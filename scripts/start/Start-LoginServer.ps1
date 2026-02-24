#!/usr/bin/env pwsh
# Start-LoginServer.ps1
# Inicia o Login Server do AION Core 4.7.5 com Maven build

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host " AION Core 4.7.5 - Login Server" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Verificar JAVA_HOME
if (-not $env:JAVA_HOME) {
    Write-Host "[!] JAVA_HOME não configurado. Execute Setup-Java8u471.ps1 primeiro." -ForegroundColor Yellow
    Write-Host "    Executando agora...`n" -ForegroundColor Yellow
    & "$PSScriptRoot\..\setup\Setup-Java8u471.ps1"
}

# Caminho do AC-Login
$LoginPath = Join-Path $PSScriptRoot "..\..\AC-Login"
Push-Location $LoginPath

# Verificar se JAR foi compilado
$JarPath = "target\ac-login-4.7.5.jar"
if (-not (Test-Path $JarPath)) {
    Write-Host "[X] AC-Login JAR não encontrado em target/!" -ForegroundColor Red
    Write-Host "    Execute: mvn clean package -DskipTests" -ForegroundColor Yellow
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
Write-Host "[✓] Porta login: 2106 (clientes)" -ForegroundColor Gray
Write-Host "[✓] Porta interna: 9014 (Game Server)" -ForegroundColor Gray
Write-Host ""

# Classpath
$ClassPath = @(
    ".\target\classes"
    ".\target\ac-login-4.7.5.jar"
    "..\AC-Commons\target\classes"
    "..\AC-Commons\target\ac-commons-4.7.5.jar"
    ".\target\libs\*"
    ".\libs\*"
) -join [IO.Path]::PathSeparator

# Java args
$JavaArgs = @(
    "-Xms128m"
    "-Xmx256m"
    "-server"
    "-cp"
    $ClassPath
    "com.aionemu.loginserver.LoginServer"
)

Write-Host "Iniciando Login Server...`n" -ForegroundColor Green

# Iniciar servidor
& "$env:JAVA_HOME\bin\java.exe" @JavaArgs

Pop-Location
