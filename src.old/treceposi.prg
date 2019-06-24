#include "hbclass.ch"
#Include "box.ch"
#Include "inkey.ch"
#Include "lista.ch"

CLASS TReceposi
	VAR cWho
	VAR cNome
	VAR aHistRecibo				 INIT {}
	VAR aUserRecibo			 	 INIT {}
	VAR aAtivo						 INIT {}
	VAR aAtivoSwap					 INIT {}
   VAR aRecno						 INIT {}
	VAR aTodos                  INIT {}
	VAR xTodos                  INIT {}
	
	VAR aDocnr_Selecao_Imprimir INIT {}
	VAR aSoma_Selecao_Imprimir  INIT {}
	VAR aObs_Selecao_Imprimir   INIT {}
	VAR aCurElemento_Selecao    INIT {}
	VAR nSoma_Total_Imprimir    INIT 0
	VAR nPrincipalSelecao       INIT 0
	VAR nJurosSelecao           INIT 0
	VAR nMultaSelecao           INIT 0
	
	VAR nPrincipal_Vencer       INIT 0
	VAR nJuros_Vencer           INIT 0
	VAR nMulta_Vencer           INIT 0	
	VAR nTotal_Vencer           INIT 0
	VAR nQtdDoc_Vencer          INIT 0
	
	VAR nPrincipal_Rescisao     INIT 0
	VAR nJuros_Rescisao         INIT 0
	VAR nMulta_Rescisao         INIT 0	
	VAR nTotal_Rescisao         INIT 0
	VAR nQtdDoc_Rescisao        INIT 0
	
	VAR CorRecibo               INIT AscanCor(13) // Vermelho do Menu 
	VAR CorVencido              INIT AscanCor(16) // Branco do Menu 
	VAR CorVencer               INIT AscanCor(11) // Verde do Menu 
	VAR CorSelecao              INIT AscanCor(10) // Azul do menu
	VAR CorAviso                INIT AscanCor(15) // Amarelo do Menu
	
	VAR nPrincipal_Vencido      INIT 0
	VAR nJuros_Vencido          INIT 0
	VAR nMulta_Vencido          INIT 0	
	VAR nTotal_Vencido          INIT 0
	VAR nQtdDoc_Vencido         INIT 0	
	
	VAR nPrincipal_Recibo       INIT 0
	VAR nJuros_Recibo           INIT 0
	VAR nMulta_Recibo           INIT 0	
	VAR nTotal_Recibo           INIT 0
	VAR nQtdDoc_Recibo          INIT 0	
	
	VAR nPrincipal	             INIT 0	
	VAR nJurosPago	             INIT 0	
	VAR nRecebido					 INIT 0	
	VAR nAberto              	 INIT 0	
	VAR nQtdDoc 					 INIT 0	
	VAR cStrSelecao             INIT ''
	VAR cStrRecibo              INIT ''
	VAR cStrVencido             INIT ''
	VAR cStrVencer              INIT ''	
	VAR Color_pFore 	          INIT {}
	VAR Color_pBack             INIT {}
	VAR Color_pUns              INIT {}	
	VAR CurElemento
	
	VAR cTop
	VAR aBottom
	VAR nBoxRow
	VAR nBoxCol
	VAR nBoxRow1
	VAR nBoxCol1
	VAR nPrtRow
	VAR nPrtCol
	VAR cPrtStr
	
	VAR PosiAgeInd
	VAR PosiAgeAll
	VAR PosiReceber
	VAR lReceberPorPeriodo INIT FALSO
   VAR dIni
   VAR dFim
   VAR dCalculo
		
	//METHOD AddVar
	METHOD New CONSTRUCTOR
	METHOD Resetar
	METHOD Achoice_
	METHOD Achoice
	METHOD MaBox_
	METHOD PrintPosi
	METHOD Redraw_
	METHOD Hello	
	METHOD ResetSelecao
	METHOD ResetAll	
	METHOD RedrawSelecao
	METHOD RedrawVencer
	METHOD RedrawVencido
	METHOD RedrawRecibo	
	METHOd ZerarSelecao
	METHOD ZerarRecibo
	METHOD ZerarVencer
	METHOD ZerarVencido
	METHOD ZerarRescisao	
	METHOD BarraSoma
	METHOD _SomaPago( nValorTotal, nValorPago )
	METHOD AssignColor
	METHOD LeftEqI( string, cKey )	
	METHOD Ach_Select( alSelect, nPos )
	METHOD Ach_Limits( /* @ */ nFrstItem, /* @ */ nLastItem, /* @ */ nItems, alSelect, acItems )	
	METHOD Displine( cLine, nRow, nCol, lSelect, lHiLite, nNumCols, nCurElemento )
	METHOD DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nArrLen, nRowsClr )
	METHOD HitTest( nTop, nLeft, nBottom, nRight, mRow, mCol )	
ENDCLASS 

