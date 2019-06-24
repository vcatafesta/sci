Proc Produ52( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL MouseList := {}
LOCAL cScreen	 := SaveScreen()
LOCAL cCodi
LOCAL nRegCortes
LOCAL Opcao
LOCAL cTabela2
LOCAL cTabela1
LOCAL cFunc
LOCAL cCodiSer
LOCAL nQuant
LOCAL nQuantAnt
LOCAL nSobrando
FIELD Tabela
FIELD Codiven
FIELD CodiSer
FIELD Qtd
FIELD Data
FIELD Sobra

WHILE OK
	Area("Cortes")
	Cortes->(Order( CORTES_TABELA ))
	MaBox( 15, 10, 17, 31 )
	cCodi := Space(07)
	@ 16, 11 Say "Tabela..:" Get cCodi Pict "9999.99" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		DbClearRel()
		DbClearFilter()
		DbGoTop()
		ResTela( cScreen )
		Exit

	EndIf
	nRegCortes := Recno()
	Area("Movi")
	Set Filter To Tabela = cCodi
	DbGoTop()
	Count To nItens
	IF ( nItens = 0 )
		ErrorBeep()
		Alerta("Erro: Nenhum Movimento Disponivel Desta Tabela..." )
		DbClearRel()
		DbClearFilter()
		DbGoTop()
		ResTela( cScreen )
		Exit
	EndIf
	DbGoTop()
	oMenu:Limpa()
	MaBox( 09, 10, 15, 65, cCabecalho )
	MoviProx( cCabecalho )
	WHILE OK
		MaBox( 20, 07, 22, 73 )
		AtPrompt( 21, 08, " Editar " )
		AtPrompt( 21, 17, " Excluir " )
		AtPrompt( 21, 27, " Proximo " )
		AtPrompt( 21, 37, " Anterior " )
		AtPrompt( 21, 49, " Localizar " )
		AtPrompt( 21, 61, " Retornar " )
		Menu To opcao
		Do Case
		Case opcao = 0 .OR. opcao = 6 .OR. opcao = 5
			DbClearRel()
			DbClearFilter()
			DbGoTop()
			ResTela( cScreen )
			Exit

		Case opcao = 1
			ErrorBeep()
			Alerta("Erro: Use a opcao Excluir...")

		Case opcao = 2
			ErrorBeep()
			IF Conf( "Pergunta: Confirma Exclusao do Registro ?" )
				cTabela := Movi->Tabela
				nQtd	  := Movi->Qtd
				Cortes->( Order( CORTES_TABELA ))
				Cortes->(DbSeek( cTabela ))
				IF Cortes->(TravaReg())
					IF Movi->(!TravaReg())
						Cortes->(Libera())
						Loop
					EndIF
					Cortes->Sobra := Cortes->Sobra + nQtd
					Cortes->(Libera())
					Movi->(DbDelete())
					Movi->(Libera())
					Alerta( "Tarefa: Registro Excluido...")
					Movi->(DbSkip())
					MoviProx( cCabecalho )
				EndIf
			EndIf
			DbSkip()
			MoviProx( cCabecalho )
			Loop

		Case opcao = 3
			IF Eof()
				ErrorBeep()
				Loop

			EndIf
			DbSkip()
			MoviProx( cCabecalho )
			Loop

		Case opcao = 4
			IF Bof()
				ErrorBeep()
				Loop

			EndIf
			DbSkip( -1 )
			MoviProx( cCabecalho )
		EndCase
	EndDo
EndDo
