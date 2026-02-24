# Script para migrar imports de commons-lang para commons-lang3
# Aion Core - Fase 1: Java 8

Write-Host "==================================" -ForegroundColor Cyan
Write-Host " Migrando commons-lang → commons-lang3" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host ""

$modules = @("AC-Commons", "AC-Login", "AC-Game", "AC-Chat")
$totalFiles = 0
$totalReplacements = 0

foreach ($module in $modules) {
    $srcPath = ".\$module\src"
    
    if (!(Test-Path $srcPath)) {
        Write-Host "[SKIP] $module - diretório src não encontrado" -ForegroundColor Yellow
        continue
    }
    
    Write-Host "[PROCESSANDO] $module..." -ForegroundColor Green
    
    # Buscar todos os arquivos .java
    $javaFiles = Get-ChildItem -Path $srcPath -Filter "*.java" -Recurse
    $moduleFiles = 0
    $moduleReplacements = 0
    
    foreach ($file in $javaFiles) {
        $content = Get-Content $file.FullName -Raw -Encoding UTF8
        $originalContent = $content
        
        # Substituições:
        # 1. org.apache.commons.lang. → org.apache.commons.lang3.
        $content = $content -replace 'import org\.apache\.commons\.lang\.', 'import org.apache.commons.lang3.'
        
        if ($content -ne $originalContent) {
            # Salvar arquivo modificado
            Set-Content -Path $file.FullName -Value $content -Encoding UTF8 -NoNewline
            $moduleFiles++
            
            # Contar quantas substituições foram feitas
            $replacements = ([regex]::Matches($content, 'import org\.apache\.commons\.lang3\.')).Count
            $moduleReplacements += $replacements
            
            $relativePath = $file.FullName.Replace((Get-Location).Path + "\", "")
            Write-Host "  ✓ $relativePath ($replacements imports)" -ForegroundColor Gray
        }
    }
    
    Write-Host "  → $moduleFiles arquivos modificados ($moduleReplacements imports)" -ForegroundColor Cyan
    $totalFiles += $moduleFiles
    $totalReplacements += $moduleReplacements
Write-Host ""
}

Write-Host "==================================" -ForegroundColor Cyan
Write-Host " RESUMO" -ForegroundColor Cyan
Write-Host "==================================" -ForegroundColor Cyan
Write-Host "Arquivos modificados: $totalFiles" -ForegroundColor Green
Write-Host "Imports atualizados: $totalReplacements" -ForegroundColor Green
Write-Host ""
Write-Host "Próximo passo: mvn clean compile -DskipTests" -ForegroundColor Yellow
