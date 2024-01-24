
# Suporte
## #️⃣ Contents
* [1 - SCRIPTs](#1---script-dti-pma)
* [1A - Enable execution script in powershell](#1a---enable-execution-script-powershell)
* [1B - Show computer name and users](#1b---show-computer-name-and-users)
* [1C - Desable Power Manage](#1c---desable-power-manage)
* [1D - creating restore point](#1d---creating-restore-point)
* [1E - Add Credential](#1e---add-credential)
* [1F - Enable Administrador user](#1f---enable-administrador-user)
* [1G - Manage user](#1g---manage-user)
* [1H - Rename Computer](#1h---rename-computer)
* [1I - CHKDSK](#1i---chkdsk)
* [1J - Defrag Windows](#1j---defrag-windows)
* [1K - SFC / DISM](#1k---sfc--dism)
* [1L - Update User Policy](#1l---update-user-policy)
* [1M - Restart print spooler service](#1m---restart-print-spooler-service)
* [1N - Refresh Interface Network](#1n---refresh-interface-network)
* [1O - Network Folder Mapping](#1o---network-folder-mapping)
* [1P - Enable Dark Theme](#1p---enable-dark-theme)
* [1Q - Turn Off Windows Activity History](#1q---turn-off-windows-activity-history)
* [1R - Disable Background apps](#1r---disable-background-apps)


&nbsp;


* [2 - Chocolatey](#2---chocolatey)
* [2A - Install Chocolatey](#2a---install-chocolatey)
* [2B - Chocolatey Management](#2b---chocolatey-management)
* [2C - Essential APPs in Chocolatey](#2c---essential-apps-in-chocolatey)
* [2D - Runtimes in Chocolatey](#2d---runtimes-in-chocolatey)
* [2E - Dev in Chocolatey](#2e---dev-in-chocolatey)


&nbsp;


* [3 - Winget](#3---winget)
* [3A - Winget Management](#3a---winget-management)
* [3B - Essential APPs in Winget](#3b---essential-apps-in-winget)
* [3C - Runtimes in Winget](#3c---runtimes-in-winget)
* [3D - Dev in Winget](#3d---dev-in-winget)
* [3E - Chat Communication in Winget](#3e---chat-communication-in-winget)


&nbsp;


## 1 - SCRIPTs
#### 1A - Enable execution script PowerShell
```shell
set-ExecutionPolicy unrestricted

```

```shell
irm https://raw.githubusercontent.com/cesarbrunoms/scripts/main/win/dti_pma.ps1 | iex  
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1B - Show computer name and users
```shell
Get-CimInstance -ClassName Win32_Desktop
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1C - Desable Power Manage
```shell
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1D - Creating restore point
* Source:
* <https://youtu.be/vi2lAsxo3Ws>

```shell
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -PropertyType DWord -Value 0

Enable-ComputerRestore -Drive "C:\"

# Cria uma nova tarefa agendada
$TaskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description \"My Restore Point Startup\" -RestorePointType \"MODIFY_SETTINGS\""'
$Trigger = New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -Action $TaskAction -Trigger $Trigger -TaskName "MyRestorePointTask" -Description "Tarefa para criar ponto de restauração ao iniciar o computador" -RunLevel Highest

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1E - Add Credential
```shell
$username = "padrao"
$password = "123456"
$cmdkeyCommand = "cmdkey /add:192.168.0.34 /user:$username /pass:$password"
Invoke-Expression -Command $cmdkeyCommand

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1F - Enable Administrador user
```shell
Enable-LocalUser -Name "Administrador"
Set-LocalUser -Name "Administrador" -Password (ConvertTo-SecureString -String "absemsau*" -AsPlainText -Force)

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1G - Manage user
```shell
# Removing user "user" from admin group and making it default user
net localgroup administrators user /delete
net localgroup users user /add

# Setting the password for the user "user" to not expire and preventing the user from being able to change the password
wmic useraccount where "name='user'" set passwordexpires=false
net user user /passwordchg:no

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1H - Rename Computer
```shell
Write-Host "Rename Computer"
$RENAME = Read-Host "escreva nome do computador"
Rename-Computer -NewName $RENAME
-Restart  

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1I - CHKDSK
```shell
chkdsk c: /r

```

##### or
```shell
Repair-Volume C -OfflineScanAndFix

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1J - Defrag Windows
* Running DEFRAG HD
```shell
defrag C: /v

```

##### or
```shell
Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose

```

* Running DEFRAG SSD
```shell
Optimize-Volume -DriveLetter C -ReTrim -Verbose  
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1K - SFC / DISM
```shell
sfc /scannow

```

```shell
DISM /Online /Cleanup-image /Restorehealth  

```

##### or
```shell
Repair-WindowsImage -Online -StartComponentCleanup -RestoreHealth

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1L - Update User Policy
```shell
gpupdate /force

```
##### or
```shell
Invoke-Expression -Command "gpupdate /force"

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1M - Restart print spooler service
```shell
# Stop print spooler service
Stop-Service -Name Spooler -Force

# To delete the files
Remove-Item -Path "$env:SystemRoot\System32\spool\PRINTERS\*.*"

# Start print spooler service
Start-Service -Name Spooler

# Restart print spooler service
Restart-Service -Name Spooler -Force  
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1N - Refresh Interface Network
```shell
#flushdns
ipconfig /flushdns

#release
ipconfig /release

#renew
ipconfig /renew

# Desable Wi-Fi... 
NETSH interface set interface name=Wi-Fi admin=DISABLE 
 
# Enable Wi-Fi... 
NETSH interface set interface name=Wi-Fi admin=ENABLE 
 
# Desable Ethernet... 
NETSH interface set interface name=Ethernet admin=DISABLE 
 
# Enable Ethernet... 
NETSH interface set interface name=Ethernet admin=ENABLE  

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1O - Network Folder Mapping
```shell
#\\srv-storage-01\semsau
net use \\srv-storage-01\semsau$ /PERSISTENT:YES
#New-PSDrive –Name “V” –PSProvider FileSystem –Root “\\srv-storage-01\semsau$ ” –Persist  

```

```shell
#\\srv-storage-01\semsau-fms$
net use \\srv-storage-01\semsau-fms$ /PERSISTENT:YES

```

```shell
#\\srv-storage-01\semsau-pad$
net use \\srv-storage-01\semsau-pad$ /PERSISTENT:YES

```

```shell
#\\srv-storage-01\semsau-atencao-basica$
net use \\srv-storage-01\semsau-atencao-basica$ /PERSISTENT:YES

```

```shell
#\\srv-storage-01\semsau-visa$
net use \\srv-storage-01\semsau-visa$ /PERSISTENT:YES

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1P - Enable Dark Theme
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1Q - Turn Off Windows Activity History
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_TrackDocs /t REG_DWORD /d 0 /f
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 1R - Disable Background apps
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f
  
```
 [⬆️](#️⃣-contents)


&nbsp;
&nbsp;


## 2 - Chocolatey
#### 2A - Install Chocolatey
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  
```
* Source:
* <https://community.chocolatey.org/>
* <https://chocolatey.org/install>
* <https://youtu.be/SaXqT1fm6Js>

 [⬆️](#️⃣-contents)

&nbsp;

#### 2B - Chocolatey Management
```shell
choco install -y vlc
choco upgrade -y vlc
choco upgrade all -y
choco uninstall vlc
choco search
choco list

choco install typora --version 0.9.75 -y
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 2C - Essential APPs in Chocolatey
```shell
choco install -y 7zip
choco install -y googlechrome
choco install -y vlc
choco install -y libreoffice-still
choco install -y rustdesk
  
```

```shell
choco install -y adobereader
choco install -y firefox
choco install -y ffmpeg
choco install -y lightshot
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 2D - Runtimes in Chocolatey
```shell
choco install -y jre8
choco install -y dotnetfx
choco install -y dotnet-5.0-runtime
choco install -y dotnet-6.0-runtime
choco install -y dotnet-7.0-runtime
choco install -y vcredist-all
# ou
choco install -y vcredist2005
choco install -y vcredist2008
choco install -y vcredist2010
choco install -y vcredist2012
choco install -y vcredist2013
choco install -y vcredist140
  
```
 [⬆️](#️⃣-contents)

&nbsp;

#### 2E - Dev in Chocolatey
```shell
choco install -y git
choco install -y vscode
choco install -y dart-sdk
choco install -y flutter
choco install -y androidstudio
choco install -y php

```
 [⬆️](#️⃣-contents)


&nbsp;
&nbsp;


## 3 - Winget
#### 3A - Winget Management
```shell
winget install
winget uninstall
winget search
winget list
winget upgrade
winget upgrade --all
  
```

```shell
winget source reset --force
winget source update
winget upgrade --all --accept-source-agreements
  
```
* Source:
* <https://winstall.app>
* <https://winget.run>
* <https://youtu.be/OYF0hWHAicc>

 [⬆️](#️⃣-contents)

#### 3B - Essential APPs in Winget
```shell
winget install --id=Microsoft.PowerShell -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.WindowsTerminal -e --accept-package-agreements --accept-source-agreements ;
winget install --id=7zip.7zip -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Mozilla.Firefox -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Foxit.FoxitReader -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Google.Chrome -e --accept-package-agreements --accept-source-agreements ;
winget install --id=TheDocumentFoundation.LibreOffice.LTS -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Skillbrains.Lightshot -e --accept-package-agreements --accept-source-agreements ;
winget install --id=RustDesk.RustDesk -e --accept-package-agreements --accept-source-agreements ;
winget install --id=VideoLAN.VLC -e --accept-package-agreements --accept-source-agreements ;
  
```

```shell
winget install --id=Adobe.Acrobat.Reader.64-bit -e --accept-package-agreements --accept-source-agreements ;
winget install --id=AnyDeskSoftwareGmbH.AnyDesk -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ByteDance.CapCut -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Dropbox.Dropbox -e --accept-package-agreements --accept-source-agreements ;
winget install --id=GlavSoft.TightVNC -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.PowerToys -e --accept-package-agreements --accept-source-agreements ;
winget install --id=MiniTool.PartitionWizard.Free -e --accept-package-agreements --accept-source-agreements ;
winget install --id=OBSProject.OBSStudio -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Oracle.VirtualBox -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Flameshot.Flameshot -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ShareX.ShareX -e --accept-package-agreements --accept-source-agreements ;
winget install --id=RealVNC.VNCViewer -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Rufus.Rufus -e --accept-package-agreements --accept-source-agreements ;
winget install --id=TeamViewer.TeamViewer -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Transmission.Transmission -e --accept-package-agreements --accept-source-agreements ;
winget install --id=uGetdm.uGet -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Valve.Steam -e --accept-package-agreements --accept-source-agreements ;
winget install --id=WinSCP.WinSCP -e --accept-package-agreements --accept-source-agreements ;

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 3C - Runtimes in Winget
```shell
winget install --id=Microsoft.DotNet.Framework.DeveloperPack_4 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.DotNet.Runtime.5 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.DotNet.Runtime.6 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.DotNet.Runtime.7 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2005.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2008.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2010.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2012.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2013.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VCRedist.2015+.x64 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Oracle.JavaRuntimeEnvironment -e --accept-package-agreements --accept-source-agreements ;

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 3D - Dev in Winget
```shell
winget install --id=Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VisualStudio.2022.Community -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Git.Git -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Google.AndroidStudio -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.8.1 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.7.4 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Notepad++.Notepad++ -e --accept-package-agreements --accept-source-agreements ;

```
 [⬆️](#️⃣-contents)

&nbsp;

#### 3E - Chat Communication in Winget
```shell
winget install --id=Discord.Discord -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Telegram.TelegramDesktop -e --accept-package-agreements --accept-source-agreements ;
winget install --id=BeeBEEP.BeeBEEP -e --accept-package-agreements --accept-source-agreements ;

```
 [⬆️](#️⃣-contents)

