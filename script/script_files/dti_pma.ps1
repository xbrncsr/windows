

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



#flushdns
#ipconfig /flushdns

#release
#ipconfig /release

#renew
#ipconfig /renew

# defrag
#Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose

Write-Host "Limpeza de arquivos temporários e remoção da pasta windows.old concluídas."

# Limpeza de arquivos temporários do Windows

# Função para calcular o tamanho de uma pasta
function Get-FolderSize($folder) {
    $size = 0
    Get-ChildItem $folder -Recurse | ForEach-Object { $size += $_.Length }
    return $size
}

# Limpeza de arquivos temporários do usuário
$env:TEMP | Remove-Item -Force -Recurse
$env:TMP | Remove-Item -Force -Recurse

# Limpeza de arquivos temporários do sistema
$windowsTemp = [System.IO.Path]::Combine($env:SystemRoot, 'Temp')
$windowsTemp | Remove-Item -Force -Recurse

# Limpeza de arquivos de logs do sistema
$windowsLogs = [System.IO.Path]::Combine($env:SystemRoot, 'Logs')
$windowsLogs | Remove-Item -Force -Recurse

# Limpeza de arquivos de cache do sistema
$windowsCSC = [System.IO.Path]::Combine($env:SystemRoot, 'CSC')
$windowsCSC | Remove-Item -Force -Recurse

# Limpeza da lixeira
Clear-RecycleBin -Force

# Mostrar espaço livre antes e depois da limpeza
$initialFreeSpace = (Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -eq "C:\" }).Free
Write-Host "Espaço livre inicial: $initialFreeSpace bytes"

# Aguardar 5 segundos antes de verificar o espaço livre novamente
Start-Sleep -Seconds 5

$finalFreeSpace = (Get-PSDrive -PSProvider FileSystem | Where-Object { $_.Root -eq "C:\" }).Free
Write-Host "Espaço livre após a limpeza: $finalFreeSpace bytes"

