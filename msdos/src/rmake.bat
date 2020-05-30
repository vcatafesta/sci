@echo off
rem set PATH=h:\windows;h:\windows\system;c:\borland\bcc55\bin;c:\harbour\bin;
rem set C_COMPILER=bcc

REM #versao 3.2 bcc55
REM set HB_COMPILER=bcc
REM set COMPILER_PATH=C:\Program Files\Embarcadero\RAD Studio\7.0\bin
REM set COMPILER_PATH=C:\Program Files\Embarcadero\Studio\17.0\bin
REM set COMPILER_PATH=C:\Program Files\Embarcadero\Studio\18.0\bin
REM set COMPILER_PATH=C:\BORLAND\BCC72\BIN
REM set COMPILER_PATH=C:\BORLAND\BCC55\BIN
REM set COMPILER_PATH=C:\Program Files (x86)\Embarcadero\Studio\19.0\bin
REM set HARBOUR_VER=C:\DEV\HB32\BCC\BIN
REM set HB_INSTALL_PREFIX=%HARBOUR_VER%

REM #versao 3.2 bcc73
set HB_COMPILER=bcc
set COMPILER_PATH=C:\Program Files (x86)\Embarcadero\Studio\19.0\bin
set HARBOUR_VER=C:\DEV\HB32\BCC73\BIN
set HB_INSTALL_PREFIX=%HARBOUR_VER%


REM #versao 3.2 mingw64
rem set HB_COMPILER=mingw64
rem set COMPILER_PATH=C:\MinGW\BIN
rem set HARBOUR_VER=C:\DEV\HB32\MINGW64\BIN
rem set HB_INSTALL_PREFIX=%HARBOUR_VER%

REM #versao 3.4 mingw
REM set HB_COMPILER=mingw
REM set COMPILER_PATH=C:\MINGW\BIN
REM set HARBOUR_VER=C:\HB34.SRC\HARBOUR-CORE\BIN\WIN\MINGW

REM #versao 3.4 msvc
rem set HB_COMPILER=msvc
rem set HARBOUR_VER=C:\HB34.SRC\HARBOUR-CORE\BIN\WIN\MSVC
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"

set PATH=%HARBOUR_VER%;%COMPILER_PATH%%PATH%
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
set TEMP=C:\LIXO
set TMP=C:\LIXO
set INCLUDE=C:\SCI\INCLUDE;%INCLUDE%
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
rem set HB_COMPILER=msvc
rem SET HB_CONTRIBLIBS=C:\harbouri\lib\win\msvc
rem hbmk2 %1 %2 %3 %4 -w3 -mt -run -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg
hbmk2 %1 %2 %3 %4 hbsqlite3.hbc -mt -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg -lleto -lrddleto -lsqlite3 -lhbmemio -lhbgzio -ic:\sci\include 
rem if not errorlevel 1 %1