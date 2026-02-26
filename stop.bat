@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +==========================================+
echo  ^|   PHP Docker Environment - Stopping      ^|
echo  +==========================================+
echo.
echo  Stopping services...
echo.

docker compose stop

echo.
echo  [OK] All services have been stopped.
echo       Your PHP files and data are preserved.
echo.
pause