Method New()
	Self:cWho	  := "TTReceposi"
	Self:cNome	  := ProcName()
	::aHistRecibo := {}
	::aUserRecibo := {}
	::aAtivo 	  := {}
	::aAtivoSwap  := {}
   ::aRecno      := {}
	::cTop		  := ""
	::aBottom	  := {"","", ""}
	::nBoxRow	  := 7
	::nBoxCol	  := 0
	::nBoxRow1	  := MaxRow()
	::nBoxCol1	  := MaxCol()
	::nPrtRow	  := MaxRow()
	::nPrtCol	  := 0
	::nQtdDoc	  := 0
	::nRecebido   := 0
	::nPrincipal  := 0
	::nJurosPago  := 0
	::nAberto	  := 0
	::PosiAgeInd  := FALSO
	::PosiAgeAll  := FALSO
	::PosiReceber := FALSO
   ::dIni        := Ctod("01/01/91")
   ::dFim        := Ctod("31/12/" + Right(Dtoc(Date()),2))
   ::dCalculo    := Date()
	::AssignColor()	
RETURN Self

METHOD Resetar()
	Self:New()
RETURN Self

METHOD AssignColor
******************
	::Color_pFore := {}
	::Color_pBack := {}
	::Color_pUns  := {}		
	::CorRecibo   := AscanCor(13) // Vermelho do Menu 
	::CorVencido  := AscanCor(16) // Branco do Menu 
	::CorVencer   := AscanCor(11) // Verde do Menu 
	::CorSelecao  := AscanCor(10) // Azul do menu
	::CorAviso    := AscanCor(15) // Amarelo do Menu
	Afill((::Color_pFore := Array(Len(::xTodos))), ::CorVencido ) // Branco do Menu
	Afill((::Color_pBack := Array(Len(::xTodos))), oAmbiente:CorLightBar )	
	Afill((::Color_pUns  := Array(Len(::xTodos))), ::CorRecibo ) // Vermelho do Menu 	
return self

METHOD aChoice_(aTodos, aAtivo, cFuncao, lPageCircular)
	::Achoice(::nBoxRow+1, ::nBoxCol+1, ::nBoxRow1-5, ::nBoxCol1-1, aTodos, aAtivo, cFuncao, NIL, NIL, lPageCircular, ::Color_pFore, ::Color_pBack, ::Color_pUns)
RETURN Self

METHOD MaBox_()
	MaBox(::nBoxRow, ::nBoxCol, ::nBoxRow1-4, ::nBoxCol1, ::cTop)
RETURN Self

METHOD PrintPosi( nRow, nCol )
	::nPrtRow := nRow
	::nPrtCol := nCol
	::aBottom := { ::cStrRecibo, ::cStrVencido, ::cStrVencer } 
	Print(::nPrtRow-3, ::nPrtCol, ::aBottom[1], ::CorRecibo,  MaxCol()+1)
	Print(::nPrtRow-2, ::nPrtCol, ::aBottom[2], ::CorVencido, MaxCol()+1)
	Print(::nPrtRow-1, ::nPrtCol, ::aBottom[3], ::CorVencer,  MaxCol()+1)
RETURN Self

METHOD Redraw_() class TReceposi
	::MaBox_()
	::PrintPosi(::nPrtRow, ::nPrtCol, ::aBottom)
RETURN Self

METHOD Hello class TReceposi
  ? "Hello",Self:cWho
  ? "Hello",::cNome
RETURN Self

METHOD ResetSelecao class TReceposi
	::ZerarSelecao()
	::RedrawSelecao()	
	::Redraw_()
RETURN Self

METHOD ResetAll class TReceposi
	::ZerarSelecao()
	::RedrawRecibo()	
	::RedrawVencido()	
	::RedrawVencer()	
	::Redraw_()
RETURN Self

METHOd ZerarSelecao class TReceposi
	::aDocnr_Selecao_Imprimir := {}
	::aSoma_Selecao_Imprimir  := {}
	::aObs_Selecao_Imprimir   := {}	
	::aCurElemento_Selecao    := {}
	
	::nSoma_Total_Imprimir    := 0
	::nPrincipalSelecao       := 0
	::nJurosSelecao           := 0
	::nMultaSelecao           := 0
return self

METHOd ZerarRecibo class TReceposi	
	::nTotal_Recibo           := 0
	::nPrincipal_Recibo       := 0
	::nJuros_Recibo           := 0
	::nMulta_Recibo           := 0	
	::nQtdDoc_Recibo          := 0
return self	

METHOd ZerarVencer class TReceposi	
	::nTotal_Vencer           := 0
	::nPrincipal_Vencer       := 0
	::nJuros_Vencer           := 0
	::nMulta_Vencer           := 0	
	::nQtdDoc_Vencer          := 0
return self	

METHOd ZerarVencido class TReceposi	
	::nTotal_Vencido          := 0
	::nPrincipal_Vencido      := 0
	::nJuros_Vencido          := 0
	::nMulta_Vencido          := 0	
	::nQtdDoc_Vencido         := 0
return self	

METHOd ZerarRescisao class TReceposi	
	::nPrincipal_Rescisao     := 0
	::nJuros_Rescisao         := 0
	::nMulta_Rescisao         := 0	
	::nTotal_Rescisao         := 0
	::nQtdDoc_Rescisao        := 0
return self		
	
