set PATH=%PATH%;%~dp0\python_standalone\Scripts

@REM To set mirror site for PIP, uncomment and edit the two lines below.
rem set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

@REM Compile texture generation tools of Hunyuan3D-2

.\python_standalone\python.exe -s -m pip install ^
 .\Hunyuan3D-2\hy3dgen\texgen\custom_rasterizer

.\python_standalone\python.exe -s -m pip install ^
 .\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer

COPY /Y ".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\build\lib.win-amd64-cpython-312\mesh_processor.cp312-win_amd64.pyd" ^
".\Hunyuan3D-2\hy3dgen\texgen\differentiable_renderer\mesh_processor.cp312-win_amd64.pyd"

@REM Reinstall hf-hub for later downloading of models

.\python_standalone\python.exe -s -m pip uninstall --yes huggingface-hub

.\python_standalone\python.exe -s -m pip install "huggingface-hub[hf-transfer]"
