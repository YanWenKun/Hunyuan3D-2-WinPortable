@echo off
setlocal
chcp 65001

set "target_dir=WinScripts-GUI"

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

REM 检查目标目录是否存在
if not exist "%target_dir%" (
    echo 错误：目标目录 "%target_dir%" 不存在。
    goto :error
)

REM 进入目标目录
pushd "%target_dir%"

REM 检查 git 是否存在
where git >nul 2>&1
if errorlevel 1 (
    echo 错误： git 命令未找到。请确保已安装 git 并将其添加到 PATH 环境变量。
    echo 下载： https://git-scm.com/downloads/win
    goto :error
)

start /d .\zh-cn init.bat

echo 已在新窗口执行脚本，可关闭本窗口

popd

goto :eof

:error
echo 脚本执行过程中发生错误。

:eof
endlocal
pause
