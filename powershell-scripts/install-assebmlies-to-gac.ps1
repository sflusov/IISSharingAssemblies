
$asm_path = 'C:\git\IISSharingAssemblies\common-assemblies-legacy'
$gac_path = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\gacutil.exe'

#install assembly to GAC
Get-ChildItem $asm_path | ForEach-Object {
    & $gac_path "/i", $_.FullName
}

#uninstall assembly from GAC
Get-ChildItem $asm_path | ForEach-Object {
   & $gac_path "/u", ([System.Reflection.AssemblyName]::GetAssemblyName($_.FullName).FullName)
}

