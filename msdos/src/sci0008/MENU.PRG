#include "classic.ch"
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

BEGIN CLASS TMenu INHERIT FROM TAmbiente():SetVar()
    Export:
        Var Frame         INHERITS FROM TAmbiente()
        Var CorMenu       INHERITS FROM TAmbiente()
        Var Sombra        INHERITS FROM TAmbiente()
        Var CorCabec      INHERITS FROM TAmbiente()
        Var PanoFundo     INHERITS FROM TAmbiente()
        Var CorBorda      INHERITS FROM TAmbiente()
        Var CorFundo      INHERITS FROM TAmbiente()
        Var CorDesativada INHERITS FROM TAmbiente()
        Var Panos         INHERITS FROM TAmbiente()
        Var Visual        INHERITS FROM TAmbiente()
        Var Usuario       INHERITS FROM TAmbiente()
        Var Selecionado   INHERITS FROM TAmbiente()
        Var CorAntiga     INHERITS FROM TAmbiente()
        Var CorCabec      INHERITS FROM TAmbiente()
        Var CorAlerta     INHERITS FROM TAmbiente()
        Var CorBox        INHERITS FROM TAmbiente()
        Var CorCima       INHERITS FROM TAmbiente()
        Var Fonte         INHERITS FROM TAmbiente()
        Var CorMsg        INHERITS FROM TAmbiente()
        Var TabelaFonte   INHERITS FROM TAmbiente()

        Var StatusSup
        Var StatusInf
        Var Ativo
        Var Menu
        Var Disp
        Var NomeFirma

        METHOD Init
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
        METHOD Fazmenu
        METHOD MsPaint
        METHOD MsProcessa
        METHOD MsMenu
        METHOD SetaCorMsg
        METHOD SetaCorAlerta
        METHOD SetaFonte

End Class

Method Procedure Init()
       ::StatusSup     := "MicroBras"
       ::StatusInf     := ""
       ::Ativo         := 1
       ::menu          := xMenu()
       ::Disp          := xDisp()
       ::NomeFirma     := "MICROBRAS COM DE PROD DE INFORMATICA LTDA"
       Return( Self )

Method SetaFonte()
******************
LOCAL nChoice   := 1
LOCAL aModeMenu := {"Resetar Fonte Para Normal",;
						  "80x25 Linhas - CGA EGA VGA Somente", ;
						  "80x43 Linhas - EGA & VGA Somente",;
						  "80x50 Linhas - VGA Somente",;
						  "Fonte Digital" ,;
						  "Avante Garde",;
						  "Fonte 3270",;
						  "Fonte Broadway",;
						  "Fonte Cyrillic",;
						  "Fonte Percy",;
						  "Fonte Legenda",;
						  "Fonte Caligrafia",;
						  "Fonte Script1",;
						  "Fonte Script2",;
						  "Fonte Italica1",;
						  "Fonte Italica2",;
						  "Fonte Romana",;
						  "Fonte Ingles Velho",;
						  "Fonte Bauhaus",;
						  "Fonte Bodoni",;
						  "Fonte Garamond",;
						  "Fonte Avenida",;
						  "Fonte Computador",;
						  "Fonte Grego",;
						  "Fonte Hebreu"}
	M_Title("SELECIONE FONTE/MODO DE VIDEO")
	nChoice := AmaxChoice( 03, 10, 20, 45, aModeMenu, Cor())
	Do Case
	Case nChoice = 0
		Return
	Case VidType() == 0
		ErrorBeep()
		Alerta("Erro: Placa de Video Monocromatica." )
		Return
	EndCase
	oAmbiente:Fonte := nChoice
	Eval( oAmbiente:TabelaFonte[ nChoice] )
//   Palette( oAmbiente:CorAntiga, oAmbiente:PanoFundo )
//   M_Data( 10, LastRow()- 2 )
//   M_Data( 26, LastRow()- 2 )
   Return(Self)

Method SetaFrame()
******************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 1
LOCAL aFrames := {"        ",;
						"�Ŀ�����",;
						"�ͻ���Ⱥ",;
						"�ķ���Ӻ",;
						"�͸���Գ",;
						"��������",;
						"���������",;
						"������ȶ"}
nChoice := ::Fazmenu( 03, 10, aFrames, ::Cormenu )
ResTela( cScreen )
IF nChoice = 0
	Return
EndIF
::Frame  := aFrames[nChoice]
M_Frame( ::Frame )
Return Self


Function xMenu()
****************
LOCAL AtPrompt := {}

