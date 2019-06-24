FUNCTION SEGURANCA()

* CAPTURA O Nß DO VOLUME DO DISCO E GRAVA NA VARIAVEL VOLUME ( TESTVOL.MEM )

  !VOL>"TESTVOL.TXT"
  DLL_MEM:=MEMOREAD("TESTVOL.TXT")
  VOLUME:=VAR_VOL:=RIGHT(MEMOLINE(DLL_MEM,40,3),9)

  IF !FILE ('TESTVOL.MEM')
     SAVE  ALL LIKE VOLUME TO TESTVOL
   ELSE
     RESTORE FROM TESTVOL.MEM ADDITIVE
  ENDIF        

  A:=VOLUME

******************************************************************************
* ROTINA PARA CRIPTOGRAFAR O Nß DO VOLUME E GRAVAR NO DBF

  ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) +  122)       +;
           CHR(ASC(SUBSTR(A,2,1)) -  152)       +;
           CHR(ASC(SUBSTR(A,3,1)) +  180)       +;
           CHR(ASC(SUBSTR(A,4,1)) -  157)       +;
           CHR(ASC(SUBSTR(A,5,1)) +  108)       +;
           CHR(ASC(SUBSTR(A,6,1)) +  248)       +;
           CHR(ASC(SUBSTR(A,7,1)) +  318)       +;
           CHR(ASC(SUBSTR(A,8,1)) +  110)       +;
           CHR(ASC(SUBSTR(A,9,1)) +  200)

           V_DATAINST:=CTOD('01/06/97)
           IF CTOD(DATE()) < V_DATAINST
             ALERT("DATA DO SISTEMA INVµLIDA;RETORNE AO PROMPT E;UTILIZE O COMANDO DATE PARA ATUALIZAR A DATA')
             CLS
           ENDIF

           USE REG && ABRE O ARQUIVO E VERIFICA SE Jµ EXISTE DADOS NO CAMPO
           GO TOP
           IF EMPTY(SENHA)
             REPL SENHA    WITH ENCRYPTA
             REPL DATAINST WITH V_DATAINST
           ENDIF

******************************************************************************
* INICIALIZA A COMPARAÄ«O COM A VARIµVEL DE MEM‡RIA E ARQUIVO DBF

  IF VOLUME # VAR_VOL
     AVISO_PIRATARIA()
  ENDIF

  USE REG
  GO TOP 
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

  IF VOLUME # D_ENCRYPTA
     AVISO_PIRATARIA()
  ENDIF
RETURN

******************************************************************************
FUNCTION AVISO_PIRATARIA() && EMITE AVISO DE QUE O PROGRAMA ê PIRATA
     @00,00 CLEAR
     FOR L:=1 TO 3
      TONE(900,05)
     ENDFOR

     FOR LL:=1 TO 3
      TONE(800,0.5)
     ENDFOR

     FOR LLL:=1 TO 23
      @01,30 SAY '     COPIA PIRATA' COLOR 'r+*'
      SET COLOR TO
      @LLL,30 SAY '     COPIA PIRATA' COLOR 'r+'
      TONE(700,0.5)
     ENDFOR

     @24,30 SAY '     COPIA PIRATA' COLOR 'r+*'
     SET COLOR TO
     FOR LLLL:=1 TO 10
      TONE(600,0.5)
     ENDFOR

     FOR LLLLL:=1 TO 3
      TONE(500,0.5)
     ENDFOR

     PIRATA:=0
     DO WHILE PIRATA < 1
        TONE(800,8)
        TONE(750,0.9)
        TONE(700,1)
        PIRATA++
      ENDDO
      SETCOLOR('N/N')
      DBCLOSEALL()
      !DEL *.PLL >NUL
      SET COLOR TO
      CLS
      SET COLOR TO G+/N
      TONE(1000,5)
      TONE(2000,5)
      TONE(350,5)
      TONE(400,5)
      ? ""
      ? ""
      ? ""
      ? "                  ØØ REALMENTE ESTE FOI O FIM DE SEU SISTEMA  ÆÆ"
      ? ""
      ? ""
      SET COLOR TO GB+
      ? "                   JAMAIS FAÄA C‡PIA PIRATA, PIRATARIA ê CRIME"
      ? ""
      ? ""
      ? ""
      SET CURS ON
      SET COLOR TO
      QUIT
RETURN
