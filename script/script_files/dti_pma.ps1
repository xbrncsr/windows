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





# NOVO
# Windows Cleanup Script

# Verifica se está sendo executado como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell -Verb RunAs -ArgumentList ($MyInvocation.MyCommand.Definition + " am_admin")
    exit
}

# Limpeza do disco usando PowerShell
Write-Host "Realizando limpeza do disco..."

# Função para limpar uma pasta
function Clear-Folder($path) {
    if (Test-Path $path) {
        Get-ChildItem -Path $path | Remove-Item -Force -Recurse -ErrorAction SilentlyContinue
    }
}

# Limpeza de arquivos temporários
Clear-Folder "$env:TEMP"

# Limpeza de arquivos de otimização de entrega
Clear-Folder "$env:SystemRoot\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Download"
Clear-Folder "$env:SystemRoot\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache"

# Remoção do diretório Windows.old
Write-Host "Removendo o diretório Windows.old..."
Remove-Item -Path "C:\Windows.old" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Limpeza concluída com sucesso!"


# xxxxxxxxxxxxxxxxx
# Script de Limpeza Completa para o Windows 11

# Função para limpar a pasta especificada
function LimparPasta($caminho) {
    Get-ChildItem $caminho -Recurse | Remove-Item -Force -ErrorAction SilentlyContinue
}

# Limpar arquivos temporários do Windows
Write-Host "Limpando arquivos temporários..."
LimparPasta "C:\Windows\Temp"

# Limpar Lixeira
Write-Host "Limpando Lixeira..."
Clear-RecycleBin -Force

# Limpar logs de eventos antigos
Write-Host "Limpando logs de eventos antigos..."
wevtutil el | ForEach-Object {wevtutil cl $_}

# Limpar cache de thumbnails
Write-Host "Limpando cache de thumbnails..."
LimparPasta "$env:USERPROFILE\AppData\Local\Microsoft\Windows\Explorer"

# Limpar cache de atualizações do Windows
Write-Host "Limpando cache de atualizações do Windows..."
net stop wuauserv
Remove-Item "$env:SystemRoot\SoftwareDistribution\Download" -Force -Recurse -ErrorAction SilentlyContinue
net start wuauserv

Write-Host "Limpeza concluída."
