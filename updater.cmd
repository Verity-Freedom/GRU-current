@echo off & cd /d "%~dp0"
ping ipfs.io -n 1
if %errorlevel% NEQ 0 (
echo I need ipfs.io connectivity to update. Please check your Internet connection.
pause
exit
)
if "%CD:~-1%" == "\" (set "WAY=%CD:~0,-1%") else set "WAY=%CD%"
(
echo @echo off
echo powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/file.zip', '%WAY%\file.zip')"
echo cscript "%temp%\extractor.vbs"
echo exit
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
start "" "%temp%\updater.cmd"
rmdir "%CD%" /s /q
