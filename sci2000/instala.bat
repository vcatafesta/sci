@ECHO OFF
CLS
IF "==%1" GOTO EXEMPLO
ECHO         ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO         ณ        Microbras Sistemas Ltda - Instalador  V 2.2       ณÛ
ECHO         ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
ECHO          ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
ECHO.
ECHO.
ECHO         ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO         ณ               Aguarde... Criando Diretorio.              ณÛ
ECHO         ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
ECHO          ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
IF NOT EXIST %1\SCI\NUL MD %1\SCI > NUL
ECHO.
ECHO         ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO         ณ               Aguarde... Extraindo Arquivos.             ณÛ
ECHO         ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
ECHO          ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
DCOMPRIM -o -d SCI.ZIP %1\SCI >NUL
CLS
ECHO         ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO         ณ       MicroBras SCI 2004 Instalado                       ณÛ
ECHO         ฦออออออออออออออออออออออออออออออออออออออออออออออออออออออออออตÛ
ECHO         ณ       Microbras Com de Prod de Informatica Ltda          ณÛ
ECHO         ณ       Av Castelo Branco, 693 - Fone (69)451.2286         ณÛ
ECHO         ณ       78984-000/Pimenta Bueno - Estado de Rondonia       ณÛ
ECHO         ณ       home : http://www.microbras.com.br                 ณÛ
ECHO         ณ       email: suporte@microbras.com.br                    ณÛ
ECHO         ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
ECHO          ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
ECHO.
ECHO         ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO         ณDigite SCI         ฤฤฤฤู                                 ณÛ
ECHO         ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพÛ
ECHO          ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
%1
CD\SCI
COPY Sci.PIF %1\WINDOWS\DESKTOP >NUL
COPY Sci.PIF %1\DOCUME~1\ADMINI~1\DESKTOP >NUL
COPY AUTOEXEC.NT %1\WINDOWS\SYSTEM32 >NUL
COPY AUTOEXEC.NT %1\WINNT\SYSTEM32 >NUL
COPY CONFIG.NT %1\WINDOWS\SYSTEM32 >NUL
COPY CONFIG.NT %1\WINNT\SYSTEM32 >NUL
REN %1\CONFIG.SYS CONFIG.SCI >NUL
REN %1\AUTOEXEC.BAT AUTOEXEC.SCI >NUL
COPY CONFIG.SYS %1\ >NUL
COPY AUTOEXEC.BAT %1\ > NUL
GOTO FIM
:EXEMPLO
ECHO 
ECHO.        ีออออออออออออออออออออออออออออออออออออออออออออออออออออออออออธ
ECHO.        ณ Para instalar o sistema digite:        INSTALA C: ฤฤฤฤู ณ
ECHO.        ิออออออออออออออออออออออออออออออออออออออออออออออออออออออออออพ
:FIM
