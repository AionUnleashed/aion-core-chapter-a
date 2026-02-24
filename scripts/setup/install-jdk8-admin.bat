@echo off
echo ============================================
echo Instalando JDK 8 em C:\Program Files\Java\
echo ============================================
echo.
echo Este script requer privilegios de Administrador!
echo.
pause

echo Copiando JDK 8...
robocopy "%USERPROFILE%\Desktop\jdk8-temp\jdk8u432-b06" "C:\Program Files\Java\jdk8u432-b06" /E /COPY:DAT /R:3 /W:5 /MT:8

if %ERRORLEVEL% LEQ 7 (
    echo.
    echo [OK] JDK 8 copiado com sucesso!
    echo.
    
    echo Configurando JAVA_HOME...
    setx JAVA_HOME "C:\Program Files\Java\jdk8u432-b06" /M
    
    echo.
    echo Atualizando PATH...
    for /f "tokens=2*" %%a in ('reg query "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Environment" /v Path') do set "systempath=%%b"
    
    :: Remove referencias antigas ao Java7
    set "systempath=%systempath:C:\Program Files\Java\jdk1.7.0_79\bin;=%"
    
    :: Adiciona Java 8 no inicio
    setx PATH "C:\Program Files\Java\jdk8u432-b06\bin;%systempath%" /M
    
    echo.
    echo [SUCESSO] Java 8 instalado e configurado!
    echo.
    echo Feche e reabra o terminal, depois execute: java -version
    echo.
) else (
    echo.
    echo [ERRO] Falha ao copiar JDK 8 (Codigo: %ERRORLEVEL%)
    echo.
)

pause
