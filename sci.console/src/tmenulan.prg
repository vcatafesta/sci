#include "HBclass.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"

#Define FALSO               .F.
#Define OK                  .T.
#define SETA_CIMA           5
#define SETA_BAIXO          24
#define SETA_ESQUERDA       19
#define SETA_DIREITA        4
#define TECLA_SPACO         32
#define TECLA_ALT_F4        -33
#define ENABLE              .T.
#define DISABLE             .F.
#define LIG                 .T.
#define DES                 .F.
#define ESC                 27
#define ENTER               13

CLASS TMenu INHERIT TAmbiente
    Export:
        Var Frame         //INHERITS FROM TAmbiente()
        Var CorMenu       //INHERITS FROM TAmbiente()
		  Var CorLightBar   //INHERITS FROM TAmbiente()
		  Var CorHotKey     //INHERITS FROM TAmbiente()    
		  Var CorHKLightBar //INHERITS FROM TAmbiente()
        
		  Var Sombra        //INHERITS FROM TAmbiente()
        Var CorCabec      //INHERITS FROM TAmbiente()
        Var CorBorda      //INHERITS FROM TAmbiente()
        Var CorFundo      //INHERITS FROM TAmbiente()
        Var CorDesativada //INHERITS FROM TAmbiente()
        
        Var Visual        //INHERITS FROM TAmbiente()
        Var Usuario       //INHERITS FROM TAmbiente()
        Var Selecionado   //INHERITS FROM TAmbiente()
        Var CorAntiga     //INHERITS FROM TAmbiente()
        Var CorCabec      //INHERITS FROM TAmbiente()
        Var CorAlerta     //INHERITS FROM TAmbiente()
        Var CorBox        //INHERITS FROM TAmbiente()
        Var CorCima       //INHERITS FROM TAmbiente()
        Var Fonte         //INHERITS FROM TAmbiente()
        Var CorMsg        //INHERITS FROM TAmbiente()
        Var TabelaFonte   //INHERITS FROM TAmbiente()
        Var StatusSup           INIT "MicroBras"
        Var StatusInf           INIT ""     
        Var Menu                INIT xMenu()
        Var Disp		           INIT xDisp()
  
        Var NomeFirma INIT "VCATAFESTA@GMAIL.COM"
        Var Codifirma INIT '0001'
        Var Alterando INIT FALSO
		  Var nPos      INIT 1
		  Var Ativo
        Var StSupArray
        Var StInfArray
        Var MenuArray
        Var DispArray

        //METHOD New CONSTRUCTOR
        METHOD Show
        METHOD SetaCor
        METHOD SetaFrame
        METHOD SetaPano
        METHOD SetaBorda
        METHOD SetaSombra
        METHOD StatInf
        METHOD StatSup
        METHOD Limpa
        METHOD MaBox
        METHOD MSMenuCabecalho
        METHOD MSProcessa
        METHOD MSMenu
        METHOD SetaCorMsg
        METHOD SetaCorAlerta
        METHOD SetaFonte
		  METHOD SetVar
		  METHOD SetPano
        METHOD Refresh
ENDCLASS

/*
Method New()
		 ::setvar()	
       ::StatusSup      := "MicroBras"
       ::StatusInf      := ""
		 ::Panos          := self:super:panos
		 ::Menu           := xMenu()
       ::Disp           := xDisp()
       ::Alterando      := FALSO
       ::Ativo          := 1
       ::nPos           := 1
       ::NomeFirma      := "MICROBRAS COM DE PROD DE INFORMATICA LTDA"
       ::Codifirma      := '0001'
       ::Visual         := Self:Super:Visual
       ::StSupArray     := { ::StatusSup }
       ::StInfArray     := { ::StatusInf }
       ::MenuArray      := { ::Menu }
       ::DispArray      := { ::Disp }
       return( Self )
*/

