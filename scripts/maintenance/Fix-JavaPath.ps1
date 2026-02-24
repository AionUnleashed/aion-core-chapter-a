# =============================================================================
# Fix-JavaPath.ps1
# Script para corrigir PATH e forçar Java 8 no terminal atual
# =============================================================================

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Corrigindo PATH para Java 8" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Problema diagnosticado
Write-Host "[DIAGNOSTICO]" -ForegroundColor Yellow
Write-Host "  Problema: C:\Windows\System32\java.exe (Java 7) esta no PATH antes do Java 8"
Write-Host "  Causa: Instalador do Java 7 copiou java.exe para System32"
Write-Host "  Solucao: Priorizar C:\Java\jdk8u432-b06\bin no PATH desta sessao"
Write-Host ""

# Configurar variáveis de ambiente para a sessão atual
$env:JAVA_HOME = "C:\Java\jdk8u432-b06"
$env:M2_HOME = "C:\apache-maven-3.6.3"

# Reconstruir PATH priorizando Java 8
$userPath = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
$machinePath = [System.Environment]::GetEnvironmentVariable('PATH', 'Machine')

# Remover referencias antigas do PATH combinado
$combinedPath = "$userPath;$machinePath"
$cleanPath = ($combinedPath -split ';' | Where-Object { 
    $_ -ne "" -and 
    $_ -notlike "*jdk1.7*" -and 
    $_ -notlike "*jre7*"
}) -join ';'

# Adicionar Java 8 e Maven no INICIO
$env:PATH = "C:\Java\jdk8u432-b06\bin;C:\apache-maven-3.6.3\bin;$cleanPath"

Write-Host "[CONFIGURADO]" -ForegroundColor Green
Write-Host "  JAVA_HOME: $env:JAVA_HOME" -ForegroundColor Gray
Write-Host "  M2_HOME: $env:M2_HOME" -ForegroundColor Gray
Write-Host "  PATH: Java 8 priorizado" -ForegroundColor Gray
Write-Host ""

# Criar aliases para garantir
Set-Alias -Name java8 -Value "C:\Java\jdk8u432-b06\bin\java.exe" -Scope Global
Set-Alias -Name javac8 -Value "C:\Java\jdk8u432-b06\bin\javac.exe" -Scope Global

Write-Host "[TESTANDO]" -ForegroundColor Cyan
& "C:\Java\jdk8u432-b06\bin\java.exe" -version
Write-Host ""

Write-Host "[IMPORTANTE]" -ForegroundColor Yellow
Write-Host "  - Esta configuracao vale APENAS para este terminal" -ForegroundColor Yellow
Write-Host "  - Maven JA esta usando Java 8 corretamente (via JAVA_HOME)" -ForegroundColor Green
Write-Host "  - Para usar Java 8 em outros terminais, execute este script novamente" -ForegroundColor Yellow
Write-Host "  - OU use 'java8' como comando em vez de 'java'" -ForegroundColor Cyan
Write-Host ""

Write-Host "[PROXIMO PASSO]" -ForegroundColor Green
Write-Host "  Execute: mvn clean install -DskipTests" -ForegroundColor White
Write-Host ""

# Retornar ao diretório do projeto
Set-Location "C:\Workspace\AION CORE 4.7.5"
