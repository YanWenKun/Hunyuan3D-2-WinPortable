#!/bin/bash
set -eux

# Chores
gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'
workdir=$(pwd)
python_exe="${workdir}/Hunyuan3D2_WinPortable/python_standalone/python.exe"
export PYTHONPYCACHEPREFIX="${workdir}/pycache2"
export PATH="$PATH:$workdir/Hunyuan3D2_WinPortable/python_standalone/Scripts"

# MKDIRs
mkdir -p "$workdir"/Hunyuan3D2_WinPortable/extras
export HF_HUB_CACHE="$workdir/Hunyuan3D2_WinPortable/HuggingFaceHub"
mkdir -p "${HF_HUB_CACHE}"

# Relocate python_standalone
mv  "$workdir"/python_standalone  "$workdir"/Hunyuan3D2_WinPortable/python_standalone

# Add MinGit (Portable Git)
curl -sSL https://github.com/git-for-windows/git/releases/download/v2.50.1.windows.1/MinGit-2.50.1-64-bit.zip \
    -o MinGit.zip
unzip -q MinGit.zip -d "$workdir"/Hunyuan3D2_WinPortable/MinGit
rm MinGit.zip

# Download Scripts
cd "$workdir"/Hunyuan3D2_WinPortable/
$gcs https://github.com/YanWenKun/Hunyuan3D-2-WinPortable-Scripts.git WinScripts

# Download Hunyuan3D-2
cd "$workdir"/Hunyuan3D2_WinPortable/
$gcs https://github.com/YanWenKun/Hunyuan3D-2.git

# Copy & overwrite attachments
cp -rf "$workdir"/attachments/. \
    "$workdir"/Hunyuan3D2_WinPortable/

cd "$workdir"
