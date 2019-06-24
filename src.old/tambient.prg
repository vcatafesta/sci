#include "hbclass.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"
#Include "Translate.Ch"
//#Include "Pragma.Ch"

#define FALSO     			.F.
#define OK       			   .T.
#define LIG                .T.
#define DES                .F.
#define ENABLE    	  	 	.T.
#define DISABLE    			.F.
#define SETA_CIMA          5
#define SETA_BAIXO         24
#define SETA_ESQUERDA      19
#define SETA_DIREITA       4
#define TECLA_SPACO        32
#define TECLA_ALT_F4       -33
#define ESC                27
#define ENTER              13
#define ESC    				27
#define ENTER              13
#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 IF <v1> == NIL ; <v1> := <x1> ; END									;
			 [; IF <vn> == NIL ; <vn> := <xn> ; END ]

#XCOMMAND DEFAU <v1> TO <x1> [, <vn> TO <xn> ]								   ;
			 =>																				;
			 IF <v1> == NIL ; <v1> := <x1> ; END									;
			 [; IF <vn> == NIL ; <vn> := <xn> ; END ]

#define INRANGE( xLo, xVal, xHi )  ( xVal >= xLo .AND. xVal <= xHi )
#define BETWEEN( xLo, xVal, xHi )  Min( Max( xLo, xVal ), xHi )
#xcommand PUBLIC:     =>   nScope := HB_OO_CLSTP_EXPORTED ; HB_SYMBOL_UNUSED( nScope )

class TAmbiente
    public:
        VAR Ano2000
        VAR Frame
        VAR Visual

        VAR CorMenu
		  VAR CorLightBar
		  VAR CorHotKey
		  VAR CorHKLightBar
        VAR CorDesativada
        VAR CorAntiga
        VAR CorCabec
        VAR CorBorda
        VAR CorAlerta
        VAR CorBox
        VAR CorCima
        VAR CorFundo
        VAR CorMsg
		  VAR HoraCerta
		  VAR TarefaConcluida
		  VAR Clock INIT Time()

        VAR Selecionado
        VAR Sombra
        VAR Fonte
        VAR Panos
		  VAR ModeMenu
        VAR PanoFundo
        VAR Isprinter
        VAR aPermissao
        VAR xBase
        VAR xBaseDados
        VAR xBaseDoc
		  VAR xBaseTxt		  
        Var xImpressora
        VAR Get_Ativo
        VAR Acento
        VAR xDataCodigo
        VAR Spooler
        VAR Externo
        VAR cArquivo
        VAR TabelaFonte
        VAR Argumentos
        VAR Drive
        VAR Normal
        VAR Mostrar_Desativados
        VAR Mostrar_Recibo
        VAR PosiAgeInd
        VAR PosiAgeAll
        VAR RecePosi
        VAR lReceber		  
        VAR cTipoRecibo
        VAR lGreenCard
        VAR lComCodigoAcesso
        VAR aFiscalIni
        VAR xLimite
        VAR _Empresa
        VAR xFanta
        VAR xNomefir
        VAR xEmpresa
        VAR xJuroMesComposto
        VAR xJuroMesSimples
        VAR aSciArray
        VAR aAtivo
        VAR lContinuarAchoice
        VAR lK_Insert
  		  VAR Menu 
        VAR Disp 
		  VAR Usuario       
		  VAR nRegistrosImpressos INIT 0
        VAR StatusSup    INIT "Macrosoft"
        VAR StatusInf    INIT ""     
        VAR xUsuario  	 INIT "ADMIN"
		  Var NomeFirma 	 INIT "VCATAFESTA@GMAIL.COM"
        Var CodiFirma 	 INIT '0001'
		  VAR xProgramador INIT "Vilmar Catafesta"
        Var Alterando 	 INIT FALSO
		  Var nPos      	 INIT 1
		  Var Ativo     	 INIT 1
        Var StSupArray
        Var StInfArray
        Var MenuArray
        Var DispArray
		  Var FonteManualAltura INIT 25
		  Var FonteManualLargura INIT 80
		  Var AlturaFonteDefaultWindows  INIT MS_MaxRow()
		  Var LarguraFonteDefaultWindows INIT MS_MaxCol()
		  VAR RelatorioCabec             INIT ""
		  VAR MaxCol	                  INIT MaxCol()+1
  
   public:
		  ACCESS cor_menu method getcormenu()
		  ASSIGN cor_menu method setcormenu( cormenu )
	
        method new constructor
		  method ConfAmbiente
        method Ano2000On
        method Ano2000Of
        method SetVar
        method SetSet
		  method SetPano
		  method SetModeMenu
		  method xDisp
		  method xMenu
		  method Show
        method SetaCor
        method SetaFrame
        method SetaSombra
		  method SetaPano
		  method statReg
        method StatInf
        method StatSup
        method Limpa
        method MaBox
        method MSMenuCabecalho
        method MSProcessa
        method MSMenu
        method SetaFonte
		  method SetVar
		  method Refresh
		  method Destroy
		  method AumentaEspacoMenu
		  method SetaFonteManual
		  method PreVisFonte
		  method ContaReg

		  
		  MESSAGE Create            method New
		  MESSAGE SetaCorAlerta     method SetaCor(8) 
		  MESSAGE SetaCorMsg			 method SetaCor(9) 
		  MESSAGE SetaCorLightBar   method SetaCor
		  MESSAGE SetaCorHotKey     method SetaCor
		  MESSAGE SetaCorHKLightBar method SetaCor
		  MESSAGE SetaCorBorda      method SetaCor(10)

		  
endclass


method getcormenu() class TAmbiente
	return ::CorMenu	
	
method setcormenu(cormenu) class TAmbiente	
	RETURN iif( cormenu != NIL, ::cormenu := cormenu, cormenu)	


