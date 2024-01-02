----------------------------------------------------------------------
<h1>Suporte</h1>
Source: <a href="https://drive.google.com/drive/folders/1QjqTl54HSL6prjwktyvCKqzsRAjF1QN5?usp=sharing" target="_blank">Google Drive</a><br>
<br>
  
<details><summary>Script DTI PMA</summary>
 
 ~~~shell
irm https://raw.githubusercontent.com/cesarbrunoms/scripts/main/win/dti_pma.ps1 | iex  
  
~~~  
</details>

  
<details><summary>Enable execution script PowerShell</summary>
 
 ~~~shell
set-ExecutionPolicy unrestricted

~~~  
</details>


<details><summary>Show computer name and users</summary>
 
 ~~~shell
Get-CimInstance -ClassName Win32_Desktop
  
~~~  
</details>


<details><summary>Desable Power Manage</summary>
 
```shell
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_VIDEO VIDEOIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP STANDBYIDLE 0
powercfg.exe /SETACVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0
powercfg.exe /SETDCVALUEINDEX SCHEME_CURRENT SUB_SLEEP HIBERNATEIDLE 0

```

</details>

<details><summary>Criando ponto restauração</summary>
  
 source: https://youtu.be/vi2lAsxo3Ws
 
~~~shell
New-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SystemRestore" -Name "SystemRestorePointCreationFrequency" -PropertyType DWord -Value 0

Enable-ComputerRestore -Drive "C:\"

# Cria uma nova tarefa agendada
$TaskAction = New-ScheduledTaskAction -Execute 'powershell.exe' -Argument '-ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description \"My Restore Point Startup\" -RestorePointType \"MODIFY_SETTINGS\""'
$Trigger = New-ScheduledTaskTrigger -AtStartup

Register-ScheduledTask -Action $TaskAction -Trigger $Trigger -TaskName "MyRestorePointTask" -Description "Tarefa para criar ponto de restauração ao iniciar o computador" -RunLevel Highest

~~~

</details>


<details><summary>Backup files</summary> 
 
~~~shell
$backupPath = "C:\backup"  # Caminho para a pasta de backup
$desktopPath = [Environment]::GetFolderPath("Desktop")  # Caminho para a pasta Área de Trabalho
$documentsPath = [Environment]::GetFolderPath("MyDocuments")  # Caminho para a pasta Documentos
$downloadsPath = [Environment]::GetFolderPath("Downloads")  # Caminho para a pasta Downloads

# Cria a pasta de backup, se não existir
if (-not (Test-Path -Path $backupPath)) {
    New-Item -ItemType Directory -Path $backupPath | Out-Null
}

# Copia a pasta Área de Trabalho para o diretório de backup
Copy-Item -Path $desktopPath -Destination $backupPath -Recurse -Force

# Copia a pasta Documentos para o diretório de backup
Copy-Item -Path $documentsPath -Destination $backupPath -Recurse -Force

# Copia a pasta Downloads para o diretório de backup
Copy-Item -Path $downloadsPath -Destination $backupPath -Recurse -Force

Write-Host "Backup concluído com sucesso!"

~~~

</details>


<details><summary>Add Credential</summary>
 
 ~~~shell
$username = "padrao"
$password = "123456"
$cmdkeyCommand = "cmdkey /add:192.168.0.34 /user:$username /pass:$password"
Invoke-Expression -Command $cmdkeyCommand

~~~

</details>


<details><summary>Enable Administrador user</summary>

~~~shell
Enable-LocalUser -Name "Administrador"
Set-LocalUser -Name "Administrador" -Password (ConvertTo-SecureString -String "absemsau*" -AsPlainText -Force)

~~~

</details>


<details><summary>Manage user</summary>

~~~shell
# Removing user "user" from admin group and making it default user
net localgroup administrators user /delete
net localgroup users user /add

# Setting the password for the user "user" to not expire and preventing the user from being able to change the password
wmic useraccount where "name='user'" set passwordexpires=false
net user user /passwordchg:no
~~~
</details>


<details><summary>Rename Computer</summary>

~~~shell
Write-Host "Rename Computer"
$RENAME = Read-Host "escreva nome do computador"
Rename-Computer -NewName $RENAME
-Restart  

~~~
</details>


<details><summary>CHKDSK</summary>

~~~shell
#chkdsk c: /r
Repair-Volume C -OfflineScanAndFix

~~~

</details>


<details><summary>Defrag Windows</summary>

~~~shell
# Running DEFRAG HD
# Like: cmd admin: defrag C: /v
Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose  
  
~~~

~~~shell
# Running DEFRAG SSD
Optimize-Volume -DriveLetter C -ReTrim -Verbose  
  
~~~
</details>


<details><summary>SFC / DISM</summary>

~~~shell
sfc /scannow

~~~

~~~shell
#DISM /Online /Cleanup-image /Restorehealth  
Repair-WindowsImage -Online -StartComponentCleanup -RestoreHealth

~~~

</details>


<details><summary>Update User Policy</summary>

~~~shell
#gpupdate /force
Invoke-Expression -Command "gpupdate /force"

~~~
</details>


<details><summary>Restart print spooler service</summary>

