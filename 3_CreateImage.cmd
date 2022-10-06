@echo off
start /b /w %~dp0\ScriptFiles\EmptyDefault.cmd
rd /q /s C:\Install
mkdir D:\Scratch
dism /Capture-Image /ImageFile:D:\install.wim /CaptureDir:C:\ /ScratchDir:D:\Scratch /name:"CustomWin10Pro" /compress:Max /CheckIntegrity /verify /bootable
