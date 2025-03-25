@echo off
setlocal

@REM 按需下载并复制 u2net.onnx 到用户主目录下
IF NOT EXIST "%USERPROFILE%\.u2net\u2net.onnx" (
    IF NOT EXIST ".\extras\u2net.onnx" (
        echo 正在下载 u2net.onnx...

        .\python_standalone\Scripts\aria2c.exe --allow-overwrite=false ^
        --auto-file-renaming=false --continue=true ^
        -d ".\extras" -o "u2net.tmp" ^
        "https://gh-proxy.com/https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx"

        IF %errorlevel% == 0 (
            ren ".\extras\u2net.tmp" "u2net.onnx"
        )
    )
    IF EXIST ".\extras\u2net.onnx" (
        mkdir "%USERPROFILE%\.u2net" 2>nul
        copy ".\extras\u2net.onnx" "%USERPROFILE%\.u2net\u2net.onnx"
    )
)

@REM 如需启用 HF Hub 实验性高速传输，取消该行注释。仅在千兆比特以上网速有意义。
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

@REM 使用国内镜像站点
set HF_ENDPOINT=https://hf-mirror.com

@REM 使用清华 PyPI 源
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

set HF_HUB_CACHE=%~dp0\HuggingFaceHub

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

@REM 重新安装 hf-hub
if not exist ".\python_standalone\Scripts\.hf-reinstalled" (
    echo 正在重新安装 huggingface-hub...
    .\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub
    .\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
    if %errorlevel% equ 0 (
        echo.> ".\python_standalone\Scripts\.hf-reinstalled"
    )
)

echo 正在下载 Hunyuan3D-2 模型...
.\python_standalone\Scripts\huggingface-cli.exe download "tencent/Hunyuan3D-2"

@REM 下载 文生3D 所需模型
rem .\python_standalone\Scripts\huggingface-cli.exe download "Tencent-Hunyuan/HunyuanDiT-v1.1-Diffusers-Distilled"

echo 脚本执行完毕，如有文件不完整，请重新运行脚本

endlocal
pause
