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


# Install Flameshot
Write-Host "=====================> [ Install Flameshot...! ]"
winget install --id=Flameshot.Flameshot -e --accept-package-agreements --accept-source-agreements ;
