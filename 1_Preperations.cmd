@echo off
pushd %~dp0
robocopy "ScriptFiles" "%localappdata%\Microsoft\Windows\Shell" "LayoutModification.xml"
robocopy "ScriptFiles" "C:\Install" "unattend.xml"
robocopy "ScriptFiles" "C:\ProgramData\Install" "DefaultAssociations.xml"

reg import "ScriptFiles\Deactivate AeroShake.reg"
reg import "ScriptFiles\Deactivate Start Menu Web Search.reg"
reg import "ScriptFiles\Deactivate News & Meet.reg"
reg import "ScriptFiles\Set Default Apps.reg"

popd
pause
exit
