@echo off
ATTRIB -R SCI2000*.*
comprime -F -EX -SZAPTUDO SCI2000
ATTRIB +R SCI2000.*
MD C:\BACKUP >NUL
MD D:\BACKUP >NUL
MD E:\BACKUP >NUL
MD G:\BACKUP >NUL
MD Z:\BACKUP >NUL
copy SCI2000.zip C:\backup
copy SCI2000.zip D:\backup
copy SCI2000.zip E:\backup
copy SCI2000.zip G:\backup
copy SCI2000.zip Z:\backup
Echo.
echo.
echo 
