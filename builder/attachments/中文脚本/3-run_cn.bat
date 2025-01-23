@REM 如将 CUDA Toolkit 安装到其他路径，注意修改
set CUDA_HOME=C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v12.4

@REM 如需配置代理，取消注释（移除行首的 'rem '）并编辑下两行环境变量。
rem set HTTP_PROXY=http://localhost:1080
rem set HTTPS_PROXY=http://localhost:1080

@REM ===========================================================================
@REM 该部分设置一般无需更改

@REM 该环境变量配置 PIP 使用国内镜像站点。
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

@REM 该环境变量配置 HuggingFace Hub 使用国内镜像站点。
set HF_ENDPOINT=https://hf-mirror.com

@REM 该环境变量指示 HuggingFace Hub 下载模型到"本目录\HuggingFaceHub"，而不是"用户\.cache"目录。
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM 该命令配置 PATH 环境变量。
set PATH=%PATH%;%~dp0\python_standalone\Scripts
set PATH=%PATH%;%CUDA_HOME%\bin

@REM 该环境变量使 .pyc 缓存文件集中保存在一个文件夹下，而不是随 .py 文件分布。
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM ===========================================================================

cd Hunyuan3D-2
..\python_standalone\python.exe -s gradio_app.py

pause
