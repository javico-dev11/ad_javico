@echo off & setlocal enableextensions
title Resetar AnyDesk

:: 🔐 Solicitar contraseña de forma oculta usando PowerShell
for /f "delims=" %%p in ('powershell -Command "$p = Read-Host -AsSecureString 'Clave'; [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($p))"') do set "pass=%%p"

if not "%pass%"=="Clave123" (
    echo Clave incorrecta. Cerrando...
    timeout /t 2 >nul
    exit /b
)

:: 🛑 Verificar ejecución como administrador
reg query HKEY_USERS\S-1-5-19 >NUL || (
    echo Por favor, ejecute como administrador.
    pause >NUL
    exit
)

chcp 437

call :stop_any

:: 🧹 Eliminar archivos de configuración de AnyDesk
del /f "%ALLUSERSPROFILE%\AnyDesk\service.conf"
del /f "%APPDATA%\AnyDesk\service.conf"

:: 💾 Guardar user.conf actual en TEMP
copy /y "%APPDATA%\AnyDesk\user.conf" "%temp%\" >nul

:: 🧼 Eliminar miniaturas antiguas
rd /s /q "%temp%\thumbnails" 2>nul

:: 📦 Copiar miniaturas actuales a TEMP
xcopy /c /e /h /r /y /i /k "%APPDATA%\AnyDesk\thumbnails" "%temp%\thumbnails" >nul

:: 🗑️ Eliminar archivos de la carpeta AnyDesk
del /f /a /q "%ALLUSERSPROFILE%\AnyDesk\*" >nul
del /f /a /q "%APPDATA%\AnyDesk\*" >nul

call :start_any

:lic
:: ⏳ Esperar system.conf
type "%ALLUSERSPROFILE%\AnyDesk\system.conf" | find "ad.anynet.id=" >nul || goto lic

:: ♻️ Restaurar archivos de configuración
call :stop_any
move /y "%temp%\user.conf" "%APPDATA%\AnyDesk\user.conf" >nul
xcopy /c /e /h /r /y /i /k "%temp%\thumbnails" "%APPDATA%\AnyDesk\thumbnails" >nul
rd /s /q "%temp%\thumbnails" >nul

call :start_any

echo *********
echo Concluído.
echo(

:: 💣 Autodestruir script
del "%~f0" >nul
goto :eof

:start_any
:: 🚀 Iniciar AnyDesk
sc start AnyDesk >nul
sc start AnyDesk >nul
if %errorlevel% neq 1056 goto start_any

:: ▶️ Ejecutar AnyDesk si existe
set "AnyDesk1=%ProgramFiles(x86)%\AnyDesk\AnyDesk.exe"
set "AnyDesk2=%ProgramFiles%\AnyDesk\AnyDesk.exe"
if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"
exit /b

:stop_any
:: 🛑 Detener servicio y proceso
sc stop AnyDesk >nul
sc stop AnyDesk >nul
if %errorlevel% neq 1062 goto stop_any
taskkill /f /im "AnyDesk.exe" >nul
exit /b
