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
# Windows Cleanup Script with UIAutomation

# Installa o módulo UIAutomation (se não estiver instalado)
Install-Module -Name UIAutomation -Force -SkipPublisherCheck -Scope CurrentUser

# Importa o módulo UIAutomation
Import-Module UIAutomation

# Função para clicar em um botão com base no texto do botão
function Click-Button($window, $buttonText) {
    $button = Get-UIAButton -Name $buttonText -Parent $window
    if ($button -ne $null) {
        Invoke-UIAButton -Button $button -Click
        return $true
    }
    return $false
}

# Limpeza do disco usando PowerShell e UIAutomation
Write-Host "Realizando limpeza do disco..."

# Executar cleanmgr.exe
Start-Process cleanmgr -Wait

# Aguardar a janela do Disk Cleanup aparecer
Start-Sleep -Seconds 5

# Obter a janela principal do Disk Cleanup
$diskCleanupWindow = Get-UIAWindow -Name "Disk Cleanup"

if ($diskCleanupWindow -ne $null) {
    # Clicar no botão "Clean up system files"
    if (Click-Button -window $diskCleanupWindow -buttonText "Clean up system files") {
        # Aguardar a janela atualizar com as novas opções
        Start-Sleep -Seconds 5

        # Clicar no botão "OK" para iniciar a limpeza
        Click-Button -window $diskCleanupWindow -buttonText "OK"
    }
}

Write-Host "Limpeza concluída com sucesso!"
