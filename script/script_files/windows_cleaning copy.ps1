# Definir a Política de Execução para Unrestricted temporariamente
Set-ExecutionPolicy Unrestricted -Scope Process -Force

# Remover diretório Windows.old (se existir)
$WindowsOldPath = "$env:SystemDrive\Windows.old"
if (Test-Path -Path $WindowsOldPath -PathType Container) {
    Remove-Item -Path $WindowsOldPath -Recurse -Force
}

# Limpeza de arquivos de logs do Windows
Remove-Item -Path "$env:SystemRoot\Logs\*" -Force -Recurse

# Limpeza de cache do Windows Update
Stop-Service -Name wuauserv
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\DataStore\*" -Force -Recurse
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Force -Recurse
Start-Service -Name wuauserv

# Limpeza de versões antigas do sistema
DISM.exe /Online /Cleanup-Image /StartComponentCleanup /ResetBase

# Limpeza de arquivos temporários
Remove-Item -Path "$env:SystemRoot\Temp\*" -Force -Recurse
Remove-Item -Path "$env:TEMP\*" -Force -Recurse

# Limpeza de cache de miniaturas
Remove-Item -Path "$env:LocalAppData\Microsoft\Windows\Explorer\thumbcache_*" -Force

# Limpeza de cache de fontes
Remove-Item -Path "$env:LocalAppData\Microsoft\Windows\Fonts\*" -Force -Recurse

# Limpeza de cache DNS
Clear-DnsClientCache

# Remover arquivos de otimização de entrega (Delivery Optimization)
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Force -Recurse

# Restaurar a Política de Execução para o estado original
Set-ExecutionPolicy -Scope Process -Force

Write-Host "A limpeza foi concluída."