method Destroy() class TAmbiente
	self := nil
	return nil

method Ano2000On() class TAmbiente
   Set Epoch To 1950
   ::Ano2000 := OK
return( Self )

method Ano2000Of() class TAmbiente
   Set Epoch To 1900
   ::Ano2000 := FALSO
return( Self )

method New() class TAmbiente
        ::Argumentos          := Argc()          
        ::Drive               := IF( ::Argumentos = 0,  NIL, Argv( 1 ))
        ::Normal              := IF( ::Argumentos <= 2, NIL, Argv( 3 ))
		  ::Visual              := IF( ::Argumentos <= 1, FALSO, OK )
		  
        ::Panos               := ::SetPano()    
		  ::ModeMenu				:= ::SetModeMenu()
	     ::Selecionado         := 10     // Pano de Fundo Selecionado
	     ::PanoFundo           := ::Panos[10]
	     ::Frame               := "ÚÄ¿³ÙÄÀ³"
        ::Cormenu             := 15
		  ::CorDesativada       := 8
		  ::CorLightBar         := 124
		  ::CorHotKey           := 10
		  ::CorHKLightBar       := 14
        ::Ano2000             := DISABLE
		  ::Menu                := ::xMenu()
        ::Disp                := ::xDisp()
		  ::nPos                := 1
		  ::SetPano()
		  
		   IF "-V" $ Upper(Argv(1))
		     Cls
			  Version()
			  __Quit()
			EndIF
		  
		  
		  M_Frame( ::Frame )
		  Qout("þ Carregando Configuracao.")
        IF ::Drive = NIL
           ::Drive := FCurdir()
		  Else
           ::Drive := AllTrim(Upper(::Drive))
           IF Left(::Drive, 2) == "\\"      // Drive Mapeado
              IF Len(::Drive) > 2
                 IF Right(::Drive, 1) == "\"   // Drive Mapeado em Diretorio
                    ::Drive := Left(::Drive,Len(::Drive)-1)
                 EndIF
              EndIF
           EndIF

           IF Len(::Drive) = 3
              IF SubStr(::Drive, 2,2) == ":\"
                 ::Drive := Left(::Drive,Len(::Drive)-1)
              EndIF
           EndIF

           /*
           IF !IsDir(::Drive)
				  ErrorBeep()
              IF Alert("Pergunta: Drive " + ::Drive + " invalido. Usar o corrente ?", {"Sim", "Nao"}) == 1
                 ::Drive := FCurdir()
				  Else
					  Quit
				  EndIF
           EndIF
           */

		  EndIF

        IF ::Normal = NIL .OR. ::Drive = NIL
           //Visual()
        EndIF

        ::SetVar()
        ::Isprinter     := 1
        ::aPermissao    := {}
        ::xBase         := ( ::Drive )
        ::xBaseDados    := ( ::Drive )
        ::xBaseDoc      := ( ::Drive )
		  ::xBaseTxt      := ( ::Drive )
        ::xImpressora   := 1
        ::Get_Ativo     := OK
        ::Acento        := FALSO
        ::xDataCodigo   := "  /  /  "
        ::Spooler       := FALSO
        ::Externo       := FALSO
        ::cArquivo      := ""
        ::ConfAmbiente()
Return( Self )


method SetaFonteManual() class TAmbiente
***********************
LOCAL nLargura  := ::FonteManualLargura 
LOCAL nAltura   := ::FonteManualAltura

::Limpa()
MaBox( 10, 10, 16, 50, "LAYOUT: Tamanho do buffer da tela" )
@ 12, 11 Say "Altura:  " Get nAltura  Pict "999"
@ 14, 11 Say "Largura: " Get nLargura Pict "999"
Read
IF LastKey() = ESC
	Return NIL
EndIF
::FonteManualLargura := nLargura
::FonteManualAltura  := nAltura
//SetMode(::FonteManualAltura, ::FonteManualLargura)
//Cls( ::CorFundo, ::PanoFundo, OK )
return( self )

method PreVisFonte() class TAmbiente
********************
LOCAL nFonte
LOCAL Selecionado  := 1
LOCAL nKey			 := 0
LOCAL cScreen      := SaveScreen()
LOCAL oTemp

nFonte         := Len( ::TabelaFonte )
nPos           := Ascan( ::TabelaFonte, ::Fonte )
Selecionado 	:= IF( nPos = 0, 1, nPos )
cPanoFundo		:= ::PanoFundo
cCormenu 		:= ::Cormenu
cCorCabec      := ::CorCabec
cCorFundo		:= ::CorFundo

oTemp           := TAmbienteNew()
oTemp:PanoFundo := cPanoFundo
oTemp:Cormenu	 := cCormenu
oTemp:CorCabec	 := cCorCabec
oTemp:CorFundo	 := cCorFundo

WHILE .T.
	Keyb( Chr( 27 ))
   oTemp:Show()
	oTemp:contareg("#" + StrZero(Selecionado,3) + "# {" + ::ModeMenu[Selecionado] + "}")
   M_Frame( ::Frame )
	M_Message("UP/DOWN, ENTER, ESC. #" + StrZero(Selecionado,3), ::Cormenu )
	nKey := Inkey(0)
	IF nKey == 27
		return Self 
	ElseIF nKey == 13
		exit
	ElseIF nKey == 5
		Selecionado := IIF( Selecionado == 1, nFonte, --Selecionado  )	
	ElseIF nKey == 24
		Selecionado := IIF( Selecionado == nFonte, 1, ++Selecionado  )
	EndIF	
	Eval( ::TabelaFonte[ Selecionado ])	
	Cls( ::CorFundo, ::PanoFundo, OK )