Method SetaFonte()
******************
LOCAL nChoice   := 1
STATIC aModeMenu	 := { "Resetar Fonte Para Normal",;
						      "25x80 Linhas - CGA EGA VGA Somente",;
								"25x132 Linhas - CGA EGA VGA Somente",;
								"25x160 Linhas - CGA EGA VGA Somente",;
								"28x80 Linhas - CGA EGA VGA Somente",;
								"28x132 Linhas - CGA EGA VGA Somente",;
								"28x160 Linhas - CGA EGA VGA Somente",;
								"33x80 Linhas - CGA EGA VGA Somente",;
								"33x132 Linhas - CGA EGA VGA Somente",;
								"33x160 Linhas - CGA EGA VGA Somente",;
								"40x80 Linhas - CGA EGA VGA Somente",;
								"40x132 Linhas - CGA EGA VGA Somente",;
								"40x160 Linhas - CGA EGA VGA Somente",;
								"43x80 Linhas - EGA & VGA Somente",;
						      "50x80 Linhas - VGA Somente",;
								"Definir Modo Manual"}
	M_Title("SELECIONE MODO DE VIDEO")
	nChoice := FazMenu( 03, 10, aModeMenu)
	if nChoice = 0
		return
	endif
	oAmbiente:Fonte := nChoice
   oMenu:Fonte     := nChoice
	Eval( oAmbiente:TabelaFonte[ nChoice] )
   return(Self)
		
Method SetVar()
***************
return (self:super:SetVar())

Method SetaFrame()
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
if nChoice = 0
	return
endif
::Frame := aFrames[nChoice]
M_Frame( ::Frame )
return Self

