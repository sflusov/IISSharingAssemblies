
# Load IIS module:
Import-Module WebAdministration


foreach($site in (Get-ChildItem IIS:\Sites | where {$_.state -eq "Started"}))
{
    # Site url
    $url = $site.name

    #Remove-WebBinding -Protocol "https" -Name "$url" -IPAddress "*" -Port "443" -HostHeader "$url"
    New-WebBinding -Name "$url" -IPAddress "*" -Port 80 -HostHeader "$url"
}

