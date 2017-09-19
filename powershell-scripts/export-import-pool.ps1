#source http://www.microsoftpro.nl/2011/01/27/exporting-and-importing-sites-and-app-pools-from-iis-7-and-7-5/


#clean all sites
cmd.exe /c "%windir%\system32\inetsrv\appcmd.exe list site /xml | %windir%\system32\inetsrv\appcmd delete site /in"
#cleam all pools
cmd.exe /c "%windir%\system32\inetsrv\appcmd.exe list apppool /xml | %windir%\system32\inetsrv\appcmd delete apppool /in"

#To Export the Application Pools on IIS 7 :
#cmd.exe /c "%windir%\system32\inetsrv\appcmd list apppool /config /xml > c:\apppools.xml"
#To Export all you’re website:
#cmd.exe /c "%windir%\system32\inetsrv\appcmd list site /config /xml > c:\sites.xml"


#To import the Application Pools:
cmd.exe /c "%windir%\system32\inetsrv\appcmd add apppool /in < c:\apppools.xml"
#To Import the website:
cmd.exe /c "%windir%\system32\inetsrv\appcmd add site /in < c:\sites.xml"