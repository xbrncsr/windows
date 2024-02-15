##########
# Win10
##########


# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	# Enable execution script PowerShell
	Start-Process powershell.exe "-command set-ExecutionPolicy unrestricted"
	Exit
}


# Install Runtimes
Write-Host "=====================> [ Install Microsoft.DotNet.Runtime.4...! ]"
winget install --id=Microsoft.DotNet.Framework.DeveloperPack_4 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.DotNet.Runtime.5...! ]"
winget install --id=Microsoft.DotNet.Runtime.5 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.DotNet.Runtime.6...! ]"
winget install --id=Microsoft.DotNet.Runtime.6 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.DotNet.Runtime.7...! ]"
winget install --id=Microsoft.DotNet.Runtime.7 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2005.x64...! ]"
winget install --id=Microsoft.VCRedist.2005.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2008.x64...! ]"
winget install --id=Microsoft.VCRedist.2008.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2010.x64...! ]"
winget install --id=Microsoft.VCRedist.2010.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2012.x64...! ]"
winget install --id=Microsoft.VCRedist.2012.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2013.x64...! ]"
winget install --id=Microsoft.VCRedist.2013.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Microsoft.VCRedist.2015.x64...! ]"
winget install --id=Microsoft.VCRedist.2015+.x64 -e --accept-package-agreements --accept-source-agreements ;

Write-Host "=====================> [ Install Java 8...! ]"
winget install --id=Oracle.JavaRuntimeEnvironment -e --accept-package-agreements --accept-source-agreements ;
