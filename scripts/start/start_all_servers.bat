@echo off
title AION Core - Iniciar Todos os Servidores
color 0C

echo ==========================================
echo  AION Core 4.7.5 - Iniciar Tudo
echo ==========================================
echo.
echo Este script iniciara todos os servidores
echo em ordem:
echo.
echo 1. Login Server
echo 2. Game Server (aguarda 10 segundos)
echo 3. Chat Server (aguarda 10 segundos)
echo.
echo Cada servidor abrira em uma nova janela.
echo.
pause

echo Iniciando Login Server...
start "AION - Login Server" "%~dp0start_login.bat"

echo Aguardando 12 segundos para o Login Server inicializar...
echo (Login Server ~ 9 segundos)
timeout /t 12 /nobreak

echo Iniciando Game Server...
start "AION - Game Server" "%~dp0start_game.bat"

echo Aguardando 600 segundos para o Game Server inicializar...
echo (Game Server ~ 579 segundos / 9.6 minutos devido ao carregamento)
timeout /t 600 /nobreak

echo Iniciando Chat Server...
start "AION - Chat Server" "%~dp0start_chat.bat"

echo.
echo ==========================================
echo  Todos os servidores foram iniciados!
echo ==========================================
echo.
echo Verifique as janelas abertas para cada servidor.
echo.
pause
