@echo off
cls
echo ============================================================
echo   STARTING SERVER WITH DELIVERY DASHBOARD FIXES
echo ============================================================
echo.
echo All fixes have been applied:
echo   [X] JavaScript errors fixed
echo   [X] 403 Forbidden error fixed
echo   [X] Security configuration updated
echo   [X] DeliveryController updated
echo.
echo Starting compilation and server startup...
echo ============================================================
echo.

cd /d "%~dp0"

echo Checking for Java...
java -version
if errorlevel 1 (
    echo ERROR: Java is not installed or not in PATH
    echo Please install Java 21 or higher
    pause
    exit /b 1
)

echo.
echo ============================================================
echo   COMPILING PROJECT (This may take 1-2 minutes)
echo ============================================================
echo.

REM Check if Maven wrapper exists
if exist "mvnw.cmd" (
    echo Using Maven wrapper...
    call mvnw.cmd clean compile
    if errorlevel 1 (
        echo.
        echo ERROR: Compilation failed!
        echo Please check the error messages above.
        pause
        exit /b 1
    )
) else (
    echo ERROR: Maven wrapper not found!
    echo Please use IntelliJ IDEA to run the project:
    echo   1. Open IntelliJ IDEA
    echo   2. Open this project
    echo   3. Find: SparePartsManagementApplication.java
    echo   4. Right-click and select "Run"
    pause
    exit /b 1
)

echo.
echo ============================================================
echo   STARTING SPRING BOOT SERVER
echo ============================================================
echo.
echo Server is starting...
echo Wait for "Started SparePartsManagementApplication" message
echo Then open browser: http://localhost:8080
echo.

call mvnw.cmd spring-boot:run

pause

