

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


Write-Host "Limpando arquivos temporários do usuário...."
rmdir /s /q %TEMP%
rmdir /s /q %TMP%

Write-Host "Limpando arquivos temporários do sistema......"
rmdir /s /q %SystemRoot%\Temp

Write-Host "Limpando arquivos de logs do sistema......"
rmdir /s /q %SystemRoot%\Logs

Write-Host "Limpando arquivos de cache do sistema......."
rmdir /s /q %SystemRoot%\CSC

Write-Host "Esvaziando a Lixeira......"
rd /s /q C:\$Recycle.Bin

Write-Host "Mostrando espaço livre antes da limpeza......."
fsutil volume diskfree C:

Write-Host "5555555 segundos...."
timeout /t 5 /nobreak >nul

Write-Host "Mostrando espaço livre após a limpeza......"

fsutil volume diskfree C:



