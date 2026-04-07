@echo off
cls
color 0A
echo ========================================
echo   SPRING BOOT 3.4.1 - SERVER DIAGNOSTIC
echo ========================================
echo.

cd /d "%~dp0"

echo [STEP 1] Checking Project Structure...
if not exist "pom.xml" (
    echo [X] ERROR: pom.xml not found!
    goto :error
)
echo [OK] pom.xml found

if not exist "src\main\java" (
    echo [X] ERROR: src\main\java folder not found!
    goto :error
)
echo [OK] Source folder found

if not exist "mvnw.cmd" (
    echo [X] ERROR: Maven wrapper not found!
    goto :error
)
echo [OK] Maven wrapper found

echo.
echo [STEP 2] Checking Java Version...
java -version 2>&1 | findstr /C:"21" >nul
if errorlevel 1 (
    echo [WARNING] Java 21 may not be installed or not in PATH
    java -version
) else (
    echo [OK] Java 21 detected
)

echo.
echo [STEP 3] Checking MySQL Connection...
echo Testing database: vehicle_spareparts_db
echo.

echo.
echo [STEP 4] Checking Port 8080...
netstat -ano | findstr ":8080" >nul
if not errorlevel 1 (
    echo [WARNING] Port 8080 is already in use!
    echo.
    echo Running processes on port 8080:
    netstat -ano | findstr ":8080"
    echo.
    echo Do you want to kill the process and continue? (Y/N)
    choice /C YN /N
    if errorlevel 2 goto :skipkill
    for /f "tokens=5" %%a in ('netstat -ano ^| findstr ":8080" ^| findstr "LISTENING"') do (
        echo Killing process ID: %%a
        taskkill /PID %%a /F
    )
    :skipkill
) else (
    echo [OK] Port 8080 is available
)

echo.
echo ========================================
echo   STARTING SPRING BOOT SERVER
echo ========================================
echo.
echo Server URL: http://localhost:8080
echo API Base: http://localhost:8080/api
echo.
echo Press Ctrl+C to stop the server
echo.
echo ----------------------------------------
echo.

call mvnw.cmd spring-boot:run

if errorlevel 1 goto :error

echo.
echo ========================================
echo   SERVER STOPPED
echo ========================================
pause
exit /b 0

:error
echo.
color 0C
echo ========================================
echo   ERROR DETECTED!
echo ========================================
echo.
echo Common Solutions:
echo   1. Ensure MySQL is running
echo   2. Check database credentials in application.properties
echo   3. Verify Java 21 is installed
echo   4. Close other applications using port 8080
echo   5. Run: mvnw.cmd clean install
echo.
pause
exit /b 1
