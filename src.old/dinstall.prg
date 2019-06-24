************************************************************************** *
* PROGRAMA....: DINSTALL.PRG                                               *
* DATA........: 25.05.97                                                   *
* AUTHOR......: EDSON MELO DE SOUZA                                        *
* COPYRIGHT...: DISBRAM ME
* OBJETIVO....: DESINSTALAR PROGRAMAS COM SEGURANÄA NO HD                  *
* COMPILADO...: CLIPPER DINSTALL                                           *
* LINKEDITADO.: RTLINK FI INSTALL OUTPUT INSTALL /PRELINK                  *
*               RTLINK FI INSTALL,MSGPOR /PLL:INSTALL                      *
****************************************************************************
//SETCANCEL(.F.)
CLS
SET DATE BRIT

TELA()
CAD_REG()
COPIAS()
INSTALA()

******************************************************************************

STATIC FUNCTION CENTER(Arg1,Arg2)
@ Arg1,40 -LEN(Arg2)/2 SAY Arg2
RETURN NIL

******************************************************************************

FUNCTION CAD_REG()
 SET CURSOR OFF
 * Tela Superior
 SET COLOR TO B
 @  0, 0 CLEAR TO  24,79
 @01,01 TO 24,79 DOUB
 @ 12,39 SAY "˛"
 @ 12,39 SAY SPACE(1)
 Logo()
 SET CURSOR ON
 SET COLOR TO B+
 CENTER(3,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(4,"€€∞                     €€∞                          ")
 CENTER(5,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(6,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(8,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(9,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO
    @10,16 CLEAR TO 19,64
    DISPBOX(10,14,19,63,2)
    CENTER(11,"TELA DE REGISTRO DO SISTEMA")
    CENTER(12,"ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ")
    TENT=0
  
    USE REG
    SET CURS OFF
    GO TOP
    NNOME:=USUARIO
    NSERIE:="SKSCB200597-1003/3"
    @14,16 SAY "Nome       : " + NNOME
    @16,16 SAY "Nß de SÇrie: " + NSERIE  
    INKEY(2)
    SET CURS ON
RETURN   
******************************************************************************

FUNCTION INSTALA() // ROTINA PARA DESINSTALAR OS ARQUIVOS NO DISCO
 SET CURSOR OFF
 CLS
 SET COLOR TO B+
 DISPBOX(00,00,24,79,2)
 CENTER(1,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(2,"€€∞                     €€∞                          ")
 CENTER(3,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(4,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(5,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(6,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO W+
 CENTER(9 ,"DESINSTALANDO ARQUIVOS DO SISTEMA")
 CENTER(9 ,"ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ")
 SET COLOR TO R+ 

 @12,25 SAY '0%'
 @12,51 SAY '100%'
 SET COLOR TO
 @13,25 say repl('˛',30) color 'r'
 SET COLOR TO 'W+'
 INKEY(1)
 RUN REN FILESYS.DAT FILESYS.EXE >NUL
 RUN FILESYS.EXE C:\SISCOB10\SISCOB.PLL A:\FILE1.SK_ >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',5) COLOR 'GB+'
 X='1'
 @18,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE C:\SISCOB10\SISCOB.EXE A:\FILE2.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',8) COLOR 'GB+'
 X:='2'
 @18,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE  C:\SISCOB10\SISREL.FRM A:\FILE3.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',10) COLOR 'GB+'
 X:='3'
 @18,013 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE C:\SISCOB10\SIARQ.DBF A:\FILE4.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',13) COLOR 'GB+'
 X:='4'
 @18,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE  C:\SISCOB10\SIPER.DBF A:\FILE5.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',17) COLOR 'GB+'
 X:='5'
 @18,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X

 RUN FILESYS.EXE C:\SISCOB10\SIFAT.DBF  A:\FILE6.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',20) COLOR 'GB+'
 X:='6'
 @18,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X
 RUN FILESYS.EXE C:\SISCOB10\BKUP.DBF  A:\FILE7.SK_  >NUL
 @15,13 CLEAR TO 16,70
 INKEY(3)
 @13,25 SAY REPL('˛',30) COLOR 'GB+'
 X:='7'
 @180,13 SAY 'Arquivos Comprimidos : '
 TONE(1000)
 @18,39 SAY X
 RUN REN FILESYS.EXE FILESYS.DAT >NUL
 !DEL C:\SISCOB10\SISCOB.PLL >NUL
 INKEY(5)
 SET COLOR TO W/N
 TONE(5000)
 TONE(5000)
 TONE(5000)
 ALERT("SISTEMA DESINSTALADO COM SUCESSO")
 SET CURSOR ON
 CLS
RETURN
******************************************************************************

FUNCTION COPIAS()  && VERIFICA O Nß DE C‡PIAS DISPON÷VEIS P/ INSTALAÄ«O

 SET CURSOR OFF
 CENTER(23,"Pressione algo para continuar")
 N_SERIE:="SKSCB200597-1003/3"

 USE REG
 GO TOP
 INST='Ù'
 NNOME:=USUARIO
 IF INST1='˛' .AND. INST2='˛' .AND. INST3='˛'
      @14,16 say space(47)
      @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
      @16,16 SAY "Nß de SÇrie             : " + N_SERIE
      @18,16 SAY "Desinstalaá‰es Dispon°veis : 3 "
      INKEY(0)
      REPL INST3 WITH INST
    RETURN
 ENDIF
 
 IF INST1='˛' .AND. INST2='˛' .AND. INST3='Ù'
      @14,16 say space(47)
      @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
      @16,16 SAY "Nß de SÇrie             : " + N_SERIE
      @18,16 SAY "Desinstalaá‰es Dispon°veis : 2 "
      INKEY(0)
      REPL INST2 WITH INST
      RETURN
 ENDIF

 IF INST1='˛' .AND. INST2='Ù' .AND. INST3='Ù'
      @14,16 say space(47)
      @14,16 SAY "Registrado para         : " + alltrim(NNOME) 
      @16,16 SAY "Nß de SÇrie             : " + N_SERIE
      @18,16 SAY "Desinstalaá‰es Dispon°veis : 1 "
      INKEY(0)
    REPL INST1 WITH INST
    DELETE FOR USUARIO
    PACK
    RETURN
 ENDIF

 IF INST1='Ù' .AND. INST2='Ù' .AND. INST3='Ù'
    TONE(5000,5)
    ALERT("NÈMERO DE DESINSTALAÄÂES ESGOTADAS")
    SET COLOR TO W/N
    CLS
    QUIT
 ENDIF
 SET CURSOR ON
RETURN
******************************************************************************

FUNCTION TELA() // MONTA A TELA DE ABERTURA PARA INICIO DA INSTALAÄ«O ***
 SET CURSOR OFF
 * Tela Superior
 SET COLOR TO B
 @  0, 0 CLEAR TO  24,79
 @ 12,39 SAY "˛"
 INKEY(.06)
 @ 12,39 SAY SPACE(1)
 tLN= 7
 tLP=15
 tCN=36
 tCP=42
 DO WHILE tLN>=2
    @ tLN,tCN TO tLP,tCP
    INKEY(.02)
    @ tLN,tCN CLEAR TO tLP,tCP
    tLN=tLN-1
    tLP=tLP+1
    tCN=tCN-6
    tCP=tCP+6
 ENDDO
 @ tLN,tCN+1 TO tLP,tCP DOUBLE
 
 Logo()
 Mover()
 
 FUNCTION Logo()
 SET CURSOR ON
 SET COLOR TO B+
 CENTER(3,"€€€€€€€∞                €€€€€€€∞                     ")
 CENTER(4,"€€∞                     €€∞                          ")
 CENTER(5,"€€∞       €€∞  €€€€€€∞  €€∞       €€€€€€€∞  €€€€€€€∞ ")
 CENTER(6,"€€€€€€€∞  €€∞  €€∞      €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(7,"     €€∞  €€∞  €€€€€€∞  €€∞       €€∞  €€∞  €€€€€€∞  ")
 CENTER(8,"     €€∞  €€∞      €€∞  €€∞       €€∞  €€∞  €€∞  €€∞ ")
 CENTER(9,"€€€€€€€∞  €€∞  €€€€€€∞  €€€€€€€∞  €€€€€€€∞  €€€€€€€∞ ")
 SET COLOR TO
 
 FUNCTION MOVER()
 tLA=12
 tCA=50
 tLB=22
 tCB=30
 tSKI=1
 tRZ="SOUKI Servicos Empresariais Ltda"
 SET CURSOR OFF
 SET COLOR TO R+
 DO WHILE .T.
 ** Move Nome do Sistema
    SET COLOR TO GB+
    @ tLA,tCA SAY "SISTEMA DE COBRANÄA "
    @ tLA,51 SAY SPACE(27)
    @ tLA, 2 SAY SPACE(28)
    INKEY(.08)
    tCA=tCA-1
    IF tCA=2
       tCA=50
    ENDIF
    SET COLOR TO B+
    CENTER(13,"Vers∆o 1.0")
 ** Move Razao Social
    SET COLOR TO N+
    @ 21,27 SAY " Tecle       para continuar "
    SET COLOR TO W+
    @ 21,34 SAY "ENTER"
    SET COLOR TO w+/n
    USE REG
    GO TOP

       IF EMPTY(USUARIO)
          INKEY(0)
          RETURN
       ENDIF

       CENTER(10,"** PROGRAMA DE DESINSTALAÄ«O **")
       CENTER(15,"REGISTRADO PARA: " + ALLTRIM(USUARIO)) 
       CENTER(16,"Nß DE SêRIE: SKSCB200597-1003/3")
       SET COLOR TO B+

    @ 19,24 SAY LEFT(tRZ,tSKI)
    tSKI=tSKI+1
    IF tSKI=38
       tSKI=1
       @ 19,24 SAY SPACE(38)
    ENDIF
    IF LASTKEY()=13
       SET COLOR TO GB+
       CENTER(12,"                                 ")
       CENTER(12,"SISTEMA DE COBRANÄA")
       CENTER(19,"Souki Serviáos Empresariais Ltda")
       INKEY(3)
       RETURN
    ENDIF
ENDDO
RETURN
******************************************************************************