EndDo
::Fonte := Selecionado
Return Self

method SetaFonte() class TAmbiente
******************
LOCAL nLargura     := ::FonteManualLargura
LOCAL nAltura      := ::FonteManualAltura 
LOCAL nChoice      := 1

M_Title("SELECIONE MODO DE VIDEO")
nChoice := FazMenu( 03, 10, ::ModeMenu)
IF nChoice = 0
	Return
	
elseif nChoice = 21 // Definir Modo Manual
	::SetaFonteManual()
elseif nChoice = 22 // Visualiza pre-escolha
	::PreVisFonte()	
   nChoice := ::Fonte	
	//Return(Self)
endif	
Eval( ::TabelaFonte[ nChoice ])	
Cls( ::CorFundo, ::PanoFundo, OK )	
if Alert("LAYOUT;" + "Tamanho do buffer da tela;;" + "Largura:     " + Str( MS_MaxCol()) + ";Altura:      " + Str( MS_MaxRow()), {"Ok","Cancelar"}) == 1
	::Fonte := nChoice
else
	::FonteManualLargura  := nLargura
	::FonteManualAltura   := nAltura
   Eval( ::TabelaFonte[ ::Fonte])	
	Cls( ::CorFundo, ::PanoFundo, OK )	
endif		   
return(Self)

method ConfAmbiente() class TAmbiente
*********************		
		 IF ::Argumentos = 0
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 1
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 2
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 3
          ::Frame := "ÚÄ¿³ÙÄÀ³"
		 EndIF
		 ::Frame := "ÚÄ¿³ÙÄÀ³"
		 
       M_Frame( ::Frame )
       ::xBase           := ( ::Drive )
       ::TabelaFonte     := Array(21)
       ::TabelaFonte[01] := {|| SetMode(28, 132)}
		 ::TabelaFonte[02] := {|| SetMode(::AlturaFonteDefaultWindows, ::LarguraFonteDefaultWindows())}
       ::TabelaFonte[03] := {|| SetMode(25 , 80)}
       ::TabelaFonte[04] := {|| SetMode(28 , 80)}
		 ::TabelaFonte[05] := {|| SetMode(33 , 80)}
       ::TabelaFonte[06] := {|| SetMode(40 , 80)}
       ::TabelaFonte[07] := {|| SetMode(43 , 80)}
		 ::TabelaFonte[08] := {|| SetMode(50 , 80)}
       ::TabelaFonte[09] := {|| SetMode(25 , 132)}
       ::TabelaFonte[10] := {|| SetMode(28 , 132)}
		 ::TabelaFonte[11] := {|| SetMode(33 , 132)}
       ::TabelaFonte[12] := {|| SetMode(40 , 132)}
       ::TabelaFonte[13] := {|| SetMode(43 , 132)}
		 ::TabelaFonte[14] := {|| SetMode(50 , 132)}
       ::TabelaFonte[15] := {|| SetMode(25 , 160)}
       ::TabelaFonte[16] := {|| SetMode(28 , 160)}
		 ::TabelaFonte[17] := {|| SetMode(33 , 160)}
       ::TabelaFonte[18] := {|| SetMode(40 , 160)}
       ::TabelaFonte[19] := {|| SetMode(43 , 160)}
		 ::TabelaFonte[20] := {|| SetMode(50 , 160)}
       ::TabelaFonte[21] := {|| SetMode(::FonteManualAltura, ::FonteManualLargura)}
		 ::SetSet()

       IF ::Fonte > 1
		    Eval( ::TabelaFonte[ ::Fonte ] )
		 EndIF
       FT_Shadow( ::Sombra )       
		return( Self )

method SetSet() class TAmbiente
       Set Conf Off
		 Set Bell On
		 Set Scor Off
		 Set Wrap On
		 Set Mess To 22
		 Set Dele On
		 Set Date Brit
		 Set Deci To 2
		 Set Print To
		 Set Fixed On
		 SetCancel( .F. )
return( self )

method SetVar() class TAmbiente
        IF ::Visual != NIL
           ::Frame  := "ÉÐËÇÊÌÈ¶"
        Else
           ::Frame  := "ÚÄ¿³ÙÄÀ³"
        EndIF
        ::Sombra              := OK
        ::Mostrar_Desativados := OK
        ::Mostrar_Recibo      := OK
        ::PosiAgeInd          := FALSO
        ::PosiAgeAll          := FALSO
        ::Receposi            := FALSO
        ::lReceber            := OK
        ::cTipoRecibo         := "RECCAR"
        ::lGreenCard          := FALSO
        ::lComCodigoAcesso    := FALSO
        ::aFiscalIni          := NIL
        ::xLimite             := NIL
        ::_Empresa            := NIL
        ::xNomefir            := NIL
        ::xEmpresa            := NIL
        ::xJuroMesSimples     := 0
        ::xJuroMesComposto    := 1
        ::xFanta              := NIL
        ::aSciArray           := Array(1,8)
        ::aAtivo              := {}
        ::lContinuarAchoice   := FALSO
        ::lK_Insert           := FALSO
        ::CorMsg        := 47
        ::CorAlerta     := 75     // Cor do menu Alerta
        ::Fonte         := 1      // FlReset()
        ::CorBorda      := 16     // Cor da Borda
        ::CorAntiga     := 05
        ::CorCima       := 128
        ::CorBox        := 9
        ::CorCabec      := 59    // Cor do Cabecalho
        ::CorFundo      := 31    // Cor Pano de Fundo
        ::Selecionado   := 10    // Pano de Fundo Selecionado
        ::Ano2000       := DISABLE
        ::xUsuario      := "ADMIN"
        //::PanoFundo     := ::Panos[ ::Selecionado ]			 
return( self )

