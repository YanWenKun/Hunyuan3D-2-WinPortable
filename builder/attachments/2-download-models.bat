@REM Download and copy u2net.onnx to user's home path, if needed.
IF NOT EXIST "%USERPROFILE%\.u2net\u2net.onnx" (
    IF NOT EXIST ".\extras\u2net.onnx" (
        .\python_standalone\Scripts\aria2c.exe --allow-overwrite=false ^
        --auto-file-renaming=false --continue=true ^
        -d ".\extras" -o "u2net.tmp" ^
        "https://github.com/danielgatis/rembg/releases/download/v0.0.0/u2net.onnx"

        IF %errorlevel% == 0 (
            ren ".\extras\u2net.tmp" "u2net.onnx"
        )
    )
    IF EXIST ".\extras\u2net.onnx" (
        mkdir "%USERPROFILE%\.u2net" 2>nul
        copy ".\extras\u2net.onnx" "%USERPROFILE%\.u2net\u2net.onnx"
    )
)

@REM To set mirror site for HuggingFace Hub, uncomment and edit the two lines below.
rem set HF_ENDPOINT=https://hf-mirror.com

@REM To enable HuggingFace Hub's experimental high-speed file transfer, uncomment the line below.
@REM https://huggingface.co/docs/huggingface_hub/hf_transfer
rem set HF_HUB_ENABLE_HF_TRANSFER=1

set HF_HUB_CACHE=%~dp0\HuggingFaceHub

set PATH=%PATH%;%~dp0\python_standalone\Scripts

@REM Download Hunyuan3D-2 from HuggingFace
.\python_standalone\Scripts\huggingface-cli.exe download "tencent/Hunyuan3D-2"

@REM Download models for Text to 3D
rem .\python_standalone\Scripts\huggingface-cli.exe download "Tencent-Hunyuan/HunyuanDiT-v1.1-Diffusers-Distilled"
