cd /d "%~dp0"
setlocal EnableDelayedExpansion
for %%I in (VERSION*) do set "UPD=%%~nxI"
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/%UPD%', '%temp%\%UPD%')" >nul
if %errorlevel% NEQ 0 (
choice /m "The local version does not match the latest version. It means that update is available, but in edge cases marks accessibility issues. Do you want to update"
if !errorlevel! EQU 2 GOTO Skip
powershell -Command " '@echo off' | Out-File """%temp%\autoupdater.cmd""" -encoding oem
powershell -Command " 'call """%CD%\updater.cmd"""' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " 'cls' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " ':Wait' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " 'if not exist """%CD%\file.any""" GOTO Wait' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " 'timeout /t 1 /nobreak' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " 'call """%CD%\%~nx0"""' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
powershell -Command " 'del """%temp%\autoupdater.cmd""" & exit' | Out-File """%temp%\autoupdater.cmd""" -append -encoding oem
start "" "%temp%\autoupdater.cmd"
exit
)
del "%temp%\%UPD%"
:Skip
