@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +============================================+
echo  ^|   Reset Portainer - Reinitialization       ^|
echo  +============================================+
echo.
echo  This script deletes the Portainer account and
echo  resets the interface (PHP files and database
echo  are NOT deleted).
echo.
set /p confirm="Confirm reset? (Y/N) : "
if /i "%confirm%" neq "Y" (
    echo  Cancelled.
    pause
    exit /b 0
)

echo.
echo  Stopping Portainer...
docker compose stop portainer

echo  Removing Portainer volume...
docker volume rm cours_portainer_data 2>nul

echo  Restarting Portainer...
docker compose up -d portainer

echo.
echo  [OK] Portainer has been reset!
echo.
echo  Go NOW to http://localhost:9000
echo  to create your new account (5 minutes max).
echo.
start http://localhost:9000
pause
