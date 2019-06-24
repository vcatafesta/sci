
#require "hbwin"

PROCEDURE Main()
	Teste1()
	//CriaPdf()

PROCEDURE Teste1()
   LOCAL nPrn := 1
   LOCAL cFileName := Space( 40 )
   LOCAL GetList := {}

   LOCAL aPrn := win_printerList()

   CLS

   IF Empty( aPrn )
      Alert( "No printers installed - Cannot continue" )
   ELSE
      DO WHILE nPrn != 0
         CLS
         @ 0, 0 SAY "win_PrintFileRaw() test program. Choose a printer to test"
         @ 1, 0 SAY "File name:" GET cFileName PICT "@!K"
         READ
         @ 2, 0 TO MaxRow(), MaxCol()
         nPrn := AChoice( 3, 1, MaxRow() - 1, MaxCol() - 1, aPrn, .T.,, nPrn )
         IF nPrn != 0
            PrnTest( aPrn[ nPrn ], cFileName )
         ENDIF
      ENDDO
   ENDIF

   RETURN

STATIC PROCEDURE PrnTest( cPrinter, cFileName )

   LOCAL lDelete

   IF Empty( cFileName )
      hb_MemoWrit( cFileName := hb_FNameExtSet( __FILE__, ".prn" ), "Hello World!" + Chr( 12 ) )
      lDelete := .T.
   ELSE
      lDelete := .F.
   ENDIF

   Alert( "win_PrintFileRaw() returned: " + hb_ntos( win_PrintFileRaw( cPrinter, cFileName, "testing raw printing" ) ) )

   IF lDelete
      FErase( cFileName )
   ENDIF

	CLS
   Teste2()

#require "hbwin"

PROCEDURE Teste2()

   LOCAL aPrn
   LOCAL nPrn := 1
   LOCAL cDocName := "Raw printing test"
   LOCAL cFileName := Space( 256 )
   LOCAL GetList := {}

   IF Empty( aPrn := win_printerList() )
      Alert( "No printers installed - Cannot continue" )
   ELSE
      DO WHILE nPrn > 0

         CLS
         @ 0, 0 SAY "Raw printing test. Choose a printer to test"
         @ 1, 0 SAY "File name:" GET cFileName PICTURE "@KS40"
         READ
         @ 2, 0 TO MaxRow(), MaxCol()

         IF ( nPrn := AChoice( 3, 1, MaxRow() - 1, MaxCol() - 1, aPrn, .T.,, nPrn ) ) > 0

            IF Empty( cFileName )
               Alert( "win_PrintDataRaw() returned: " + ;
                  hb_ntos( win_PrintDataRaw( aPrn[ nPrn ], "Hello World!" + hb_BChar( 12 ), cDocName ) ) )
            ELSE
               Alert( "win_PrintFileRaw() returned: " + ;
                  hb_ntos( win_PrintFileRaw( aPrn[ nPrn ], cFileName, cDocName ) ) )
            ENDIF
         ENDIF
      ENDDO
   ENDIF

#require "hbwin"
#include "simpleio.ch"

PROCEDURE Teste3()

   Dump( win_printerList( .F., .F. ) )
   Dump( win_printerList( .F., .T. ) )
   Dump( win_printerList( .T., .F. ) )
   Dump( win_printerList( .T., .T. ) )

   ? "win_printerGetDefault():", ">" + win_printerGetDefault() + "<"
   ? "win_printerStatus():", hb_ntos( win_printerStatus() )

   RETURN

STATIC PROCEDURE Dump( a )

   LOCAL b, c

   ? "==="
   FOR EACH b IN a
      ?
      IF HB_ISARRAY( b )
         FOR EACH c IN b
            ?? c:__enumIndex(), c
            IF c:__enumIndex() == 2
               ?? "", ;
                  ">>" + win_printerPortToName( c ) + "<<", ;
                  "|>>" + win_printerPortToName( c, .T. ) + "<<|"
            ENDIF
            ?
         NEXT
         ? "---"
      ELSE
         ? b, win_printerExists( b ), win_printerStatus( b )
      ENDIF
		inkey(0)
   NEXT
   RETURN

	
#require "hbwin"
#include "simpleio.ch"
PROCEDURE Teste4()

   LOCAL a := win_printerGetDefault()

   ? ">" + a + "<"

   ? win_printerSetDefault( a )

   RETURN	


	
? WIN_PRINTEREXISTS()     
? WIN_PRINTERSTATUS()     
? WIN_PRINTERPORTTONAME() 
? WIN_PRINTERLIST()       
? WIN_PRINTERGETDEFAULT() 
? WIN_PRINTERSETDEFAULT() 
? WIN_PRINTFILERAW()      



Win_PrintFileRaw(Win_PrinterGetDefault(), "REPLACE.PRG", "Relatorio Teste")
Alert( "Retorno: " + hb_ntos( WIN_PRINTFILERAW( cPrinter, "REPLACE.PRG", "testando impressão" ) ) )

SelecionaImpressora()

Function SelecionaImpressora()
Local aPrinterList := {}, nOpc := 1, lCancel := .f.

aPrinterList := Win_PrinterList()
For nCont = 1 To Len(aPrinterList)
   If aPrinterList[nCont] == Win_PrinterGetDefault()
      nOpc := nCont
      Exit
   Endif
Next   
Achoice(20,Int(MaxCol()/4), 40, 79, aPrinterList,@nOpc,"Impressora a utilizar")
lCancel := ( LastKey() == 27 )
If .Not. lCancel
   Win_PrinterSetDefault(aPrinterList[nOpc])
