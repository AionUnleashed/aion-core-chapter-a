@echo off
echo ==========================================
echo   LIBERANDO PORTA 10241 (Chat Server)
echo ==========================================
echo.

echo [1] Verificando processos na porta 10241...
echo.

for /f "tokens=5" %%a in ('netstat -aon ^| findstr :10241') do (
    set PID=%%a
    goto :found
)

echo Porta 10241 livre!
echo.
pause
exit /b 0

:found
echo Processo encontrado: PID %PID%
echo.

echo [2] Detalhes do processo:
tasklist /FI "PID eq %PID%" /FO TABLE
echo.

echo [3] Matando processo...
taskkill /F /PID %PID%
echo.

if %ERRORLEVEL% EQU 0 (
    echo ✓ Processo terminado com sucesso!
) else (
    echo × Erro ao matar processo!
)

echo.
pause
