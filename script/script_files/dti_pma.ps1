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

# SFC
sfc /scannow

# DISM
DISM /Online /Cleanup-image /Restorehealth

# defrag
Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose  

# limpeza
@echo off
echo ===============================================================
echo    Windows Cleanup Script
echo ===============================================================
echo.

:: Execute o prompt de comando como administrador
cd /d "%~dp0"
if NOT "%1"=="am_admin" (
    powershell start -verb runas '%0' am_admin
    goto :eof
)

:: Inicia a limpeza do disco
echo Realizando limpeza do disco...
echo.
cleanmgr /verylowdisk

:: Remove o diretório Windows.old
echo Removendo o diretório Windows.old...
rmdir /s /q C:\Windows.old

:: Limpeza de arquivos de otimização de entrega
echo Limpando arquivos de otimização de entrega...
rmdir /s /q "%SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Download"
rmdir /s /q "%SystemRoot%\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache"

echo Limpeza concluída com sucesso!
echo.
pause
