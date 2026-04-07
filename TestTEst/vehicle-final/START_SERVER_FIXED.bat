@echo off
cls
echo ========================================
echo   Vehicle Spare Parts Management System
echo   Spring Boot 3.4.1 Server
echo ========================================
echo.

cd /d "%~dp0"

echo [INFO] Checking Maven wrapper...
if not exist "mvnw.cmd" (
    echo [ERROR] Maven wrapper not found!
    echo Please run this script from the project root.
    pause
    exit /b 1
)

echo [OK] Maven wrapper found!
echo.
echo ========================================
echo   Starting Spring Boot Application...
echo ========================================
echo.
echo Server will start on: http://localhost:8080
echo.
echo Press Ctrl+C to stop the server
echo.

call mvnw.cmd spring-boot:run

if errorlevel 1 (
    echo.
    echo ========================================
    echo   SERVER FAILED TO START!
    echo ========================================
    echo.
    echo Check the error messages above.
    echo Common issues:
    echo   - Port 8080 already in use
    echo   - Database not running
    echo   - Configuration errors
    echo.
    pause
    exit /b 1
)
