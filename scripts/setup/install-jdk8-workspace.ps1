# Instala JDK 8 no Workspace (nao requer admin)
# Alternativa para quando nao tem permissoes de administrador

Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Instalando JDK 8 em C:\Java\" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$targetDir = "C:\Java\jdk8u432-b06"
$sourceDir = "$env:USERPROFILE\Desktop\jdk8-temp\jdk8u432-b06"

if (!(Test-Path $sourceDir)) {
    Write-Host "[ERRO] Diretorio fonte nao encontrado: $sourceDir" -ForegroundColor Red
    Write-Host "Execute primeiro a extracao do ZIP" -ForegroundColor Yellow
    exit 1
}

Write-Host "[1/4] Criando diretorio C:\Java..." -ForegroundColor Yellow
New-Item -ItemType Directory -Path "C:\Java" -Force -ErrorAction SilentlyContinue | Out-Null

Write-Host "[2/4] Copiando JDK 8 (pode demorar 1-2 minutos)..." -ForegroundColor Yellow
Copy-Item -Path $sourceDir -Destination $targetDir -Recurse -Force

if (Test-Path "$targetDir\bin\java.exe") {
    Write-Host "[3/4] Configurando JAVA_HOME..." -ForegroundColor Yellow
    [System.Environment]::SetEnvironmentVariable('JAVA_HOME', $targetDir, 'User')
    $env:JAVA_HOME = $targetDir
    
    Write-Host "[4/4] Atualizando PATH..." -ForegroundColor Yellow
    $currentPath = [System.Environment]::GetEnvironmentVariable('PATH', 'User')
    
    # Remove referencias antigas
    $currentPath = $currentPath -replace 'C:\\Program Files\\Java\\jdk1\.7\.0_79\\bin;', ''
    $currentPath = $currentPath -replace 'C:\\Workspace\\Java\\jdk8u432-b06\\bin;', ''
    
    # Adiciona novo path no inicio
    $newPath = "$targetDir\bin;$currentPath"
    [System.Environment]::SetEnvironmentVariable('PATH', $newPath, 'User')
    $env:PATH = "$targetDir\bin;$env:PATH"
    
    Write-Host ""
    Write-Host "[SUCESSO] JDK 8 instalado em: $targetDir" -ForegroundColor Green
    Write-Host ""
    Write-Host "Testando..." -ForegroundColor Cyan
    & "$targetDir\bin\java.exe" -version
    
    Write-Host ""
    Write-Host "Para o sistema reconhecer, recarregue o terminal ou execute:" -ForegroundColor Yellow
    Write-Host '  $env:PATH = [System.Environment]::GetEnvironmentVariable("PATH", "User") + ";" + [System.Environment]::GetEnvironmentVariable("PATH", "Machine")' -ForegroundColor Gray
    
} else {
    Write-Host ""
    Write-Host "[ERRO] Instalacao falhou!" -ForegroundColor Red
}

Write-Host ""
Write-Host "Limpando arquivos temporarios..." -ForegroundColor Yellow
Remove-Item "$env:USERPROFILE\Desktop\jdk8-temp" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "Concluido!" -ForegroundColor Green
