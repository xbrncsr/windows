
# Suporte

* [1 - SCRIPTs](#1---script-dti-pma)
* [Enable execution script in powershell](#enable-execution-script-powershell)
* [Show computer name and users](#show-computer-name-and-users)
* [Desable Power Manage](#desable-power-manage)
* [creating restore point](#creating-restore-point)
* [Add Credential](#add-credential)
* [Enable Administrador user](#enable-administrador-user)
* [Manage user](#manage-user)
* [Rename Computer](#rename-computer)
* [CHKDSK](#chkdsk)
* [Defrag Windows](#defrag-windows)
* [SFC / DISM](#sfc--dism)
* [Update User Policy](#update-user-policy)
* [Restart print spooler service](#restart-print-spooler-service)
* [Refresh Interface Network](#refresh-interface-network)
* [Network Folder Mapping](#network-folder-mapping)
* [Enable Dark Theme](#enable-dark-theme)
* [Turn Off Windows Activity History](#turn-off-windows-activity-history)
* [Disable Background apps](#disable-background-apps)


&nbsp;


* [2 - Chocolatey](#2---chocolatey)
* [Install Chocolatey](#install-chocolatey)
* [Chocolatey Management](#chocolatey-management)
* [Essential APPs in Chocolatey](#essential-apps-in-chocolatey)
* [Runtimes in Chocolatey](#runtimes-in-chocolatey)
* [Dev in Chocolatey](#dev-in-chocolatey)


&nbsp;


* [3 - Winget](#3---winget)
* [Winget Management](#winget-management)
* [Essential APPs in Winget](#essential-apps-in-winget)
* [Runtimes in Winget](#runtimes-in-winget)
* [Dev in Winget](#dev-in-winget)
* [Chat Communication in Winget](#chat-communication-in-winget)


&nbsp;


## 1 - SCRIPTs
#### Enable execution script PowerShell 
```shell
set-ExecutionPolicy unrestricted

```

```shell
irm https://raw.githubusercontent.com/cesarbrunoms/scripts/main/win/dti_pma.ps1 | iex  
  
```

#### Show computer name and users
```shell
Get-CimInstance -ClassName Win32_Desktop
  
```

#### Desable Power Manage 
```shell
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0

```

#### Creating restore point
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


#### Add Credential 
```shell
$username = "padrao"
$password = "123456"
$cmdkeyCommand = "cmdkey /add:192.168.0.34 /user:$username /pass:$password"
Invoke-Expression -Command $cmdkeyCommand

```

#### Enable Administrador user
```shell
Enable-LocalUser -Name "Administrador"
Set-LocalUser -Name "Administrador" -Password (ConvertTo-SecureString -String "absemsau*" -AsPlainText -Force)

```

#### Manage user
```shell
# Removing user "user" from admin group and making it default user
net localgroup administrators user /delete
net localgroup users user /add

# Setting the password for the user "user" to not expire and preventing the user from being able to change the password
wmic useraccount where "name='user'" set passwordexpires=false
net user user /passwordchg:no

```

#### Rename Computer
```shell
Write-Host "Rename Computer"
$RENAME = Read-Host "escreva nome do computador"
Rename-Computer -NewName $RENAME
-Restart  

```

#### CHKDSK
```shell
chkdsk c: /r

```

##### ou
```shell
Repair-Volume C -OfflineScanAndFix

```

#### Defrag Windows
* Running DEFRAG HD
```shell
defrag C: /v

```

##### ou
```shell
Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose

```

* Running DEFRAG SSD
```shell
Optimize-Volume -DriveLetter C -ReTrim -Verbose  
  
```

#### SFC / DISM
```shell
sfc /scannow

```

```shell
DISM /Online /Cleanup-image /Restorehealth  

```

##### ou
```shell
Repair-WindowsImage -Online -StartComponentCleanup -RestoreHealth

```

#### Update User Policy
```shell
gpupdate /force

```
##### ou
```shell
Invoke-Expression -Command "gpupdate /force"

```

#### Restart print spooler service
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

#### Refresh Interface Network
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

#### Network Folder Mapping
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

#### Enable Dark Theme
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
  
```

#### Turn Off Windows Activity History
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_TrackDocs /t REG_DWORD /d 0 /f
  
```

#### Disable Background apps
```shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f
  
```


&nbsp;
&nbsp;


## 2 - Chocolatey
#### Install Chocolatey
```shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  
```
* Source:
* <https://community.chocolatey.org/>
* <https://chocolatey.org/install>
* <https://youtu.be/SaXqT1fm6Js>

#### Chocolatey Management
```shell
choco install -y vlc
choco upgrade -y vlc
choco upgrade all -y
choco uninstall vlc
choco search
choco list

choco install typora --version 0.9.75 -y
  
```

#### Essential APPs in Chocolatey
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

#### Runtimes in Chocolatey
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

#### Dev in Chocolatey
```shell
choco install -y git
choco install -y vscode
choco install -y dart-sdk
choco install -y flutter
choco install -y androidstudio
choco install -y php

```


&nbsp;
&nbsp;


## 3 - Winget
#### Winget Management
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

#### Essential APPs in Winget
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

#### Runtimes in Winget
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

#### Dev in Winget
```shell
winget install --id=Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VisualStudio.2022.Community -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Git.Git -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Google.AndroidStudio -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.8.1 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.7.4 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Notepad++.Notepad++ -e --accept-package-agreements --accept-source-agreements ;

```

#### Chat Communication in Winget
```shell
winget install --id=Discord.Discord -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Telegram.TelegramDesktop -e --accept-package-agreements --accept-source-agreements ;
winget install --id=BeeBEEP.BeeBEEP -e --accept-package-agreements --accept-source-agreements ;

```

