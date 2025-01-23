#!/bin/bash
set -eux

ls -lahF

du -hd1 Hunyuan3D2_WinPortable

"C:\Program Files\7-Zip\7z.exe" a -t7z -m0=lzma2 -mx=7 -mfb=64 -md=128m -ms=on -mf=BCJ2 Hunyuan3D2_WinPortable.7z Hunyuan3D2_WinPortable

ls -lahF
