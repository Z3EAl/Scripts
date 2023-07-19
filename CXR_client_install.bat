@echo off
mkdir %CD%\extracted_folder
powershell.exe -nologo -noprofile -command "& { $shell = New-Object -COM Shell.Application; $target = $shell.NameSpace('%CD%\extracted_folder'); $zip = $shell.NameSpace('%CD%\source.zip'); $target.CopyHere($zip.Items(), 16); }"
echo Extracting Zip......
timeout /t 2
cd extracted_folder
echo Change directries......
timeout /t 2
adb.exe install -r app-debug.apk
echo installing cxr client app......
timeout /t 2

@echo off
(for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr /C:"IPv4 Address"') do echo -s %%a) > temp.txt

@echo off & setlocal EnableDelayedExpansion
set row=
for /F "delims=" %%j in (temp.txt) do (
if defined row echo.!row!>> CloudXRLaunchOptions.txt
set row=%%j
)

adb.exe push CloudXRLaunchOptions.txt /sdcard/CloudXRLaunchOptions.txt
echo pushing launch options to oculus......
timeout /t 2
cd..
cd..
rmdir /s /q extracted_folder
echo deleting extracted folder......
timeout /t 2
echo done
timeout /t 5