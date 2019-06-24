@echo off

set HRB_DIR=%HB_PATH%
set HWGUI_INSTALL=c:\hwgui
REM set HRB_DIR=C:\CVS-Developers\xharbour
REM set HWGUI_INSTALL=C:\CVS-Developers\xharbour\contrib\hwgui

%HRB_DIR%\bin\harbour manage.prg -n -i%HRB_DIR%\include;%HWGUI_INSTALL%\include;..\..\include

bcc32  -c -O2 -tW -M -I%HRB_DIR%\include;%HWGUI_INSTALL%\include manage.c
echo 1 24 "%HWGUI_INSTALL%\samples\image\WindowsXP.Manifest" > hwgui_xp.rc
brc32 -r hwgui_xp -fohwgui_xp

echo c0w32.obj + > b32.bc
echo manage.obj, + >> b32.bc
echo manage.exe, + >> b32.bc
rem  manage.map, + >> b32.bc

echo %HWGUI_INSTALL%\lib\hwgui.lib + >> b32.bc
echo %HWGUI_INSTALL%\lib\procmisc.lib + >> b32.bc
echo %HWGUI_INSTALL%\lib\hbxml.lib + >> b32.bc

if exist %HRB_DIR%\lib\win\bcc\win\bcc\rtl%HB_MT%.lib echo %HRB_DIR%\lib\win\bcc\rtl%HB_MT%.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbrtl%HB_MT%.lib echo %HRB_DIR%\lib\win\bcc\hbrtl%HB_MT%.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\vm%HB_MT%.lib echo %HRB_DIR%\lib\win\bcc\vm%HB_MT%.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbvm.lib echo %HRB_DIR%\lib\win\bcc\hbvm.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\gtgui.lib echo %HRB_DIR%\lib\win\bcc\gtgui.lib + >> b32.bc
if not exist %HRB_DIR%\lib\win\bcc\gtgui.lib echo %HRB_DIR%\lib\win\bcc\gtwin.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\lang.lib echo %HRB_DIR%\lib\win\bcc\lang.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hblang.lib echo %HRB_DIR%\lib\win\bcc\hblang.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\codepage.lib echo %HRB_DIR%\lib\win\bcc\codepage.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbcpage.lib echo %HRB_DIR%\lib\win\bcc\hbcpage.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\macro%HB_MT%.lib echo %HRB_DIR%\lib\win\bcc\macro%HB_MT% + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbmacro.lib echo %HRB_DIR%\lib\win\bcc\hbmacro.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\common.lib echo %HRB_DIR%\lib\win\bcc\common + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbcommon.lib echo %HRB_DIR%\lib\win\bcc\hbcommon.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\debug.lib echo %HRB_DIR%\lib\win\bcc\debug.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbdebug.lib echo %HRB_DIR%\lib\win\bcc\hbdebug.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\pp.lib echo %HRB_DIR%\lib\win\bcc\pp.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbpp.lib echo %HRB_DIR%\lib\win\bcc\hbpp.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\pcrepos.lib echo %HRB_DIR%\lib\win\bcc\pcrepos.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\dbfcdx.lib echo %HRB_DIR%\lib\win\bcc\dbfcdx.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\dbfntx.lib echo %HRB_DIR%\lib\win\bcc\dbfntx.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\dbffpt.lib echo %HRB_DIR%\lib\win\bcc\dbffpt.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\rddntx.lib echo %HRB_DIR%\lib\win\bcc\rddntx.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\rddfpt.lib echo %HRB_DIR%\lib\win\bcc\rddfpt.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbsix.lib echo %HRB_DIR%\lib\win\bcc\hbsix.lib + >> b32.bc

echo %HRB_DIR%\lib\win\bcc\rddleto.lib + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\rdd%HB_MT%.lib echo %HRB_DIR%\lib\win\bcc\rdd%HB_MT% + >> b32.bc
if exist %HRB_DIR%\lib\win\bcc\hbrdd.lib echo %HRB_DIR%\lib\win\bcc\hbrdd.lib + >> b32.bc

echo cw32.lib + >> b32.bc
echo import32.lib, >> b32.bc
echo hwgui_xp.res >> b32.bc
ilink32 -Gn -Tpe -aa @b32.bc

del *.tds
del manage.c
del manage.map
del manage.obj
del b32.bc
