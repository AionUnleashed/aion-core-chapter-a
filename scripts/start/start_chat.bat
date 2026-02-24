@echo off
title AION Core - Chat Server
color 0E

echo ==========================================
echo  AION Core 4.7.5 - Chat Server
echo ==========================================
echo.

cd ..\..\AC-Chat

if not exist "build\AC-Chat.jar" (
    echo ERRO: AC-Chat.jar nao encontrado em build\!
    echo Execute scripts\build\build_all.bat primeiro.
    echo.
    pause
    exit /b 1
)

set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_79

echo Iniciando Chat Server...
echo.
echo Memoria: 128 MB minima, 256 MB maxima
echo Porta padrao: 10241
echo.

"%JAVA_HOME%\bin\java.exe" -Xms128m -Xmx256m -server -cp "./libs/*;build/AC-Chat.jar" com.aionemu.chatserver.ChatServer

pause
