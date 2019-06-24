/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³																								 ³
 Ý³	Programa.....: LISTALAN.PRG														 ³
 Ý³	Aplicacaoo...: SISTEMA DE CONTROLE DE ESTOQUE								 ³
 Ý³	Versao.......: 3.3.00																 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³   Empresa......: Microbras Com de Prod de Informatica Ltda              ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³	Ult.Atual....: 20 de Janeiro de 2001.											 ³
 Ý³	Compilacao...: Clipper 5.2e														 ³
 Ý³	Linker.......: Blinker 5.00														 ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include   "InKey.Ch"
#Include   "SetCurs.Ch"
#Include   "Lista.Ch"
#Include   "Indice.Ch"
#Include   "Permissao.ch"
#Include   "Picture.ch"

Proc ListaLan()
***************
LOCAL lOk      := OK
PUBL Ent
*:----------------------------------------------------------------------------
SetKey( F5, {|| TabPreco() })
SetColor("")
AbreArea()
oMenu:Limpa()
*:----------------------------------------------------------------------------
RefreshClasse()
WHILE lOk
	Begin Sequence
      Op := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Encerrar este modulo ?")
				GravaDisco()
				lOk := FALSO
				Break
			EndIF
		Case Op = 2.01
			IF PodeIncluir()
				InclusaoProdutos()
			EndIF
		Case Op = 2.02
			IF PodeIncluir()
				Lista1_1()
			EndIF
		Case Op = 2.03
			IF PodeIncluir()
				Lista1_2()
			EndIF
		Case Op = 2.04
			IF PodeIncluir()
				InclusaoTaxas()
			EndIF
		Case Op = 2.05
			IF PodeIncluir()
				InclusaoDolar()
			EndIF
		Case Op = 2.06
			IF PodeIncluir()
				InclusaoForma()
			EndIF
		Case Op = 2.07
			IF PodeIncluir()
				ForInclusao()
			EndIF
		Case Op = 2.08
			IF PodeIncluir()
				Func11()
			EndIF
		Case Op = 2.09
			IF PodeIncluir()
				CliInclusao()
			EndIF
		Case Op = 2.10
			IF PodeIncluir()
				CepInclusao()
			EndIF
		Case Op = 2.11
			IF PodeIncluir()
				RepresInclusao()
			EndIF
		Case Op = 3.01
			AlteraProdutos()
		Case Op = 3.02
			GrupoDbedit( OK )
		Case Op = 3.03
			SubGrupoDbEdit()
		Case Op = 3.04
			TaxasDbEdit()
		Case Op = 3.05
			MudaDolar()
		Case Op = 3.06
			FormaConsulta( OK )
		Case Op = 3.07
			MudaMargem()
		Case Op = 3.08
			MudaCep()
		Case Op = 3.09
			MudaFor()
		Case Op = 3.10
			AjustaEstoque()
      Case Op = 3.11
         AjustaPrevenda()
      Case Op = 3.12
			AjustaIcms()
      Case Op = 3.13
         MudaRepres()
      Case Op = 3.14
			GerCodBar()
      Case Op = 3.15
			TransValores()
      Case Op = 3.16
			RepresDbEdit()
      Case Op = 3.17
			TrocaEntSai()
		Case Op = 4.01
			RelaDolar()
		Case Op = 4.02
			EtiQueta()
		Case Op = 4.03
			MenuEstoques()
		Case Op = 4.04
			MenuEntSai()
		Case Op = 4.05
			FormaRelatorio()
		Case Op = 4.06
			PrintGrupo()
		Case Op = 4.07
			Relatori1()
		Case Op = 4.08
         EntNota()
		Case Op = 4.09
			Pedidos()
		Case Op = 4.10
			RolRepres()
		Case Op = 4.11
			PrintSubGrupo()
		Case Op = 4.12
			RelaTaxas()
		Case Op = 5.01
			Lista21()
		Case Op = 5.02
			Lista22()
		Case Op = 5.03
			TaxasDbedit()
		Case Op = 5.04
			GrupoDbedit( FALSO )
		Case Op = 5.05
			SubGrupoDbedit()
		Case Op = 5.06
			ConLista(3)
		Case Op = 5.07
			PagarDbedit()
		Case Op = 5.08
			ClientesFiltro()
		Case Op = 5.09
			MudaDolar()
		Case Op = 5.10
			FormaConsulta( FALSO )
		Case Op = 5.11
			GraficoVenda()
		Case Op = 5.12
			GraficoCompra()
		Case Op = 5.13
			PedidoDbedit( ( nVisualizar := 1 ))
		Case Op = 5.14
			Maiorais()
		Case Op = 6.01
			Reajustes(( lVenda := OK ))
		Case Op = 6.02
			Reajustes(( lVenda := FALSO ))
		Case Op = 6.03
			ReajVarDolar()
		Case Op = 6.04
			ReajAtaDolar()
		Case Op = 6.05
			MostraDebito()
		Case Op = 7.01
			Orcamento( OK )
		Case Op = 7.02
			Orcamento( OK )
		Case Op = 7.03
			Orcamento( OK )
		Case Op = 7.04
			Ped_Cli9()
		Case Op = 7.05
			Entradas()
		Case Op = 7.06
			BaixaDebitoc_c()
		Case Op = 7.07
			Entradas()
		Case Op = 7.08
			TrocaEmis()
		Case Op = 8.01
         DupPersonalizado()
		Case Op = 8.02
			DiretaLivre()
		Case Op = 8.03
         ProBranco()
		Case Op = 8.04
			Espelho()
		Case Op = 8.05
			EspelhoParcial()
		Case Op = 8.06
			RelacaoEntrega()
		Case Op = 8.07
			Separacao()
		Case Op = 8.08
			NotaFiscal()
		Case Op = 8.09
			Ipi()
		Case Op = 8.10
			Bordero()
		Case Op = 8.11
			Sefaz()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde... Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
Set Key F5 To
Return

*:----------------------------------------------------------------------------

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup      := oMenu:StSupArray[2]
oMenu:StatusInf      := oMenu:StInfArray[2]
oMenu:Menu           := oMenu:MenuArray[2]
oMenu:Disp           := oMenu:DispArray[2]
Return

*:==================================================================================================================================

Proc AjustaEstoque()
********************
LOCAL nDebito		:= 0
LOCAL nCredito 	:= 0
LOCAL nEstoque 	:= 0
LOCAL nChoice		:= 1
LOCAL xCodigo		:= 0
LOCAL cGrupo		:= Space(3)
LOCAL aMenu 		:= {"Individual", "Por Grupo", "Por Fornecedor", "Geral"}

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA A OPCAO DE AJUSTE   ")
	nChoice := FazMenu( 07, 10, aMenu, Cor())
	IF nChoice = 0
		Return
	EndIF
	IF nChoice = 1
		xCodigo	  := 0
		Lista->(Order( LISTA_CODIGO ))
		MaBox( 04, 10, 06, 78 )
		@ 05, 11 Say  "Codigo :" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo,,, Row(), Col()+6)
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		nDebito	:= 0
		nCredito := 0
		Saidas->(Order( SAIDAS_CODIGO ))
		IF Saidas->(DbSeek( xCodigo ))
			Mensagem('Aguarde, Somando Saidas.')
			While Saidas->Codigo = xCodigo .AND. Rep_Ok()
				nDebito += Saidas->Saida
				Saidas->(DbSkip(1))
			EndDo
		EndIF
		Entradas->(Order( ENTRADAS_CODIGO ))
		IF Entradas->(DbSeek( xCodigo ))
			Mensagem('Aguarde, Somando Entradas.')
			While Entradas->Codigo = xCodigo  .AND. Rep_Ok()
				nCredito += Entradas->Entrada
				Entradas->(DbSkip(1))
			EndDo
		EndIF
		Mensagem('Aguarde, Gravando Estoque.')
		Lista->(Order( LISTA_CODIGO ))
		IF Lista->(DbSeek( xCodigo ))
			IF Lista->(TravaReg())
				Lista->Quant := ( nCredito - nDebito )
				Lista->(Libera())
				oMenu:Limpa()
				Alerta("Tarefa: Estoque Atualizado.")
			EndIF
		Else
			oMenu:Limpa()
			Alerta("Erro: Estoque nao Atualizado.")
		EndIF

	ElseIf nChoice = 2
		cGrupo := Space(03)
		MaBox( 04, 10, 06, 31 )
		@ 05, 11 Say "Grupo.:" Get cGrupo Pict "999" Valid CodiGrupo( @cGrupo )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODGRUPO ))
		IF Lista->(!DbSeek( cGrupo ))
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		IF Lista->(DbSeek( cGrupo ))
			While Lista->CodGrupo = cGrupo .AND. Rep_Ok()
				xCodigo	:= Lista->Codigo
				nDebito	:= 0
				nCredito := 0
				Saidas->(Order( SAIDAS_CODIGO ))
				IF Saidas->(DbSeek( xCodigo ))
					Mensagem('Aguarde, Somando Saidas.')
					While Saidas->Codigo = xCodigo .AND. Rep_Ok()
						nDebito += Saidas->Saida
						Saidas->(DbSkip(1))
					EndDo
				EndIF
				Entradas->(Order( ENTRADAS_CODIGO ))
				IF Entradas->(DbSeek( xCodigo ))
					Mensagem('Aguarde, Somando Entradas.')
					While Entradas->Codigo = xCodigo .AND. Rep_Ok()
						nCredito += Entradas->Entrada
						Entradas->(DbSkip(1))
					EndDo
				EndIF
				IF Lista->(TravaReg())
					Lista->Quant := ( nCredito - nDebito )
					Lista->(Libera())
				EndIF
				Lista->(DbSkip(1))
			EndDo
			oMenu:Limpa()
			Alerta("Tarefa: Estoque Atualizado.")
		Else
			oMenu:Limpa()
			Alerta("Erro: Estoque Nao Atualizado.")
		EndIf

	ElseIf nChoice = 3
		cCodi := Space(04)
		MaBox( 04, 10, 06, 78 )
		@ 05, 11 Say "Fornecedor.:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODI ))
		IF Lista->(!DbSeek( cCodi ))
			Loop
		EndIF
		IF !SimOuNao()
			Loop
		EndIF
		xCodigo := Lista->Codigo
		IF Lista->(DbSeek( cCodi ))
			While Lista->Codi = cCodi .AND. Rep_Ok()
				xCodigo	:= Lista->Codigo
				nDebito	:= 0
				nCredito := 0
				Saidas->(Order( SAIDAS_CODIGO ))
				IF Saidas->(DbSeek( xCodigo ))
					Mensagem('Aguarde, Somando Saidas.')
					While Saidas->Codigo = xCodigo .AND. Rep_Ok()
						nDebito += Saidas->Saida
						Saidas->(DbSkip(1))
					EndDo
				EndIF
				Entradas->(Order( ENTRADAS_CODIGO ))
				IF Entradas->(DbSeek( xCodigo ))
					Mensagem('Aguarde, Somando Entradas.')
					While Entradas->Codigo = xCodigo  .AND. Rep_Ok()
						nCredito += Entradas->Entrada
						Entradas->(DbSkip(1))
					EndDo
				EndIF
				IF Lista->(TravaReg())
					Lista->Quant := ( nCredito - nDebito )
					Lista->(Libera())
				EndIF
				Lista->(DbSkip(1))
			EndDo
			oMenu:Limpa()
			Alerta("Tarefa: Estoque Atualizado.")
		Else
			oMenu:Limpa()
			Alerta("Erro: Estoque Nao Atualizado.")
		EndIf

	ElseIf nChoice = 4
		IF !SimOuNao()
			Loop
		EndIF
		Area("Lista")
		Lista->( Order( LISTA_CODIGO ))
		Lista->(DbGoTop())
		xCodigo := Lista->Codigo
		While Lista->(!Eof()) .AND. Rep_Ok()
			xCodigo	:= Lista->Codigo
			nCredito := 0
			nDebito	:= 0
			Saidas->(Order( SAIDAS_CODIGO ))
			IF Saidas->(DbSeek( xCodigo ))
				Mensagem('Aguarde, Somando Entradas.')
				While Saidas->Codigo = xCodigo .AND. Rep_Ok()
					nDebito += Saidas->Saida
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Entradas->(Order( ENTRADAS_CODIGO ))
			IF Entradas->(DbSeek( xCodigo ))
				Mensagem('Aguarde, Somando Saidas.')
				While Entradas->Codigo = xCodigo  .AND. Rep_Ok()
					nCredito += Entradas->Entrada
					Entradas->(DbSkip(1))
				EndDo
			EndIF
			IF Lista->(TravaReg())
				Lista->Quant := ( nCredito - nDebito )
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
		EndDo
		oMenu:Limpa()
		Alerta("Tarefa: Estoque Atualizado.")
	EndIF
EndDo
ResTela( cScreen )
Return

*:==================================================================================================================================

Proc TrocaEntSai()
******************
LOCAL cScreen	:= SaveScreen()
LOCAL xCodigo1 := 0
LOCAL xCodigo2 := 0

WHILE OK
	oMenu:Limpa()
	xCodigo1 := 0
	xCodigo2 := 0
	Lista->(Order( LISTA_CODIGO ))
	MaBox( 04, 05, 07, 78 )
	@ 05, 06 Say  "Codigo Anterior..:" Get xCodigo1 Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo1,,, Row(), Col()+1)
	@ 06, 06 Say  "Codigo Atual.....:" Get xCodigo2 Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo2,,, Row(), Col()+1)
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIf
	ErrorBeep()
	IF Conf('Pergunta: Deseja Continuar a Troca ?')
		Mensagem('Aguarde, Trabalhando Processando Pesado.')
		Saidas->(Order( SAIDAS_CODIGO ))
		Entradas->(Order( ENTRADAS_CODIGO ))
		Lista->(Order( LISTA_CODIGO ))
		IF Lista->(DbSeek( xCodigo1 ))
			IF Saidas->(DbSeek( xCodigo1 ))
				While Saidas->(DbSeek( xCodigo1 )) .AND. Rep_Ok()
					IF Saidas->(TravaReg())
						Saidas->Codigo := xCodigo2
						Saidas->(Libera())
					EndIF
				EndDo
			EndIF
			IF Entradas->(DbSeek( xCodigo1 ))
				While Entradas->(DbSeek( xCodigo1 )) .AND. Rep_Ok()
					IF Entradas->(TravaReg())
						Entradas->Codigo := xCodigo2
						Entradas->(Libera())
					EndIF
				EndDo
			EndIF
		EndIF
	EndIf
EnddO

*:==================================================================================================================================

Proc GerCodBar()
****************
LOCAL GetList	:= {}
LOCAL nChoice	:= 1
LOCAL cCodeBar := Space(13)
LOCAL aMenu 	:= {"Individual ", "Por Grupo ", "Por Fornecedor ", "Geral" }
LOCAL xCodigo
LOCAL cGrupo
LOCAL cCodigo
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	M_Title("GERAR CODIGO DE BARRA")
	nChoice := FazMenu( 05, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		Return

	Case nChoice = 1
		xCodigo	  := 0
		Lista->(Order( LISTA_CODIGO ))
		MaBox( 13, 10, 15, 78 )
		@ 14, 11 Say  "Codigo :" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo,,, Row(), Col()+6)
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODIGO ))
		IF Lista->(DbSeek( xCodigo ))
			ErrorBeep()
			IF Conf("Pergunta: Continuar com a Alteracao ?")
				cCodeBar := EMPRECODEBAR + Lista->Codi + Lista->Codigo
				cCodeBar += EanDig( cCodeBar )
				IF Lista->(TravaReg())
					Lista->CodeBar := cCodeBar
					Lista->(Libera())
				EndIF
			EndIF
		EndIF

	Case nChoice = 2
		cGrupo := Space(03)
		Grupo->(Order(GRUPO_CODGRUPO ))
		MaBox( 13, 10, 15, 78 )
		@ 14, 11 Say "Grupo.:" Get cGrupo Pict "999" Valid CodiGrupo( @cGrupo )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODGRUPO ))
		IF Lista->(!DbSeek( cGrupo ))
			Loop
		EndIF
		ErrorBeep()
		IF !Conf("Pergunta: Continuar com a Alteracao ?")
			Loop
		EndIF
		cCodigo := Lista->Codigo
		While Lista->CodGrupo = cGrupo .AND. Rep_Ok()
			cCodeBar := EMPRECODEBAR + Lista->Codi + Lista->Codigo
			cCodeBar += EanDig( cCodeBar )
			IF Lista->(TravaReg())
				Lista->CodeBar := cCodeBar
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
		EndDo

	Case nChoice = 3
		cCodi := Space(04)
		MaBox( 13, 10, 15, 78 )
		@ 14, 11 Say "Fornecedor.:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Lista")
		Lista->(Order( LISTA_CODI ))
		IF Lista->(!DbSeek( cCodi ))
			Loop
		EndIF
		ErrorBeep()
		IF !Conf("Pergunta: Continuar com a Alteracao ?")
			Loop
		EndIF
		cCodigo := Lista->Codigo
		While Lista->Codi = cCodi .AND. Rep_Ok()
			cCodeBar := EMPRECODEBAR + Lista->Codi + Lista->Codigo
			cCodeBar += EanDig( cCodeBar )
			IF Lista->(TravaReg())
				Lista->CodeBar := cCodeBar
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
		EndDo

	Case nChoice = 4
		ErrorBeep()
		IF !Conf("Pergunta: Continuar com a Alteracao ?")
			Loop
		EndIF
		Area("Lista")
		Lista->( Order( LISTA_CODIGO ))
		Lista->(DbGoTop())
		cCodigo := Lista->Codigo
		Mensagem("Aguarde, Gerando Codigo de Barra.")
		While Lista->(!Eof()) .AND. Rep_Ok()
			cCodeBar := EMPRECODEBAR + Lista->Codi + Lista->Codigo
			cCodeBar += EanDig( cCodeBar )
			IF Lista->(TravaReg())
				Lista->CodeBar := cCodeBar
				Lista->(Libera())
			EndIF
			Lista->(DbSkip(1))
		EndDo
	EndCase
EndDo
Return

Proc TransValores()
*******************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}

oMenu:Limpa()
IF Conf("Pergunta: Confirma Transporte de Valores ?")
	Mensagem("Informa: Aguarde, Alterando Valores.")
	IF Lista->(TravaArq())
		Lista->(DbGoTop())
		WHILE Lista->(!Eof())
			Lista->Varejo := Lista->Atacado
			Lista->(DbSkip(1))
		EndDo
	EndIF
	Lista->(Libera())
EndIF
ResTela( cScreen )
Return

Proc InclusaoTaxas( dDIni )
**************************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL dDfim
LOCAL nDolar
LOCAL nUfir
LOCAL nJurVar
LOCAL nJurAta
LOCAL nTxAtu

oMenu:Limpa()
MaBox( 05, 11, 12, 49, "INCLUSAO DE NOVOS INDEXADORES" )
IF dDIni = Nil
	dDIni := Date() + 7
EndIF
dDFim  := dDIni
nTxAtu := nJurAta := nJurVar := nUfir := nDolar := 0
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
WHILE OK
	@ 06, 	  12 Say "Data...................:" Get dDini   Pict PIC_DATA Valid TaxaCerta( dDIni )
	@ Row()+1, 12 Say "Tx Atualizacao Diaria..:" Get nTxAtu  Pict "999.99"
	@ Row()+1, 12 Say "Tx Juros Atacado.......:" Get nJurAta Pict "999.99"
	@ Row()+1, 12 Say "Tx Juros Varejo........:" Get nJurVar Pict "999.99"
	@ Row()+1, 12 Say "Ufir Diaria............:" Get nUfir   Pict "9999.99"
	@ Row()+1, 12 Say "Cotacao Dolar R$.......:" Get nDolar  Pict "99999999.99"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Confirma Inclusao do Registro ?")
		IF !TaxaCerta( dDIni )
			Loop
		EndIF
		IF Taxas->(!Incluiu())
			Loop
		EndIF
		Taxas->Dini 	 := dDIni
		Taxas->DFim 	 := dDIni
		Taxas->TxAtu	 := nTxATu
		Taxas->JurAta	 := nJurAta
		Taxas->JurVar	 := nJurVar
		Taxas->Ufir 	 := nUfir
		Taxas->Cotacao  := nDolar
		Taxas->(Libera())
	EndIF
EndDo

Function TaxaCerta( dData )
***************************
IF Taxas->(DbSeek( dData ))
	ErrorBeep()
	Alerta("Erro: Data ja registrada. Escolha Pesq/Altera Indexadores!")
	Return( FALSO )
EndIF
Return( OK )

Proc AlteraProdutos()
*********************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 1
LOCAL aMenu   := {" Individual ordem Codigo ", " Individual ordem Descricao ", " Em Tabela "}

