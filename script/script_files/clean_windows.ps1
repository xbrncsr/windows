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

# ******************** LIXEIRA ********************
del c:\$recycle.bin\* /s /q
PowerShell.exe -NoProfile -Command Clear-RecycleBin -Confirm:$false >$null
del $null

# ******************** PASTA TEMP DOS USUÁRIOS ********************

# Apaga todos arquivos da pasta Temp de todos os usuários
for /d %%F in (C:\Users\*) do (Powershell.exe Remove-Item -Path "%%F\AppData\Local\Temp\*" -Recurse -Force)

# cria arquivo vazio.txt dentro da pasta Temp de todos usuários
for /d %%F in (C:\Users\*) do type nul >"%%F\Appdata\Local\Temp\vazio.txt"

# apaga todas as pastas vazias dentro da pasta Temp de todos usuários (mas não apaga a própria pasta Temp)
for /d %%F in (C:\Users\*) do robocopy %%F\AppData\Local\Temp\ %%F\AppData\Local\Temp\ /s /move /NFL /NDL /NJH /NJS /nc /ns /np

# Apaga arquivo vazio.txt dentro da pasta Temp de todos usuários
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Temp\vazio.txt

# ******************** WINDOWS TEMP ********************

# Apaga todos arquivos da pasta \Windows\Temp, mantendo das pastas
del c:\Windows\Temp\* /s /q

# cria arquivo vazio.txt dentro da pasta \Windows\Temp
type nul > c:\Windows\Temp\vazio.txt

# apaga todas as pastas vazias dentro da pasta \Windows\Temp (mas não apaga a própria pasta)
robocopy c:\Windows\Temp c:\Windows\Temp /s /move /NFL /NDL /NJH /NJS /nc /ns /np

# Apaga arquivo vazio.txt dentro da pasta \Windows\Temp
del c:\Windows\Temp\vazio.txt

# ******************** ARQUIVOS DE LOG DO WINDOWS ********************

del C:\Windows\Logs\cbs\*.log
del C:\Windows\setupact.log
attrib -s c:\windows\logs\measuredboot\*.*
del c:\windows\logs\measuredboot\*.log
attrib -h -s C:\Windows\ServiceProfiles\NetworkService\
attrib -h -s C:\Windows\ServiceProfiles\LocalService\
del C:\Windows\ServiceProfiles\LocalService\AppData\Local\Temp\MpCmdRun.log
del C:\Windows\ServiceProfiles\NetworkService\AppData\Local\Temp\MpCmdRun.log
attrib +h +s C:\Windows\ServiceProfiles\NetworkService\
attrib +h +s C:\Windows\ServiceProfiles\LocalService\
for /d %%F in (C:\Users\*) do del %%F\AppData\Local\Microsoft\*.log /s /q
del C:\Windows\Logs\MeasuredBoot\*.log 
del C:\Windows\Logs\MoSetup\*.log
del C:\Windows\Panther\*.log /s /q
del C:\Windows\Performance\WinSAT\winsat.log /s /q
del C:\Windows\inf\*.log /s /q
del C:\Windows\logs\*.log /s /q
del C:\Windows\SoftwareDistribution\*.log /s /q
del C:\Windows\Microsoft.NET\*.log /s /q

