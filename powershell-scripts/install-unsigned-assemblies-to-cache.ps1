$asm_path = 'C:\ASPNETCommonAssemblies'
$ngn_path = 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe'

#install native images from cache
Get-ChildItem -recurse $asm_path | where {$_.extension -eq ".dll"} | ForEach-Object {
   Write-Host "Try to install assemblies by path $_"
   & $ngn_path "install", $_.FullName
}

#uninstall native images from cache
#Get-ChildItem -recurse $asm_path | where {$_.extension -eq ".dll"} | ForEach-Object {
#   Write-Host "Try to install assemblies by path $_"
#   & $ngn_path "uninstall", $_.FullName
#}
