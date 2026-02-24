@echo off
echo Copiando Guava para AC-Chat\libs...

set SOURCE=%USERPROFILE%\.m2\repository\com\google\guava\guava\31.1-jre\guava-31.1-jre.jar
set DEST=AC-Chat\libs\guava-31.1-jre.jar

if not exist "%SOURCE%" (
    echo ERRO: Guava nao encontrada em %SOURCE%
    pause
    exit /b 1
)

copy "%SOURCE%" "%DEST%"

if exist "%DEST%" (
    echo.
    echo SUCESSO! Guava copiada para AC-Chat\libs
    dir "%DEST%"
) else (
    echo ERRO: Copia falhou!
)

pause
