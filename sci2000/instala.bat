@ECHO OFF
CLS
IF "==%1" GOTO EXEMPLO
ECHO         ����������������������������������������������������������͸
ECHO         �        Microbras Sistemas Ltda - Instalador  V 2.2       ��
ECHO         ����������������������������������������������������������;�
ECHO          ������������������������������������������������������������
ECHO.
ECHO.
ECHO         ����������������������������������������������������������͸
ECHO         �               Aguarde... Criando Diretorio.              ��
ECHO         ����������������������������������������������������������;�
ECHO          ������������������������������������������������������������
IF NOT EXIST %1\SCI\NUL MD %1\SCI > NUL
ECHO.
ECHO         ����������������������������������������������������������͸
ECHO         �               Aguarde... Extraindo Arquivos.             ��
ECHO         ����������������������������������������������������������;�
ECHO          ������������������������������������������������������������
DCOMPRIM -o -d SCI.ZIP %1\SCI >NUL
CLS
ECHO         ����������������������������������������������������������͸
ECHO         �       MicroBras SCI 2004 Instalado                       ��
ECHO         ����������������������������������������������������������͵�
ECHO         �       Microbras Com de Prod de Informatica Ltda          ��
ECHO         �       Av Castelo Branco, 693 - Fone (69)451.2286         ��
ECHO         �       78984-000/Pimenta Bueno - Estado de Rondonia       ��
ECHO         �       home : http://www.microbras.com.br                 ��
ECHO         �       email: suporte@microbras.com.br                    ��
ECHO         ����������������������������������������������������������;�
ECHO          ������������������������������������������������������������
ECHO.
ECHO         ����������������������������������������������������������͸
ECHO         �Digite SCI         �����                                 ��
ECHO         ����������������������������������������������������������;�
ECHO          ������������������������������������������������������������
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
ECHO.        ����������������������������������������������������������͸
ECHO.        � Para instalar o sistema digite:        INSTALA C: ����� �
ECHO.        ����������������������������������������������������������;
:FIM
