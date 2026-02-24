#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Fix Predicate references in MySQL DAO scripts for Java 8 compatibility
.DESCRIPTION
    Changes Guava Predicate.apply() to use fully-qualified names to avoid conflicts with Java 8's java.util.function.Predicate
#>

$ErrorActionPreference = "Stop"

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Fixing Predicate in DAO scripts" -ForegroundColor Yellow
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$DaoPath = "C:\Workspace\AION CORE 4.7.5\AC-Game\data\scripts\system\database\mysql5"
$Files = Get-ChildItem "$DaoPath\*.java" -File

$TotalFixed = 0

foreach ($File in $Files) {
    $Content = Get-Content $File.FullName -Raw
    $OriginalContent = $Content
    
    # Replace anonymous Predicate<Item> with fully-qualified Guava version
    $Content = $Content -replace 'private static final Predicate<Item>', 'private static final com.google.common.base.Predicate<Item>'
    $Content = $Content -replace 'private static final Predicate<', 'private static final com.google.common.base.Predicate<'
    $Content = $Content -replace 'new Predicate<', 'new com.google.common.base.Predicate<'
    
    if ($Content -ne $OriginalContent) {
        Set-Content $File.FullName -Value $Content -NoNewline
        Write-Host "[FIXED] $($File.Name)" -ForegroundColor Green
        $TotalFixed++
    }
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Fixed $TotalFixed files" -ForegroundColor Green
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
