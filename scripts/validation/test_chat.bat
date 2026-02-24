@echo off
cd AC-Chat

echo Testando Chat Server...
echo.

"C:\Program Files\Java\jdk-1.8\bin\java.exe" -Xms128m -Xmx256m -server -cp "build/classes;build/AC-Chat.jar;../AC-Commons/target/classes;../AC-Commons/target/ac-commons-4.7.5.jar;libs/*" com.aionemu.chatserver.ChatServer > test_chat_output.txt 2>&1

echo.
echo Output salvo em AC-Chat\test_chat_output.txt
echo.
pause
