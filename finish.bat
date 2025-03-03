
echo Installing noVNC...
set noVNCPath=C:\Users\Administrator\Desktop\noVNC
if not exist "%noVNCPath%" (
    mkdir "%noVNCPath%"
)
curl -o "%noVNCPath%\noVNC.zip" "https://github.com/novnc/noVNC/archive/refs/heads/main.zip"
if %errorLevel% == 0 (
    echo noVNC downloaded successfully.
) else (
    echo Failed to download noVNC. Continuing...
)

:: Extract noVNC
:: =============
powershell -command "Expand-Archive -Path '%noVNCPath%\noVNC.zip' -DestinationPath '%noVNCPath%'"
if %errorLevel% == 0 (
    echo noVNC extracted successfully.
) else (
    echo Failed to extract noVNC. Continuing...
)

:: Create noVNC batch file
:: =======================
echo Creating noVNC batch file...
echo @echo off > "%noVNCPath%\novnc.bat"
echo cd /d "%noVNCPath%\noVNC-main" >> "%noVNCPath%\novnc.bat"
echo python C:\Users\Administrator\AppData\Local\Packages\PythonSoftwareFoundation.Python.3.13_qbz5n2kfra8p0\LocalCache\local-packages\Python313\site-packages\websockify --web . 3000 localhost:5901 >> "%noVNCPath%\novnc.bat"
if %errorLevel% == 0 (
    echo noVNC batch file created successfully.
) else (
    echo Failed to create noVNC batch file. Continuing...
)

:: Add noVNC to Task Scheduler
:: ===========================
echo Adding noVNC to Task Scheduler...
schtasks /create /tn "noVNC Startup" /tr "%noVNCPath%\novnc.bat" /sc onstart /ru Administrator /rl highest
if %errorLevel% == 0 (
    echo noVNC added to Task Scheduler successfully.
) else (
    echo Failed to add noVNC to Task Scheduler. Continuing...
)

echo All tasks completed successfully.
