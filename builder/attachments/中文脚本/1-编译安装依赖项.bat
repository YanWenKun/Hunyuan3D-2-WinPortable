@echo off
setlocal

@REM 使用清华 PyPI 源
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\python_standalone\Scripts

echo "编译安装 custom_rasterizer..."

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\custom_rasterizer

if %errorlevel% neq 0 (
    echo "编译安装 custom_rasterizer 失败！"
    goto :end
)

echo "编译安装 differentiable_renderer..."

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer

if %errorlevel% neq 0 (
    echo "编译安装 differentiable_renderer 失败！"
    goto :end
)

COPY /Y ".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\build\lib.win-amd64-cpython-312\mesh_processor.cp312-win_amd64.pyd" ^
".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\mesh_processor.cp312-win_amd64.pyd"

echo "编译安装完成！"

:end
endlocal
pause
