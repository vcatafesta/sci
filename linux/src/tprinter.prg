#include <sci.ch>

#define WIN_PRINTERLIST_PRINTERNAME     1
#define WIN_PRINTERLIST_PORT            2
#define WIN_PRINTERLIST_TYPE            3
#define WIN_PRINTERLIST_DRIVERNAME      4
#define WIN_PRINTERLIST_SHARENAME       5
#define WIN_PRINTERLIST_SERVERNAME      6                                                                                                                                       

CLASS TPrinter
    Export:		  
        DATA RowPrn	  INIT 0
		  DATA Pagina	  INIT 0
		  DATA Tamanho   INIT 80
		  DATA NomeFirma INIT oAmbiente:xFanta
        DATA Sistema   INIT "Macrosoft NOME DO PROGRAMA"
		  DATA Titulo	  INIT "TITULO DO RELATORIO"
		  DATA Cabecalho INIT "CODIGO DESCRICAO"
		  DATA Separador INIT "="
		  DATA Registros INIT 0

    Export:
        method    New CONSTRUCTOR
		  method    Inicio		  
		  method    Eject		  		  
        method    ArrPrinter()
        method    CriaNewPrinter() 
        method    EscolheImpressoraUsuario()
        method    PrintOn()
        method    PrintOff()
        method    AbreSpooler()        
        method    FPrint(cString)
        method    CloseSpooler()
        method    CupsArrayPrinter()
        method    Instru80()        
        method    SaidaParaRedeCups()
        method    SetPrc(n,y)
        method    LptOk()
        method    RetPrinterStatus()
        message   cabec method Inicio
        message   __eject method Eject
EndClass

Method New() class TPrinter		  
        return( Self )

Method Inicio() class TPrinter
		LOCAL nTam := ::Tamanho / 2
		LOCAL Hora := Time()
		LOCAL Data := Dtoc( Date() )
		::Pagina++

		DevPos( 0, 0) ; QQout( Padc( ::NomeFirma, ::Tamanho ))
		Qout( Padc( ::Sistema, ::Tamanho ))
		Qout( Padc( ::Titulo, ::Tamanho ))
		Qout( Padr( "Pagina : " + StrZero( ::Pagina, 3 ), ( nTam     ) ) + Padl( Data + " - " + Hora, ( nTam  ) ) )
		Qout( Repl( ::Separador, ::Tamanho ))
		Qout( ::Cabecalho )
		Qout( Repl( ::Separador, ::Tamanho ))
      ::RowPrn := 7
      return( Self )
		
Method EJect() class TPrinter
	::RowPrn := 0
   __Eject()
	SetPrc(0,0)
   return self
   