WHILE OK
	M_Title("ALTERACAO DE PRODUTOS")
	nChoice := FazMenu( 05, 23, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Otherwise
		ConLista( nChoice )

	EndCase
EndDo

Proc ReajVarDolar() // Reajuste Varejo Pela Cotacao do Dolar
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dData   := Date()

MaBox( 10, 10, 12, 45 )
@ 11, 11 Say "Reajustar para o Dia ¯¯ " Get dData Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
oMenu:Limpa()
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
WHILE !DbSeek( dData )
	ErrorBeep()
	 IF Conf("Cota‡ao de " + Dtoc( dData ) + " Nao Encontrada. Registrar ? ")
		 InclusaoDolar( dData )
	 Else
		 ResTela( cScreen )
		 Return
	 EndIF
EndDo
IF Taxas->Cotacao = 0
	ErrorBeep()
	IF Conf("Cota‡ao Ja registrada com valor 0. Alterar ? ")
		MudaDolar( OK )
	Else
		ResTela( cScreen )
		Return
	EndIF
EndIF
IF Conf(" Reajustar Preco Varejo Pelo Dolar de " + Dtoc( dData ) + " ?")
	nCotacao := Taxas->Cotacao
	Mensagem("Aguarde... Atualizando Preco Varejo Pelo Dolar...", WARNING )
	Area("Lista")
	Lista->(Order( LISTA_DESCRICAO ))
	Lista->(DbGoTop())
	IF Lista->(TravaArq())
		While !Eof()
			Lista->Varejo := ( nCotacao * Lista->Varejo )
			Lista->(DbSkip())
		EndDo
		Lista->(Libera())
	EndIF
EndIF
ResTela( cScreen )
Return

Proc ReajAtaDolar() // Reajuste Atacado Pela Cotacao do Dolar
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dData   := Date()

MaBox( 10, 10, 12, 45 )
@ 11, 11 Say "Reajustar para o Dia ¯¯ " Get dData Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
oMenu:Limpa()
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
WHILE !DbSeek( dData )
	ErrorBeep()
	IF Conf("Cota‡ao de " + Dtoc( dData ) + " Nao Encontrada. Registrar ? ")
		InclusaoDolar( dData )
	Else
		ResTela( cScreen )
		Return
	EndIF
EndDo
IF Taxas->Cotacao = 0
	ErrorBeep()
	IF Conf("Cota‡ao Ja registrada com valor 0. Alterar ? ")
		MudaDolar( OK )
	Else
		ResTela( cScreen )
		Return
	EndIF
EndIF
IF Conf(" Reajustar Preco Atacado Pelo Dolar de " + Dtoc( dData ) + " ?")
	nCotacao := Taxas->Cotacao
	Mensagem("Aguarde... Atualizando Preco Atacado Pelo Dolar...", WARNING )
	Area("Lista")
	Lista->(Order( LISTA_DESCRICAO ))
	DbGoTop()
	IF Lista->(TravaArq())
		While !Eof()
			Lista->Atacado := ( nCotacao * Lista->Atacado )
			Lista->(DbSkip())
		EndDo
		Lista->(Libera())
	EndIF
EndIF
ResTela( cScreen )
Return

Function CodiGrupo( cGrupo )
****************************
LOCAL aRotina := {{|| Lista1_1() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Grupo->(Order( GRUPO_CODGRUPO ))
IF Grupo->(! DbSeek( cGrupo ))
	Grupo->(Order( GRUPO_DESGRUPO ))
	Grupo->(Escolhe( 03, 01, 22,"CodGrupo + 'º' + DesGrupo","GRUPO DESCRICAO DO GRUPO", aRotina ))
	cGrupo := Grupo->CodGrupo
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function CodiSubGrupo( cSubGrupo )
*********************************
LOCAL aRotina := {{|| Lista1_2() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Lista")
Lista->(Order( LISTA_SUBGRUPO ))
IF !( DbSeek( cSubGrupo ))
	Area("SubGrupo")
	SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
	Escolhe( 03, 01, 22,"CodsGrupo + 'º' + DessGrupo","SUBGRUPO DESCRICAO DO SUBGRUPO", aRotina )
	cSubGrupo := CodsGrupo
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Reajustes( lVenda )
************************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Reajuste Individual       ",;
							 " Reajuste Parcial          ",;
							 " Reajuste Por Grupo        ",;
							 " Reajuste Por SubGrupo     ",;
							 " Reajuste Por Fornecededor ",;
							 " Reajuste Geral            "}
WHILE OK
	 IF lVenda
		 M_Title("REAJUSTE PRECO VENDA" )
	 Else
		 M_Title("REAJUSTE PRECO CUSTO" )
	 EndIF
	 VendaCusto := FazMenu( 05, 11, aMenuArray, Cor())
	 Do Case
	 Case VendaCusto = 0
		 ResTela( cScreen )
		 Exit
	 OtherWise
		 Reajuste( lVenda, VendaCusto )
	 EndCase
EndDo

Proc Reajuste( lVenda, VendaCusto )
***********************************
#Define PCUSTO 	!lVenda
#Define PVENDA 	lVenda
LOCAL cScreen		:= SaveScreen()
LOCAL nItem 		:= UM
LOCAL nParcial 	:= DOIS
LOCAL nGrupo		:= TRES
LOCAL nSubGrupo	:= QUATRO
LOCAL nFornecedor := CINCO
LOCAL nGeral		:= SEIS
LOCAL lSair 		:= FALSO
LOCAL nAnterior	:= 0
LOCAL nAtual		:= 0
LOCAL cQual
LOCAL cOpcao

WHILE OK
	Area("Lista")
	IF VendaCusto = nFornecedor
		Lista->(Order( LISTA_CODI ))
		cCodiFor := Space(QUATRO)
		MaBox( 15, 11, 17, 62 )
		@ 16, 12 Say "Fornecedor ¯¯ " Get cCodiFor Pict "9999" Valid Pagarrado( @cCodiFor, 16, 22 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		IF !( DbSeek(cCodiFor))
			ErrorBeep()
			Alerta("Erro: Nenhum Produto Registrado com este Fornecedor.")
			Loop
		EndIF

	ElseIF VendaCusto = nItem
		Lista->(Order( LISTA_CODIGO ))
		MaBox( 15, 11, 17, 30 )
		cCodiIni := 0
		@ 16, 12 Say "Codigo...:" Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF

	ElseIF VendaCusto = nParcial
		Lista->(Order( LISTA_CODIGO ))
		MaBox( 15, 11, 18, 37 )
		cCodiIni := 0
		cCodiFim := 0
		@ 16, 12 Say "Codigo Inicial..:" Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni )
		@ 17, 12 Say "Codigo Final....:" Get cCodiFim Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiFim )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		DbSeek( cCodiIni )

	ElseIF VendaCusto = nGrupo
		Lista->(Order( LISTA_CODGRUPO ))
		MaBox( 15, 11, 18, 31 )
		cGrupoIni := Space(TRES)
		cGrupoFim := Space(TRES)
		@ 16, 12 Say "Grupo Inicial ¯" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
		@ 17, 12 Say "Grupo Final   ¯" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		DbSeek( cGrupoIni )

	ElseIF VendaCusto = nSubGrupo
		Lista->(Order( LISTA_SUBGRUPO ))
		MaBox( 15, 11, 18, 37 )
		cSubIni := Space(SEIS)
		cSubFim := Space(SEIS)
		@ 16, 12 Say "SubGrupo Inicial ¯" Get cSubIni Pict "999.99" Valid CodiSubGrupo( @cSubIni )
		@ 17, 12 Say "SubGrupo Final   ¯" Get cSubFim Pict "999.99" Valid CodiSubGrupo( @cSubFim )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		DbSeek( cSubIni )

	ElseIF VendaCusto = nGeral
		IF lSair
			ResTela( cScreen )
			Exit
		EndIF
		Lista->(Order( LISTA_CODIGO ))
		DbGoTop()
	EndIF
	oMenu:Limpa()
	MaBox( 05, 09, 18, 70, "REAJUSTE DE PRECOS")
	AntProx()
	WHILE OK
		Area("Lista")
		Lista->(Order( LISTA_DESCRICAO ))
		MaBox( 21, 04, 23, 73, "OPCOES")
		AtPrompt( 22, 05, "Reajustar" )
		AtPrompt( 22, 16, "Deletar  " )
		AtPrompt( 22, 27, "Proximo  " )
		AtPrompt( 22, 38, "Anterior " )
		AtPrompt( 22, 49, "Localizar" )
		AtPrompt( 22, 60, "Retornar " )
		Menu To Opcao
		Lista->(Order( LISTA_CODIGO ))
		Do Case
		Case Opcao = 6 .OR. Opcao = 0
			lSair := OK
			ResTela( cScreen )
			Exit

		Case opcao = 2
			ErrorBeep()
			IF Conf( "Confirma Exclusao do Registro ?" )
				IF Lista->(TravaReg())
					DbDelete()
					Lista->(Libera())
					ErrorBeep()
					Alerta( "Registro Excluido...")
					Lista->(DbSkip())
					AntProx()
				EndIF
			EndIF

		Case Opcao = 3
			IF Lista->(Eof())
				MaBox( 21, 04, 23, 73, "OPCOES")
				Write( 22, 10, "Fim de Arquivo...")
				ErrorBeep()
				Opcao := 4
				Loop
			EndIF
			Lista->(DbSkip())
			AntProx()

		Case opcao = 4
			IF Lista->(Bof())
				MaBox( 21, 04, 23, 73, "OPCOES")
				Write( 22, 10, "Inicio de Arquivo...")
				ErrorBeep()
				Opcao = 3
				Loop
			EndIF
			Lista->(DbSkip(-1))
			AntProx()

		Case Opcao = 5
			Lista->(Order( LISTA_CODIGO ))
			DbClearFilter()
			DbGoTop()
			Procura()

		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nItem
			cOpcao := PorcNormal()
			IF cOpcao = "N"
				MaBox( 21, 04, 23, 73, "MENSAGEM")
				nPorc := 0
				@ 22, 10 Say  "Novo Preco ¯¯" Get nPorc Pict "@E 99,999,999.99"
				Read
				ErrorBeep()
				IF Conf( "Confirma Novo Preco ?" )
					IF Lista->(TravaReg())
						Lista->Pcusto := nPorc
						Lista->Data   := Date()
						Lista->(Libera())
						AntProx()
					EndIF
				EndIF

			ElseIF cOpcao = "P"
				IF ((nPorc := Porcentagem())) != 0
					IF Lista->(TravaReg())
						ErrorBeep()
						IF Conf( "Arredondar Valor ? ")
							Lista->Pcusto := Lista->(Round( Pcusto * ( nPorc/100 ) + Pcusto, 0 ))
						Else
							Lista->Pcusto := Lista->Pcusto * ( nPorc/100 ) + Lista->Pcusto
						EndIF
						Lista->Data   := Date()
						Lista->(Libera())
						AntProx()
					EndIF
				EndIF
			EndIF

		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nParcial
			IF ((nPorc := Porcentagem())) != 0
				IF Conf( "Confirma Reajuste ?" )
					lArredondar := Conf( "Arredondar Valor ? ")
					IF Lista->(TravaArq())
						Iniciando()
						Reg  := Recno()
						Lista->(Order( LISTA_CODIGO ))
						oBloco := {|| Codigo >= cCodiIni .AND. Codigo <= cCodiFim }
						IF DbSeek( cCodiIni )
							While EVal( oBloco ) .AND. Rep_Ok()
								IF lArredondar
									_Field->Pcusto := Round( Pcusto * ( nPorc / 100 ) + Pcusto, 0 )
								Else
									_Field->Pcusto := Pcusto * ( nPorc / 100 ) + Pcusto
								EndIF
								Lista->Data   := Date()
								DbSkip()
							EndDo
							DbGoto( Reg )
							AntProx()
						EndIF
						Lista->(Libera())
					EndIF
				EndIF
			EndIF
		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nGeral
			IF ((nPorc := Porcentagem())) != 0
				IF Conf( "Confirma Reajuste ?" )
					lArredondar := Conf( "Arredondar Valor ? ")
					IF Lista->(TravaArq())
						Iniciando()
						Reg  := Recno()
						Lista->(Order( LISTA_CODIGO ))
						oBloco := {|| !Eof() }
						DbGoTop()
						While EVal( oBloco ) .AND. Rep_Ok()
							IF lArredondar
								_Field->Pcusto := Round( Pcusto * ( nPorc / 100 ) + Pcusto, 0 )
							Else
								_Field->Pcusto := Pcusto * ( nPorc / 100 ) + Pcusto
							EndIF
							Lista->Data   := Date()
							DbSkip()
						EndDo
						Lista->(Libera())
						DbGoto( Reg )
						AntProx()
					EndIF
				EndIF
			EndIF
		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nFornecedor
			IF ((nPorc := Porcentagem())) != 0
				ErrorBeep()
				IF Conf( "Confirma Reajuste ?" )
					lArredondar := Conf( "Arredondar Valor ? ")
					IF lista->(TravaArq())
						Iniciando()
						Reg := Recno()
						Lista->(Order( LISTA_CODI ))
						oBloco := {|| Lista->Codi = cCodiFor }
						IF DbSeek( cCodiFor )
							While EVal( oBloco ) .AND. Rep_Ok()
								IF lArredondar
									_Field->Pcusto := Round( Pcusto * ( nPorc / 100 ) + Pcusto, 0 )
								Else
									_Field->Pcusto := Pcusto * ( nPorc / 100 ) + Pcusto
								EndIF
								Lista->Data   := Date()
								DbSkip()
							EndDo
							DbGoto( Reg )
							AntProx()
						EndIF
						Lista->(Libera())
					EndIF
				EndIF
			EndIF
		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nGrupo
			IF ((nPorc := Porcentagem())) != 0
				ErrorBeep()
				IF Conf( "Confirma Reajuste ?" )
					lArredondar := Conf( "Arredondar Valor ? ")
					IF Lista->(TravaArq())
						Iniciando()
						Reg := Recno()
						Lista->(Order( LISTA_CODGRUPO ))
						oBloco := {|| CodGrupo >= cGrupoIni .AND. CodGrupo <= cGrupoFim }
						IF DbSeek( cGrupoIni )
							While EVal( oBloco ) .AND. Rep_Ok()
								IF lArredondar
									_Field->Pcusto := Round( Pcusto * ( nPorc / 100 ) + Pcusto, 0 )
								Else
									_Field->Pcusto := Pcusto * ( nPorc / 100 ) + Pcusto
								EndIF
								Lista->Data   := Date()
								DbSkip()
							EndDo
							DbGoto( Reg )
							AntProx()
						EndIF
						Lista->(Libera())
					EndIF
				EndIF
			EndIF
		Case Opcao = 1 .AND. PCUSTO .AND. VendaCusto = nSubGrupo
			IF ((nPorc := Porcentagem())) != 0
		 ErrorBeep()
		 IF Conf( "Confirma Reajuste ?" )
			 lArredondar := Conf( "Arredondar Valor ? ")
					IF Lista->(TravaArq())
						Iniciando()
						Reg := Recno()
						Lista->(Order( LISTA_SUBGRUPO ))
						oBloco := {|| CodsGrupo >= cSubIni .AND. CodsGrupo <= cSubFim }
						IF DbSeek( cSubIni )
							While EVal( oBloco ) .AND. Rep_Ok()
								IF lArredondar
									_Field->Pcusto := Round( Pcusto * ( nPorc / 100 ) + Pcusto, 0 )
								Else
									_Field->Pcusto := Pcusto * ( nPorc / 100 ) + Pcusto
								EndIF
								Lista->Data   := Date()
								DbSkip()
							EndDo
							DbGoto( Reg )
							AntProx()
						EndIF
						Lista->(Libera())
					EndIF
				EndIF
			EndIF
// ----------------------------------------------------------------//
//   REAJUSTE PRECO VENDA
// ----------------------------------------------------------------//
		Case Opcao = 1 .AND. PVENDA .AND. VendaCusto = nItem
			 cOpcao := PorcNormal()
			 IF cOpcao = "N"
				 nPorc := 0
				 cQual := TipoPreco()
				 MaBox( 21, 04, 23, 73, "MENSAGEM")
				 @ 22, 10 Say	"Digite Novo Preco ¯¯" Get nPorc Pict "@E 99,999,999.99"
				 Read
				 ErrorBeep()
				 IF Conf( "Confirma Novo Preco ?" )
					 IF Lista->(TravaReg())
						 IF cQual	  = "A"     // Atacado
							 _Field->Atacado := nPorc
						 ElseIf cQual = "V" // Varejo
							 _Field->Varejo := nPorc
						 ElseIf cQual = "T" // Varejo
							 _Field->Varejo  := nPorc
							 _Field->Atacado := nPorc
						 EndIF
						 Lista->Data	:= Date()
						 Lista->(Libera())
						 AntProx()
					 EndIF
				 EndIF
			 ElseIF cOpcao = "P"
				 cQual := TipoPreco()
				 IF ((nPorc := Porcentagem())) != 0
					 IF Conf( "Confirma Reajuste ?" )
						 lArredondar := Conf( "Arredondar Valor ? ")
						 IF Lista->(TravaReg())
							 IF cQual= "A"   // Atacado
								 IF lArredondar
									  _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
								 Else
									  _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
								 EndIF
							 ElseIf cQual = "V" // Varejo
								 IF lArredondar
									 _Field->Varejo := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
								 Else
									 _Field->Varejo := ReajCentavo( _Field->Varejo, nPorc )
								 EndIF
							 Else
								 IF lArredondar
									 _Field->Atacado	:= Round( Atacado  * ( nPorc / 100 ) + Atacado, 0 )
									 _Field->Varejo	:= Round( Varejo	 * ( nPorc / 100 ) + Varejo, 0 )
								 Else
									 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
								 EndIF
							 EndIF
							 Lista->Data	:= Date()
							 Lista->(Libera())
						 EndIF
						 AntProx()
					 EndIF
				 EndIF
			 EndIF
		 Case Opcao = 1 .AND. PVENDA .AND. VendaCusto = nGeral .OR. VendaCusto = nFornecedor
			 cQual := TipoPreco()
			 IF ((nPorc := Porcentagem())) != 0
				 ErrorBeep()
				 IF Conf( "Confirma Reajuste ?" )
					 lArredondar := Conf( "Arredondar Valor ? ")
					 IF Lista->(TravaArq())
						 Iniciando()
						 Reg	:= Recno()
						 DbGoTop()
						 IF VendaCusto = nGeral
							 Lista->(Order( LISTA_CODIGO ))
							 oBloco := {|| !Eof() }
							 DbGoTop()
							 While EVal( oBloco ) .AND. Rep_Ok()
								 IF lArredondar
									 IF cQual	  = "A"   // Atacado
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
									 ElseIf cQual = "V"
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 ElseIf cQual = "T"
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 EndIF
									 Lista->Data	:= Date()
								 Else
									 IF cQual	  = "A"   // Atacado
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 ElseIf cQual = "V"
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
									 ElseIf cQual = "T"
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
									 EndIF
									 Lista->Data	:= Date()
								 EndIF
								 DbSkip()
							 EndDo
							 AntProx()
						 ElseIF VendaCusto = nFornecedor
							 Lista->(Order( LISTA_CODI ))
							 oBloco := {|| Lista->Codi = cCodiFor }
							 IF DbSeek( cCodiFor )
								 While EVal( oBloco ) .AND. Rep_Ok()
									 IF lArredondar
										 IF cQual	  = "A"   // Atacado
											 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
										 ElseIf cQual = "V"
											 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
										 ElseIf cQual = "T"
											 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
											 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
										 EndIF
										 Lista->Data	:= Date()
									 Else
										 IF cQual	  = "A"   // Atacado
											 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
										 ElseIf cQual = "V"
											 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
										 ElseIf cQual = "T"
											 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
											 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
										 EndIF
										 Lista->Data	:= Date()
									 EndIF
									 DbSkip()
								 EndDo
								 AntProx()
							 EndIF
						 EndIF
						 DbGoto( Reg )
						 AntProx()
						 Lista->(Libera())
					 EndIF
				EndIF
			EndIF
		 Case Opcao = 1 .AND. PVENDA .AND. VendaCusto = nParcial
			 cQual := TipoPreco()
			 IF ((nPorc := Porcentagem())) != 0
				 ErrorBeep()
				 IF Conf( "Confirma Reajuste ?" )
					 lArredondar := Conf( "Arredondar Valor ? ")
					 IF Lista->(TravaArq())
						 Iniciando()
						 Reg	:= Recno()
						 Lista->(Order( LISTA_CODIGO ))
						 oBloco := {|| Codigo >= cCodiIni .AND. Codigo <= cCodiFim }
						 IF DbSeek( cCodiIni )
							 While EVal( oBloco ) .AND. Rep_Ok()
								 IF lArredondar
									 IF cQual	  = "A"   // Atacado
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
									 ElseIf cQual = "V"
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 ElseIf cQual = "T"
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 EndIF
									 Lista->Data	:= Date()
								 Else
									 IF cQual	  = "A"   // Atacado
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 ElseIf cQual = "V"
										 _Field->Varejo := ReajCentavo( _Field->Varejo, nPorc )
									 ElseIf cQual = "T"
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									EndIF
									Lista->Data   := Date()
								EndIF
								DbSkip()
							EndDo
							AntProx()
						EndIF
						DbGoto( Reg )
						AntProx()
						Lista->(libera())
					EndIF
				EndIF
			EndIF
		 Case Opcao = 1 .AND. PVENDA .AND. VendaCusto = nGrupo
			 cQual := TipoPreco()
			 IF ((nPorc := Porcentagem())) != 0
				 ErrorBeep()
				 IF Conf( "Confirma Reajuste ?" )
					 lArredondar := Conf( "Arredondar Valor ? ")
					 IF Lista->(TravaArq())
						 Iniciando()
						 Reg	 := Recno()
						 Lista->(Order( LISTA_CODGRUPO ))
						 oBloco := {|| CodGrupo >= cGrupoIni .AND. CodGrupo <= cGrupoFim }
						 IF DbSeek( cGrupoIni )
							 While EVal( oBloco ) .AND. Rep_Ok()
								 IF lArredondar
									 IF cQual	 = "A"   // Atacado
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
									 ElseIf cQual = "V"
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 ElseIf cQual = "T"
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 EndIF
									 Lista->Data	:= Date()
								 Else
									 IF cQual	 = "A"   // Atacado
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 ElseIf cQual = "V"
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
									 ElseIf cQual = "T"
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 EndIF
									 Lista->Data	:= Date()
								 EndIF
								 DbSkip()
							 EndDo
							 AntProx()
						 EndIF
						 DbGoto( Reg )
						 AntProx()
						 Lista->(Libera())
					 EndIF
				 EndIF
			 EndIF
		 Case Opcao = 1 .AND. PVENDA .AND. VendaCusto = nSubGrupo
			 cQual := TipoPreco()
			 IF ((nPorc := Porcentagem())) != 0
				 ErrorBeep()
				 IF Conf( "Confirma Reajuste ?" )
					 lArredondar := Conf( "Arredondar Valor ? ")
					 IF Lista->(TravaArq())
						 Iniciando()
						 Reg	 := Recno()
						 Lista->(Order( LISTA_SUBGRUPO ))
						 oBloco := {|| CodsGrupo >= cSubIni .AND. CodsGrupo <= cSubFim }
						 IF DbSeek( cSubIni )
							 While EVal( oBloco ) .AND. Rep_Ok()
								 IF lArredondar
									 IF cQual	 = "A"   // Atacado
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
									 ElseIf cQual = "V"
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 ElseIf cQual = "T"
										 _Field->Atacado := Round( Atacado * ( nPorc / 100 ) + Atacado, 0 )
										 _Field->Varejo  := Round( Varejo * ( nPorc / 100 ) + Varejo, 0 )
									 EndIF
									 Lista->Data	:= Date()
								 Else
									 IF cQual	 = "A"   // Atacado
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
									 ElseIf cQual = "V"
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
									 ElseIf cQual = "T"
										 _Field->Atacado := ReajCentavo( _Field->Atacado, nPorc )
										 _Field->Varejo  := ReajCentavo( _Field->Varejo, nPorc )
									 EndIF
									 Lista->Data	:= Date()
								 EndIF
								 DbSkip()
							 EndDo
							 AntProx()
						 EndIF
						 DbGoto( Reg )
						 AntProx()
						 Lista->(Libera())
					EndIF
				EndIF
			EndIF
		EndCase
	EndDo
EndDo

Function ReajCentavo( nPreco, nPorc )
*************************************
LOCAL nAtual := nPreco
LOCAL nTemp  := nPreco * ( nPorc / 100 ) + nPreco
LOCAL cTemp  := ""

cTemp := Str( nTemp, 12, 3 )
IF Right( cTemp, 1 ) <> '0'
	nTemp := Val( Str( nTemp, 12, 3 ))
	nTemp += 0.01
EndIF
Return( nTemp )

Function Porcentagem()
**********************
LOCAL GetList := {}
LOCAL nTaxa   := 0

MaBox( 21, 04, 23, 73, "MENSAGEM")
WHILE OK
	@ 22, 10 Say  "Porcentagem a Reajustar ¯¯ " Get nTaxa Pict "999.99"
	Read
	IF LastKey() = ESC
		Return(0)
	EndIF
	IF Conf(" Confirma a Porcentagem a Reajustar ?")
		Return( nTaxa )
	EndIF
Enddo

Proc Iniciando()
****************
MaBox( 21, 04, 23, 73, "MENSAGEM")
Write( 22, 30, "Aguarde... Reajustando. ESC Cancela.")
Return

Function PorcNormal()
*********************
LOCAL GetList := {}
LOCAL cOpcao  := "P"

MaBox( 21, 04, 23, 73, "MENSAGEM")
@ 22, 10 Say  "Porcentagem ou Normal ¯¯" Get cOpcao Pict "!" Valid cOpcao $ "PN"
Read
IF LastKey() = ESC
	Return("")
EndIF
Return( cOpcao )

Function TipoPreco()
********************
lOCAL GetList := {}
LOCAL cTipo   := "T"
MaBox( 21, 04, 23, 73, "MENSAGEM")
@ 22, 10 Say  "(A)tacado (V)arejo (T)odos ¯¯ " Get cTipo Pict "!"
Read
IF LastKey() = ESC
	Return(" ")
EndIF
Return( cTipo )

Proc Procura()
**************
LOCAL Procura := SaveScreen()
LOCAL Cod

Area("Lista")
Lista->(Order( LISTA_CODIGO ))
MaBox( 00, 20, 02, 37 )
Cod := 0
@ 01, 21 Say "Codigo ..:" Get Cod Pict PIC_LISTA_CODIGO Valid CodiErrado( @Cod )
Read
ResTela( Procura )
AntProx()

Proc Lista21()
**************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL aMenuArray := {" Por Codigo "," Por Documento ", " Por Periodo "," Por Fornecedor ", " Geral " }
LOCAL nChoice
LOCAL cDeleteFile
LOCAL cTela
LOCAL aStru

WHILE OK
	oMenu:Limpa()
	M_Title( "CONSULTA ENTRADAS DE PRODUTOS" )
	nChoice := FazMenu( 04, 05, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		 cScreen1 := SaveScreen()
		 WHILE OK
			 Area("Entradas")
			 Entradas->(Order( ENTRADAS_CODIGO ))
			 xCodigo = 0
			 MaBox( 13, 05, 15, 28 )
			 @ 14, 06 Say "Codigo..:" Get xCodigo Pict PIC_LISTA_CODIGO Valid EntraMov( @xCodigo )
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Entradas")
			 Entradas->(Order( ENTRADAS_CODIGO ))
			 IF Entradas->(!DbSeek( xCodigo ))
				 Nada()
				 ResTela( cScreen )
				 Loop
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Entradas->Codigo = xCodigo }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Entradas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Entradas")
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 xTemp->( DbAppend())
				 For nField := 1 To nCampos
					 xTemp->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				 Next
				 Entradas->(DbSkip(1))
			 Enddo
			 Pagar->(Order( PAGAR_CODI ))
			 Lista->(Order( LISTA_CODIGO ))
			 Select xTemp
			 Set Rela To xTemp->Codigo Into Lista, xTemp->Codi Into Pagar
			 DbGoTop()
			 ResTela( cTela )
			 EntradaDbedit()
			 DbClearRel()
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
		 EndDo

	 Case nChoice = 2
		 cScreen1 := SaveScreen()
		 WHILE OK
			 Area("Entradas")
			 DbClearFilter( )
			 DbGoTop()
			 Entradas->(Order( ENTRADAS_FATURA ))
			 MaBox( 13, 05, 15, 32 )
			 cDocnr = Space(09)
			 @ 14, 06 Say "Documento N§..: " Get cDocnr Pict "@!" Valid VisualEntraFatura( @cDocnr )
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 IF Entradas->(!DbSeek( cDocnr ))
				 Alerta("Erro: Documento Nao Encontrado...")
				 ResTela( cScreen1 )
				 Loop
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Entradas->Fatura = cDocnr }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Entradas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Entradas")
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 xTemp->( DbAppend())
				 For nField := 1 To nCampos
					 xTemp->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				 Next
				 Entradas->(DbSkip(1))
			 Enddo
			 Pagar->(Order( PAGAR_CODI ))
			 Lista->(Order( LISTA_CODIGO ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Pagar
			 DbGoTop()
			 ResTela( cTela )
			 EntradaDbedit( nChoice )
			 DbClearRel()
			 xTemp->( DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
		 EndDo

	 Case nChoice = 3
		 cScreen1 := SaveScreen()
		 WHILE OK
			 Area("Entradas")
			 DbClearFilter( )
			 DbGoTop()
			 Entradas->(Order( ENTRADAS_DATA ))
			 dIni := Date()
			 dFim := Date()+30
			 MaBox( 13, 05, 16, 31 )
			 @ 14, 06 Say "Emis Inicial..:" Get dIni Pict PIC_DATA
			 @ 15, 06 Say "Emis Final....:" Get dFim Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Entradas->Data >= dIni .AND. Entradas->Data <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Entradas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Entradas")
			 Set Soft On
			 DbSeek( dIni )
			 Set Soft Off
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 xTemp->( DbAppend())
				 For nField := 1 To nCampos
					 xTemp->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				 Next
				 Entradas->(DbSkip(1))
			 Enddo
			 Pagar->(Order( PAGAR_CODI ))
			 Lista->(Order( LISTA_CODIGO ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Pagar
			 DbGoTop()
			 ResTela( cTela )
			 EntradaDbedit( nChoice )
			 DbClearRel()
			 xTemp->( DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
		 EndDo

	 Case nChoice = 4
		cScreen1 := SaveScreen()
		WHILE OK
			dIni	  := Date() - 30
			dFim	  := Date()
			cCodi   := Space(04)
			MaBox( 13, 05, 17, 78, "ENTRE COM O PERIODO")
			@ 14, 06 Say "Fornecedor......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
			@ 15, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
			@ 16, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Area("Entradas")
			Entradas->(Order( ENTRADAS_CODI))
			cDeleteFile := FTempName()
			aStru 		:= Entradas->(DbStruct())
			DbCreate( cDeleteFile, aStru )
			Use (cDeleteFile) Alias xTemp Exclusive New
			cTela  := Mensagem("Aguarde, Verificando. ESC Cancela.")
			IF Entradas->(!DbSeek( cCodi ))
				Nada()
				xTemp->(DbCloseArea())
				Ferase( cDeleteFile )
				Loop
			EndIF
			WHILE Entradas->Codi = cCodi
				IF Entradas->Data >= dIni .AND. Entradas->Data <= dFim
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->( FieldPut( nField, Entradas->(FieldGet( nField ))))
					Next
				EndIF
				Entradas->(DbSkip(1))
			EndDo
			Pagar->(Order( PAGAR_CODI ))
			Lista->(Order( LISTA_CODIGO ))
			xTemp->(DbGoTop())
			Set Rela To xTemp->Codigo Into Lista, xTemp->Codi Into Pagar
			ResTela( cTela )
			EntradaDbedit( nChoice )
			xTemp->(DbClearFilter())
			xTemp->(DbGoTop())
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			ResTela( cScreen1 )
			Loop
		EndDo

	 Case nChoice = 5
		 Pagar->(Order( PAGAR_CODI ))
		 Lista->(Order( LISTA_CODIGO ))
		 Area("Entradas")
		 Set Rela To Entradas->Codigo Into Lista, Entradas->Codi Into Pagar
		 Entradas->(DbGoTop())
		 Entradas->(Order( ENTRADAS_CODIGO ))
		 EntradaDbEdit( nChoice )
		 Entradas->(DbClearRel())
		 Entradas->(DbGoTop())
	EndCase
EndDo

Proc Lista22()
**************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Por Produto","Por Cliente", "Por Cliente/Produto", "Por Documento","Por Fabricante","Por Periodo","Por Forma Pgto", 'Por Vendedor',"Todas Saidas" }
LOCAL cCodi 	  := Space( 04 )
LOCAL cForma	  := Space(02)
LOCAL cCodiVen   := Space(04)
LOCAL aStru
LOCAL cScreen1
LOCAL nChoice
LOCAL cDeleteFile
LOCAL cTela
LOCAL oBloco
LOCAL dBloco
LOCAL cBloco

xArquivo := TempNew()
WHILE OK
	 oMenu:Limpa()
	 M_Title( "CONSULTA SAIDAS DE PRODUTOS" )
	 nChoice := FazMenu( 00, 05, aMenuArray, Cor())
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		 cScreen1 := SaveScreen()
		 WHILE OK
			 xCodigo := 0
			 dIni 	:= Date()-30
			 dFim 	:= Date()
			 MaBox( 13, 05, 17, 30 )
			 @ 14, 06 Say "Codigo.......:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiMov( @xCodigo )
			 @ 15, 06 Say "Data Inicial.:" Get dIni Pict PIC_DATA
			 @ 16, 06 Say "Data Final...:" Get dFim Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_CODIGO ))
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 IF Saidas->(!DbSeek( xCodigo ))
				 Nada()
				 Loop
			 EndIF
			 bBloco		 := {|| Saidas->Codigo = xCodigo }
			 dBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 IF Eval( dBloco )
					xTemp->( DbAppend())
					For nField := 1 To FCount()
						xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
					Next
				 EndIF
				 Saidas->(DbSkip(1))
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Area("xTemp")
			 Set Rela To xTemp->Codigo Into Lista, xTemp->Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->( DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo


	 Case nChoice = 2
		 cScreen1 := SaveScreen()
		 WHILE OK
			 dIni 	:= Date()-30
			 dFim 	:= Date()
			 cCodi	:= Space(05)
			 MaBox( 13, 05, 17, 70 )
			 @ 14, 06 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
			 @ 15, 06 Say "Data Inicial....: " Get dIni  Pict PIC_DATA
			 @ 16, 06 Say "Data Final......: " Get dFim  Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_CODI ))
			 cTela := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 IF Saidas->(!DbSeek( cCodi ))
				 Nada()
				 Loop
			 EndIF
			 bBloco		 := {|| Saidas->Codi = cCodi }
			 dBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 IF Eval( dBloco )
					 xTemp->( DbAppend())
					 For nField := 1 To FCount()
						 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
					 Next
				 EndIF
				 Saidas->(DbSkip(1))
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 3
		 cScreen1 := SaveScreen()
		 WHILE OK
			 dIni 	:= Date()-30
			 dFim 	:= Date()
			 xCodigo := 0
			 cCodi	:= Space(05)
			 MaBox( 13, 05, 18, 70 )
			 @ 14, 06 Say "Codigo Cliente..: " Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
			 @ 15, 06 Say "Codigo..........: " Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigo )
			 @ 16, 06 Say "Data Inicial....: " Get dIni    Pict PIC_DATA
			 @ 17, 06 Say "Data Final......: " Get dFim    Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_CODI ))
			 cTela := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 IF Saidas->(!DbSeek( cCodi ))
				 Nada()
				 Loop
			 EndIF
			 bBloco		 := {|| Saidas->Codi = cCodi }
			 dBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
			 cBloco		 := {|| Saidas->Codigo = xCodigo }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 IF Eval( dBloco )
					 IF Eval( cBloco )
						 xTemp->( DbAppend())
						 For nField := 1 To FCount()
							 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
						 Next
					 EndIF
				 EndIF
				 Saidas->(DbSkip(1))
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->( DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 4
		 cScreen1 := SaveScreen()
		 WHILE OK
			 MaBox( 13, 05, 15, 30 )
			 cDocnr = Space( 07 )
			 @ 14, 06 Say "Fatura N§....Ä¯" Get cDocnr Pict "@!" Valid VisualAchaFatura( @cDocnr )
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Saidas->Fatura = cDocnr }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_FATURA ))
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 xTemp->( DbAppend())
				 For nField := 1 To FCount()
					 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
				 Next
				 Saidas->(DbSkip(1))
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 5
		cScreen1 := SaveScreen()
		WHILE OK
			dIni	  := Date()-30
			dFim	  := Date()
			cCodi   := Space(04)
			MaBox( 13, 05, 17, 78, "ENTRE COM O PERIODO")
			@ 14, 06 Say "Fabricante......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
			@ 15, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
			@ 16, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			cTela := Mensagem("Aguarde, Verificando. ESC Cancela.")
			Area("Saidas")
			Saidas->(Order( SAIDAS_CODIGO ))
			xArquivo := TempNew()
			aStru := Saidas->(DbStruct())
			DbCreate( xArquivo, aStru )
			Use (xArquivo) Exclusive Alias xTemp New
			Lista->(Order( LISTA_CODI ))
			oBloco := {|| Lista->Codi = cCodi }
			IF Lista->(!DbSeek( cCodi ))
				Nada()
				xTemp->(DbCloseArea())
				Ferase( xArquivo )
				Loop
			EndIF
			WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
				cCodigo := Lista->Codigo
				IF Saidas->(DbSeek( cCodigo ))
					WHILE Saidas->Codigo = cCodigo
						IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
							xTemp->(DbAppend())
							For nField := 1 To FCount()
								xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
							Next
						EndIF
						Saidas->(DbSkip(1))
					EndDo
				EndIF
				Lista->(DbSkip(1))
			EndDo
			xTemp->(DbGoTop())
			Lista->(Order( LISTA_CODIGO ))
			Receber->(Order( RECEBER_CODI ))
			Set Rela To Codigo Into Lista, Codi Into Receber
			ResTela( cTela )
			SaidaDbedit( OK, cDeleteFile )
			xTemp->(DbClearFilter())
			xTemp->(DbGoTop())
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			ResTela( cScreen1 )
			Loop
		EndDo

	 Case nChoice = 6
		 cScreen1 := SaveScreen()
		 WHILE OK
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_EMIS ))
			 MaBox( 13, 05, 16, 31 )
			 dIni := Date()-30
			 dFim := Date()
			 @ 14, 06 Say "Emis Inicial..:" Get dIni Pict PIC_DATA
			 @ 15, 06 Say "Emis Final....:" Get dFim Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Emis >= dIni .AND. Emis <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 Set Soft On
			 DbSeek( dIni )
			 Set Soft Off
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 xTemp->( DbAppend())
				 For nField := 1 To FCount()
					 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
				 Next
				 Saidas->(DbSkip())
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 7
		 cScreen1 := SaveScreen()
		 WHILE OK
			 dIni   := Date()-30
			 dFim   := Date()
			 cForma := Space(02)
			 MaBox( 13, 05, 17, 31 )
			 @ 14, 06 Say "Forma Pgto....:" Get cForma Pict "##" Valid FormaErrada( @cForma )
			 @ 15, 06 Say "Emis Inicial..:" Get dIni Pict PIC_DATA
			 @ 16, 06 Say "Emis Final....:" Get dFim Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_FORMA ))
			 IF Saidas->(!DbSeek( cForma ))
				 Nada()
				 Loop
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Saidas->Forma = cForma }
			 dBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 Saidas->(DbSeek( cForma ))
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 IF Eval( dBloco )
					 xTemp->( DbAppend())
					 For nField := 1 To FCount()
						 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
					 Next
				 EndIF
				 Saidas->(DbSkip())
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 8
		 cScreen1 := SaveScreen()
		 WHILE OK
			 dIni 	 := Date()-30
			 dFim 	 := Date()
			 cCodiVen := Space(04)
			 MaBox( 13, 05, 17, 70 )
			 @ 14, 06 Say "Vendedor......:" Get cCodiVen  Pict "9999" Valid FunErrado( @cCodiVen, NIL, Row(), Col()+1 )
			 @ 15, 06 Say "Emis Inicial..:" Get dIni Pict PIC_DATA
			 @ 16, 06 Say "Emis Final....:" Get dFim Pict PIC_DATA
			 Read
			 IF LastKey() = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 Area("Saidas")
			 Saidas->(Order( SAIDAS_CODIVEN ))
			 IF Saidas->(!DbSeek( cCodiVen ))
				 Nada()
				 Loop
			 EndIF
			 cTela		 := Mensagem("Aguarde, Verificando. ESC Cancela.")
			 bBloco		 := {|| Saidas->CodiVen = cCodiVen }
			 dBloco		 := {|| Saidas->Emis >= dIni .AND. Saidas->Emis <= dFim }
			 nCampos 	 := FCount()
			 cDeleteFile := FTempName()
			 aStru		 := Saidas->(DbStruct())
			 DbCreate( cDeleteFile, aStru )
			 Use (cDeleteFile) Alias xTemp Exclusive New
			 Area("Saidas")
			 Saidas->(DbSeek( cCodiVen ))
			 WHILE Eval( bBloco ) .AND. Rep_Ok()
				 IF Eval( dBloco )
					 xTemp->( DbAppend())
					 For nField := 1 To FCount()
						 xTemp->( FieldPut( nField, Saidas->(FieldGet( nField ))))
					 Next
				 EndIF
				 Saidas->(DbSkip())
			 Enddo
			 Lista->(Order( LISTA_CODIGO ))
			 Receber->(Order( RECEBER_CODI ))
			 Select xTemp
			 Set Rela To Codigo Into Lista, Codi Into Receber
			 xTemp->(DbGoTop())
			 ResTela( cTela )
			 SaidaDbedit( OK, cDeleteFile )
			 xTemp->(DbClearRel())
			 xTemp->(DbGoTop())
			 xTemp->(DbCloseArea())
			 Ferase( cDeleteFile )
			 ResTela( cScreen1 )
			 Loop
		 EndDo

	 Case nChoice = 9
		 Lista->(Order( LISTA_CODIGO ))
		 Receber->(Order( RECEBER_CODI ))
		 Area("Saidas")
		 Set Rela To Codigo Into Lista, Codi Into Receber
		 Saidas->(Order( SAIDAS_FATURA ))
		 Saidas->(DbGoTop())
		 SaidaDbedit( FALSO )
		 Saidas->(DbClearRel())
		 Saidas->(DbGoTop())

	EndCase
