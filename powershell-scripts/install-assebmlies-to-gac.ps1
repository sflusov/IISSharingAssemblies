$asm_path = 'C:\git\IISSharingAssemblies\common-assemblies-legacy'

#Windows 10
#$gac_path = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\gacutil.exe'
#Windows Server
$gac_path = "C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.7 Tools\gacutil.exe"

#install assembly to GAC
Get-ChildItem $asm_path | ForEach-Object {
    Write-Host "Try to install assembly $_"
    & $gac_path "/i", $_.FullName
}

#uninstall assembly from GAC
#Get-ChildItem $asm_path | ForEach-Object {
#   & $gac_path "/u", ([System.Reflection.AssemblyName]::GetAssemblyName($_.FullName).FullName)
#}

