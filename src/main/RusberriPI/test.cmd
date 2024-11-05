@echo off
REM Print the received path for debugging
echo Received path: "%~1"

REM Check if the path argument is provided
if "%~1"=="" (
    echo Error: No path provided.
    exit /b 1
)

REM Set the target path (use quotes around %~1 to handle spaces in paths)
set "targetPath=%~1"

REM Check if target path exists
if not exist "%targetPath%" (
    echo Error: The specified path does not exist.
    exit /b 1
)

REM Create test.txt in the specified path
echo This is a test file. > "%targetPath%\test.txt"

echo test.txt created in %targetPath%
exit /b 0
