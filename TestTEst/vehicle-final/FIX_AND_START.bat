@echo off
cls
color 0A
echo.
echo ============================================================
echo          FIXING 403 ERROR - STARTING SERVER
echo ============================================================
echo.
echo Status: All code fixes are ready!
echo Action: Starting server with fixed code...
echo.
echo ============================================================
echo.

cd /d "%~dp0"

echo [1/3] Checking Java installation...
java -version 2>nul
if errorlevel 1 (
    color 0C
    echo.
    echo ERROR: Java is not installed!
    echo Please install Java 17 or higher from: https://adoptium.net/
    echo.
    pause
    exit /b 1
)
echo      Java found! [OK]
echo.

echo [2/3] Looking for IntelliJ IDEA project...
if exist ".idea\" (
    echo      IntelliJ project detected! [OK]
    echo.
    echo ============================================================
    echo   PLEASE USE INTELLIJ IDEA TO START THE SERVER
    echo ============================================================
    echo.
    echo Steps:
    echo   1. Open IntelliJ IDEA
    echo   2. Open this project folder
    echo   3. Find: SparePartsManagementApplication.java
    echo      Location: src/main/java/com/vehicle/spareparts/
    echo   4. Right-click the file
    echo   5. Select: "Run 'SparePartsManagementApplication.main()'"
    echo   6. Wait for: "Started SparePartsManagementApplication"
    echo.
    echo After the server starts:
    echo   - Press F12 in your browser
    echo   - Type: localStorage.clear()
    echo   - Press F5 to refresh
    echo   - Login again: delivery1 / password123
    echo.
    echo The 403 error will be GONE!
    echo.
    pause
    exit /b 0
)

echo [3/3] Trying to start with Java directly...
echo.

REM Check if classes are compiled
if not exist "target\classes\com\vehicle\spareparts\SparePartsManagementApplication.class" (
    echo Classes not found. Attempting to compile...
    echo.

    if exist "mvnw.cmd" (
        echo Compiling with Maven...
        call mvnw.cmd clean compile
        if errorlevel 1 (
            color 0C
            echo.
            echo Compilation failed!
            echo Please use IntelliJ IDEA instead.
            echo.
            pause
            exit /b 1
        )
    ) else (
        color 0C
        echo.
        echo Cannot compile - Maven wrapper not found.
        echo.
        echo SOLUTION: Use IntelliJ IDEA
        echo   1. Open IntelliJ IDEA
        echo   2. Open this project
        echo   3. Run SparePartsManagementApplication.java
        echo.
        pause
        exit /b 1
    )
)

echo.
echo ============================================================
echo   STARTING SPRING BOOT SERVER
echo ============================================================
echo.
echo Wait for the message: "Started SparePartsManagementApplication"
echo Then open: http://localhost:8080/delivery-dashboard.html
echo.
echo Press Ctrl+C to stop the server
echo.
echo ============================================================
echo.

if exist "mvnw.cmd" (
    call mvnw.cmd spring-boot:run
) else (
    color 0C
    echo Maven wrapper not found!
    echo Please use IntelliJ IDEA to run the project.
    pause
)

