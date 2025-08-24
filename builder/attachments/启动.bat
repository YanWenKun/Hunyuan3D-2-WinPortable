@echo on
setlocal

set PATH=%PATH%;%~dp0\MinGit\cmd;%~dp0\python_standalone\Scripts

set PYTHONPYCACHEPREFIX=%~dp0\pycache

set HF_HUB_CACHE=%~dp0\HuggingFaceHub
set HY3DGEN_MODELS=%~dp0\HuggingFaceHub

.\python_standalone\python.exe -s .\WinScripts-GUI\py\launcher.zh.py

endlocal
