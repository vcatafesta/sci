@ECHO OFF
CLS
C:
CD C:\WIN95_CD\APP\SCI2000
ECHO �����������������������������������������������������������������������������͸
ECHO � ����  ����MicroBras           �Av Castelo Branco, 599 - Centro              �
ECHO � �� ���� ��Informatica         �Fone (069)451-2286                           �
ECHO � ��  ��  ��  Ltda              �78984-000/Pimenta Bueno - Rondonia           �
ECHO �����������������������������������������������������������������������������;
ECHO 
ECHO �����������������������������������������������������������������������������͸
ECHO � Insira o disco de backup no drive A: e tecle ENTER para iniciar             �
ECHO �                                                                             �
ECHO � CUIDADO!! Os dados do drive A: serao todos apagados.                        �
ECHO �������������������������������������������������������������������������������
PAUSE >NUL
COMPRIME -EX -RP -SMSIL -&F A:\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.BAT + *.ETI + *.NFF + *.COB + *.DUP
