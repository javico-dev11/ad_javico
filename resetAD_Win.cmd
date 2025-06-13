@echo off & setlocal enableextensions
title Resetar AnyDesk

:: Comprueba si el script se está ejecutando como administrador (comprueba si la clave existe en el registro)
reg query HKEY_USERS\S-1-5-19 >NUL || (
    echo Por favor, execute como administrador.
    pause >NUL
    exit
)

chcp 437 :: Define o código de página

call :stop_any

:: Eliminar archivos de configuración de AnyDesk
del /f "%ALLUSERSPROFILE%\AnyDesk\service.conf"
del /f "%APPDATA%\AnyDesk\service.conf"

:: Guarda el user.conf actual en TEMP
copy /y "%APPDATA%\AnyDesk\user.conf" "%temp%\"

:: Eliminar miniaturas antiguas
rd /s /q "%temp%\thumbnails" 2>NUL

:: Copia las miniaturas actuales a TEMP
xcopy /c /e /h /r /y /i /k "%APPDATA%\AnyDesk\thumbnails" "%temp%\thumbnails"

:: Elimina todos los archivos de la carpeta AnyDesk (tanto del sistema como del perfil de usuario)
del /f /a /q "%ALLUSERSPROFILE%\AnyDesk\*"
del /f /a /q "%APPDATA%\AnyDesk\*"

call :start_any

:lic
:: Espere hasta que el archivo system.conf contenga la línea "ad.anynet.id="
type "%ALLUSERSPROFILE%\AnyDesk\system.conf" | find "ad.anynet.id=" || goto lic

:: Restaura archivos de configuración
call :stop_any
move /y "%temp%\user.conf" "%APPDATA%\AnyDesk\user.conf"
xcopy /c /e /h /r /y /i /k "%temp%\thumbnails" "%APPDATA%\AnyDesk\thumbnails"
rd /s /q "%temp%\thumbnails"

call :start_any

echo *********
echo Concluído.
echo(
goto :eof

:start_any
:: Iniciar el servicio AnyDesk
sc start AnyDesk
sc start AnyDesk
if %errorlevel% neq 1056 goto start_any

:: Intenta iniciar el ejecutable si existe
set AnyDesk1=%SystemDrive%\Program Files (x86)\AnyDesk\AnyDesk.exe
set AnyDesk2=%SystemDrive%\Program Files\AnyDesk\AnyDesk.exe
if exist "%AnyDesk1%" start "" "%AnyDesk1%"
if exist "%AnyDesk2%" start "" "%AnyDesk2%"
exit /b

:stop_any
:: Para el servicio y matar el proceso
sc stop AnyDesk
sc stop AnyDesk
if %errorlevel% neq 1062 goto stop_any
taskkill /f /im "AnyDesk.exe"
exit /b