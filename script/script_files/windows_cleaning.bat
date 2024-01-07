@echo off
echo ===============================================================
echo    Windows Cleanup Script
echo ===============================================================
echo.

:: Execute o prompt de comando como administrador
cd /d "%~dp0"
if NOT "%1"=="am_admin" (
    powershell start -verb runas '%0' am_admin
    goto :eof
)

:: Inicia a limpeza do disco
echo Realizando limpeza do disco...
echo.
cleanmgr /sagerun:1

:: Aguarda o processo de limpeza terminar
timeout /t 10 /nobreak > nul

:: Remove o diretório Windows.old
echo Removendo o diretório Windows.old...
rmdir /s /q C:\Windows.old

echo Limpeza concluída com sucesso!
echo.
pause
