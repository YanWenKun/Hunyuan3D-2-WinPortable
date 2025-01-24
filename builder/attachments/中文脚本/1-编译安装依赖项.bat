@REM 使用清华 PyPI 源
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\python_standalone\Scripts

setlocal enabledelayedexpansion

set error=0

@REM 编译 混元3D-2 的材质生成工具

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\custom_rasterizer

if %errorlevel% neq 0 (
    echo "编译安装 custom_rasterizer 失败！"
    goto :end
)

.\python_standalone\python.exe -s -m pip install .\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer

if %errorlevel% neq 0 (
    echo "编译安装 differentiable_renderer 失败！"
    goto :end
)

COPY /Y ".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\build\lib.win-amd64-cpython-312\mesh_processor.cp312-win_amd64.pyd" ^
".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\mesh_processor.cp312-win_amd64.pyd"

:end
if %error% equ 0 (
    echo "所有操作成功！"
)

endlocal

pause
