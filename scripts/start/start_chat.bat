@echo off
title AION Core - Chat Server
color 0E

echo ==========================================
echo  AION Core 4.7.5 - Chat Server
echo  (Com limpeza automatica de porta)
echo ==========================================
echo.

REM Matar processos Java antigos na porta 10241
echo [1] Verificando porta 10241...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr :10241') do (
    echo    Processo encontrado na porta 10241 ^(PID: %%a^)
    echo    Finalizando processo...
    taskkill /F /PID %%a >nul 2>&1
    timeout /t 2 /nobreak >nul
)
echo    Porta 10241 liberada!
echo.

cd ..\..\AC-Chat

if not exist "build\AC-Chat.jar" (
    echo ERRO: AC-Chat.jar nao encontrado!
    pause
    exit /b 1
)

if not exist "..\AC-Commons\target\ac-commons-4.7.5.jar" (
    echo ERRO: AC-Commons nao encontrado!
    pause
    exit /b 1
)

if not exist "libs\guava-31.1-jre.jar" (
    echo ERRO: Guava nao encontrado em libs!
    pause
    exit /b 1
)

set JAVA_HOME=C:\Program Files\Java\jdk-1.8

echo [2] Iniciando Chat Server...
echo.
echo Memoria: 128 MB min, 256 MB max
echo Porta cliente: 10241
echo Porta Game: 9021
echo.

"%JAVA_HOME%\bin\java.exe" -Xms128m -Xmx256m -server -cp "build/classes;build/AC-Chat.jar;../AC-Commons/target/classes;../AC-Commons/target/ac-commons-4.7.5.jar;libs/guava-31.1-jre.jar;libs/*" com.aionemu.chatserver.ChatServer

pause
