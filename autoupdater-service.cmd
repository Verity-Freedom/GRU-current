cd /d "%~dp0"
setlocal EnableDelayedExpansion
for %%I in (VERSION*) do set "UPD=%%~nxI"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/%UPD%', '%temp%\%UPD%')" >nul
if %errorlevel% NEQ 0 (
choice /m "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Do you want to update"
if !errorlevel! EQU 2 GOTO Skip
sc query "Service" >nul
if !errorlevel! EQU 0 set "CHECK=0" & GOTO Service
:Loop
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
:Skip
...
:Service
...
If "%CHECK%"=="0" set "CHECK=1" & GOTO Loop