METHOD RedrawSelecao class TReceposi
	::cStrSelecao := " TOTAL SELECAO  ¯¯ {"
	::cStrSelecao += StrZero(Len(::aDocnr_Selecao_Imprimir),5)
	::cStrSelecao += "}" + Space(4)
	::cStrSelecao += Tran(::nPrincipalSelecao, 		"@E 999,999.99") + Space(8)
	::cStrSelecao += Tran(::nJurosSelecao,	  	 		"@E 999,999.99") + Space(1)
	::cStrSelecao += Tran(::nMultaSelecao,		 		"@E 9,999.99")   + Space(1)
	::cStrSelecao += Tran(::nSoma_Total_Imprimir,   "@E 999,999.99")
	oMenu:StatInf("")
	oMenu:ContaReg( ::cStrSelecao, 31)
RETURN Self

METHOD RedrawRecibo class TReceposi
	::cStrRecibo := " RECIBO EMITIDO ¯¯ {"
	::cStrRecibo += StrZero(::nQtdDoc_Recibo,5)
	::cStrRecibo += "}" + Space(4)
	::cStrRecibo += Tran(::nPrincipal_Recibo, "@E 999,999.99") + Space(8)
	::cStrRecibo += Tran(::nJuros_Recibo,     "@E 999,999.99") + Space(1)
	::cStrRecibo += Tran(::nMulta_Recibo,     "@E 9,999.99")   + Space(1)
	::cStrRecibo += Tran(::nTotal_Recibo,     "@E 999,999.99")
return(::cStrRecibo)	

METHOD RedrawVencido class TReceposi
	::cStrVencido := " ABERTO VENCIDO ¯¯ {"
	::cStrVencido += StrZero(::nQtdDoc_Vencido,5)
	::cStrVencido += "}" + Space(4)
	::cStrVencido += Tran(::nPrincipal_Vencido, "@E 999,999.99") + Space(8)
	::cStrVencido += Tran(::nJuros_Vencido,     "@E 999,999.99") + Space(1)
	::cStrVencido += Tran(::nMulta_Vencido,     "@E 9,999.99")   + Space(1)
	::cStrVencido += Tran(::nTotal_Vencido,     "@E 999,999.99") + Space(1)
	::cStrVencido += Tran(::nTotal_Vencido,     "@E 999,999.99")
	
return(::cStrVencido)	

METHOD RedrawVencer class TReceposi
	::cStrVencer := " ABERTO VENCER  ¯¯ {"
	::cStrVencer += StrZero(::nQtdDoc_Vencer,5)
	::cStrVencer += "}" + Space(4)
	::cStrVencer += Tran(::nPrincipal_Vencer, "@E 999,999.99") + Space(8)
	::cStrVencer += Tran(::nJuros_Vencer,     "@E 999,999.99") + Space(1)
	::cStrVencer += Tran(::nMulta_Vencer,     "@E 9,999.99")   + Space(1)
	::cStrVencer += Tran(::nTotal_Vencer,     "@E 999,999.99") + space(1)
	::cStrVencer += Tran(::nTotal_Rescisao,   "@E 999,999.99")
	
return(::cStrVencer)

METHOD _SomaPago( nValorTotal, nValorPago )
*********************************************
	 ::cStrRecibo := " TOTAL GERAL ¯¯ "
	 ::cStrRecibo += Space(27)
	 ::cStrRecibo += Tran(nValorTotal, "@E 999,999,999.99")
	 ::cStrRecibo += Space(01)
	 ::cStrRecibo += Tran(nValorPago,  "@E 999,999,999.99")	 
Return( ::cStrRecibo)

*+------------------------------------------------------------------------------

