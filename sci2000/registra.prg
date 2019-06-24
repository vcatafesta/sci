SET DATE BRIT
IF !FILE("REG.DBF")
   TONE(5000)
   TONE(4000)
   TONE(3500)
   TONE(3000)
   ALERT("ARQUIVO DE REGISTRO AUSENTE;SISTEMA ABORTADO")
   CLS
   QUIT
ENDIF
CLS
L:=5
C:=16
DISPBOX(02,14,09,58,2)
@03 ,16 SAY "           INFORMA��O DO CONFIG" COLOR 'GB+'
@04 ,14 SAY "�"
@04 ,15 SAY REPL("�",43)
@04 ,58 SAY "�"

SET CURS OFF
  @ L, C SAY "GRAVANDO ARQUIVO DE LOG"
  TONE(5000)
  INKEY(1)
  !VOL>"TESTVOL.TXT"
  DLL_MEM:=MEMOREAD("TESTVOL.TXT")
  VOLUME:=VAR_VOL:=RIGHT(MEMOLINE(DLL_MEM,40,3),9)

  @ L+1, C SAY "TESTANDO NUMERA��O DO VOLUME"
  TONE(5000)
  INKEY(1)
     SAVE  ALL LIKE VOLUME TO TESTVOL
  A:=VOLUME
  
******************************************************************************
* ROTINA PARA CRIPTOGRAFAR O N� DO VOLUME E GRAVAR NO DBF

  ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) +  122)       +;
           CHR(ASC(SUBSTR(A,2,1)) -  152)       +;
           CHR(ASC(SUBSTR(A,3,1)) +  180)       +;
           CHR(ASC(SUBSTR(A,4,1)) -  157)       +;
           CHR(ASC(SUBSTR(A,5,1)) +  108)       +;
           CHR(ASC(SUBSTR(A,6,1)) +  248)       +;
           CHR(ASC(SUBSTR(A,7,1)) +  318)       +;
           CHR(ASC(SUBSTR(A,8,1)) +  110)       +;
           CHR(ASC(SUBSTR(A,9,1)) +  200)

           @L+2 , C SAY "ABRINDO O BANCO DE DADOS"
           TONE(5000)
           INKEY(1)
           USE REG && ABRE O ARQUIVO E VERIFICA SE J� EXISTE DADOS NO CAMPO
           GO TOP
           @L+3 , C SAY "TESTANDO CONSIST�NCIA"
           TONE(5000)
           INKEY(1)

             REPL SENHA WITH ENCRYPTA
             REPL INST1 WITH '�'
             REPL INST2 WITH '�'
             REPL INST3 WITH '�'

  PRIVATE A:=SENHA
  D_ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) -  122)       +;
             CHR(ASC(SUBSTR(A,2,1)) +  152)       +;
             CHR(ASC(SUBSTR(A,3,1)) -  180)       +;
             CHR(ASC(SUBSTR(A,4,1)) +  157)       +;
             CHR(ASC(SUBSTR(A,5,1)) -  108)       +;
             CHR(ASC(SUBSTR(A,6,1)) -  248)       +;
             CHR(ASC(SUBSTR(A,7,1)) -  318)       +;
             CHR(ASC(SUBSTR(A,8,1)) -  110)       +;
             CHR(ASC(SUBSTR(A,9,1)) -  200)

             DISPBOX(10,14,18,58,2)                
             @11,16 SAY "           CONFIGURA��ES ATUAIS" COLOR 'GB+'
             @12,14 SAY "�"
             @12,15 SAY REPL("�",43)
             @12,58 SAY "�"
             @13,16 SAY "N� DO VOLUME ORIGINAL         : " + VOLUME
             @14,16 SAY "N� DO VOLUME CRIPTOGRAFADO    : " + A
             @15,16 SAY "N� DO VOLUME DESCRIPTOGRAFADO : " + D_ENCRYPTA
             @16,14 SAY "�"
             @16,15 SAY REPL("�",43)
             @16,58 SAY "�"
             @17,16 SAY "  OPERA��O CONCLU�DA  - < PRESS ENTER >" COLOR 'BG+'
             INKEY(0)
CLS
SET CURS ON