Method ArrPrinter() class TPrinter
	LOCAL hESCP    := oAmbiente:hESCP
	LOCAL aPrinter := {}
	LOCAL nTam
	LOCAL nX
	
	Aadd( aPrinter, {'12','FUJITSU DL-700','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'13','SAMSUNG EE-809','#27#18','#27#58','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'14','PROLOGICA P720 XT','#27#18','#27#58','#14','#15','#27#120#49','#27#120#48','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'27','DATAMAX','#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'28','ARGOX','#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'01','EPSON FX-1170','#27#18','#27#58','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'02','EPSON FX-1050','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'03','EPSON LQ-1070','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'04','EPSON LQ-570','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'05','EPSON LX-810','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'06','EPSON LX-300','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'34','EPSON LX-300+','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'20','EPSON FX-2170','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'21','EPSON LQ-2170','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70#27#85#49#27#52', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'07','RIMA XT-180','#30#49','#30#50','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'08','CITYZEN GSX-190','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'09','SEIKOSHA','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'10','HP DESKJET 500',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'11','HP DESKJET 520',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'15','HP DESKJET 600',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'40','HP DESKJET 656C', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'16','HP DESKJET 660',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'17','HP DESKJET 680',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'18','HP DESKJET 692',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'19','HP DESKJET 693',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'24','HP DESKJET 670',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'25','HP DESKJET 695',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'26','HP DESKJET 610',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'29','HP DESKJET 640',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'30','HP DESKJET 710',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'31','HP DESKJET 740',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'32','HP DESKJET 950',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'33','HP DESKJET 970',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'35','HP DESKJET 840',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'38','HP DESKJET 3420', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'39','HP DESKJET 3820', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'36','HP LASERJET 1100','#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'22','HP LASERJET 5L',  '#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'23','HP LASERJET 6L',  '#27#38#107#48#83',   '#27#40#115#112#72',  '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'37','HP LASERJET 4L',  '#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', '#27#52', '#27#53', Date()})
	Aadd( aPrinter, {'38',' ARQUIVO',        '#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#27#52', '#27#53', Date()})
	nTam := Len( aPrinter )
	if Printer->(TravaArq())
	  for nX := 1 To nTam
		  Printer->(DbAppend())
		  for nField := 1 To Printer->(FCount())
			  Printer->(FieldPut( nField, aPrinter[nX,nField]))
		  next
	  next
	  Printer->(Libera())
	endif
   //BrowseArray(aPrinter)
	return
endmethod

method CriaNewPrinter() class TPrinter
*+-----------------------------------+*
	LOCAL cTela   := Mensagem("Aguarde, Verificando Arquivos.")
	
	FechaTudo()
   ResTela( cTela ) 
	if !NetUse("PRINTER", MONO )       
      return false
   endif   
   
	cTela := Mensagem("Verificando: printer.dbf")
	Area("Printer")
	Printer->(__DbZap())
	::ArrPrinter()
	FechaTudo()   
	resTela( cTela )   
	return true
endmethod


method EscolheImpressoraUsuario()
   MEMVAR aStr
   LOCAL nIndex   := 0
	LOCAL aPrinter := cupsGetDests()
	LOCAL nLen     := 7  
	LOCAL aPrnList := {}
	LOCAL xLpt     := {}
	LOCAL cLpt     := Space(2)
	LOCAL cDefault := "06"
	LOCAL oEscolhe := TIniNew(oAmbiente:xUsuario + ".INI")

	if UsaArquivo("PRINTER")
		Printer->(Order(PRINTER_CODI))
		Printer->(DbGoTop())
		if Printer->(Eof())
			::ArrPrinter()
		endif
      
		nLen           += Len(aPrinter) // impressora windows ou cups instaladas ?
		oAmbiente:aLpt := {}
		for nIndex := 1 to nLen
			Aadd( xLpt, oEscolhe:ReadString("printer", "lpt" + StrZero(nIndex,2), cDefault))
			cLpt := xLpt[nIndex]
			if Printer->(DbSeek(cLpt))
				aPrnList := { Printer->Codi,;
            	           Printer->Nome, ;
               	        Printer->_Cpi10,; 
                  	     Printer->_Cpi12,; 
                     	  Printer->Gd,; 
                       	  Printer->Pq,; 
                       	  Printer->Ng,; 
                       	  Printer->Nr,; 
                          Printer->Ca,; 
                          Printer->c18,; 
                          Printer->LigSub,; 
                          Printer->DesSub,; 
                          Printer->_SaltoOff,; 
                          Printer->_Spaco1_8,;
                          Printer->_Spaco1_6,; 
                          Printer->Reseta;
                      }
			else
	      	aPrnList := { NIL, NIL, NIL, NIL, NIL, NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL,NIL }
   		endif		
	   	Aadd(oAmbiente:aLpt, aPrnList )                               
			oEscolhe:WriteString('printer', 'lpt' + strzero(nIndex,2), cLpt)		
      next
		Printer->(DbCloseArea())
		return true
	endif
	return false
endmethod


method PrintOff() class TPrinter
	::PrintOn( true )
	::FPrint( RESETA )
	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	::CloseSpooler()
	return Nil
endmethod

method AbreSpooler() class TPrinter
*----------------*
	iif( oAmbiente:Spooler, Set( _SET_PRINTFILE, oAmbiente:cArquivo, false ), Set( _SET_PRINTFILE, "" ))
	return NULL
endmethod

method FPrint( cString ) class TPrinter
**************************
   return( DevOut( cString ))
endmethod

method CloseSpooler() class TPrinter
********************
   LOCAL cScreen	   := SaveScreen()
   LOCAL lSpooler	   := oAmbiente:Spooler
   LOCAL cTemp 	   := oAmbiente:cArquivo
   LOCAL lexterno    := oAmbiente:externo
   LOCAL lVisualizar := oAmbiente:lVisSpooler
   LOCAL cComando
   LOCAL i

   Set(_SET_PRINTFILE, "" )
   Set Print To

   if lexterno
      #if defined( __PLATFORM__UNIX )
         //ms_system("gnome-terminal --command '/opt/shell.sh'");
         ms_system("nano " + cTemp)
      #else
         cComando := 'firefox.exe ' + cTemp
         cComando := "C:\Program Files\Mozilla Firefox\firefox.exe " + cTemp
         cComando := "chrome.exe " + cTemp		
         ShellRun("NOTEPAD " + cTemp )
         //ShellRun( cComando )
         /*
         i = SWPUSEEMS(OK)
         i = SWPUSEXMS(OK)
         i = SWPUSEUMB(OK)
         i = SWPCURDIR(OK)
         i = SWPVIDMDE(OK)
         //i = SWPDISMSG(OK)
         i = SWPRUNCMD( cComando, 0, "", "")
         */         
      #endif
      oAmbiente:externo := false
   else
      if lSpooler
         if lVisualizar
            oMenu:Limpa()
            oMenu:StatInf()
            oMenu:StatReg("IMPRESSO #" + StrZero( oAmbiente:nRegistrosImpressos, 7))
            M_Title( "ESC - Retorna │Setas CIMA/BAIXO Move")
            M_View( 00, 00, MaxRow()-1, MaxCol(), cTemp, Cor())
            //ShellRun("NOTEPAD " + cTemp )
            ResTela( cScreen )
         else            
            cupsPrintFile( oAmbiente:CupsPrinter, oAmbiente:cArquivo, "Macrosoft SCI for Linux")
         endif
      endif
   endif   
   oAmbiente:Spooler     := false
   oAmbiente:lVisSpooler := false
   return nil
endef   

method PrintOn(lFechaSpooler) class TPrinter
	LOCAL nQualPorta := 1
	LOCAL cSaida	  := ""
   LOCAL cLpr       := "|lpr -h -l -P"

   hb_default(@lFechaSpooler, nil)
	if lFechaSpooler == nil
		::AbreSpooler()
	endif
	::Instru80( @nQualPorta )
   
	switch nQualPorta 
   case 1	
		cSaida := "LPT1"
      exit
	case 2
		cSaida := "LPT2"
      exit
	case 3
		cSaida := "LPT3"
      exit
	case 4
		cSaida := "COM1"
      exit
	case 5
		cSaida := "COM2"
      exit
	case 6
		cSaida := "COM3"   
      exit
	endswitch
   
   cSaida := cLpr += cSaida
	if lFechaSpooler == nil
		oMenu:StatInf()
		oAmbiente:nRegistrosImpressos := 0
	endif	
	Set Cons Off
	Set Devi To Print
	if !oAmbiente:Spooler
		if nQualPorta != 1
			Set Print To ( cSaida )
		endif
	endif
	Set Print On
	::FPrint( RESETA )
	::SetPrc(0,0)
	return Nil
endmethod

*==================================================================================================*			

method Instru80( nQualPorta, cArquivo ) class TPrinter
	Instru80( nQualPorta, cArquivo )
endmethod	

*==================================================================================================*			

method CupsArrayPrinter() class TPrinter
	return CupsArrayPrinter()
endef   	


method SaidaParaRedeCups()   
	LOCAL cDir     := oAmbiente:xBaseTxt	
   LOCAL xArquivo := ""
	
   xArquivo           := TrimStr(FTempPorExt('txt', cDir))
	oAmbiente:cArquivo := xArquivo
   oAmbiente:Spooler  := true
	Set Print To (xArquivo)	   	
	return true
endef

method SetPrc(n,y)
   SetPrc(n,y)
endef   

method LptOk() class TPrinter
	LOCAL cScreen
	LOCAL nComPort := 1
	LOCAL nStatus
	LOCAL lRetorno := OK
	STATI lMaluco  := FALSO
	LOCAL aAction	:= { "ERRO: IMPRESSORA FORA DE LINHA. ",;
							  "ERRO: IMPRESSORA DESLIGADA.     ",;
							  "ERRO: IMPRESSORA SEM PAPEL.     ",;
							  "ERRO: IMPRESSORA NAO CONECTADA. ",;
							  "ERRO: IMPRESSORA NAO PRONTA.    ",;
							  "OK: IMPRESSORA ONLINE NOVAMENTE."}
	LOCAL cMsg := ";;1)Verifique a impressora se ligada, cabeamento, conexoes "
			cMsg += "  e mapeamentos de rede, etc. Lembre-se que impressoras  "
			cMsg += "  mapeadas sempre estarao com status de PRONTA devido ao "
			cMsg += "  SPOOL de impressao da rede.                            "
			
			cMsg += ";2)Voce pode verificar status de online novamente. Escolha"
			cMsg += " (TENTAR).                                               "
			cMsg += ";3)Ao escolher a opcao (IMPRIMIR ASSIM MESMO) podera haver"
			cMsg += "   um travamento completo do sistema.                    "
			cMsg += ";4)Escolha (RETORNAR) para cancelar a impressão.          "
			
	if lMaluco 
		return( lMaluco)
	endif

	if oAmbiente:Isprinter <= 3
		nStatus := PrnStatus( oAmbiente:Isprinter )
		if !oAmbiente:Spooler
			cScreen := SaveScreen()
			oMenu:Limpa()
			WHILE !IsPrinter( oAmbiente:Isprinter )
				nStatus := PrnStatus( oAmbiente:IsPrinter )
				if nStatus = 0 // Windows sempre retorna 0
					nStatus := Iif( IsPrinter(oAmbiente:Isprinter), 6, 1)
				else
					if nStatus = -1
						nStatus := 5
					endif
				endif	
				ErrorBeep()
				nDecisao := Alerta( aAction[ nStatus] + cMsg, {"TENTAR", "IMPRIMIR ASSIM MESMO", "CANCELAR", "MAPEAR"} )
				if nDecisao = 3 .OR. nDecisao = 0
					lMaluco  := FALSO
					lRetorno := FALSO
					exit
				endif
				if nDecisao = 2
					lMaluco  := OK
					lRetorno := OK
					exit
				endif
				if nDecisao = 4
					Cls
					DosShell("CMD net")
					lMaluco  := FALSO
					lRetorno := FALSO
					exit
				endif
				
			EndDo
			ResTela( cScreen )
		endif
	else
		nComPort := ( oAmbiente:IsPrinter - 4 )
		lRetorno := ( nStatus := FIsPrinter( nComPort ))
	endif
	return( lRetorno )
endef

method RetPrinterStatus()
   LOCAL i := 0
   LOCAL aStatus := {}
   
   for i := 1 to 3
      nStatus := PrnStatus(i)
      if nStatus = 0 
         nStatus := Iif(IsPrinter(i), 1, 2 )
      else
        if nStatus = -1
           nStatus = 4
        else
           nStatus++
         endif
      endif	
      Aadd( aStatus, nStatus )
   next
   return aStatus
endef      
   
Function TPrinterNew()
*********************
return( TPrinter():New())