EndDo

Proc EntradaDbEdit( nEscolha )
******************************
LOCAL cScreen := SaveScreen()
LOCAL Tb, nKey, Coluna, nAtraso
LOCAL nTotCusto	:= 0
LOCAL nTotVenda	:= 0
LOCAL nTotCompra	:= 0
LOCAL nEntrada 	:= 0
LOCAL cFrame2		:= SubStr( oMenu:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oMenu:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oMenu:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oMenu:Frame, 6, 1 )
LOCAL aMenu 		:= {"Nenhuma", "Codigo", "Data", "Documento"}
LOCAL xNtx
LOCAL cTela

xNtx	:= TempNew()
cTela := Mensagem("Aguarde, Somando.")
SetCursor( 0 )
WHILE !Eof()
	nEntrada 	+= Entrada
	nTotCompra	+= Pcusto * Entrada
	nTotCusto	+= CustoFinal * Entrada
	nTotVenda	+= Lista->Varejo * Entrada
	DbSkip(1)
EndDo
ResTela( cTela )
IF nEscolha != 5
	M_Title("ESCOLHA A ORDEM")
	nChoice := FazMenu( 04, 49, aMenu, Cor())
	IF nChoice = 2
		Inde On xTemp->Codigo To (xNtx )
	ElseIF nChoice = 3
		Inde On xTemp->Data To (xNtx )
	ElseIF nChoice = 4
		Inde On xTemp->Fatura To (xNtx )
	EndIF
EndIF
DbGoTop()
MaBox( 00, 00, MaxRow(), MaxCol(), "CONSULTA DE ENTRADAS DE PRODUTOS" )
Tb 			 := TBROWSEDB( 01, 01, MaxRow()-1, MaxCol()-1 )
Tb:ColorSpec := "N/W, N/BG, B/W, B/BG, B/W, B/BG, R/W, W+/R"
Tb:HeadSep	 := cFrame2 + cFrame3 + cFrame2
Tb:ColSep	 := Chr(032) + cFrame4 + Chr(032)
Tb:FootSep	 := cFrame2  + cFrame2 + cFrame2
Print( 24, 00, "QTDE.:" + Tran( nEntrada, "999999.99") + "³TOTAL COMPRA:" + Tran( nTotCompra, "@E 999,999,999,999.99") + "³TOTAL CUSTO.:" + Tran( nTotCusto, "@E 999,999,999,999.99"), Cor(),80)

