
#require "hbwin"

function main(cPort)
	aInfo := win_osVersionInfo()
	qout(  ainfo[1])
	qout(  ainfo[2])
	qout(  ainfo[3])
	qout(  ainfo[4])

cPrinter := ""
qout("win_PrintDlgDC:", win_PrintDlgDC(@cPrinter), cPrinter)
Qout("win_PrinterExists:", win_printerExists(cPrinter))
Qout("win_PrinterExists:", win_printerExists("p1"))
qout("win_PrinterPortToName:", win_printerPortToName("10.0.0.99:p1"))

qout(win_printerPortToName("LPT1:"))
qout(win_printerExists("USB001"))
qout(win_printerExists("http://10.0.0.77:8018/wsd"))
qout(win_printerExists("LPT1:"))

aPrinterList := win_printerList(.t.)

#define WIN_PRINTERLIST_PRINTERNAME 	1
#define WIN_PRINTERLIST_PORT 		2
#define WIN_PRINTERLIST_TYPE 		3
#define WIN_PRINTERLIST_DRIVERNAME 	4
#define WIN_PRINTERLIST_SHARENAME 	5
#define WIN_PRINTERLIST_SERVERNAME 	6

qout(replicate("=", 80))
for i := 1 to len(aPrinterList)
   Qout(1, padr(aPrinterList[i,1],20),;
   2, padr(aPrinterList[i,2],20), ;
   3, padr(aPrinterList[i,3],20), ;
   4, padr(aPrinterList[i,4],20),;
   5, padr(aPrinterList[i,5],20),;
   6, padr(aPrinterList[i,6],20))
   qout()
next
qout(replicate("=", 80))
inkey(0)

qout("printer default:", win_printerGetDefault())
qout()
//qout("set printer default:", win_printerSetDefault("SEC30CDA78CC9E1"))
qout("set printer default:", win_printerSetDefault("EPSON LX-300+ /II"))
//win_PrintFileRaw(win_printerGetDefault(), "printer.prg")

qout('hb_Isprinter("LPT1:")', hb_IsPrinter("LPT1:"))
qout('hb_Isprinter("LPT1")', hb_IsPrinter("LPT1"))

lComLPT1:=.F.
aPrinters:=GetPrinters( .T. )

For x=1 To Len( aPrinters )
  qout("aPrinters:", aPrinters[ x, 1 ] )
  qout("aPrinters:", aPrinters[ x, 2 ] )
  qout("aPrinters:", aPrinters[ x, 3 ] )
  qout("aPrinters:", aPrinters[ x, 4 ] )
  If ( "LPT1" $ aPrinters[ x, 2 ] )  // pega o elemento 2 (porta da impressora)
   lComLPT1 := .T.  // tem impressora na LPT1
   qout("A Impressora: " + aPrinters[ x, 1 ] + " está usando a LPT1" )
   Exit
  EndIf
qout()
 Next

 If !lComLPT1
  qout( "Nenhuma impressora usando LPT1" )
 EndIf

qout("TESTELPT", TESTELPT("LPT1:"))
qout("TESTELPT", TESTELPT("10.0.0.99:p1"))
Qout(win_printerPortToName("10.0.0.99:p1"))

#pragma BEGINDUMP
#include "windows.h"
#include "hbapi.h"
#include "hbstack.h"
#include "hbapiitm.h"

HB_FUNC( TESTELPT )

{
   BOOL bRetorno = FALSE;
   HANDLE hComm = CreateFileA( hb_parc (1), GENERIC_READ | GENERIC_WRITE, 
      0, 0, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);

      DCB status = {0};
      BOOL success = GetCommState(hComm, &status);

      bRetorno = success;
      hb_retl(bRetorno);
}
#pragma ENDDUMP

set( _SET_DEFEXTENSIONS, .f. )
qout("win_PrinterPortToName:", win_printerPortToName("10.0.0.99:p1"))

set print to "temp.txt"
set cons off
set devi to print
set print on
qout("teste")
set print to
set devi to screen
set cons on
set print off
qout("printer default:", win_printerGetDefault())
win_PrintFileRaw(win_printerGetDefault(), "temp.txt")
