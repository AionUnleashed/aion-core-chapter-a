@echo off
REM ==========================================
REM AION Core 4.7.5 - Complete Database Setup
REM ==========================================
echo.
echo ==========================================
echo   AION Core 4.7.5 Database Setup
echo ==========================================
echo.

REM MySQL Configuration
set MYSQL_PATH=C:\Program Files\MySQL\MySQL Server 5.7\bin
set MYSQL_USER=root
set MYSQL_PASS=vertrigo
set MYSQL_BIN=%MYSQL_PATH%\mysql.exe

REM Project paths
set PROJECT_ROOT=%~dp0..\..
set GAME_SQL=%PROJECT_ROOT%\AC-Game\sql\ac47_server_gs.sql
set LOGIN_SQL=%PROJECT_ROOT%\AC-Login\sql\ac47_server_ls.sql
set ADMIN_SQL=%PROJECT_ROOT%\scripts\database\create_admin_account.sql

echo Step 1: Creating databases...
echo.
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% -e "CREATE DATABASE IF NOT EXISTS al_server_gs CHARACTER SET utf8 COLLATE utf8_general_ci; CREATE DATABASE IF NOT EXISTS al_server_ls CHARACTER SET utf8 COLLATE utf8_general_ci;"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create databases!
    echo Check your MySQL credentials.
    pause
    exit /b 1
)
echo Databases created successfully!
echo.

echo Step 2: Importing Game Server schema...
echo This may take a few minutes...
echo.
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% al_server_gs < "%GAME_SQL%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to import Game Server schema!
    pause
    exit /b 1
)
echo Game Server schema imported successfully!
echo.

echo Step 3: Importing Login Server schema...
echo.
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% al_server_ls < "%LOGIN_SQL%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to import Login Server schema!
    pause
    exit /b 1
)
echo Login Server schema imported successfully!
echo.

echo Step 4: Creating admin account...
echo.
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% al_server_ls < "%ADMIN_SQL%"
if %ERRORLEVEL% NEQ 0 (
    echo ERROR: Failed to create admin account!
    pause
    exit /b 1
)
echo Admin account created successfully!
echo.

echo Step 5: Verifying setup...
echo.
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% -e "USE al_server_gs; SELECT COUNT(*) as 'Game Tables' FROM information_schema.tables WHERE table_schema = 'al_server_gs';"
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% -e "USE al_server_ls; SELECT COUNT(*) as 'Login Tables' FROM information_schema.tables WHERE table_schema = 'al_server_ls';"
"%MYSQL_BIN%" -u %MYSQL_USER% -p%MYSQL_PASS% -e "USE al_server_ls; SELECT name, COUNT(*) as 'Admin Accounts' FROM account_data WHERE access_level = 3;"
echo.

echo ==========================================
echo   DATABASE SETUP COMPLETE!
echo ==========================================
echo.
echo Default Admin Account:
echo   Username: admin
echo   Password: admin
echo   Level: 3 (Administrator)
echo.
echo IMPORTANT: Change the admin password after first login!
echo.
echo Next steps:
echo   1. Compile the project: scripts\build\build_all.bat
echo   2. Start servers: scripts\start\start_all_servers.bat
echo.

pause
