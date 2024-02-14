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


# Enable Admin User
Write-Host "=====================> [ Enable Admin User...! ]"
Enable-LocalUser -Name "Administrador"
Set-LocalUser -Name "Administrador" -Password (ConvertTo-SecureString -String "absemsau*" -AsPlainText -Force)