~~~shell
# Stop print spooler service
Stop-Service -Name Spooler -Force

# To delete the files
Remove-Item -Path "$env:SystemRoot\System32\spool\PRINTERS\*.*"

# Start print spooler service
Start-Service -Name Spooler

# Restart print spooler service
Restart-Service -Name Spooler -Force  
  
~~~
</details>


<details><summary>Refresh Interface Network</summary>

~~~shell
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

~~~
</details>


<details><summary>Network Folder Mapping</summary>

~~~shell
#\\srv-storage-01\semsau
net use \\srv-storage-01\semsau$ /PERSISTENT:YES
#New-PSDrive –Name “V” –PSProvider FileSystem –Root “\\srv-storage-01\semsau$ ” –Persist  

~~~

~~~shell
#\\srv-storage-01\semsau-fms$
net use \\srv-storage-01\semsau-fms$ /PERSISTENT:YES
~~~

~~~shell
#\\srv-storage-01\semsau-pad$
net use \\srv-storage-01\semsau-pad$ /PERSISTENT:YES

~~~

~~~shell
#\\srv-storage-01\semsau-atencao-basica$
net use \\srv-storage-01\semsau-atencao-basica$ /PERSISTENT:YES

~~~

~~~shell
#\\srv-storage-01\semsau-visa$
net use \\srv-storage-01\semsau-visa$ /PERSISTENT:YES

~~~
</details>


<details><summary>Enable Dark Theme</summary>

~~~shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize /v AppsUseLightTheme /t REG_DWORD /d 0 /f
  
~~~
</details>


<details><summary>Turn Off Windows Activity History</summary>

~~~shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Advanced /v Start_TrackDocs /t REG_DWORD /d 0 /f
  
~~~
</details>


<details><summary>Disable Background apps</summary>

~~~shell
reg add HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\BackgroundAccessApplications /v GlobalUserDisabled /t REG_DWORD /d 1 /f
  
~~~
</details>


----------------------------------------------------------------------
<h1>Chocolatey</h1>

<details><summary>Install Chocolatey</summary>

~~~shell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  
~~~
<p>Source: <br> https://community.chocolatey.org/ <br> https://chocolatey.org/install <br> https://youtu.be/SaXqT1fm6Js</p>
</details>


<details><summary>Chocolatey Management</summary>

~~~shell
choco install -y vlc
choco upgrade -y vlc
choco upgrade all -y
choco uninstall vlc
choco search
choco list

choco install typora --version 0.9.75 -y
  
~~~
</details>

<details><summary>Essential APPs</summary>

~~~shell
choco install -y 7zip
choco install -y googlechrome
choco install -y vlc
choco install -y libreoffice-still
choco install -y rustdesk
  
~~~

~~~shell
choco install -y adobereader
choco install -y firefox
choco install -y ffmpeg
choco install -y lightshot
  
~~~
</details>


<details><summary>Runtimes</summary>

~~~shell
choco install -y jre8
choco install -y dotnetfx
choco install -y dotnet-5.0-runtime
choco install -y dotnet-6.0-runtime
choco install -y dotnet-7.0-runtime
choco install -y vcredist-all
ou
choco install -y vcredist2005
choco install -y vcredist2008
choco install -y vcredist2010
choco install -y vcredist2012
choco install -y vcredist2013
choco install -y vcredist140
  
~~~
</details>


<details><summary>Dev</summary>

~~~shell
choco install -y git
choco install -y vscode
choco install -y dart-sdk
choco install -y flutter
choco install -y androidstudio
choco install -y php


  
~~~
</details>


</details>


----------------------------------------------------------------------
<h1>Winget</h1>

<details><summary>Winget Management</summary>

~~~shell
winget install
winget uninstall
winget search
winget list
winget upgrade
winget upgrade --all
  
~~~

~~~shell
winget source reset --force
winget source update
winget upgrade --all --accept-source-agreements
  
~~~
<p>Source: <br> https://winstall.app/ <br> https://winget.run/ <br> https://youtu.be/OYF0hWHAicc</p>
</details>


<details><summary>Essential APPs</summary>

~~~shell
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
  
~~~

~~~shell
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
  
~~~
</details>


<details><summary>Runtimes</summary>

~~~shell
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
  
~~~
</details>


<details><summary>Dev</summary>

~~~shell
winget install --id=Microsoft.VisualStudioCode -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Microsoft.VisualStudio.2022.Community -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Git.Git -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Google.AndroidStudio -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.8.1 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=ApacheFriends.Xampp.7.4 -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Notepad++.Notepad++ -e --accept-package-agreements --accept-source-agreements ;
  
~~~
</details>


<details><summary>Chat Communication</summary>

~~~shell
winget install --id=Discord.Discord -e --accept-package-agreements --accept-source-agreements ;
winget install --id=Telegram.TelegramDesktop -e --accept-package-agreements --accept-source-agreements ;
winget install --id=BeeBEEP.BeeBEEP -e --accept-package-agreements --accept-source-agreements ;
  
~~~
</details>

<details>
<summary>Título do detalhe</summary>
Conteúdo que será mostrado ou ocultado quando o usuário clicar no título.

</details>

