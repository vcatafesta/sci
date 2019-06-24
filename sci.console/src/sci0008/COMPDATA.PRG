FUNCTION COMP_DATA()
SET DATE BRIT
USE REG
 IF EMPTY(DD)
    A:=DTOC(DATE())
    ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) +  122)       +;
             CHR(ASC(SUBSTR(A,2,1)) -  152)       +;
             CHR(ASC(SUBSTR(A,3,1)) +  180)       +;
             CHR(ASC(SUBSTR(A,4,1)) -  157)       +;
             CHR(ASC(SUBSTR(A,5,1)) +  108)       +;
             CHR(ASC(SUBSTR(A,6,1)) +  248)       +;
             CHR(ASC(SUBSTR(A,7,1)) +  108)       +;
             CHR(ASC(SUBSTR(A,8,1)) +  248)       
             REPL DD WITH ENCRYPTA
 ENDIF

  A:=DD
  D_ENCRYPTA=CHR(ASC(SUBSTR(A,1,1)) -  122)       +;
             CHR(ASC(SUBSTR(A,2,1)) +  152)       +;
             CHR(ASC(SUBSTR(A,3,1)) -  180)       +;
             CHR(ASC(SUBSTR(A,4,1)) +  157)       +;
             CHR(ASC(SUBSTR(A,5,1)) -  108)       +;
             CHR(ASC(SUBSTR(A,6,1)) -  248)       +;
             CHR(ASC(SUBSTR(A,7,1)) -  108)       +;
             CHR(ASC(SUBSTR(A,8,1)) -  248)       

 IF DATE() > CTOD(D_ENCRYPTA) + 30 .OR. DATE() < CTOD(D_ENCRYPTA)
   ALERT("O PRAZO DE VALIDADE DO SISTEMA FOI ESGOTADO;ENTRE EM CONTATO COM O FABRICANTE;;Souki Servi‡os Empresariais Ltda;Fone: 283-3962")
   CLS
 ENDIF

RETURN
