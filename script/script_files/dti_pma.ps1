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
# Desativar temporariamente o Storage Sense para evitar conflitos
Disable-StorageSense -ExecutionPolicy Bypass -Force

# Limpar lixeira
Clear-RecycleBin -Force

# Limpar arquivos temporários de usuários
Get-ChildItem -Path "C:\Users\" -Directory | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Temp\*" -Force -Recurse
}

# Limpar a pasta Temp do Windows
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse

# Limpar arquivos de log
Remove-Item -Path "C:\Windows\Logs\CBS\*.log" -Force
Remove-Item -Path "C:\Windows\Logs\MoSetup\*.log" -Force
Remove-Item -Path "C:\Windows\Panther\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\inf\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\Logs\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\SoftwareDistribution\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\Microsoft.NET\*.log" -Force -Recurse

# Limpar arquivos de cache do Internet Explorer
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\IE\*" -Force -Recurse
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\*.dat" -Force -Recurse
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\*.js" -Force -Recurse
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\*.htm" -Force -Recurse
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\*.txt" -Force -Recurse
Remove-Item -Path "$env:USERPROFILE\AppData\Local\Microsoft\Windows\INetCache\Low\*.jpg" -Force -Recurse

# Ativar o Storage Sense de volta
Enable-StorageSense -ExecutionPolicy Bypass -Force

