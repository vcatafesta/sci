#include "classic.ch"
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


BEGIN CLASS TRelato
    Export:
		  VAR RowPrn
		  VAR Pagina
		  VAR Tamanho
		  VAR NomeFirma
		  VAR Sistema
		  VAR Titulo
		  VAR Cabecalho
		  VAR Separador
		  VAR Registros

    Export:
        METHOD Init
        METHOD Inicio

End Class

Method Procedure Init()
		  ::RowPrn	  := 0
		  ::Pagina	  := 0
		  ::Tamanho   := 80
		  ::NomeFirma := IF( XNOMEFIR = NIL, "", XNOMEFIR )
        ::Sistema   := "MicroBras NOME DO PROGRAMA"
		  ::Titulo	  := "TITULO DO RELATORIO"
		  ::Cabecalho := "CODIGO DESCRICAO"
		  ::Separador := "="
		  ::Registros := 0
        Return( Self )

Method Inicio
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
      Return( Self )

Function TRelatoNew()
*********************
Return( TRelato():New())
