@echo off
setlocal

@REM To set mirror site for PIP, uncomment and edit the line below.
rem set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\python_standalone\Scripts

echo "Compile-installing custom_rasterizer..."

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\custom_rasterizer

if %errorlevel% neq 0 (
    echo "Failed to compile-install custom_rasterizer!"
    goto :end
)

echo "Compile-installing differentiable_renderer..."

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer

if %errorlevel% neq 0 (
    echo "Failed to compile-install differentiable_renderer!"
    goto :end
)

COPY /Y ".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\build\lib.win-amd64-cpython-312\mesh_processor.cp312-win_amd64.pyd" ^
".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\mesh_processor.cp312-win_amd64.pyd"

echo "Compile-install Finished!"

:end
endlocal
pause
