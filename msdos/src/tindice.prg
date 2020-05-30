#include <sci.ch>

CLASS TIndice
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
		  METHOD New CONSTRUCTOR
		  METHOD DbfNtx
		  METHOD AddNtx
		  METHOD CriaNtx
		  METHOD ProgNtx
		  METHOD PackDbf
		  METHOD Limpa
ENDCLASS

METHOD New( cAlias )
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
	return( Self )

METHOD Limpa()
	::aNome_Campo	:= {}
	::aNome_Ntx 	:= {}
	::acTag			:= {}
	return( Self )

METHOD DbfNtx( cAlias )
***********************
	LOCAL bQuery
	Self:aNome_Campo	:= {}
	Self:aNome_Ntx 	:= {}
	Self:acTag			:= {}
	if cAlias != NIL		
		WA_USE((cAlias))
		WA_LOCK((cAlias))
		Sele (cAlias)		
	endif
	if Used()
		Self:Alias := Alias()
	endif
	return( Self )

METHOD PackDbf( cAlias )
	if Self:Compactar
		if cAlias != NIL
			WA_USE((cAlias))
			WA_LOCK((cAlias))
			Sele (cAlias)
		endif
		if Used()
			Self:Alias := Alias()
			mensagem(" Aguarde, Compactando ;-;;#" + cAlias)
			__DbPack()
		endif
	endif
	return( Self )

METHOD AddNtx( Nome_Campo, Nome_Ntx, cTag ) CLASS TIndice
****************************************
	Aadd( Self:aNome_Campo, Nome_Campo )
	Aadd( Self:aNome_Ntx,	Nome_Ntx   )
	Aadd( Self:acTag, 		cTag		  )
	return( Self )

METHOD CriaNtx()
	LOCAL cScreen := SaveScreen()
	LOCAL nLen	  := Len( Self:aNome_Campo )
	LOCAL nX 	  := 0
	LOCAL nCol	  := Self:Row - 2
	LOCAL Nome_Campo
	LOCAL Nome_Ntx
	LOCAL cTag

	if Used() // 13:56 25/04/2018
		oMenu:Limpa()
		MaBox( Self:Row, Self:Col, Self:Row+nLen+1, 42, Self:Alias )
		For nX := 1 To nLen
			Nome_Campo := Self:aNome_Campo[nX]
			Nome_Ntx   := Self:aNome_Ntx[nX]
			cTag		  := Self:acTag[nX]
			Self:Reindexando	:= .T.
			Self:Reindexado	:= .T.
			//nSetColor( Roloc( Cor()))

			Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
			Write( Self:Row+nX, Self:Col+15+10, Chr(10))

			if RddSetDefa() = "DBFNTX"
				if Self:ProgressoNtx
					MaBox( Self:Row-5, Self:Col, Self:Row-1, Self:Row+57 )
					Index On &Nome_Campo. To &Nome_Ntx. Eval Self:ProgNtx() Every LastRec() / 100
				else
					Index On &Nome_Campo. To &Nome_Ntx.
				endif
			else
				if Self:ProgressoNtx
					MaBox( Self:Row-5, Self:Col, Self:Row-1, Self:Row+57 )
					Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Self:ProgNtx() Every Lastrec() / 100
					//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Odometer() Every 10
				else
					Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag )
					//Index On &Nome_Campo. Tag &Nome_Ntx. To ( cTag ) Eval Odometer() Every 10
				endif
			endif
			Self:Reindexando	:= .F.
			nSetColor(Cor())
			Write( Self:Row+nX, Self:Col+1, Self:aNome_Ntx[nX] + Repl("Ä", 24 - Len( Self:aNome_Ntx[nX])))
			Write( Self:Row+nX, Self:Col+15+10, Chr(251))		
		Next	
		resTela( cScreen )
		return( Self )	
		WA_UNLOCK(Alias())  // 13:57 25/04/2018
	endif

METHOD def ProgNtx
	LOCAL nReg		 := Recno()
	LOCAL nUltimo	 := LastRec()
	LOCAL nPorcento := ( nReg / nUltimo ) * 100
	LOCAL cComplete := LTrim( Str( Int( nPorcento )))
	if cComplete  = "99"
		cComplete := "100"
	endif
	@ Self:Row-4, Self:Col+1 Say "þ " + LTrim(Str(nReg)) + " de " + LTrim(Str(nUltimo )) + " Registros"
	@ Self:Row-3, Self:Col+1 Say "þ " + cComplete + "%"
	@ Self:Row-2, Self:Col+1 Say Replicate(" ", 100/2 ) Color "W+/r"
	@ Self:Row-2, Self:Col+1 Say Replicate("Û", nPorcento/2 ) Color "W+/r"
	return .T.

def TIndiceNew( cAlias )
	return( TIndice():New( cAlias ))
