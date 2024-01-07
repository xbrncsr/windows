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
# Windows Cleanup Script

# Verifica se está sendo executado como administrador
$isAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $isAdmin) {
    Start-Process powershell -Verb RunAs -ArgumentList ($MyInvocation.MyCommand.Definition + " am_admin")
    exit
}

# Limpeza do disco usando PowerShell e WMI
Write-Host "Realizando limpeza do disco..."

# Obter a classe Win32_DiskCleanup
$diskCleanup = Get-CimClass -Namespace root/cimv2 -ClassName Win32_DiskCleanup

# Criar uma instância da classe
$instance = $diskCleanup.CreateInstance()

# Configurar todas as opções para verdadeiro
foreach ($property in $diskCleanup.CimClassProperties) {
    if ($property.Name -ne 'Name' -and $property.Name -ne 'Description') {
        $instance[$property.Name] = $true
    }
}

# Executar o método RunNow
$result = $diskCleanup.CimClassMethods['RunNow'].Invoke($instance)

# Remoção do diretório Windows.old
Write-Host "Removendo o diretório Windows.old..."
Remove-Item -Path "C:\Windows.old" -Recurse -Force -ErrorAction SilentlyContinue

# Limpeza de arquivos de otimização de entrega
Write-Host "Limpando arquivos de otimização de entrega..."
Remove-Item -Path "$env:SystemRoot\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Download" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:SystemRoot\ServiceProfiles\NetworkService\AppData\Local\Microsoft\Windows\DeliveryOptimization\Cache" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Limpeza concluída com sucesso!"
