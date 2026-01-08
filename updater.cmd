@echo off & cd /d "%~dp0"
ping ipfs.io -n 1
if %errorlevel% NEQ 0 (
echo I need ipfs.io connectivity to update. Please check your Internet connection.
pause
exit
)
set countfile=0 & for %%f in (*) do set /a countfile+=1
set countfolder=0 & for /D %%a in (%CD%\*) do set /a countfolder+=1
if %countfile% lss 10 if %countfolder% lss 8 goto Skip
choice /m "There are too many files to update. You don't want to run the updater in a folder with your personal files. Continue update anyway"
if %errorlevel% EQU 2 exit
:Skip
if "%CD:~-1%" == "\" (set "WAY=%CD:~0,-1%") else set "WAY=%CD%"
(
echo @echo off
echo powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/file.zip', '%WAY%\file.zip')"
echo cscript "%temp%\extractor.vbs"
)>"%temp%\updater.cmd"
(
cmd /u /c echo CreateObject("Shell.Application"^).NameSpace("%CD%"^).CopyHere(CreateObject("Shell.Application"^).NameSpace("%WAY%\file.zip"^).items^)
cmd /u /c echo CreateObject("WScript.Shell"^).Run "%temp%\cleaner.cmd"
)>"%temp%\extractor.vbs"
(
echo @echo off
echo del "%WAY%\file.zip"
echo xcopy "%temp%\data" "%CD%\data" /i /e /y
echo rmdir "%temp%\data" /s /q
echo del "%temp%\updater.cmd"
echo del "%temp%\extractor.vbs"
echo del "%temp%\cleaner.cmd"
)>"%temp%\cleaner.cmd"
xcopy "%CD%\data" "%temp%\data" /i /e /y
start "" cmd /c "%temp%\updater.cmd"
rmdir "%CD%" /s /q
