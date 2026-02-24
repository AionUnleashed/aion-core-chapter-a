@echo off
echo ============================================
echo   DIAGNÓSTICO COMPLETO - CHAT SERVER
echo ============================================
echo.

cd AC-Chat\libs

echo [1] Verificando Guava em libs...
if exist guava-31.1-jre.jar (
    echo    OK - Guava encontrado
    for %%F in (guava-31.1-jre.jar) do echo    Tamanho: %%~zF bytes
) else (
    echo    ERRO - Guava NAO encontrado!
    pause
    exit /b 1
)

echo.
echo [2] Listando conteudo do Guava JAR...
echo.
"C:\Program Files\Java\jdk-1.8\bin\jar" -tf guava-31.1-jre.jar | findstr /C:"MoreExecutors" > ..\..\guava_classes.txt

if exist ..\..\guava_classes.txt (
    echo Classes MoreExecutors encontradas:
    type ..\..\guava_classes.txt
    echo.
) else (
    echo ERRO: MoreExecutors NAO encontrado no JAR!
)

cd ..\..

echo.
echo [3] Comparando Guava de libs com Maven...
echo.

set MAVEN_GUAVA=%USERPROFILE%\.m2\repository\com\google\guava\guava\31.1-jre\guava-31.1-jre.jar
set LIBS_GUAVA=AC-Chat\libs\guava-31.1-jre.jar

if exist "%MAVEN_GUAVA%" (
    for %%F in ("%MAVEN_GUAVA%") do echo Maven: %%~zF bytes
) else (
    echo Maven: NAO encontrado
)

if exist "%LIBS_GUAVA%" (
    for %%F in ("%LIBS_GUAVA%") do echo Libs : %%~zF bytes
) else (
    echo Libs: NAO encontrado
)

echo.
echo [4] Testando Chat Server...
echo.

cd AC-Chat

"C:\Program Files\Java\jdk-1.8\bin\java.exe" -Xms128m -Xmx256m -server -cp "build/classes;build/AC-Chat.jar;../AC-Commons/target/classes;../AC-Commons/target/ac-commons-4.7.5.jar;libs/*" com.aionemu.chatserver.ChatServer > ..\chat_test_output.txt 2>&1

echo Output salvo em: chat_test_output.txt
echo.
echo Ultimas 15 linhas do output:
type ..\chat_test_output.txt | more +30

cd ..

echo.
echo ============================================
echo   DIAGNÓSTICO CONCLUÍDO
echo ============================================
pause
