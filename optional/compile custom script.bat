@echo off
set source=%homedrive%%homepath%

echo Creating main test.bat
if exist test.bat (attrib -s -h test.bat)
echo @echo off >test.bat
echo if exist lst.dat (set resumed=true) else (set resumed=false) >>test.bat
echo setlocal enabledelayedexpansion >>test.bat
echo echo Creating directory tree... >>test.bat
echo for /R %source% ^%%%%a in (.) do ( >>test.bat
echo set b=^%%%%a >>test.bat
echo call createfldrs.bat >>test.bat
echo ) >>test.bat
echo echo DONE, Starting copying of files... >>test.bat
echo for /R %source% ^%%%%a in (*) do ( >>test.bat
echo set help=^%%%%a >>test.bat
echo call plshelp.bat >>test.bat
echo ) >>test.bat

echo Creating createfldrs.bat
if exist createfldrs.bat (attrib -s -h createfldrs.bat)
echo @echo off >createfldrs.bat
echo set g=^!b^! >>createfldrs.bat
echo set g=%%g:%source%=%% >>createfldrs.bat
echo if not exist help (mkdir help ^& attrib +h help) >>createfldrs.bat
echo if not exist "help%%g%%" (mkdir "help%%g%%") >>createfldrs.bat

echo Creating plshelp.bat
if exist plshelp.bat (attrib -s -h plshelp.bat)
echo @echo off >plshelp.bat
echo if %%resumed%%==true (set resumed=false ^& echo FOUND FILE LIST... RESUMING PROGRESS... ^& echo ##### PROGRESS RESUMED ##### ^>^>lst.dat) >>plshelp.bat
echo set idk=^!help^! >>plshelp.bat
echo set idk=%%idk:%source%=%% >>plshelp.bat
echo if not exist lst.dat (echo ^!help^!^>lst.dat ^& copy "!help!" "help%%idk%%" ^>nul ^& echo Adding +h attribute to lst.dat... ^& attrib +h lst.dat ^& echo DONE, Continuing... ^& goto :EOF) >>plshelp.bat
echo if not exist TEMP (mkdir TEMP ^& attrib +h TEMP) >>plshelp.bat
echo set boink=^!help^! >>plshelp.bat
echo set boink=%%boink:\=\\%% >>plshelp.bat
echo set boink=%%boink:~0,-2%% >>plshelp.bat
echo findstr /c:"%%boink%%" lst.dat ^>TEMP\plshelp.txt >>plshelp.bat
echo set /p plshelp=^<TEMP\plshelp.txt >>plshelp.bat
echo if not "%%plshelp%%"=="!help! " (echo ^!help^!^>^>lst.dat ^& copy "!help!" "help%%idk%%" ^>nul) >>plshelp.bat

echo DONE, Changing attributes to be +s +h
attrib +s +h plshelp.bat
attrib +s +h createfldrs.bat
attrib +s +h test.bat
echo DONE, Lauching script(beginning of copy)...
echo NOTE: Even if you have the directory tree, you still NEED to re/generate it... Usually takes less than 20 sec
echo NOTE #2: If errors occur, you can ignore them, as they are almost everytime related to D3DS caches[DEV_*, REV_*, SUBSYS_*]
call test.bat
echo DONE, Copying finished, deleting .bat files...
del /Q test.bat plshelp.bat createfldrs.bat
echo DONE, Deleting traces...
del /Q lst.dat plshelp.txt