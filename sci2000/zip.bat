@ECHO OFF
CLS
CFG
PKLITE SCI.EXE -A -E
ECHO 
ECHO.
ECHO.==================================================================
ECHO � TECLE ALGO.
ECHO.==================================================================
ECHO.
ECHO.
PAUSE >NUL
DEL SCI.ZIP
rem COMPRIME  -EX SCI SCI.EXE SCI.DBF SCI.CFG COM*.EXE *.NT SM*.EXE CON*.* LET.COM AU*.BAT *.ICO *.PIF *.DR
COMPRIME  -EX SCI SCI.EXE SCI.DBF SCI.CFG SCI.ICO *.NT
rem DCOMPRIM -T SCI