Tb:AddColumn(TBColumnNew( "CODIGO",               {|| Lista->Codigo } ))
Tb:AddColumn(TBColumnNew( "FORNECEDOR",           {|| Pagar->Nome } ))
Tb:AddColumn(TBColumnNew( "COD FABR.",            {|| Lista->N_Original } ))
Tb:AddColumn(TBColumnNew( "DESCRICAO DO PRODUTO", {|| Lista->descricao } ))
Tb:AddColumn(TBColumnNew( "UN",                   {|| Lista->Un } ) )
Tb:AddColumn(TBColumnNew( "DATA",                 {|| Data } ) )
Tb:AddColumn(TBColumnNew( "ENTRADA",              {|| Entrada } ))
Tb:AddColumn(TBColumnNew( "DOCTO N§",             {|| Fatura } ) )
Tb:AddColumn(TBColumnNew( "CFOP",                 {|| CFop } ) )
Tb:AddColumn(TBColumnNew( "CUSTO NFF",            {|| Tran( Pcusto, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "T. CUSTO",             {|| Tran( Pcusto*Entrada, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "CUSTO FINAL",          {|| Tran( CustoFinal, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "T. CUSTO FINAL",       {|| Tran( CustoFinal*Entrada, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "P.VENDA",              {|| Tran( Lista->Varejo, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "TOTAL VENDA",          {|| Tran( Lista->Varejo * Entrada, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "VALOR NFF",            {|| Tran( VlrNff, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "P. COMPRA",            {|| Tran( Lista->Pcompra, "@E 9,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "TOTAL P. COMPRA",      {|| Tran( Lista->Pcompra*Entrada, "@E 9,999,999,999.99") } ) )

Coluna:=Tb:GetColumn(7)   // ENTRADA
Coluna:DefColor := {7,8}
Coluna:=Tb:GetColumn(10)	// PCUSTO
Coluna:DefColor := { 7, 8 }
Coluna:=Tb:GetColumn(11)	// TOTAL
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(12)	// TOTAL
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(13)	// TOTAL
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(14)	// VALOR NFF
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(15)
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(16)
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(17)
Coluna:DefColor := {7, 8}
Coluna:=Tb:GetColumn(18)
Coluna:DefColor := {7, 8}
WHILE OK
  WHILE ( !Tb:stabilize() )
	  nKey = InKey()
	  IF nKey != 0
		  Exit
	  EndIF
  Enddo
  IF Tb:HitTop .OR. Tb:HitBottom
	  ErrorBeep()
  EndIF
  nKey := InKey( 0 )
  IF nKey = K_ESC
	  SetCursor(1)
	  ResTela( cScreen )
	  Exit
  EndIF
  TestaTecla( nKey, Tb )
END

Proc SaidaDbedit( lTemporario, cDeleteFile )
********************************************
LOCAL cScreen		:= SaveScreen()
LOCAL nTotalGeral := 0
LOCAL nTotalCusto := 0
LOCAL nSaida		:= 0
LOCAL nMargem		:= 0
LOCAL nComissao   := 0
LOCAL cFrame2		:= SubStr( oMenu:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oMenu:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oMenu:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oMenu:Frame, 6, 1 )
LOCAL aMenu 		:= {"Nenhuma", "Codigo", "Data", "Documento"}
LOCAL Tb
LOCAL nKey
LOCAL coluna
LOCAL nAtraso
LOCAL xNtx
LOCAL cTela

xNtx	:= TempNew()
cTela := Mensagem("Aguarde, Somando.")
SetCursor(0)
IF lTemporario
   While !Eof() .AND. Rel_Ok()
		nSaida		+= xTemp->Saida
		nTotalGeral += ( xTemp->Saida * xTemp->Pvendido )
		nTotalCusto += ( xTemp->Saida * xTemp->Pcusto )
      nComissao   += ((( xTemp->Saida * xTemp->Pvendido ) * xTemp->Porc ) / 100)
		xTemp->(DbSkip(1))
	Enddo
	xTemp->(DbGoTop())
	ResTela( cTela )
	M_Title("ESCOLHA A ORDEM")
	nChoice := FazMenu( 04, 45, aMenu, Cor())
	IF nChoice = 2
		Inde On xTemp->Codigo To (xNtx )
	ElseIF nChoice = 3
		Inde On xTemp->Data To (xNtx )
	ElseIF nChoice = 4
		Inde On xTemp->Docnr To (xNtx )
	EndIF
Else
   While !Eof() .AND. Rel_Ok()
		nSaida		+= Saidas->Saida
		nTotalGeral += ( Saidas->Saida * Saidas->Pvendido )
		nTotalCusto += ( Saidas->Saida * Saidas->Pcusto )
      nComissao   += ((( Saidas->Saida * Saidas->Pvendido ) * Saidas->Porc ) / 100)
      Saidas->(DbSkip(1))
	Enddo
	ResTela( cTela )
EndIF
nMargem := (( nTotalGeral / nTotalCusto ) * 100 )- 100
Saidas->(DbGoTop())
MaBox( 00, 00, MaxRow(), MaxCol(), "CONSULTA SAIDAS DE PRODUTOS", Roloc( Cor()))
Tb 			 := TbrowseDb( 01, 01, MaxRow()-1, MaxCol()-1 )
Tb:colorSpec := "N/W, N/BG, B/W, B/BG, B/W, B/BG, R/W, W+/R"
Tb:HeadSep	 := cFrame2 + cFrame3 + cFrame2
Tb:ColSep	 := Chr(032) + cFrame4 + Chr(032)
Tb:FootSep	 := cFrame2  + cFrame2 + cFrame2
Print( 24, 00,;
"QTD:" + Tran( nSaida, "9999.99") + ;
"³CUSTO:" + Tran( nTotalCusto, "@E 99,999,999.99") + ;
"³VENDA:" + Tran( nTotalGeral, "@E 99,999,999.99") + ;
"³MARG:" + Tran( nMargem, "@E 999.99") + ;
"³COMIS:" + Tran( nComissao, "@E 99,999.99"), Cor(),80)

Tb:AddColumn(TBColumnNew( "DATA",      {|| Data } ) )
Tb:AddColumn(TBColumnNew( "CODIGO",    {|| Codigo } ))
Tb:AddColumn(TBColumnNew( "DESCRICAO DO PRODUTO", {|| Lista->Descricao } ))
Tb:AddColumn(TBColumnNew( "UN",        {|| Lista->Un } ) )
Tb:AddColumn(TBColumnNew( "SAIDA",     {|| Saida } ))
Tb:AddColumn(TBColumnNew( "P.VENDIDO", {|| Tran( Pvendido, "@E 9,999,999,999.99")} ) )
Tb:AddColumn(TBColumnNew( "TOTAL VENDIDO", {|| Tran( ( Pvendido * Saida ) , "@E 99,999,999,999.99") } ) )
Tb:AddColumn(TBColumnNew( "P.CUSTO",   {|| Tran( Pcusto,   "@E 9,999,999,999.99")}) )
Tb:AddColumn(TBColumnNew( "CMV",       {|| Tran((Pcusto / Pvendido) * 100, "@E 999.99%")}))
Tb:AddColumn(TBColumnNew( "VAREJO",    {|| Tran( Varejo,   "@E 9,999,999,999.99")} ) )
Tb:AddColumn(TBColumnNew( "P.ATACADO", {|| Tran( Atacado,  "@E 9,999,999,999.99")} ) )
Tb:AddColumn(TBColumnNew( "COD FABR.", {|| Lista->N_Original } ))
Tb:AddColumn(TBColumnNew( "N§ SERIE",  {|| Serie } ))
Tb:AddColumn(TBColumnNew( "DOCTO N§",  {|| Docnr } ) )
Tb:AddColumn(TBColumnNew( "CLIENTE",   {|| Receber->Nome } ))
Tb:AddColumn(TBColumnNew( "VENDEDOR" , {|| Codiven } ) )
Tb:AddColumn(TBColumnNew( "TECNICO" ,  {|| Tecnico } ) )
Tb:AddColumn(TBColumnNew( "FORMA PGTO",{|| Forma  } ) )
Tb:AddColumn(TBColumnNew( "PERC ACR/DESC", {|| Tran( RetPerc( PVendido, Varejo ), "99999.999%")}))
Tb:AddColumn(TBColumnNew( "DIFERENCA",     {|| Tran( Diferenca, "@E 999,999.99")} ) )
Tb:AddColumn(TBColumnNew( "PERC COMISSAO", {|| Porc }))
Tb:AddColumn(TBColumnNew( "VLR COMISSAO", {|| Tran((((Pvendido * Saida) * Porc) / 100), "@E 999,999.99") } ) )
Coluna := Tb:GETCOLUMN(4)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(7)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(8)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(9)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(10)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(11)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(12)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(18)
Coluna:DefColor := {7, 8}
Coluna := Tb:GETCOLUMN(19)
Coluna:DefColor := {7, 8}
WHILE OK
  WHILE ( !Tb:Stabilize() )
	  nKey = InKey()
	  IF ( nKey != 0 )
		  Exit
     EndIF
  END
  IF Tb:HitTop .OR. Tb:HitBottom
	  ErrorBeep()
  EndIF
  nKey := InKey( 0 )
  IF nKey = K_ESC
	  SetCursor(1)
	  ResTela( cScreen )
	  Exit
  EndIF
  TestaTecla( nKey, Tb )
END
Return

Proc PrintGrupo()
*****************
LOCAL cScreen	:= SaveScreen()
LOCAL Col		:= 58
LOCAL Pagina	:= 0
LOCAL Tam		:= 80

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
Area("Grupo")
Grupo->(Order( GRUPO_DESGRUPO ))
Grupo->(DbGoTop())
PrintOn()
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "LISTAGEM DE GRUPOS",Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "CODIGO    DESCRICAO DO GRUPO" )
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	IF !Empty( CodGrupo )
		Qout( CodGrupo, Space( 05 ), DesGrupo )
		Col++
	EndIF
	IF Col >= 58
		Write( Col, 0,  Repl( SEP, Tam ))
		__Eject()
	EndIF
	DbSkip()
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc PrintSubGrupo()
********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Parcial ", " Geral " }
LOCAL lNovoGrupo := OK
LOCAL cSubIni	  := Space(03)
LOCAL cSubFim	  := Space(03)
LOCAL Tam		  := 80
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL UltGrupo
LOCAL oBloco

Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
Set Rela To Left( CodSgrupo,3) Into Grupo
DbGoTop()
M_Title("MENU DE IMPRESSAO")
nChoice := FazMenu( 10, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	cSubIni := Space(03)
	cSubFim := Space(03)
	MaBox( 16, 10, 19, 72 )
	@ 17, 11 Say "Grupo Inicial..:" Get cSubIni Pict "999" Valid GrupoErrado( @cSubIni, Row(), Col()+1 )
	@ 18, 11 Say "Grupo Final....:" Get cSubFim Pict "999" Valid GrupoErrado( @cSubFim, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	oBloco := {|| Left( CodSGrupo, 3) >= cSubIni .AND. Left( CodSGrupo, 3 ) <= cSubFim .AND. Rel_Ok() }
	DbSeek( cSubIni)
Case nChoice = 2
	oBloco  := {|| !Eof() .AND. Rel_Ok() }
EndCase

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
UltGrupo := Left( CodSGrupo, 3)
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco )
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "LISTAGEM DE SUBGRUPOS",Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "CODIGO          DESCRICAO DO SUBGRUPO" )
		Write( 07, 00, Linha5(Tam))
		Qout( NG + Left(CodsGrupo,3) + ":" + Grupo->DesGrupo + NR )
		Col++
		Col := 10
	EndIF
	IF !Empty( CodSGrupo )
		IF lNovoGrupo
			Qout("")
			Qout( NG + Left(CodsGrupo,3) + ":" + Grupo->DesGrupo + NR )
			Col += 2
		EndIF
		Qout( Space(2),CodSGrupo, Space( 05 ), DesSGrupo )
		Col++
	EndIF
	IF Col >= 58
		Write( Col, 0,  Repl( SEP, Tam ))
		__Eject()
	EndIF
	DbSkip()
	IF UltGrupo != Left( CodSGrupo,3)
		UltGrupo := Left( CodSGrupo,3)
		lNovoGrupo := OK
		Col++
	Else
		lNovoGrupo := FALSO
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc Relatori1()
***************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Ordem Numerica ", " Ordem Alfabetica ", " Ordem Cod. Fabr " }
LOCAL aTotalParc := { " Total  ", " Parcial ", " Por Fornecedor ", " Por Grupo ", " Entradas Por Data" }
LOCAL aNormal	  := { " Lista Normal ", " Lista Por Grupo ", " Lista de Pedidos " }
LOCAL xIndice	  := FTempName("T*.TMP")
LOCAL xArquivo   := FTempName("T*.TMP")
LOCAL cCodiIni
LOCAL cCodiFim
LOCAL cGrupoIni
LOCAL cGrupoFim
LOCAL cSubFim
LOCAL cSubIni
LOCAL cForn
LOCAL nOrder
LOCAL cTela1
LOCAL cTela2
LOCAL cTela3
LOCAL dDataIni
LOCAL dDataFim

WHILE OK
	M_Title("ESCOLHA A ORDEM")
	Codigo_Descricao := FazMenu( 03, 27, aMenuArray, Cor())
	IF Codigo_Descricao = ZERO
		ResTela( cScreen )
		Exit
	EndIF
	cTela1 := SaveScreen()
	cTela2 := SaveScreen()
	WHILE OK
		M_Title("ESCOLHA O FILTRO")
		Total_Parcial	  := FazMenu( 05, 29, aTotalParc, Cor())
		IF Total_Parcial = ZERO
			ResTela( cTela2 )
			Exit
		EndIF
		cCodiIni   := 0
		cCodiFim   := 0
		cForn 	  := Space(4)
		cGrupoIni  := Space(TRES)
		cGrupoFim  := Space(TRES)
		cSubIni	  := Space(SEIS)
		cSubFim	  := Space(SEIS)
		dDataIni   := Date()
		dDataFim   := Date()
		IF !Parcial( Total_Parcial, @cCodiIni, @cCodiFim, @cForn, @cGrupoIni, @cGrupoFim, @cSubIni, @cSubFim, @dDataIni, @dDataFim )
			ResTela( cTela2 )
			Loop
		EndIF
		M_Title("ESCOLHA O TIPO")
		Choice := FazMenu( 07, 31, aNormal, Cor())
		IF Choice = ZERO
			ResTela( cTela2 )
			Exit
		EndIF

		Area("Lista")
		IF Codigo_Descricao = 1
			IF Choice = 1 // Normal
				Lista->(Order( LISTA_CODIGO ))
			Else
				Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_CODIGO ))
			EndIF
		ElseIF Codigo_Descricao = 2
			IF Choice = 1 // Normal
				Lista->(Order( LISTA_DESCRICAO ))
			Else
				Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_DESCRICAO ))
			EndIF
		ElseIF Codigo_Descricao = 3
			Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_N_ORIGINAL ))
		EndIF
		nOrder := IndexOrd()
		Grupo->(Order( GRUPO_CODGRUPO ))
		SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
		Set Rela To Lista->CodGrupo Into Grupo, Lista->CodSgrupo Into SubGrupo
		cTela3	:= Mensagem(" Please, Aguarde...", Cor())

		IF Total_Parcial != 1 // Total
			nConta	:= 0
			Copy Stru To ( xArquivo )
			Use (xArquivo) Alias xLista Exclusive New
			aStru := xLista->(DbStruct())
			Aadd( aStru, {"DESGRUPO",  "C", 40, 0})
			Aadd( aStru, {"DESSGRUPO", "C", 40, 0})
			xLista->(DbCloseArea())
			DbCreate( xArquivo, aStru )
			Use (xArquivo) Alias xLista Exclusive New

		EndIF
		IF Total_Parcial = 2 //  Parcial
			oBloco := {|| Codigo >= cCodiIni .AND. Codigo <= cCodiFim }
			Lista->(Order( LISTA_CODIGO ))
			Lista->(DbSeek( cCodiIni ))
			WHILE Lista->(Eval( oBloco ))
				xLista->(DbAppend())
				For nField := 1 To FCount()
					IF Field( nField ) = "DESGRUPO"
						xLista->DesGrupo	:= Grupo->DesGrupo
						nField++
						Loop
					EndIF
					IF Field( nField ) = "DESSGRUPO"
						xLista->DessGrupo := SubGrupo->DessGrupo
						nField++
						Loop
					EndIF
					xLista->(FieldPut( nField, Lista->(FieldGet( nField ))))
				Next
				nConta++
				Lista->(DbSkip(1))
			EndDo

		ElseIF Total_Parcial = 3 //  Por Fornecedor
			oBloco := {|| Codi = cforn  }
			Lista->(Order( LISTA_CODI ))
			Lista->(DbSeek( cForn ))
			WHILE Lista->(Eval( oBloco ))
				IF Lista->Data >= dDataIni .AND. Lista->Data <= dDataFim
					xLista->(DbAppend())
					For nField := 1 To FCount()
						IF Field( nField ) = "DESGRUPO"
							xLista->DesGrupo	:= Grupo->DesGrupo
							nField++
							Loop
						EndIF
						IF Field( nField ) = "DESSGRUPO"
							xLista->DessGrupo := SubGrupo->DessGrupo
							nField++
							Loop
						EndIF
						xLista->(FieldPut( nField, Lista->(FieldGet( nField ))))
					Next
					nConta++
				EndIF
				Lista->(DbSkip(1))
			EndDo

		ElseIF Total_Parcial = 4 //  Por Grupo
			oBloco := {|| CodGrupo >= cGrupoIni .AND. CodGrupo <= cGrupoFim }
			Lista->(Order( LISTA_CODGRUPO ))
			Lista->(DbSeek( cGrupoIni ))
			WHILE Lista->(Eval( oBloco ))
				xLista->(DbAppend())
				For nField := 1 To FCount()
					IF Field( nField ) = "DESGRUPO"
						xLista->DesGrupo	:= Grupo->DesGrupo
						nField++
						Loop
					EndIF
					IF Field( nField ) = "DESSGRUPO"
						xLista->DessGrupo := SubGrupo->DessGrupo
						nField++
						Loop
					EndIF
					xLista->(FieldPut( nField, Lista->(FieldGet( nField ))))
				Next
				nConta++
				Lista->(DbSkip(1))
			EndDo

		ElseIF Total_Parcial = 5 //  Por Data
			oBloco := {|| Data >= dDataIni .AND. Data <= dDataFim }
			Lista->(Order( LISTA_DATA ))
			Set Soft On
			Lista->(DbSeek( dDataIni ))
			WHILE Lista->(Eval( oBloco ))
				xLista->(DbAppend())
				For nField := 1 To FCount()
					IF Field( nField ) = "DESGRUPO"
						xLista->DesGrupo	:= Grupo->DesGrupo
						nField++
						Loop
					EndIF
					IF Field( nField ) = "DESSGRUPO"
						xLista->DessGrupo := SubGrupo->DessGrupo
						nField++
						Loop
					EndIF
					xLista->(FieldPut( nField, Lista->(FieldGet( nField ))))
				Next
				nConta++
				Lista->(DbSkip(1))
			EndDo
			Set Soft Off
		EndIF
		IF Total_Parcial != 1
			IF nConta = 0
				xLista->(DbCloseArea())
				Ferase( xArquivo )
				ErrorBeep()
				Alerta("Erro: Nenhum Registro a Processsar.")
				ResTela( cTela2 )
				Loop
			EndIF
			Area("xLista")
			IF Codigo_Descricao = 1 // Codigo
				IF Choice = 1 // Normal
					Inde On xLista->Codigo To ( xIndice )
				Else
					Inde On xLista->CodGrupo + xLista->CodSgrupo + xLista->Codigo To ( xIndice )
				EndIF
			ElseIF Codigo_Descricao = 2 // Descricao
				IF Choice = 1 // Normal
					Inde On xLista->Descricao To ( xIndice )
				Else
					Inde On xLista->CodGrupo + xLista->CodSgrupo + xLista->Descricao To ( xIndice )
				EndIF
			ElseIF Codigo_Descricao = 3 // Cod Fabricante
				IF Choice = 1 // Normal
					Inde On xLista->N_Original To ( xIndice )
				Else
					Inde On xLista->CodGrupo + xLista->CodSgrupo + xLista->N_Original To ( xIndice )
				EndIF
			EndIF
			nOrder := xLista->(IndexOrd())
		EndIF
		DbGoTop()
		ResTela( cTela3 )
		IF Choice = 1 // Normal
			PrnNormal( nOrder )
		ElseIF Choice = 2 // Por Grupo
			PrnGrupo( nOrder )
		ElseIF Choice = 3 // Pedidos
			PrnPedidos( nOrder )
		EndIF
		DbClearRel()
		DbClearFilter()
		DbGoTop()
		IF Total_Parcial != 1
			xLista->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xIndice )
		EndIF
		ResTela( cTela2 )
	Enddo
Enddo

Function Parcial( Total_Parcial, cCodiIni, cCodiFim, cForn, cGrupoIni, cGrupoFim, cSubIni, cSubFim, dDataIni, dDataFim )
************************************************************************************************************************
LOCAL cScreen	:= SaveScreen()
Do Case
	Case Total_Parcial = 1 // Total
		  Return( OK )

	Case Total_Parcial = 2 // Parcial
		  MaBox( 10, 44, 13, 62 )
		  @ 11, 45 Say "Cod.Ini..:" Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni )
		  @ 12, 45 Say "Cod.Fim..:" Get cCodiFim Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiFim,,OK )
		  Read
		  IF LastKey() = ESC
			  ResTela( cScreen )
			  Return( FALSO )
		  EndIF
		  ResTela( cScreen )
		  Return( OK )

	Case Total_Parcial = 3 // Por Fornecedor
	  cForn	:= Space(4)
	  Area("Receber")
	  Receber->(Order( RECEBER_CODI ))
	  MaBox( 13, 05, 17, 67 )
	  @ 14, 06 Say "Fornecedor...:" Get cForn Pict "9999" Valid Pagarrado( @cForn, Row(), Col()+1 )
	  @ 15, 06 Say "Data Inicial.:" Get dDataIni Pict PIC_DATA
	  @ 16, 06 Say "Data Final...:" Get dDataFim Pict PIC_DATA
	  Read
	  IF LastKey() = ESC
		  ResTela( cScreen )
		  Return( FALSO )
	  EndIF
	  ResTela( cScreen )
	  Return( OK )

	Case Total_Parcial = 4 // Por Grupo
		Lista->(Order( LISTA_CODGRUPO ))
		MaBox( 15, 11, 18, 31 )
		@ 16, 12 Say "Grupo Inicial.:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
		@ 17, 12 Say "Grupo Final...:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		ResTela( cScreen )
		Return( OK )

	Case Total_Parcial = 5 // Por Data
		MaBox( 13, 05, 16, 30 )
		@ 14, 06 Say "Data Inicial.:" Get dDataIni Pict PIC_DATA
		@ 15, 06 Say "Data Final...:" Get dDataFim Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return( FALSO )
		EndIF
		ResTela( cScreen )
		Return( OK )
EndCase

Function PorFornecedor( cForn)
******************************
LOCAL GetList := {}
Area("Receber")
Receber->(Order( RECEBER_CODI ))
MaBox( 14, 10, 16, 72 )
@ 15, 11 Say "Fornecedor.....:" Get cForn Pict "9999" Valid Pagarrado( @cForn, 15, 33 )
Read
IF LastKey() = ESC
	Return(FALSO )
EndIF
Return( OK )

Proc Detalhado_de_Entradas()
****************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL EntSai	  := SaveScreen()
LOCAL aMenuArray := {"Por Codigo", "Por Fornecedor", "Por Documento", "Geral"}
LOCAL xDbf		  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL nChoice	  := 0
LOCAL xCodigo	  := 0
LOCAL xCodigo1   := 0
LOCAL xSwap 	  := 0
LOCAL cFatura	  := Space(07)
LOCAL oBloco1
LOCAL oBloco2
LOCAL aStru
LOCAL nField

WHILE OK
	oMenu:Limpa()
	M_Title("ROL DE PRODUTOS ADQUIRIDOS")
	nChoice := FazMenu( 02, 05, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		dIni	  := Date()-30
		dFim	  := Date()
		xCodigo := 0
		MaBox( 10, 05, 14, 78 )
		@ 11, 06 Say "Codigo..........:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigo,,,Row(), Col()+5 )
		@ 12, 06 Say "Data Inicial....:" Get dIni    Pict PIC_DATA
		@ 13, 06 Say "Data Final......:" Get dFim    Pict PIC_DATA
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Pagar->(Order( PAGAR_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Area("Entradas")
		Entradas->(Order( ENTRADAS_CODIGO ))
		IF Entradas->(!DbSeek( xCodigo ))
			Nada()
			Loop
		EndIF
		Set Rela To Entradas->Codigo Into Lista, Entradas->Codi Into Pagar
		oBloco1 := {|| Entradas->Codigo = xCodigo }
		oBloco2 := {|| Entradas->Data >= dIni .AND. Entradas->Data <= dFim }
		LisEntradas( oBloco1, oBloco2 )
		Entradas->(DbClearRel())
		Entradas->(DbGoTop())
		Loop

	Case nChoice = 2
		dIni	  := Date()-30
		dFim	  := Date()
		cCodi   := Space(04)
		MaBox( 10, 05, 14, 78 )
		@ 11, 06 Say "Fornecedor......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		@ 12, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
		@ 13, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Entradas->(Order( ENTRADAS_CODI ))
		IF Entradas->(!DbSeek( cCodi ))
			Nada()
			Loop
		EndIF
		Mensagem('Aguarde, Processando.')
		aStru   := Entradas->(DbStruct())
		oBloco1 := {|| Entradas->Codi = cCodi }
		oBloco2 := {|| Entradas->Data >= dIni .AND. Entradas->Data <= dFim }
		DbCreate( xDbf, aStru )
		Use (xDbf) Alias xEntradas Exclusive New
		WHILE Eval( oBloco1 ) .AND. Rep_Ok()
			IF Eval( oBloco2 )
				xEntradas->( DbAppend())
				For nField := 1 To FCount()
					xEntradas->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				Next
			EndIF
			Entradas->(DbSkip(1))
		Enddo
		Pagar->(Order( PAGAR_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Area('xEntradas')
		Set Rela To xEntradas->Codigo Into Lista, xEntradas->Codi Into Pagar
		Inde On xEntradas->Codigo To (xNtx )
		xEntradas->(DbGoTop())
		oBloco1 := {|| xEntradas->Codi = cCodi }
		oBloco2 := {|| xEntradas->Data >= dIni .AND. xEntradas->Data <= dFim }
		LisEntradas( oBloco1, oBloco2 )
		xEntradas->(DbClearRel())
		xEntradas->(DbGoTop())
		xEntradas->(DbCloseArea())
		Ferase( xDbf )
		Ferase( xNtx )
		Loop

	Case nChoice = 3
		dIni	  := Date()-30
		dFim	  := Date()
		cFatura := Space(07)
		MaBox( 10, 05, 12, 78 )
		@ 11, 06 Say "Documento.......: " Get cFatura Pict "@!" Valid VisualEntraFatura( @cFatura )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Entradas->(Order( ENTRADAS_FATURA ))
		IF Entradas->(!DbSeek( cFatura ))
			Nada()
			Loop
		EndIF
		Mensagem('Aguarde, Processando.')
		aStru   := Entradas->(DbStruct())
		oBloco1 := {|| Entradas->Fatura = cFatura }
		oBloco2 := {|| Entradas->Fatura = cFatura }
		DbCreate( xDbf, aStru )
		Use (xDbf) Alias xEntradas Exclusive New
		WHILE Eval( oBloco1 ) .AND. Rep_Ok()
			IF Eval( oBloco2 )
				xEntradas->( DbAppend())
				For nField := 1 To FCount()
					xEntradas->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				Next
			EndIF
			Entradas->(DbSkip(1))
		Enddo
		Pagar->(Order( PAGAR_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Area('xEntradas')
		Set Rela To xEntradas->Codigo Into Lista, xEntradas->Codi Into Pagar
		Inde On xEntradas->Codigo To (xNtx )
		xEntradas->(DbGoTop())
		oBloco1 := {|| xEntradas->Fatura = cFatura }
		oBloco2 := {|| xEntradas->Fatura = cFatura }
		LisEntradas( oBloco1, oBloco2 )
		xEntradas->(DbClearRel())
		xEntradas->(DbGoTop())
		xEntradas->(DbCloseArea())
		Ferase( xDbf )
		Ferase( xNtx )
		Loop

	Case nChoice = 4
		dIni := Date()-30
		dFim := Date()
		MaBox( 10, 05, 13, 78 )
		@ 11, 06 Say "Data Inicial....: " Get dIni Pict PIC_DATA
		@ 12, 06 Say "Data Final......: " Get dFim Pict PIC_DATA
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Entradas->(Order( ENTRADAS_DATA ))
		Entradas->(Dbgotop())
		IF Entradas->(Eof())
			Nada()
			Loop
		EndIF
		Entradas->(DbSeek( dIni, OK ))
		Mensagem('Aguarde, Processando.')
		aStru   := Entradas->(DbStruct())
		oBloco1 := {|| Entradas->(!Eof()) }
		oBloco2 := {|| Entradas->Data >= dIni .AND. Entradas->Data <= dFim }
		DbCreate( xDbf, aStru )
		Use (xDbf) Alias xEntradas Exclusive New
		WHILE Eval( oBloco1 ) .AND. Rep_Ok()
			IF Eval( oBloco2 )
				xEntradas->( DbAppend())
				For nField := 1 To FCount()
					xEntradas->( FieldPut( nField, Entradas->(FieldGet( nField ))))
				Next
			EndIF
			Entradas->(DbSkip(1))
		Enddo
		Pagar->(Order( PAGAR_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Area('xEntradas')
		Set Rela To xEntradas->Codigo Into Lista, xEntradas->Codi Into Pagar
		Inde On xEntradas->Codigo To (xNtx )
		xEntradas->(DbGoTop())
		oBloco1 := {|| xEntradas->(!Eof())}
		oBloco2 := {|| xEntradas->Data >= dIni .AND. xEntradas->Data <= dFim }
		LisEntradas( oBloco1, oBloco2 )
		xEntradas->(DbClearRel())
		xEntradas->(DbGoTop())
		xEntradas->(DbCloseArea())
		Ferase( xDbf )
		Ferase( xNtx )
		Loop
	EndCase
EndDo

Proc LisEntradas( oBloco1, oBloco2 )
************************************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL Total1	  := 0
LOCAL Total4	  := 0
LOCAL Total5	  := 0
LOCAL TotEntra   := 0
LOCAL GerEntra   := 0
LOCAL nParVarejo := 0
LOCAL nTotVarejo := 0
LOCAL NovoCodigo := OK
LOCAL UltCodigo  := Codigo

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF

Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Eval( oBloco1 ) .AND. !Eof() .AND. Rel_Ok()
	IF !Eval( oBloco2 )
		DbSkip(1)
		Loop
	EndIF
	IF Col >= 56
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "ROL DE PRODUTOS ADQUIRIDOS", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"DATA      DOCTO    FORNECEDOR                               COD FABRIC        ENTRADA      CUSTO   T. CUSTO    P.VENDA    T.VENDA")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	IF NovoCodigo .OR. Col = 8
		IF NovoCodigo
			Col++
		EndIF
		cDescricao := Lista->(AllTrim( Descricao))
		Write( Col, 0, NG + Lista->(Padr( Codigo + " " + cDescricao, Tam )) + NR)
		IF NovoCodigo
			NovoCodigo := FALSO
			TotEntra   := 0
			GerEntra   := 0
			TotLucro   := 0
			nParVarejo := 0
		EndIF
		Col++
	EndIF
	Qout( Data, Fatura, Pagar->Nome, Lista->N_Original, Entrada, Tran( Pcusto, 	"@E 999,999.99"),;
																	Tran((Pcusto * Entrada),		"@E 999,999.99"),;
																	Tran( Lista->Varejo, 			"@E 999,999.99"),;
																	Tran( Lista->Varejo*Entrada,	"@E 999,999.99"))
	TotEntra   += Entrada
	GerEntra   += (Entrada * Pcusto)
	Total1	  += Entrada
	Total4	  += (Entrada * Pcusto)
	nParVarejo += (Entrada * Lista->Varejo)
	nTotVarejo += (Entrada * Lista->Varejo)
	Col++
	DbSkip()
	IF UltCodigo  != Codigo .OR. Eof()
		UltCodigo  := Lista->Codigo
		NovoCodigo := OK
		Col++
		Write( Col, 000, "** Total Codigo  **" )
		Write( Col, 075, Tran( TotEntra,   "9999999.99" ))
		Write( Col, 091, Tran( GerEntra,   "@E 9,999,999,999.99" ) )
		Write( Col, 115, Tran( nParVarejo, "@E 999,999,999.99" ))
		Col++
	EndIF
	IF Col >= 56
		Col := 58
		__Eject()
	EndIF
EndDo
Col++
Write( Col, 000, "** Total Geral **" )
Write( Col, 075, Tran( Total1,	  "9999999.99" ))
Write( Col, 091, Tran( Total4,	  "@E 9,999,999,999.99" ))
Write( Col, 115, Tran( nTotVarejo, "@E 999,999,999.99" ))
__Eject()
PrintOff()
Return

Proc RolFatEntrada()
********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cFatura := Space(07)
LOCAL cCodi
LOCAL oBloco

WHILE OK
	oMenu:Limpa()
	Area("Entradas")
	cFatura := Space(07)
	MaBox( 10, 05, 12, 78 )
	@ 11, 06 Say "Documento N§....: " Get cFatura Pict "@!" Valid VisualEntraFatura( @cFatura )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	cTela := Mensagem("Aguarde...", Cor())
	cCodi := Entradas->Codi
	Pagar->(Order( PAGAR_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Entradas->(Order(ENTRADAS_FATURA))
   Set Rela To Entradas->Codigo Into Lista, Entradas->Codi Into Pagar, Entradas->Codi Into EntNota
	Entradas->(DbSeek( cFatura ))
	oBloco := {|| Entradas->Fatura = cFatura }
	RolFatImp( oBloco, cCodi )
	Entradas->(DbClearRel())
	Entradas->(DbGoTop())
EndDo

Proc RolFatImp( oBloco, cCodi )
*******************************
LOCAL cScreen := SaveScreen()
LOCAL Tam
LOCAL Col
LOCAL Pagina

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Tam		  := 132
Col		  := 58
Pagina	  := 0
Mensagem("Aguarde, Emitindo Relatorio.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. !Eof() .AND. Rel_Ok()
	IF Entradas->Codi != cCodi
		Entradas->(DbSkip(1))
		Loop
	EndIF
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "POSICAO DE ENTRADA POR NOTA", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "FORNECEDOR...: " + Pagar->Nome )
		Write( 07, 00, "NOTA N§......: " + Entradas->Fatura )
		Write( 08, 00, "DATA EMISSAO.: " + DToc( Entradas->Data ))
		Write( 09, 00, "DATA ENTRADA.: " + DToc( Entradas->DEntrada ))
		Write( 10, 00, "VLR NFF......: " + AllTrim(Tran( Entradas->VlrNff, "@E 999,999,999.99")))
		Write( 11, 00, Linha5(Tam))
		Write( 12, 00,"CODIGO DESCRICAO DO PRODUTO                 UN     QUANT   CUSTO NFF  FRETE   ICMS   CUSTO FIN  M.VAR  M.ATA      VAREJO     ATACADO")
		Write( 13, 00, Linha5(Tam))
		Col := 14
	EndIF
	Qout( Entradas->Codigo, Left( Lista->Descricao,36), Lista->Un, Entradas->Entrada, Entradas->Pcusto, ;
			Entradas->Frete, Entradas->Imposto, Entradas->CustoFinal, Lista->MarVar, Lista->MarAta, Lista->Varejo, Lista->Atacado )
	Col++
	Entradas->(DbSkip(1))
	IF Col >= 58 .OR. Eof() .OR. !Eval(oBloco)
		__Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return


Proc RolEstoqueFor()
********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL nCop		  := 0
LOCAL nTam		  := 132
LOCAL Col		  := 58
LOCAL Pagin 	  := 0
LOCAL nQuant	  := 0
LOCAL xAlias	  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL lFiltro	  := OK
LOCAL aStru
LOCAL aMenuArray := { "Codigo", "Descricao", "Tamanho", "Cod Fabricante", "Qtde Minima", "Estoque", "Preco Venda" }
LOCAL cTela

WHILE OK
	cCodiFor := Space( 04 )
	cSigla	:= Space( 10 )
	MaBox( 13, 10, 15, 79 )
	@ 14, 11 Say "Fornecedor.:" Get cCodiFor Pict "9999" Valid Pagarrado( @cCodiFor, Row(), Col()+1, @cSigla )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	lFiltro := Conf("Pergunta: Selecionar registros zerados ou negativos ?")
	cNomeFor := Pagar->Nome
	cContFor := Pagar->Con
	cFoneFor := Pagar->Fone
	cFaxFor	:= Pagar->Fax
	aArray	:= {}
	cTela := Mensagem(" Aguarde, Filtrando Registros... ", WARNING )
	aStru := Lista->(DbStruct())
	DbCreate( xAlias, aStru )
	Use ( xAlias ) Exclusive Alias xTemp New
	Area("Lista")
	Lista->(Order( LISTA_CODI ))
	IF Lista->(DbSeek( cCodiFor ))
		While ( Lista->Codi = cCodiFor .AND. Rel_Ok() )
			IF !lFiltro
				IF Lista->Quant <= 0
					Lista->(DbSkip(1))
					Loop
				EndIF
			EndIF
			cSigla := Sigla
			xTemp->(DbAppend())
			xTemp->Codigo		:= Lista->Codigo
			xTemp->N_Original := Lista->N_Original
			xTemp->Descricao	:= Lista->Descricao
			xTemp->Un			:= Lista->Un
			xTemp->Qmin 		:= Lista->Qmin
			xTemp->Quant		:= Lista->Quant
			xTemp->Tam			:= Lista->Tam
			xTemp->Varejo		:= Lista->Varejo
			Lista->(DbSkip(1))
		EndDo
	EndIF
	xTemp->(DbGoTop())
	IF xTemp->(Eof())  // Nenhum Registro
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		Alerta("Erro: Nenhum Produto Registrado deste Fornecedor.")
		ResTela( cScreen )
		Loop
	EndIF
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aMenuArray )
		IF nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		ElseIf nOpcao = 1 // Por Codigo
			 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Codigo To ( xNtx )
		 ElseIf nOpcao = 2 // Por Descricao
			 Mensagem(" Aguarde, Ordenando Por Descricao. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Descricao To ( xNtx )
		 ElseIf nOpcao = 3 // Por Tamanho
			 Mensagem(" Aguarde, Ordenando Por Tamanho. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Tam To ( xNtx )
		 ElseIf nOpcao = 4 // N_Original
			 Mensagem(" Aguarde, Ordenando Por Codigo Fabricante. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->N_Original To ( xNtx )
		 ElseIf nOpcao = 5 // QMin
			 Mensagem(" Aguarde, Ordenando Por Qtde Minima. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Qmin To ( xNtx )
		 ElseIf nOpcao = 6 // Quant
			 Mensagem(" Aguarde, Ordenando Por Estoque. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Quant To ( xNtx )
		 ElseIf nOpcao = 7 // Quant
			 Mensagem(" Aguarde, Ordenando Por Preco Venda. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Varejo To ( xNtx )
		EndIF
		oMenu:Limpa()
		IF !Instru80()
			ResTela( cScreen )
			Loop
		EndIF
		xTemp->(DbGoTop())
		Mensagem("Aguarde, Imprimindo.", WARNING )
		nTam			:= 132
		Col			:= 58
		Pagina		:= 0
		nQuant		:= 0
		lSair 		:= FALSO
		Relato		:= "RELACAO DE PRODUTOS POR FORNECEDOR"
		PrintOn()
		FPrint( PQ )
		SetPrc(0,0)
		WHILE xTemp->(!Eof()) .AND. Rep_Ok()
			IF Col >= 57
				IF !Rel_OK()
					Exit
				EndIF
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( Relato ,nTam ) )
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00, "FORNECEDOR : " + NG + cCodiFor + " " + cNomeFor + NR )
				Write( 07, 00, "CONTATO    : " + NG + cContFor + NR + " FONE : " + NG + cFoneFor + NR + " FAX : " + NG + cFaxFor + NR)
				Write( 08, 00, Linha5(nTam))
				Write( 09, 00, "CODIGO REFER/COD. FABR TAM    DESCRICAO DO PRODUTO                     UN    MINIMO   ESTOQUE     P.VAREJO OBSERVACOES")
				Write( 10, 00, Linha5(nTam))
				Col := 11
			EndIF
			xTemp->(Qout( Codigo, N_Original, Tam, Ponto( Descricao, 40 ), Un, Qmin, Quant, Tran( Varejo, "@E 9,999,999.99"), "_________________________" ))
			nQuant += xTemp->Quant
			Col++
			xTemp->(DbSkip(1))
			IF Col >= 57 .OR. xTemp->(Eof())
				Qout( Repl( SEP, nTam ))
				Qout( Space(86), Tran( nQuant, "999.99"))
				__Eject()
			EndIF
		EndDo
		xTemp->(DbClearIndex())
		PrintOff()
	EndDo
	ResTela( cScreen )
EndDo

Proc RolEstGrupo()
******************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL nCop		  := 0
LOCAL nTam		  := 132
LOCAL Col		  := 58
LOCAL Pagin 	  := 0
LOCAL xAlias	  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL aStru
LOCAL aMenuArray := { "Codigo", "Descricao", "Tamanho", "Cod Fabricante", "Qtde Minima", "Estoque", "Preco Venda" }
LOCAL cTela

WHILE OK
	MaBox( 13, 10, 17, 70 )
	cGrupo := Space(03)
	cLetra1 := Space(40)
	cLetra2 := Space(40)
	@ 14, 11 Say "Grupo............:" Get cGrupo Pict "999" Valid CodiGrupo( @cGrupo )
	@ 15, 11 Say "Palavra Inicial..:" Get cLetra1 Pict "@!" Valid !Empty( cLetra1 )
	@ 16, 11 Say "Palavra Final....:" Get cLetra2 Pict "@!" Valid !Empty( cLetra2 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	cLetra1 := AllTrim( cLetra1 )
	cLetra2 := AllTrim( cLetra2 )
	cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
	aStru   := Lista->(DbStruct())
	DbCreate( xAlias, aStru )
	Use ( xAlias ) Exclusive Alias xTemp New
	Area("Lista")
	Lista->(Order( LISTA_CODGRUPO ))
	IF Lista->(DbSeek( cGrupo ))
		While ( Lista->CodGrupo = cGrupo .AND. Rel_Ok() )
			IF Lista->(Left( Descricao, Len( cLetra1 ))) >= cLetra1 .AND. Lista->(Left( Descricao, Len( cLetra2 ))) <= cLetra2
				xTemp->(DbAppend())
				xTemp->Codigo		:= Lista->Codigo
				xTemp->N_Original := Lista->N_Original
				xTemp->Descricao	:= Lista->Descricao
				xTemp->Un			:= Lista->Un
				xTemp->Qmin 		:= Lista->Qmin
				xTemp->Quant		:= Lista->Quant
				xTemp->Tam			:= Lista->Tam
				xTemp->Varejo		:= Lista->Varejo
			EndIF
			Lista->(DbSkip(1))
		EndDo
	EndIF
	xTemp->(DbGoTop())
	IF xTemp->(Eof())  // Nenhum Registro
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		Alerta("Erro: Nenhum Produto Atende a Condicao.")
		ResTela( cScreen )
		Loop
	EndIF
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aMenuArray )
		IF nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		ElseIf nOpcao = 1 // Por Codigo
			 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Codigo To ( xNtx )
		 ElseIf nOpcao = 2 // Por Descricao
			 Mensagem("Aguarde, Ordenando Por Descricao. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Descricao To ( xNtx )
		 ElseIf nOpcao = 3 // Por Tamanho
			 Mensagem(" Aguarde, Ordenando Por Tamanho. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Tam To ( xNtx )
		 ElseIf nOpcao = 4 // N_Original
			 Mensagem(" Aguarde, Ordenando Por Codigo Fabricante. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->N_Original To ( xNtx )
		 ElseIf nOpcao = 5 // QMin
			 Mensagem(" Aguarde, Ordenando Por Qtde Minima. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Qmin To ( xNtx )
		 ElseIf nOpcao = 6 // Quant
			 Mensagem(" Aguarde, Ordenando Por Estoque. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Quant To ( xNtx )
		 ElseIf nOpcao = 7 // Quant
			 Mensagem(" Aguarde, Ordenando Por Preco Venda. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Varejo To ( xNtx )
		EndIF
		oMenu:Limpa()
		IF !Instru80()
			ResTela( cScreen )
			Loop
		EndIF
		xTemp->(DbGoTop())
		Mensagem("Aguarde, Imprimindo.", WARNING )
		nTam			:= 132
		Col			:= 58
		Pagina		:= 0
		lSair 		:= FALSO
		Relato		:= "RELACAO DE PRODUTOS POR FORNECEDOR"
		PrintOn()
		FPrint( PQ )
		SetPrc(0,0)
		Grupo->(Order( GRUPO_CODGRUPO ))
		Grupo->(DbSeek( cGrupo ))
		WHILE xTemp->(!Eof()) .AND. Rep_Ok()
			IF Col >=  58
				IF !Rel_OK()
					Exit
				EndIF
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( Relato ,nTam ) )
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00, "GRUPO    : " + NG + cGrupo + " " + Grupo->DesGrupo + NR )
				Write( 07, 00, "CONDICAO : " + NG + cLetra1 + " a " + cLetra2 + NR)
				Write( 08, 00, Linha5(nTam))
				Write( 09, 00, "CODIGO REFER/COD. FABR TAM    DESCRICAO DO PRODUTO                     UN    MINIMO   ESTOQUE     P.VAREJO OBSERVACOES")
				Write( 10, 00, Linha5(nTam))
				Col := 11
			EndIF
			xTemp->(Qout( Codigo, N_Original, Tam, Ponto( Descricao, 40 ), Un, Qmin, Quant, Tran( Varejo, "@E 9,999,999.99"), "_________________________" ))
			xTemp->(DbSkip(1))
			Col++
			IF Col >= 58 .OR. xTemp->(Eof())
				Write( Col, 0, Repl( SEP, nTam ))
				__Eject()
			EndIF
		EndDo
		xTemp->(DbClearIndex())
		PrintOff()
	EndDo
	ResTela( cScreen )
EndDo

Proc RolFisGrupo()
******************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL nCop		  := 0
LOCAL nTam		  := 132
LOCAL Col		  := 58
LOCAL Pagin 	  := 0
LOCAL xAlias	  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL aMenuArray := { "Codigo", "Descricao", "Estoque", "Total Custo", "Total Venda" }
LOCAL cGrupoIni  := Space(03)
LOCAL cGrupoFim  := Space(03)
LOCAL aStru 	  := {{ "CODGRUPO",  "C", 03, 0 },;
							{ "DESGRUPO",  "C", 40, 0 },;
							{ "QUANT",     "N", 09, 2 },;
							{ "PCUSTO",    "N", 13, 2 },;
							{ "VAREJO",    "N", 13, 2 }}
LOCAL cTela

WHILE OK
	MaBox( 13, 10, 16, 70 )
	cGrupoIni := Space(03)
	cGrupoFim := Space(03)
	@ 14, 11 Say "Grupo Inicial....:" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
	@ 15, 11 Say "Grupo Final......:" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
	oBloco  := {|| Grupo->CodGrupo >= cGrupoIni .AND. Grupo->CodGrupo <= cGrupoFim }
	DbCreate( xAlias, aStru )
	Use ( xAlias ) Exclusive Alias xTemp New
	Area("Grupo")
	Grupo->(Order( GRUPO_CODGRUPO ))
	Lista->(Order( LISTA_CODGRUPO ))
	Set Soft On
	Grupo->(DbSeek( cGrupoIni ))
	Set Soft Off
	While Eval( oBloco ) .AND. Grupo->(!Eof())
		cGrupo	 := Grupo->CodGrupo
		cDesGrupo := Grupo->DesGrupo
		IF Lista->(DbSeek( cGrupo ))
			xTemp->(DbAppend())
			xTemp->CodGrupo	:= cGrupo
			xTemp->DesGrupo	:= cDesGrupo
			While ( Lista->CodGrupo = cGrupo .AND. Rel_Ok() )
				xTemp->Quant		+= Lista->Quant
				xTemp->Pcusto		+= Lista->Quant * Lista->Pcusto
				xTemp->Varejo		+= Lista->Quant * Lista->Varejo
				Lista->(DbSkip(1))
			EndDo
		EndIF
		Grupo->(DbSkip(1))
	EndDo
	xTemp->(DbGoTop())
	IF xTemp->(Eof())  // Nenhum Registro
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )
		Alerta("Erro: Nenhum Produto Atende a Condicao.")
		ResTela( cScreen )
		Loop
	EndIF
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aMenuArray )
		IF nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xAlias )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		ElseIf nOpcao = 1 // Por Codigo
			 Mensagem(" Aguarde, Ordenando Por Codigo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->CodGrupo To ( xNtx )
		 ElseIf nOpcao = 2 // Por Descricao
			 Mensagem("Aguarde, Ordenando Por Descricao. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->DesGrupo To ( xNtx )
		 ElseIf nOpcao = 3 // Por Tamanho
			 Mensagem(" Aguarde, Ordenando Por Quantidade. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Quant To ( xNtx )
		 ElseIf nOpcao = 4 // N_Original
			 Mensagem(" Aguarde, Ordenando Por Total Custo. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Pcusto To ( xNtx )
		 ElseIf nOpcao = 5 // QMin
			 Mensagem(" Aguarde, Ordenando Por Total Venda. ", WARNING )
			 Area("xTemp")
			 Inde On xTemp->Varejo To ( xNtx )
		EndIF
		oMenu:Limpa()
		IF !Instru80()
			ResTela( cScreen )
			Loop
		EndIF
		xTemp->(DbGoTop())
		Mensagem("Aguarde, Imprimindo.", WARNING )
		nTam			:= 80
		Col			:= 58
		Pagina		:= 0
		lSair 		:= FALSO
		Relato		:= "RELATORIO FISICO/FINANCEIRO POR GRUPO"
		nTotPcusto	:= 0
		nTotVenda	:= 0
		nTotQuant	:= 0
		nParPcusto	:= 0
		nParVenda	:= 0
		nParQuant	:= 0
		PrintOn()
		SetPrc(0,0)
		WHILE xTemp->(!Eof()) .AND. Rep_Ok()
			IF Col >=  57
				IF !Rel_OK()
					Exit
				EndIF
				Write( 00, 00, Linha1( nTam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(nTam))
				Write( 03, 00, Linha4(nTam, SISTEM_NA2 ))
				Write( 04, 00, Padc( Relato ,nTam ) )
				Write( 05, 00, Linha5(nTam))
				Write( 06, 00, "GRP DESCRICAO DO GRUPO                           QUANT     T. CUSTO    T. VAREJO")
				Write( 07, 00, Linha5(nTam))
				Col := 8
			EndIF
			xTemp->(Qout( CodGrupo, DesGrupo, Quant, Tran( PCusto, "@E 9,999,999.99"), Tran( Varejo, "@E 9,999,999.99")))
			nTotPcusto	 += xTemp->Pcusto
			nTotVenda	 += xTemp->Varejo
			nTotQuant	 += xTemp->Quant
			nParPcusto	 += xTemp->Pcusto
			nParVenda	 += xTemp->Varejo
			nParQuant	 += xTemp->Quant
			xTemp->(DbSkip(1))
			Col++
			IF Col >= 57 .OR. xTemp->(Eof())
				Write( Col, 0, Repl( SEP, nTam ))
				Qout("*** PARCIAL ***", Space(28), Tran( nParQuant, "999999.99"), Tran( nParPCusto, "@E 9,999,999.99"), Tran( nParVenda, "@E 9,999,999.99"))
				IF xTemp->(Eof())
					Qout("***  TOTAL  ***", Space(28), Tran( nTotQuant, "999999.99"), Tran( nTotPCusto, "@E 9,999,999.99"), Tran( nTotVenda, "@E 9,999,999.99"))
				EndIF
				__Eject()
			EndIF
		EndDo
		xTemp->(DbClearIndex())
		PrintOff()
	EndDo
	ResTela( cScreen )
EndDo

Proc EstoqueFornecedor()
************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aMenuArray := {" Individual ", " Geral " }
LOCAL nChoice	  := 0

M_Title("ESTOQUE POR FORNECEDOR")
nChoice := FazMenu( 05, 12, aMenuArray, Cor())
Do Case
Case nChoice = 1
	EstoForIndividual()

Case nChoice = 2
	EstoForGeral()

EndCase
ResTela( cScreen )
Return

Proc EstoForGeral()
*******************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL Tam		  := CPI1280
LOCAL cCodi 	  := ""
LOCAL lNovo 	  := OK
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL Relato	  := "RELATORIO GERAL DE ESTOQUE POR FORNECEDOR"

IF !Instru80()
	Restela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( _CPI12)
SetPrc( 0, 0 )
Pagar->(Order( PAGAR_CODI ))
Area("Lista")
Lista->(Order( LISTA_CODI_DESCRICAO ))
Set Rela To Codi Into Pagar
Lista->(DbGoTop())
cCodi := Lista->Codi
WHILE !Eof() .AND. Rep_Ok()
	cNome := Pagar->(AllTrim( Nome))
	IF Col >=  58
		Write( 01, 00, Linha1( Tam, @Pagina))
		Write( 02, 00, Linha2())
		Write( 03, 00, Linha3(Tam))
		Write( 04, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 05, 00, Padc( Relato ,Tam ) )
		Write( 06, 00, Linha5(Tam))
		Write( 07, 00, "CODIGO COD FABRICANT  DESCRICAO DO PRODUTO                     UN EMB   ESTOQUE")
		Write( 08, 00, Linha5(Tam))
		Col := 9
		Qout( NG + Pagar->(Padr( Codi + " " + cNome, Tam,"Ä")) + NR)
		Col++
	EndIF
	IF lNovo
		lNovo := FALSO
		IF Col != 10
			Qout("")
			Qout( NG + Pagar->(Padr( Codi + " " + cNome, Tam,"Ä")) + NR)
			Col += 2
		EndIF
	EndIF
	Qout( Lista->Codigo, Lista->N_Original, Lista->Descricao, Lista->Un, Lista->Emb, Lista->Quant )
	Col++
	Lista->(DbSkip(1))
	IF Lista->Codi != cCodi
		cCodi := Lista->Codi
		lNovo := OK
	EndIF
	IF Col >= 58
		Write( Col, 0, Repl( SEP, Tam ))
		__Eject()
	EndIF
EndDo
__Eject()
FPrint( _CPI10 )
PrintOff()
DbClearFilter()
ResTela( cScreen )
Return

Proc EstoForIndividual()
************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aArray	  := {}
LOCAL aMenuArray := { " Codigo ", " Descricao " }
LOCAL Tam		  := CPI1280
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL cCodiFor   := Space( 04 )
LOCAL cSigla	  := Space( 10 )
LOCAL lSair 	  := FALSO
LOCAL oBloco

WHILE OK
	cCodiFor := Space( 04 )
	cSigla	:= Space( 10 )
	MaBox( 11, 01, 13, 61 )
	@ 12, 02 Say "Fornecedor..:" Get cCodiFor Pict "9999" Valid Pagarrado( @cCodiFor, Row(), Col()+1, @cSigla )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Area("Lista")
	Lista->(Order( LISTA_CODI ))
	IF !DbSeek( cCodiFor )
		Nada()
		ResTela( cScreen )
		Loop
	EndIF
	cFornecedor := cSigla
	cTela 		:= Mensagem("Aguarde, Localizando Registros. ESC Cancela.", Cor())
	oBloco		:= {|| Lista->Codi = cCodiFor }
	aArray		:= {}
	While Eval( oBloco ) .AND. Rel_Ok()
		Aadd( aArray, { Lista->Codigo, Lista->N_Original, Lista->Descricao, Lista->Un, Lista->Emb, Lista->Quant } )
		Lista->(DbSkip(1))
	EndDo
	ResTela( cTela )
	IF (nTamArray := Len( aArray )) > 0 	  // Processar
		M_Title("IMPRIMIR")
		nOpcao := FazMenu( 16, 54, aMenuArray )
		IF nOpcao = 0
			ResTela( cScreen )
			Loop
		ElseIf nOpcao = 1 // Por Codigo
			cTela := Mensagem("Aguarde, Ordenando Por Codigo.", WARNING )
			Asort( aArray,,, {| x, y | y[ 1 ] > x[ 1 ] } )
		Else
			cTela := Mensagem("Aguarde, Ordenando Por Descricao.", WARNING )
			Asort( aArray,,, {| x, y | y[ 3 ] > x[ 3 ] } )
		EndIF
		ResTela( cTela )
		IF !Instru80()
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Imprimindo.  ESC Cancela", WARNING )
		Tam			:= CPI1280
		Col			:= 58
		Pagina		:= 0
		lSair 		:= FALSO
		cFornecedor := Trim( cFornecedor )
		Relato		:= "RELATORIO DE ESTOQUE DO FORNECEDOR &cFornecedor"
		PrintOn()
		FPrint( _CPI12)
		SetPrc( 0, 0 )
		For nX := 1 To nTamArray
			IF Col >=  57
				Write( 01, 00, Linha1( Tam, @Pagina))
				Write( 02, 00, Linha2())
				Write( 03, 00, Linha3(Tam))
				Write( 04, 00, Linha4(Tam, SISTEM_NA2 ))
				Write( 05, 00, Padc( Relato ,Tam ) )
				Write( 06, 00, Linha5(Tam))
				Write( 07, 00, "CODIGO       COD FAB          DESCRICAO DO PRODUTO                     UN    EMB   ESTOQUE")
				Write( 08, 00, Linha5(Tam))
				Col := 9
			EndIF
			Qout( aArray[nX,1], Space(6), aArray[nX,2], aArray[nX,3], aArray[nX,4], aArray[nX,5], aArray[nX,6] )
			Col++
			IF Col >= 57 .OR. nX = nTamArray
				Write( Col, 0, Repl( SEP, Tam ))
				Qout("**** ITENS LISTADOS **** ", Tran( nX, "9999"))
				__Eject()
			EndIF
		Next nX
	EndIF
	FPrint( _CPI10 )
	PrintOff()
	ResTela( cScreen )
EndDo

Proc EstoqueDia()
*****************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Video", "Impressora" }
LOCAL nChoice	  := 0
LOCAL aProc 	  := { {|| VideoDia() }, {|| ImpreDia() }}

M_Title("ESTOQUE DIARIO")
nChoice := FazMenu( 13, 10, aMenuArray, Cor())
IF nChoice != 0
	Eval( aProc[ nChoice ] )
EndIF
ResTela( cScreen )

Proc VideoDia()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL lSair   := FALSO
LOCAL aArray  := {}
LOCAL cTela

Area("Lista")
Lista->(Order( LISTA_DATA ))
DbGoTop()
MaBox( 19, 10, 21, 36 )
dData := Date()
@ 20, 11 Say "Data...........:" Get dData Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
DbSeek( dData )
cTela := Mensagem(" Aguarde, Filtrando Registros.")
While Lista->Data = dData .AND. Rel_Ok()
	Aadd( aArray, Lista->Codigo + "  " + Lista->(Ponto( Descricao,40)) + " " + Lista->Sigla + " " + ;
					  Lista->Un + " " + Lista->(Str(Emb,3)) + " " + Lista->(Str(Quant,9,2)))
	DbSkip()
EndDo
ResTela( cTela )
IF (nTamArray := Len( aArray )) > 0 	  // Processar
	UnClock12()
	oMenu:Limpa()
	Print( 00,00, "CODIGO  DESCRICAO DO PRODUTO                     SIGLA      UN EMB     QUANT    ", Roloc(Cor()))
	M_Title( "ESC Retorna ")
	Mx_Choice( 01, 00, 24, 79, aArray, Cor())
	Write( 00, 72, Clock12( 00, 72, Cor()))
Else
	Alerta("Erro: Nenhum Produto saiu neste dia.")
EndIF
ResTela( cScreen )
Return

Proc ImpreDia()
***************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL lSair 	  := FALSO
LOCAL aArray	  := {}
LOCAL aMenuArray := { "Codigo", "Descricao" }
LOCAL nTamArray  := 0
LOCAL Tam		  := CPI1280
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL Relato	  := "RELATORIO DO ESTOQUE ATUAL DAS SAIDAS ENTRE "
LOCAL dIni		  := Date()
LOCAL dFim		  := Date()
LOCAL nQtdDoc	  := 0
LOCAL oBloco
LOCAL cTela


MaBox( 19, 10, 22, 36 )
@ 20, 11 Say "Data Inicial...:" Get dIni Pict PIC_DATA
@ 21, 11 Say "Data Final.....:" Get dFim Pict PIC_DATA Valid dFim >= dIni
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
Relato += Dtoc( dIni ) + " A " + Dtoc( dFim )
Area("Lista")
Lista->(Order( LISTA_DATA ))
Set Soft On
Lista->(DbSeek( dIni ))
Set Soft Off
cTela  := Mensagem("Aguarde, Filtrando Registros.", Cor())
oBloco := {|| Lista->Data >= dIni .AND. Lista->Data <= dFim }
While Eval( oBloco ) .AND. Rel_Ok()
	Aadd( aArray, { Lista->Codigo, Lista->N_Original, Lista->Descricao, Lista->Un, Lista->Quant } )
	Lista->(DbSkip(1))
EndDo
ResTela( cTela )
IF ( nTamArray := Len( aArray )) = 0
	Nada()
	ResTela( cScreen )
	Return
EndIF
M_Title("IMPRIMIR")
nOpcao := FazMenu( 17, 37, aMenuArray )
IF nOpcao = 0
	ResTela( cScreen )
	Return
ElseIf nOpcao = 1 // Por Codigo
	 cTela := Mensagem(" Aguarde... Ordenando Por Codigo... ", WARNING )
	 Asort( aArray,,, {| x, y | y[1] > x[1] } )
Else
	 cTela := Mensagem(" Aguarde... Ordenando Por Descricao... ", WARNING )
	 Asort( aArray,,, {| x, y | y[3] > x[3] } )
EndIF
ResTela( cTela )
IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( _CPI12)
SetPrc( 0, 0 )
For nX := 1 To nTamArray
	IF Col >=  57
		Write( 01, 00, Linha1( Tam, @Pagina))
		Write( 02, 00, Linha2())
		Write( 03, 00, Linha3(Tam))
		Write( 04, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 05, 00, Padc( Relato ,Tam ) )
		Write( 06, 00, Linha5(Tam))
		Write( 07, 00, "CODIGO       COD FABR         DESCRICAO DO PRODUTO                     UN        ESTOQUE")
		Write( 08, 00, Linha5(Tam))
		Col := 9
	EndIF
	Qout( aArray[nX,1], Space(6), aArray[nX,2], aArray[nX,3], aArray[nX,4], Space(04), aArray[nX,5])
	Col++
	IF Col >= 57 .OR. nX = nTamArray
		Write( Col, 0, Repl( SEP,Tam ))
		Qout("*** ITENS LISTADOS *** ", Tran( nX, "9999"))
		__Eject()
	EndIF
Next nX
PrintOff()
ResTela( cScreen )
Return

Proc EntSaiEstoque()
********************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 0
LOCAL aStru
LOCAL cDeleteFile
LOCAL xNtx

BEGIN
	cCodigo := 0
	dIni	  := Date() - 30
	dFim	  := Date()
	MaBox( 10, 10, 14, 70, "ROL ENT/SAI PRODUTO")
	@ 11, 11 Say "Codigo...: " Get cCodigo Pict PIC_LISTA_CODIGO Valid CodiMov( @cCodigo, Row(), Col()+1 )
	@ 12, 11 Say "Data Ini.: " Get dIni Pict PIC_DATA
	@ 13, 11 Say "Data Fim.: " Get dFim Pict PIC_DATA
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	lResumido := Conf("Pergunta: Imprimir somente resumo ?")
	Lista->(Order( LISTA_CODIGO ))
	Receber->(Order( RECEBER_CODI ))
	nTotalEntrada := 0
	nTotalSaida   := 0
	cTela1		  := SaveScreen()
	nEstoAtual	  := Lista->Quant
	cDescricao	  := Lista->Descricao
	bBloco		  := {|| Saidas->Codigo = cCodigo }
	cDeleteFile   := FTempName()
	xNtx			  := FTempName()
	aStru 		  := Saidas->(DbStruct())
	Aadd( aStru, {"ENTRADA",  "N", 09, 2 })
	Aadd( aStru, {"NOME",     "C", 40, 0 })
	Aadd( aStru, {"TOTAL",    "N", 13, 2 })
	DbCreate( cDeleteFile, aStru )
	Use (cDeleteFile) Alias xTemp Exclusive New
	Area("Saidas")
	Saidas->(Order( SAIDAS_CODIGO ))
	IF Saidas->(DbSeek( cCodigo ))
		Set Rela To Saidas->Codigo Into Lista, Saidas->Codi Into Receber
		Mensagem("Aguarde, Filtrando.", Cor())
		WHILE Eval( bBloco )
			xTemp->(DbAppend())
			xTemp->Codigo	 := Saidas->Codigo
			xTemp->Data 	 := Saidas->Data
			xTemp->Fatura	 := Saidas->Fatura
			xTemp->Saida	 := Saidas->Saida
			xTemp->CodiVen  := Saidas->CodiVen
			xTemp->Nome 	 := Receber->Nome
			xTemp->Pvendido := Saidas->Pvendido
			xTemp->Total	 := Saidas->Pvendido * Saidas->Saida
			Saidas->(DbSkip(1))
		Enddo
	EndIF
	Saidas->(DbClearRel())
	Saidas->(DbGotop())
	bBloco := {|| Entradas->Codigo = cCodigo }
	Pagar->(Order( PAGAR_CODI ))
	Area("Entradas")
	Entradas->(Order( ENTRADAS_CODIGO ))
	IF Entradas->(DbSeek( cCodigo ))
		Set Rela To Codi Into Pagar
		WHILE Eval( bBloco )
			xTemp->(DbAppend())
			xTemp->Codigo	 := Entradas->Codigo
			xTemp->Data 	 := Entradas->Data
			xTemp->Fatura	 := Entradas->Fatura
			xTemp->Entrada  := Entradas->Entrada
			xTemp->Nome 	 := Pagar->Nome
			xTemp->Pcusto	 := Entradas->PCusto
			xTemp->Total	 := Entradas->PCusto * Entradas->Entrada
			Entradas->(DbSkip(1))
		Enddo
	EndIF
	Entradas->(DbClearRel())
	Entradas->(DbGoTop())
	Area('xTemp')
	IF xTemp->(!Eof())
		Inde On xTemp->Data To ( xNtx )
		nSaida	:= 0
		nEntrada := 0
		nSaldo	:= 0
		nSomaEnt := 0
		nSomaSai := 0
		xTemp->(DbGoTop())
		While xTemp->(!Eof())
			nEntrada += xTemp->Entrada
			nSaida	+= xTemp->Saida
			xTemp->(DbSkip(1))
		EndDO
		nEstoAnterior := ( nEstoAtual + nSaida ) - nEntrada
		nSaldo		  := nEstoAnterior
		Tam			  := 132
		Col			  := 58
		Pagina		  := 0
		nContador	  := 0
		lSair 		  := FALSO
		nCredito 	  := 0
		nDebito		  := 0
		IF !Instru80()
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Ferase( xNtx )
			ResTela( cScreen )
			Loop
		EndIF
		ResTela( cTela1 )
		Mensagem("Aguarde, Imprimindo.")
		PrintOn()
		FPrint( PQ )
		SetPrc( 0, 0 )
		xTemp->(DbGoTop())
		While xTemp->(!Eof())
			IF Col >= 58
				Write( 00, 00, Linha1( Tam, @Pagina))
				Write( 01, 00, Linha2())
				Write( 02, 00, Linha3(Tam))
				Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
				Write( 04, 00, Padc( "RELATORIO DE ENTRADA E SAIDA DE PRODUTO NO PERIODO DE " + Dtoc( dIni ) + " A " + Dtoc( dFim ), Tam ))
				Write( 05, 00, Linha5(Tam))
				Write( 06, 00, "DATA     DOCTO N§  DESTINATARIO/PROCEDENCIA                      ENT      SAI      SALDO VEND  CUSTO/VENDA        TOTAL")
				Write( 07, 00, Linha5(Tam))
				Col := 8
			EndIF
			nSaldo	+= xTemp->Entrada
			nSaldo	-= xTemp->Saida
			nCredito += xTemp->Entrada
			nDebito	-= xTemp->Saida
			IF xTemp->Data >= dIni .AND. xTemp->Data <= dFim
				IF Col = 8
					nAnterior := ( nEstoAnterior + nCredito ) - nDebito
					nAnterior += xTemp->Saida - xTemp->Entrada
					Write( Col, 00, NG + xTemp->Codigo + " " + cDescricao + NR )
					Col += 2
					Write( Col, 00, "Saldo Anterior" + Space(65) + Tran( nAnterior, "999999.99"))
				EndIF
				IF !lResumido
					IF xTemp->Pvendido = 0
						nPreco := xTemp->Pcusto
					Else
						nPreco := xTemp->Pvendido
					EndIF
					Qout( xTemp->Data, xTemp->Fatura, xTemp->Nome,;
							Tran( xTemp->Entrada, '99999.99'),;
							Tran( xTemp->Saida,	 '99999.99'),;
							Tran( nSaldo,		  '9999999.99'),;
							xTemp->Codiven,;
							Tran( nPreco,		  '999999999.99'),;
							Tran( xTemp->Total, '999999999.99'))
							Col++
				EndIF
				nContador++
				nTotalEntrada += xTemp->Entrada * xTemp->PCusto
				nTotalSaida   += xTemp->Saida   * xTemp->PVendido
				UltimoSaldo   := nSaldo
				nSomaEnt 	  += xTemp->Entrada
				nSomaSai 	  += xTemp->Saida
				nEstoqueAnt   := UltimoSaldo + nSomaSai - nSomaEnt
			EndIF
			IF Col >= 58
				Col++
				Write( Col, 0,  Repl( SEP, Tam ))
				__Eject()
			EndIF
			xTemp->(DbSkip(1))
		EndDo
		IF nContador != 0
			Write( (Col += 2), 0, "(+) Saldo Estoque Anterior " + Space( 32 ) + Tran( nEstoqueAnt, "999999.99") )
			Write( (++Col), 0,	 "(+) Entradas de Estoque    " + Space( 32 ) + Tran( nSomaEnt,    "999999.99") + " = TOTAL R$ : " + Tran( nTotalEntrada,    "@E 99,999,999.99"))
			Write( (++Col), 0,	 "(-) Saidas de Estoque      " + Space( 32 ) + Tran( nSomaSai,    "999999.99") + " = TOTAL R$ : " + Tran( nTotalSaida,      "@E 99,999,999.99"))
			Write( (++Col), 0,	 "(=) Saldo                  " + Space( 32 ) + Tran( UltimoSaldo, "999999.99") )
			Write( (Col += 2), 0, "(*) Saldo Em Estoque Atual " + Space( 32 ) + Tran( nSaldo,      "999999.99") )
			__Eject()
		EndIF
		PrintOff()
		ResTela( cTela1 )
	EndIF
	xTemp->(DbCloseArea())
	Ferase( cDeleteFile )
	Ferase( xNtx )
EndDo

Proc LisConver()
****************
LOCAL cScreen := SaveScreen( )
oMenu:Limpa()
ErrorBeep()
IF Alert( "Este Utilitario convertera os valores de Pr.Custo," +;
			 ";Pr.Venda, Atacado, Varejo dividindo-os           " +;
			 ";por mil sem arredondamento. "+;
			 ";;Continua com a Operacao ?", {" Sim ", " Nao "} ) = SIM

	Mensagem( "Aguarde... Convertendo. ", WARNING )
	Area("Lista")
	DbGoTop()
	IF Lista->(TravaArq())
		WHILE !Eof()
			_Field->Atacado  := ( Atacado / MIL )
			_Field->Pcusto   := ( Pcusto	/ MIL )
			_Field->Varejo   := ( Varejo	/ MIL )
			DbSkip()
		EndDo
		Lista->(Libera())
		ErrorBeep()
		oMenu:Limpa()
		Alerta( "Operacao Realizada com Sucesso...")
	EndIF
Else
	ErrorBeep()
	Alerta("Erro: Operacao Cancelada ... ")
EndIF
ResTela( cScreen )
Return

Proc LisTela()
***************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray	:= { " Pre‡o Varejo     ", " Pre‡o Atacado    ", " Pre‡o Custo  " }
LOCAL aTodos	  := {}
LOCAL nChoic	  := 0
LOCAL nContador  := 0
LOCAL lExibir	  := OK
LOCAL cTela

M_Title( "ESC Retorna" )
nChoice := FazMenu( 10, 35, aMenuArray, Cor())
IF nChoice = 0
	ResTela( cScreen )
	Return
EndIF
oMenu:Limpa()
WHILE !Eof() .AND. Rep_Ok()
	nContador++
	cTela := Mensagem(" Aguarde... Incluindo Registro n§ " + StrZero( nContador, 5), Cor())
	IF nChoice = 1
		Var := Varejo
	ElseIf nChoice = 2
		Var := Atacado
	ElseIf nChoice = 3
		Var := Pcusto
	EndIF
	IF nContador > 2048 // Tamanho Maximo Array
		ResTela( cTela )
		ErrorBeep()
		Alerta("Erro: Lista muito grande para exibir...;Use a Tecla F5 para visualizar.")
		Exit
	EndIF
	Aadd( aTodos, Codigo + "  " + Ponto( Descricao,40) + " " +;
					  Tran( Quant, "99999.99") + " " + Tran( Var, "@E 99,999,999,999.99"))
	Dbskip()
EndDo
IF lExibir
	ResTela( cTela )
	ExibeLista( aTodos )
EndIF
ResTela( cScreen )
Return

Proc ExibeLista( aTodos )
*************************
Print( 00,00, "CODIGO DESCRICAO DO PRODUTO                      QUANT             PRECO VENDA", Roloc(Cor()))
Mx_Choice( 01, 00, 24, 79, aTodos, Cor())
Return

Proc PedidoImprime()
********************
LOCAL cScreen := SaveScreen()
LOCAL TotGeral := 0
LOCAL SubTotal := 0
LOCAL Pagina	:= 0
LOCAL Lista 	:= SISTEM_NA2
LOCAL Titulo	:= "MERCADORIAS COM ESTOQUE ABAIXO DO MINIMO"
LOCAL Tam		:= CPI12132
LOCAL Col		:= 60
LOCAL lSair 	:= FALSO

IF !Instruim()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Informa: Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( _SALTOOFF ) // Inibe Salto de Picote
FPrint( _CPI12)
FPrint( PQ )
SetPrc( 0, 0 )
WHILE ! Eof() .AND. REL_OK()
	IF Col >= 60
		Cabec007( ++Pagina, Lista, Titulo, Tam )
		Col := 8
	 EndIF
	 nFalta := Qmin - (Quant+Pedido)
    Qout( Codigo, N_Original, Ponto( Left( Descricao,30),30), Un, Pcompra, Pcusto,;
			 Quant, Qmin, Qmin, Qmax, nFalta, Tran((Pcusto * nFalta), "@E 99,999,999,999.99"))
	 Col++
	 TotGeral += (Pcusto * nFalta)
	 SubTotal += (Pcusto * nFalta)
	 DbSkip()
	 IF Col >= 60
		 Write(++Col, 000, "** Sub Total Pedido **" )
		 Write(	Col, 134, Tran( SubTotal,"@E 99,999,999,999.99" ) )
		 SubTotal := 0
		 __Eject()
	 EndIF
EndDo
Write(++CoL, 000, "** Sub Total Pedido **" )
Write(  Col, 134, Tran( SubTotal,"@E 99,999,999,999.99" ) )
Write(++Col, 000, "** Total Pedido **" )
Write(  Col, 134, Tran( TotGeral,"@E 99,999,999,999.99" ) )
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc Cabec007( Pagina, Lista, Titulo, Tam )
*******************************************
Write( 00, 00, Padr( "Pagina N§ " + StrZero( Pagina, 4 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 00, Dtoc( Date() ) )
Write( 02, 00, Padc( XNOMEFIR, Tam ))
Write( 03, 00, Padc( Lista, Tam ))
Write( 04, 00, Padc( Titulo, Tam))
Write( 05, 00, Repl( SEP, Tam))
Write( 06, 00, "CODIGO  COD. FABR.    DESCRICAO DO PRODUTO           UN    P COMPRA     P_CUSTO   ESTOQUE    PEDIDO     Q.MIN     Q.MAX      QT.PEDIR      VALOR PEDIDO")
Write( 07, 000, Repl( SEP, Tam ))
Return


Proc SetaTaxas( lEncontrou, nTaxa, nJurAta, nJurVar )
*****************************************************
IF lEncontrou
	nTaxa   := Taxas->TxAtu / 100
	nJurAta := Taxas->JurAta
	nJurVar := Taxas->JurVar
Else
	nTaxa := nJurAta := nJurVar := 0
EndIF
Return

Proc MudaFor()
**************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodiIni := 0
LOCAL cCodiFim := 0
LOCAL cCodi 	:= Space(4)
LOCAL oBloco
LOCAL cTela
LOCAL cSigla
LOCAL cCodigo := ""

Area("Entradas")
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
MaBox( 10, 00, 14, 72 )
WHILE OK
	cSigla := Space(10)
	@ 11, 01 Say "Fornecedor.....: " Get cCodi    Pict "9999" Valid Pagarrado( @cCodi, 11, 31,@cSigla )
	@ 12, 01 Say "Codigo Inicial.: " Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiIni, @cCodiFim )
	@ 13, 01 Say "Codigo Final...: " Get cCodiFim Pict PIC_LISTA_CODIGO Valid CodiErrado( @cCodiFim,,OK )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Entradas->(Order( ENTRADAS_CODIGO ))
	oBloco := {|| Lista->Codigo >= cCodiIni .AND. Lista->Codigo <= cCodiFim }
	IF Lista->(DbSeek( cCodiIni ))
		cTela := Mensagem("Aguarde, Modificando Fornecedor.", Cor())
		IF Lista->(TravaArq())
			WHILE Eval( oBloco )
				cCodigo		 := Lista->Codigo
				Lista->Codi  := cCodi
				Lista->Sigla := cSigla
				MudaForEntradas( cCodigo, cCodi )
				Lista->(DbSkip(1))
			EndDo
			Lista->(Libera())
		EndIF
		ResTela( cTela )
	EndIF
EndDo

Proc MudaForEntradas( cCodigo, cCodi )
**************************************
LOCAL oBloco := {|| Entradas->Codigo = cCodigo }

IF Entradas->(DbSeek( cCodigo ))
	IF Entradas->(TravaArq())
		WHILE Eval( oBloco )
			Entradas->Codi := cCodi
			Entradas->(DbSkip(1))
		EndDo
		Entradas->(Libera())
	EndIF
EndIF
Return

Proc MudaRepres()
*****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(04)
LOCAL cRepres	:= Space(04)
LOCAL oBloco
LOCAL cTela

WHILE OK
	MaBox( 10, 00, 13, 72 )
	@ 11, 01 Say "Fornecedor.....: " Get cCodi    Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
	@ 12, 01 Say "Representante..: " Get cRepres  Pict "9999" Valid Represrrado( @cRepres, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Lista->(Order( LISTA_CODI ))
	oBloco := {|| Lista->Codi = cCodi }
	IF Lista->(DbSeek( cCodi ))
		IF Lista->(TravaArq())
			Mensagem(" Aguarde, Modificando Representante.", Cor())
			WHILE Eval( oBloco )
				Lista->Repres := cRepres
				Lista->(DbSkip(1))
			EndDo
			Lista->(Libera())
			ResTela( cScreen )
		EndIF
	Else
		Nada()
	EndIF
EndDo

Proc PrnPedidos( nIndice )
**************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= CPI1280
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL nCampos		:= 0
LOCAL nT 			:= 0
LOCAL cRelato		:= ""
LOCAL xFile 		:= ""
LOCAL cTitulo		:= ""
LOCAL aGets 		:= {}
LOCAL aLinha		:= {}
LOCAL lCondensado := FALSO
LOCAL l12Cpi		:= FALSO
LOCAL lCompreco	:= FALSO
LOCAL lUsa			:= FALSO
LOCAL xString		:= ""
LOCAL cGet			:= ""
LOCAL dData
LOCAL oLista
LOCAL n
LOCAL nVarejo
FIELD Varejo

MaBox( 14, 56, 16, 79 )
dData := Date()
@ 15, 57 Say "Validade... " Get dData Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
lComPreco := Conf("Imprimir somente produtos que tenham Preco ?")
lUsa		 := Conf("Imprimir produtos marcados ?")
xFile 	 := LerArqLista()
IF xFile = NIL
	ResTela( cScreen )
	Return
EndIF
oLista		:= TIniNew( xFile )
lCondensado := oLista:ReadBool("configuracao","imprimircondensado", FALSO )
l12Cpi		:= oLista:ReadBool("configuracao","imprimir12cpi", FALSO )
nCampos		:= oLista:ReadInteger("configuracao","campos", 0 )
cRelato		:= oLista:ReadString("cabecalho","relatorio", 0 )
cTitulo		:= oLista:ReadString("cabecalho","titulo", 0 )
For n := 1 To nCampos
  cGet := oLista:ReadString("campos",  "campo" + AllTrim(Str(n, 3)))
  IF !Empty(cGet)
	  Aadd( aGets, cGet )
  EndIF
Next
nCampos := Len( aGets )
aLinha := Array( nCampos )
IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
IF lCondensado
  Tam := 132
  xString := PQ
Else
	IF l12Cpi
	  Tam := CPI1280
	  xString := _CPI12
	EndIF
EndIF
IF Tam = 0
	Tam := 80
EndIF
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
FPrint( xString )
SetPrc( 0, 0 )
WHILE !Eof() .AND. REL_OK()
	IF Col >= 56
		CabecPedido( cTitulo, ++Pagina, Tam )
		Col := IF( Pagina >= 2, 4, 10 )
	EndIF
	For n := 1 To nCampos
	  cVar		:= aGets[n]
	  aLinha[n] := ""
	  aLinha[n] := eval({||&cVar})
	Next
	nVarejo := Varejo
	IF !lUsa
		IF Usa
			DbSkip(1)
			Loop
		EndIF
	EndIF
	IF lComPreco
		IF !Empty( nVarejo )
			For n := 1 To nCampos
			  IF n = 1
				  Qout( aLinha[n],"")
			  Else
				  QQout( aLinha[n],"")
			  EndIF
			Next
			Col++
			nT++
		EndIF
	Else
		For n := 1 To nCampos
			IF n = 1
				Qout( aLinha[n],"")
			Else
				QQout( aLinha[n],"")
			EndIF
		Next
		Col++
		nT++
	EndIF
	DbSkip()
	IF Col >= 56 .OR. Eof()
		Write( Col, 0, Repl( SEP, Tam ))
		Qout("*** ITENS LISTADOS *** ", Tran( nT, "9999"), Space(10), "VALIDA ATE ", DataExt1( dData ))
		__Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc CabecPedido( cTitulo, Pagina, Tam )
****************************************
IF Pagina = 1
	#IFDEF CICLO
		Write(00,00, NG + "===C I C L O    C A I R U=== | P E D I D O        DATA____/____/_____         Pagina N§ " + StrZero( Pagina, 3 ) + NR )
		Write(01,00, NG + "---------------------------- | Cliente:___________________________________________C¢d._____" + NR )
		Write(02,00, NG + "Fone:   0800-99-5252         | Endere‡o:___________________________N§______Fone:___________" + NR )
		Write(03,00, NG + "Fone: (069) 451-3922         | Munic¡pio:___________________________________Estado:________" + NR )
		Write(04,00, NG + "Fax : (069) 451-2367         | C.G.G.:________.__________.__________/____________-_________" + NR )
		Write(05,00, NG + "Pimenta Bueno - Rond“nia     | Inscri‡„o Estadual:_________________________________________" + NR )
	#ELSE
		Write(00,00, NG + Padc( XNOMEFIR, Tam ) + NR )
		Write(01,00, NG + "P E D I D O  | P E D I D O   | P E D I D O        DATA____/____/_____         Pagina N§ " + StrZero( Pagina, 3 ) + NR )
		Write(02,00, NG + "Cliente..._____________________________________________________________________Cod.________" + NR )
		Write(03,00, NG + "Endereco..:_____________________________________________________N§________Fone:____________" + NR )
		Write(04,00, NG + "Cidade....:_________________________________________________________________Estado:________" + NR )
		Write(05,00, NG + "C.G.G.....:_____.__________.__________/__________-_____ I.Estadual:________________________" + NR )
	#ENDIF
	Write(06,00, Repl("-", Tam))
	Write(07,00, cTitulo )
	Write(08,00, Repl("-", Tam))
Else
	Write(00, 00, Padr( "Pagina N§ " + StrZero( Pagina,3 ), ( Tam/2 ) ) + Padl( Dtoc(Date()), ( Tam/2 )))
	Write(01, 00, Repl("-", Tam))
	Write(02, 00, cTitulo )
	Write(03, 00, Repl("-", Tam))
EndIF
Return

Proc PrnNormal( nIndice )
*************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= CPI1280
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL nCampos		:= 0
LOCAL nT 			:= 0
LOCAL cRelato		:= ""
LOCAL xFile 		:= ""
LOCAL cTitulo		:= ""
LOCAL aGets 		:= {}
LOCAL aLinha		:= {}
LOCAL lCondensado := FALSO
LOCAL l12Cpi		:= FALSO
LOCAL lCompreco	:= FALSO
LOCAL lUsa			:= FALSO
LOCAL xString		:= ""
LOCAL cGet			:= ""
LOCAL oLista
LOCAL n
LOCAL nVarejo
FIELD Varejo

lComPreco := Conf("Imprimir somente produtos que tenham Preco ?")
lUsa		 := Conf("Imprimir produtos marcados ?")
xFile 	 := LerArqLista()
IF xFile = NIL
	ResTela( cScreen )
	Return
EndIF
oLista		:= TIniNew( xFile )
lCondensado := oLista:ReadBool("configuracao","imprimircondensado", FALSO )
l12Cpi		:= oLista:ReadBool("configuracao","imprimir12cpi", FALSO )
nCampos		:= oLista:ReadInteger("configuracao","campos", 0 )
cRelato		:= oLista:ReadString("cabecalho","relatorio", 0 )
cTitulo		:= oLista:ReadString("cabecalho","titulo", 0 )
For n := 1 To nCampos
  cGet := oLista:ReadString("campos",  "campo" + AllTrim(Str(n, 3)))
  IF !Empty(cGet)
	  Aadd( aGets, cGet )
  EndIF
Next
nCampos := Len( aGets )
aLinha := Array( nCampos )

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
IF lCondensado
  Tam := 132
  xString := PQ
Else
	IF l12Cpi
	  Tam := CPI1280
	  xString := _CPI12
	EndIF
EndIF
IF Tam = 0
	Tam := 80
EndIF
nT := 0
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
FPrint( xString )
SetPrc( 0, 0 )
WHILE !Eof() .AND. REL_OK()
	IF Col >= 56
		Write( 00, 00, Linha1(Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( cRelato, Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, cTitulo )
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	For n := 1 To nCampos
	  cVar		:= aGets[n]
	  aLinha[n] := ""
	  aLinha[n] := eval({||&cVar})
	Next
	nVarejo := Varejo
	IF !lUsa
		IF Usa
			DbSkip(1)
			Loop
		EndIF
	EndIF
	IF lComPreco
		IF !Empty( nVarejo )
			For n := 1 To nCampos
			  IF n = 1
				  Qout( aLinha[n],"")
			  Else
				  QQout( aLinha[n],"")
			  EndIF
			Next
			Col++
			nT++
		EndIF
	Else
		For n := 1 To nCampos
			IF n = 1
				Qout( aLinha[n],"")
			Else
				QQout( aLinha[n],"")
			EndIF
		Next
		Col++
		nT++
	EndIF
	DbSkip()
	IF Col >= 56 .OR. Eof()
		Write( Col, 0, Repl( SEP, Tam ))
		Qout("*** ITENS LISTADOS *** ", Tran( nT, "9999"))
		__Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc PrnGrupo()
***************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= CPI1280
LOCAL Col			:= 58
LOCAL Pagina		:= 0
LOCAL nCampos		:= 0
LOCAL nT 			:= 0
LOCAL cRelato		:= ""
LOCAL xFile 		:= ""
LOCAL cTitulo		:= ""
LOCAL aGets 		:= {}
LOCAL aLinha		:= {}
LOCAL lCondensado := FALSO
LOCAL l12Cpi		:= FALSO
LOCAL lCompreco	:= FALSO
LOCAL lUsa			:= FALSO
LOCAL xString		:= ""
LOCAL cGet			:= ""
LOCAL NovoGrupo
LOCAL NovosGrupo
LOCAL UltGrupo
LOCAL UltsGrupo
LOCAL n
LOCAL nVarejo
LOCAL oLista
LOCAL cVar
FIELD CodGrupo
FIELD CodsGrupo
FIELD Varejo

lComPreco := Conf("Imprimir somente produtos que tenham Preco ?")
lUsa		 := Conf("Imprimir produtos marcados ?")
xFile 	 := LerArqLista()
IF xFile = NIL
	ResTela( cScreen )
	Return
EndIF
oLista		:= TIniNew( xFile )
lCondensado := oLista:ReadBool("configuracao","imprimircondensado", FALSO )
l12Cpi		:= oLista:ReadBool("configuracao","imprimir12cpi", FALSO )
nCampos		:= oLista:ReadInteger("configuracao","campos", 0 )
cRelato		:= oLista:ReadString("cabecalho","relatorio", 0 )
cTitulo		:= oLista:ReadString("cabecalho","titulo", 0 )
For n := 1 To nCampos
  cGet := oLista:ReadString("campos",  "campo" + AllTrim(Str(n, 3)))
  IF !Empty(cGet)
	  Aadd( aGets, cGet )
  EndIF
Next
nCampos := Len( aGets )
aLinha := Array( nCampos )
IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Grupo->(Order( GRUPO_CODGRUPO ))
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
Set Rela To CodGrupo Into Grupo, CodSgrupo Into SubGrupo
nT 		  := 0
NovoGrupo  := OK
NovoSGrupo := OK
UltGrupo   := Grupo->DesGrupo
UltSGrupo  := SubGrupo->DesSGrupo
Mensagem( "Aguarde, Imprimindo.")
IF lCondensado
  Tam := 132
  xString := PQ
Else
	IF l12Cpi
	  Tam := CPI1280
	  xString := _CPI12
	EndIF
EndIF
IF Tam = 0
	Tam := 80
EndIF
PrintOn()
FPrint( xString )
SetPrc( 0, 0 )
WHILE !Eof() .AND. REL_OK()
	IF Col >= 56
		Write( 00, 00, Linha1(Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( cRelato, Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, cTitulo )
		Write( 07, 00, Linha5(Tam))
		Col := 8
		Write( Col, 00, NG + CodGrupo  + ": " + Grupo->DesGrupo + NR )
		Col++
		Write( Col, 10, NG + CodSgrupo + ": " + SubGrupo->DesSGrupo + NR )
		Col++
		NovoGrupo  := FALSO
		NovoSGrupo := FALSO
	EndIF
	IF NovoGrupo
		NovoGrupo := FALSO
		Write( Col, 00, NG + CodGrupo + ": " + Grupo->DesGrupo + NR )
		Col++
	EndIF
	IF NovoSGrupo
		NovoSGrupo := FALSO
		Write( Col, 10,  NG + CodSgrupo + ": " + SubGrupo->DesSGrupo + NR )
		Col++
	EndIF
	For n := 1 To nCampos
	  cvar		:= aGets[n]
	  aLinha[n] := eval({||&cvar})
	Next
	nVarejo := Varejo
	IF !lUsa
		IF Usa
			DbSkip(1)
			Loop
		EndIF
	EndIF
	FPrint( xString )
	IF lComPreco
		IF !Empty( nVarejo )
			For n := 1 To nCampos
			  IF n = 1
				  Qout( aLinha[n],"")
			  Else
				  QQout( aLinha[n],"")
			  EndIF
			Next
			Col++
			nT++
		EndIF
	Else
		For n := 1 To nCampos
			IF n = 1
				Qout( aLinha[n],"")
			Else
				QQout( aLinha[n],"")
			EndIF
		Next
		Col++
		nT++
	EndIF
	UltGrupo  := Grupo->DesGrupo
	UltSGrupo := SubGrupo->DesSGrupo
	DbSkip()
	IF Col = 62 .OR. UltGrupo != Grupo->DesGrupo .OR. UltSGrupo != SubGrupo->DesSGrupo
		IF UltGrupo != Grupo->DesGrupo
			NovoGrupo := OK
			Col++
		EndIF
		IF UltSGrupo != SubGrupo->DesSGrupo
			NovoSGrupo := OK
			Col++
		EndIF
	EndIF
	IF Col >= 56
		__Eject()
	EndIF
EndDo
Qout("")
Qout( "REGISTROS LISTADOS : ", AllTrim(Str( nT)))
__Eject()
PrintOff()
DbClearRel()
ResTela( cScreen )
Return

Function LerArqLista()
**********************
LOCAL cScreen := SaveScreen()
LOCAL cFiles  := '*.LIS'
LOCAL aMenu   := { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Lista de Precos"}
LOCAL nChoice := 0

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
ErrorBeep()
WHILE OK
	oMenu:Limpa()
	M_Title("IMPRESSAO DE LISTA DE PRECOS")
	nChoice := FazMenu( 05, 10, aMenu, Cor())
	Do Case
	Case nChoice = 0
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ResTela( cScreen )
		Return( NIL )
	Case nChoice = 2
		GravaListaPreco()
		Loop
	Case nChoice = 3
		Edicao( OK, "*.LIS" )
		Loop
	EndCase
	IF !File( oAmbiente:xBaseDoc + '\' + cFiles )
		oMenu:Limpa()
		ErrorBeep()
		Alert("Erro: Arquivos de Lista de Precos nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .LIS")
		Loop
	EndIF
	oMenu:Limpa()
	M_Title( oAmbiente:xBaseDoc + '\*.LIS')
	xArquivo := Mx_PopFile( 05, 05, 20, 70, cFiles, Cor() )
	ResTela( cScreen )
	IF Empty( xArquivo )
		Loop
	EndIF
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return( oAmbiente:xBaseDoc + '\' + xArquivo )
EndDo

Procedure GravaListaPreco()
***************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL xFile   := "LISTA   "
LOCAL xExt	  := ".LIS   "
LOCAL oLista

FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
MaBox( 12, 10, 14, 76 )
@ 13, 11 Say "Entre com o nome do Arquivo ser criado (sem extensao)..:" Get xFile Pict "@!" Valid FileExist( xFile, xExt)
Read
IF LastKey() = ESC
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Return
EndIF
oLista  := TIniNew( xFile + xExt )
oLista:WriteBool("configuracao","imprimircondensado", FALSO )
oLista:WriteBool("configuracao","imprimir12cpi", OK )
oLista:WriteInteger("configuracao","campos", 6 )
oLista:WriteString("cabecalho","relatorio", "LISTA DE PRECOS")
oLista:WriteString("cabecalho","titulo","CODIGO COD. FABRIC.    DESCRICAO DO PRODUTO                     UN    EMB    P.VENDA")
oLista:WriteString("campos","campo1","CODIGO")
oLista:WriteString("campos","campo2","N_ORIGINAL")
oLista:WriteString("campos","campo3","PONTO(DESCRICAO,40)")
oLista:WriteString("campos","campo4","UN")
oLista:WriteString("campos","campo5","EMB")
oLista:WriteString("campos","campo6",'TRAN(VAREJO,"@E 999,999.99")')
oLista:Close()
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return

Function FileExist( xFile, xExt )
*********************************
IF File( xFile  + xExt )
	ErrorBeep()
	Return( Conf("Pergunta: Arquivo existente. Deseja regrava-lo ?"))
EndIF
Return( OK )

Proc RelaTaxas()
****************
LOCAL cScreen	:= SaveScreen()
LOCAL Tam		:= 80
LOCAL Col		:= 58
LOCAL Pagina	:= 0
LOCAL dDataIni := Date()
LOCAL dDataFim := Date() - 30

MaBox( 10, 10, 13, 43 )
@ 11, 11 Say "Data Inicial.......: " Get dDataIni Pict PIC_DATA
@ 12, 11 Say "Data Final.........: " Get dDataFim Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
Set Soft On
Taxas->(DbSeek( dDataIni ))
PrintOn()
SetPrc( 0, 0 )
WHILE Taxas->(!Eof()) .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "LISTAGEM DE INDEXADORES",Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "DATA     VALIDADE   TX ATU  TX JUR VAR  TX JUR ATA      UFIR     DOLAR R$" )
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	IF DFim >= dDataIni .AND. DFim <= dDataFim
		Qout( DIni, DFim, Space(1), TxAtu, Space(4), JurVar, Space(4),;
				JurAta, Space(1),Ufir, Tran( Cotacao,"@E 99,999,999.99"))
		Col++
	EndIF
	IF Col >= 58 .OR. Eof()
		Write( Col, 0,  Repl( SEP, Tam ))
		__Eject()
	EndIF
	Taxas->(DbSkip(1))
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc MostraTela( aTodos )
*************************
Print( 00,00, " CODIGO       DESCRICAO DO PRODUTO                      QUANT       PRECO VENDA ", Roloc(Cor()))
Mx_Choice( 01, 00, 24, 79, aTodos, Cor())
Return

Proc RelConfEntradas()
**********************
LOCAL cScreen	  := SaveScreen()
LOCAL cGetList   := {}
LOCAL cCodi 	  := Space(4)
LOCAL dIni		  := Date() - 30
LOCAL dFim		  := Date()
LOCAL Pagina	  := 0
LOCAL nTotal	  := 0
LOCAL nCredito   := 0
LOCAL Col		  := 11
LOCAL lPago 	  := FALSO
LOCAL cFatura

WHILE OK
	oMenu:Limpa()
	cCodi := Space(4)
	dIni	:= Date() - 30
	dFim	:= Date()
	MaBox( 10, 10, 14, 78 )
	@ 11, 11 Say "Fornecedor......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, 11, 34 )
	@ 12, 11 Say "Emissao Inicial.:" Get dIni  Pict PIC_DATA
	@ 13, 11 Say "Emissao Final...:" Get dFim  Pict PIC_DATA Valid dFim >= dIni
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Pagamov->(Order( PAGAMOV_CODI ))
	Pago->(Order( PAGO_CODI))
   Area("EntNota")
   EntNota->(Order( ENTNOTA_CODI ))
   IF EntNota->(!DbSeek( cCodi ))
		Nada()
		Loop
	EndIF
	Mensagem("Aguarde...", Cor(), 19 )
	IF !Instruim()
		ResTela( cScreen )
		Loop
	EndIF
	Mensagem("Aguarde, Processando." )
	PrintOn()
	FPrint(PQ)
	SetPrc(0,0)
	nTotal	:= 0
	nCredito := 0
	Pagar->(DbSeek( cCodi ))
	CabecEntradas( @Pagina, cCodi, dIni, dFim )
   WHILE EntNota->Codi = cCodi .AND. Rep_Ok()
      IF EntNota->Data >= dIni .AND. EntNota->Data <= dFim
         cFatura := EntNota->Numero
			IF Col >= 58
				__Eject()
				CabecEntradas( @Pagina, cCodi, dIni, dFim )
				Col := 11
			EndIF
			lPago := FALSO
         Qout( EntNota->Data, Space(9), EntNota->Numero,Space(7),;
               EntNota->Condicoes, EntNota->(Tran( VlrNFF,"@E 9,999,999,999.99")))
         nTotal  += EntNota->VlrNFF
			Col++
			Pagamov->(DbSeek( cCodi ))
			WHILE Pagamov->Codi = cCodi
				IF Pagamov->Fatura != cFatura
					Pagamov->(DbSkip(1))
					Loop
				EndIF
				IF Col >= 58
					__Eject()
					CabecEntradas( @Pagina, cCodi, dIni, dFim )
					Col := 11
				EndIF
				Qout( Space(7), Pagamov->Vcto, Pagamov->Docnr, Space(6), ;
						Pagamov->(Str( Vcto-Emis,4)), Space(19), ;
						Pagamov->(Tran(Vlr,"@E 9,999,999,999.99")))
				Col++
				Pagamov->(DbSkip(1))
			EndDo
			Pago->(DbSeek( cCodi ))
			WHILE Pago->Codi = cCodi
				IF Pago->Fatura != cFatura
					Pago->(DbSkip(1))
					Loop
				EndIF
				IF Col >= 58
					__Eject()
					CabecEntradas( @Pagina, cCodi, dIni, dFim )
					Col := 11
				EndIF
				nCredito += Pago->Vlr
				lPago := OK
				Qout( Space(7), Pago->Datapag, Pago->Docnr, Space(8),;
						Pago->(Str(Datapag-Vcto,4)), Space(34),;
						Pago->(Tran(Vlr,"@E 9,999,999,999.99")),;
						Pago->(Tran( VlrPag, "@E 9,999,999,999.99")))

				Col++
				Pago->(DbSkip(1))
			EndDo
			IF lPago
				Qqout( Tran(nTotal-nCredito,"@E 99,999,999,999.99"))
			Else
				Qqout( Space(33), Tran(nTotal-nCredito,"@E 99,999,999,999.99"))
			EndIF
		EndIF
      EntNota->(DbSkip(1))
	EndDo
	__Eject()
	PrintOff()
	ResTela( cScreen )
EndDo

Proc CabecEntradas( Pagina, cCodi, dIni, dFim )
***********************************************
LOCAL Tam := 132
Write( 00, 00, Linha1( Tam, @Pagina))
Write( 01, 00, Linha2())
Write( 02, 00, Linha3(Tam))
Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
Write( 04, 00, Padc( "RELATORIO DE CONFERENCIA DE NOTAS DE ENTRADAS REF. " + Dtoc( dIni ) + " A " + Dtoc( dFim ),Tam ))
Write( 05, 00, Linha5(Tam))
Write( 06, 00, NG + "FORNECEDOR: " + Pagar->Codi + " " + Pagar->Nome + " FONE: " + Pagar->Fone + NR )
Write( 07, 00, NG + "CGC/MF    : " + Pagar->Cgc  + " INSC.EST.: " + Pagar->Insc + " CIDADE: "  + Pagar->Cida + " ESTADO: " + Pagar->Esta + NR )
Write( 08, 00, Linha5(Tam))
Write( 09, 00, "EMISSAO VCTO/PG  N.FISCAL DOC.N§        PRAZO/ATRASO              DEBITO R$       CREDITO R$    VALOR PAGO R$         SALDO R$")
Write( 10, 00, Linha5(Tam))
Return

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
DbCloseAll()

IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("SAIDAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEBER")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("GRUPO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("SUBGRUPO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("ENTRADAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("TAXAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("NOTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CHEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CHEQUE")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CHEPRE")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECEBIDO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("VENDEMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("REGIAO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("PAGAR")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("PAGAMOV")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("PAGO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("FORMA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CEP")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("REPRES")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("ENTNOTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("PREVENDA")
	MensFecha()
	Return
EndIF
Return

Proc RelaDolar()
****************
LOCAL cScreen	:= SaveScreen()
LOCAL dDataIni := Date()
LOCAL dDataFim := Date() - 30
LOCAL nCop		:= 0
LOCAL Tam		:= 80
LOCAL Col		:= 58
LOCAL Pagina	:= 0

IF Taxas->(LastRec() = 0 )
	Nada()
	ResTela( cScreen )
	Return
EndIF
MaBox( 10, 10, 13, 43 )
@ 11, 11 Say "Data Inicial.......¯ " Get dDataIni Pict PIC_DATA
@ 12, 11 Say "Data Final.........¯ " Get dDataFim Pict PIC_DATA
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
Set Soft On
DbSeek( dDataIni )
Set Soft Off
Mensagem("Aguarde, Imprimindo." )
PrintOn()
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
  IF Col >= 58
	  Write( 00, 00, Linha1( Tam, @Pagina))
	  Write( 01, 00, Linha2())
	  Write( 02, 00, Linha3(Tam))
	  Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
	  Write( 04, 00, Padc( "LISTAGEM COTACAO DO DOLAR",Tam ) )
	  Write( 05, 00, Linha5(Tam))
	  Write( 06, 00, "DATA     VALIDADE      VALOR R$" )
	  Write( 07, 00, Linha5(Tam))
	  Col := 8
  EndIF
  IF Taxas->DFim >= dDataIni .AND. Taxas->DFim <= dDataFim
	  Qout( DIni, DFim, Tran(Cotacao, "@E 999,999,999.99"))
	  Col++
  EndIF
  IF Col >= 58 .OR. Eof()
	  Write( Col, 0,	Repl( SEP, Tam ))
	  __Eject()
  EndIF
  DbSkip(1)
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc TrocaEmis()
***************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL cFatura
LOCAL dPedido
LOCAL dFatura
WHILE OK
	 oMenu:Limpa()
	 Area("Saidas")
	 Saidas->(Order( SAIDAS_FATURA ))
	 Saidas->(DbGoTop())
	 MaBox( 10, 10, 12, 37 )
	 cFatura := Space(7)
	 @ 11, 11 Say "Fatura N§.....¯" Get cFatura Pict "@!" Valid VisualAchaFatura( @cFatura )
	 Read
	 IF LastKey() = K_ESC
		 ResTela( cScreen )
		 Exit
	 EndIF
	 dPedido := Saidas->Emis
	 dFatura := Saidas->Emis
	 MaBox( 13, 10, 16, 40 )
	 @ 14, 11 Say "Emissao Pedido...: " Get dPedido Pict "##/##/##"
	 @ 15, 11 Say "Emissao Fatura...: " Get dFatura Pict "##/##/##"
	 Read
	 IF LastKey() = K_ESC
		 ResTela( cScreen )
		 Exit
	 EndIF
	 nDif := dFatura - Saidas->Emis
	 IF Conf("Confirma Alteracao da Emissao ?")
		 IF Saidas->(TravaArq())
			 WHILE Saidas->Fatura = cFatura
				 Saidas->Emis := dFatura
				 Saidas->Data := dFatura
				 Saidas->(DbSkip(1))
			 EndDO
			 Saidas->(Libera())
		 EndIF
		 Vendemov->(Order( VENDEMOV_FATURA ))
		 IF Vendemov->(DbSeek( cFatura ))
			 IF Vendemov->(TravaReg())
				 Vendemov->Data	 := dFatura
				 Vendemov->DataPed := dPedido
				 Vendemov->(Libera())
			 EndIF
		 EndIF
		 Recemov->(Order( RECEMOV_FATURA ))
		 IF Recemov->(DbSeek( cFatura ))
			 IF Recemov->(TravaArq())
				 WHILE Recemov->Fatura = cFatura
					 Recemov->Vcto += nDif
					 Recemov->Emis := dFatura
					 Recemov->(DbSkip(1))
				 EndDo
				 Recemov->(Libera())
			 EndIF
		 EndIF
		 Chemov->(Order( CHEMOV_FATURA ))
		 IF Chemov->(DbSeek( cFatura ))
			 IF Chemov->(TravaArq())
				 WHILE Chemov->Fatura = cFatura
					 Chemov->Data	:= dFatura
					 Chemov->Emis	:= dFatura
					 Chemov->(DbSkip(1))
				 EndDo
				 Chemov->(Libera())
			 EndIF
		 EndIF
	 EndIF
EndDo

Function AtPrompt( nRow, nCol, cString )
****************************************
@ nRow, nCol Prompt cString
Return NIL

Proc FechaDia()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL aMenu 	:= {"Fatura", "Cliente", "Periodo","Individual", "Por Classe"}
LOCAL dIni		:= Date()
LOCAL dFim		:= Date()
LOCAL xNtx		:= FTempName()
LOCAL nIndice	:= oIni:ReadInteger('ecf','indice', 1.25 )
LOCAL aOrdem	:= {"Emissao", "Cliente", "Fatura", "Codigo", "Descricao", "Custo"}
LOCAL nChoice	:= 0
LOCAL cFatu 	:= Space(07)
LOCAL cCodi 	:= Space(05)
LOCAL xCodigo	:= 0
LOCAL cClasse  := Space(02)
LOCAL oBloco
LOCAL oBloco2
LOCAL oBloco3 := NIL
LOCAL nCusto
LOCAL Handle
LOCAL cCodigo
LOCAL cTela
LOCAL nField

oMenu:Limpa()
nChoice := FazMenu( 09, 10, aMenu )
oBloco3 = NIL
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	cFatu  := Space(07)
	MaBox( 18, 10, 20, 34 )
	@ 19, 11 Say "Fatura n§....:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_FATURA ))
	oBloco  := {|| Saidas->Fatura = cFatu }
	oBloco2 := {|| !Eof() }
	IF Saidas->(!DbSeek( cFatu ))
		Nada()
		ResTela( cScreen )
		Return
	EndIF

Case nChoice = 2
	cCodi := Space(05)
	dIni	:= Date()
	dFim	:= Date()
	MaBox( 18, 10, 22, 35 )
	@ 19, 11 Say "Cliente.......:" Get cCodi Pict "99999" Valid RecErrado( @cCodi )
	@ 20, 11 Say "Data Inicial..:" Get dIni  Pict PIC_DATA Valid AchaDtFatura( @dIni )
	@ 21, 11 Say "Data Final....:" Get dFim  Pict PIC_DATA Valid dFim >= dIni
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_CODI ))
	oBloco	:= {|| Saidas->Codi = cCodi}
	oBloco2	:= {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	IF Saidas->(!DbSeek( cCodi ))
		Nada()
		ResTela( cScreen )
		Return
	EndIF

Case nChoice = 3
	dIni := Date()
	dFim := Date()
	MaBox( 18, 10, 21, 44, "ENTRE COM O PERIODO")
	@ 19, 11 Say "Data Inicial..:" Get dIni  Pict PIC_DATA Valid AchaDtFatura( @dIni )
	@ 20, 11 Say "Data Final....:" Get dFim  Pict PIC_DATA Valid dFim >= dIni
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_EMIS ))
	oBloco  := {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	oBloco2 := {|| !Eof() }
	IF Saidas->(!DbSeek( dIni ))
		Nada()
		ResTela( cScreen )
		Return
	EndIF

Case nChoice = 4
	xCodigo := 0
	dIni := Date()
	dFim := Date()
	MaBox( 18, 10, 22, 78 )
	@ 19, 11 Say "Codigo........:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo,,, Row(), Col()+6)
	@ 20, 11 Say "Data Inicial..:" Get dIni  Pict PIC_DATA Valid AchaDtFatura( @dIni )
	@ 21, 11 Say "Data Final....:" Get dFim  Pict PIC_DATA Valid dFim >= dIni
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_CODIGO ))
	oBloco  := {|| Saidas->Codigo = xCodigo }
	oBloco2 := {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	IF Saidas->(!DbSeek( xCodigo ))
		Nada()
		ResTela( cScreen )
		Return
	EndIF

Case nChoice = 5
	dIni	  := Date()
	dFim	  := Date()
   cClasse := Space(02)
	MaBox( 18, 10, 22, 44, "ENTRE COM O PERIODO")
   @ 19, 11 Say "Classe........:" Get cClasse Pict "99" Valid PickClasse( @cClasse )
	@ 20, 11 Say "Data Inicial..:" Get dIni    Pict PIC_DATA Valid AchaDtFatura( @dIni )
	@ 21, 11 Say "Data Final....:" Get dFim    Pict PIC_DATA Valid dFim >= dIni
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_EMIS ))
	oBloco  := {|| Saidas->Data >= dIni .AND. Saidas->Data <= dFim }
	oBloco2 := {|| !Eof() }
	oBloco3 := {|| Lista->Classe = cClasse }
	IF Saidas->(!DbSeek( dIni ))
		Nada()
		ResTela( cScreen )
		Return
	EndIF
EndCase
Handle := FaturaNew()
Use ( Handle ) Alias xEcf Exclusive New
Area("xEcf")
Inde On xEcf->Fatura To ( xNtx )
cTela := Mensagem("Aguarde... ", Cor())
WHILE Saidas->(Eval( oBloco ))
	IF Saidas->Saida <= 0
		Saidas->(DbSkip(1))
		Loop
	EndIF
	IF Saidas->(Eval( oBloco2 ))
	cCodigo := Saidas->Codigo
	nCusto  := Saidas->Pcompra
	IF Lista->(DbSeek( cCodigo ))
		IF oBloco3 != NIL
			IF Lista->(!Eval( oBloco3 ))
				Saidas->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF nCusto <= 0 .OR. nCusto > Lista->Pcompra
			IF Lista->Pcompra > 0
				 nCusto := Lista->Pcompra
			Else
				 nCusto := Lista->PCusto
			EndIF
		EndIF
		IF !Lista->Servico
			IF !Lista->Usa
				IF !Saidas->Impresso
					xEcf->(DbAppend())
					xEcf->Codigo	 := cCodigo
					xEcf->Quant 	 := Saidas->Saida
					xEcf->Desconto  := Saidas->Desconto
					xEcf->Unitario  := nCusto * nIndice
					xEcf->Atacado	 := Saidas->Atacado
					xEcf->Varejo	 := Saidas->Varejo
					xEcf->Pcompra	 := Saidas->Pcompra
					xEcf->Total 	 := Saidas->VlrFatura
					xEcf->Fatura	 := Saidas->Fatura
					xEcf->Forma 	 := Saidas->Forma
					xEcf->Descricao := Lista->Descricao
					xEcf->Un 		 := Lista->Un
					xEcf->Emis		 := Saidas->Emis
					xEcf->Codi		 := Saidas->Codi
					xEcf->Classe	 := Lista->Classe
					xEcf->Servico	 := Lista->Servico
				EndIF
			EndIF
		EndIF
	EndIF
	EndIF
	Saidas->(DbSkip(1))
EndDo
xEcf->(DbGoTop())
Lista->(Order( LISTA_CODIGO ))
Set Rela To Codigo Into Lista
ResTela( cTela )
oMenu:Limpa()
M_Title("ESCOLHA A ORDEM")
nChoice := FazMenu( 10, 20, aOrdem, Cor())
IF nChoice = 0
	xEcf->(DbCloseArea())
	Ferase( Handle )
	Ferase( xNtx )
	ResTela( cScreen )
	Return
ElseIF nChoice = 1
	Inde On xEcf->Emis To (xNtx )
ElseIF nChoice = 2
	Inde On xEcf->Codi To (xNtx )
ElseIF nChoice = 3
	Inde On xEcf->Fatura To (xNtx )
ElseIF nChoice = 4
	Inde On xEcf->Codigo To (xNtx )
ElseIF nChoice = 5
	Inde On xEcf->Descricao To (xNtx )
ElseIF nChoice = 6
	Inde On xEcf->Pcompra To (xNtx )
EndIF
ErrorBeep()
IF Conf("Pergunta: Imprimir Listagem ?")
	ListaEcf()
	IF Conf("Pergunta: Tudo Pronto ?")
		FechaDiaEcf()
	EndIF
EndIF
xEcf->(DbCloseArea())
Ferase( Handle )
Ferase( xNtx )
ResTela( cScreen )
Return

Proc FechaDiaEcf()
******************
LOCAL nIniEcf := oIni:ReadInteger('ecf','modelo', 1 )
IF nIniEcf = 1
	Fd_ZantIz11()
ElseIF nIniEcf = 4
	Fd_Sigtron()
EndIF
Return

Proc Fd_ZantIz11()
******************
LOCAL Arq_Ant		 := Alias()
LOCAL Ind_Ant		 := IndexOrd()
LOCAL cScreen		 := SaveScreen()
LOCAL nPorta		 := 0
LOCAL cBuffer		 := Space(134)
LOCAL nPreco		 := 0
LOCAL nTotal		 := 0
LOCAL lServico 	 := FALSO
LOCAL cFatura		 := ""
LOCAL cMensagem    := 'MICROBRAS - ADIANTANDO O SEU FUTURO'
LOCAL lNomeEcf 	 := oIni:ReadBool('ecf', 'nomeecf', FALSO )
LOCAL cRamoIni 	 := oIni:ReadString('sistema','ramo', Left( XRAMO, 40))
LOCAL cCodiCliente := ''
LOCAL cNomeCliente := ''
LOCAL cEndeCliente := ''
LOCAL cBairCliente := ''
LOCAL cCidaCliente := ''
LOCAL cEstaCliente := ''
LOCAL cCgcCliente  := ''

Receber->(Order( RECEBER_CODI ))
Lista->(Order( LISTA_CODIGO ))
oMenu:Limpa()
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
nPorta  := ZaIniciaDrive(cBuffer)
cBuffer := "~1/1/" // Inicio de Dia
FWrite( nPorta, @cBuffer, Len( cBuffer ))
xEcf->(DbGoTop())
cFatura := xEcf->Fatura
WHILE xEcf->(!Eof())
	IF lNomeEcf
		IF Receber->(DbSeek( xEcf->Codi ))
			cCodiCliente := AllTrim( Receber->Codi )
			cNomeCliente := Left( AllTrim( Receber->Nome ),38)
			cEndeCliente := AllTrim( Receber->Ende )
			cBairCliente := AllTrim( Receber->Bair )
			cCidaCliente := AllTrim( Receber->Cida )
			cEstaCliente := Receber->Esta
			cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
		EndIF
	Else
		cCodiCliente := ''
		cNomeCliente := ''
		cEndeCliente := ''
		cBairCliente := ''
		cCidaCliente := ''
		cEstaCliente := ''
		cCgcCliente  := ''
	EndIF
	cForma  := xEcf->Forma
	cBuffer := "~1/8/" // Inicio de Cupom Fiscal
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	FRead( nPorta, @cBuffer, 134)

	// Mensagem Promocional
	cBuffer := "~2/o/$00========================================$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	IF lNomeEcf
		cBuffer := "~2/o/$01" + 'Cliente.: ' + cNomeCliente + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := "~2/o/$02" + 'Endereco: ' + cEndeCliente + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := "~2/o/$03" + 'Cidade..: ' + cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := "~2/o/$04" + 'Cgc/Cpf.: ' + cCgcCliente + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := "~2/o/$05========================================$"
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := "~2/o/$06" + Padc(Left(AllTrim( cRamoIni ),39),39) + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := '~2/o/$07' + Repl('=', 40-Len(AllTrim(cFatura))) + AllTrim(cFatura) + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
	Else
		cBuffer := "~2/o/$01" + Padc(Left(AllTrim( cRamoIni ),39),39) + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		cBuffer := '~2/o/$02' + Repl('=', 40-Len(AllTrim(cFatura))) + AllTrim(cFatura) + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
	EndIF

	// Espacejamento
	cBuffer := "~2/U/$01$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	nGeral := 0
	While xEcf->Fatura = cFatura
		nQuant	  := xEcf->Quant
		nTotal	  := ( xEcf->Unitario * xEcf->Quant )
		nGeral	  += nTotal
		cDescricao := Left( xEcf->Descricao, 33)
		cTotal	  := ValueToStr( nTotal )
		cCodigo	  := xEcf->Codigo
		cQuant	  := AllTrim(Str( nQuant, 5, 2 ))
		cUnitario  := ValueToStr( xEcf->Unitario )
		cLetra	  := ' T'
		cIcms 	  := "17.00%"
		cIss		  := " S05.00%"

		Lista->(DbSeek( cCodigo ))
		lServico := Lista->Servico
		cClasse	:= Lista->Classe

      IF cClasse = '00'
			cLetra := 'T'
      ElseIF cClasse = '10'
			cLetra := 'F'
      ElseIF cClasse = '20'
			cLetra := 'N'
      ElseIF cClasse = '30'
			cLetra := 'F'
      ElseIF cClasse = '40'
			cLetra := 'I'
      ElseIF cClasse = '41'
			cLetra := 'I'
      ElseIF cClasse = '50'
			cLetra := 'I'
      ElseIF cClasse = '51'
			cLetra := 'I'
      ElseIF cClasse = '60'
			cLetra := 'F'
      ElseIF cClasse = '70'
			cLetra := 'N'
      ElseIF cClasse = '90'
			cLetra := 'N'
		EndIF

		// Armazenamento do Descritivo do Item
		cBuffer	  := "~3/g/$00" + cCodigo + ' ' + cDescricao + '$'
		FWrite( nPorta, @cBuffer, Len( cBuffer ))

		// Registro do Item em cupom fiscal
		IF lServico
			cEsq		  := "~3/;/$ " + cQuant + " x " + AllTrim(cUnitario ) + cIss
			cDir		  := AllTrim( cTotal ) + " S $"
		Else
         IF cClasse = '00'
				cEsq		  := "~3/;/$ " + cQuant + " x " + AllTrim(cUnitario ) + ' ' + cLetra + cIcms
				cDir		  := AllTrim( cTotal ) + ' ' + cLetra + ' $'
			Else
				cEsq		  := "~3/;/$ " + cQuant + " x " + AllTrim(cUnitario )
				cDir		  := AllTrim( cTotal ) + ' ' + cLetra + ' $'
			EndIF
		EndIF
		cBuffer	  := cEsq + Space(47-(Len(cEsq)+Len(cDir))) + cDir
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		xEcf->(DbSkip(1))
	EndDo
	// Totalizacao do Cupom Fiscal
	cGeral	  := ValueToStr( nGeral )
	cBuffer	  := '~3/O/$' + Space(37-Len(cGeral)) + cGeral + '   $ '
	FWrite( nPorta, @cBuffer, Len( cBuffer ))

   #IFDEF MICROBRAS
		cForma := '01' // Vista
	#ELSE
		IF cForma > '01'
			cForma := '05'
		EndIF
	#ENDIF

	// Registro do Pagamento
	cBuffer	  := '~3/i/$' + cForma + Space(35-Len(cGeral)) + cGeral  + '   $'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))

	// Fechamento do Cupom
	FWrite( nPorta, "~1/9/", 5)

	// Espacejamento
	cBuffer := "~2/U/$08$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))

	// Limpeza Mensagem Publicitaria
	cBuffer := "~2/o/$00$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$01$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$02$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$03$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$04$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$05$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$06$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$07$"
	FWrite( nPorta, @cBuffer, Len( cBuffer ))

	//Atualizacao do Banco de Dados
	Saidas->(Order( SAIDAS_FATURA ))
	IF Saidas->(DbSeek( cFatura ))
		While Saidas->Fatura = cFatura
			IF Saidas->(TravaReg())
				Saidas->Impresso := OK
				Saidas->(Libera())
				Saidas->(DbSkip(1))
			EndIF
		EndDo
	EndIF
	cFatura := xEcf->Fatura
EndDo
FClose( nPorta )
ResTela( cScreen )
Return

Proc Fd_Sigtron()
*****************
LOCAL Arq_Ant		 := Alias()
LOCAL Ind_Ant		 := IndexOrd()
LOCAL cScreen		 := SaveScreen()
LOCAL nPorta		 := 0
LOCAL nTotal		 := 0
LOCAL nGeral		 := 0
LOCAL nLiquido     := 0
LOCAL nQuant		 := 0
LOCAL nIcms 		 := 17
LOCAL cBuffer		 := Space(134)
LOCAL lServico 	 := FALSO
LOCAL lVista		 := FALSO
LOCAL cGeral		 := '000000000000'
LOCAL cUnitario	 := '000000000'
LOCAL nSigLinha    := 1
LOCAL cCodiCliente := ''
LOCAL cNomeCliente := ''
LOCAL cEndeCliente := ''
LOCAL cBairCliente := ''
LOCAL cCidaCliente := ''
LOCAL cEstaCliente := ''
LOCAL cCgcCliente  := ''
LOCAL cFatura		 := ''
LOCAL lNomeEcf
LOCAL cRamoIni
LOCAL nConta

Receber->(Order( RECEBER_CODI ))
Lista->(Order( LISTA_CODIGO ))
lVista    := oIni:ReadBool('ecf', 'vista', OK )
nSigLinha := oIni:ReadInteger('ecf', 'siglinha', 2 )
lNomeEcf  := oIni:ReadBool('ecf', 'nomeecf', FALSO )
cRamoIni  := oIni:ReadString('sistema','ramo', Left( XRAMO, 40))

oMenu:Limpa()
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
xEcf->(DbGoTop())
cFatura := xEcf->Fatura
While xEcf->(!Eof())
	IF Receber->(DbSeek( xEcf->Codi ))
      nIcms := Receber->Tx_Icms
		IF nIcms = 0
			nIcms = oIni:ReadInteger('ecf', 'uficms', 17 )
		EndIF
		IF lNomeEcf
			cCodiCliente := AllTrim( Receber->Codi )
			cNomeCliente := Left( AllTrim( Receber->Nome ),38)
			cEndeCliente := AllTrim( Receber->Ende )
			cBairCliente := AllTrim( Receber->Bair )
			cCidaCliente := AllTrim( Receber->Cida )
			cEstaCliente := Receber->Esta
			cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
		Else
			cCodiCliente := ''
			cNomeCliente := ''
			cEndeCliente := ''
			cBairCliente := ''
			cCidaCliente := ''
			cEstaCliente := ''
			cCgcCliente  := ''
		EndIF
	EndIF
   nGeral   := 0
   nLiquido := 0
   nPorta   := SigtronIniciaDrive(cBuffer)
   cBuffer  := Chr(27) + Chr(228) + '1100100010110391505000025500000000000000'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := Chr(27) + Chr(200) // Inicio de Cupom Fiscal
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	While xEcf->Fatura = cFatura
		cCodigo	  := xEcf->Codigo
		cDescricao := Left( xEcf->Descricao, 37)
		nQuant	  := xEcf->Quant

		IF Right( Str( nQuant, 7, 2 ), 2 ) == '00'
			cQuant := StrZero(Int( nQuant ), 5)
		Else
			IF Right( Str( nQuant, 6, 2 ), 1 ) == '0'
				cQuant := StrTran( Str( nQuant, 5, 1 ), '.', ',')
			Else
				cQuant := StrTran( Str( nQuant, 5, 2 ), '.', ',')
			EndiF
		EndIF

		cUnitario  := StrSemComma( xEcf->Unitario, 13, 2, 9 )
		nTotal	  := ( xEcf->Unitario * xEcf->Quant )
		nGeral	  += nTotal
      nLiquido   += nTotal

		Lista->(DbSeek( cCodigo ))
		cUn		:= Lista->Un
		lServico := Lista->Servico
		cClasse	:= Lista->Classe

		cLetra := 'TD'
      IF cClasse = '00'
			IF nIcms = 7
				cLetra := 'TB'
			ElseIF nIcms = 12
				cLetra := 'TC'
			ElseIF nIcms = 17
				cLetra := 'TD'
			ElseIF nIcms = 25
				cLetra := 'TE'
			EndIF
      ElseIF cClasse = '10'
			cLetra := 'F?'
      ElseIF cClasse = '20'
			cLetra := 'N?'
      ElseIF cClasse = '30'
			cLetra := 'F?'
      ElseIF cClasse = '40'
			cLetra := 'I?'
      ElseIF cClasse = '41'
			cLetra := 'I?'
      ElseIF cClasse = '50'
			cLetra := 'I?'
      ElseIF cClasse = '51'
			cLetra := 'I?'
      ElseIF cClasse = '60'
			cLetra := 'F?'
      ElseIF cClasse = '70'
			cLetra := 'N?'
      ElseIF cClasse = '90'
			cLetra := 'N?'
		EndIF
      IF nSigLinha = 1
         cBuffer := Chr(27) + Chr(202) // Descricao do Produto em 1 linhas com codigo de 6 digitos
      Else
         cBuffer := Chr(27) + Chr(203) // Descricao do Produto em 2 linhas com codigo de 6 digitos
      EndIF
		IF lServico
			cBuffer += 'TA'            // Situacao Tributaria
		Else
			cBuffer += cLetra 			// Situacao Tributaria
		EndIF
		cBuffer += cCodigo				// Codigo Produto 6 Digitos
		cBuffer += '000'              // Compatibilidade
		cBuffer += '1'                // 0=Desconto 1=Acrescimo
		cBuffer += '0000'             // Percentual Desconto/Acrescimo
		cBuffer += cUnitario 			// Preco Unitario 9 digitos sem virgula
		cBuffer += cQuant 				// Quantidade
      IF nSigLinha = 1
         cBuffer += Left( cDescricao,14)  // Descricao com 14 caracteres
      Else
         cBuffer += cUn                   // Unidade
         cBuffer += Left( cDescricao,37)  // Descricao com 37 caracteres
      EndIF
		FWrite( nPorta, @cBuffer, Len( cBuffer ))
		xEcf->(DbSkip(1))
	EndDo
   nDesconto  := ( nLiquido - nGeral )
   cGeral     := StrSemComma( nGeral, 13, 2, 12 )
   cDesconto  := '000000000000'
   cLetraDesc := '1'
   IF nDesconto < 0 // Desconto
      xDesconto := 0
      xDesconto -= nDesconto
      nDesconto := xDesconto
      cDesconto := StrSemComma( nDesconto, 13, 2, 12 )
      cLetraDesc := '1'
   ElseIF nDesconto > 0 // Acrescimo
      cDesconto  := StrSemComma( nDesconto, 13, 2, 12 )
      cGeral     := StrSemComma( nLiquido, 13, 2, 12 )
      cLetraDesc := '5'
   EndIF

   //Totalizacao do Cupom Fiscal
   cBuffer := Chr(27) + Chr(241)
   cBuffer += cLetraDesc  // 0=Percentagem 1=Desconto em Valor 5=Acrescimo em Valor
   cBuffer += cDesconto   // PPPP00000000 = Porcentagem de desconto/acrescimo (PP,PP%) seguido de 8 zeros, ou VVVVVVVVVVVV = Valor do Desconto/Acrescimo com 12 digitos, sendo os 2 ultimos os centavos.
   FWrite( nPorta, @cBuffer, Len( cBuffer ))

   cLetra := 'A'
   IF lVista
      cLetra := 'A' // Dinheiro
   Else
      cLetra := 'E' // A Prazo
      nConta := ChrCount("/", cCondicoes ) + 1
      IF nConta = 1
         IF Val( cCondicoes ) = 0
            cLetra := 'A' // Dinheiro
         EndIF
      EndIF
   EndIF
   // Registro do Pagamento
   cBuffer := Chr(27) + Chr(242)
   cBuffer += cLetra          // Forma de Pagamento
   cBuffer += cGeral          // Valor Total com 12 digitos sem virgula/ponto
   cBuffer += Chr(255)
   FWrite( nPorta, @cBuffer, Len( cBuffer ))

   // Fechamento do Cupom
   cBuffer := Chr(27) + Chr(243)
   cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
   IF lNomeEcf
      cBuffer += 'Codigo..:' + cCodiCliente + Chr(13) + Chr(10)
      cBuffer += 'Cliente.:' + cNomeCliente + Chr(13) + Chr(10)
      cBuffer += 'Endereco:' + cEndeCliente + Chr(13) + Chr(10)
      cBuffer += 'Cidade..:' + cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente + Chr(13) + Chr(10)
      cBuffer += 'Cgc/Cpf.:' + cCgcCliente  + Chr(13) + Chr(10)
      cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
   EndIF
   cBuffer += cRamoIni + Chr(13) + Chr(10)
   cBuffer += Repl('=', 48-Len(AllTrim(cFatura))) + AllTrim(cFatura) + Chr(13) + Chr(10)
   cBuffer += Chr(255)
   FWrite( nPorta, @cBuffer, Len( cBuffer ))
   /* Autenticacao de Documentos
   cBuffer := Chr(27) + Chr(89)
   cBuffer += LEFT( XFANTA, 13 ) + Chr(13) + Chr(10)
   FWrite( nPorta, @cBuffer, Len( cBuffer ))
   */
   /*Cupom Fiscal Adicional
   cBuffer := Chr(27) + Chr(210)
   FWrite( nPorta, @cBuffer, Len( cBuffer ))
   */
   FClose( nPorta )

   //Atualizacao do Banco de Dados
   Saidas->(Order( SAIDAS_FATURA ))
   IF Saidas->(DbSeek( cFatura ))
      While Saidas->Fatura = cFatura
         IF Saidas->(TravaReg())
            Saidas->Impresso := OK
            Saidas->(Libera())
            Saidas->(DbSkip(1))
         EndIF
      EndDo
   EndIF
	cFatura := xEcf->Fatura
EndDo
FClose( nPorta )
ResTela( cScreen )
Return


Function AchaDtFatura( dData )
******************************
LOCAL cScreen	:= SaveScreen()
LOCAL lRetorno := OK

Saidas->(Order( SAIDAS_EMIS ))
IF Saidas->(!DbSeek( dData ))
	IF Conf("Erro: Data Invalida. Localizar Proxima ?")
		Mensagem('Aguarde, Localizando Proximo Vcto.')
		dData ++
		While Saidas->(!DbSeek( dData ))
			dData ++
			Saidas->(DbSkip(1))
		EndDo
	Else
		lRetorno := FALSO
	EndIF
EndIF
ResTela( cScreen )
Return( lRetorno )

Proc ListaEcf()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL Col		:= 57
LOCAL Pagina	:= 0
LOCAL Tam		:= 132
LOCAL nTotal	:= 0
LOCAL nGeral	:= 0
LOCAL nItens	:= 0

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
Area("xEcf")
xEcf->(DbGoTop())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
nItens := 0
nGeral := 0
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 57
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "LISTAGEM DE CALCULO DE CUSTO",Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "EMISSAO  CODI  FATURA    CODIGO DESCRICAO DO PRODUTO                        QUANT         CUSTO      UNITARIO         TOTAL FP C SER")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	nTotal := Quant * Unitario
	Qout( Emis, Codi, Fatura, Codigo, Descricao, Quant, Pcompra, Unitario, nTotal, Forma, Classe, Servico )
	nGeral += nTotal
	Col++
	nItens++
	DbSkip(1)
	IF Col >= 57 .OR. Eof()
		Qout( Repl( SEP, Tam ))
		Qout( "**** Total ****", Tran( nItens, "99999"), Space(85), Tran( nGeral, "@E 999,999,999.99"))
		Col += 2
		__Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Function oMenuTestelan()
************************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

IF !aPermissao[SCI_CONTROLE_DE_ESTOQUE]
   Return( AtPrompt )
EndIF
IF oAmbiente:Get_Ativo
	cStr_Get := "Desativar Get Tela Cheia"
Else
	cStr_Get := "Ativar Get Tela Cheia"
EndIF
IF oMenu:Sombra
	cStr_Sombra := "DesLigar Sombra"
Else
	cStr_Sombra := "Ligar Sombra"
EndIF
AADD( AtPrompt, {"Sair",       {"Encerrar Sessao"}})
Aadd( AtPrompt, {"Cadastro",   {"Produtos","Grupos","SubGrupos","Indexadores","Cota‡ao Dolar","Forma de Pgto","Fornecedores","Vendedores","Clientes","Cep","Representantes"}})
Aadd( AtPrompt, {"Alteracao",  {"Produtos","Grupos","SubGrupos","Indexadores","Cota‡ao Dolar","Forma de Pgto","Margem de Venda","Cep","Fornecedor de Produtos","Ajuste do Estoque", "Ajuste do Prevenda", "Taxa de Icms Substituicao","Representantes de Produtos","Gerar Codigo de Barra","Transporte de Valores","Representantes","Movimento Entrada/Saida"}})
Aadd( AtPrompt, {"Relatorios", {"Cotacao Dolar","Etiquetas Produtos","Estoques","Entradas/Saidas","Formas de Pagto","Grupos","Lista de Precos","Notas de Entradas","Pedidos a Fornecedor","Representantes","SubGrupos","Indexadores"}})
Aadd( AtPrompt, {"Consulta",   {"Entradas de Produtos","Saidas de Produtos","Indexadores","Grupos","SubGrupos","Lista de Precos","Fornecedores","Clientes","Cota‡ao do Dolar","Forma de Pagto","Grafico de Vendas","Grafico de Compras","Pedido a Fornecedor","Grafico 12 maiores clientes"}})
Aadd( AtPrompt, {"Reajuste",   {"Preco Venda","Preco Custo","Preco Varejo Pelo Dolar","Preco Atacado Pelo Dolar","Debito Conta Corrente"}})
Aadd( AtPrompt, {"Faturar",    {"Saidas Produtos","Devolucao Saidas","Inclusao Produtos","Visualizar Fatura","Entradas de Produtos","Baixa Debito c/c","Devolucao Entradas","Trocar Emissao Fatura"}})
Aadd( AtPrompt, {"Impressao",  {"Duplicatas","Boleto Bancario","Promissorias","Espelho Nota","Espelho Nota Parcial","Relacao Entrega","Relacao de Separacao","Nota Fiscal","Demostrativo IPI","Bordero","Arquivo Nota Fiscal"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispTestelan()
************************
LOCAL oTesteLan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt  := oMenuTesteLan()
LOCAL nMenuH    := Len(AtPrompt)
LOCAL aDisp     := Array( nMenuH, 22 )
LOCAL aMenuV    := {}

IF !aPermissao[SCI_CONTROLE_DE_ESTOQUE]
   Return( aDisp )
EndIF

Mensagem("Aguarde, Verificando Diretivas do CONTROLE DE ESTOQUE.")
Return( aDisp := ReadIni("testelan", nMenuH, aMenuV, AtPrompt, aDisp, oTesteLan))

Proc LisSaiTotal( cString )
***************************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL nSaida	  := 0
LOCAL nPcusto	  := 0
LOCAL nPvendido  := 0
LOCAL nItens	  := 0

IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem(" Aguarde... Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE xTemp->(!Eof()) .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "ROL DETALHADO DE SAIDAS " + cString, Tam ) )
		Write( 05, 00, Linha5(Tam))
      Write( 06, 00,"CODI NOME DO VENDEDOR                                SAIDA        T. PCUSTO      T. PVENDIDO     CMV    OBSERVACOES")
      Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	xTemp->(Qout( CodiVen,;
					  Nome,;
					  Tran( Saida, 	'999999999.99'),;
					  Tran( Pcusto,  "@E 9,999,999,999.99"),;
					  Tran( Pvendido,"@E 9,999,999,999.99"),;
                 Tran((Pcusto / Pvendido) * 100, "@E 999.99%"),;
                 Repl('_',31)))

	nSaida	  += xTemp->Saida
	nPcusto	  += xTemp->Pcusto
	nPvendido  += xTemp->PVendido
	nItens	  ++
	Col++
	xTemp->(DbSkip(1))
	IF Col >= 56 .OR. xTemp->(Eof())
		Qout()
		Qout("** Total *", StrZero( nItens, 4 ),;
								 Space(29),;
								 Tran( nSaida,   "@E 999999999.99"),;
								 Tran( nPcusto,  "@E 9,999,999,999.99"),;
								 Tran( nPvendido,"@E 9,999,999,999.99"))
		Col := 58
		__Eject()
	EndIF
EndDo
PrintOff()
Return

Proc AjustaPrevenda()
*********************
LOCAL GetList   := {}
LOCAL cScreen   := SaveScreen()
LOCAL cCodigo
LOCAL nPrevenda
LOCAL lOk

oMenu:Limpa()
ErrorBeep()
IF Conf("Pergunta: Atualizar ?" )
  Mensagem("Aguarde, Somando Itens.", Cor())
  Lista->(Order( LISTA_CODIGO ))
  Lista->(DbGoTop())
  Prevenda->(Order( PREVENDA_CODIGO ))
  While Lista->(!Eof()) .AND. Rep_Ok()
    cCodigo   := Lista->Codigo
    nPrevenda := 0
    IF Prevenda->(DbSeek( cCodigo ))
       While Prevenda->Codigo = cCodigo
          nPrevenda += Prevenda->Saida
          Prevenda->(DbSkip(1))
       EndDo
    EndIF
    IF Lista->(TravaReg())
       Lista->Vendida := nPrevenda
       Lista->(Libera())
    EndIF
    Lista->(DbSkip(1))
  EndDo
EndIF
ResTela( cScreen )
Return

Proc FisicoFinanceiro()
***********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aOrdem	  := { " Ordem Numerica ", " Ordem Alfabetica ", " Ordem Cod Fabric ", " Totalizado "}
LOCAL aMenu 	  := { " Geral   "," Parcial ", " Por Grupo ", " Por SubGrupo ", " Por Fornecedor " }
LOCAL cCodiIni   := 0
LOCAL cCodiFim   := 0
LOCAL cGrupoIni  := Space(3)
LOCAL cGrupoFim  := Space(3)
LOCAL cSubIni	  := Space(SEIS)
LOCAL cSubFim	  := Space(SEIS)
LOCAL xDbf		  := FTempName("T*.TMP")
LOCAL xNtx		  := FTempName("T*.TMP")
LOCAL nCusParc   := 0
LOCAL nVarParc   := 0
LOCAL nAtaParc   := 0
LOCAL nCusTotal  := 0
LOCAL nVarTotal  := 0
LOCAL nAtaTotal  := 0
LOCAL NovoGrupo
LOCAL NovoSGrupo
LOCAL UltGrupo
LOCAL UltSGrupo
LOCAL nField
LOCAL oBloco1
LOCAL aStru
LOCAL Tam
LOCAL Col
LOCAL Pagina
LOCAL nTipo
LOCAL nPreco1
LOCAL nPreco2
LOCAL nPreco3
LOCAL nChoice
LOCAL nOrdem
LOCAL lComEstoque
LOCAL cCodiFor
FIELD CodSGrupo
FIELD N_Original
FIELD Codigo
FIELD Descricao
FIELD CodGrupo
FIELD Pcusto
FIELD Quant
FIELD Varejo
FIELD Atacado
FIELD Codi
FIELD Un


Area('Lista')
M_Title( "ESC Retorna" )
nOrdem := FazMenu( 03, 27, aOrdem )
IF nOrdem = 0
	ResTela( cScreen )
	Return
EndIF
IF nOrdem = 4
	Totalizado()
	ResTela( cScreen )
	Return
EndIF
nTipo := FazMenu( 05, 29, aMenu, Cor())
IF nTipo = 0
	ResTela( cScreen )
	Return
ElseIF nTipo = 1
	Do Case
	Case nOrdem = UM	 // Numerica
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_CODIGO ))
	Case nOrdem = DOIS // Alfabetica
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_DESCRICAO ))
	Case nOrdem = TRES // N_Original
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_N_ORIGINAL ))
	EndCase

ElseIF nTipo = 2
	MaBox( 20, 47, 23, 66 )
	@ 21, 48 Say "Cod.Ini..:" Get cCodiIni Pict PIC_LISTA_CODIGO Valid CodiErrado(@cCodiIni, @cCodiFim )
	@ 22, 48 Say "Cod.Fim..:" Get cCodiFim Pict PIC_LISTA_CODIGO Valid CodiErrado(@cCodiFim,,OK)
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Mensagem('Aguarde, Processando.')
	Lista->(Order( LISTA_CODIGO ))
	Lista->(DbSeek( cCodiIni ))
	aStru   := Lista->(DbStruct())
	oBloco1 := {|| Lista->Codigo >= cCodiIni .AND. Lista->Codigo <= cCodiFim }
	DbCreate( xDbf, aStru )
	Use (xDbf) Alias xTemp Exclusive New
	WHILE Eval( oBloco1 ) .AND. Rep_Ok()
		xTemp->( DbAppend())
		For nField := 1 To FCount()
			xTemp->( FieldPut( nField, Lista->(FieldGet( nField ))))
		Next
		Lista->(DbSkip(1))
	Enddo
	Do Case
	Case nOrdem = UM	 // Numerica
		Inde On xTemp->CodGrupo+CodSGrupo+Codigo To (xNtx)
	Case nOrdem = DOIS // Alfabetica
		Inde On xTemp->CodGrupo+CodSGrupo+Descricao To (xNtx)
	Case nOrdem = TRES // N_Original
		Inde On xTemp->CodGrupo+CodSGrupo+N_Original To (xNtx)
	EndCase
ElseIF nTipo = 3
	MaBox( 15, 11, 18, 31 )
	cGrupoIni := Space(TRES)
	cGrupoFim := Space(TRES)
	@ 16, 12 Say "Grupo Inicial ¯" Get cGrupoIni Pict "999" Valid CodiGrupo( @cGrupoIni )
	@ 17, 12 Say "Grupo Final   ¯" Get cGrupoFim Pict "999" Valid CodiGrupo( @cGrupoFim )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Mensagem('Aguarde, Processando.')
	Lista->(Order( LISTA_CODGRUPO ))
	Lista->(DbSeek( cGrupoIni ))
	aStru   := Lista->(DbStruct())
	oBloco1 := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
	DbCreate( xDbf, aStru )
	Use (xDbf) Alias xTemp Exclusive New
	WHILE Eval( oBloco1 ) .AND. Rep_Ok()
		xTemp->( DbAppend())
		For nField := 1 To FCount()
			xTemp->( FieldPut( nField, Lista->(FieldGet( nField ))))
		Next
		Lista->(DbSkip(1))
	Enddo
	Do Case
	Case nOrdem = UM	 // Numerica
		Inde On xTemp->CodGrupo+CodSGrupo+Codigo To (xNtx)
	Case nOrdem = DOIS // Alfabetica
		Inde On xTemp->CodGrupo+CodSGrupo+Descricao To (xNtx)
	Case nOrdem = TRES // N_Original
		Inde On xTemp->CodGrupo+CodSGrupo+N_Original To (xNtx)
	EndCase

ElseIF nTipo = 4
	MaBox( 15, 11, 18, 37 )
	cSubIni := Space(SEIS)
	cSubFim := Space(SEIS)
	@ 16, 12 Say "SubGrupo Inicial ¯" Get cSubIni Pict "999.99" Valid CodiSubGrupo( @cSubIni )
	@ 17, 12 Say "SubGrupo Final   ¯" Get cSubFim Pict "999.99" Valid CodiSubGrupo( @cSubFim )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Mensagem('Aguarde, Processando.')
	Lista->(Order( LISTA_SUBGRUPO ))
	Lista->(DbSeek( cSubIni ))
	aStru   := Lista->(DbStruct())
	oBloco1 := {|| Lista->CodsGrupo >= cSubIni .AND. Lista->CodSGrupo <= cSubFim }
	DbCreate( xDbf, aStru )
	Use (xDbf) Alias xTemp Exclusive New
	WHILE Eval( oBloco1 ) .AND. Rep_Ok()
		xTemp->( DbAppend())
		For nField := 1 To FCount()
			xTemp->( FieldPut( nField, Lista->(FieldGet( nField ))))
		Next
		Lista->(DbSkip(1))
	Enddo
	Do Case
	Case nOrdem = UM	 // Numerica
		Inde On xTemp->CodGrupo+CodSGrupo+Codigo To (xNtx)
	Case nOrdem = DOIS // Alfabetica
		Inde On xTemp->CodGrupo+CodSGrupo+Descricao To (xNtx)
	Case nOrdem = TRES // N_Original
		Inde On xTemp->CodGrupo+CodSGrupo+N_Original To (xNtx)
	EndCase

ElseIF nTipo = 5
	cCodiFor := Space(QUATRO)
	MaBox( 15, 01, 17, 62 )
	@ 16, 02 Say "Fornecedor ¯¯ " Get cCodiFor Pict "9999" Valid Pagarrado( @cCodiFor, 16, 22 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Lista->(Order( LISTA_CODI ))
	IF Lista->(!DbSeek(cCodiFor))
		ErrorBeep()
		Alerta("Erro: Nenhum Produto Registrado com este Fornecedor.")
		ResTela( cScreen )
		Return
	EndIF
	Do Case
	Case nOrdem = UM	 // Numerica
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_CODIGO ))
	Case nOrdem = DOIS // Alfabetica
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_DESCRICAO ))
	Case nOrdem = TRES // N_Original
		Lista->(Order( LISTA_CODGRUPO_CODSGRUPO_N_ORIGINAL ))
	EndCase
EndIF
DbGoTop()
oMenu:Limpa()
lComEstoque := Conf("Imprimir estoque zerados ou negativos tambem ?")
IF !Instru80()
	DbGoTop()
	DbClearRel()
	IF nTipo = 2 .OR. nTipo = 3 .OR. nTipo = 4
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		Ferase( xNtx )
	EndIF
	ResTela( cScreen )
	Return
EndIF
Grupo->(Order( GRUPO_CODGRUPO ))
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
Set Rela To CodGrupo Into Grupo, CodSgrupo Into SubGrupo
Tam		  := 132
Col		  := 58
Pagina	  := 0
nCusTotal  := 0
nVarTotal  := 0
nAtaTotal  := 0
NovoGrupo  := OK
NovoSGrupo := OK
UltGrupo   := Grupo->DesGrupo
UltSGrupo  := SubGrupo->DesSGrupo
Mensagem("Aguarde, Imprimindo. ESC Cancela.")
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 58
		Write( 01, 00, Linha1(Tam, @Pagina))
		Write( 02, 00, Linha2())
		Write( 03, 00, Linha3(Tam))
		Write( 04, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 05, 00, Padc( "RELATORIO FISICO/FINANCEIRO DO ESTOQUE",Tam ) )
		Write( 06, 00, Linha5(Tam))
      Write( 07, 00, "CODIGO COD FABRICANTE  DESCRICAO DO PRODUTO                 UN   ESTOQUE    CUSTO   T. CUSTO   VAREJO  T. VAREJO  ATACADO  T. ATACDO")
		Write( 08, 00, Linha5(Tam))
		Write( 09, 00, NG + CodGrupo	+ ": " + Grupo->DesGrupo + NR )
		Write( 10, 10, NG + CodSgrupo + ": " + SubGrupo->DesSGrupo + NR )
		NovoGrupo  := FALSO
		NovoSGrupo := FALSO
		Col		  := 11
	EndIF
	IF NovoGrupo
		NovoGrupo := FALSO
		Write( Col, 00, NG + CodGrupo + ": " + Grupo->DesGrupo + NR )
		Col++
	EndIF
	IF NovoSGrupo
		NovoSGrupo := FALSO
		Write( Col, 000," ** Total **" )
      Write( Col, 080, Tran( nCusParc, "@E 9,999,999.99" ) )
      Write( Col, 100, Tran( nVarParc, "@E 9,999,999.99" ) )
      Write( Col, 120, Tran( nAtaParc, "@E 9,999,999.99" ) )
		Col += 2
		Write( Col, 10,  NG + CodSgrupo + ": " + SubGrupo->DesSGrupo + NR )
		nCusParc := 0
		nVarParc := 0
		nAtaParc := 0
		Col++
	EndIF
	nPreco1 := PCusto
	nPreco2 := Varejo
	nPreco3 := Atacado
	IF !lComEstoque
		IF Quant <= 0
			UltGrupo  := Grupo->DesGrupo
			UltSGrupo := SubGrupo->DesSGrupo
			DbSkip(1)
			IF UltGrupo != Grupo->DesGrupo
				NovoGrupo := OK
				Col++
			EndIF
			IF UltSGrupo != SubGrupo->DesSGrupo
				NovoSGrupo := OK
				Col++
			EndIF
			Loop
		EndIF
	EndIF
	IF nTipo = 5
		IF Codi != cCodiFor
			DbSkip(1)
			Loop
		EndIF
	EndIF
   Qout( Codigo, N_Original, Left(Ponto( Descricao,36),36), Un, Str(Quant,9,2),;
			Tran(nPreco1,"@E 9,999.99"),;
         Tran((nPreco1 * Quant),"@E 999,999.99" ),;
			Tran(nPreco2,"@E 9,999.99"),;
         Tran(nPreco2*Quant,"@E 999,999.99"),;
			Tran(nPreco3,"@E 9,999.99"),;
         Tran(nPreco3*Quant,"@E 999,999.99"))
	nCusTotal  += ( nPreco1 * Quant )
	nCusParc   += ( nPreco1 * Quant )
	nVarTotal  += ( nPreco2 * quant )
	nVarParc   += ( nPreco2 * Quant )
	nAtaTotal  += ( nPreco3 * Quant )
	nAtaParc   += ( nPreco3 * quant )
	Col++
	UltGrupo  := Grupo->DesGrupo
	UltSGrupo := SubGrupo->DesSGrupo
	DbSkip()
	IF Col = 62 .OR. UltGrupo != Grupo->DesGrupo .OR. UltSGrupo != SubGrupo->DesSGrupo
		IF UltGrupo != Grupo->DesGrupo
			NovoGrupo := OK
			Col++
		EndIF
		IF UltSGrupo != SubGrupo->DesSGrupo
			NovoSGrupo := OK
			Col++
		EndIF
	EndIF
	IF Col >= 58
		Col++
		Write( Col, 000," ** Total **" )
      Write( Col, 080, Tran( nCusParc, "@E 9,999,999.99" ) )
      Write( Col, 100, Tran( nVarParc, "@E 9,999,999.99" ) )
      Write( Col, 120, Tran( nAtaParc, "@E 9,999,999.99" ) )
      nCusParc := 0
      nVarParc := 0
      nAtaParc := 0
		__Eject()
	EndIF
EndDo
IF Col >= 56
	Col := 0
EndIF
Col++
Write( Col, 000," ** Total **" )
Write( Col, 080, Tran( nCusParc, "@E 9,999,999.99" ) )
Write( Col, 100, Tran( nVarParc, "@E 9,999,999.99" ) )
Write( Col, 120, Tran( nAtaParc, "@E 9,999,999.99" ) )
Col++
Write( Col, 000," ** Total Geral **" )
Write( Col, 080, Tran( nCusTotal, "@E 9,999,999.99" ) )
Write( Col, 100, Tran( nVarTotal, "@E 9,999,999.99" ) )
Write( Col, 120, Tran( nAtaTotal, "@E 9,999,999.99" ) )
__Eject()
PrintOff()
DbGoTop()
DbClearRel()
IF nTipo = 2 .OR. nTipo = 3 .OR. nTipo = 4
	xTemp->(DbCloseArea())
	Ferase( xDbf )
	Ferase( xNtx )
EndIF
ResTela( cScreen )
Return

Proc Relatori5( nTipo )  // RELATORIO DETALHADO DE SAIDAS
*********************************************************
LOCAL cScreen		:= SaveScreen()
LOCAL GetList		:= {}
LOCAL aMenuArray	:= {"Individual", "Parcial", "Por Grupo", "Por Fornecedor", "Por Vendedor", "Por Grupo/Vendedor", 'Acumulado', "Geral "}
LOCAL aMenu       := {"Codigo","Vendedor","Saida","Total Custo","Total Pvendido"}
LOCAL aMenu2      := {"Codigo","Descricao"}
LOCAL xNtx			:= FTempName()
LOCAL nChoice		:= 0
LOCAL xCodigo		:= 0
LOCAL cString		:= ''
LOCAL cNomeVen 	:= ''
LOCAL cNomeVen1	:= ''
LOCAL cNomeVen2	:= ''
LOCAL cCodiVen1	:= ''
LOCAL cCodiVen2	:= ''
LOCAL cDeleteFile := FTempName()
LOCAL aStru
LOCAL cTela

WHILE OK
	M_Title("ROL DE PRODUTOS VENDIDOS")
	nChoice := FazMenu( 00, 05, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF

	Case nChoice = 1 // Individual
		Area("Saidas")
		dIni	  := Date()-30
		dFim	  := Date()
		xCodigo := 0
		MaBox( 12, 05, 16, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Codigo..........:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigo )
		@ 14, 06 Say "Data Inicial....:" Get dIni Pict PIC_DATA
		@ 15, 06 Say "Data Final......:" Get dFim Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Lista->(Order( LISTA_CODIGO ))
		oBloco := {|| Lista->Codigo = xCodigo }
		cTela := Mensagem("Aguarde...", Cor())
		IF Lista->(!DbSeek( xCodigo ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Loop
		EndIF
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						xTemp->(DbAppend())
                  xTemp->Descricao := Lista->Descricao
                  For nField := 1 To nFCount
                     FieldPut( nField, Saidas->(FieldGet( nField )))
						Next
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
      IF nTipo = 5           // Normal
			LisSaidas( dIni, dFim )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 2 // Parcial
		Area("Saidas")
		dIni		  := Date() - 30
		dFim		  := Date()
		xCodigoIni := 0
		xCodigoFim := 0
		MaBox( 12, 05, 17, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Codigo Inicial..:" Get xCodigoIni Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigoIni )
		@ 14, 06 Say "Codigo Final....:" Get xCodigoFim Pict PIC_LISTA_CODIGO Valid CodiErrado( @xCodigoFim )
		@ 15, 06 Say "Data Inicial....:" Get dIni Pict PIC_DATA
		@ 16, 06 Say "Data Final......:" Get dFim Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Lista->(Order( LISTA_CODIGO ))
		oBloco := {|| Lista->Codigo >= xCodigoIni .AND. Lista->Codigo <= xCodigoFim }
		cTela := Mensagem("Aguarde... ", Cor())
		IF Lista->(!DbSeek( xCodigoIni ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Loop
		EndIF
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						xTemp->(DbAppend())
                  xTemp->Descricao := Lista->Descricao
                  For nField := 1 To nFCount
							FieldPut( nField, Saidas->(FieldGet( nField )))
						Next
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF nTipo = 5			  // Normal
			LisSaidas( dIni, dFim )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 3	// Por Grupo
		dIni		  := Date() - 30
		dFim		  := Date()
		cGrupoIni  := Space(03)
		cGrupoFim  := Space(03)
		MaBox( 12, 05, 17, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Grupo Inicial...:" Get cGrupoIni Pict "999" Valid GrupoCerto( @cGrupoIni, Row(), Col()+4 )
		@ 14, 06 Say "Grupo Final.....:" Get cGrupoFim Pict "999" Valid GrupoCerto( @cGrupoFim, Row(), Col()+4 )
		@ 15, 06 Say "Data Inicial....:" Get dIni      Pict PIC_DATA
		@ 16, 06 Say "Data Final......:" Get dFim      Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
		cTela  := Mensagem("Aguarde... ", Cor())
		nConta := 0
		Lista->(Order( LISTA_CODGRUPO ))
		Grupo->(Order( GRUPO_CODGRUPO ))
		Grupo->(DbSeek( cGrupoIni ))
		WHILE Grupo->CodGrupo >= cGrupoIni .AND. Grupo->CodGrupo <= cGrupoFim
			cGrupoIni := Grupo->CodGrupo
			IF Lista->(DbSeek( cGrupoIni ))
				nConta ++
				Exit
			EndIF
			Grupo->(DbSkip(1))
		EndDo
		IF nConta = 0
			Nada()
			Loop
		EndIF
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Saidas->(Order( SAIDAS_CODIGO ))
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						xTemp->(DbAppend())
                  xTemp->Descricao := Lista->Descricao
                  For nField := 1 To nFCount
							FieldPut( nField, Saidas->(FieldGet( nField )))
						Next
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF xTemp->(!Eof())
			IF nTipo = 5			  // Normal
				LisSaidas( dIni, dFim )
			Else						  // Acumulado
				LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
			EndIF
		Else
			Nada()
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 4 // Por Fornecedor
		dIni	  := Date() - 30
		dFim	  := Date()
		cCodi   := Space(04)
		MaBox( 12, 05, 16, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Fornecedor......:" Get cCodi Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+5 )
		@ 14, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
		@ 15, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Lista->(Order( LISTA_CODI ))
		oBloco := {|| Lista->Codi = cCodi }
		cTela := Mensagem("Aguarde... ", Cor())
		IF Lista->(!DbSeek( cCodi ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Loop
		EndIF
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						xTemp->(DbAppend())
                  xTemp->Descricao := Lista->Descricao
                  For nField := 1 To nFCount
							FieldPut( nField, Saidas->(FieldGet( nField )))
						Next
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF nTipo = 5			  // Normal
			LisSaidas( dIni, dFim )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 5 // Por Vendedor
		dIni	  := Date() - 30
		dFim	  := Date()
		cCodi   := Space(04)
		MaBox( 12, 05, 16, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Vendedor........:" Get cCodi Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+5 )
		@ 14, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
		@ 15, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIVEN ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		oBloco := {|| Saidas->CodiVen = cCodi }
      cTela  := Mensagem("Aguarde... ", Cor())
		IF Saidas->(!DbSeek( cCodi ))
			Nada()
			xTemp->(DbCloseArea())
			Ferase( cDeleteFile )
			Loop
		EndIF
		WHILE Saidas->(Eval( oBloco )) .AND. Rep_Ok()
			IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
				xTemp->(DbAppend())
            xTemp->Descricao := Lista->Descricao
            For nField := 1 To nFCount
					FieldPut( nField, Saidas->(FieldGet( nField )))
				Next
			EndIF
			Saidas->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF nTipo = 5			  // Normal
			LisSaidas( dIni, dFim )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 6	// Por Grupo/Vendedor
		Area("Saidas")
		dIni		  := Date() - 30
		dFim		  := Date()
		cGrupoIni  := Space(03)
		cGrupoFim  := Space(03)
		xCodigoIni := 0
		xCodigoFim := 0
		cNomeVen   := ''
		cCodi 	  := Space(04)
		MaBox( 12, 05, 18, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Vendedor........:" Get cCodi     Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+5, @cNomeVen )
		@ 14, 06 Say "Grupo Inicial...:" Get cGrupoIni Pict "999" Valid GrupoCerto( @cGrupoIni, Row(), Col()+4 )
		@ 15, 06 Say "Grupo Final.....:" Get cGrupoFim Pict "999" Valid GrupoCerto( @cGrupoFim, Row(), Col()+4 )
		@ 16, 06 Say "Data Inicial....:" Get dIni      Pict PIC_DATA
		@ 17, 06 Say "Data Final......:" Get dFim      Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		cString := 'VENDEDOR : ' + AllTrim( cNomeVen ) + ' GRUPO : ' + cGrupoIni + ' A ' + cGrupoFim + ' NO PERIODO DE ' + dToc( dIni ) + ' A ' + dToc( dFim )
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Lista->(Order( LISTA_CODGRUPO ))
		oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
		cTela := Mensagem("Aguarde... ", Cor())
		lAchou := FALSO
		WHILE Lista->(!(lAchou := DbSeek( cGrupoIni )))
			cGrupoIni := StrZero( Val( cGrupoIni ) + 1, 3 )
			IF cGrupoIni > cGrupoFim
				Nada()
				xTemp->(DbCloseArea())
				Ferase( cDeleteFile )
				Exit
			EndIF
		EndDo
		IF !lAchou
			Exit
		EndIF
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						IF Saidas->CodiVen = cCodi
							xTemp->(DbAppend())
                     xTemp->Descricao := Lista->Descricao
                     For nField := 1 To nFCount
								FieldPut( nField, Saidas->(FieldGet( nField )))
							Next
						EndIF
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		Inde On xTemp->Codigo To (xNtx )
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF nTipo = 5			  // Normal
			LisSaidas( dIni, dFim, cString )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop

	Case nChoice = 7	// Acumulado
		Area("Saidas")
		dIni		  := Date() - 30
		dFim		  := Date()
		cGrupoIni  := Space(03)
		cGrupoFim  := Space(03)
		xCodigoIni := 0
		xCodigoFim := 0
		cNomeVen1  := ''
		cNomeVen2  := ''
		cCodiVen1  := Space(04)
		cCodiVen2  := Space(04)
		MaBox( 12, 05, 19, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Vendedor Inicial:" Get cCodiVen1 Pict "9999" Valid FunErrado( @cCodiVen1,, Row(), Col()+1)
		@ 14, 06 Say "Vendedor Final..:" Get cCodiVen2 Pict "9999" Valid FunErrado( @cCodiVen2,, Row(), Col()+1)
		@ 15, 06 Say "Grupo Inicial...:" Get cGrupoIni Pict "999"  Valid GrupoCerto( @cGrupoIni, Row(), Col()+1 )
		@ 16, 06 Say "Grupo Final.....:" Get cGrupoFim Pict "999"  Valid GrupoCerto( @cGrupoFim, Row(), Col()+1 )
		@ 17, 06 Say "Data Inicial....:" Get dIni      Pict PIC_DATA
		@ 18, 06 Say "Data Final......:" Get dFim      Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		cString := 'VENDEDOR : ' + cCodiVen1 + ' A ' + cCodiVen2 + ' GRUPO : ' + cGrupoIni + ' A ' + cGrupoFim + ' NO PERIODO DE ' + dToc( dIni ) + ' A ' + dToc( dFim )
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
		cDeleteFile := FTempName()
		aStru 		:= {{ "CODIVEN",  "C", 04, 0 },;
							 { "NOME",     "C", 40, 2 },;
							 { "SAIDA",    "N", 09, 2 },;
							 { "PCUSTO",   "N", 13, 2 },;
							 { "PVENDIDO", "N", 13, 2 }}
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		Inde On xTemp->CodiVen To (xNtx )
		Lista->(Order( LISTA_CODGRUPO ))
		oBloco := {|| Lista->CodGrupo >= cGrupoIni .AND. Lista->CodGrupo <= cGrupoFim }
		cTela  := Mensagem("Aguarde... ", Cor())
		lAchou := FALSO
		WHILE Lista->(!(lAchou := DbSeek( cGrupoIni )))
			cGrupoIni := StrZero( Val( cGrupoIni ) + 1, 3 )
			IF cGrupoIni > cGrupoFim
				Nada()
				xTemp->(DbCloseArea())
				Ferase( cDeleteFile )
				Exit
			EndIF
		EndDo
		IF !lAchou
			Exit
		EndIF
		WHILE Lista->(Eval( oBloco )) .AND. Rep_Ok()
			cCodigo := Lista->Codigo
			IF Saidas->(DbSeek( cCodigo ))
				WHILE Saidas->Codigo = cCodigo
					IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
						IF Saidas->CodiVen >= cCodiVen1 .AND. Saidas->CodiVen <= cCodiVen2
							cCodiVen  := Saidas->CodiVen
							IF xTemp->(!DbSeek( cCodiVen ))
								xTemp->(DbAppend())
							EndIF
							Vendedor->(Order( VENDEDOR_CODIVEN ))
							IF Vendedor->(DbSeek( cCodiVen ))
								xTemp->Nome := Vendedor->Nome
							EndIF
							xTemp->CodiVen  := Saidas->CodiVen
							xTemp->Saida	 += Saidas->Saida
							xTemp->Pcusto	 += Saidas->Saida * Saidas->Pcusto
							xTemp->Pvendido += Saidas->Saida * Saidas->Pvendido
						EndIF
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			Lista->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		ResTela( cTela )
		IF xTemp->(Eof())
			Nada()
		Else
			WHILE OK
				oMenu:Limpa()
				M_Title("ESCOLHA A ORDEM")
				nChoice := FazMenu( 10, 05, aMenu, Cor())
				Do Case
				Case nChoice = 0
					ResTela( cScreen )
					Exit
				Case nChoice = 1
					Mensagem('Aguarde, Ordenando Registros.')
					Inde On xTemp->CodiVen To (xNtx )
					xTemp->(DbGoTop())
					LisSaiTotal( cString )
				Case nChoice = 2
					Mensagem('Aguarde, Ordenando Registros.')
					Inde On xTemp->Nome To (xNtx )
					xTemp->(DbGoTop())
					LisSaiTotal( cString )
				Case nChoice = 3
					Mensagem('Aguarde, Ordenando Registros.')
					Inde On xTemp->Saida To (xNtx )
					xTemp->(DbGoTop())
					LisSaiTotal( cString )
				Case nChoice = 4
					Mensagem('Aguarde, Ordenando Registros.')
					Inde On xTemp->Pcusto To (xNtx )
					xTemp->(DbGoTop())
					LisSaiTotal( cString )
				Case nChoice = 5
					Mensagem('Aguarde, Ordenando Registros.')
					Inde On xTemp->PVendido To (xNtx )
					xTemp->(DbGoTop())
					LisSaiTotal( cString )
				EndCase
			EndDO
		EndIF
		xTemp->(DbClearRel())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		ResTela( cScreen )
		Loop

	Case nChoice = 8 // Geral
		dIni := Date() - 30
		dFim := Date()
		MaBox( 12, 05, 15, 78, "ENTRE COM O PERIODO")
		@ 13, 06 Say "Data Inicial....:" Get dIni  Pict PIC_DATA
		@ 14, 06 Say "Data Final......:" Get dFim  Pict PIC_DATA
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Saidas")
		Saidas->(Order( SAIDAS_CODIGO ))
      nFCount     := Saidas->(FCount())
		cDeleteFile := FTempName()
		aStru 		:= Saidas->(DbStruct())
      Aadd( aStru, {"DESCRICAO",  "C", 40, 0})
		DbCreate( cDeleteFile, aStru )
		Use (cDeleteFile) Exclusive Alias xTemp New
		cTela := Mensagem("Aguarde... ", Cor())
		Saidas->(DbGoTop())
		WHILE Saidas->(!Eof())
			IF Saidas->Data >= dIni .AND. Saidas->Data <= dFim
				xTemp->(DbAppend())
            xTemp->Descricao := Lista->Descricao
            For nField := 1 To nFCount
					FieldPut( nField, Saidas->(FieldGet( nField )))
				Next
			EndIF
			Saidas->(DbSkip(1))
		EndDo
		xTemp->(DbGoTop())
		Lista->(Order( LISTA_CODIGO ))
		Set Rela To Codigo Into Lista
		ResTela( cTela )
      IndexOrdem( aMenu2, xNtx )
		IF nTipo = 5			  // Normal
			LisSaidas( dIni, dFim )
		Else						  // Acumulado
			LisSaiAcumulado( Dtoc( dIni) , dToc( dFim ))
		EndIF
		xTemp->(DbClearFilter())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( cDeleteFile )
		Ferase( xNtx )
		ResTela( cScreen )
		Loop
	EndCase
EndDo

Proc IndexOrdem( aMenu2, xNtx )
*******************************
oMenu:Limpa()
M_Title("ESCOLHA A ORDEM")
nChoice := FazMenu( 10, 05, aMenu2 )
Do Case
Case nChoice = 0
   ResTela( cScreen )
   Return
Case nChoice = 1
   Mensagem('Aguarde, Ordenando Registros.')
   Inde On xTemp->Codigo To (xNtx )
   xTemp->(DbGoTop())
Case nChoice = 2
   Mensagem('Aguarde, Ordenando Registros.')
   Inde On xTemp->Descricao To (xNtx )
   xTemp->(DbGoTop())
EndCase

Proc LisSaidas( dIni, dFIm, cString )
*************************************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenu 	  := {'Codigo', 'Descricao','Data'}
LOCAL ParCusto   := 0
LOCAL GerCusto   := 0
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodigo := OK
LOCAL nSaida	  := 0
LOCAL Total4	  := 0
LOCAL Total5	  := 0
LOCAL TotSaida   := 0
LOCAL GerSaida   := 0
LOCAL cIni		  := Dtoc( dIni )
LOCAL cFim		  := Dtoc( dFim )
LOCAL nCmv		  := 0
LOCAL nPme		  := 0
LOCAL nParCmv	  := 0
LOCAL nParPme	  := 0
LOCAL nPeriodo   := ( dFim - dIni )
LOCAL nChoice	  := 0
LOCAL UltCodigo  := Codigo
IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
IfNil( cString, '')
Mensagem(" Aguarde... Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( 'ROL DETALHADO DE SAIDAS ' + cString + 'NO PERIODO DE ' + cIni + ' A ' + cFim, Tam ))
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,'DATA     DOCTO         SAIDA      PRECO CUSTO    PRECO VENDIDO       TOTAL SAIDA      CMV                PME')
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	IF NovoCodigo .OR. Col = 8
		cDescricao := Lista->(AllTrim( Descricao))
		Write( Col, 0, NG + Lista->(Padr( Codigo + " " + cDescricao, Tam,"Ä")) + NR)
		IF NovoCodigo
			TotSaida   := 0
			GerSaida   := 0
			ParCusto   := 0
			NovoCodigo := FALSO
		EndIF
		Col++
	EndIF
	nCmv := (( Pcusto / PVendido ) * 100 )
	nPme := (( Pcusto * nPeriodo ) / 30 )
	Qout( Data, Fatura, Saida, Tran( Pcusto,				 "@E 9,999,999,999.99"),;
										Tran( Pvendido,			 "@E 9,999,999,999.99"),;
										Tran( Pvendido * Saida,  "@E 99,999,999,999.99"),;
										Tran( nCmv, 				 "@E 9,999.99%"),;
										Tran( nPme, 				 "@E 99,999,999,999.99"))
	ParCusto += (Saida * PCusto)
	GerCusto += (Saida * PCusto)
	TotSaida += Saida
	GerSaida += (Saida * Pvendido)
	nSaida	+= Saida
	Total4	+= (Saida * Pvendido)
	nParCmv	:= (( ParCusto / GerSaida ) * 100 )
	nParPme	:= (( GerSaida * nPeriodo ) / 30 )
	Col++
	DbSkip()
	IF UltCodigo != Codigo .OR. Eof()
		UltCodigo  := Codigo
		NovoCodigo := OK
		Col++
		Write( Col, 00, "* Total Codigo *" )
		Write( Col, 19, Tran( TotSaida, "@E 999999.99" ) )
		Write( Col, 29, Tran( ParCusto, "@E 9,999,999,999.99" ))
		Write( Col, 62, Tran( GerSaida, "@E 999,999,999,999.99"))
		Write( Col, 81, Tran( nParCmv,  "@E 9,999.99%"))
		Write( Col, 90, Tran( nParPme,  "@E 999,999,999,999.99"))
		Col += 2
	EndIF
	IF Col >= 58
		__Eject()
	EndIF
EndDo
Col++
nParCmv	:= (( GerCusto / Total4 ) * 100 )
nParPme	:= (( Total4 * nPeriodo ) / 30 )
Write( Col, 00, "* Total Geral *" )
Write( Col, 19, Tran( nSaida,   "@E 999999.99" ) )
Write( Col, 29, Tran( GerCusto, "@E 9,999,999,999.99" ))
Write( Col, 62, Tran( Total4,   "@E 999,999,999,999.99" ))
Write( Col, 81, Tran( nParCmv,  "@E 9,999.99%"))
Write( Col, 90, Tran( nParPme,  "@E 999,999,999,999.99"))
__Eject()
PrintOff()
Saidas->( DbClearRel())
Return

Proc LisSaiAcumulado( cIni, cFim )
**********************************
LOCAL cScreen		  := SaveScreen()
LOCAL nSomaQuant	  := 0
LOCAL nMediaCusto   := 0
LOCAL nMediaVendido := 0
LOCAL nSomaVendido  := 0
LOCAL nSomaCusto	  := 0
LOCAL nTempCusto	  := 0
LOCAL nTempVenda	  := 0
LOCAL Tam			  := 132
LOCAL Col			  := 0
LOCAL Pagina		  := 0
LOCAL cCodigo		  := Codigo
LOCAL cDescricao	  := Lista->Descricao
LOCAL nQuant		  := 0
LOCAL nCusto		  := 0
LOCAL nVenda		  := 0
LOCAL nTotalNff	  := 0
LOCAL lPontuar 	  := FALSO
LOCAL nIndice		  := oIni:ReadInteger('ecf', 'indice', 1.25 )

ErrorBeep()
lPontuar := Conf("Pergunta: Somente Pontuar ?")
IF !InsTru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Lista->Usa = OK
		DbSkip(1)
		Loop
	EndIF
	cCodigo	  := Codigo
	cDescricao := Lista->Descricao
	IF Col = 0
		IF Pagina >0
			__Eject()
		EndIF
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
		Write( 04, 00, Padc( "RELATORIO ACUMULADO DE SAIDAS DE MERCADORIAS NO PERIODO DE " + cIni + " a " + cFim, Tam ) )
		Write( 05, 00, Linha5(Tam))
		IF lPontuar
			Write( 06, 00,"CODIGO DESCRICAO DO PRODUTO                        SAIDA        NFF 1234567890123456789012345678901234567890123456789012345678901234")
		Else
			Write( 06, 00,"CODIGO DESCRICAO DO PRODUTO                        SAIDA    MEDIA CUSTO    TOTAL CUSTO  MEDIA VENDIDO  TOTAL VENDIDO            NFF")
		EndIF
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIF
	nSomaQuant	  := 0
	nMediaCusto   := 0
	nMediaVendido := 0
	nSomaVendido  := 0
	nSomaCusto	  := 0
	nTempCusto	  := 0
	nTempVenda	  := 0
	While Codigo = cCodigo
		nSomaQuant	 += Saida
		nTempCusto	 := IF( Pcusto 	 = 0, Lista->Pcusto, Pcusto	)
		nTempVenda	 := IF( Pvendido	 = 0, Lista->Varejo, PVendido )
		nTempCusto	 := IF( nTempCusto = 0, Pvendido / Lista->MarVar, nTempCusto )
		nTempCusto	 := IF( nTempCusto = 0, Pvendido / 1.5,			  nTempCusto )
		nSomaCusto	 += Saida * nTempCusto
		nSomaVendido += Saida * nTempVenda
		DbSkip(1)
	EndDo
	nMediaCusto   := nSomaCusto	/ nSomaQuant
	nMediaVendido := nSomaVendido / nSomaQuant
	nTotalNff	  += ( nMediaCusto * nIndice ) * nSomaQuant
	IF lPontuar
		IF nSomaQuant > 64
			While nSomaQuant > 64
				nSomaQuant -= 64
				Qout( cCodigo,cDescricao,;
								  Tran( 64, "9,999.99"),;
								  Tran( nMediaCusto * nIndice,  "@E 999,999.99"),;
								 Repl("O", 64 ))
				Col++
			EndDo
		EndIF
		Qout( cCodigo,cDescricao,;
						  Tran( nSomaQuant,	  "9,999.99"),;
						  Tran( nMediaCusto * nIndice,  "@E 999,999.99"),;
						  Repl("O", nSomaQuant ))
	Else
		Qout( cCodigo,cDescricao,;
						  Tran( nSomaQuant,	  "9,999.99"),;
						  Tran( nMediaCusto,   "@E 999,999,999.99"),;
						  Tran( nSomaCusto,	  "@E 999,999,999.99"),;
						  Tran( nMediaVendido, "@E 999,999,999.99"),;
						  Tran( nSomaVendido,  "@E 999,999,999.99"),;
						  Tran( nMediaCusto * nIndice,  "@E 999,999,999.99"))
	EndIF
	Col++
	nQuant += nSomaQuant
	nCusto += nSomaCusto
	nVenda += nSomaVendido
	IF Col >= 56
		Qout()
		Qout( "***Total***", Space(35),;
						  Tran( nQuant,	 "9,999.99"),;
						  Tran( 0,			 "@E 999,999,999.99"),;
						  Tran( nCusto,	 "@E 999,999,999.99"),;
						  Tran( 0,			 "@E 999,999,999.99"),;
						  Tran( nVenda,	 "@E 999,999,999.99"),;
						  Tran( nTotalNff, "@E 999,999,999.99"))
		Col := 0
	EndIF
EndDo
IF nQuant >0
	Qout()
	Qout( "***Geral***", Space(35),;
					  Tran( nQuant,	 "9,999.99"),;
					  Tran( 0,			 "@E 999,999,999.99"),;
					  Tran( nCusto,	 "@E 999,999,999.99"),;
					  Tran( 0,			 "@E 999,999,999.99"),;
					  Tran( nVenda,	 "@E 999,999,999.99"),;
					  Tran( nTotalNff, "@E 999,999,999.99"))
	__Eject()
EndIF
PrintOff()
Saidas->( DbClearRel())
Return
