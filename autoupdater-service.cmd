@echo off & cd /d "%~dp0"
setlocal EnableDelayedExpansion
for %%I in (VERSION*) do set "UPD=%%~nxI"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/%UPD%', '%temp%\%UPD%')" >nul
if %errorlevel% NEQ 0 (
sc query "Service" >nul
if !errorlevel! EQU 0 set "UPDATE=0" & goto Service
:Loop
choice /c abc /n /m "The local version does not match the latest version. Do you want to update and start service (A), update without starting service (B), or skip update (C)?"
if !errorlevel! EQU 1 set "CHECK=0"
if !errorlevel! EQU 3 GOTO Service
echo @echo off>"%temp%\autoupdater.cmd"
echo call "%CD%\updater.cmd">>"%temp%\autoupdater.cmd"
echo cls>>"%temp%\autoupdater.cmd"
echo :Wait>>"%temp%\autoupdater.cmd"
echo if not exist "%CD%\file.any" GOTO Wait>>"%temp%\autoupdater.cmd"
echo timeout /t 1 /nobreak>>"%temp%\autoupdater.cmd"
echo if "%CHECK%" NEQ "1" call "%CD%\%~nx0">>"%temp%\autoupdater.cmd"
echo del "%temp%\autoupdater.cmd" ^& exit>>"%temp%\autoupdater.cmd"
start "" "%temp%\autoupdater.cmd"
exit
)
del "%temp%\%UPD%"
:Service
...
Echo.
Echo Please don't close this window, I will finish the work and check version...
timeout /t 3 /nobreak
Echo.
if "%UPDATE%" EQU "0" set "UPDATE=" & goto Loop
