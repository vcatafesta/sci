Proc Paga5()
************
LOCAL GetList    := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Individual", "Geral"}
LOCAL xAlias     := FTempName("T*.$$$")
LOCAL nChoice    := 0
LOCAL cCodi      := Space(04)
LOCAL dIni       := Date()
LOCAL dFim       := Date()+30
LOCAL Tot_Juros  := 0
LOCAL Tot_Geral  := 0
LOCAL nConta     := 0
LOCAL nAtraso    := 0
LOCAL nJuroDia   := 0
LOCAL nField     := 0
LOCAL bBloco
LOCAL bCodi
LOCAL bPeriodo
LOCAL bVencido
LOCAL cTela
FIELD Codi

oMenu:Limpa()
WHILE OK
	M_Title("CONSULTAR TITULOS A PAGAR" )
	nChoice := FazMenu( 05, 10, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Pagar" )
		Pagar->( Order( PAGAR_CODI ))
		cCodi 	 := Space( 04 )
		dFim		 := Date()
		dIni		 := dFim - 30
		Tot_Juros := 0
		Tot_Geral := 0
		nConta	 := 0
		MaBox( 11, 10, 15, 75 )
		@ 12, 11 Say "Fornecedor...:" Get cCodi Pict "@!" Valid PagaRrado( @cCodi, Row(), Col()+1 )
		@ 13, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 14, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area( "Pagamov" )
      Pagamov->(Order( PAGAMOV_CODI ))
		oMenu:Limpa()
		IF !DbSeek( cCodi )
			Nada()
			ResTela( cScreen )
			Loop
		EndIF
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		bCodi 	:= {|| Pagamov->Codi = cCodi }
		bPeriodo := {| dVcto | dVcto >= dIni .AND. dVcto <= dFim }
		bVencido := {| dVcto | dVcto < Date() }
		cTela 	:= Mensagem("Aguarde, Processando.", Cor())
		WHILE Eval( bCodi ) .AND. Rep_Ok()
			IF Eval( bPeriodo, Pagamov->Vcto )
				nConta++
				Tot_Geral += Pagamov->Vlr
				IF Eval( bVencido, Pagamov->Vcto )
					nAtraso	 := Atraso( Date(), Pagamov->Vcto )
					nJuroDia  := JuroDia( Pagamov->Vlr, Pagamov->Juro )
					Tot_Juros += ( nAtraso * nJuroDia )
				EndIF
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			EndIF
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		oMenu:Limpa()
		IF nConta = 0
			Nada()
		Else
			Paga45( Tot_Geral, Tot_Juros )
		EndIF
		xTemp->(DbCloseArea())
		Ferase( xAlias )

	Case nChoice = 2
		dFim		 := Date()
		dIni		 := dFim - 30
		nConta	 := 0
		Tot_Juros := 0
		Tot_Geral := 0
		MaBox( 11, 10, 14, 75 )
		@ 12, 11 Say "Data Inicial.:" Get dIni Pict "##/##/##"
		@ 13, 11 Say "Data Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area( "PagaMov" )
		Pagamov->(Order(3)) // VCTO
		oMenu:Limpa()
		Set Soft On
		Pagamov->(DbSeek( dIni ))
		Set Soft Off
		Copy Stru To ( xAlias )
		Use ( xAlias ) Exclusive Alias xTemp New
		bBloco	:= {|| Pagamov->Vcto >= dIni .AND. Pagamov->Vcto <= dFim }
		bPeriodo := {| dVcto | dVcto >= dIni .AND. dVcto <= dFim }
		bVencido := {| dVcto | dVcto < Date() }
		cTela 	:= Mensagem("Aguarde, Processando.", Cor())
		WHILE Eval( bBloco ) .AND. Rep_Ok()
			IF Eval( bPeriodo, Pagamov->Vcto )
				nConta++
				Tot_Geral += Pagamov->Vlr
				IF Eval( bVencido, Pagamov->Vcto )
					nAtraso	 := Atraso( Date(), Pagamov->Vcto )
					nJuroDia  := JuroDia( Pagamov->Vlr, Pagamov->Juro )
					Tot_Juros += ( nAtraso * nJuroDia )
				EndIF
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Pagamov->(FieldGet( nField ))))
				Next
			EndIF
			Pagamov->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		oMenu:Limpa()
		IF nConta = 0
			Nada()
		Else
			Paga45( Tot_Geral, Tot_Juros )
		EndIF
		xTemp->(DbCloseArea())
		Ferase( xAlias )
	EndCase
EndDo
ResTela( cScreen )
Return
