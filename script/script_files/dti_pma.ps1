

# Ask for elevated permissions if required
If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
	Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
	# Enable execution script PowerShell
	Start-Process powershell.exe "-command set-ExecutionPolicy unrestricted"
	Exit
}

# DISM
#DISM /Online /Cleanup-image /Restorehealth

# SFC
#sfc /scannow



#flushdns
#ipconfig /flushdns

#release
#ipconfig /release

#renew
#ipconfig /renew

# defrag
#Optimize-Volume -DriveLetter C -Defrag -TierOptimize -Verbose

Write-Host "Limpeza de arquivos temporários e remoção da pasta windows.old concluídas."


# Configurar a frequência de execução do Storage Sense (em dias)
Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy' -Name '02' -Value 7



