@echo off & cd /d "%~dp0"
if "%CD:~-1%" == "\" (set "WAY=%CD:~0,-1%") else set "WAY=%CD%"
(
echo @echo off
echo powershell -Command "(New-Object Net.WebClient).DownloadFile('https://ipfs.io/ipns/link/file.zip', '%WAY%\file.zip')"
echo if %%errorlevel%% NEQ 0 call "%temp%\cleaner.cmd"
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
echo if not exist "%CD%\file.any" (
echo xcopy "%temp%\backup" "%CD%" /i /e /y
echo rmdir "%temp%\backup" /s /q
echo echo Update failed. Please retry.
echo pause
echo del "%temp%\cleaner.cmd" ^& exit
echo ^)
echo rmdir "%temp%\backup" /s /q
echo del "%temp%\cleaner.cmd"
)>"%temp%\cleaner.cmd"
xcopy "%CD%\data" "%temp%\data" /i /e /y
xcopy "%CD%" "%temp%\backup" /i /e /y
start "" "%temp%\updater.cmd"
rmdir "%CD%" /s /q
