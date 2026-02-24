#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Configure Java 8u471 environment
.DESCRIPTION
    Sets JAVA_HOME and PATH for JDK 8u471 installed in C:\Program Files\Java\jdk-1.8
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Configurando JDK 8u471" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set JAVA_HOME to JDK 8u471
$env:JAVA_HOME = "C:\Program Files\Java\jdk-1.8"
Write-Host "[✓] JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Green

# Update PATH to prioritize JDK 8u471
$JavaBin = "$env:JAVA_HOME\bin"
$PathParts = $env:PATH -split ";"
$NewPath = @($JavaBin) + ($PathParts | Where-Object { $_ -notlike "*Java*" -and $_ -ne $JavaBin })
$env:PATH = $NewPath -join ";"
Write-Host "[✓] PATH atualizado (JDK 8u471 priorizado)" -ForegroundColor Green

# Set Maven home
if (Test-Path "C:\apache-maven-3.6.3") {
    $env:M2_HOME = "C:\apache-maven-3.6.3"
    $env:PATH = "$env:M2_HOME\bin;$env:PATH"
    Write-Host "[✓] M2_HOME: $env:M2_HOME" -ForegroundColor Green
}

Write-Host ""
Write-Host "[TESTANDO]" -ForegroundColor Yellow
& java -version 2>&1 | Select-Object -First 3 | ForEach-Object { Write-Host "  $_" -ForegroundColor Gray }

Write-Host ""
Write-Host "[✓] JDK 8u471 configurado com sucesso!" -ForegroundColor Green
Write-Host ""
Write-Host "[IMPORTANTE]" -ForegroundColor Yellow
Write-Host "  - Esta configuracao vale APENAS para este terminal" -ForegroundColor Gray
Write-Host "  - Maven agora usara JDK 8u471 via JAVA_HOME" -ForegroundColor Gray
Write-Host ""
