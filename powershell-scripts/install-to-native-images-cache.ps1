$asm_path = 'C:\git\IISSharingAssemblies\common-assemblies-legacy'
$ngn_path = 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\ngen.exe'

#install native images from cache
Get-ChildItem -Recurse $asm_path  | where {$_.extension -eq ".dll"} | ForEach-Object {
   & $ngn_path "install", ([System.Reflection.AssemblyName]::GetAssemblyName($_.FullName).FullName)
}


#uninstall native images from cache
#Get-ChildItem $asm_path  | where {$_.extension -eq ".dll"} | ForEach-Object {
#   & $ngn_path "uninstall", ([System.Reflection.AssemblyName]::GetAssemblyName($_.FullName).FullName)
#}

