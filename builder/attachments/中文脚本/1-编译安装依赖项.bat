@REM 使用清华 PyPI 源
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

set PATH=%PATH%;%~dp0\python_standalone\Scripts

@REM 编译 混元3D-2 的材质生成工具

.\python_standalone\python.exe -s -m pip install ^
 .\Hunyuan3D-2\hy3dgen\texgen\custom_rasterizer

.\python_standalone\python.exe -s -m pip install ^
 .\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer

COPY /Y ".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\build\lib.win-amd64-cpython-312\mesh_processor.cp312-win_amd64.pyd" ^
".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\mesh_processor.cp312-win_amd64.pyd"

@REM 重新安装 hf-hub 以便后续下载模型

.\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub

.\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
