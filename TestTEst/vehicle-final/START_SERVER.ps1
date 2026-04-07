# Spring Boot Server Startup Script
# This script handles the Maven wrapper path issues and starts the server

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Vehicle Spare Parts Management System" -ForegroundColor Cyan
Write-Host "  Spring Boot 3.4.1 Server Startup" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Get the script directory
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

Write-Host "[INFO] Current directory: $scriptPath" -ForegroundColor Yellow
Write-Host ""

# Check if mvnw.cmd exists
if (Test-Path "mvnw.cmd") {
    Write-Host "[OK] Maven wrapper found!" -ForegroundColor Green
} else {
    Write-Host "[ERROR] Maven wrapper not found!" -ForegroundColor Red
    Write-Host "Please run this script from the project root directory." -ForegroundColor Red
    pause
    exit 1
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Starting Spring Boot Application..." -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Run Maven Spring Boot
& cmd.exe /c "mvnw.cmd spring-boot:run"

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "[ERROR] Server failed to start!" -ForegroundColor Red
    Write-Host "Check the error messages above for details." -ForegroundColor Yellow
    Write-Host ""
    pause
    exit 1
}