method SetModeMenu() class TAmbiente
********************

		::ModeMenu	 := { "Resetar Para Default Sistema",;
								"Tamanho Padrao da Janela do Windows",;
						      "25 x  80 - CGA EGA VGA Somente",;
								"28 x  80 - EGA VGA Somente",;
								"33 x  80 - EGA VGA Somente",;
								"40 x  80 - EGA VGA Somente",;
								"43 x  80 - EGA VGA Somente",;
								"50 x  80 - EGA VGA Somente",;								
								"25 x 132 - EGA VGA Somente",;
								"28 x 132 - EGA VGA Somente",;
								"33 x 132 - EGA VGA Somente",;
								"40 x 132 - EGA VGA Somente",;
								"43 x 132 - EGA VGA Somente",;
								"50 x 132 - EGA VGA Somente",;								
								"25 x 160 - EGA VGA Somente",;					
								"28 x 160 - EGA VGA Somente",;
								"33 x 160 - EGA VGA Somente",;
								"40 x 160 - EGA VGA Somente",;
								"43 x 160 - EGA VGA Somente",;						      
								"50 x 160 - EGA VGA Somente",;
								"Definir Layout Modo Manualmente",;
								"Testar Layout pre-definidos"}								
return( self:modemenu )								


method SetPano() class TAmbiente
        ::Panos         := ;
		  { "*#*#*°V±I²LÛM°A±R²:;*#*#*",;
		    "°E±V²IÛL¹I",;
			 "°±²²±°°±²³±Ä",;
		    " Macrosoft ", ;
          "Û²°±MacrosoftÛ±²°",;
          "°°°°°°°°°°±±±±±±±±±²²²²²²²²²²±±±±±±±±±±", ;
			 "°°°°°°°°°±±±±±±±±²²²²²²²²²±±±±±±±±±", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²±±²°²²", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²", ;
			 "±±°±²±²°±°±°°²°²±²±²²", ;
			 "°²±²±²°±²±°²°±²°²°²±", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²°", ;
			 "±±±±±±±°°°°°°°°", ;
			 "²²²²²²²±±±±±±", ;
			 "²²²²²²²±±±±±", ;
          "°±²Û²±°",;
			 " °±²Û²±°", ;
			 "  °°±±²²±±°°", ;
			 " °±²Û", ;
			 "°±²", ;
			 "Û", ;
			 "²", ;
			 "±", ;
          "°", ;
          "ÅÅ", ;
			 " ",;
          "þþþþþþþþþþþþþþ",;
			 "ß", "Ý", "?", "÷", "þ", "?", "?","?", "", "", "?", "?",;
			 "", "", "?", "?", "", "?", "	", "?", "?", "",;
			 "ú.ù,ú'ù.';ùþùú    ",;
          "ú.ù.'ú.'ù.ù'", ;
          "Macrosoft Informatica                                       ", ;
          "Macrosoft Informatica                                      ", ;
          "Macrosoft Informatica                                     ", ;
          "Macrosoft Informatica                                    ", ;
          "Macrosoft Informatica                                   ", ;
          "Macrosoft Informatica                                  ", ;
          "Macrosoft Informatica                                 ", ;
          "Macrosoft                                            ", ;
          "Macrosoft                                           ", ;
          "Macrosoft                                          ", ;
          "Macrosoft                                         ", ;
          "Macrosoft                                        ", ;
          "Macrosoft                                       ", ;
          "Macrosoft                                      ", ;
          "Macrosoft                                     ", ;
          "Macrosoft                                    ", ;
          "Macrosoft                                   ", ;
          "Macrosoft                                  ", ;
          "Macrosoft                                 ", ;
          "Macrosoft                                ", ;
          "Macrosoft                               ", ;
          "Macrosoft                              ", ;
          "Macrosoft                             ", ;
          "Macrosoft                            ", ;
          "Macrosoft                           ", ;
          "Macrosoft                          ", ;
          "Macrosoft                         ", ;
          "Macrosoft                        ", ;
          "Macrosoft                       ", ;
          "Macrosoft                      ", ;
          "Macrosoft                     ", ;
          "Macrosoft                    ", ;
          "Macrosoft                   ", ;
          "Macrosoft                  ", ;
          "Macrosoft                 ", ;
          "Macrosoft                ", ;
          "Macrosoft               ", ;
          "Macrosoft              ", ;
          "Macrosoft             ", ;
          "Macrosoft            ", ;
          "Macrosoft           ", ;
          "Macrosoft          ", ;
          "Macrosoft         ", ;
          "Macrosoft        ", ;
          "Macrosoft       ", ;
          "Macrosoft      ", ;
          "Macrosoft     ", ;
          "Macrosoft    ", ;
          "Macrosoft   ", ;
          "Macrosoft  ", ;
          "Macrosoft ", ;
          "Macrosoft","ÄÁÂ", "°±²Û", "²", "±", "Û", "°", "Î", " À¿", " É¼", "ÄÁÂ", " ", "ú.ù.'ú.'ù.ù'",;
          "À¿À¿",;
          "ÊËËÊ",;
          "ÁÂÂÁ",;
          "Ã´´Ã",;
          "¹ÌÌ¹",;
          "°°°°°±±±±±°°°°°²²²²²",;
          "ÍÊÍËÍËÍÊ",;
          "ÄÁÄÂÄÂÄÁ",;
          "=-",;
          ":-",;
          "%%",;
          "##",;
          "@@"}
			
	return( self:panos )
		
