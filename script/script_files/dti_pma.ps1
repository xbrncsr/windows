

# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	# Enable execution script PowerShell
	Start-Process powershell.exe "-command set-ExecutionPolicy unrestricted"
	Exit
}

# DISM
DISM /Online /Cleanup-image /Restorehealth

# SFC
sfc /scannow

# defrag
Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose  

#flushdns
ipconfig /flushdns

#release
ipconfig /release

#renew
ipconfig /renew


# Script para limpeza de arquivos temporários e remoção da pasta windows.old no Windows 11
# Caminhos para pastas de arquivos temporários
$windowsTempPath = [System.IO.Path]::Combine($env:SystemRoot, 'Temp')
$userTempPath = [System.IO.Path]::Combine($env:TEMP)

# Caminho para a pasta windows.old
$windowsOldPath = [System.IO.Path]::Combine($env:SystemDrive, 'windows.old')

# Função para limpar arquivos em uma pasta
function LimparTempFolder($folderPath) {
    Get-ChildItem -Path $folderPath | Remove-Item -Force -Recurse
}

# Função para limpar a pasta windows.old
function LimparWindowsOldFolder($folderPath) {
    if (Test-Path $folderPath) {
        Remove-Item -Path $folderPath -Recurse -Force
    }
}

# Limpar arquivos na pasta de arquivos temporários do Windows
LimparTempFolder $windowsTempPath

# Limpar arquivos na pasta de arquivos temporários do usuário
LimparTempFolder $userTempPath

# Limpar a pasta windows.old
LimparWindowsOldFolder $windowsOldPath

Write-Host "Limpeza de arquivos temporários e remoção da pasta windows.old concluídas."
