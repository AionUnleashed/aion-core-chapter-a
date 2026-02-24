@echo off
echo ============================================
echo   VALIDACAO FINAL - 3 SERVIDORES
echo ============================================
echo.

echo [1] Verificando portas abertas...
echo.

netstat -ano | findstr :2106 | findstr LISTENING >nul
if %ERRORLEVEL% EQU 0 (
    echo    2106  ^(Login GS^)       : [OK] LISTENING
) else (
    echo    2106  ^(Login GS^)       : [XX] Fechada
)

netstat -ano | findstr :9014 | findstr LISTENING >nul
if %ERRORLEVEL% EQU 0 (
    echo    9014  ^(Login Client^)   : [OK] LISTENING
) else (
    echo    9014  ^(Login Client^)   : [XX] Fechada
)

netstat -ano | findstr :7777 | findstr LISTENING >nul
if %ERRORLEVEL% EQU 0 (
    echo    7777  ^(Game Client^)    : [OK] LISTENING
) else (
    echo    7777  ^(Game Client^)    : [XX] Fechada
)

netstat -ano | findstr :9021 | findstr LISTENING >nul
if %ERRORLEVEL% EQU 0 (
    echo    9021  ^(Chat Game^)      : [OK] LISTENING
) else (
    echo    9021  ^(Chat Game^)      : [XX] Fechada
)

netstat -ano | findstr :10241 | findstr LISTENING >nul
if %ERRORLEVEL% EQU 0 (
    echo    10241 ^(Chat Client^)    : [OK] LISTENING
) else (
    echo    10241 ^(Chat Client^)    : [XX] Fechada
)

echo.
echo [2] Processos Java rodando:
echo.
tasklist | findstr /I "java.exe"

echo.
echo [3] Ultimas linhas do Chat Server:
echo.
type AC-Chat\log\console.log | find "started in"

echo.
echo ============================================
echo   FIM DA VALIDACAO
echo ============================================
pause
