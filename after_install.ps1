##########
# Win10 Initial Setup Script
# Author: cesarbrunoms <bruno.cesar@outlook.it>
# Version: 0.1
##########

# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	# Enable execution script PowerShell
	Start-Process powershell.exe "-command set-ExecutionPolicy unrestricted"
	Exit
}

# Install 7-Zip
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_7zip/install_7zip.ps1 | iex

# Install Runtimes
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_runtimes/install_runtimes.ps1 | iex

# Install Firefox
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_firefox/install_firefox.ps1 | iex

# Install Google Chrome
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_google_chrome/install_google_chrome.ps1 | iex

# Install LibreOffice LTS
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_libreoffice/install_libreoffice.ps1 | iex

# Install Flameshot
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_flameshot/install_flameshot.ps1 | iex

# Install VLC
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_vlc/install_vlc.ps1 | iex

# Install TightVNC
irm https://raw.githubusercontent.com/xbrncsr/windows/main/install_tightvnc/install_tightvnc.ps1 | iex
