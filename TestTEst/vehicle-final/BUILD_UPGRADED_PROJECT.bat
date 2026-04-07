@echo off
echo ========================================
echo   Spring Boot 3.4.1 Build Script
echo   Building with JJWT 0.12.6
echo ========================================
echo.

cd /d "%~dp0"

echo [1/3] Cleaning previous build...
call mvnw.cmd clean
if errorlevel 1 (
    echo ERROR: Clean failed!
    pause
    exit /b 1
)

echo.
echo [2/3] Compiling with updated dependencies...
call mvnw.cmd compile
if errorlevel 1 (
    echo ERROR: Compilation failed! Check the errors above.
    pause
    exit /b 1
)

echo.
echo [3/3] Packaging application...
call mvnw.cmd package -DskipTests
if errorlevel 1 (
    echo ERROR: Package failed!
    pause
    exit /b 1
)

echo.
echo ========================================
echo   BUILD SUCCESSFUL!
echo ========================================
echo.
echo Your application is ready to run!
echo.
echo To start the server, run:
echo   mvnw.cmd spring-boot:run
echo.
echo Or simply run: START_SERVER_NOW.bat
echo.
pause
