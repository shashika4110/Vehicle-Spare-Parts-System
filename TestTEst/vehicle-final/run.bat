@echo off
echo ========================================
echo  Starting Vehicle Spare Parts System
echo ========================================
echo.
echo Checking Java...
java -version
echo.
echo Starting application...
echo Please wait...
echo.

cd /d "%~dp0"

REM Try to find Maven in common locations
set "MAVEN_HOME="
if exist "%ProgramFiles%\Apache\maven\bin\mvn.cmd" (
    set "MAVEN_HOME=%ProgramFiles%\Apache\maven"
)
if exist "%ProgramFiles(x86)%\Apache\maven\bin\mvn.cmd" (
    set "MAVEN_HOME=%ProgramFiles(x86)%\Apache\maven"
)

if defined MAVEN_HOME (
    echo Maven found at: %MAVEN_HOME%
    "%MAVEN_HOME%\bin\mvn.cmd" spring-boot:run
) else (
    echo.
    echo ========================================
    echo  Maven not installed!
    echo ========================================
    echo.
    echo Please use one of these methods:
    echo.
    echo METHOD 1 - VS Code ^(EASIEST^):
    echo   1. Open this project in VS Code
    echo   2. Press Ctrl+Shift+P
    echo   3. Type: "Java: Run Spring Boot App"
    echo   4. Or just press F5
    echo.
    echo METHOD 2 - IntelliJ IDEA:
    echo   1. Open project in IntelliJ
    echo   2. Right-click SparePartsManagementApplication.java
    echo   3. Click "Run"
    echo.
    echo METHOD 3 - Install Maven:
    echo   Download from: https://maven.apache.org/download.cgi
    echo.
    pause
)
