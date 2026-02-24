@echo off
title AION Core - Game Server
color 0B

echo ==========================================
echo  AION Core 4.7.5 - Game Server
echo ==========================================
echo.

cd ..\..\AC-Game

if not exist "build\AC-Game.jar" (
    echo ERRO: AC-Game.jar nao encontrado em build\!
    echo Execute scripts\build\build_all.bat primeiro.
    echo.
    pause
    exit /b 1
)

if not exist "libs\ac-commons-1.3.jar" (
    echo ERRO: ac-commons-1.3.jar nao encontrado em libs\!
    echo Copie AC-Commons\target\ac-commons-1.3.jar para AC-Game\libs\
    echo.
    pause
    exit /b 1
)

set JAVA_HOME=C:\Program Files\Java\jdk1.7.0_79

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

"%JAVA_HOME%\bin\java.exe" -Xms512m -Xmx4096m -server -noverify -javaagent:./libs/ac-commons-1.3.jar -cp "./libs/*;build/AC-Game.jar" com.aionemu.gameserver.GameServer

pause
