#!/bin/bash
set -eux

# Chores
git config --global core.autocrlf true
gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'
workdir=$(pwd)
pip_exe="${workdir}/python_standalone/python.exe -s -m pip"
export PYTHONPYCACHEPREFIX="${workdir}/pycache1"
export PATH="$PATH:$workdir/python_standalone/Scripts"
export PIP_NO_WARN_SCRIPT_LOCATION=0

ls -lahF

# Download Python Standalone
cd "$workdir"
curl -sSL \
https://github.com/astral-sh/python-build-standalone/releases/download/20250115/cpython-3.12.8+20250115-x86_64-pc-windows-msvc-shared-install_only.tar.gz \
    -o python.tar.gz
tar -zxf python.tar.gz
mv python python_standalone

# PIP installs
$pip_exe install --upgrade pip wheel setuptools

$pip_exe install -r "$workdir"/pak2.txt
$pip_exe install -r "$workdir"/pak3.txt
$pip_exe install -r "$workdir"/pak4.txt

$pip_exe list

# Add Ninja binary (replacing PIP Ninja)
curl -sSL https://github.com/ninja-build/ninja/releases/latest/download/ninja-win.zip \
    -o ninja-win.zip
unzip -q -o ninja-win.zip -d "$workdir"/python_standalone/Scripts
rm ninja-win.zip

# Add aria2 binary
curl -sSL https://github.com/aria2/aria2/releases/download/release-1.37.0/aria2-1.37.0-win-64bit-build1.zip \
    -o aria2.zip
unzip -q aria2.zip -d "$workdir"/aria2
mv "$workdir"/aria2/*/aria2c.exe  "$workdir"/python_standalone/Scripts/
rm aria2.zip

# Add FFmpeg binary
curl -sSL https://github.com/GyanD/codexffmpeg/releases/download/7.1/ffmpeg-7.1-full_build.zip \
    -o ffmpeg.zip
unzip -q ffmpeg.zip -d "$workdir"/ffmpeg
mv "$workdir"/ffmpeg/*/bin/ffmpeg.exe  "$workdir"/python_standalone/Scripts/
rm ffmpeg.zip

cd "$workdir"

ls -lahF
