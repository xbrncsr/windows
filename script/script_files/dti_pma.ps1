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
# Lixeira (Recycle Bin)
Remove-Item -Path "C:\$Recycle.Bin\*" -Force -Recurse

# Pasta Temp dos Usuários (User Temp Folder)
Get-ChildItem -Path "C:\Users\" -Directory | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Temp\*" -Force -Recurse
    New-Item -Path "$($_.FullName)\AppData\Local\Temp\vazio.txt" -ItemType File | Out-Null
    Move-Item -Path "$($_.FullName)\AppData\Local\Temp\*" -Destination "$($_.FullName)\AppData\Local\Temp\" -Force
    Remove-Item -Path "$($_.FullName)\AppData\Local\Temp\vazio.txt" -Force
}

# Windows Temp
Remove-Item -Path "C:\Windows\Temp\*" -Force -Recurse
New-Item -Path "C:\Windows\Temp\vazio.txt" -ItemType File | Out-Null
Move-Item -Path "C:\Windows\Temp\*" -Destination "C:\Windows\Temp\" -Force
Remove-Item -Path "C:\Windows\Temp\vazio.txt" -Force

# Arquivos de Log do Windows (Windows Log Files)
Remove-Item -Path "C:\windows\logs\cbs\*.log" -Force
Remove-Item -Path "C:\Windows\Logs\MoSetup\*.log" -Force
Remove-Item -Path "C:\Windows\Panther\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\inf\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\logs\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\SoftwareDistribution\*.log" -Force -Recurse
Remove-Item -Path "C:\Windows\Microsoft.NET\*.log" -Force -Recurse

Get-ChildItem -Path "C:\Users\" -Directory | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\OneDrive\setup\logs\*.log" -Force -Recurse
}

# Arquivos de Log do Windows e IE (Windows and Internet Explorer Log Files)
Get-ChildItem -Path "C:\Users\" -Directory | ForEach-Object {
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\Explorer\*.db" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\WebCache\*.log" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\SettingSync\*.log" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\Explorer\ThumbCacheToDelete\*.tmp" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Terminal Server Client\Cache\*.bin" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\IE\*" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\Low\*.dat" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\Low\*.js" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\Low\*.htm" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\Low\*.txt" -Force -Recurse
    Remove-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\Low\*.jpg" -Force -Recurse
    Move-Item -Path "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\IE\*" -Destination "$($_.FullName)\AppData\Local\Microsoft\Windows\INetCache\IE\" -Force
}