METHOD BarraSoma(xTodos)
************************
	LOCAL xLen		  := Len(xTodos)
	LOCAL nPrincipal := 0
	LOCAL nAberto	  := 0
	LOCAL nRecibo	  := 0
	LOCAL nJuros	  := 0
	LOCAL nMulta	  := 0
	LOCAL nT
	LOCAL nAtraso
	LOCAL nDiaComUso
	LOCAL nDiaSemUso
	LOCAL nVlrComUso
	LOCAL nVlrSemUso
	LOCAL cStr
	LOCAL nLen

	::ZerarRecibo()
	::ZerarVencer()
	::ZerarVencido()
	::ZerarSelecao()
	::ZerarRescisao()
	
	
	For nT := 1 To xLen
		
		//calcular recebidos
		if !(::aAtivo[nT])	
			::nPrincipal_Recibo       += xTodos[nT,XTODOS_VLR]
			::nMulta_Recibo           += xTodos[nT,XTODOS_MULTA]
			::nJuros_Recibo 			  += xTodos[nT,XTODOS_JUROS]
			::nTotal_Recibo           += xTodos[nT,XTODOS_SOMA]
			::nQtdDoc_Recibo++					
			::Color_pFore[nT]         := ::CorRecibo
		endif		
		
		nAtraso := Atraso( Date(), xTodos[nT,XTODOS_VCTO]) 
		if nAtraso < 0 
			::Color_pFore[nT] := ::CorVencer					
		endif	
		if nAtraso > oAmbiente:aSciArray[1,SCI_CARENCIA]
			::Color_pFore[nT] := ::CorVencido			
		endif	
		if nAtraso >= 0 .AND. nAtraso <= oAmbiente:aSciArray[1,SCI_CARENCIA]
			::Color_pFore[nT] :=::CorAviso
		endif	
				
		//calcular vencidos
		if xTodos[nT,XTODOS_VCTO] <= Date()
		   if ::aAtivo[nT] // sem recibo
				if xTodos[nT, XTODOS_DOCNR] != "000000-00"
					::nPrincipal_Vencido += xTodos[nT,XTODOS_VLR]
					::nMulta_Vencido     += xTodos[nT,XTODOS_MULTA]
					::nJuros_Vencido     += xTodos[nT,XTODOS_JUROS]
					::nTotal_Vencido     += xTodos[nT,XTODOS_SOMA]	
					::nQtdDoc_Vencido++										
				endif
			endif
		endif
		
		//calcular a vencer		
		if xTodos[nT,XTODOS_VCTO] > Date() 
			if xTodos[nT, XTODOS_DOCNR] != "000000-00"
				::nPrincipal_Vencer   += xTodos[nT,XTODOS_VLR]
				::nMulta_Vencer	    += xTodos[nT,XTODOS_MULTA]
				::nJuros_Vencer	    += xTodos[nT,XTODOS_JUROS]
				::nTotal_Vencer	    += xTodos[nT,XTODOS_SOMA]	
				::nQtdDoc_Vencer++				
			endif	
		endif
		
		//calcular rescisao		
		nVlr := xTodos[nT,XTODOS_VLR]
		cStr := aTodos[nT] 
		nLen := Len(cStr)
		if Empty(Right(cStr, nLen-80)) // mensalidade?
			if ::aAtivo[nT] // sem recibo
				if nAtraso < 0
					IF nAtraso < -30
						nVlr *= 0.5  // Metade da Mensalidade de Rescisao
						cstr := aTodos[nT] := Left( aTodos[nT], 77) + + ' ' + Tran(nVlr,  "@E 999,999.99") + ' {50%}'
					else
						nDiaComUso := (30 + nAtraso)
						nDiaSemUso := (30 - nDiaComUso)
						nVlrComUso := (nDiaComUso * (nVlr/30))
						nVlrSemUso := (nDiaSemUso * (nVlr/30)*0.5)
						nVlr		  := (nVlrComUso + nVlrSemUso)
						cstr       := aTodos[nT] := Left( aTodos[nT], 77) + ' ' + Tran(nVlr, "@E 999,999.99") + ' {' + StrZero(nDiaComUso,2) + 'D}=' + AllTrim(Tran(nVlrComUso, "@E 999,999.99")) + ;
																																		  ' + {' + StrZero(nDiaSemUso,2) + 'D}=' + AllTrim(Tran(nVlrSemUso, "@E 999,999.99")) + ' {50%}'
					endIF
				endIF
			endif	
		endif	
		
		if xTodos[nT,XTODOS_VCTO] > Date() 
			if ::aAtivo[nT] // sem recibo
				if xTodos[nT, XTODOS_DOCNR] != "000000-00"
					::nPrincipal_Rescisao += nVlr
					::nMulta_Rescisao	    += xTodos[nT,XTODOS_MULTA] /2
					::nJuros_Rescisao	    += xTodos[nT,XTODOS_JUROS] /2
					::nTotal_Rescisao	    += nVlr
					::nQtdDoc_Rescisao++						
					aTodos[nT] := cStr
				endif	
			endif	
		endif		
	Next

	::cStrRecibo  := ::RedrawRecibo
	::cStrVencido := ::RedrawVencido
	::cstrVencer  := ::RedrawVencer
return self

Function TReceposiNew()
	Return(TReceposi():New())

#include <hbclass.ch>
#Include <box.ch>
#Include <inkey.ch>
#include "achoice.ch"
#include "color.ch"
#include "inkey.ch"
#include "setcurs.ch"

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
#Define FALSO .F.
#DEFINE OK    .T.
#define AC_CURELEMENTO  10

/* NOTE: Extension: Harbour supports codeblocks and function pointers
         as the xSelect parameter (both when supplied as is, or as an
         array of codeblocks). [vszakats] */

