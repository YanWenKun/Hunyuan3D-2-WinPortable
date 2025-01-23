@echo off

setlocal

set "target_dir=Hunyuan3D-2"

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

REM 执行 git reset --hard
echo 正在执行 git reset --hard...
git reset --hard
if errorlevel 1 (
    echo 错误： git reset --hard 执行失败。
    goto :error
)

REM 执行 git pull
echo 正在执行 git pull...
git pull
if errorlevel 1 (
    echo 错误： git pull 执行失败。
    goto :error
)

echo 操作成功完成！

popd

goto :eof

:error
echo 脚本执行过程中发生错误。

:eof
endlocal
pause