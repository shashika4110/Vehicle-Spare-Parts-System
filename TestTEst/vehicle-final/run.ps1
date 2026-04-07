# PowerShell script to run Vehicle Spare Parts Management System
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Starting Vehicle Spare Parts System" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$projectDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $projectDir

Write-Host "Checking Java..." -ForegroundColor Yellow
java -version
Write-Host ""

Write-Host "Checking if compiled..." -ForegroundColor Yellow
$mainClass = "target\classes\com\vehicle\spareparts\SparePartsManagementApplication.class"
if (Test-Path $mainClass) {
    Write-Host "✓ Project is compiled" -ForegroundColor Green
} else {
    Write-Host "✗ Project needs to be compiled first" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please compile in VS Code:" -ForegroundColor Yellow
    Write-Host "  1. Right-click pom.xml" -ForegroundColor White
    Write-Host "  2. Select 'Maven' > 'Reload Project'" -ForegroundColor White
    Write-Host "  3. Wait for build to complete" -ForegroundColor White
    Write-Host ""
    pause
    exit
}

Write-Host ""
Write-Host "Starting Spring Boot Application..." -ForegroundColor Yellow
Write-Host "Please wait, this may take 30-60 seconds..." -ForegroundColor Yellow
Write-Host ""
Write-Host "Once started, open browser at: http://localhost:8080" -ForegroundColor Green
Write-Host ""
Write-Host "Press Ctrl+C to stop the application" -ForegroundColor Red
Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan

# Get all JAR files from Maven local repository
$mavenRepo = "$env:USERPROFILE\.m2\repository"

# Build classpath
$classpath = "target\classes"

# Run using Spring Boot's main class
$env:JAVA_OPTS = "-Dspring.profiles.active=dev"

try {
    # Use Spring Boot Maven plugin approach by finding the built JAR
    if (Test-Path "target\spareparts-management-1.0.0.jar") {
        Write-Host "Running from JAR file..." -ForegroundColor Green
        java -jar target\spareparts-management-1.0.0.jar
    } else {
        Write-Host "========================================" -ForegroundColor Red
        Write-Host " JAR file not found!" -ForegroundColor Red
        Write-Host "========================================" -ForegroundColor Red
        Write-Host ""
        Write-Host "The project needs to be packaged first." -ForegroundColor Yellow
        Write-Host ""
        Write-Host "PLEASE USE VS CODE TO RUN:" -ForegroundColor Cyan
        Write-Host ""
        Write-Host "Option 1 - Press F5:" -ForegroundColor White
        Write-Host "  Just press F5 in VS Code" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Option 2 - Use Maven Panel:" -ForegroundColor White
        Write-Host "  1. Open Maven panel (left sidebar)" -ForegroundColor Gray
        Write-Host "  2. Expand 'spareparts-management'" -ForegroundColor Gray
        Write-Host "  3. Expand 'Plugins' > 'spring-boot'" -ForegroundColor Gray
        Write-Host "  4. Double-click 'spring-boot:run'" -ForegroundColor Gray
        Write-Host ""
        Write-Host "Option 3 - Click Run button:" -ForegroundColor White
        Write-Host "  1. Open SparePartsManagementApplication.java" -ForegroundColor Gray
        Write-Host "  2. Click 'Run' button above main method" -ForegroundColor Gray
        Write-Host ""
    }
} catch {
    Write-Host ""
    Write-Host "Error starting application: $_" -ForegroundColor Red
    Write-Host ""
    Write-Host "Please use VS Code to run (Press F5)" -ForegroundColor Yellow
}

Write-Host ""
pause
