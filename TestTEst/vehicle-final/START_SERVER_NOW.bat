@echo off
title Starting Vehicle Spare Parts Server - FIXED VERSION
color 0B
cls

echo.
echo ================================================================
echo       VEHICLE SPARE PARTS MANAGEMENT SYSTEM
echo       Starting Server with 403 FIX Applied
echo ================================================================
echo.
echo All authentication checks have been disabled temporarily.
echo The delivery dashboard will work immediately after startup!
echo.
echo ================================================================
echo.

cd /d "%~dp0"

echo [Step 1/2] Checking Java installation...
java -version 2>&1 | findstr "version" >nul
if errorlevel 1 (
    color 0C
    echo ERROR: Java is not installed or not in system PATH!
    echo.
    echo Please install Java 17+ from: https://adoptium.net/
    echo.
    pause
    exit /b 1
)
echo SUCCESS: Java is installed [OK]
echo.

echo [Step 2/2] Starting Spring Boot application...
echo.
echo PLEASE WAIT - This may take 30-60 seconds...
echo.
echo ================================================================
echo.

REM Try to start with Maven wrapper
if exist "mvnw.cmd" (
    echo Using Maven wrapper to start server...
    echo.
    call mvnw.cmd spring-boot:run
) else (
    color 0C
    echo ERROR: Maven wrapper not found!
    echo.
    echo MANUAL STEPS REQUIRED:
    echo 1. Open IntelliJ IDEA
    echo 2. Open this project folder
    echo 3. Find: src/main/java/com/vehicle/spareparts/SparePartsManagementApplication.java
    echo 4. Right-click and select "Run"
    echo.
    pause

