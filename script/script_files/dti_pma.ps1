##########
# Win10 Initial Setup Script
# Author: cesarbrunoms <bruno.cesar@outlook.it>
# Version: 5.0.2, 2023-01-28
##########

# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	# Enable execution script PowerShell
	Start-Process powershell.exe "-command set-ExecutionPolicy unrestricted"
	Exit
}


function DisplayMenu {
	Clear-Host
	(Get-Date).ToString("dd/MM/yyyy")
	Write-Host @"
Computador: $env:computername
Usuario: $env:username
+------------------------------------------------------------------------------------------------------------+
|   0.  U P D A T E   A L L              |       I M A G E M        |       U T I L I T A R I O S            |
|                                        |   4A. GIMP               |   7A. AnyDesk                          |
|                                        |   4B. Lightshot          |   7B. qBittorrent                      |
|       C O M P A C T A C A O            |   4C. ShareX             |   7C. Rufus                            |
|   1A. 7-Zip                            |                          |   7D. RustDesk                         |
|   1B. WinRAR                           |                          |   7E. Transmission                     |
|                                        |       M I D I A          |   7F. VNCViewer                        |
|                                        |   5A. HandBrake          |                                        |
|       D E V                            |   5B. K-Lite Codec       |                                        |
|   2A. Android Studio                   |   5C. VLC                |       C O N F I G U R A C O E S        |
|   2B. EclipseAdoptium.Temurin.8.JDK    |                          |    8. Add Credencial Publica           |
|   2C. EclipseAdoptium.Temurin.11.JDK   |                          |    9. Habilitar User Administrador     |
|   2D. EclipseAdoptium.Temurin.17.JDK   |       R U N T I M E S    |   10. Renomear Computador -> Restart   |
|   2E. Git                              |   6A. DotNet Runtime 4   |   11. CHKDSK -> Restart                |
|   2F. Notepad++                        |   6B. DotNet Runtime 5   |   12. SFC and DISM                     |
|   2G. VSCode                           |   6C. DotNet Runtime 6   |   13. Atualizar Politica Usuario       |
|   2H. Visual Studio Community          |   6D. DotNet Runtime 7   |   14. Refresh Interfaces Rede          |
|                                        |   6E. VCRdist 2005       |   15. MODO PMA                         |
|                                        |   6F. VCRdist 2008       |   16. MODO BRNCZZR                     |
|       D O C U M E N T O S              |   6G. VCRdist 2010       |                                        |
|   3A. Adobe Acrobat Reader             |   6H. VCRdist 2012       |                                        |
|   3B. Foxit Reader                     |   6I. VCRdist 2013       |                                        |
|   3C. LibreOffice LTS                  |   6J. VCRdist 2015+      |                                        |
|                                        |   6K. Java 8 JRE         |                                        |
+------------------------------------------------------------------------------------------------------------+
"@

	function update_allwinget {
		winget upgrade --all --accept-source-agreements
	}

	function installApp ($idApp) {		
		# Verificar se o $idApp está presente na lista de pacotes
		$result = winget list | Select-String $idApp

		# Se o $idApp não estiver presente na lista, instalá-lo
		if (-not $result) {
			winget install --id=$idApp -e --accept-package-agreements --accept-source-agreements ;
			Write-Host ""
		}
		else {
			Write-Host "$idApp ja esta instalado!"
		}
		
	}

	function addCredencialPublica () {
		cmdkey /add:192.168.0.34 /user:padrao /pass:123456
	}

	function enableAdminUser () {
		#net user administrador /active:yes
		Enable-LocalUser -Name administrator
	}

	function renameComputer () {
		Write-Host "Rename Computer"
		$RENAME = Read-Host "escreva nome do computador"
		Rename-Computer -NewName $RENAME
		Restart-Computer
	}

	function chkdsk () {
		chkdsk c: /r
		#Repair-Volume C -OfflineScanAndFix
		Restart-Computer
	}

	function sfcDISM () {
		sfc /scannow
		#Invoke-Expression -Command "sfc /scannow"


		DISM /Online /Cleanup-image /Restorehealth
		#Repair-WindowsImage -Online -StartComponentCleanup -RestoreHealth
	}

	function updateUserPolicy () {
		Invoke-Expression -Command "gpupdate /force"
	}

	function refreshNetwork () {
		#ipconfig /flushdns
		Clear-DnsClientCache

		#ipconfig /release
		Remove-NetIPAddress -InterfaceAlias "Ethernet" -AddressFamily IPv4 -Confirm:$false
		Remove-NetIPAddress -InterfaceAlias "Wi-Fi" -AddressFamily IPv4 -Confirm:$false		

		#ipconfig /renew
		Restart-NetAdapter -Name "Ethernet"	
		Restart-NetAdapter -Name "Wi-Fi"			
		
		#Desabilitar todos os adaptadores de rede
		#Disable-NetAdapter -Name "Ethernet"
		#Disable-NetAdapter -Name "Wi-Fi"		

		#Habilitar todos os adaptadores de rede
		#Enable-NetAdapter -Name "Ethernet"
		#Enable-NetAdapter -Name "Wi-Fi"		
	}

	

	$MENU = Read-Host "OPTION"
	Write-Host ""
	Write-Host ""
	$MENU = $MENU -split ","
	foreach ($MENU in $MENU) {
		Switch ($MENU.Trim()) {
			default {
				# -================> DEFAULT OPTION
				Write-Host "Option not available"
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"Q" {
				#OPTION - EXIT
				Break
			}
			"0" {
				# -================> OPTION - 0.  U P D A T E   A L L
				update_allwinget
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"1A" {
				# -================> OPTION - 1A. 7-Zip
				installApp "7zip.7zip"
				Start-Sleep -Seconds 4				
			}
			"1B" {
				# -================> OPTION - 1B. WinRAR
				installApp "RARLab.WinRAR"
				Start-Sleep -Seconds 4				
			}
			"2A" {
				# -================> OPTION - 2A. Android Studio
				installApp "Google.AndroidStudio"
				Start-Sleep -Seconds 4				
			}
			"2B" {
				# -================> OPTION - 2B. EclipseAdoptium.Temurin.8.JDK
				installApp "EclipseAdoptium.Temurin.8.JDK"
				Start-Sleep -Seconds 4				
			}
			"2C" {
				# -================> OPTION - 2C. EclipseAdoptium.Temurin.11.JDK
				installApp "EclipseAdoptium.Temurin.11.JDK"
				Start-Sleep -Seconds 4				
			}
			"2D" {
				# -================> OPTION - 2D. EclipseAdoptium.Temurin.17.JDK
				installApp "EclipseAdoptium.Temurin.17.JDK"
				Start-Sleep -Seconds 4				
			}
			"2E" {
				# -================> OPTION - 2E. Git
				installApp "Git.Git"
				Start-Sleep -Seconds 4				
			}
			"2F" {
				# -================> OPTION - 2F. Notepad++
				installApp "Notepad++.Notepad++"
				Start-Sleep -Seconds 4				
			}
			"2G" {
				# -================> OPTION - 2G. VSCode
				installApp "Microsoft.VisualStudioCode"
				Start-Sleep -Seconds 4				
			}
			"2H" {
				# -================> OPTION - 2H. Visual Studio Community
				installApp "Microsoft.VisualStudio.2022.Community"
				Start-Sleep -Seconds 4				
			}
			"3A" {
				# -================> OPTION - 3A. Adobe Acrobat Reader
				installApp "Adobe.Acrobat.Reader.64-bit"
				Start-Sleep -Seconds 4				
			}
			"3B" {
				# -================> OPTION - 3B. Foxit Reader
				installApp "Foxit.FoxitReader"
				Start-Sleep -Seconds 4				
			}
			"3C" {
				# -================> OPTION - 3C. LibreOffice LTS
				installApp "TheDocumentFoundation.LibreOffice.LTS"
				Start-Sleep -Seconds 4				
			}
			"4A" {
				# -================> OPTION - 4A. GIMP
				installApp "GIMP.GIMP"
				Start-Sleep -Seconds 4				
			}
			"4B" {
				# -================> OPTION - 4B. Lightshot
				installApp "Skillbrains.Lightshot"
				Start-Sleep -Seconds 4				
			}
			"4C" {
				# -================> OPTION - 4C. ShareX
				installApp "ShareX.ShareX"
				Start-Sleep -Seconds 4				
			}
			"5A" {
				# -================> OPTION - 5A. HandBrake
				installApp "HandBrake.HandBrake"
				Start-Sleep -Seconds 4				
			}
			"5B" {
				# -================> OPTION - 5B. K-Lite Codec
				installApp "CodecGuide.K-LiteCodecPack.Full"
				Start-Sleep -Seconds 4				
			}
			"5C" {
				# -================> OPTION - 5C. VLC
				installApp "VideoLAN.VLC"
				Start-Sleep -Seconds 4				
			}
			"6A" {
				# -================> OPTION - 6A. DotNet Runtime 4
				installApp "Microsoft.DotNet.Framework.DeveloperPack_4"
				Start-Sleep -Seconds 4				
			}
			"6B" {
				# -================> OPTION - 6B. DotNet Runtime 5
				installApp "Microsoft.DotNet.Runtime.5"
				Start-Sleep -Seconds 4				
			}
			"6C" {
				# -================> OPTION - 6C. DotNet Runtime 6
				installApp "Microsoft.DotNet.Runtime.6"
				Start-Sleep -Seconds 4				
			}
			"6D" {
				# -================> OPTION - 6D. DotNet Runtime 7
				installApp "Microsoft.DotNet.Runtime.7"
				Start-Sleep -Seconds 4				
			}
			"6E" {
				# -================> OPTION - 6E. VCRdist 2005
				installApp "Microsoft.VCRedist.2005.x64"
				Start-Sleep -Seconds 4				
			}
			"6F" {
				# -================> OPTION - 6F. VCRdist 2008
				installApp "Microsoft.VCRedist.2008.x64"
				Start-Sleep -Seconds 4				
			}
			"6G" {
				# -================> OPTION - 6G. VCRdist 2010
				installApp "Microsoft.VCRedist.2010.x64"
				Start-Sleep -Seconds 4				
			}
			"6H" {
				# -================> OPTION - 6H. VCRdist 2012
				installApp "Microsoft.VCRedist.2012.x64"
				Start-Sleep -Seconds 4				
			}
			"6I" {
				# -================> OPTION - 6I. VCRdist 2013
				installApp "Microsoft.VCRedist.2013.x64"
				Start-Sleep -Seconds 4				
			}
			"6J" {
				# -================> OPTION - 6J. VCRdist 2015+
				installApp "Microsoft.VCRedist.2015+.x64"
				Start-Sleep -Seconds 4				
			}
			"6K" {
				# -================> OPTION - 6K. Java 8 JRE
				installApp "Oracle.JavaRuntimeEnvironment"
				Start-Sleep -Seconds 4				
			}
			"7A" {
				# -================> OPTION - 7A. AnyDesk
				installApp "AnyDeskSoftwareGmbH.AnyDesk"
				Start-Sleep -Seconds 4				
			}
			"7B" {
				# -================> OPTION - 7B. qBittorrent
				installApp "qBittorrent.qBittorrent"
				Start-Sleep -Seconds 4				
			}
			"7C" {
				# -================> OPTION - 7C. Rufus
				installApp "Rufus.Rufus"
				Start-Sleep -Seconds 4				
			}
			"7D" {
				# -================> OPTION - 7D. RustDesk
				installApp "RustDesk.RustDesk"
				Start-Sleep -Seconds 4				
			}
			"7E" {
				# -================> OPTION - 7E. Transmission
				installApp "Transmission.Transmission"
				Start-Sleep -Seconds 4				
			}
			"7F" {
				# -================> OPTION - 7F. VNCViewer
				installApp "RealVNC.VNCViewer"
				Start-Sleep -Seconds 4				
			}
			"8" {
				# -================> OPTION - 8. Add Credencial Publica
				addCredencialPublica
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"9" {
				# -================> OPTION - 9. Habilitar User Administrador
				enableAdminUser
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"10" {
				# -================> OPTION - 10. Renomear Computador -> Restart
				renameComputer
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"11" {
				# -================> OPTION - 11. CHKDSK -> Restart
				chkdsk
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"12" {
				# -================> OPTION - 12. SFC and DISM
				sfcDISM
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"13" {
				# -================> OPTION - 13. Atualizar Politica Usuario
				updateUserPolicy
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"14" {
				# -================> OPTION - 14. Refresh Interfaces Rede
				refreshNetwork
				Start-Sleep -Seconds 4
				DisplayMenu
			}
			"15" {
				# -================> OPTION - 15. MODO PMA
				installApp "7zip.7zip"
				Write-Host ""
				installApp "Mozilla.Firefox"
				Write-Host ""
				installApp "Foxit.FoxitReader"
				Write-Host ""
				installApp "Google.Chrome"
				Write-Host ""
				installApp "TheDocumentFoundation.LibreOffice.LTS"
				Write-Host ""
				installApp "Skillbrains.Lightshot"
				Write-Host ""
				installApp "RustDesk.RustDesk"
				Write-Host ""
				installApp "VideoLAN.VLC"
				Write-Host ""
				installApp "Microsoft.DotNet.Framework.DeveloperPack_4"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.5"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.6"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.7"
				Write-Host ""
				installApp "Microsoft.VCRedist.2005.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2008.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2010.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2012.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2013.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2015+.x64"
				Write-Host ""
				installApp "Oracle.JavaRuntimeEnvironment"
				Write-Host ""
				addCredencialPublica
				Write-Host ""
				enableAdminUser
				Write-Host ""
				renameComputer
				Start-Sleep -Seconds 4
				DisplayMenu
			}			
			"16" {
				# -================> OPTION - 16. MODO BRNCZZR
				installApp "7zip.7zip"
				Write-Host ""
				installApp "Google.Chrome"
				Write-Host ""
				installApp "TheDocumentFoundation.LibreOffice.LTS"
				Write-Host ""
				installApp "RustDesk.RustDesk"
				Write-Host ""
				installApp "VideoLAN.VLC"
				Write-Host ""
				installApp "Microsoft.DotNet.Framework.DeveloperPack_4"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.5"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.6"
				Write-Host ""
				installApp "Microsoft.DotNet.Runtime.7"
				Write-Host ""
				installApp "Microsoft.VCRedist.2005.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2008.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2010.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2012.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2013.x64"
				Write-Host ""
				installApp "Microsoft.VCRedist.2015+.x64"
				Write-Host ""
				installApp "ApacheFriends.Xampp.8.1"
				Write-Host ""
				installApp "EclipseAdoptium.Temurin.17.JDK"
				Write-Host ""
				installApp "Git.Git"
				Write-Host ""
				installApp "Notepad++.Notepad++"
				Write-Host ""
				installApp "Microsoft.VisualStudioCode"
				Start-Sleep -Seconds 4
				DisplayMenu
			}			
		}
	}DisplayMenu
}DisplayMenu
