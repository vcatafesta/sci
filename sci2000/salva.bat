@ECHO OFF
CLS
C:
CD C:\WIN95_CD\APP\SCI2000
ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
ECHO ³ ÝÝÝÝ  ÝÝÝÝMicroBras           ³Av Castelo Branco, 599 - Centro              ³
ECHO ³ ÝÝ ÝÝÝÝ ÝÝInformatica         ³Fone (069)451-2286                           ³
ECHO ³ ÝÝ  ÝÝ  ÝÝ  Ltda              ³78984-000/Pimenta Bueno - Rondonia           ³
ECHO ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾
ECHO 
ECHO ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
ECHO ³ Insira o disco de backup no drive A: e tecle ENTER para iniciar             ³
ECHO ³                                                                             ³
ECHO ³ CUIDADO!! Os dados do drive A: serao todos apagados.                        ³
ECHO ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PAUSE >NUL
COMPRIME -EX -RP -SMSIL -&F A:\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.BAT + *.ETI + *.NFF + *.COB + *.DUP