METHOD AChoice( nTop, nLeft, nBottom, nRight, acItems, xSelect, xUserFunc, nPos, nHiLiteRow, lPageCircular)

   LOCAL nNumCols           // Number of columns in the window
   LOCAL nNumRows           // Number of rows in the window
   LOCAL nRowsClr           // Number of rows to clear
   LOCAL alSelect           // Select permission
   LOCAL nNewPos   := 0     // The next item to be selected
   LOCAL lFinished          // Is processing finished?
   LOCAL nKey      := 0     // The keystroke to be processed
   LOCAL nMode              // The current operating mode
   LOCAL nAtTop             // The number of the item at the top
   LOCAL nItems    := 0     // The number of items
   LOCAL nGap               // The number of lines between top and current lines
	
   // Block used to search for items
   LOCAL lUserFunc          // Is a user function to be used?
   LOCAL nUserFunc          // Return value from user function
   LOCAL nSaveCsr
   LOCAL nFrstItem := 0
   LOCAL nLastItem := 0

   LOCAL bAction
   LOCAL cKey
   LOCAL nAux
	DEFAU lPageCircular TO .T.
	
	// PRIVA :  := TAchoiceNew()
	// Afill((::Color_pFore := Array(Len(acItems))), Cor(1)) // oAmbiente:CorMenu
	// Afill((::Color_pBack := Array(Len(acItems))), Cor(5)) // oAmbiente:CorLightBar
	//Afill((::Color_pUns  := Array(Len(acItems))), AscanCorHKLightBar( Cor(1)))
			
	hb_default( @nTop, 0)
   hb_default( @nBottom, 0)

   hb_default( @nLeft, 0 )
   hb_default( @nRight, 0 )

   IF nRight > MaxCol()
      nRight := MaxCol()
   ENDIF

   IF nBottom > MaxRow()
      nBottom := MaxRow()
   ENDIF

   IF ! HB_ISARRAY( acItems ) .OR. Len( acItems ) == 0
      SetPos( nTop, nRight + 1 )
      RETURN 0
   ENDIF

   nSaveCsr := SetCursor( SC_NONE )
   ColorSelect( CLR_STANDARD )

   /* NOTE: Undocumented parameter passing handled. AChoice()
            is called in such way in rldialg.prg from RL tool
            supplied with Clipper 5.x. 6th parameter is the
            user function and 7th parameter is zero (empty I
            suppose). [vszakats] */
   IF Empty( xUserFunc ) .AND. ValType( xSelect ) $ "CBS"
      xUserFunc := xSelect
      xSelect   := NIL
   ENDIF

   lUserFunc := ! Empty( xUserFunc ) .AND. ValType( xUserFunc ) $ "CBS"

   IF ! HB_ISARRAY( xSelect ) .AND. ! HB_ISLOGICAL( xSelect )
      xSelect := .T.               // Array or logical, what is selectable
   ENDIF

   hb_default( @nPos, 1 )          // The number of the selected item
   hb_default( @nHiLiteRow, 0 )    // The row to be highlighted

   nNumCols := nRight - nLeft + 1
   nNumRows := nBottom - nTop + 1

   IF HB_ISARRAY( xSelect )
      alSelect := xSelect
   ELSE
      alSelect := Array( Len( acItems ) )
      AFill( alSelect, xSelect )
   ENDIF

   IF ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
      nPos := 0
		::CurElemento := nPos
   ENDIF

   // Ensure hilighted item can be selected
   nPos := BETWEEN( nFrstItem, nPos, nLastItem )
	::CurElemento := nPos
	
   // Force hilighted row to be valid
   nHiLiteRow := BETWEEN( 0, nHiLiteRow, nNumRows - 1 )

   // Force the topmost item to be a valid index of the array
   nAtTop := BETWEEN( 1, Max( 1, nPos - nHiLiteRow ), nItems )

   // Ensure as much of the selection area as possible is covered
   IF ( nAtTop + nNumRows - 1 ) > nItems
      nAtTop := Max( 1, nItems - nNumrows + 1 )
   ENDIF

   ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nItems )

   lFinished := ( nMode == AC_NOITEM )
   IF lFinished .AND. lUserFunc
	   Do( xUserFunc, nMode, nPos, nPos - nAtTop )
   ENDIF

   DO WHILE !lFinished
		IF nMode != AC_EXCEPT .AND. nMode != AC_NOITEM .AND. nMode != AC_CURELEMENTO
         nKey  := Inkey( 0 )
         nMode := AC_IDLE
      ENDIF

      DO CASE
		CASE nMode = AC_CURELEMENTO
		   nNewPos := ::CurElemento
			DO WHILE !::Ach_Select( alSelect, nNewPos )
            nNewPos--
         ENDDO
         IF INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            nPos := nNewPos
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
         ELSE
            DispBegin()
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
            hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
            nAtTop := nNewPos
            nPos   := Max( nPos, nAtTop + nNumRows - 1 )
            DO WHILE nPos > nNewPos
               IF nTop + nPos - nAtTop <= nBottom
                  ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               ENDIF
               nPos--
            ENDDO
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            DispEnd()
         ENDIF
		
      CASE ( bAction := SetKey( nKey ) ) != NIL
         Eval( bAction, ProcName( 1 ), ProcLine( 1 ), "" )
         IF NextKey() == 0
            hb_keySetLast( 255 )
            nKey := 0
         ENDIF

         nRowsClr := Min( nNumRows, nItems )
         IF ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
            nPos := 0
            nAtTop := Max( 1, nPos - nNumRows + 1 )
         ELSE
            DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
               nPos++
            ENDDO

            IF nPos > nLastItem
               nPos := BETWEEN( nFrstItem, nPos, nLastItem )
            ENDIF

            nAtTop := Min( nAtTop, nPos )
            IF nAtTop + nNumRows - 1 > nItems
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
            ENDIF

            IF nAtTop < 1
               nAtTop := 1
            ENDIF
         ENDIF

         ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems, nRowsClr )

      CASE ( nKey == K_ESC .OR. nMode == AC_NOITEM ) .AND. ! lUserFunc

         IF nPos != 0
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         ENDIF

         nMode     := AC_IDLE
         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LDBLCLK .OR. nKey == K_LBUTTONDOWN
         nAux := HitTest( nTop, nLeft, nBottom, nRight, MRow(), MCol() )
         IF nAux != 0 .AND. ( nNewPos := nAtTop + nAux - 1 ) <= nItems
            IF ::Ach_Select( alSelect, nNewPos )
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               IF nKey == K_LDBLCLK
                  hb_keyIns( K_ENTER )
               ENDIF
            ENDIF
         ENDIF

