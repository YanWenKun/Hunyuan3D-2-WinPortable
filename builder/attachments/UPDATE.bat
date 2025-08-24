@echo off
setlocal enabledelayedexpansion

:: --- 1. Environment Setup & Checks ---
:: Add embedded Git and Python to the temporary PATH
set "PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts"

:: Check if Git is available
where git >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo Error: 'git' command not found. Please ensure Git is installed and added to your PATH environment variable.
    echo Download from: https://git-scm.com/downloads/win
    goto :error
)

:: --- 2. Batch Update Git Repositories ---
:: Define the list of all directories to be updated
set "repo_list=Hunyuan3D-2 Hunyuan3D-2-vanilla Hunyuan3D-2.1 WinScripts-GUI"

echo ===============================================
echo            Starting Git Repositories Update
echo ===============================================
echo.

:: Loop through each directory in the list
for %%G in (%repo_list%) do (
    echo --- Processing: %%G ---
    if not exist "%%G" (
        echo [WARNING] Directory "%%G" does not exist. Skipping.
    ) else (
        pushd "%%G" && (
            echo Executing git reset --hard...
            git reset --hard >nul && (
                echo Executing git pull...
                git pull
            ) || (
                echo [ERROR] 'git reset --hard' failed.
            )
            popd
        ) || (
            echo [ERROR] Failed to enter directory "%%G".
        )
    )
    echo.
)

:: --- 3. Execute Post-Update Actions for Specific Repo ---
set "gui_dir=WinScripts-GUI"
if exist "%gui_dir%\bat\init.bat" (
    echo --- Launching initialization script for %gui_dir%... ---
    start "GUI Initializer" /d "%gui_dir%\bat" init.bat
    echo.
    echo The script has been launched in a new window. You may safely close this one.
) else (
    echo [WARNING] Could not find "%gui_dir%\bat\init.bat". Cannot launch.
)

goto :end

:error
echo.
echo !!! An error occurred during script execution. Aborting. !!!

:end
echo.
endlocal
pause
