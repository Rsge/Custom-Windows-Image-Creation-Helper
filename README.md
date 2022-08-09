# Custom-Windows-Image-Creation-Helper
Tutorial and scripts to help with the preparation and creation of and installation using a custom Windows 10 image.

Much of the first part is adapted from [this blogpost by James Rankin](https://james-rankin.com/articles/creating-a-custom-default-profile-on-windows-10-v1803/) [[Archived link](https://web.archive.org/web/20210525055756/https://james-rankin.com/articles/creating-a-custom-default-profile-on-windows-10-v1803/)].<br>
The second part is adapted from [this post on the TenForums](https://www.tenforums.com/tutorials/72031-create-windows-10-iso-image-existing-installation.html#Part5) [[Archived link](https://web.archive.org/web/20211201160745/https://www.tenforums.com/tutorials/72031-create-windows-10-iso-image-existing-installation.html#Part5)] from point 5.3) onwards.

## What you need
* A PC with a clean installation of windows, with no user set up yet (asking which region you're in).
* A [standard bootable Windows installation USB stick](https://www.microsoft.com/en-us/software-download/windows10) with a copy of all the files from here in a subfolder on it, plugged into the PC.
* An additional copy of the `winre.wim` file found in the default installation or got through [this method](https://docs.microsoft.com/de-de/windows-hardware/manufacture/desktop/deploy-windows-re?view=windows-10) in the `ScriptFiles` folder.

## Creation of custom install files
1. In the region choice screen, press `Ctrl+Shift+F3`.<br>
	The PC reboots into Audit Mode and gives you a temporary account to work with.
2. Close the *System Preparation Tool* window.
3. Configure windows settings according to your needs and wants.
4. [Uninstall and disable unwanted UWPs (Windows 10 default Apps)](https://james-rankin.com/articles/how-to-remove-uwp-apps-on-windows-10-v1803/) [[Archived link](https://web.archive.org/web/20211209142423/https://james-rankin.com/articles/how-to-remove-uwp-apps-on-windows-10-v1803/)]
	1. Open PowerShell as Administrator (`Ctrl+Shift`).
	2. Run `Get-AppxProvisionedPackage -online | Out-GridView -PassThru | Remove-AppxProvisionedPackage -online`.
	3. Select all Apps you don't want (Ctrl+Click) and click ok. Wait for it running.
	4. Run `Get-AppxPackage -AllUsers | Out-GridView -PassThru | Remove-AppxPackage`.
	5. Select all Apps you don't want (Ctrl+Click) and click ok. Wait for it running. If there are errors ignore them.
	6. Go the normal program list and uninstall any additional unwanted programs (e.g. OneDrive).
5. Install programs to provide by default (e.g. Firefox, MS Office, ...).
6. Configure these programs' settings (e.g. config and install Addons in Firefox) and make them default for their filetypes if wanted.
	* If a program you're using saves it's settings in `AppData`, add the corresponding folder/file in the `EmptyDefault.bat` from `ScriptFiles`.
7. Run `0.1_CreateDefaultAssociations.bat`.
8. Run `0.2_CreateDefaultStartMenuLayout.ps1`.
	* If that doesn't work, run `Export-StartLayout -Path C:\LayoutModification.xml` in an elevated PowerShell.
10. Open `C:\defaultassociations.xml` and edit it according to the wanted default file associations. (An example is provided in `ScriptFiles`.)
11. Open `C:\LayoutModification.xml` and [add the Taskbar Layout as needed](https://docs.microsoft.com/en-us/windows/configuration/configure-windows-10-taskbar#sample-taskbar-configuration-added-to-start-layout-xml-file) [[Archived link](https://web.archive.org/web/20220121115213/https://docs.microsoft.com/en-us/windows/configuration//configure-windows-10-taskbar#sample-taskbar-configuration-added-to-start-layout-xml-file)].
	* An example is provided in `ScriptFiles`.
13. Cut & paste your modified XMLs from 8. & 9. into the `ScriptFiles` folder, replacing my default ones.
14. Run `1_Preparations.bat` elevated.
15. Run the partition manager.
16. Shrink your main partition by 15-25 GB.
17. Create a new partition with this space called `Install`.
18. Run `2_Sysprep.bat` elevated and wait for the system to shut down.
19. Start your system from the USB stick.
20. In the installation screen, press `Shift+F10` to open the command prompt.
21. Use `E:` (probably) to change to your stick and `cd` to the directory the batch files are located in.
22. Run `3_CreateImage.bat` (from the command line). This will take a while (> 20 min probably, so go make yourself a coffee or whatever).
23. Close command line and installation window and reboot your system normally.
24. Go through the first user creation process until you reach the desktop.
25. Open the USB stick and run `4_SplitImage.bat`. This will again take a short while (> 5 min probably).
26. Open the `sources` folder on your USB stick and delete `install.wim` from it.
27. Open the *Install* partition in file explorer.
28. Copy all `.swm` files (not the `.wim` file) into the sources dir of your stick.
29. Use the partition manager to delete the Install partition and reclaim it's space for your main partition.
30. You now have a stick with an installer for a customized Windows.

## Creation of custom ISO image
(You can skip this if you are happy with the USB stick.)<br>
1. Temporarily move the folder containing the scripts from your USB stick to somewhere else (e.g. the Desktop).
2. Download the [*Windows Assessment and Deployment Kit (ADK)*](https://developer.microsoft.com/en-us/windows/hardware/windows-assessment-deployment-kit).
3. Install only the *Deployment Tools*. (You don't need anything else.)
4. Open the (newly installed) *Deployment and Imaging Tools* elevated.
5. Run command `cd\`.
6. Run `oscdimg.exe -m -o -u2 -udfver102 -bootdata:2#p0,e,bE:\boot\etfsboot.com#pEF,e,bE:\efi\microsoft\boot\efisys.bin E: C:\CustomWin10.iso`.<br>
	Replace `E:` with the drive letter of your USB stick and `C:\CustomWin10.iso` with the path and name of the ISO file you want.<br>
	This will again take a short while.
7. The image was created at the specified path. Renaming the file is possible without any special care.
8. Move the folder with scripts back onto your USB stick.

## Installation with custom install files
Because of the split image and the nature of custom installations, a few things are different from a normal installation.
1. Plug in your USB stick from above into a new PC.
2. Boot from the USB stick.
3. In the installation screen, press `Shift+F10` to open the command prompt.
4. Use `D:` (probably now) to change to your USB stick and `cd` to the directory the batch files are located in.
5. Run `A_StartInstallation.bat`. This will take a while (> 15 min probably, go get a second refreshment if you like).
6. Close command line and installation window and reboot your system normally.
7. Got through the first user creation process until you reach the desktop.
8. **Important!** Run `B_FixDefault.bat` elevated.<br>
	**If you don't do this step, new logins will take ages and won't work correctly the first few times.**<br>
	If you forget this step, you can run `X_EmergencyFixDefault.bat` elevated on any user to fix it for future users.
