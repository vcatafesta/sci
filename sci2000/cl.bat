@ECHO OFF
rem tcc -ml -c romcksum.c
rem clipper getsys /m/n/w/b
clipper %1 /b /n
IF NOT ERRORLEVEL 1 FLINK -V %1,,, nanfor
rem IF NOT ERRORLEVEL 1 WL %1,,, nanfor
rem IF NOT ERRORLEVEL 1 WL %1 GETSYS
rem IF NOT ERRORLEVEL 1 %1
