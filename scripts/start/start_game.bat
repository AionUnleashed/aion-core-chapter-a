@echo off
title AION Core - Game Server
color 0B

echo ==========================================
echo  AION Core 4.7.5 - Game Server
echo ==========================================
echo.

cd ..\..\AC-Game

if not exist "target\ac-game-4.7.5.jar" (
    echo ERRO: ac-game-4.7.5.jar nao encontrado em target\!
    echo Execute: mvn clean package -DskipTests
    echo Ou use: scripts\build\build_maven_all.bat
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

REM Usa Java 8u471
if not defined JAVA_HOME (
    set JAVA_HOME=C:\Program Files\Java\jdk-1.8
)

echo Iniciando Game Server...
echo.
echo Memoria: 512 MB minima, 4096 MB maxima
echo Porta padrao: 7777 (clientes)
echo.
echo ATENCAO: Certifique-se de que o Login Server
echo          esta rodando antes de iniciar o Game Server!
echo.
echo Parametros especiais:
echo   -noverify: Desabilita verificacao de bytecode
echo   -javaagent: Habilita sistema de callbacks
echo.

"%JAVA_HOME%\bin\java.exe" -Xms512m -Xmx4096m -server -noverify -javaagent:../AC-Commons/target/ac-commons-4.7.5.jar -cp "target/classes;target/ac-game-4.7.5.jar;../AC-Commons/target/classes;../AC-Commons/target/ac-commons-4.7.5.jar;libs/*;target/libs/*" com.aionemu.gameserver.GameServer

pause
