#Windows 10 path
#$intern_path = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.6 Tools\aspnet_intern.exe'
#Windows Server
$intern_path = 'C:\Program Files (x86)\Microsoft SDKs\Windows\v10.0A\bin\NETFX 4.7 Tools\aspnet_intern.exe'

$intern_param = '-mode', 'exec', 
                '-sourcedir', 'C:\Windows\Microsoft.NET\Framework64\v4.0.30319\Temporary ASP.NET Files',
                '-interndir', 'C:\ASPNETCommonAssemblies'

& $intern_path $intern_param