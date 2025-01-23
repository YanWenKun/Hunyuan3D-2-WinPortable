@echo off

setlocal

set "target_dir=Hunyuan3D-2"

if not exist "%target_dir%" (
    echo Error: Target directory "%target_dir%" does not exist.
    goto :error
)

pushd "%target_dir%"

where git >nul 2>&1
if errorlevel 1 (
    echo Error: git command not found. Please ensure git is installed and added to the PATH environment variable.
    echo Download: https://git-scm.com/downloads/win
    goto :error
)

echo Executing git reset --hard...
git reset --hard
if errorlevel 1 (
    echo Error: git reset --hard failed.
    goto :error
)

echo Executing git pull...
git pull
if errorlevel 1 (
    echo Error: git pull failed.
    goto :error
)

echo Operation completed successfully!

popd

goto :eof

:error
echo An error occurred during script execution.

:eof
endlocal
pause