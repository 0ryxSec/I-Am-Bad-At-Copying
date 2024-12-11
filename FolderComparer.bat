@echo off
setlocal enabledelayedexpansion

:: Input directories
set "dir1=C:\Path\To\First\Directory"
set "dir2=C:\Path\To\Second\Directory"

:: Temporary files to store file lists and checksums
set "temp1=%temp%\dir1_files.txt"
set "temp2=%temp%\dir2_files.txt"
set "differences=%temp%\differences.txt"

:: Cleanup old temp files, I always forget to
if exist "%temp1%" del "%temp1%"
if exist "%temp2%" del "%temp2%"
if exist "%differences%" del "%differences%"

:: This function is used to calculate checksums and store in temp files, it uses SHA256
for %%F in ("%dir1%" "%dir2%") do (
    echo Processing %%~nF...
    for /r "%%F" %%f in (*) do (
        certutil -hashfile "%%f" SHA256 > nul 2>&1 && (
            for /f "tokens=1 delims= " %%a in ('certutil -hashfile "%%f" SHA256 ^| find /i /v "certutil"') do (
                echo %%a %%~pnxf >> "!temp1!"
            )
        )
    )
)

:: Compare the file lists
echo Comparing directories...
for /f "tokens=*" %%A in (%temp1%) do (
    set "line=%%A"
    set "hash=!line:~0,64!"
    set "filepath=!line:~65!"

    for /f "tokens=*" %%B in (%temp2%) do (
        if "%%~nxB" equ "%%~nxA" (
)        

cmd