method SetaFrame() class TAmbiente
******************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 1
LOCAL aFrames := {"        ",;
						B_SINGLE,;
						B_DOUBLE,;
						B_SINGLE_DOUBLE,;
						B_DOUBLE_SINGLE,;
						HB_B_SINGLE_UNI,;
						HB_B_DOUBLE_UNI,;
						HB_B_SINGLE_DOUBLE_UNI,;
						HB_B_DOUBLE_SINGLE_UNI,;
						"ßßßÞÜÜÜÝ",;
						"ÛÛÛÛÛÛÛÛÛ",;
                  "ÉÐËÇÊÌÈ¶"}
						
M_Title("ESCOLHA O TIPO DE BORDA/FRAME")						
nChoice := Fazmenu( 03, 10, aFrames, ::Cormenu )
ResTela( cScreen )
IF nChoice = 0
	Return
EndIF
::Frame := aFrames[nChoice]
M_Frame( ::Frame )
Return Self

method xMenu() class TAmbiente
****************
	LOCAL AtPrompt := {}
	AADD( AtPrompt, {"I^nclusao",  {"S^ubMenu A","SubMenu B^","","Item D^esativado","Sub^Menu D"}})
	AADD( AtPrompt, {"A^lteraro",  {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"I^mpressao", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"C^onsulta",  {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"H^elp",      {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
return( AtPrompt )

method xDisp() class TAmbiente
****************
	LOCAL aDisp := {}
	Aadd( aDisp, { LIG, LIG, .F., .F., LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
return( aDisp )

method Limpa() class TAmbiente
   Cls( ::CorFundo, ::PanoFundo )
	::StatSup()
	::StatInf()
	return self

method StatSup( cCabecalho ) class TAmbiente
	LOCAL nTam  := ::MaxCol
	LOCAL nPos  := ( nTam - Len( ::StatusSup ))
	
	aPrint( 00 , 00 , "", nTam )
   aPrint( 00 , 00 , Padc( IF( cCabecalho = NIL, ::StatusSup, cCabecalho), nTam ),  ::CorCabec, nTam )   
	aPrint( 00 , ::MaxCol-17, Dtoc(Date()) + ' ' + (oAmbiente:Clock := Time()), omenu:corcabec)
	//aPrint( 00 , ( nTam-17),  Clock( 00, (nTam-17), ::CorCabec ), ::CorCabec )
	Return Self		
	
method StatInf( cMensagem ) class TAmbiente
	LOCAL nTam  := ::MaxCol
	LOCAL nCol  := MaxRow()
   LOCAL nPos  := ( nTam - Len(::CodiFirma + ':' + ::xUsuario + '/' + ::NomeFirma ))
	
	aPrint( nCol, 00 , "", nTam )
   aPrint( nCol, 00 , IF( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec, nTam )
   aPrint( nCol, nPos,  ::CodiFirma + ':' + ::xUsuario + '/' + ::NomeFirma, ::CorCabec )
return self
	
method StatReg( cMensagem, nCor ) class TAmbiente
	LOCAL nTam  := ::MaxCol	
	LOCAL nCol  := MaxRow()
	LOCAL nPos  := ( nTam - Len(::CodiFirma + ':' + ::xUsuario + '/' + ::NomeFirma ))
	DEFAU nCor TO ::CorCabec
	
	// ::StatInf("")		
	Print( nCol, 00 , IF( cMensagem = NIL, ::StatusInf, cMensagem), nCor, iif(nCor <> ::CorCabec, MaxCol()+1, nil))   
	//write( nCol, 00 , IF( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec ) 
return Self	
	
method SetaSombra() class TAmbiente
*********************************
	FT_Shadow( ::Sombra )
	Return Self	

method SetaCor( nTipo ) class TAmbiente
***********************
	LOCAL aTipo      := { ::CorMenu,;
								 ::CorCabec,;
								 ::CorFundo,;
								 ::CorDesativada,;
								 ::CorLightBar,;
								 ::CorHotKey,;
								 ::CorHKLightBar,;
								 ::CorAlerta,;
								 ::CorMsg,;
								 ::CorBorda,;
	}

	LOCAL    cPanoFundo 	:= ::PanoFundo
	LOCAL       cScreen	:= SaveScreen()
	LOCAL         xTipo  := IF( nTipo = NIL, 1, nTipo )
	LOCAL        xColor	:= aTipo[ xTipo ]
	LOCAL        CorAnt	:= aTipo[ xTipo ]
	LOCAL lManterScreen 	:= FALSO
	LOCAL         oTemp 	:= TAmbienteNew()  // Cria nova instancia do Objeto
	LOCAL     nLenAtipo  := Len( aTipo )
	LOCAL          ikey

	WHILE (OK)	
		oTemp:CorMenu           := aTipo[ 1 ]
		oTemp:CorCabec          := aTipo[ 2 ]
		oTemp:CorFundo		      := aTipo[ 3 ]
		oTemp:CorDesativada     := aTipo[ 4 ]	
		oTemp:CorLightBar       := aTipo[ 5 ]
		oTemp:CorHotKey         := aTipo[ 6 ]	
		oTemp:CorHKLightBar     := aTipo[ 7 ]
		oTemp:CorAlerta         := aTipo[ 8 ]	
		oTemp:CorMsg            := aTipo[ 9 ]	
		oTemp:CorBorda          := aTipo[10 ]	
		
		oTemp:PanoFundo 	      := cPanoFundo
		oTemp:StatusSup 	      := "TESTE DE COR - Cabecalho"
		oTemp:StatusInf         := "TESTE DE COR - Rodape"

		Keyb( Chr(27))
		oTemp:Show(lManterScreen := OK)
		M_Frame( ::Frame )
		M_Message("COR ATUAL : "+ StrZero( xColor, 3 ) + " - Enter para Escolher ou ESCape", xColor )
		Ikey := InKey( 0 )
		if ( Ikey == 24)
			aTipo[ xTipo ] := ( XColor  := IIF( xColor  == 0, 255, --xColor  ))
		elseif ( Ikey == 5)
			( aTipo[ xTipo ] ) :=  ( xColor	:= IIF( xColor  == 255, 0, ++xColor  ))
		elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
			 Exit
		endif
		 
		Do case
		Case nTipo = 1 // cormenu
			aTipo[ 4 ] := AscanCorDesativada(aTipo[1])	
			aTipo[ 5 ] := Roloc(aTipo[1])
			aTipo[ 6 ] := AscanCorHotKey( aTipo[1])	
			aTipo[ 7 ] := AscanCorHKLightBar( aTipo[5])		
		Case nTIpo = 5 // CorLightBar
			aTipo[ 6 ] := AscanCorHotKey(aTipo[1])	
			aTipo[ 7 ] := AscanCorHKLightBar( aTipo[5])
		EndCase
	enddo
	::CorMenu           := aTipo[ 1 ]
	::CorCabec          := aTipo[ 2 ]
	::CorFundo	        := aTipo[ 3 ]
	::CorDesativada     := aTipo[ 4 ]
	::CorLightBar       := aTipo[ 5 ]
	::CorHotKey         := aTipo[ 6 ]
	::CorHKLightBar     := aTipo[ 7 ]	
	::CorAlerta         := aTipo[ 8 ]	
	::CorMsg            := aTipo[ 9 ]	
	::CorBorda          := aTipo[10 ]	
	ResTela( cScreen )
return SeLF

method SetaPano() class TAmbiente
*****************
	LOCAL nPano
	LOCAL Selecionado  := 1
	LOCAL nKey			 := 0
	LOCAL cScreen      := SaveScreen()
	LOCAL oTemp

	Aadd( ::Panos, TokenUpper(::xUsuario))
	nPano          := Len( ::Panos )
	nPos           := Ascan( ::Panos, ::Panofundo )
	Selecionado 	:= IF( nPos = 0, 1, nPos )
	cPanoFundo		:= ::PanoFundo
	cCormenu 		:= ::Cormenu
	cCorCabec      := ::CorCabec
	cCorFundo		:= ::CorFundo

	oTemp           := TAmbienteNew()
	oTemp:PanoFundo := cPanoFundo
	oTemp:Cormenu	 := cCormenu
	oTemp:CorCabec	 := cCorCabec
	oTemp:CorFundo	 := cCorFundo

	WHILE .T.
		Keyb( Chr( 27 ))
		oTemp:Show()
		M_Frame( ::Frame )
		M_Message("Use as setas CIMA e BAIXO para trocar, ENTER para aceitar. N§ " + StrZero( Selecionado, 3 ), ::Cormenu )
		nKey := Inkey(0)
		IF ( nKey == 27 .OR. nKey = 13 )
			Exit
		ElseIF nKey == 24
			Selecionado := IIF( Selecionado == 1, nPano, --Selecionado  )
		ElseIF nKey == 5
			Selecionado := IIF( Selecionado == nPano, 1, ++Selecionado  )
		EndIF
		oTemp:PanoFundo := ::Panos[ Selecionado ]
	EndDo
	::PanoFundo := ::Panos[ Selecionado ]
Return Self

method MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor ) class TAmbiente
******************************************************************************
   LOCAL cPanoFundo := " " 
   LOCAL nCor       := IF( lInverterCor = NIL, ::Cormenu,  lInverterCor )
   LOCAL pback
   
   //DispWHILE OK()
   IF nDireita = 79
   	nDireita = ::MaxCol
   EndIf
   ColorSet( @nCor, @pback )
   Box( nTopo, nEsq, nFundo, nDireita, ::Frame + cPanoFundo, nCor )
   IF Cabecalho != Nil
   	aPrint( nTopo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( nCor ))
   EndIF
   IF Rodape != Nil
   	aPrint( nFundo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( nCor ))
   EndIF
   cSetColor( SetColor())
   nSetColor( nCor, Roloc( nCor ))
   //DispEnd()
return 

method AumentaEspacoMenu(nSp) class TAmbiente
	LOCAL nTam    := Len(::menu)
	LOCAL cSpMais := Space(IF(nSp == nil, nSp := 1, nSp))
	LOCAL nX
	
	for nX := 1 To nTam
	   ::menu[nX,1] := AllTrim(::menu[nX,1])
	   ::menu[nX,1] := cSpMais + ::menu[nX,1] + cSpMais
	next
	return( self )

method Show(lManterScreen) class TAmbiente
*************************
   LOCAL MenuClone := aClone( ::menu )
	LOCAL nSpMais   := 0
   LOCAL nChoice
	
	::Limpa()
	::StatSup()
   ::StatInf()
	IF( lManterScreen == nil , lManterScreen := FALSO , lManterScreen)
   M_Frame( ::Frame )
   //::nPos := 2
	if nSpMais > 1
		::AumentaEspacoMenu(nSpMais)
	endif	
   nChoice := ::MsMenu( 1, lManterScreen )
	::menu  := Aclone( MenuClone)
	::StatSup()
   ::StatInf()
	return (nChoice )
	
	
method MsMenu( nLinha, lManterScreen ) class TAmbiente
**************************************
LOCAL cScreen	 := SaveScreen() // nLinha+1, 00, MaxRow(), MaxCol())
LOCAL nMaxCol   := ::MaxCol
LOCAL xScreen
LOCAL nSoma 	 := 0
LOCAL nX 		 := 0
LOCAL nDireita  := 0
LOCAL nVal		 := 1
LOCAL nMaior	 := 1
LOCAL nRetorno  := 0.0
LOCAL cmenu 	 := ""
LOCAL cPrinc	 := ""
LOCAL nKey		 := 0
LOCAL nMax		 := 0
LOCAL nBaixo	 := 0
LOCAL nTam      := 0
LOCAL nTamSt	 := 0
LOCAL nCorrente := 1
LOCAL aNew		 := {}
LOCAL aSelecao  := {}
LOCAL oP 		 := 0
LOCAL cJanela
LOCAL nScr1
LOCAL nScr2
LOCAL nScr3
LOCAL nScr4

nLinha := IF( nLinha = NIL, 0, nLinha )
WHILE OK
	nSoma 	 := 0
	nX 		 := 0
	nDireita  := 0
	nVal		 := 1
	nMaior	 := 1
	nRetorno  := 0.0
	cmenu 	 := ""
	cPrinc	 := ""
	nKey		 := 0
	nMax		 := 0
	oP 		 := 0
	nBaixo	 := 0
	nTamSt	 := 0
	nCorrente := 1
	aNew		 := {}
	aSelecao  := {}
	nTam      := 0
	//::Limpa()
   ::MSmenuCabecalho( nLinha, ::nPos )
   FOR nX := 2 To ::nPos
      nSoma += Len( ::menu[nX-1,1]) + 1 
	Next
	nX := 0
   
	FOR nX := 1 To Len( ::menu[ ::nPos, 2])
      IF Empty( ::menu[::nPos,2, nX ])
			Aadd( aNew, "")
			Aadd( aSelecao, ENABLE )
		Else
         Aadd( aNew, "  " + ::menu[::nPos,2, nX ] + "  " )
         Aadd( aSelecao, ::Disp[::nPos, nX ])
		EndIF
      nTamSt := Len( ::menu[::nPos,2, nX ]) + 2
		IF nTamSt > nVal
			nVal	 := nTamSt
			nMaior := nX
		EndIF
	Next
	
   nDireita  := Len( ::menu[::nPos, 2, nMaior])+5
   nBaixo    := Len( ::menu[::nPos, 2])
	nTam		 := nDireita + nSoma
	nMax		 := IF( nTam > nMaxCol, nMaxCol, nTam )
	nSoma 	 := IF( nTam > nMaxCol, (nSoma-( nTam-nMaxCol)) , nSoma )
	nSoma 	 := IF( nSoma < 0, 0, nSoma )
	nScr1 	 := 01+nLinha
	nScr2 	 := 00
	nScr3 	 := MaxRow()-1
	nScr4 	 := ::MaxCol
	xScreen	 := SaveScreen( nScr1, nScr2, nScr3, nScr4 )
   Box( 01+nLinha, nSoma, 02+nBaixo+nLinha, nMax, ::Frame, ::CorMenu )
	oP 		  := ::MsProcessa( 02+nLinha, nSoma+1, 02+nBaixo+nLinha, nMax-1, aNew, aSelecao )
	IF !lManterScreen
	   RestScreen( nScr1, nScr2, nScr3, nScr4, xScreen )
	EndIF	
	cPrinc   := Str( ::nPos, 2 )
	cMenu 	:= StrZero( oP, 2 )
   nMax     := Len( ::Menu )
	nKey		:= LastKey()
	nRetorno := Val( cPrinc + "." + cmenu )
   
	DO Case
      Case nKey = 13 .OR. nKey = K_SPACE
         IF aSelecao[oP] // Item Ativo?
            Return( nRetorno )
         Else
            Alerta("ERRO: Item Desativado")
         EndIF
		Case nKey = 27 .OR. nKey = TECLA_ALT_F4
			Return( 0 )
		Case nKey = SETA_DIREITA
         ::nPos++
		Case nKey = SETA_ESQUERDA
         ::nPos--
      Case nKey = K_HOME .OR. nKey = K_CTRL_PGUP .OR. nKey = K_PGUP
         ::nPos := 1
      Case nKey = K_END .OR. nKey = K_CTRL_PGDN .OR. nKey = K_PGDN
         ::nPos := nMax
		OtherWise
			Eval( SetKey( nKey ))
	EndCase
   ::nPos := IF( ::nPos > nMax, 1,    ::nPos )
   ::nPos := IF( ::nPos < 1,    nMax, ::nPos )
EndDo
return 

method MSMenuCabecalho( nLinha, nPos ) class TAmbiente
***********************************
   LOCAL nMax    := ::MaxCol
	LOCAL nSoma   := 0
	LOCAL nSoma1  := 0
   LOCAL nX 	  := 0
   LOCAL nTam    := Len(::menu)
	LOCAL aHotKey := Array(nTam)
	LOCAL aRow    := Array(nTam)
	LOCAL aCol    := Array(nTam)
	LOCAL cHotKey := Space(0)
	LOCAL nLen
	LOCAL cMenu
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew
	
	aPrint( nLinha, 00, " ", ::Cormenu, nMax )
	FOR nX := 1 To nTam
		cMenu   := ::menu[nX,1]
     	cHotKey := Space(0)
		nSoma1  := 0
		StrHotKey(@cMenu, @cHotKey, 1)
		IF (nSoma1 := Len(cHotKey)) > 1 
		   cHotKey := Right(cHotKey,1)
		EndIF
		nSoma1--		
		::menu[nX,1]:= cMenu
		aHotKey[nX] := cHotKey
		nLen        := Len( ::menu[nX,1])
		aRow[nX]    := nLinha	
		aCol[nX]    := nSoma	+ nSoma1
		aPrint( nLinha,   nSoma,    cMenu,       IF( nPos = nX, ::CorLightBar,   ::CorMenu ))
		aPrint( aRow[nX], aCol[nX], aHotKey[nX], IF( nPos = nX, ::CorHKLightBar, ::CorHotKey ))
	   nSoma    += nLen + 1
		nSoma1   += nLen + 1
   Next
return

Function StrHotKey(cMenu, cHotKey, nMenuOuSubMenu)
**************************************************
   LOCAL cChar   := "^"
	LOCAL cSwap   := Space(0)
	LOCAL nDel    := 0
	LOCAL nPos    := 3
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew

	IF( nMenuOuSubMenu == 1, nPos := 3, nPos := 4)
	nConta := StrCount( cChar, cMenu )
	if nConta <= 0  // sem cChar ?
	   cMenu := Stuff( cMenu, nPos, nDel, cChar )
	endif		
	nConta := StrCount( cChar, cMenu )
	if nConta >0
	   cHotKey := StrExtract(cMenu, cChar, 1 )
	   cMenu   := StrSwap(cMenu, cChar, 1, cSwap)
   endif
return	

method MSProcessa( nCima, nEsquerda, nBaixo, nDireita, aNew, aSelecionado ) class TAmbiente
***************************************************************************
	LOCAL nX 	  := 1
	LOCAL nTam	  := Len( aNew )
	LOCAL aHotKey := Array(nTam)
	LOCAL aRow    := Array(nTam)
	LOCAL aCol    := Array(nTam)
	LOCAL nRow	  := nCima-1
	LOCAL nMax	  := nTam
	LOCAL nTamSt  := ( nDireita - nEsquerda ) + 1
	LOCAL nKey	  := 1
	LOCAL nConta  := 0
	LOCAL cSep
   LOCAL cMenu
	LOCAL cStr
	LOCAL cNew
	STATI nItem   
	
	nItem := ::ativo
	IF ::Visual != NIL
		if ::Frame == B_SINGLE
			cSep := 'Ã' + Repl( 'Ä', nTamSt ) + '´'
		else	
			 device changed by admin
2016.06.15-16:54:45 <10.0.0.5>: wireless,info rb433.centro: 14:A3:64:25:F7:99@SyberNET.HotSpot: connected
2016.06.15-16:54:48 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:54:54 <10.0.0.5>: wireless,info rb433.centro: E0:98:61:67:7F:03@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:54:58 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:01 <10.0.0.5>: wireless,info rb433.centro: 48:59:29:FA:FB:63@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:55:05 <10.0.0.5>: wireless,info rb433.centro: 9C:D9:17:D2:35:B7@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:55:05 <10.0.0.5>: wireless,info rb433.centro: 48:59:29:FF:FE:C4@SyberNET.HotSpot: connected
2016.06.15-16:55:08 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:09 <10.0.0.5>: wireless,info rb433.centro: 14:A3:64:25:F7:99@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:55:14 <10.0.0.5>: wireless,info rb433.centro: SyberNET.HotSpot: data from unknown device 14:A3:64:25:F7:99, sent deauth
2016.06.15-16:55:18 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:28 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:29 <10.0.0.5>: wireless,info rb433.centro: 48:59:29:FF:FE:C4@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:55:30 <10.0.0.5>: wireless,info rb433.centro: 04:FE:31:3A:7A:5C@SyberNET.HotSpot: connected
2016.06.15-16:55:32 <10.0.0.5>: wireless,info rb433.centro: 9C:D9:17:D2:35:B7@SyberNET.HotSpot: connected
2016.06.15-16:55:33 <10.0.0.5>: wireless,info rb433.centro: 3C:BB:FD:83:FC:12@SyberNET.HotSpot: connected
2016.06.15-16:55:38 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:43 <10.0.0.5>: wireless,info rb433.centro: 3C:BB:FD:83:FC:12@SyberNET.HotSpot: disconnected, received disassoc: sending station leaving (8)
2016.06.15-16:55:44 <10.0.0.5>: wireless,info rb433.centro: 3C:BB:FD:83:FC:12@SyberNET.HotSpot: connected
2016.06.15-16:55:48 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:55:58 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:56:00 <10.0.0.5>: wireless,info rb433.centro: 04:FE:31:3A:7A:5C@SyberNET.HotSpot: disconnected, received disassoc: sending station leaving (8)
2016.06.15-16:56:00 <10.0.0.5>: wireless,info rb433.centro: SyberNET.HotSpot: data from unknown device 04:FE:31:3A:7A:5C, sent deauth
2016.06.15-16:56:00 <10.0.0.5>: wireless,info rb433.centro: SyberNET.HotSpot: data from unknown device 04:FE:31:3A:7A:5C, sent deauth
2016.06.15-16:56:00 <10.0.0.5>: wireless,info rb433.centro: SyberNET.HotSpot: data from unknown device 04:FE:31:3A:7A:5C, sent deauth
2016.06.15-16:56:08 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:56:14 <10.0.0.5>: wireless,info rb433.centro: 9C:65:B0:F3:B4:B7@SyberNET.HotSpot: connected
2016.06.15-16:56:16 <10.0.0.5>: wireless,info rb433.centro: 9C:D9:17:D2:35:B7@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:56:18 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:56:28 <10.0.0.5>: system,info rb433.centro: device changed by admin
2016.06.15-16:56:31 <10.0.0.5>: wireless,info rb433.centro: 48:59:29:FF:FE:C4@SyberNET.HotSpot: connected
2016.06.15-16:56:33 <10.0.0.5>: wireless,info rb433.centro: 3C:BB:FD:83:FC:12@SyberNET.HotSpot: disconnected, extensive data loss
2016.06.15-16:56:35 <10.0.0.5>: wireless,info rb433.centro: 9C:D9:17:D2:35:B7@SyberNET.HotSpot: connected
2016.06.15-16:56:38 <10.0.0.5>: wireless,info rb433.centro: SyberNET.HotSpot: data from unknown device 3C:BB:FD:83:FC:12, sent deauth
2016.06.15-16:56:38 <10.0.0.5>: 