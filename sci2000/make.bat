cd \hb.src
set HB_INSTALL_PREFIX=c:\harbouri
set PATH=c:\bcc55\bin;%PATH%
set LIB=c:\bcc55\lib;c:\bcc55\lib\psdk
set HB_USER_CFLAGS=-DHB_GUI -DHB_NO_PROFILER -DADS_LIB_VERSION=700 -DHB_HASH_MSG_ITEMS -DHB_NO_DEBUG -DHB_LEGACY_OFF -DHB_FM_STD_ALLOC
set HB_BUILD_DLL=no
set HB_INC_ADS=c:\ads\acesdk
win-make clean install