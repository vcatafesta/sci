@ECHO OFF
set TEMP=C:\LIXO
set TMP=C:\LIXO
set COMP_PATH=C:\mingw
set HB_COMPILER=mingw
set HB_INSTALL_PREFIX=c:\DEV\hb32\%HB_COMPILER%
set PATH=%COMP_PATH%\bin;h:\windows;h:\windows\system;%HB_INSTALL_PREFIX%\BIN;
set LIB=%COMP_PATH%\lib;%COMP_PATH%\lib\sdk;
set INCLUDE=%COMP_PATH%\include;
rem call "c:\watcom\owsetenv.bat"
set HB_CPU=x86
SET HB_CONTRIBLIBS=%HB_INSTALL_PREFIX%\lib
hbmk2 %1 %2 %3 %4 -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lgtstd -lgtcgi -lgtgui -lgtpca -lgtwin -lGTWVG
