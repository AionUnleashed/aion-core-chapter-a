# Script de Verificação e Setup - Fase 1
# Verifica instalação de JDK 8 e Maven, e auxilia na configuração

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Aion Core - Fase 1: Java 8 + Maven  " -ForegroundColor Cyan
Write-Host "  Verificação de Ambiente              " -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Função para verificar se comando existe
function Test-Command {
    param($Command)
    try {
        if (Get-Command $Command -ErrorAction Stop) {
            return $true
        }
    }
    catch {
        return $false
    }
}

# Verificar Java
Write-Host "[1/3] Verificando Java..." -ForegroundColor Yellow
if (Test-Command "java") {
    $javaVersion = java -version 2>&1 | Select-String "version" | ForEach-Object { $_ -replace '.*"(.+)".*', '$1' }
    Write-Host "  ✓ Java encontrado: $javaVersion" -ForegroundColor Green
    
    if ($javaVersion -like "1.8.*") {
        Write-Host "  ✓ Java 8 instalado corretamente!" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Java encontrado, mas não é versão 8" -ForegroundColor Yellow
        Write-Host "    Versão atual: $javaVersion" -ForegroundColor Yellow
        Write-Host "    Precisa instalar Java 8" -ForegroundColor Yellow
    }
    
    if ($env:JAVA_HOME) {
        Write-Host "  ✓ JAVA_HOME configurado: $env:JAVA_HOME" -ForegroundColor Green
    } else {
        Write-Host "  ✗ JAVA_HOME não configurado" -ForegroundColor Red
        Write-Host "    Execute: [System.Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Eclipse Adoptium\jdk-8.0.392.8-hotspot', 'Machine')" -ForegroundColor Yellow
    }
} else {
    Write-Host "  ✗ Java NÃO encontrado" -ForegroundColor Red
    Write-Host "    Download: https://adoptium.net/temurin/releases/?version=8" -ForegroundColor Yellow
}

Write-Host ""

# Verificar Maven
Write-Host "[2/3] Verificando Maven..." -ForegroundColor Yellow
if (Test-Command "mvn") {
    $mavenVersion = mvn --version 2>&1 | Select-String "Apache Maven" | ForEach-Object { $_.Line }
    Write-Host "  ✓ Maven encontrado: $mavenVersion" -ForegroundColor Green
    
    if ($env:M2_HOME) {
        Write-Host "  ✓ M2_HOME configurado: $env:M2_HOME" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ M2_HOME não configurado (opcional)" -ForegroundColor Yellow
    }
} else {
    Write-Host "  ✗ Maven NÃO encontrado" -ForegroundColor Red
    Write-Host "    Download: https://archive.apache.org/dist/maven/maven-3/3.8.8/binaries/apache-maven-3.8.8-bin.zip" -ForegroundColor Yellow
    Write-Host "    Extrair para: C:\apache-maven-3.8.8\" -ForegroundColor Yellow
    Write-Host "    Adicionar ao PATH: C:\apache-maven-3.8.8\bin" -ForegroundColor Yellow
}

Write-Host ""

# Verificar estrutura Maven
Write-Host "[3/3] Verificando estrutura Maven do projeto..." -ForegroundColor Yellow
$pomFiles = @(
    "pom.xml",
    "AC-Commons\pom.xml",
    "AC-Login\pom.xml",
    "AC-Game\pom.xml",
    "AC-Chat\pom.xml"
)

$allPomsExist = $true
foreach ($pom in $pomFiles) {
    if (Test-Path $pom) {
        Write-Host "  ✓ $pom" -ForegroundColor Green
    } else {
        Write-Host "  ✗ $pom não encontrado" -ForegroundColor Red
        $allPomsExist = $false
    }
}

if ($allPomsExist) {
    Write-Host "  ✓ Todos os POMs criados!" -ForegroundColor Green
} else {
    Write-Host "  ✗ Alguns POMs estão faltando" -ForegroundColor Red
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Resumo" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$javaOk = Test-Command "java"
$mavenOk = Test-Command "mvn"
$pomsOk = $allPomsExist

if ($javaOk -and $mavenOk -and $pomsOk) {
    Write-Host "✓ Ambiente pronto para build!" -ForegroundColor Green
    Write-Host ""
    Write-Host "Próximos passos:" -ForegroundColor Cyan
    Write-Host "  1. mvn validate           # Validar POMs" -ForegroundColor White
    Write-Host "  2. mvn clean install      # Build completo" -ForegroundColor White
    Write-Host "  3. Refatorar código conforme plano" -ForegroundColor White
} else {
    Write-Host "✗ Ambiente incompleto" -ForegroundColor Red
    Write-Host ""
    Write-Host "Pendências:" -ForegroundColor Yellow
    
    if (-not $javaOk) {
        Write-Host "  - Instalar Java 8 (JDK)" -ForegroundColor White
        Write-Host "    Link: https://adoptium.net/temurin/releases/?version=8" -ForegroundColor Gray
    }
    
    if (-not $mavenOk) {
        Write-Host "  - Instalar Maven 3.8.8" -ForegroundColor White
        Write-Host "    Link: https://archive.apache.org/dist/maven/maven-3/3.8.8/binaries/" -ForegroundColor Gray
    }
    
    if (-not $pomsOk) {
        Write-Host "  - Verificar POMs criados" -ForegroundColor White
    }
    
    Write-Host ""
    Write-Host "Consulte: docs\INSTALL_JAVA8_MAVEN.md" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "Pressione qualquer tecla para continuar..." -ForegroundColor Gray
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