#ifdef HB_CLP_STRICT
      CASE nKey == K_UP
#else
      CASE nKey == K_UP .OR. nKey == K_MWFORWARD
#endif
			nNewPos := nPos - 1
			IF nNewPos < nFrstItem
				nPos    := nLastItem
				nAtTop  := Max( 1, nPos - nNumRows + 1 )
				nNewPos := nPos
				::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
				nMode   := AC_HITBOTTOM
			endif
         
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            IF INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ELSE
               DispBegin()
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos
               nPos   := Max( nPos, nAtTop + nNumRows - 1 )
               DO WHILE nPos > nNewPos
                  IF nTop + nPos - nAtTop <= nBottom
                     ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  ENDIF
                  nPos--
               ENDDO
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            ENDIF
         
#ifdef HB_CLP_STRICT
      CASE nKey == K_DOWN
#else
      CASE nKey == K_DOWN .OR. nKey == K_MWBACKWARD
#endif

         // Find the next selectable item to display
            nNewPos := nPos + 1
				IF nNewPos > nLastItem
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				endif
				
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO

            IF INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ELSE
               DispBegin()
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               hb_Scroll( nTop, nLeft, nBottom, nRight, nNewPos - ( nAtTop + nNumRows - 1 ) )
               nAtTop := nNewPos - nNumRows + 1
               nPos   := Max( nPos, nAtTop )
               DO WHILE nPos < nNewPos
                  ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
                  nPos++
               ENDDO
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
               DispEnd()
            ENDIF
								
         //ENDIF

      CASE nKey == K_CTRL_PGUP .OR. ( nKey == K_HOME .AND. ! lUserFunc )

         IF nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					IF nAtTop == Max( 1, nPos - nNumRows + 1 )
						nMode := AC_HITTOP
					ELSE
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					ENDIF
				endif	
         ELSE
            nPos   := nFrstItem
            nAtTop := nPos
            ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         ENDIF

      CASE nKey == K_CTRL_PGDN .OR. ( nKey == K_END .AND. ! lUserFunc )

         IF nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else	
					IF nAtTop == Min( nLastItem, nItems - Min( nItems, nNumRows ) + 1 )
						nMode   := AC_HITTOP
						nMode := AC_HITBOTTOM
					ELSE
						nAtTop := Min( nLastItem, nItems - nNumRows + 1 )
						::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					ENDIF
				endif	
         ELSE
            IF INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ELSE
               nPos   := nLastItem
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            ENDIF
         ENDIF

      CASE nKey == K_CTRL_HOME

         IF nPos == nFrstItem
            IF nAtTop == Max( 1, nPos - nNumRows + 1 )
               nMode := AC_HITTOP
            ELSE
               nAtTop := Max( 1, nPos - nNumRows + 1 )
               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            ENDIF
         ELSE
            nNewPos := nAtTop
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos++
            ENDDO
            IF nNewPos != nPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ENDIF
         ENDIF

      CASE nKey == K_CTRL_END

         IF nPos == nLastItem
            IF nAtTop == Min( nPos, nItems - Min( nItems, nNumRows ) + 1 ) .OR. nPos == nItems
               nMode := AC_HITBOTTOM
            ELSE
               nAtTop := Min( nPos, nItems - nNumRows + 1 )
               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            ENDIF
         ELSE
            nNewPos := Min( nAtTop + nNumRows - 1, nItems )
            DO WHILE ! ::Ach_Select( alSelect, nNewPos )
               nNewPos--
            ENDDO
            IF nNewPos != nPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ENDIF
         ENDIF

      CASE nKey == K_PGUP

         IF nPos == nFrstItem
				if lPageCircular
					nPos    := nLastItem
					nAtTop  := Max( 1, nPos - nNumRows + 1 )
					nNewPos := nPos
					::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITBOTTOM
				else
					nMode := AC_HITTOP
					IF nAtTop > Max( 1, nPos - nNumRows + 1 )
						nAtTop := Max( 1, nPos - nNumRows + 1 )
						::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					ENDIF
				endif	
         ELSE
            IF INRANGE( nAtTop, nFrstItem, nAtTop + nNumRows - 1 )
               // On same page as nFrstItem
               nPos   := nFrstItem
               nAtTop := Max( nPos - nNumRows + 1, 1 )
            ELSE
               IF ( nPos - nNumRows + 1 ) < nFrstItem
                  nPos   := nFrstItem
                  nAtTop := nFrstItem
               ELSE
                  nPos   := Max( nFrstItem, nPos - nNumRows + 1 )
                  nAtTop := Max( 1, nAtTop - nNumRows + 1 )
                  DO WHILE nPos > nFrstItem .AND. ! ::Ach_Select( alSelect, nPos )
                     nPos--
                     nAtTop--
                  ENDDO
                  nAtTop := Max( 1, nAtTop )
                  IF nAtTop < nNumRows .AND. nPos < nNumRows
                     nPos := nNumRows
                     nAtTop := 1
                  ENDIF
               ENDIF
            ENDIF
            ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
         ENDIF

      CASE nKey == K_PGDN

         IF nPos == nLastItem
				if lPageCircular
					nPos    := nFrstItem					
					nAtTop  := nPos
					nNewPos := nPos
					::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					nMode   := AC_HITTOP
				else
					nMode := AC_HITBOTTOM
					IF nAtTop < Min( nPos, nItems - nNumRows + 1 )
						nAtTop := Min( nPos, nItems - nNumRows + 1 )
						::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
					ENDIF
				endif	
         ELSE
            IF INRANGE( nAtTop, nLastItem, nAtTop + nNumRows - 1 )
               // On the same page as nLastItem
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nLastItem
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ELSE
               nGap := nPos - nAtTop
               nPos := Min( nLastItem, nPos + nNumRows - 1 )
               IF ( nPos + nNumRows - 1 ) > nLastItem
                  // On the last page
                  nAtTop := nLastItem - nNumRows + 1
                  nPos   := Min( nLastItem, nAtTop + nGap )
               ELSE
                  // Not on the last page
                  nAtTop := nPos - nGap
               ENDIF
               // Make sure that the item is selectable
               DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
                  nPos++
                  nAtTop++
               ENDDO
               // Don't leave blank space on the page
               DO WHILE ( nAtTop + nNumRows - 1 ) > nItems
                  nAtTop--
               ENDDO
               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            ENDIF
         ENDIF

      CASE nKey == K_ENTER .AND. ! lUserFunc

         IF nPos != 0
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         ENDIF

         nMode     := AC_IDLE
         lFinished := .T.

      CASE nKey == K_RIGHT .AND. ! lUserFunc

         IF nPos != 0
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         ENDIF

         nPos      := 0
         lFinished := .T.

      CASE nKey == K_LEFT .AND. ! lUserFunc

         IF nPos != 0
            ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         ENDIF

         nPos      := 0
         lFinished := .T.

      CASE ( ! lUserFunc .OR. nMode == AC_EXCEPT ) .AND. ;
           ! ( cKey := Upper( hb_keyChar( nKey ) ) ) == ""

         // Find next selectable item
         FOR nNewPos := nPos + 1 TO nItems
            IF ::Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( acItems[ nNewPos ], cKey )
               EXIT
            ENDIF
         NEXT
         IF nNewPos == nItems + 1
            FOR nNewPos := 1 TO nPos - 1
               IF ::Ach_Select( alSelect, nNewPos ) .AND. LeftEqI( acItems[ nNewPos ], cKey )
                  EXIT
               ENDIF
            NEXT
         ENDIF

         IF nNewPos != nPos
            IF INRANGE( nAtTop, nNewPos, nAtTop + nNumRows - 1 )
               // On same page
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .F., nNumCols, nPos )
               nPos := nNewPos
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, ::Ach_Select( alSelect, nPos ), .T., nNumCols, nPos )
            ELSE
               // On different page
               nPos   := nNewPos
               nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems )
               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems )
            ENDIF
         ENDIF

         nMode := AC_IDLE

      CASE nMode == AC_EXCEPT
		   nPos := ::CurElemento
         // Handle keypresses which don't translate to characters
         nMode := AC_IDLE
			
		CASE nMode == AC_CURELEMENTO
			nPos := ::CurElemento
			IF nPos != 0
				::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
         ENDIF
			nMode := AC_IDLE
         
      CASE nMode != AC_NOITEM
         nMode := iif( nKey == 0, AC_IDLE, AC_EXCEPT )

      ENDCASE

      IF lUserFunc
         IF HB_ISNUMERIC( nUserFunc := Do( xUserFunc, nMode, nPos, nPos - nAtTop ) )

            SWITCH nUserFunc
            CASE AC_ABORT
					lFinished := .T.
					nPos      := 0
               EXIT
					
				CASE AC_CURELEMENTO
					nPos := ::CurElemento
					IF nPos != 0
						::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
					ENDIF
					lFinished := .F.
               LOOP
				
				CASE AC_REDRAW  /* QUESTION: Is this correct? */
               IF nPos != 0
                  ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               ENDIF
               lFinished := .T.
               nPos      := 0
               EXIT
            CASE AC_SELECT
               IF nPos != 0
                  ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
               ENDIF
               lFinished := .T.
               EXIT
            CASE AC_CONT
               // Do nothing
					nMode := AC_IDLE
               EXIT
            CASE AC_GOTO
               // Do nothing. The next keystroke won't be read and
               // this keystroke will be processed as a goto.
               nMode := AC_EXCEPT
               EXIT
            ENDSWITCH

            IF nPos > 0 .AND. nMode != AC_EXCEPT

