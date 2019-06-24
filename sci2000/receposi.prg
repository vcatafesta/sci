*------------------------------------------------------------------------------

Proc RecePosi( nChoice, xParam, cCaixa, lRescisao )
***************************************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0
LOCAL nT 		 := 0
LOCAL xLen		 := 0
LOCAL nRegPago  := 0
LOCAL dCalculo  := Date()
LOCAL nJuroDia  := 0
LOCAL cColor	 := SetColor()
LOCAL lCalcular
LOCAL cFatu
LOCAL cCodi
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
LOCAL xObs
LOCAL cStr
LOCAL xDataPag
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
PRIVA aCodi 	  := {}
PRIVA xTodos	  := {}
PRIVA aTodos	  := {}
PRIVA alMulta	  := {}
PRIVA oRecePosi := TReceposi()

IfNil( lRescisao, FALSO )
oAmbiente:lReceber	 := OK
oReceposi:aAtivo		 := {}
oReceposi:aAtivoSwap  := {}
oReceposi:aHistRecibo := {}
oReceposi:aUserRecibo := {}
oReceposi:nQtdDoc 	 := 0

oMenu:Limpa()
Receber->(Order( RECEBER_CODI ))
Recemov->(DbGoTop())
IF Recemov->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	Do Case
	Case nChoice = 1
		IF xParam != NIL
			cCodi := xParam
			//dFim  := Date()
			dFim	:= Ctod("31/12/" + Right(Dtoc(Date()),2))
			IF oAmbiente:Ano2000
				dIni	:= Ctod("01/01/80")
			Else
				dIni	:= Ctod("01/01/01")
			EndIF
		Else
			cCodi 	:= Space(05)
			dIni		:= Ctod("01/01/91")
			dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
			dCalculo := Date()
			IF lRescisao
				cStr		:= "Data Rescisao:"
			Else
				cStr		:= "Calcular ate.:"
			EndIF
			MaBox( 14, 45, 19, 75 )
			@ 15, 46 Say "Cliente......:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
			@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
			@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
			@ 18, 46 Say cStr 				Get dCalculo Pict "##/##/##"
			Read
			IF LastKey() = ESC
				DbClearRel()
				ResTela( cScreen )
				Exit
			EndIF
		EndIF
		Area("Recemov")
		Recemov->(Order( RECEMOV_CODI ))
		oBloco		:= {|| Recemov->Codi = cCodi }
		IF !DbSeek( cCodi )
			Nada()
			IF xParam != NIL
				Exit
			Else
				Loop
			EndIF
		EndIF
		oReceposi:PosiReceber := OK

	Case nChoice = 2
		cRegiao	:= Space(02)
		dIni		:= Ctod("01/01/91")
		dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
		dCalculo := Date()
		MaBox( 14, 45, 19, 75 )
		@ 15, 46 Say "Regiao.......:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
		@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
		@ 18, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
		Read
		IF LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		EndIF
		Area("Recemov")
		Recemov->(Order( RECEMOV_REGIAO ))
		IF !DbSeek( cRegiao )
			Nada()
			Loop
		EndIF
		oBloco := {|| Recemov->Regiao = cRegiao }
		oReceposi:PosiReceber := FALSO

	Case nChoice = 3
		dIni		:= Ctod("01/01/91")
		dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
		dCalculo := Date()
		MaBox( 14, 45, 18, 75 )
		@ 15, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
		@ 16, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
		@ 17, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
		Read
		IF LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		EndIF
		Area("Recemov")
		Recemov->( Order( RECEMOV_VCTO ))
		IF !SeekData( dIni, dFim, "Vcto" )
			Nada()
			Loop
		EndIF
		oBloco := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
		oReceposi:PosiReceber := FALSO

	Case nChoice = 4
		cTipo 	:= Space(06)
		dIni		:= Ctod("01/01/91")
		dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
		dCalculo := Date()
		MaBox( 14, 45, 19, 75 )
		@ 15, 46 Say "Tipo.........:" Get cTipo Pict "@!" Valid AchaTipo( cTipo )
		@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
		@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
		@ 18, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Recemov->(DbClearRel())
			Recemov->(DbGoTop())
			ResTela( cScreen )
			Exit
		EndIF
		Area("Recemov")
		Recemov->(Order( RECEMOV_TIPO_CODI ))
		IF !DbSeek( cTipo )
			Nada()
			Loop
		EndIF
		oBloco  := {|| Recemov->Tipo = cTipo }
		oReceposi:PosiReceber := FALSO

	Case nChoice = 5
		IF xParam != NIL
			cFatu := xParam
		Else
			cFatu := Space(7)
			MaBox( 14, 45, 16, 67 )
			@ 15, 46 Say "Fatura N§.:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
			Read
			IF LastKey() = ESC
				Recemov->(DbClearRel())
				Recemov->(DbGoTop())
				ResTela( cScreen )
				Exit
			EndIF
		EndIF
		Area("Recemov")
		Recemov->(Order( RECEMOV_FATURA ))
		oBloco := {|| Recemov->Fatura = cFatu }
		IF !DbSeek( cFatu )
			Nada()
			IF xParam != NIL
				ResTela( cScreen )
				Exit
			Else
				Loop
			EndIF
		EndIF
		oReceposi:PosiReceber := FALSO

	Case nChoice = 6
		dCalculo := Date()
		MaBox( 14, 45, 16, 75 )
		@ 15, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Recemov->(DbClearRel())
			Recemov->(DbGoTop())
			ResTela( cScreen )
			Exit
		EndIF
		Area("Recemov")
		Recemov->(Order(UM)) // CODI
		Recemov->(DbGoTop())
		oBloco := {|| Recemov->(!Eof()) }
		oReceposi:PosiReceber := FALSO

	EndCase
	nRecebido	:= 0
	nValorTotal := 0
	nJuros		:= 0
	nMulta		:= 0
	nAtraso		:= 0
	nDesconto	:= 0
	nSoma 		:= 0
	nTotalGeral := 0
	Col			:= 12
	aTodos		:= {}
	xTodos		:= {}
	oReceposi:aAtivo		 := {}
	oReceposi:aAtivoSwap  := {}
	oReceposi:aHistRecibo := {}
	oReceposi:aUserRecibo := {}
	oReceposi:nQtdDoc 	 := 0
	aCodi 		:= {}
	nConta		:= 0
	nRegPago 	:= 0
	xObs			:= Space(0)
	cTela 		:= Mensagem("Aguarde... ", Cor())
	lCalcular	:= (dCalculo != Ctod("00/00/00")) // Nao calcular juros ou descontos
	dCalculo 	:= IF(!lCalcular, Date(), dCalculo)

	WHILE Eval( oBloco )
		IF nConta >= 4096
			Alerta("Erro: Impossivel mostrar mais do que 4096 registros.")
			Exit
		EndIF
		IF nChoice != 5 .AND. nChoice != 6
			IF Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF !oAmbiente:Mostrar_Desativados
			IF nChoice != 1
				IF nChoice != 5
					cCodi := Recemov->Codi
					Receber->(Order( RECEBER_CODI ))
					IF Receber->(DbSeek( cCodi ))
						IF !Receber->Suporte
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
			EndIF
		EndIF

		cCodi   := Recemov->Codi
		nAtraso := Atraso( dCalculo, Vcto )
		nVlr	  := Recemov->Vlr
		IF lRescisao
			IF nAtraso < 0
				IF nAtraso < -30
					nVlr *= 0.5  // Metade da Mensalidade de Rescisao
				Else
					nDiaComUso := (30 + nAtraso)
					nDiaSemUso := (30 - nDiaComUso)
					nVlrComUso := (nDiaComUso * (nVlr/30))
					nVlrSemUso := (nDiaSemUso * (nVlr/30)*0.5)
					nVlr		  := (nVlrComUso + nVlrSemUso)
				EndIF
			EndIF
		EndIF
		IF lCalcular
			nCarencia	:= Carencia( dCalculo, Vcto )
			//nMulta 	  := VlrMulta( dCalculo, Vcto, nVlr )
			nMulta		:= 0
			nDesconto	:= VlrDesconto( dCalculo, Vcto, nVlr )
			//nJurodia	  := Jurodia( nVlr, Juro, XJURODIARIO )
			nJurodia 	:= Recemov->Jurodia
			nJuros		:= IF( nAtraso <= 0, 0, ( nCarencia * nJurodia ))
		EndIF
		xObs			:= Recemov->Obs

		Recibo->(Order( RECIBO_DOCNR))
		IF Recibo->(DbSeek( Recemov->Docnr ))
			xDataPag := Recibo->Data
			nRegPago++
		Else
			xDataPag := Ctod("31/12/2099") // Para fins de indexacao
		EndIF
		nValorTotal += nVlr
		nTotalGeral += nVlr
		nTotalGeral += nJuros
		nTotalGeral += nMulta
		nTotalGeral -= nDesconto
		nSoma 		:= ((nVlr + nMulta ) + nJuros ) - nDesconto
		nMulta		:= VlrMulta( dCalculo, Vcto, nSoma )
		nSoma 		+= nMulta
		nTotalGeral += nMulta
		nConta++
		Aadd( xTodos, { Docnr,;
							 Emis,;
							 Vcto,;
							 nAtraso,;
							 nVlr,;
							 nDesconto,;
							 nMulta,;
							 nJuros,;
							 nSoma,;
							 Codi,;
							 xObs,;
							 DateToStr(xDataPag)+DateToStr(Vcto)+Docnr,;
							 DateToStr(Vcto)+Docnr,;
							 DateToStr(xDataPag)+DateToStr(Vcto),;
							 Fatura})
		Aadd( aTodos, Docnr + " " + ;
						  Left( Dtoc(Emis),5 ) + " " + ;
						  Dtoc( Vcto ) + " " + ;
						  StrZero( nAtraso, 4) + " " + ;
						  Tran( nVlr,			"@E 99,999.99") + " " + ;
						  Tran( nDesconto,	"@E 9,999.99")  + " " + ;
						  Tran( nJuros,		"@E 9,999.99")  + " " + ;
						  Tran( nMulta,		"@E 9,999.99")  + " " + ;
						  Tran( nSoma, 		"@E 999,999.99"))
		Recemov->(DbSkip(1))
	EndDo
	//IF nRegPago >= 15
		Aadd( xTodos, {Repl("0",6)+"-00",;
							cTod("01/01/1900"),;
							cTod("01/01/1900"),;
							0,;
							0,;
							0,;
							0,;
							0,;
							0,;
							cCodi,;
							Space(40),;
							DateToStr(cTod("")) + DateToStr(cTod(""))+Space(9),;
							DateToStr(cTod("")) + Space(9),;
							DateToStr(cTod("")) + DateToStr(cTod("")),;
							Space(9)}) // Incluir Registro vazio para cursor poder ir topo

		Aadd( aTodos, Repl("0",6)+ "-00 " + Left( Dtoc(cTod("")),5 ) + " " + ;
						  Dtoc( cTod("")) + " " + StrZero( 0, 4) + " " + ;
						  Tran( 0,	 "@E 99,999.99") + " " + ;
						  Tran( 0,	 "@E 9,999.99")  + " " + ;
						  Tran( 0,	 "@E 9,999.99")  + " " + ;
						  Tran( 0,	 "@E 9,999.99")  + " " + ;
						  Tran( 0,	 "@E 999,999.99"))
	//EndIF
	ResTela( cTela )
	IF Len( aTodos ) > 0
		Mensagem('Informa: Aguarde, ordenando.')
		IF nChoice = 5
			Asort( xTodos,,, {|x,y|x[13] < y[13]}) // VCTO_DOCNR
		Else
			Asort( xTodos,,, {| x, y | y[12] > x[12] } ) // DATAPAG_VCTO_DOCNR
		EndIF
		alMulta					 := {}
		oReceposi:aAtivo		 := {}
		oReceposi:aAtivoSwap  := {}
		oReceposi:aHistRecibo := {}
		oReceposi:aUserRecibo := {}
		oReceposi:nQtdDoc 	 := 0
		aCodi 					 := {}
		aTodos					 := {}
		aPos						 := {}
		xLen						 := Len(xTodos)
		For nT := 1 To xLen
			Aadd( oReceposi:aHistRecibo,Space(0))
			Aadd( oReceposi:aUserRecibo,Space(0))
			Aadd( oReceposi:aAtivoSwap, OK )
			Aadd( oReceposi:aAtivo, OK )
			Aadd( alMulta, (xTodos[nT,7] <> 0)) // Multa?
			Aadd( aCodi, xTodos[nT,10] )
			Aadd( aTodos, xTodos[nT,1] + " " + ;
							  Left( Dtoc( xTodos[nT,2]),5 ) + " " + ;
							  Dtoc(xTodos[nT,3]) + " " + ;
							  StrZero( xTodos[nT,4], 4) + " " + ;
							  Tran(xTodos[nT,5], "@E 99,999.99") + " " + ;
							  Tran(xTodos[nT,6], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,8], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,7], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,9], "@E 999,999.99"))

		Next
		IF oAmbiente:Mostrar_Recibo
			SeekLog(xTodos, aTodos)
		EndIF
		MaBox( 00, 00, 06, 79 )
		oRecePosi:aBottom := SomaRecebido(xTodos, nConta, nValorTotal, nTotalGeral)
// 	oRecePosi:cTop 	:= " DOCTO N§  EMIS   VENCTO ATRA  ORIGINAL DESC/PAG PG/MULTA    JUROS     ABERTO     "
		oRecePosi:cTop 	:= " DOCTO N§  EMIS   VENCTO ATRA  ORIGINAL DESC/PAG    JUROS PG/MULTA     ABERTO     "
		oRecePosi:cTop 	+= Space( MaxCol() - Len(oRecePosi:cTop))
		oRecePosi:Redraw()
		M_Title("[ESC] RETORNA")
		oReceposi:PosiReceber := OK
		__Funcao( 0, 1, 1 )
		SetColor(",,,,R+/")
		aChoice( 08, 01, MaxRow()-3, MaxCol()-1, aTodos, oRecePosi:aAtivo, "__Funcao" )
		SetColor(cColor)
		xTodos				 := {}
		oReceposi:PosiReceber := FALSO
	EndIF
	ResTela( cScreen )
	IF nChoice = 6 .OR. xParam != NIL
		Exit
	EndIF
EndDo
