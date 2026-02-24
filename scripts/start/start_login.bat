@echo off
title AION Core - Login Server
color 0A

echo ==========================================
echo  AION Core 4.7.5 - Login Server
echo ==========================================
echo.

cd ..\..\AC-Login

if not exist "build\AC-Login.jar" (
    echo ERRO: AC-Login.jar nao encontrado em build\!
    echo Execute scripts\build\build_all.bat primeiro.
    echo.
    pause
    exit /b 1
)

set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_79

echo Iniciando Login Server...
echo.
echo Memoria: 128 MB minima, 256 MB maxima
echo Porta padrao: 2106 (clientes)
echo Porta interna: 9014 (Game Server)
echo.

"%JAVA_HOME%\bin\java.exe" -Xms128m -Xmx256m -server -cp "./libs/*;build/AC-Login.jar" com.aionemu.loginserver.LoginServer

pause
