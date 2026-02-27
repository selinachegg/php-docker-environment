@echo off
cd /d "%~dp0"
start /min "" powershell -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0launcher.ps1"
exit
