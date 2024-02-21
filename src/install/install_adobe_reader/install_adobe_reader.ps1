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


# Install Adobe Acrobat Reader DC (64-bit)
Write-Host "=====================> [ Install Firefox...! ]"
winget install --id=Adobe.Acrobat.Reader.64-bit -e --accept-package-agreements --accept-source-agreements ;