#if 0
               /* TOVERIFY: Disabled nRowsClr ::DispPage().
                  Please verify it, I do not know why it was added but
                  it breaks code which adds dynamically new acItems positions */
               nRowsClr := Min( nNumRows, nItems )
#endif
               IF ( nMode := ::Ach_Limits( @nFrstItem, @nLastItem, @nItems, alSelect, acItems ) ) == AC_NOITEM
                  nPos := 0
                  nAtTop := Max( 1, nPos - nNumRows + 1 )
               ELSE
                  DO WHILE nPos < nLastItem .AND. ! ::Ach_Select( alSelect, nPos )
                     nPos++
                  ENDDO

                  IF nPos > nLastItem
                     nPos := BETWEEN( nFrstItem, nPos, nLastItem )
                  ENDIF

                  nAtTop := Min( nAtTop, nPos )

                  IF nAtTop + nNumRows - 1 > nItems
                     nAtTop := BETWEEN( 1, nPos - nNumRows + 1, nItems - nNumRows + 1 )
                  ENDIF

                  IF nAtTop < 1
                     nAtTop := 1
                  ENDIF
               ENDIF

               ::DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nItems /*, nRowsClr */ )
            ENDIF
         ELSE
            IF nPos != 0
               ::Displine( acItems[ nPos ], nTop + nPos - nAtTop, nLeft, .T., .F., nNumCols, nPos )
            ENDIF
            nPos      := 0
            lFinished := .T.
         ENDIF
      ENDIF
   ENDDO
   SetCursor( nSaveCsr )
   RETURN nPos

