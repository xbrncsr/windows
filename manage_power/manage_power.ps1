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


# Manage Power
Write-Host "=====================> [ Manage Power...! ]"
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
