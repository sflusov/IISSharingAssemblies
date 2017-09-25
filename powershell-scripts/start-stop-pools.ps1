
# Load IIS module:
Import-Module WebAdministration

#enable TLS2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#stop web appol
#Get-ChildItem IIS:\AppPools | where {$_.state -eq "Started"} | Stop-WebAppPool

#start web appol
#Get-ChildItem IIS:\AppPools | where {$_.state -eq "Stopped"} | Start-WebAppPool

function GetWebSiteStatusCode {
    param (
        [string] $testUri,
        $maximumRedirection = 5
    )
    $request = $null
    try {
        $request = Invoke-WebRequest -Uri $testUri -MaximumRedirection $maximumRedirection -ErrorAction SilentlyContinue
    } 
    catch [System.Net.WebException] {
        $request = $_.Exception.Response

    }
    catch {
        Write-Error $_.Exception
        return $null
    }
    $request.StatusCode
}


$startDate = Get-Date
foreach($site in (Get-ChildItem IIS:\Sites | where {$_.state -eq "Started"}))
{
    # Site url
    $url = $site.name
    # Get AppPool Name
    $appPoolName = $site.applicationPool
        
    $get_apppool_state = Get-WebAppPoolState $appPoolName
    # Check if exists 
    # Check if appool already started
    if ((Test-Path IIS:\AppPools\$appPoolName) -and
        ($get_apppool_state.value -eq "Stopped"))
    {
        # Start App Pool        
        Write-Output "Starting IIS app pool $appPoolName"
        Start-WebAppPool $appPoolName

        for($i = 0; $i -lt 10; $i++)
        {
            $get_apppool_state = Get-WebAppPoolState $appPoolName
            if($get_apppool_state.value -eq "Started")
            {
                break
            }

            Write-Output "Wait 2 second for start $appPoolName"
            Start-Sleep 2
        }
    }
        

    #warming site 
    foreach ($service in ("https://" + $url + "/version"))
    {
     $resultRequest = GetWebSiteStatusCode -testUri $service
     if ($resultRequest -eq "200")
     {
        Write-Host ("$(Get-Date) $service activated successfully") 
	    #exit 0
     }
     else
     {
       Write-Host ("$(Get-Date) $service has a problem")
       #exit 1
     }
 }
}

#calculate total time for warming
Write-Host "Total warming time: $((Get-Date) - $startDate)"
#calculate count of running site
Write-Host "Total site count: $((Get-ChildItem IIS:\Sites | where {$_.state -eq 'Started'}).Count)"