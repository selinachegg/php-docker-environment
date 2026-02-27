@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo.
echo  +==========================================+
echo  ^|  PHP Docker Environment - Starting       ^|
echo  +==========================================+
echo.

REM Check Docker Desktop
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo  [ERROR] Docker Desktop is not running!
    echo.
    echo  Solution:
    echo    1. Open Docker Desktop from the Start menu
    echo    2. Wait for the whale icon in the taskbar
    echo    3. Run this start.bat file again
    echo.
    pause
    exit /b 1
)

echo  [OK] Docker Desktop is ready
echo.
echo  Starting services...
echo.

docker compose up -d

if %errorlevel% neq 0 (
    echo.
    echo  [ERROR] Failed to start. Check Docker Desktop.
    pause
    exit /b 1
)

echo.
echo  +==========================================+
echo  ^|          Available services              ^|
echo  +==========================================+
echo  ^|  PHP Site    -^> http://localhost:8080    ^|
echo  ^|  phpMyAdmin  -^> http://localhost:8081    ^|
echo  ^|  Portainer   -^> http://localhost:9000    ^|
echo  ^|  Dashboard   -^> http://localhost:8082    ^|
echo  +==========================================+
echo.
echo  Waiting for services to be ready (5 seconds)...
timeout /t 5 /nobreak >nul

echo.
echo  Opening dashboard in your browser...
start http://localhost:8082

echo.
echo  [OK] Environment started successfully!
echo.
echo  IMPORTANT - Portainer (localhost:9000):
echo    If this is your first launch, go to
echo    http://localhost:9000 NOW to create
echo    your account (you have 5 minutes).
echo.
pause
