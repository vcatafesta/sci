#include "classic.ch"

BEGIN CLASS TIndice
	 Export:
		  VAR aNome_Campo
		  VAR aNome_Ntx
		  VAR acTag
		  VAR ProgressoNtx
		  VAR Reindexando
		  VAR Row
		  VAR Col
		  VAR Alias
		  VAR Compactar
		  VAR Reindexado
		  VAR Final
	 Export:
		  METHOD Init
		  METHOD DbfNtx
		  METHOD AddNtx
		  METHOD CriaNtx
		  METHOD ProgNtx
		  METHOD PackDbf
		  METHOD Limpa
End Class

Method procedure Init( cAlias )
	Self:ProgressoNtx := .F.
	Self:Reindexando	:= .F.
	Self:aNome_Campo	:= {}
	Self:aNome_Ntx 	:= {}
	Self:acTag			:= {}
	Self:Row 			:= 09
	Self:Col 			:= 15
	Self:Compactar 	:= .F.
	Self:Reindexado	:= .F.
	Self:Final			:= .F.
	Self:DbfNtx( cAlias )
	Return( Self )

Method Limpa()
	Self:aNome_Campo	:= {}
	Self:aNome_Ntx 	:= {}
	Self:acTag			:= {}
	Return( Self )

Method DbfNtx( cAlias )
***********************
	Self:aNome_Campo	:= {}
	Self:aNome_Ntx 	:= {}
	Self:acTag			:= {}
	IF cAlias != NIL
		Sele ( cAlias )
	EndIF
	IF Used()
		Self:Alias := Alias()
	EndIF
	Return( Self )

Method PackDbf( cAlias )
************************
	IF Self:Compactar
		IF cAlias != NIL
			Sele ( cAlias )
		EndIF
		IF Used()
			Self:Alias := Alias()
		EndIF
		Mensagem("Aguarde, Compactando : " + cAlias )
		__DbPack()
	EndIF
	Return( Self )

Method AddNtx( Nome_Campo, Nome_Ntx, cTag )
****************************************
	Aadd( Self:aNome_Campo, Nome_Campo )
	Aadd( Self:aNome_Ntx,	Nome_Ntx   )
	Aadd( Self:acTag, 		cTag		  )
	Return( Self )

Method CriaNtx()
****************
	LOCAL cScreen := SaveScreen()
	LOCAL nLen	  := Len( Self:aNome_Campo )
	LOCAL nX 	  := 0
	LOCAL nCol	  := Self:Row - 2
	LOCAL Nome_Campo
	LOCAL Nome_Ntx
	LOCAL cTag

	oMenu:Limpa()
	//MaBox( Self:Row, Self:Col, Self:Row+nLen+1, 42, Self:Alias )
	MaBox( Self:Row, Self:Col, Self:Row+nLen+1, 42, Self:Alias )
	For nX := 1 To nLen
		Nome_Campo := Self:aNome_Campo[nX]
		Nome_Ntx   := Self:aNome_Ntx[nX]
		cTag		  := Self:acTag[nX]
		Self:Reindexando	:= .T.
		Self:Reindexado	:= .T.
		nSetColor( Roloc( Cor()))

		//Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
		//Write( Self:Row+nX, Self:Col+15+10, Chr(10))
		Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
		Write( Self:Row+nX, Self:Col+15+10, Chr(10))

		IF RddSetDefa() = "DBFNTX"
			IF Self:ProgressoNtx
				MaBox( Self:Row-5, Self:Col, Self:Row-1, Self:Row+57 )
				Index On &Nome_Campo. To &Nome_Ntx. Eval Self:ProgNtx() Every LastRec() / 100
			Else
				Index On &Nome_Campo. To &Nome_Ntx.
			EndIF
		Else
			IF Self:ProgressoNtx
				//MaBox( Self:Row-5, Self:Col, Self:Row-1, Self:Row+57 )
				//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Self:ProgNtx() Every Lastrec() / 100
				MaBox( Self:Row-5, Self:Col, Self:Row-1, Self:Row+57 )
				Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Self:ProgNtx() Every Lastrec() / 100
				//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Odometer() Every 10
			Else
				//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag )
				Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag )
				//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Odometer() Every 10
			EndIF
		EndIF
		Self:Reindexando	:= .F.
		nSetColor(Cor())
		//Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
		//Write( Self:Row+nX, Self:Col+15+10, Chr(251))
		Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
		Write( Self:Row+nX, Self:Col+15+10, Chr(251))
	Next
	ResTela( cScreen )
	Return( Self )

Method ProgNtx
**************
	LOCAL nReg		 := Recno()
	LOCAL nUltimo	 := LastRec()
	LOCAL nPorcento := ( nReg / nUltimo ) * 100
	LOCAL cComplete := LTrim( Str( Int( nPorcento )))
	IF cComplete  = "99"
		cComplete := "100"
	EndIF
	@ Self:Row-4, Self:Col+1 Say "þ " + LTrim(Str(nReg)) + " de " + LTrim(Str(nUltimo )) + " Registros"
	@ Self:Row-3, Self:Col+1 Say "þ " + cComplete + "%"
	@ Self:Row-2, Self:Col+1 Say Replicate(" ", 100/2 ) Color "W+/r"
	@ Self:Row-2, Self:Col+1 Say Replicate("Û", nPorcento/2 ) Color "W+/r"
	Return .T.

Function TIndiceNew( cAlias )
	Return( TIndice():New( cAlias ))
