@echo off
echo ========================================
echo FIX ADMIN ACCESS - Quick Setup
echo ========================================
echo.

echo This script will fix the admin user access issue
echo by running the SQL fix script.
echo.

echo Database: vehicle_spareparts_db
echo Username: root
echo Password: Python@2003
echo.

pause

echo.
echo Running SQL fix script...
echo.

mysql -u root -pPython@2003 vehicle_spareparts_db < fix_admin_access.sql

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo SUCCESS! Admin user fixed!
    echo ========================================
    echo.
    echo Now try:
    echo 1. Go to: http://localhost:8080/login.html
    echo 2. Username: admin
    echo 3. Password: password123
    echo 4. Then access: http://localhost:8080/admin-users.html
    echo.
) else (
    echo.
    echo ========================================
    echo ERROR! Something went wrong.
    echo ========================================
    echo.
    echo Possible issues:
    echo - MySQL not in PATH
    echo - Wrong database credentials
    echo - Database not running
    echo.
    echo Try running the SQL manually:
    echo 1. Open MySQL Workbench or command line
    echo 2. Connect to vehicle_spareparts_db
    echo 3. Run fix_admin_access.sql
    echo.
)

pause
