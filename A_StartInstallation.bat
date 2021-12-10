@echo off
diskpart /s %~d0\ScriptFiles\CreatePartitions.dps
dism /Apply-Image /ImageFile:%~d0\sources\install.swm /SWMFile:%~d0\sources\install*.swm /Index:1 /ApplyDir:W:\ /CheckIntegrity /Verify
bcdboot W:\Windows /s S:
md R:\Recovery\WindowsRE
copy %~d0\ScriptFiles\winre.wim R:\Recovery\WindowsRE
W:\Windows\System32\ReAgentc.exe /SetReImage /Path R:\Recovery\WindowsRE /Target W:\Windows
