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

set PATH=C:\ProgramData\Oracle\Java\javapath;C:\Windows\system32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\;C:\Program Files\Notepad++;C:\Program Files\Git\cmd;%HARBOUR_VER%;%COMPILER_PATH%
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
set TEMP=C:\LIXO
set TMP=C:\LIXO
rem set PATH=c:\harbouri\bin;h:\windows;h:\windows\system32
rem call "c:\Program Files\Microsoft Visual Studio 9.0\VC\bin\vcvars32.bat"
rem set HB_COMPILER=msvc
rem SET HB_CONTRIBLIBS=C:\harbouri\lib\win\msvc
hbmk2 %1 %2 %3 %4 -mt -run -b -inc -info -debug -cpp -n2 -lhbct -lxhb -lhbwin -lhbgt -lhbnf -lhbxpp -lgtwvg