#!/usr/bin/env pwsh
<#
.SYNOPSIS
    AION Core 4.7.5 - Game Server Launcher (Java 8)
.DESCRIPTION
    Inicia o Game Server com Java 8 e Maven
.NOTES
    Requires: Java 8, Maven 3.6.3, MySQL running with al_server_gs database
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " AION Core 4.7.5 - Game Server" -ForegroundColor Yellow
Write-Host " Java 8 Build" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Change to project root
$ProjectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
Push-Location $ProjectRoot

# Fix Java PATH
Write-Host "[1/4] Configurando Java 8u471..." -ForegroundColor Yellow
$env:JAVA_HOME = "C:\Program Files\Java\jdk-1.8"
$JavaBin = "$env:JAVA_HOME\bin"
$PathParts = $env:PATH -split ";"
$NewPath = @($JavaBin) + ($PathParts | Where-Object { $_ -notlike "*Java*" -and $_ -ne $JavaBin })
$env:PATH = $NewPath -join ";"

# Verify Java version
Write-Host ""
Write-Host "[2/4] Verificando versao do Java..." -ForegroundColor Yellow
$JavaVersion = & java -version 2>&1 | Select-String "version" | Select-Object -First 1
Write-Host "      $JavaVersion" -ForegroundColor Gray

if ($JavaVersion -notmatch "1\.8") {
    Write-Host ""
    Write-Error "ERRO: Java 8 nao encontrado! Execute Fix-JavaPath.ps1 primeiro."
    Pop-Location
    exit 1
}

# Check MySQL
Write-Host ""
Write-Host "[3/4] Verificando MySQL..." -ForegroundColor Yellow
$MysqlService = Get-Service -Name "*mysql*" -ErrorAction SilentlyContinue | Where-Object {$_.Status -eq 'Running'}
if (-not $MysqlService) {
    Write-Warning "      MySQL nao esta rodando!"
    Write-Host "      Inicie o MySQL antes de continuar." -ForegroundColor Red
    Pop-Location
    exit 1
}
Write-Host "      MySQL: $($MysqlService.DisplayName) [Running]" -ForegroundColor Green

# Check database exists
Write-Host ""
Write-Host "      Verificando database al_server_gs..." -ForegroundColor Gray
$DbCheck = & "C:\Program Files\MySQL\MySQL Server 5.7\bin\mysql.exe" -u root -pvertrigo -e "SELECT 1 FROM al_server_gs.players LIMIT 1;" 2>&1
if ($LASTEXITCODE -ne 0) {
    Write-Warning "      Database al_server_gs nao encontrado ou vazio!"
    Write-Host "      Execute scripts\database\setup_database.bat primeiro." -ForegroundColor Red
    Pop-Location
    exit 1
}
Write-Host "      Database: al_server_gs [OK]" -ForegroundColor Green

# Start Game Server
Write-Host ""
Write-Host "[4/4] Iniciando Game Server..." -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Configuracao de Runtime:" -ForegroundColor White
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  JVM Memory: 512 MB min / 4096 MB max"
Write-Host "  Game Port: 7777 (clientes)"
Write-Host "  Database: al_server_gs @ localhost:3306"
Write-Host "  Java: OpenJDK 1.8.0_432 (Temurin)"
Write-Host ""
Write-Host "  ATENCAO: Login Server deve estar rodando!" -ForegroundColor Yellow
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Pressione Ctrl+C para parar o servidor..." -ForegroundColor Gray
Write-Host ""

# Run Game Server from Maven target/classes
Set-Location "$ProjectRoot\AC-Game"

# Build classpath
$MavenLibs = Get-ChildItem "target\libs\*.jar" -ErrorAction SilentlyContinue | ForEach-Object { $_.FullName }
$Libs = Get-ChildItem "libs\*.jar" -Recurse | ForEach-Object { $_.FullName }
$CommonsJar = Get-ChildItem "..\AC-Commons\target\ac-commons-*.jar" -Exclude "*-sources.jar","*-javadoc.jar" | Select-Object -First 1
if (-not $CommonsJar) {
    Write-Error "      AC-Commons JAR not found! Run 'mvn install -pl ac-commons' first."
    Pop-Location
    exit 1
}
$ClassPath = @("target\classes", "..\AC-Commons\target\classes") + $CommonsJar.FullName + $MavenLibs + $Libs -join ";"

Write-Host "      ClassPath: $(($ClassPath -split ';').Count) entries" -ForegroundColor Gray
Write-Host "      JavaAgent: $($CommonsJar.Name)" -ForegroundColor Gray
Write-Host ""

# Start with Java directly
$JavaArgs = @(
    "-Xms512m"
    "-Xmx4096m"
    "-server"
    "-noverify"
    "-javaagent:$($CommonsJar.FullName)"
    "-Dfile.encoding=UTF-8"
    "-Djava.net.preferIPv4Stack=true"
    "-cp"
    $ClassPath
    "com.aionemu.gameserver.GameServer"
)

& "$env:JAVA_HOME\bin\java.exe" $JavaArgs

Write-Host ""
Write-Host "Game Server encerrado." -ForegroundColor Yellow
Pop-Location