METHOD HitTest( nTop, nLeft, nBottom, nRight, mRow, mCol )

   IF mCol >= nLeft .AND. ;
      mCol <= nRight .AND. ;
      mRow >= nTop .AND. ;
      mRow <= nBottom
      RETURN mRow - nTop + 1
   ENDIF

   RETURN 0

METHOD DispPage( acItems, alSelect, nTop, nLeft, nRight, nNumRows, nPos, nAtTop, nArrLen, nRowsClr )

   LOCAL nCntr
   LOCAL nRow       // Screen row
   LOCAL nIndex     // Array index

   hb_default( @nRowsClr, nArrLen )

   DispBegin()
   FOR nCntr := 1 TO Min( nNumRows, nRowsClr )

      nRow   := nTop + nCntr - 1
      nIndex := nCntr + nAtTop - 1

      IF INRANGE( 1, nIndex, nArrLen )
         ::Displine( acItems[ nIndex ], nRow, nLeft, ::Ach_Select( alSelect, nIndex ), nIndex == nPos, nRight - nLeft + 1, nIndex )
      ELSE		
         ColorSelect( CLR_STANDARD )
         hb_DispOutAt( nRow, nLeft, Space( nRight - nLeft + 1 ) )
      ENDIF
   NEXT
   DispEnd()

   RETURN

METHOD Displine( cLine, nRow, nCol, lSelect, lHiLite, nNumCols, nCurElemento )
	
	nSetColor( ::Color_pFore[nCurElemento], ::Color_pBack[nCurElemento], ::Color_pUns[nCurElemento])
	ColorSelect( iif( lSelect .AND. HB_ISSTRING( cLine ), iif( lHiLite, CLR_ENHANCED, CLR_STANDARD ), CLR_UNSELECTED ))	
	hb_DispOutAt( nRow, nCol, iif( HB_ISSTRING( cLine ), PadR( cLine, nNumCols ), Space( nNumCols ) ) )	
   IF lHiLite
      SetPos( nRow, nCol )
   ENDIF	
   ColorSelect( CLR_STANDARD )
   RETURN

METHOD Ach_Limits( /* @ */ nFrstItem, /* @ */ nLastItem, /* @ */ nItems, alSelect, acItems )

   LOCAL nCntr

   nFrstItem := nLastItem := nItems := 0

   FOR nCntr := 1 TO Len( acItems )
      IF HB_ISSTRING( acItems[ nCntr ] ) .AND. Len( acItems[ nCntr ] ) > 0
         nItems++
         IF ::Ach_Select( alSelect, nCntr )
            IF nFrstItem == 0
               nFrstItem := nLastItem := nCntr
            ELSE
               nLastItem := nItems
            ENDIF
         ENDIF
      ELSE
         EXIT
      ENDIF
   NEXT

   IF nFrstItem == 0
      nLastItem := nItems
      RETURN AC_NOITEM
   ENDIF

   RETURN AC_IDLE

METHOD Ach_Select( alSelect, nPos )

   LOCAL sel
	
   IF nPos >= 1 .AND. nPos <= Len( alSelect )
      sel := alSelect[ nPos ]
      IF HB_ISEVALITEM( sel )
         sel := Eval( sel )
      ELSEIF HB_ISSTRING( sel ) .AND. ! Empty( sel )
         sel := Eval( hb_macroBlock( sel ) )
      ENDIF
      IF HB_ISLOGICAL( sel )
         RETURN sel
      ENDIF
   ENDIF

   RETURN .T.

METHOD LeftEqI( string, cKey )	
	LOCAL nLen := Len( cKey )
	return( IIF(Left(string, nLen ) == cKey, .T., .F.))
