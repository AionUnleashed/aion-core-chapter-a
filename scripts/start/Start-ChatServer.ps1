#!/usr/bin/env pwsh
# Start-ChatServer.ps1
# Inicia o Chat Server do AION Core 4.7.5 com Maven build

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " AION Core 4.7.5 - Chat Server" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Verificar JAVA_HOME
if (-not $env:JAVA_HOME) {
    Write-Host "[!] JAVA_HOME não configurado. Execute Setup-Java8u471.ps1 primeiro." -ForegroundColor Yellow
    Write-Host "    Executando agora...`n" -ForegroundColor Yellow
    & "$PSScriptRoot\..\setup\Setup-Java8u471.ps1"
}

# Caminho do AC-Chat
$ChatPath = Join-Path $PSScriptRoot "..\..\AC-Chat"
Push-Location $ChatPath

# Verificar se JAR foi compilado (usa build/ do Ant, não target/ do Maven)
# Nota: AC-Chat ainda não migrado para Maven (código usa Netty 3)
$JarPath = "build\AC-Chat.jar"
if (-not (Test-Path $JarPath)) {
    Write-Host "[X] AC-Chat JAR não encontrado em build/!" -ForegroundColor Red
    Write-Host "    Execute: AC-Chat\build_chatserver.bat primeiro" -ForegroundColor Yellow
    Write-Host "    (Migração Maven pendente: código usa Netty 3)" -ForegroundColor Gray
    Pop-Location
    exit 1
}

# Verificar AC-Commons
$CommonsJar = Join-Path $PSScriptRoot "..\..\AC-Commons\target\ac-commons-4.7.5.jar"
if (-not (Test-Path $CommonsJar)) {
    Write-Host "[X] AC-Commons JAR não encontrado!" -ForegroundColor Red
    Write-Host "    Compile AC-Commons primeiro." -ForegroundColor Yellow
    Pop-Location
    exit 1
}

Write-Host "[✓] Memoria: 128 MB min, 256 MB max" -ForegroundColor Gray
Write-Host "[✓] Porta clientes: 10241" -ForegroundColor Gray
Write-Host "[✓] Porta Game Server: 9021" -ForegroundColor Gray
Write-Host ""

# Classpath (usa build/ folder - Ant)
$ClassPath = @(
    ".\build\classes"
    ".\build\AC-Chat.jar"
    "..\AC-Commons\target\classes"
    "..\AC-Commons\target\ac-commons-4.7.5.jar"
    ".\libs\*"
) -join [IO.Path]::PathSeparator

# Java args
$JavaArgs = @(
    "-Xms128m"
    "-Xmx256m"
    "-server"
    "-cp"
    $ClassPath
    "com.aionemu.chatserver.ChatServer"
)

Write-Host "Iniciando Chat Server...`n" -ForegroundColor Green

# Iniciar servidor
& "$env:JAVA_HOME\bin\java.exe" @JavaArgs

Pop-Location
