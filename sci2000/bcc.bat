@echo off
set HB_INSTALL_PREFIX=C:\HARBOUR\COMP\BCC55
set CC_COMPILER=C:\BORLAND\BCC55\BIN
PATH=c:\windows;c:\windows\system;c:\windows\syswow64;%CC_COMPILER%;%HB_INSTALL_PREFIX%\BIN;
echo path
set HB_COMPILER=
echo HB_COMPILER
echo HB_INSTALL_PREFIX
echo Compilador Harbour: %HB_INSTALL_PREFIX%\BIN
echo Compilador C++    : %CC_COMPILER%
set TEMP=C:\TEMP
set TMP=C:\TEMP
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
hbmk2 %1 %2 %3 %4 -b -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin -lgtwvg  -lgtwvt