Endif   
Return lCancel


cls

? ReplAll("abcd  ", "-")           // "abcd--"
? ReplAll("001234", " ", "0")      // "  1234"
? ReplAll("   d  ", "-")           // "---d--"
? ReplAll(" d d  ", "-")           // "-d d--"


#require "hbwin"
PROCEDURE CriaPdf()

   LOCAL oPC, nTime, cDefaultPrinter, oPrinter, nEvent := 0

   IF Empty( oPC := win_oleCreateObject( "PDFCreator.clsPDFCreator" ) )
      ? "Could not create PDFCreator COM object"
      RETURN
   ENDIF

   /* Setup event notification */
   oPC:__hSink := __axRegisterHandler( oPC:__hObj, {| X | nEvent := X } )

   oPC:cStart( "/NoProcessingAtStartup" )
   oPC:_cOption( "UseAutosave", 1 )
   oPC:_cOption( "UseAutosaveDirectory", 1 )
   oPC:_cOption( "AutosaveDirectory", hb_DirSepDel( hb_DirBase() ) )
   oPC:_cOption( "AutosaveFilename", "pdfcreat.pdf" )
   oPC:_cOption( "AutosaveFormat", 0 )

   cDefaultPrinter := oPC:cDefaultPrinter
   oPC:cDefaultPrinter := "PDFCreator"
   oPC:cClearCache()

   /* You can do any printing here using WinAPI or
      call a 3rd party application to do printing */
#if 1
   oPrinter := win_Prn():New( "PDFCreator" )
   oPrinter:Create()
   oPrinter:startDoc( "Harbour print job via PDFCreator" )
   oPrinter:NewLine()
   oPrinter:NewLine()
   oPrinter:TextOut( "Hello, PDFCreator! This is Harbour :)" )
   oPrinter:EndDoc()
   oPrinter:Destroy()
#else
   oPrinter := NIL
   ? "Do some printing to PDFCreator printer and press any key..."
   Inkey( 0 )
#endif

   oPC:cPrinterStop := .F.

   nTime := hb_MilliSeconds()
   DO WHILE nEvent == 0 .AND. hb_MilliSeconds() - nTime < 10000
      hb_idleSleep( 0.5 )
      /* The following dummy line is required to allow COM server to send event [Mindaugas] */
      oPC:cOption( "UseAutosave" )
   ENDDO

   SWITCH nEvent
   CASE 0
      ? "Print timeout"
      EXIT
   CASE 1
      ? "Printed successfully"
      EXIT
   CASE 2
      ? "Error:", oPC:cError():Description
      EXIT
   OTHERWISE
      ? "Unknown event"
   ENDSWITCH

   oPC:cDefaultPrinter := cDefaultPrinter
   oPC:cClose()
   oPC := NIL

   RETURN
	
PROC TESTE6()	
cArq := "c:\SCI\TESTE.TXT"
SET CONSOLE OFF
SET DEVICE TO PRINT
SET PRINTER TO (cArq)
SET PRINT ON
? Time()
SET PRINT OFF
SET PRINTER TO
SET DEVICE TO SCREEN
SET CONSOLE ON

// cDefaultPrinter:= WIN_PRINTERGETDEFAULT()
// WIN_PRINTFILERAW(cDefaultPrinter, cArq)
ImprimeRaw( cArq )


FUNCTION ImprimeRaw(cArq)
LOCAL cPrinter:= WIN_PrinterGetDefault() , cMsg:="", nRet, nErro, cMensagem

      nRet:=WIN_PrintFileRaw(cPrinter,cArq,'Impressao Sistema')
      IF nRet < 0
         cMsg := 'Erro Imprimindo: '+hb_ntos(nRet)+" "
         SWITCH nRet
         CASE -1
            cMsg+="Parâmetros inválidos passados para função."   ; EXIT
         CASE -2
            cMsg+="WinAPI OpenPrinter() falha na chamada."      ; EXIT
         CASE -3 
            cMsg+="WinAPI StartDocPrinter() falha na chamada."  ; EXIT
         CASE -4
            cMsg+="WinAPI StartPagePrinter() falha na chamada." ; EXIT
         CASE -5
            cMsg+="WinAPI malloc() falha de memória."           ; EXIT
         CASE -6
            cMsg+="Arquivo " + cArq + " não localizado."        ; EXIT
         END
         nErro := wapi_GetLastError()
         cMensagem := space(128)
         wapi_FormatMessage(,,,,@cMensagem)
        Alert("Nº erro: "+hb_ntos(nErro)+;
                                hb_eol()+;
                                hb_eol()+;
                                cMsg+;
                                hb_eol()+;
                                hb_eol()+;
                               cMensagem)
         
      ENDIF
RETURN Nil


#require "hbnf"
PROCEDURE Teste_Box()

   LOCAL i

   SetColor( "W/B" )
   CLS
   FOR i := 0 TO MaxRow()
      @ i, 0 SAY Replicate( "@", MaxCol() + 1 )
   NEXT

   ft_XBox( , , , , , , , "This is a test", "of the ft_XBox() function" )
   ft_XBox( "L", "W", "D", "GR+/R", "W/B", 1, 10, "It is so nice", ;
      "to not have to do the messy chore", ;
      "of calculating the box size!" )
   ft_XBox( , "W", "D", "GR+/R", "W/B", MaxRow() - 8, 10, "It is so nice", ;
      "to not have to do the messy chore", ;
      "of calculating the box size!", ;
      "Even though this line is way too long, and is in fact longer than the screen width, if you care to check!" )

   RETURN