Function xMenu()
****************
	LOCAL AtPrompt := {}
	AADD( AtPrompt, {"I^nclusao", {"S^ubMenu A","SubMenu B^","SubM^enu C","Sub^Menu D"}})
	AADD( AtPrompt, {"A^lteraro", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"I^mpressao", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"C^onsulta", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
	AADD( AtPrompt, {"H^elp", {"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
return( AtPrompt )

Function xDisp()
****************
	LOCAL aDisp := {}
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
	Aadd( aDisp, { LIG, LIG, LIG, LIG, LIG, LIG , LIG})
return( aDisp )

Method Limpa
   Cls( ::CorFundo, ::PanoFundo )
return Self

Method StatInf( cMensagem )
	LOCAL nCol  := LastRow()
	LOCAL nTam  := MaxCol()
   LOCAL nPos  := ( nTam - Len(::Codifirma + ':' + oAmbiente:xUsuario + '/' + ::NomeFirma ))
   aPrint( nCol, 00,    if( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec, MaxCol() )
   aPrint( nCol, nPos,  ::Codifirma + ':' + oAmbiente:xUsuario + '/' + ::NomeFirma, ::CorCabec )
return Self

Method StatSup( cCabecalho )
		  LOCAL nTam  := MaxCol()
		  LOCAL nPos  := ( nTam - Len( ::StatusSup ))
        aPrint( 00, 00, Padc( if( cCabecalho = NIL, ::StatusSup, cCabecalho), nTam ),  ::CorCabec, nTam )
        aPrint( 00, ( nTam-8), Clock( 00, (nTam-8), ::CorCabec ), ::CorCabec )
		  return Self

Method SetaCor( nTipo )
***********************
LOCAL aTipo      := { ::CorMenu,;
                      ::CorCabec,;
							 ::CorFundo,;
							 ::CorDesativada,;
							 ::CorLightBar,;
							 ::CorHotKey,;
							 ::CorHKLightBar;
}
LOCAL cPanoFundo    := ::PanoFundo
LOCAL cScreen	     := SaveScreen()
LOCAL xTipo         := if( nTipo = NIL, 1, nTipo )
LOCAL xColor	     := aTipo[ xTipo ]
LOCAL CorAnt	     := aTipo[ xTipo ]
LOCAL lManterScreen := FALSO
LOCAL oTemp         := TMenuNew()  // Cria nova instancia do Objeto
LOCAL ikey

WHILE (OK)
   oTemp:CorMenu           := aTipo[ 1 ]
   oTemp:CorCabec          := aTipo[ 2 ]
	oTemp:CorFundo		      := aTipo[ 3 ]
	oTemp:CorDesativada     := aTipo[ 4 ]
	oTemp:CorLightBar       := aTipo[ 5 ]
	oTemp:CorHotKey         := aTipo[ 6 ]
	oTemp:CorHKLightBar     := aTipo[ 7 ]	
	oTemp:PanoFundo 	      := cPanoFundo
	oTemp:StatusSup 	      := "TESTE DE COR - Cabecalho"
	oTemp:StatusInf         := "TESTE DE COR - Rodape"

	Keyb( Chr(27))
   oTemp:Show(lManterScreen := OK)
   M_Frame( ::Frame )
	M_Message("COR ATUAL : "+ StrZero( xColor, 3 ) + " - Enter para Escolher ou ESCape", xColor )
	Ikey := InKey( 0 )
	if ( Ikey == 24)
		aTipo[ xTipo ] := ( XColor  := Iif( xColor  == 0, 255, --xColor  ))
	elseif ( Ikey == 5)
		( aTipo[ xTipo ] ) :=  ( xColor	:= Iif( xColor  == 255, 0, ++xColor  ))
	 elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 endif
EndDO
::CorMenu		     := aTipo[ 1 ]
::CorCabec          := aTipo[ 2 ]
::CorFundo		     := aTipo[ 3 ]
::CorDesativada     := aTipo[ 4 ]
::CorLightBar       := aTipo[ 5 ]
::CorHotKey         := aTipo[ 6 ]
::CorHKLightBar     := aTipo[ 7 ]
ResTela( cScreen )
return SeLF
	  
Method SetaCorMsg()
*******************
LOCAL cScreen	  := SaveScreen()
LOCAL aTipo      := { ::CorMenu,;
                      ::CorCabec,;
							 ::CorFundo,;
							 ::CorDesativada,;
							}

LOCAL cPanoFundo := ::PanoFundo
LOCAL xColor     := ::CorMsg
LOCAL ikey
LOCAL oTemp                := TMenuNew()
      oTemp:CorMenu        := aTipo[ 1 ]
      oTemp:CorCabec       := aTipo[ 2 ]
		oTemp:CorFundo		   := aTipo[ 3 ]
		oTemp:CorDesativada  := aTipo[ 4 ]
		oTemp:PanoFundo 	   := cPanoFundo
      oTemp:StatusSup      := "TESTE DE COR - Box de Confirmacao"
      oTemp:StatusInf      := "TESTE DE COR"

WHILE .T.
	Keyb( Chr( 27 ))
   oTemp:Show()
   M_Frame( ::Frame )
	M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	if ( Ikey == 24)
      ::CorMsg := ( XColor  := Iif( xColor  == 0, 255, --xColor  ))
	elseif ( Ikey == 5)
      ::CorMsg :=  ( xColor  := Iif( xColor  == 255, 0, ++xColor  ))
	 elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 endif
End
ResTela( cScreen )
return SeLF

Method SetaCorAlerta()
**********************
LOCAL cScreen	  := SaveScreen()
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo, ::CorDesativada }
LOCAL cPanoFundo := ::PanoFundo
LOCAL xColor     := ::CorAlerta
LOCAL ikey
LOCAL oTemp                := TMenuNew()
      oTemp:CorMenu        := aTipo[ 1 ]
      oTemp:CorCabec       := aTipo[ 2 ]
		oTemp:CorFundo	      := aTipo[ 3 ]
		oTemp:CorDesativada  := aTipo[ 4 ]
		oTemp:PanoFundo 	   := cPanoFundo
      oTemp:StatusSup      := "TESTE DE COR - Mensagem de Alerta"
		oTemp:StatusInf 	   := "TESTE DE COR"

WHILE (OK)
	Keyb( Chr( 27 ))
   oTemp:Show()
   M_Frame( ::Frame )
	M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	if ( Ikey == 24)
      ::CorAlerta := ( XColor  := Iif( xColor  == 0, 255, --xColor  ))
	elseif ( Ikey == 5)
      ::CorAlerta :=  ( xColor  := Iif( xColor  == 255, 0, ++xColor  ))
	 elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 endif
End
ResTela( cScreen )
return SeLF

Method SetaSombra
*****************
FT_Shadow( ::Sombra )
return Self

Method SetaBorda
****************
LOCAL aTipo      := { ::Cormenu, ::CorCabec, ::CorFundo }
LOCAL cPanoFundo := ::PanoFundo
LOCAL cScreen	  := SaveScreen()
LOCAL xColor	  := ::CorBorda
LOCAL ikey
LOCAL oTemp           := TMenuNew()
		oTemp:Cormenu	 := aTipo[ 1 ]
      oTemp:CorCabec  := aTipo[ 2 ]
		oTemp:CorFundo	 := aTipo[ 3 ]
		oTemp:CorBorda	 := ::CorBorda
		oTemp:PanoFundo := cPanoFundo
		oTemp:StatusSup := "TESTE DE COR DE BORDA"
		oTemp:StatusInf := oTemp:StatusSup

WHILE .T.
	Keyb( Chr( 27 ))
   oTemp:Show()
   M_Frame( ::Frame )
	M_Message("Cor Borda Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	if ( Ikey == 24)
		XColor  := Iif( xColor	== 0, 63, --xColor  )
		oTemp:CorBorda	:= xColor
		::CorBorda		:= xColor
	elseif ( Ikey == 5)
		xColor  := Iif( xColor	== 63, 0, ++xColor  )
		oTemp:CorBorda	:= xColor
		::CorBorda		:= xColor
	 elseif ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 endif
	 //Border( ::CorBorda )
End
//Border( ::CorBorda )
ResTela( cScreen )
return SeLF

Method SetaPano
***************
LOCAL nPano
LOCAL Selecionado  := 1
LOCAL nKey			 := 0
LOCAL cScreen      := SaveScreen()
LOCAL oTemp

Aadd( ::Panos, TokenUpper(oAmbiente:xUsuario))
nPano          := Len( ::Panos )
nPos           := Ascan( ::Panos, ::Panofundo )
Selecionado 	:= if( nPos = 0, 1, nPos )
cPanoFundo		:= ::PanoFundo
cCormenu 		:= ::Cormenu
cCorCabec      := ::CorCabec
cCorFundo		:= ::CorFundo

oTemp           := TMenuNew()
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
	if ( nKey == 27 .OR. nKey = 13 )
		Exit
	elseif nKey == 24
		Selecionado := Iif( Selecionado == 1, nPano, --Selecionado  )
	elseif nKey == 5
		Selecionado := Iif( Selecionado == nPano, 1, ++Selecionado  )
	endif
	oTemp:PanoFundo := ::Panos[ Selecionado ]
EndDo
::PanoFundo := ::Panos[ Selecionado ]
return Self

Method MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
******************************************************************************
   LOCAL cPanoFundo := " " 
   LOCAL nCor       := if( lInverterCor = NIL, ::Cormenu,  lInverterCor )
   LOCAL pback
   
   //DispBegin()
   if nDireita = 79
   	nDireita = MaxCol()
   endif
   ColorSet( @nCor, @pback )
   Box( nTopo, nEsq, nFundo, nDireita, ::Frame + cPanoFundo, nCor )
   if Cabecalho != Nil
   	aPrint( nTopo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( nCor ))
   endif
   if Rodape != Nil
   	aPrint( nFundo, nEsq+1, "Û", Roloc( nCor ), (nDireita-nEsq)-1)
   	aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( nCor ))
   endif
   cSetColor( SetColor())
   nSetColor( nCor, Roloc( nCor ))
   //DispEnd()
return 

Method Show(lManterScreen)
*************************
   LOCAL nChoice
	
	if( lManterScreen == NIL, lManterScreen := FALSO, lManterScreen)
	Cls( ::CorFundo, ::PanoFundo )
   M_Frame( ::Frame )
   //::nPos := 2
   ::StatSup()
   ::StatInf()
return( nChoice := ::MsMenu( 1, lManterScreen ))

Method MsMenu( nLinha, lManterScreen )
**************************************
LOCAL cScreen	 := SaveScreen( nLinha+1, 00, MaxRow()-1, MaxCol())
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
LOCAL oP 		 := 0
LOCAL nBaixo	 := 0
LOCAL nTam		 := 0
LOCAL nTamSt	 := 0
LOCAL nCorrente := 1
LOCAL aNew		 := {}
LOCAL aSelecao  := {}
LOCAL cJanela
LOCAL nScr1
LOCAL nScr2
LOCAL nScr3
LOCAL nScr4

nLinha := if( nLinha = NIL, 0, nLinha )
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
	nTam		 := 0
	nTamSt	 := 0
	nCorrente := 1
	aNew		 := {}
	aSelecao  := {}
   ::MSmenuCabecalho( nLinha, ::nPos )
   FOR nX := 2 To ::nPos
      nSoma += Len( ::menu[nX-1,1]) 
	Next
	nX := 0
   FOR nX := 1 To Len( ::menu[ ::nPos, 2])
      if Empty( ::menu[::nPos,2, nX ])
			Aadd( aNew, "")
			Aadd( aSelecao, ENABLE )
		else
         Aadd( aNew, "  " + ::menu[::nPos,2, nX ] + "  " )
         Aadd( aSelecao, ::Disp[::nPos, nX ])
		endif
      nTamSt := Len( ::menu[::nPos,2, nX ]) + 2
		if nTamSt > nVal
			nVal	 := nTamSt
			nMaior := nX
		endif
	Next
   nDireita  := Len( ::menu[::nPos, 2, nMaior])+5
   nBaixo    := Len( ::menu[::nPos, 2])
	nTam		 := nDireita + nSoma
	nMax		 := if( nTam > 79, 79, nTam )
	nSoma 	 := if( nTam > 79, (nSoma-( nTam-79)) , nSoma )
	nSoma 	 := if( nSoma < 0, 0, nSoma )
	nScr1 	 := 01+nLinha
	nScr2 	 := 00
	nScr3 	 := MaxRow()-1
	nScr4 	 := MaxCol()
	cScreen	 := SaveScreen( nScr1, nScr2, nScr3, nScr4 )
   Box( 01+nLinha, nSoma, 02+nBaixo+nLinha, nMax, ::Frame, ::CorMenu )
	oP 		  := ::MsProcessa( 02+nLinha, nSoma+1, 02+nBaixo+nLinha, nMax-1, aNew, aSelecao )
	if !lManterScreen
	   RestScreen( nScr1, nScr2, nScr3, nScr4, cScreen )
	endif	
   cPrinc   := Str( ::nPos, 2 )
	cMenu 	:= StrZero( oP, 2 )
   nMax     := Len( ::Menu )
	nKey		:= LastKey()
	nRetorno := Val( cPrinc + "." + cmenu )
	DO Case
      Case nKey = 13 .OR. nKey = K_SPACE
         if aSelecao[oP] // Item Ativo?
            return( nRetorno )
         else
            Alerta("ERRO: Item Desativado")
         endif
		Case nKey = 27 .OR. nKey = TECLA_ALT_F4
			return( 0 )
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
   ::nPos := if( ::nPos > nMax, 1,    ::nPos )
   ::nPos := if( ::nPos < 1,    nMax, ::nPos )
EndDo
return 

Method MSMenuCabecalho( nLinha, nPos )
***********************************
   LOCAL nMax    := MaxCol()
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
	
	aPrint( nLinha, 00, "", ::Cormenu, nMax )
	FOR nX := 1 To nTam
		cMenu   := ::menu[nX,1]
     	cHotKey := Space(0)
		nSoma1  := 0
		StrHotKey(@cMenu, @cHotKey)
		if (nSoma1 := Len(cHotKey)) > 1 
		   cHotKey := Right(cHotKey,1)
		endif
		nSoma1--		
		aHotKey[nX] := cHotKey
		nLen        := Len( ::menu[nX,1])
		aRow[nX]    := nLinha	
		aCol[nX]    := nSoma	+ nSoma1
		aPrint( nLinha,   nSoma,    cMenu,       if( nPos = nX, ::CorLightBar,   ::CorMenu ))
		aPrint( aRow[nX], aCol[nX], aHotKey[nX], if( nPos = nX, ::CorHKLightBar, ::CorHotKey ))
	   nSoma    += nLen
		nSoma1   += nLen
   Next
	
return

Method MSProcessa( nCima, nEsquerda, nBaixo, nDireita, aNew, aSelecionado )
***************************************************************************
	STATI nItem   := 1
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

	if (!::Visual == NIL)
		cSep := SubStr(::Frame, 4, 1) + Repl( "Ä", nTamSt ) + SubStr(::Frame, 8,1)
	else
		cSep := Chr(195) + Repl( "Ä", nTamSt ) + Chr(180)
	endif
	SetCursor(0)
	FOR nX := 1 To nTam
	   cMenu       := aNew[nX]
	   cHotKey     := Space(0)
		StrHotKey(@cMenu, @cHotKey)
		aNew[nX]    := cMenu
		nLen        := (nTamSt-Len(cMenu))
		nSoma1      := 0
		if (nSoma1  := Len(cHotKey)) > 1 
		   cHotKey  := Right(cHotKey,1)
		endif
		nSoma1--		
		aHotKey[nX] := cHotKey
		aRow[nX]    := nRow+nX
		aCol[nX]    := nEsquerda + nSoma1
		
		if Empty( cMenu )
			aPrint( nRow+nX, nEsquerda-1, cSep, ::CorMenu ) // Separador
			Loop
		endif
		
		if aSelecionado[ nX ]                              //Item dipsonivel
			aPrint( nRow+nX, nEsquerda, cMenu + Space(nLen), ::Cormenu )
		else
			nConta++
			aPrint( nRow+nX, nEsquerda, cMenu + Space(nLen), ::CorDesativada )
		endif
	Next
				
	if nItem > nMax
		nItem = nMax
	endif
	
	WHILE OK
	   cMenu := aNew[nItem]
	   nLen  := (nTamSt-Len(cMenu))
	  
		if nConta != nMax
			if aSelecionado[ nItem ] .AND. !Empty( cMenu)
				 aPrint( nRow+nItem, nEsquerda, cMenu   + Space(nLen), ::CorLightBar )
			endif
			if aSelecionado[ nItem ] .AND. Empty(cMenu)
				aPrint( nRow+nItem, nEsquerda-1, cSep, ::CorMenu )
				if LastKey() = SETA_CIMA
					nItem--
				else
					nItem++
				endif
				nItem := if( nItem > nMax, 1, 	nItem )
				nItem := if( nItem < 1, 	nMax, nItem )
				Loop
			endif
			if !::alterando
				if !aSelecionado[ nItem ]
					aPrint( nRow+nItem, nEsquerda, cMenu + Space(nLen), ::CorDesativada )
					if LastKey() = SETA_CIMA
						nItem--
					else
						nItem++
					endif
					nItem := if( nItem > nMax, 1,    nItem )
					nItem := if( nItem < 1,    nMax, nItem )
					Loop
				endif
			endif
		endif
		
		FOR nX := 1 To nTam
			aPrint( aRow[nX], aCol[nX], aHotKey[nX], if(nItem == nX, ::CorHKLightBar, ::CorHotKey ))
	   Next
		
		nKey := Inkey(0)
		if ::Alterando
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space(nLen), if( aSelecionado[nItem], ::CorMenu, ::Cordesativada-1 ))
		else
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space(nLen), if( aSelecionado[nItem], ::Cormenu, ::Cordesativada ))
		endif
		Do Case
		
		Case nKey = 27 .OR. nKey = TECLA_ALT_F4
			return( 0 )

		Case nKey = 13 .OR. nKey = TECLA_SPACO
			return( nItem )

		Case nKey = K_HOME .OR. nKey = K_CTRL_PGUP .OR. nKey = K_PGUP
			nItem := 1

		Case nKey = K_END .OR. nKey = K_CTRL_PGDN .OR. nKey = K_PGDN
			nItem := nMax

		Case nKey = SETA_DIREITA
			return( SETA_DIREITA )

		Case nKey = SETA_ESQUERDA
			return( SETA_ESQUERDA )

		Case nKey = SETA_CIMA
			nItem--

		Case nKey = SETA_BAIXO
			nItem++

		Case ( bAction := SetKey( nKey )) != NIL
			Eval( bAction, ProcName(), ProcLine(), ReadVar())

		EndCase
		nItem   := if( nItem > nMax, 1,    nItem )
		nItem   := if( nItem < 1,    nMax, nItem )
		::Ativo := nItem
	EndDo
return( NIL )

Proc StrHotKey(cMenu, cHotKey)
******************************
   LOCAL cChar   := "^"
	LOCAL cSwap   := Space(0)
	LOCAL nConta
	LOCAL cStr
	LOCAL cNew

	nConta := StrCount( cChar, cMenu )
   if nConta >0
	   cHotKey := StrExtract(cMenu, cChar, 1 )
	   cMenu   := StrSwap(cMenu, cChar, 1, cSwap)
   endif
return	

Method Refresh(nItem)
*********************
	::menu := Eval({|nItem|::menuarray[nItem]}, nItem )
	//LOCAL oBloco := {|nItem|::menuarray[nItem]}
	//::menu := Eval(oBloco, nItem)
return

METHOD SetPano() CLASS TMenu
        ::Panos         := {" MicroBras ", ;
          "Û²°±MicroBrasÛ±²°",;
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
			 " ", ;
          "þþþþþþþþþþþþþþ", ;
			 "ú.ù,ú'ù.';ùþùú    ", ;
          "ú.ù.'ú.'ù.ù'", ;
          "MicroBras Informatica                                       ", ;
          "MicroBras Informatica                                      ", ;
          "MicroBras Informatica                                     ", ;
          "MicroBras Informatica                                    ", ;
          "MicroBras Informatica                                   ", ;
          "MicroBras Informatica                                  ", ;
          "MicroBras Informatica                                 ", ;
          "MicroBras                                            ", ;
          "MicroBras                                           ", ;
          "MicroBras                                          ", ;
          "MicroBras                                         ", ;
          "MicroBras                                        ", ;
          "MicroBras                                       ", ;
          "MicroBras                                      ", ;
          "MicroBras                                     ", ;
          "MicroBras                                    ", ;
          "MicroBras                                   ", ;
          "MicroBras                                  ", ;
          "MicroBras                                 ", ;
          "MicroBras                                ", ;
          "MicroBras                               ", ;
          "MicroBras                              ", ;
          "MicroBras                             ", ;
          "MicroBras                            ", ;
          "MicroBras                           ", ;
          "MicroBras                          ", ;
          "MicroBras                         ", ;
          "MicroBras                        ", ;
          "MicroBras                       ", ;
          "MicroBras                      ", ;
          "MicroBras                     ", ;
          "MicroBras                    ", ;
          "MicroBras                   ", ;
          "MicroBras                  ", ;
          "MicroBras                 ", ;
          "MicroBras                ", ;
          "MicroBras               ", ;
          "MicroBras              ", ;
          "MicroBras             ", ;
          "MicroBras            ", ;
          "MicroBras           ", ;
          "MicroBras          ", ;
          "MicroBras         ", ;
          "MicroBras        ", ;
          "MicroBras       ", ;
          "MicroBras      ", ;
          "MicroBras     ", ;
          "MicroBras    ", ;
          "MicroBras   ", ;
          "MicroBras  ", ;
          "MicroBras ", ;
          "MicroBras","ÄÁÂ", "°±²Û", "²", "±", "Û", "°", "Î", " À¿", " É¼", "ÄÁÂ", " ", "ú.ù.'ú.'ù.ù'",;
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
			
return( self )


Function TMenuNew()
   return( TMenu():New())
