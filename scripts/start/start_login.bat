@echo off
title AION Core - Login Server
color 0A

echo ==========================================
echo  AION Core 4.7.5 - Login Server
echo ==========================================
echo.

cd ..\..\AC-Login

if not exist "target\ac-login-4.7.5.jar" (
    echo ERRO: ac-login-4.7.5.jar nao encontrado em target\!
    echo Execute: mvn clean package -DskipTests
    echo Ou use: scripts\build\build_maven_commons.bat
    echo.
    pause
    exit /b 1
)

REM Verifica AC-Commons
if not exist "..\AC-Commons\target\ac-commons-4.7.5.jar" (
    echo ERRO: AC-Commons nao encontrado!
    echo Compile AC-Commons primeiro.
    echo.
    pause
    exit /b 1
)

REM Usa Java 8u471 (configurado via Setup-Java8u471.ps1)
if not defined JAVA_HOME (
    set JAVA_HOME=C:\Program Files\Java\jdk-1.8
)

echo Iniciando Login Server...
echo.
echo Memoria: 128 MB minima, 256 MB maxima
echo Porta padrao: 2106 (clientes)
echo Porta interna: 9014 (Game Server)
echo.

"%JAVA_HOME%\bin\java.exe" -Xms128m -Xmx256m -server -cp "target/classes;target/ac-login-4.7.5.jar;../AC-Commons/target/classes;../AC-Commons/target/ac-commons-4.7.5.jar;target/libs/*;libs/*" com.aionemu.loginserver.LoginServer

pause
