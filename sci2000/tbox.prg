#include "classic.ch"
//#include "class(y).ch"
#Include "Box.Ch"
#Include "Inkey.Ch"

#Define  FALSO   .F.
#Define  OK      .T.
#define SETA_CIMA 			  5
#define SETA_BAIXO			  24
#define SETA_ESQUERDA		  19
#define SETA_DIREITA 		  4
#define TECLA_SPACO			  32
#define TECLA_ALT_F4 		  -33
#define ENABLE 				  .T.
#define DISABLE				  .F.

//CREATE CLASS MBox
BEGIN CLASS TBox
    Export:
        VAR Cima
		  VAR Esquerda
		  VAR Baixo
		  VAR Direita
		  VAR cScreen
        VAR Cabecalho
        VAR Rodape
		  VAR Cor
		  VAR Frame

    Export:
        METHOD Init
        METHOD Show
        METHOD Hide
        METHOD Up
        METHOD Down
        METHOD Right
        METHOD PageUp
        METHOD PageDown
        METHOD Move
        METHOD MoveGet
        MESSAGE Inkey    METHOD InkeyMBox
        MESSAGE Esquerda METHOD LeftMBox

End Class

Method Procedure Init( nCima, nEsquerda, nBaixo, nDireita, cCabecalho, cRodape, lInverterCor )
		  ::Cima 	  := IF( nCima 	 != NIL, nCima,	  10 )
		  ::Esquerda  := IF( nEsquerda != NIL, nEsquerda, 10 )
		  ::Baixo	  := IF( nBaixo	 != NIL, nBaixo,	  20 )
		  ::Direita   := IF( nDireita  != NIL, nDireita,  40 )
		  ::Cor		  := IF( lInverterCor != NIL, lInverterCor, 31 )
		  ::Cabecalho := IF( cCabecalho != NIL, cCabecalho, NIl )
		  ::Rodape	  := IF( cRodape	  != NIL, cRodape,	 NIL )
        ::Frame     := B_SINGLE
        Return( Self )

Method Move( oGetList, nCima, nEsquerda, nBaixo, nDireita )
		  LOCAL nTam := Len( oGetList )
		  LOCAL nDifTopo := nCima		- ::Cima
		  LOCAL nDifEsq  := nEsquerda - ::Esquerda
		  ::Hide()
        ::Show( nCima, nEsquerda, nBaixo, nDireita )
		  IF nTam != 0
			  ::MoveGet( oGetList, nTam, nDifTopo, nDifEsq )
		  EndIF
        Return( Self )

Method MoveGet( oGetList, nTam, nDifTopo, nDifEsq )
		  LOCAL nX
		  For nX := 1 To nTam
			  oGetList[nX]:Row += nDifTopo
			  oGetList[nX]:Col += nDifEsq
		  Next
		  RETURN Self

Method Hide( nTela )
		  ResTela( ::cScreen )
		  RETURN Self

Method InkeyMBox()
		  Inkey(0)
		  IF LastKey() = 397
			  ::Up()
		  End
		  Return Self

Method Up()
		  ::Hide()
		  ::Cima--
		  ::Baixo--
		  ::Paint()
		  Return Self

Method PageUp()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima 	 := 0
		  ::Baixo	 := 4
		  ::Paint()
		  Return Self

Method PageDown()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima 	 := 20
		  ::Baixo	 := 24
		  ::Paint()
		  Return Self

Method Down()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Cima++
		  ::Baixo++
		  ::Paint()
		  Return Self

Method LeftMBox()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Esquerda--
		  ::Direita--
		  ::Paint()
		  Return Self

Method Right()
		  ::Hide()
		  ::cScreen  := SaveScreen()
		  ::Esquerda++
		  ::Direita++
		  ::Paint()
		  Return Self

Method Show( nCima, nEsquerda, nBaixo, nDireita, cCabecalho, cRodape, lInverterCor )
	LOCAL cPattern := " "
		  LOCAL cCor
		  LOCAL pBack
		  ::cScreen 	:= SaveScreen()
	::Cima		 := IF( nCima		!= NIL, nCima, ::Cima )
	::Esquerda	:= IF( nEsquerda != NIL, nEsquerda, ::Esquerda )
	::Baixo		:= IF( nBaixo	  != NIL, nBaixo, ::Baixo )
	::Direita	:= IF( nDireita  != NIL, nDireita,	::Direita)
	::Cor 	 := IF( lInverterCor != NIL, lInverterCor, ::Cor )
	::Cabecalho := IF( cCabecalho != NIL, cCabecalho, ::Cabecalho )
	::Rodape 	:= IF( cRodape 	!= NIL, cRodape,	  ::Rodape )

		  cCor := ::Cor
	DispBegin()
	IF ::Direita = 79
		::Direita := MaxCol()
	EndIf
		  ColorSet( @cCor, @pback )
	Box( ::Cima, ::Esquerda, ::Baixo, ::Direita, Super:Frame + cPattern, ::Cor )
	IF ::Cabecalho != Nil
		aPrint( ::Cima, ::Esquerda+1, "Û", Roloc( ::Cor ), (::Direita-::Esquerda)-1)
		aPrint( ::Cima, ::Esquerda+1, Padc( ::Cabecalho, ( ::Direita-::Esquerda)-1), Roloc( ::Cor ))
	EndIF
	IF ::Rodape != Nil
		aPrint( ::Baixo, ::Esquerda+1, "Û", Roloc( ::Cor ), (::Direita-::Esquerda)-1)
		aPrint( ::Baixo, ::Esquerda+1, Padc( ::Rodape, ( ::Direita-::Esquerda)-1), Roloc( ::Cor ))
	EndIF
		  cSetColor( SetColor())
		  nSetColor( cCor, Roloc( cCor ))
	DispEnd()
	Return Self

Function TBoxNew()
*******************
   Return( TBox():New())