AADD( AtPrompt, {"Menu 1",{"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
AADD( AtPrompt, {"Menu 1",{"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
AADD( AtPrompt, {"Menu 1",{"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
AADD( AtPrompt, {"Menu 1",{"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
AADD( AtPrompt, {"Menu 1",{"SubMenu 1","SubMenu 2","SubMenu 3","SubMenu 4"}})
Return( AtPrompt )

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
Return( aDisp )

Method Limpa
        Cls( ::CorFundo, ::PanoFundo )
		  Return Self

Method StatInf( cMensagem )
		  LOCAL nCol  := LastRow()
		  LOCAL nTam  := MaxCol()
		  LOCAL nPos  := ( nTam - Len( ::NomeFirma ))
        aPrint( nCol, 00,    IF( cMensagem = NIL, ::StatusInf, cMensagem), ::CorCabec, MaxCol() )
        aPrint( nCol, nPos,  ::NomeFirma, ::CorCabec )
		  Return Self

Method StatSup( cCabecalho )
		  LOCAL nTam  := MaxCol()
		  LOCAL nPos  := ( nTam - Len( ::StatusSup ))
        aPrint( 00, 00, Padc( IF( cCabecalho = NIL, ::StatusSup, cCabecalho), nTam ),  ::CorCabec, nTam )
        aPrint( 00, ( nTam-8), Clock12( 00, (nTam-8), ::CorCabec ), ::CorCabec )
		  Return Self

Method SetaCorMsg()
*******************
LOCAL cScreen	  := SaveScreen()
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo, ::CorDesativada }
LOCAL cPanoFundo := ::PanoFundo
LOCAL xColor     := ::CorMsg
LOCAL ikey
LOCAL oCor := TvMenuNew()
      oCor:CorMenu        := aTipo[ 1 ]
      oCor:CorCabec       := aTipo[ 2 ]
		oCor:CorFundo		  := aTipo[ 3 ]
		oCor:CorDesativada  := aTipo[ 4 ]
		oCor:PanoFundo 	  := cPanoFundo
      oCor:StatusSup      := "TESTE DE COR - Box de Confirmacao"
		oCor:StatusInf 	  := "TESTE DE COR"

WHILE .T.
	Keyb( Chr( 27 ))
	oCor:Show()
   M_Frame( ::Frame )
	M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	IF ( Ikey == 24)
      ::CorMsg := ( XColor  := IIF( xColor  == 0, 255, --xColor  ))
	ELSEIF ( Ikey == 5)
      ::CorMsg :=  ( xColor  := IIF( xColor  == 255, 0, ++xColor  ))
	 ELSEIF ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 EndIF
End
ResTela( cScreen )
Return SeLF

Method SetaCorAlerta()
**********************
LOCAL cScreen	  := SaveScreen()
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo, ::CorDesativada }
LOCAL cPanoFundo := ::PanoFundo
LOCAL xColor     := ::CorAlerta
LOCAL ikey
LOCAL oCor := TvMenuNew()
      oCor:CorMenu        := aTipo[ 1 ]
      oCor:CorCabec       := aTipo[ 2 ]
		oCor:CorFundo		  := aTipo[ 3 ]
		oCor:CorDesativada  := aTipo[ 4 ]
		oCor:PanoFundo 	  := cPanoFundo
      oCor:StatusSup      := "TESTE DE COR - Mensagem de Alerta"
		oCor:StatusInf 	  := "TESTE DE COR"

WHILE .T.
	Keyb( Chr( 27 ))
	oCor:Show()
   M_Frame( ::Frame )
	M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	IF ( Ikey == 24)
      ::CorAlerta := ( XColor  := IIF( xColor  == 0, 255, --xColor  ))
	ELSEIF ( Ikey == 5)
      ::CorAlerta :=  ( xColor  := IIF( xColor  == 255, 0, ++xColor  ))
	 ELSEIF ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 EndIF
End
ResTela( cScreen )
Return SeLF

Method SetaCor( nTipo )
****************************
LOCAL aTipo      := { ::CorMenu, ::CorCabec, ::CorFundo, ::CorDesativada }
LOCAL cPanoFundo := ::PanoFundo
LOCAL cScreen	  := SaveScreen()
LOCAL xTipo      := IF( nTipo = NIL, 1, nTipo )
LOCAL xColor	  := aTipo[ xTipo ]
LOCAL CorAnt	  := aTipo[ xTipo ]
LOCAL ikey
LOCAL oCor := TvMenuNew()
      oCor:CorMenu        := aTipo[ 1 ]
      oCor:CorCabec       := aTipo[ 2 ]
		oCor:CorFundo		  := aTipo[ 3 ]
		oCor:CorDesativada  := aTipo[ 4 ]
		oCor:PanoFundo 	  := cPanoFundo
		oCor:StatusSup 	  := "TESTE DE COR - Cabecalho"
		oCor:StatusInf 	  := "TESTE DE COR"

WHILE .T.
	Keyb( Chr( 27 ))
	oCor:Show()
   M_Frame( ::Frame )
	M_Message("Cor Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	IF ( Ikey == 24)
		aTipo[ xTipo ] := ( XColor  := IIF( xColor  == 0, 255, --xColor  ))
	ELSEIF ( Ikey == 5)
		( aTipo[ xTipo ] ) :=  ( xColor	:= IIF( xColor  == 255, 0, ++xColor  ))
	 ELSEIF ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 EndIF
	 oCor:CorMenu		  := aTipo[ 1 ]
    oCor:CorCabec      := aTipo[ 2 ]
	 oCor:CorFundo 	  := aTipo[ 3 ]
	 oCor:CorDesativada := aTipo[ 4 ]
End
::CorMenu		 := aTipo[ 1 ]
::CorCabec      := aTipo[ 2 ]
::CorFundo		 := aTipo[ 3 ]
::CorDesativada := aTipo[ 4 ]
ResTela( cScreen )
Return SeLF

Method SetaSombra
*****************
SetShadow( ::Sombra )
Return Self

Method SetaBorda
****************
LOCAL aTipo      := { ::Cormenu, ::CorCabec, ::CorFundo }
LOCAL cPanoFundo := ::PanoFundo
LOCAL cScreen	  := SaveScreen()
LOCAL xColor	  := ::CorBorda
LOCAL ikey
LOCAL oCor := TvMenuNew()
		oCor:Cormenu	:= aTipo[ 1 ]
      oCor:CorCabec  := aTipo[ 2 ]
		oCor:CorFundo	:= aTipo[ 3 ]
		oCor:CorBorda	:= ::CorBorda
		oCor:PanoFundo := cPanoFundo
		oCor:StatusSup := "TESTE DE COR DE BORDA"
		oCor:StatusInf := oCor:StatusSup

WHILE .T.
	Keyb( Chr( 27 ))
	oCor:Show()
   M_Frame( ::Frame )
	M_Message("Cor Borda Atual = "+ StrZero( xColor, 3 ) + " - Enter Para Setar ou ESCape", xColor )
	Ikey := WaitKey( 0 )
	IF ( Ikey == 24)
		XColor  := IIF( xColor	== 0, 63, --xColor  )
		oCor:CorBorda	:= xColor
		::CorBorda		:= xColor
	ELSEIF ( Ikey == 5)
		xColor  := IIF( xColor	== 63, 0, ++xColor  )
		oCor:CorBorda	:= xColor
		::CorBorda		:= xColor
	 ELSEIF ( Ikey == 27 ) .OR. ( IKey == 13 )
		 Exit
	 EndIF
	 Border( ::CorBorda )
End
Border( ::CorBorda )
ResTela( cScreen )
Return SeLF

Method SetaPano
***************
LOCAL nPano
LOCAL Selecionado  := 1
LOCAL nKey			 := 0
LOCAL cScreen      := SaveScreen()
LOCAL oCor

Aadd( ::Panos, CapFirst( oAmbiente:xUsuario ))
nPano          := Len( ::Panos )
nPos           := Ascan( ::Panos, ::Panofundo )
Selecionado 	:= IF( nPos = 0, 1, nPos )
cPanoFundo		:= ::PanoFundo
cCormenu 		:= ::Cormenu
cCorCabec      := ::CorCabec
cCorFundo		:= ::CorFundo

oCor           := TvMenuNew()
oCor:PanoFundo := cPanoFundo
oCor:Cormenu	:= cCormenu
oCor:CorCabec	:= cCorCabec
oCor:CorFundo	:= cCorFundo

WHILE .T.
	Keyb( Chr( 27 ))
	oCor:Show()
   M_Frame( ::Frame )
	M_Message("Use as setas CIMA e BAIXO para trocar, ENTER para aceitar. N� " + StrZero( Selecionado, 3 ), ::Cormenu )
	nKey := Inkey(0)
	IF ( nKey == 27 .OR. nKey = 13 )
		Exit
	ElseIF nKey == 24
		Selecionado := IF( Selecionado == 1, nPano, --Selecionado  )
      oCor:PanoFundo := ::Panos[ Selecionado ]
	ElseIF nKey == 5
		Selecionado := IF( Selecionado == nPano, 1, ++Selecionado  )
      oCor:PanoFundo := ::Panos[ Selecionado ]
	EndIF
EndDo
::PanoFundo := ::Panos[ Selecionado ]
Return Self

Method MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
******************************************************************************
LOCAL cPanoFundo := " "
LOCAL nCor       := IF( lInverterCor = NIL, ::Cormenu,  lInverterCor )
LOCAL pback

//DispBegin()
IF nDireita = 79
	nDireita = MaxCol()
EndIf
ColorSet( @nCor, @pback )
Box( nTopo, nEsq, nFundo, nDireita, ::Frame + cPanoFundo, nCor )
IF Cabecalho != Nil
	aPrint( nTopo, nEsq+1, "�", Roloc( nCor ), (nDireita-nEsq)-1)
	aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( nCor ))
EndIF
IF Rodape != Nil
	aPrint( nFundo, nEsq+1, "�", Roloc( nCor ), (nDireita-nEsq)-1)
	aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( nCor ))
EndIF
cSetColor( SetColor())
nSetColor( nCor, Roloc( nCor ))
//DispEnd()
Return

Method Fazmenu( nTopo, nEsquerda, aArray, Cor )
***********************************************
LOCAL nFundo	  := ( nTopo + Len( aArray ) + 3 )
LOCAL nTamTitle  := ( Len( M_Title() ) + 12 )
LOCAL nDireita   := ( nEsquerda + AmaxStrLen( aArray ) + 1 )
IF ( nDireita - nEsquerda ) <  nTamTitle
	nDireita := ( nEsquerda + nTamTitle )
EndIF
Cor := IF( Cor = NIL, ::Cormenu, Cor )
::MaBox( nTopo, nEsquerda, nFundo, nDireita, "", "", Cor )
nChoice := Mx_Choice( @nTopo, @nEsquerda, @nFundo, @nDireita, aArray, Cor )
Return( nChoice )

Method Show
***********
LOCAL nChoice
Cls( ::CorFundo, ::PanoFundo )
M_Frame( ::Frame )
::StatSup()
::StatInf()
Return( nChoice := ::MsMenu( 1 ))

Method MsMenu( nLinha )
***********************
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
STATI nPos		 := 1

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
	nTam		 := 0
	nTamSt	 := 0
	nCorrente := 1
	aNew		 := {}
	aSelecao  := {}
   ::MsPaint( nLinha, nPos )
	FOR nX := 2 To nPos
      nSoma += Len( ::menu[nX-1,1])+1
	Next
	nX := 0
   FOR nX := 1 To Len( ::menu[ nPos, 2])
      IF Empty( ::menu[nPos,2, nX ] )
			Aadd( aNew, "")
			Aadd( aSelecao, ENABLE )
		Else
         Aadd( aNew, "  " + ::menu[nPos,2, nX ] + "  " )
         Aadd( aSelecao, ::Disp[ nPos, nX ])
		EndIF
      nTamSt := Len( ::menu[nPos,2, nX ]) + 2
		IF nTamSt > nVal
			nVal	 := nTamSt
			nMaior := nX
		EndIF
	Next
   nDireita  := Len( ::menu[nPos, 2, nMaior])+5
   nBaixo    := Len( ::menu[nPos, 2])
	nTam		 := nDireita + nSoma
	nMax		 := IF( nTam > 79, 79, nTam )
	nSoma 	 := IF( nTam > 79, (nSoma-( nTam-79)) , nSoma )
	nSoma 	 := IF( nSoma < 0, 0, nSoma )
	nScr1 	 := 01+nLinha
	nScr2 	 := 00
	nScr3 	 := MaxRow()-1
	nScr4 	 := MaxCol()
	cScreen	 := SaveScreen( nScr1, nScr2, nScr3, nScr4 )
   Box( 01+nLinha, nSoma, 02+nBaixo+nLinha, nMax, ::Frame, ::CorMenu )
	oP 		  := ::MsProcessa( 02+nLinha, nSoma+1, 02+nBaixo+nLinha, nMax-1, aNew, aSelecao )
	RestScreen( nScr1, nScr2, nScr3, nScr4, cScreen )
	cPrinc	:= Str( nPos, 2 )
	cMenu 	:= StrZero( oP, 2 )
   nMax     := Len( ::Menu )
	nKey		:= LastKey()
	nRetorno := Val( cPrinc + "." + cmenu )
	DO Case
      Case nKey = 13 .OR. nKey = K_SPACE
			Return( nRetorno )
		Case nKey = 27 .OR. nKey = TECLA_ALT_F4
			Return( 0 )
		Case nKey = SETA_DIREITA
			nPos++
		Case nKey = SETA_ESQUERDA
			nPos--
		OtherWise
			Eval( SetKey( nKey ))
	EndCase
	nPos := IF( nPos > nMax, 1,	 nPos )
	nPos := IF( nPos < 1,	 nMax, nPos )
EndDo

Method MsProcessa( nCima, nEsquerda, nBaixo, nDireita, aNew, aSelecionado )
***************************************************************************
LOCAL nX 	 := 1
LOCAL nTam	 := Len( aNew )
LOCAL nRow	 := nCima-1
LOCAL nMax	 := nTam
LOCAL nTamSt := ( nDireita - nEsquerda ) + 1
LOCAL cSep   := Chr(195) + Repl( "�", nTamSt ) + Chr(180)
LOCAL nKey	 := 1
STATI nItem  := 1
LOCAL nConta := 0

SetCursor(0)
FOR nX := 1 To nTam
	IF Empty( aNew[nX] )
		aPrint( nRow+nX, nEsquerda-1, cSep, ::CorMenu )
		Loop
	EndIF
	IF aSelecionado[ nX ]
		aPrint( nRow+nX, nEsquerda, aNew[nX] + Space( nTamSt - Len( aNew[nX] )), ::CorMenu )
	Else
		nConta++
		aPrint( nRow+nX, nEsquerda, aNew[nX] + Space( nTamSt - Len( aNew[nX] )), ::CorDesativada )
	Endif
Next
IF nItem > nMax
	nItem = nMax
EndIF
WHILE .T.
	IF nConta != nMax
		IF aSelecionado[ nItem ] .AND. !Empty( aNew[nItem])
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space( nTamSt - Len( aNew[nItem] )), Roloc( ::CorMenu ))
		EndIF
		IF aSelecionado[ nItem ] .AND. Empty( aNew[nItem])
			aPrint( nRow+nItem, nEsquerda-1, cSep, ::CorMenu )
			IF LastKey() = SETA_CIMA
				nItem--
			Else
				nItem++
			EndIF
			nItem := IF( nItem > nMax, 1, 	nItem )
			nItem := IF( nItem < 1, 	nMax, nItem )
			Loop
		EndIF
		IF !aSelecionado[ nItem ]
			aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space( nTamSt - Len( aNew[nItem] )), ::CorDesativada )
			IF LastKey() = SETA_CIMA
				nItem--
			Else
				nItem++
			EndIF
			nItem := IF( nItem > nMax, 1, 	nItem )
			nItem := IF( nItem < 1, 	nMax, nItem )
			Loop
		EndIF
	EndIF
	nKey := Inkey(0)
	aPrint( nRow+nItem, nEsquerda, aNew[nItem] + Space( nTamSt - Len( aNew[nItem] )), IF( aSelecionado[nItem], ::CorMenu, ::Cordesativada ))
	Do Case
	Case nKey = 27 .OR. nKey = TECLA_ALT_F4
		Return( 0 )

	Case nKey = 13 .OR. nKey = TECLA_SPACO
		Return( nItem )

	Case nKey = SETA_DIREITA
		Return( SETA_DIREITA )

	Case nKey = SETA_ESQUERDA
		Return( SETA_ESQUERDA )

	Case nKey = SETA_CIMA
		nItem--

	Case nKey = SETA_BAIXO
		nItem++

	Case ( bAction := SetKey( nKey )) != NIL
		Eval( bAction, ProcName(), ProcLine(), ReadVar())

	EndCase
   nItem   := IF( nItem > nMax, 1,    nItem )
   nItem   := IF( nItem < 1,    nMax, nItem )
   ::Ativo := nItem
EndDO
Return( NIL )

Method MsPaint( nLinha, nPos )
******************************
LOCAL nMax  := MaxCol()
LOCAL nSoma := 0
LOCAL nX 	:= 0
LOCAL nTam  := Len( ::menu )

aPrint( nLinha, 00, "", ::Cormenu, nMax )
aPrint( nLinha, nSoma, ::Menu[1,1], IF( nPos = 1, Roloc( ::CorMenu ), ::CorMenu ))
FOR nX := 2 To nTam
   aPrint( nLinha, ( nSoma += Len( ::menu[nX-1,1])+1 ), ::Menu[nX,1], IF( nPos = nX, Roloc( ::CorMenu ), ::CorMenu ))
Next
Return

Function TMenuNew()
   Return( TMenu():New())
