/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³																								 ³
 Ý³	Programa.....: RECELAN.PRG 														 ³
 Ý³	Aplicacaoo...: SISTEMA DE CONTAS A RECEBER									 ³
 Ý³   Versao.......: 3.3.00                                                 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³	Ult.Atual....: 03 de Agosto de 2003.											 ³
 Ý³	Compilacao...: Clipper 5.02														 ³
 Ý³	Linker.......: Blinker 5.10														 ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "hbclass.ch"
#Include "lista.ch"
#Include "inkey.ch"
#Include "indice.ch"
#Include "picture.ch"
#Include "permissao.ch"
#Include "achoice.ch"
#Include "fileio.ch"
#xcommand PUBLIC:     =>   nScope := HB_OO_CLSTP_EXPORTED ; HB_SYMBOL_UNUSED( nScope )

Proc Recelan()
**************
LOCAL Op          := 1
LOCAL lOk			:= OK
PUBLI cVendedor   := Space(40)
PUBLI cCaixa		:= Space(04)

*:=======================================================================================================
AbreArea()
oMenu:Limpa()
IF !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	Return
EndIF
*:=======================================================================================================
SetKey( -4, 		  {|| ClientesDbEdit() })
SetKey( -7, 		  {|| AcionaSpooler()})
SetKey( 23, 		  {|| GravaDisco()})
//SetKey( F2,         {|| BaixasRece( cCaixa, cVendedor )})
SetKey( TECLA_ALTC, {|| Altc()})
oMenu:Limpa()
*:=======================================================================================================
Op := 1
RefreshClasse()
WHILE lOk
	BEGIN Sequence
		Op := oMenu:Show()
		oAmbiente:cTipoRecibo := "RECCAR"
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Encerrar este modulo ?")
            oMenu:nPos := 1
				GravaDisco()
				lOk := FALSO
				Break
			EndIF
		Case op = 2.01 ; CliInclusao()
		Case op = 2.02 ; CliAltera()
		Case op = 2.03 ; CliAltera()
		Case op = 2.04 ; CliAltera()
		Case op = 2.05 ; ClientesFiltro()
		Case op = 2.06 ; ClientesDbedit()
		Case op = 2.07 ; MarDesmarcaCliente()
		Case op = 2.08 ; AnexarAgendaAntiga()
		Case op = 2.09 ; AnexarLogRecibo()
      Case op = 2.10 ; BidoToRecibo()
      Case op = 2.11 ; FoneTroca()
		Case op = 3.01 ; AlteraReceber()
		Case op = 3.02 ; AlteraRecebido()
      Case op = 3.03 ; MenuTxJuros(op)
      Case op = 3.04 ; MenuTxJuros(op)
		Case op = 3.05 ; AltRegTitRec()
		Case op = 3.06 ; AltRegTitPag()
		Case op = 3.07 ; ReajTitulos()
		Case op = 3.08 ; RemoveCobranca()
		Case op = 3.09 ; RemoveAgenda()
		Case op = 3.10 ; AltRegCfop()
		Case op = 3.11 ; TrocaCliente(cCaixa)
		Case op = 3.12 ; TrocaCobAgenda()
		Case op = 3.13 ; AgendaDbedit()
		Case op = 4.01 ; Lancamentos(cCaixa)
		Case op = 4.02
			IF PodeReceber()
				BaixasRece( cCaixa, cVendedor )
			EndIF
		Case op = 4.03 ; Exclusao()
		Case op = 4.04 ; FechtoMes()
		Case op = 4.05 ; AgeCobranca()
		Case op = 4.06 ; ImpExpDados()
		Case op = 4.07 ; CancelaContrato()
		Case op = 4.08 ; LancaDespesasDiversas(cCaixa, cVendedor, 'RECIBO')
		Case op = 5.01 ; RelCli()
		Case op = 5.02 ; RelReceber()
		Case op = 5.03 ; RelRecebido()
		Case op = 5.04 ; EtiquetasClientes()
		Case op = 5.05 ; CobTitulo()
		Case op = 5.06 ; Extrato()
      Case op = 5.07 ; MenuDuplicata()
      Case op = 5.08 ; DiretaLivre()
      Case op = 5.09 ; MenuPromissoria()
      Case op = 5.10
			#IFDEF CENTRALCALCADOS
				Alert("Erro: Nao Disponivel")
			#ELSE
				ReciboRegiao()
			#ENDIF
      Case op = 5.11
			#IFDEF CENTRALCALCADOS
				Alert("Erro: Nao Disponivel")
			#ELSE
				ReciboIndividual(cCaixa, cVendedor)
			#ENDIF
      Case op = 5.12 ; ReciboDiv( cCaixa, cVendedor )
      Case op = 5.13 ; Carta( FALSO )
      Case op = 5.14 ; CarnePag()
      Case op = 5.15 ; CarneCaixa()
      Case op = 5.16 ; CarneRec()
      Case op = 5.17 ; CartaSpc()
      Case op = 5.18 ; PrnDiversos(NIL,NIL,NIL, cVendedor)
      Case op = 5.19 ; FichaAtendimento( cCaixa, cVendedor )
      Case Op = 6.01 ; PosiReceber( 1, NIL, cCaixa )
		Case Op = 6.02 ; PosiReceber( 2, NIL, cCaixa )
		Case Op = 6.03 ; PosiReceber( 3, NIL, cCaixa )
      Case Op = 6.04 ; PosiReceber( 4, NIL, cCaixa )
      Case Op = 6.05 ; PosiReceber( 5, NIL, cCaixa )
      Case Op = 6.06 ; PosiReceber( 6, NIL, cCaixa )
      Case Op = 6.07 ; PosiReceber( 1, NIL, cCaixa, OK )		
		Case Op = 6.08 
		   oAmbiente:cTipoRecibo := "RECBCO"
			PosiReceber( 1, NIL, cCaixa )
			oAmbiente:cTipoRecibo := "RECCAR"
		Case Op = 6.09 
		   oAmbiente:cTipoRecibo := "RECOUT"
			PosiReceber( 1, NIL, cCaixa )
			oAmbiente:cTipoRecibo := "RECCAR"
		Case Op = 6.11 ; PosiReceber( 3, NIL, cCaixa, NIL, NIL, (oAmbiente:cTipoRecibo := "RECCAR"))
      Case Op = 6.12 ; PosiReceber( 3, NIL, cCaixa, NIL, NIL, (oAmbiente:cTipoRecibo := "RECBCO"))
      Case Op = 6.13 ; PosiReceber( 3, NIL, cCaixa, NIL, NIL, (oAmbiente:cTipoRecibo := "RECOUT"))
		Case Op = 6.14 ; PosiReceber( 3, NIL, cCaixa, NIL, NIL, (oAmbiente:cTipoRecibo := "RECALL"))
      Case Op = 6.16 ; ReceGrafico()
      Case Op = 6.18 ; PosiAgeInd()
      Case Op = 6.19 ; PosiAgeReg()
      Case Op = 6.20 ; PosiAgeAll()
      Case Op = 6.21 ; SuporteIni()
      Case Op = 6.22 ; SuporteRecibo()

      Case Op = 7.01 ; RecePago( 1 )
      Case Op = 7.02 ; RecePago( 2 )
      Case Op = 7.03 ; RecePago( 3 )
      Case Op = 7.04 ; RecePago( 4 )
      Case Op = 7.05 ; RecePago( 5 )
      Case Op = 7.07 ; BidoGrafico(Op)
      Case Op = 7.08 ; BidoGrafico(Op)
      Case Op = 7.09 ; BidoGrafico(Op)
      Case Op = 7.10 ; BidoGrafico(Op)
      Case Op = 7.12 ; PosiAgeInd()
      Case Op = 7.13 ; PosiAgeReg()
      Case Op = 7.14 ; PosiAgeAll()
      Case Op = 7.15 ; SuporteIni()
      Case Op = 7.16 ; SuporteRecibo()

      Case op = 8.01 ; RegiaoInclusao()
      Case op = 8.02 ; RegiaoConsulta()
      Case op = 8.03 ; RegiaoConsulta()
      Case op = 8.04 ; RegiaoConsulta()

      Case op = 9.01 ; CepInclusao()
      Case op = 9.02 ; MudaCep()
      Case op = 9.03 ; MudaCep()
      Case op = 9.04 ; MudaCep()
      Case op = 9.05 ; CepPrint()

      Case op = 10.01 ; LogConsulta()
      Case op = 10.02 ; ReciboDbedit()

      Case op = 11.01 ; CmInclusao()
      Case op = 11.02 ; CmDbEdit()
      Case op = 11.03 ; CmDbEdit()
      Case op = 11.04 ; CmDbEdit()
      Case op = 11.05 ; CmDbEdit()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde, Fechando Arquivos." )
FechaTudo()
Set KEY F2 TO
Set KEY F3 TO
Return

*:==================================================================================================================================

Function oMenuRecelan()
***********************
LOCAL AtPrompt := {}
LOCAL cStr_Suporte
LOCAL cStr_Recibo

IF !aPermissao[SCI_CONTAS_A_RECEBER]
	Return( AtPrompt )
EndIF

IF oAmbiente:Mostrar_Desativados
	cStr_Suporte := "Esconder Posicao Clientes Inativos"
Else
	cStr_Suporte := "Mostrar Posicao Clientes Inativos"
EndIF
IF oAmbiente:Mostrar_Recibo
	cStr_Recibo := "Desativar Checagem de Recibos"
Else
	cStr_Recibo := "Ativar Checagem de Recibos"
EndIF
AADD( AtPrompt, {"S^air",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"C^liente",     {"Inclusao",;
                                  "Alteracao",;
										    "Exclusao",;
											 "Consulta",;
											 "Consulta por Filtro",;
											 "Pesq/Altera Todos",;
											 "Marcar/Desmarcar Cliente",;
											 "Anexar Agenda Antiga",;
                                  "Anexar Arquivo RECIBO.LOG",;
                                  "Recebido To Recibo",;
                                  "Ajustar Campo Telefone"}})

AADD( AtPrompt, {"A^ltera",      {"Titulos a Receber",;
											 "Titulos Recebidos",;
											 "Taxa de Juro Geral",;
											 "Taxa de Juro Individual",;
											 "Regiao de Titulos a Receber",;
											 "Regiao de Titulos Recebidos",;
											 "Reajuste de Titulos",;
											 "Remover Comissao Cobrador",;
                                  'Remover Agendamento',;
											 "Cfop por Regiao",;
											 "Cliente de Fatura",;
											 "Cobrador do Agendamento",;
											 "Agendamento"}})

AADD( AtPrompt, {"L^ancamento", {"Titulos a Receber",;
											"Baixa de Recebimentos",;
											"Exclusao de Titulo",;
											"Fechamento Periodico",;
											"Agendamento de Cobranca",;
											'Imp/Exportacao Dados Externos',;
											'Cancelamento Contrato',;
											'Despesas Diversas'}})

AADD( AtPrompt, {"I^mpressao",   {"Ficha/Relacao de Clientes",;
                                  "Titulos a Receber",;
                                  "Titulos Recebidos",;
                                  "Etiquetas Clientes",;
                                  "Carta Cobranca Titulos",;
                                  "Extrato de Conta",;
                                  "Duplicata",;
                                  "Boleto Bancario",;
                                  "Promissoria",;
                                  "Recibo Por Regiao",;
                                  "Recibo Individual",;
                                  "Recibo/Vale Diversos",;
                                  "Mala Direta",;
                                  "Carne de Pagamento",;
                                  "Carne de Pagamento Caixa",;
                                  "Carne de Recebimento",;
                                  "Negativar Clientes no Spc",;
                                  "Documentos Diveros",;
                                  "Ficha Atendimento/Ativacao"}})

AADD( AtPrompt, {"R^eceber",     {"Consulta/Recibo Por C^liente",;
                                  "Consulta/Recibo Por R^egiao",;
                                  "Consulta/Recibo Por P^eriodo",;
                                  "Consulta/Recibo Por T^ipo",;
                                  "Consulta/Recibo Por F^atura",;
                                  "Consulta/Recibo G^eral",;
                                  "Consulta/Recibo Para Re^scisao",;
											 "Consulta/Recibo B^anco",;
											 "Consulta/Recibo O^utros",;
                                  "",;
											 "Consulta Recebido C^arteira",;
                                  "Consulta Recebido B^anco",;
                                  "Consulta Recebido O^utros",;
											 "Consulta Recebido G^eral",;
                                  "",;
                                  "G^rafico de Contas a Receber",;
                                  "",;
                                  "Agendamento I^ndividual",;
                                  "Agendamento por Regiao",;
                                  "Agendamento por Periodo",;
                                  cStr_Suporte,;
                                  cStr_Recibo }})

AADD( AtPrompt, {"R^ecebido",    {"Recebido Por Cliente",;
                                  "Recebido Por Periodo",;
                                  "Recebido por Regiao",;
                                  "Recebido for Fatura",;
                                  "Recebido Geral",;
                                  "",;
                                  "Grafico de Contas Recebidas em Carteira",;
                                  "Grafico de Contas Recebidas em Banco",;
                                  "Grafico de Contas Recebidas em Outros",;
                                  "Grafico de Contas Recebidas Geral",;
                                  "",;
                                  "Agendamento individual",;
                                  "Agendamento por regiao",;
                                  "Agendamento por periodo",;
                                  cStr_Suporte,;
                                  cStr_Recibo }})
Aadd( AtPrompt, {"R^egiao",      {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta"}})
Aadd( AtPrompt, {"C^ep",         {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta",;
                                  "Impressao"}})
Aadd( AtPrompt, {"R^ecibo",      {"Consulta Log",;
                                  "Em tabela"}})
Aadd( AtPrompt, {"C^m",          {"Inclusao",;
                                  "Alteracao",;
                                  "Exclusao",;
                                  "Consulta",;
                                  "Em tabela"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispRecelan()
**********************
LOCAL oRecelan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuRecelan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

Mensagem("Aguarde, Verificando Diretivas do CONTAS A RECEBER.")
Return( aDisp := ReadIni("recelan", nMenuH, aMenuV, AtPrompt, aDisp, oRecelan))

*:==================================================================================================================================

Proc LogConsulta()
******************
LOCAL cFile := "RECIBO.LOG"
oMenu:Limpa()
IF File( cFile )
	M_Title("LOG DOS RECIBOS EMITIDOS")
	M_View( 00, 00, LastRow(), LastCol(), cFile,  Cor())
Else
	ErrorBeep()
	Alerta("Erro: Arquivo " + cFile + " nao localizado.", Cor())
EndIF

*:==================================================================================================================================

STATIC Proc RefreshClasse()
***************************
oMenu:StatusSup		:= oMenu:StSupArray[CONTAS_A_RECEBER]
oMenu:StatusInf		:= oMenu:StInfArray[CONTAS_A_RECEBER]
oMenu:Menu				:= oMenu:MenuArray[CONTAS_A_RECEBER]
oMenu:Disp				:= oMenu:DispArray[CONTAS_A_RECEBER]
Return

Proc SuporteRecibo()
********************
LOCAL lMostrar := oAmbiente:Mostrar_Recibo

oAmbiente:Mostrar_Recibo := !lMostrar
oIni:WriteBool('sistema', 'Mostrar_Recibo', !lMostrar )
Alerta("Info: Consulta Recibo foi "+ IF(!lMostrar,"LIGADO","DESLIGADO"))
oMenu:Menu := oMenuRecelan()
//oMenu:refresh(CONTAS_A_RECEBER)
Return

*:==================================================================================================================================

Proc SuporteIni()
*****************
LOCAL lMostrar := oAmbiente:Mostrar_Desativados

oAmbiente:Mostrar_Desativados := !lMostrar
oIni:WriteBool('sistema', 'Mostrar_Desativados', !lMostrar )
Alerta("Info: Consulta dos Clientes Desativados foi "+ IF(!lMostrar,"LIGADO","DESLIGADO"))
oMenu:Menu := oMenuRecelan()
//oMenu:refresh(CONTAS_A_RECEBER)
Return

*:==================================================================================================================================

Proc Extrato()
**************
LOCAL GetList   := {}
LOCAL cScreen   := SaveScreen()
LOCAL aMenu     := {'Individual','Por Regiao','Geral'}
LOCAL aMenu1    := {'Normal Carteira','Para Tribunal'}
LOCAL lTribunal := FALSO

LOCAL nChoice := 0
LOCAL oBloco
LOCAL cCodi
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL dCalculo
FIELD Codi


WHILE OK
	oMenu:Limpa()
	M_Title("FINALIDADE DO EXTRATO DE CONTA" )
	lTribunal := (FazMenu( 03, 20, aMenu1)) == 2
	
	if LastKey() = ESC
		ResTela( cScreen )
		Return
	endif
	
	M_Title("ESCOLHA O EXTRATO DE CONTA" )
	nChoice := FazMenu( 09, 20, aMenu )
	
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cCodi    := Space(05)
		dIni     := Ctod("01/01/91")
      dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
      dCalculo := Date()
		MaBox( 16, 20, 21, 80 )
		@ 17, 21 Say "Cliente......:" Get cCodi    Pict "99999"  Valid RecErrado( @cCodi )
		@ 18, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 19, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 20, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 		
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Filtrando Registros.")
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI_VCTO ))
		IF Recemov->(!DbSeek( cCodi ))
			Nada()
			Loop
		EndIF
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->Codi = cCodi }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop

	Case nChoice = 2
		cRegiao  := Space(02)
		dIni     := Ctod("01/01/91")
      dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
      dCalculo := Date()
		MaBox( 16, 20, 21, 50 )
		@ 17, 21 Say "Regiao.......:" Get cRegiao Pict '99' Valid RegiaoErrada( @cRegiao )
		@ 18, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 19, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 20, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Filtrando Registros.")
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_REGIAO_CODI ))
		IF Recemov->(!DbSeek( cRegiao ))
			Nada()
			Loop
		EndIF
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->Regiao = cRegiao }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop

	Case nChoice = 3
		MaBox( 16, 20, 20, 50 )
		@ 17, 21 Say "Data Inicial.:" Get dIni     Pict PIC_DATA Valid AchaUltVcto(cCodi, @dFim)
      @ 18, 21 Say "Data Final...:" Get dFim     Pict PIC_DATA 
      @ 19, 21 Say "Data Calculo.:" Get dCalculo Pict PIC_DATA 
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI_VCTO ))
		Recemov->(DbGotop())
		IF Recemov->(Eof())
			Nada()
			Loop
		EndIF
		Mensagem("Aguarde, Filtrando Registros.")
		Set Rela To Recemov->Codi Into Receber
		oBloco := {|| Recemov->(!Eof()) }
		ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
		Recemov->(DbClearRel())
		Recemov->(DbGoTop())
		Loop
	EndCase
EndDo

*:==================================================================================================================================

Proc LancaDespesasDiversas( cCaixa, cVendedor, cTipo )
******************************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx1  := Space(04)
LOCAL cCodiCx2  := Space(04)
LOCAL dData     := Date()
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL cDc1		 := 'D'
LOCAL cDc2		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow
LOCAL cNomeFir
LOCAL cStr
LOCAL oObj

cNome 	:= Space(40)
cEnde 	:= Space(40)
cCida 	:= Space(40)
cHist 	:= Space(40)
cRef		:= Space(40)
cCodiCx1 := Space(04)
cCodiCx2 := Space(04)
cCodiCx	:= '0000'
cDc		:= 'D'
cDc1		:= 'D'
cDc2		:= 'D'
nValor	:= 0
cNomeFir := oAmbiente:xNomefir
o1       := TLancaDespesasDiversas():New()

WHILE OK
	o1:GeraDocnr()
	nTamDoc	:= Len( o1:cDocnr)
	oMenu:Limpa()
	MaBox( 10, 00, 20, 79, 'LANCAMENTO DE DESPESAS DIVERSAS' )
   @ 11, 01 Say "Nome Emitente..: " Get cNome    Pict "@!" Valid IF(Empty(cNome),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!"), FALSO ), OK )
	@ 12, 01 Say "Referente......: " Get cRef     Pict "@!" Valid IF(Empty(cRef),   ( ErrorBeep(), Alerta("Ooops!: Entre com a referencia!"), FALSO ), (ValidarcHist(cRef,@cHist), OK))
	@ 13, 01 Say "Historico Cx...: " Get cHist    Pict "@!" Valid IF(Empty(cHist),  ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	@ 14, 01 Say "Data...........: " Get dData    Pict PIC_DATA Valid IF(Empty(dData), ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 15, 01 Say "Documento #....: " Get o1:cDocnr   Pict "@!" Valid CheqDoc(o1:cDocnr)
	@ 16, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid IF(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 17, 01 Say "Conta Caixa....: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), 32, OK )
	@ 17, 24 Say "D/C.:"             GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
	@ 18, 01 Say "C. Partida.....: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), 32, OK )
	@ 18, 24 Say "D/C.:"             GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
	@ 19, 01 Say "C. Partida.....: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), 32, OK )
	@ 19, 24 Say "D/C.:"             GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	EndIF
	nVlrLcto := nValor
	IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF
	*:-------------------------------------------------------
	IF Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc1 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx1
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF
	
	*:-------------------------------------------------------
	
	IF Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc2 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx2
				Chemov->Docnr	:= o1:cDocnr
				Chemov->Emis	:= dData
				Chemov->Data	:= dData
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := o1:cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF

	*:-------------------------------------------------------

   IF Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := Date()
      Recibo->Tipo    := "PAGDIV"
      Recibo->Codi    := "00000"
		Recibo->Docnr	 := o1:cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := dData
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))
      Recibo->Caixa   := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF
	
EndDo

*:==================================================================================================================================

CLASS TLancaDespesasDiversas
   DATA 	 cDocnr     		INIT Space(9)
	DATA 	 Contador			INIT 0
	METHOD New 					INLINE self
//	METHOD New 					INLINE ::GeraDocnr
	METHOD GeraDocnr	
END CLASS

METHOD GeraDocnr class TLancaDespesasDiversas  
****************
	::cDocnr	:= StrZero(Day(Date()),2)
	::cDocnr += StrZero(Month(Date()),2)
	::cDocnr += Right(StrZero(Year(Date()),4),2)
	::cDocnr += '-'
	::cDocnr += StrZero(++::Contador, 2)
	return self

*:==================================================================================================================================

Proc TrocaCobAgenda()
********************
LOCAL aMenu 	 := {'Por Cobrador','Por Cliente','Geral'}
LOCAL cScreen	 := SaveScreen()
LOCAL cCodiVen  := Space(04)
LOCAL cCobrador := Space(04)
LOCAL cCodi 	 := Space(05)
LOCAL nChoice	 := 0

WHILE OK
	oMenu:Limpa()
	M_Title('TROCA COBRADOR DO AGENDAMENTO')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cCodiVen  := Space( 04 )
		cCobrador := Space( 04 )
		MaBox( 10, 10, 13, 78 )
		@ 11 , 11 Say "Cobrador Anterior.:" Get cCodiVen  Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		@ 12 , 11 Say "Cobrador Atual....:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		If Conf("Pergunta: A troca podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Trocando de cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				IF Recemov->Cobrador = cCodiVen
					IF Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					EndIF
				EndIF
			  Recemov->(DbSkip(1))
			EndDo
		EndIf

	Case nChoice = 2
		cCodi 	 := Space(05)
		cCobrador := Space(04)
		MaBox( 10, 10, 13, 78 )
		@ 11, 11 Say "Cliente.......:" Get cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		@ 12, 11 Say "Novo Cobrador.:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		IF Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Trocando de cobrador.")
			Recemov->(Order( RECEMOV_CODI ))
			IF Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					IF Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					EndIF
					Recemov->(DbSkip(1))
				EndDo
			EndIf
		EndIF

	Case nChoice = 3
		cCobrador := Space(04)
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Novo Cobrador.:" Get cCobrador Pict "9999" Valid FunErrado( @cCobrador,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		If Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Trocando de cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				IF !Empty( Recemov->Cobrador)
					IF Recemov->(TravaReg())
						Recemov->Cobrador := cCobrador
						Recemov->RelCob	:= OK
						Recemov->(Libera())
					EndIF
				EndIF
				Recemov->(DbSkip(1))
			EndDo
		EndIF
	EndCase
EndDo

*:==================================================================================================================================

Proc RemoveCobranca()
*********************
LOCAL aMenu 	:= {'Por Cobrador','Por Cliente','Geral'}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodiVen := Space(04)
LOCAL cCodi 	:= Space(05)
LOCAL nChoice	:= 0

WHILE OK
	oMenu:Limpa()
	M_Title('REMOVE COMISSAO COBRADOR')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		MaBox( 10, 10, 12, 78 )
		cCodiVen := Space( 04 )
		@ 11 , 11 Say "Cobrador..:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		If Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				IF Recemov->Cobrador = cCodiVen
					IF Recemov->(TravaReg())
						Recemov->Cobrador := Space(04)
						Recemov->RelCob	:= FALSO
						Recemov->(Libera())
					EndIF
				EndIF
			  Recemov->(DbSkip(1))
			EndDo
		EndIf

	Case nChoice = 2
		cCodi := Space( 05 )
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		IF Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			Recemov->(Order( RECEMOV_CODI ))
			IF Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					IF Recemov->(TravaReg())
						Recemov->Cobrador := Space(04)
						Recemov->RelCob	:= FALSO
						Recemov->(Libera())
					EndIF
					Recemov->(DbSkip(1))
				EndDo
			EndIf
		EndIF

	Case nChoice = 3
		ErrorBeep()
		If Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Limpando Comissao Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				IF Recemov->(TravaReg())
					Recemov->Cobrador := Space(04)
					Recemov->RelCob	:= FALSO
					Recemov->(Libera())
				EndIF
				Recemov->(DbSkip(1))
			EndDo
		EndIF
	EndCase
EndDo

*:==================================================================================================================================

Function ClientesFiltro()
*************************
LOCAL cScreen	:= SaveScreen()
LOCAL AtPrompt := {"Por Codigo", "Por Cidade", "Por Estado", "Por Regiao", "Todos"}
LOCAL xAlias	:= FTempName()
LOCAL xNtx		:= FTempName()
LOCAL cCodi 	:= Space(05)
LOCAL cCida 	:= Space(25)
LOCAL cEsta 	:= Space(02)
LOCAL cRegiao	:= Space(02)
LOCAL Op1		:= 0
LOCAL aStru
LOCAL nLen
LOCAL nField

Area("Receber")
Receber->(DbGoTop())
IF Receber->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	M_Title( "ESCOLHA A OPCAO DE CONSULTA" )
	Op1	:= FazMenu( 04, 10, AtPrompt, Cor() )
	Do Case
	Case Op1 = 0
		ResTela( cScreen )
		Exit

	Case Op1 = 1
		MaBox( 13, 10, 15, 26 )
		cCodi := Space( 05 )
		@ 14 , 11 Say "Codigo..:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		Read

		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF

		cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		nLen := Receber->(FCount())
		IF Receber->(DbSeek( cCodi ))
			While ( Receber->Codi = cCodi .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		EndIF
		xTemp->(DbGoTop())
		IF xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		Else
		  CliFiltro()
		EndIf
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 2
		MaBox( 13, 10, 15, 47 )
		cCida := Space( 25 )
		@ 14, 11 Say "Cidade..:" GET cCida PICT "@!"
		Read

		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF

		cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_CIDA ))
		nLen := Receber->(FCount())
		IF Receber->(DbSeek( cCida ))
			While ( Receber->Cida = cCida .AND. Receber->(!Eof()).AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		EndIF
		xTemp->(DbGoTop())
		IF xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		Else
		  CliFiltro()
		EndIF
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 3
		MaBox( 13, 10, 15, 24 )
		cEsta := Space( 02 )
		@ 14 , 11 Say "Estado..:" GET cEsta PICT "@!"
		Read

		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF

		cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_ESTA ))
		nLen := Receber->(FCount())
		IF Receber->(DbSeek( cEsta ))
			While ( Receber->Esta = cEsta .AND. Receber->(!Eof()) .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		EndIF
		xTemp->(DbGoTop())
		IF xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		Else
			CliFiltro()
		EndIF
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 4
		MaBox( 13, 10, 15, 24 )
		cRegiao := Space(2)
		@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
		Read

		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF

		cTela   := Mensagem(" Aguarde, Filtrando Registros. ", WARNING )
		aStru   := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Area("Receber")
		Receber->(Order( RECEBER_REGIAO ))
		nLen := Receber->(FCount())
		IF Receber->(DbSeek( cRegiao ))
			While ( Receber->Regiao = cRegiao .AND. Rep_Ok() )
				xTemp->(DbAppend())
				For nField := 1 To nLen
					xTemp->( FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
				Receber->(DbSkip(1))
			EndDo
		EndIF
		xTemp->(DbGoTop())
		IF xTemp->(Eof())  // Nenhum Registro
			Alerta("Erro: Nenhum Cliente Atende a Condicao.")
		Else
			CliFiltro()
		EndIF
		xTemp->(DbCloseArea())
		Ferase( xAlias )
		Ferase( xNtx )

	Case Op1 = 5
		ClientesDbEdit()

	EndCase
	ResTela( cScreen )

EndDo

*:==================================================================================================================================

Proc CliFiltro()
****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area( xTemp )
xTemp->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Titulo   := "CONSULTA DE CLIENTES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Proc RegiaoConsulta()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Regiao")
Regiao->(Order( REGIAO_NOME ))
Regiao->(DbGoTop())
oBrowse:Add( "CODIGO",    "Regiao")
oBrowse:Add( "DESCRICAO", "Nome")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE REGIOES"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

STATIC Proc Exclusao()
**********************
LOCAL cScreen := SaveScreen()
LOCAL Doc

Receber->( Order( RECEBER_CODI ))
WHILE OK
	Area("ReceMov")
	Set Rela To Codi Into Receber
	Recemov->(Order( RECEMOV_DOCNR ))
	Recemov->(DbGoTop())
	MaBox( 16 , 10 , 18 , 30 )
	Doc := Space( 9 )
	@ 17 , 11 SAY "Doc.No..¯"GET doc PICT "@K!" Valid DocErrado( @doc )
	Read
	IF LastKey() = ESC
		DbClearRel()
		DbGoTop()
		ResTela( cScreen )
		Exit
	EndIF
	oMenu:Limpa()
	MaBox(  06 , 10, 17 , 76, "EXCLUSAO DE MOVIMENTO" )
	Write( 07 , 11, "Codigo...¯ " + Codi + "  " + Receber->Nome )
	Write( 08 , 11, "Tipo.....¯ " + Tipo)
	Write( 09 , 11, "Doc.N§...¯ " + Docnr)
	Write( 10 , 11, "Nosso N§.¯ " + Nossonr)
	Write( 11 , 11, "Bordero..¯ " + Bordero)
	Write( 12 , 11, "Emissao..¯ " + Dtoc( Emis ))
	Write( 13 , 11, "Vencto...¯ " + Dtoc( Vcto ))
	Write( 14 , 11, "Portador.¯ " + Port)
	Write( 15 , 11, "Valor....¯ " + Tran( Vlr,  "@E 9,999,999,999.99"))
	Write( 16 , 11, "Jr Mes...¯ " + Tran( Juro, "999.99"))
	ErrorBeep()
	IF Conf( "Confirma Exclusao deste Movimento ?" )
		IF Recemov->(TravaReg())
			DbDelete()
			Recemov->(Libera())
			Alerta(" Registro Excluido ...")
			ResTela( cScreen )
			Loop
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

*:==================================================================================================================================

Proc Proc_Altera()
******************
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL aMenuArray := { " A Receber "," Recebidos "}

WHILE OK
	M_Title("ALTERACAO DE TITULOS")
	nChoice := FazMenu( 10, 10, aMenuArray, Cor())
	IF nChoice = 0
		ResTela( cScreen )
		Exit
	ElseIF nChoice = 1
		AlteraReceber()
	Else
		AlteraRecebido()
	EndIF
EndDO

*:==================================================================================================================================

Proc AlteraReceber( cDocnr, nRegistro )
**************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL nCotacao := 0
LOCAL lParam   := if( cDocnr == NIL , FALSO, OK)
LOCAL cObs
LOCAL lRetVal  := FALSO

if !lParam 
   cDocnr := Space(9)
endif

WHILE OK
	Receber->(Order( RECEBER_CODI ))
	Area("ReceMov")
	Recemov->(Order( RECEMOV_DOCNR ))
   if !lParam
	   MaBox( 16 , 10 , 18 , 30 )
	   @ 17 , 11 Say	"Doc.No..¯" Get cDocNr Pict "@K!" Valid DocErrado( @cDocNr )
	   Read
	   IF LastKey() = ESC
	   	AreaAnt( Arq_Ant, Ind_Ant )
		   ResTela( cScreen )
		   Exit
	   EndIF 
	else
	   Recemov->(DbGoto( nRegistro ))
		if Recemov->Docnr != cDocnr
			DocErrado( @cDocNr )
		endif
	endif	
	oMenu:Limpa()
	nRegistro := Recemov->(Recno())	
	cCodi     := Recemov->Codi
	cTipo 	 := Recemov->Tipo
	cDocnr	 := Recemov->Docnr
	cNossoNr  := Recemov->NossoNr
	cBordero  := Recemov->Bordero
	dEmis 	 := Recemov->Emis
	dVcto 	 := Recemov->Vcto
	cPort 	 := Recemov->Port
	nVlr		 := Recemov->Vlr
	nJuro 	 := Recemov->Juro
	nVlrAnt	 := Recemov->Vlr
	cFatura	 := Recemov->Fatura
	cObs		 := Recemov->Obs
	
	Receber->(DbSeek( cCodi ))
   MaBox( 06 , 10 , 18 , MaxCol()-4, "ALTERACAO DE MOVIMENTO" )
	Write( 07 , 11 ,	"Codigo...: " + Recemov->Codi + " " + Receber->Nome )
	Write( 08 , 11 ,	"Tipo.....: " + Recemov->Tipo)
	Write( 09 , 11 ,	"Doc.N§...: " + Recemov->Docnr)
	Write( 10 , 11 ,	"Nosso N§.: " + Recemov->Nossonr)
	Write( 11 , 11 ,	"Bordero..: " + Recemov->Bordero)
	Write( 12 , 11 ,	"Emissao..: " + Recemov->(Dtoc(Emis)))
	Write( 13 , 11 ,	"Vencto...: " + Recemov->(Dtoc(Vcto)))
	Write( 14 , 11 ,	"Portador.: " + Recemov->Port)
	Write( 15 , 11 ,	"Valor....: " + Recemov->(Tran(Vlr,  "@E 9,999,999,999.99")))
	Write( 16 , 11 ,	"Jr Mes...: " + Recemov->(Tran( Juro, "999.99")))
	Write( 17 , 11 ,	"Obs......: " + Recemov->Obs )
	
	@ 07 , 22 Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi, NIL , Row(), Col()+1)
	@ 08 , 22 Get cTipo	  Pict "@!"
	@ 09 , 22 Get cDocnr   Pict "@!"
	@ 10 , 22 Get cNossoNr Pict "@!"
	@ 11 , 22 Get cBordero Pict "@!"
	@ 12 , 22 Get dEmis	  Pict "##/##/##"
	@ 13 , 22 Get dVcto	  Pict "##/##/##"
	@ 14 , 22 Get cPort	  Pict "@!"
	@ 15 , 22 Get nVlr	  Pict "@E 9,999,999,999.99"
	@ 16 , 22 Get nJuro	  Pict "999.99"
	@ 17 , 22 Get cObs	  Pict "@!"
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		if lParam
		   Return( lRetVal )
		endif	
		Exit
	EndIF
	DbGoTo( nRegistro )
	ErrorBeep()
	IF (lRetVal := Conf( "Confirma Alteracao Do Registro ?"))
		nJdia := Jurodia( nVlr, nJuro )
		IF Recemov->(TravaArq())
			DbGoTo( nRegistro )
			Recemov->Codi		:= cCodi
			Recemov->Docnr 	:= cDocNr
			Recemov->Emis		:= dEmis
			Recemov->Emis		:= dEmis
			Recemov->Port		:= cPort
			Recemov->Vcto		:= dVcto
			Recemov->Vlr		:= nVlr
			Recemov->Tipo		:= cTipo
			Recemov->NossoNr	:= cNossoNr
			Recemov->Bordero	:= cBordero
			Recemov->Juro		:= nJuro
			Recemov->Jurodia	:= nJDia
			Recemov->VlrDolar := nVlr
			Recemov->Obs		:= cObs
			Recemov->(Order( RECEMOV_FATURA ))
			IF Recemov->(DbSeek( cFatura ))
				WHILE Recemov->Fatura = cFatura
					Recemov->VlrFatu -= nVlrAnt
					Recemov->VlrFatu += nVlr
					Recemov->(DbSkip(1))
				EndDo
			EndIF
			Recemov->(Libera())
		EndIF
	endif	
	ResTela( cScreen )
	if lParam
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( lRetVal )
	endif	
EndDo

*:==================================================================================================================================

Proc AlteraRecebido()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nCotacao := 0
LOCAL cDocnr	:= Space(9)
LOCAL nVlrPag	:= 0
LOCAL cObs		:= ""

Receber->(Order( RECEBER_CODI ))
Area("Recebido")
Recebido->(Order( RECEBIDO_DOCNR ))
Set Rela To Codi Into Receber
WHILE OK
	MaBox( 16 , 10 , 18 , 30 )
	@ 17 , 11 Say	"Doc.No..:"Get cDocNr Pict "@K!" Valid RecebiErrado( @cDocNr )
	Read
	IF LastKey() = ESC
		Recebido->(DbClearRel())
		Recebido->(DbClearFilter())
		Recebido->(DbGoTop())
		ResTela( cScreen )
		Exit
	EndIF
	oMenu:Limpa()
	MaBox( 06 , 10 , 20 , 76, 'ALTERACAO DE TITULO RECEBIDO' )
	Write( 07 , 11 ,	"Codigo...: " + Recebido->Codi + " " + Receber->Nome )
	Write( 08 , 11 ,	"Tipo.....: " + Recebido->Tipo)
	Write( 09 , 11 ,	"Doc.N§...: " + Recebido->Docnr)
	Write( 10 , 11 ,	"Nosso N§.: " + Recebido->Nossonr)
	Write( 11 , 11 ,	"Bordero..: " + Recebido->Bordero)
	Write( 12 , 11 ,	"Emissao..: " + Recebido->(Dtoc(Emis)))
	Write( 13 , 11 ,	"Vencto...: " + Recebido->(Dtoc(Vcto)))
	Write( 14 , 11 ,	"Portador.: " + Recebido->Port)
	Write( 15 , 11 ,	"Valor....: " + Recebido->(Tran(Vlr,  "@E 9,999,999,999.99")))
	Write( 16 , 11 ,	"Jr Mes...: " + Recebido->(Tran(Juro, "999.99")))
	Write( 17 , 11 ,	"Data Pgto: " + Recebido->(Dtoc( DataPag)))
	Write( 18 , 11 ,	"Recebido.: " + Recebido->(Tran(VlrPag,"@E 9,999,999,999.99")))
	Write( 19 , 11 ,	"Obs......: " + Recebido->Obs )
	Read
	IF LastKey() = ESC
		DbClearFilter()
		ResTela( cScreen )
		Exit
	EndIF
	cCodi 	:= Recebido->Codi
	cTipo 	:= Recebido->Tipo
	cDocnr	:= Recebido->Docnr
	cNossoNr := Recebido->NossoNr
	cBordero := Recebido->Bordero
	dEmis 	:= Recebido->Emis
	dVcto 	:= Recebido->Vcto
	cPort 	:= Recebido->Port
	nVlr		:= Recebido->Vlr
	nJuro 	:= Recebido->Juro
	nVlrAnt	:= Recebido->Vlr
	nVlrPag	:= Recebido->VlrPag
	cFatura	:= Recebido->Fatura
	dDataPag := Recebido->DataPag
	cObs		:= Recebido->Obs

	@ 07 , 22 Get cCodi	  Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	@ 08 , 22 Get cTipo	  Pict "@!"
	@ 09 , 22 Get cDocnr   Pict "@!"
	@ 10 , 22 Get cNossoNr Pict "@!"
	@ 11 , 22 Get cBordero Pict "@!"
	@ 12 , 22 Get dEmis	  Pict "##/##/##"
	@ 13 , 22 Get dVcto	  Pict "##/##/##"
	@ 14 , 22 Get cPort	  Pict "@!"
	@ 15 , 22 Get nVlr	  Pict "@E 9,999,999,999.99"
	@ 16 , 22 Get nJuro	  Pict "999.99"
	@ 17 , 22 Get dDataPag Pict "##/##/##"
	@ 18 , 22 Get nVlrPag  Pict "@E 9,999,999,999.99"
	@ 19 , 22 Get cObs	  Pict "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Loop
	EndIF
	ErrorBeep()
	IF Conf( "Confirma Alteracao Do Registro ?" )
		IF Recebido->(TravaReg())
			Recebido->Codi 	 := cCodi
			Recebido->Docnr	 := cDocNr
			Recebido->Emis 	 := dEmis
			Recebido->Emis 	 := dEmis
			Recebido->Port 	 := cPort
			Recebido->Vcto 	 := dVcto
			Recebido->Vlr		 := nVlr
			Recebido->Tipo 	 := cTipo
			Recebido->NossoNr  := cNossoNr
			Recebido->Bordero  := cBordero
			Recebido->Juro 	 := nJuro
			Recebido->VlrPag	 := nVlrPag
			Recebido->DataPag  := dDataPag
			Recebido->Obs		 := cObs
			Recebido->(Libera())
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

*:==================================================================================================================================

Function RecebiErrado( Var )
***************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Recebido")
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGoTop())
IF Recebido->(Eof())
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	Return( FALSO )
EndIF
IF !( DbSeek( Var ) )
	DbGoTop()
	Escolhe( 03, 01, 22, "Docnr + 'º' + Receber->Nome", "DOCTO N§  NOME DO CLIENTE" )
	Var := Docnr
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
IF Empty( Var )
	Return( FALSO )
EndIF
Return( OK )

*:==================================================================================================================================

Proc Lancamentos(cCaixa)
************************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Normal ", " Fechamento Futuro " }
LOCAL nChoice	  := 0

oMenu:Limpa()
WHILE OK
	M_Title( "INCLUIR OS TITULOS COMO ?" )
	nChoice := FazMenu( 02, 10, aMenuArray, Cor())
	Do Case
		Case nChoice = 0
			ResTela( cScreen )
			Exit
	  Case nChoice = 1
			ReceNormal(OK, cCaixa)
	  Case nChoice = 2
			ReceNormal(FALSO, cCaixa)
	  EndCase
EndDo

*:==================================================================================================================================

Function ReceNormal( lTipo, cCaixa, xDados )
********************************************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL cCodi 	  := Space(05)
LOCAL dUltCompra := Date()
LOCAL nCotacao   := 0
LOCAL cDolar	  := "R"
LOCAL aRecno	  := {}
LOCAL cCond      := nil
LOCAL cFatura    := nil
LOCAL cObs       := "(escreva at‚ 80 letras - CTRL + Y apaga linha)" + space(80-46)
LOCAL aMenu      := {"Promissoria Papel Branco", "Promissoria Papel Continuo", "Duplicata Form Branco","Duplicata Form Personalizado","Boleto Bancario"}
LOCAL PIC_OBS    := iif(MaxCol() <= 80, "@!S40", "@!")

WHILE OK
	Area("Receber")
	Receber->(Order( RECEBER_CODI ))
	oMenu:Limpa()
	if xDados != NIL
	   lSair := OK
		cCodi := xDados[1]
		nVlr	:= xDados[2]
		if !RecErrado( @cCodi ) .AND. !VerificaPosicao( cCodi, cCond, cFatura)
         return Nil		
      endif		
	else
		lSair  := FALSO
		cCodi  := Space(05)
		nVlr	 := 0
		MaBox( 05 , 10 , 07 , MaxCol()-13 )
		@ 06 , 11 Say	"Cliente.:" Get cCodi Pict "99999" Valid RecErrado( @cCodi ) .AND. VerificaPosicao( cCodi, cCond, cFatura)
		Read
		IF LastKey() = ESC
			return( ResTela( cScreen))
		EndIF
	endif
	cNome 	 := Receber->Nome
	cEnde 	 := Receber->Ende
	nRecoCli  := Receber->(Recno())
	cRegiao	 := Receber->Regiao
	cTipo 	 := "NP      "
	dVcto 	 := Date() 
   nJuro     := oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES]
	cPort 	 := "CARTEIRA  "
	cNosso	 := Space( 13 )
	cBorde	 := Space( 09 )	
	dEmis 	 := Date()
	cDolar	 := "R"

	WHILE OK
		Nota->(Order( NATURAL ))
		Nota->(DbGoBottom())
		cDocnr := Nota->(StrZero( Val( Numero ) + 1, 7 )) + "-A"
		MaBox( 08 , 10 , 22 , MaxCol()-13 )
		Write( 09 , 11, "Codigo........: " + cCodi )
		Write( 10 , 11, "Cliente.......: " + cNome )
		Write( 11 , 11, "Endereco......: " + cEnde )
		@ 12 , 11 Say	 "Tipo..........:" Get cTipo  Pict "@K!"
		@ 13 , 11 Say	 "Documento n§..:" Get cDocnr Pict "@K!"              Valid LastKey()=UP .OR. DocCerto(@cDocnr)
		@ 14 , 11 Say	 "Nosso N§......:" Get cNosso Pict "@K!"
		@ 15 , 11 Say	 "Bordero n§....:" Get cBorde Pict "@K!"
		@ 16 , 11 Say	 "Data Emissao..:" Get dEmis  Pict "##/##/##"
		@ 17 , 11 Say	 "Data Vcto.....:" Get dVcto  Pict "##/##/##"         Valid LastKey()=UP .OR. IF((dVcto<dEmis), (ErrorBeep(), Alerta("Erro: Entrada Invalida. Vcto tem que ser maior que Emissao."), FALSO ), OK )
		@ 18 , 11 Say	 "Portador......:" Get cPort  Pict "@K!"            
		@ 19 , 11 Say	 "Valor.........:" Get nVlr   Pict "@E 9999999999.99" Valid LastKey()=UP .OR. IF(nVlr == 0,     (ErrorBeep(), Alerta("Erro: Entrada Invalida. Valor zerado fica dificil."),          FALSO ), OK )
		@ 20 , 11 Say	 "Juros Mes.....:" Get nJuro  Pict "999.99"
		@ 21 , 11 Say	 "Observacao....:" Get cObs   Pict PIC_OBS
		
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		nOpcao := Alerta( "Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		IF nOpcao = 1 // Incluir
			IF !DocCerto( @cDocnr )
				Loop
			EndIF
			Jdia	:=  Jurodia( nVlr, nJuro )
			IF Recemov->(!Incluiu())
				Loop
			EndIF
			aRecno				  := { Recemov->(Recno()) }
			Recemov->Codi		  := cCodi
			Recemov->Docnr 	  := cDocnr
			Recemov->Emis		  := dEmis
			Recemov->Qtd_D_Fatu := 1
			Recemov->Caixa 	  := cCaixa
			Recemov->Vcto		  := dVcto
			Recemov->Vlr		  := nVlr
			Recemov->Port		  := cPort
			Recemov->Tipo		  := cTipo
			Recemov->NossoNr	  := cNosso
			Recemov->Juro		  := nJuro
			Recemov->Bordero	  := cBorde
			Recemov->Jurodia	  := Jdia
			Recemov->Regiao	  := cRegiao
			Recemov->Fatura	  := Left( cDocnr, 7)
			Recemov->VlrFatu	  := nVlr
			Recemov->VlrDolar   := nVlr
			Recemov->Titulo	  := IF( lTipo, OK, FALSO )
			Recemov->Obs        := cObs			
			Recemov->(Libera())

			IF ( Receber->(Order( RECEBER_CODI )), Receber->( DbSeek( cCodi )))
				IF Receber->UltCompra < dEmis
					IF Receber->(TravaReg())
						Receber->UltCompra := dEmis
						Receber->(Libera())
					EndIF
				EndIF
			EndIF			
			IF Nota->(!Incluiu())
				Loop
			EndIF
			aRecno				  := { Recemov->(Recno()) }
			Nota->Numero        := Left(cDocnr,7)
			Nota->Data   		  := Date()
			Nota->Situacao      := "RECEBER"
			Nota->Caixa         := cCaixa
			Nota->Codi		     := cCodi
			Nota->(Libera())
			
			WHILE OK
				oMenu:Limpa()
				ErrorBeep()
				M_Title("LANCAMENTO EFETUDO COM SUCESSO. DESEJA IMPRIMIR ?")
				nEscolha := FazMenu( 10, 10, aMenu )
				Do Case
				Case nEscolha = 0
					lSair := OK
					if xDados != NIL
					   return( ResTela( cScreen))
					endif
					Exit
				Case nEscolha = 1
               ProBranco( cCodi, aRecno )
				Case nEscolha = 2
               ProPersonalizado( cCodi, aRecno )
				Case nEscolha = 3
					DupPapelBco( cCodi, aRecno )
				Case nEscolha = 4
               DupPersonalizado( cCodi, aRecno )
				Case nEscolha = 3
					DiretaLivre( cCodi, aRecno )
				
				EndCase
			EndDo

		ElseIf nOpcao = 2 // Alterar
			Loop

		ElseIf nOpcao = 3  // Sair
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit
	EndIF
EndDo
return nil

*:==================================================================================================================================

Proc MenuDuplicata()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu    := {"Formulario Branco", "Formulario Personalizado"}
LOCAL oBloco1
LOCAL oBloco2

WHILE OK
   M_Title( "IMPRESSAO DUPLICATA")
   nChoice := FazMenu( 05, 10, aMenu, Cor() )
   Do Case
   Case nChoice = 0
      ResTela( cScreen )
      Return
   Case nChoice = 1
     DupPapelBco()
   Case nChoice = 2
      DupPersonalizado()
   EndCase
BEGOUT

*:==================================================================================================================================

Proc MenuPromissoria()
**********************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu    := {"Formulario Branco", "Formulario Personalizado"}
LOCAL oBloco1
LOCAL oBloco2

WHILE OK   
   M_Title( "IMPRESSAO PROMISSORIA")
   nChoice := FazMenu( 05, 10, aMenu, Cor() )
   Do Case
   Case nChoice = 0
      ResTela( cScreen )
      Return
   Case nChoice = 1
     ProBranco()
   Case nChoice = 2
      ProPersonalizado()
   EndCase
BEGOUT

*:==================================================================================================================================

Proc Fluxo()
************
LOCAL cScreen	:= SaveScreen()
LOCAL aData 	:= {}
LOCAL aValor	:= {}
LOCAL aConta	:= {}
LOCAL nRegis	:= 0
LOCAL nPosicao := 0
LOCAL nTamanho := 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL aMenu 	:= {"Por Vcto", "Por Emissao", "Geral"}
LOCAL oBloco1
LOCAL oBloco2

M_Title( "FLUXO SINTETICO")
nChoice := FazMenu( 03, 20, aMenu, Cor() )
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Vcto Final....:" Get dFim    Pict "##/##/##"
	oBloco1 := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
Case nChoice = 2
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Emis Final....:" Get dFim    Pict "##/##/##"
	oBloco2 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
EndCase
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
oMenu:Limpa()
Area("ReceMov")
Recemov->(Order( RECEMOV_VCTO ))
Recemov->(DbGoTop())
Mensagem( "Aguarde, Processando. ESC Interrompe.", Cor() )
nRegis := Lastrec()
WHILE !Eof() .AND. Rep_Ok()
	IF nChoice = 1
		IF !Eval( oBloco1 )
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF nChoice = 2
		IF !Eval( oBloco2 )
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF ( nPosicao := Ascan( aData, Recemov->Vcto )) = 0
		Aadd( aData,  Recemov->Vcto )
		Aadd( aValor, Recemov->Vlr )
		Aadd( aConta, 1 )
	Else
		aValor[ nPosicao ] += Recemov->Vlr
		aConta[ nPosicao ]++
	EndIF
	Recemov->(DbSkip( 1 ))
EndDo
IF ( nTamanho := Len( aData )) = 0
	NaoTem()
	Restela( cScreen )
	Return
EndIF
oMenu:Limpa()
IF InsTru80()
	ImprimirFluxo( aData, aValor, aConta, SISTEM_NA3 )
EndIF
ResTela( cScreen )
Return

*:==================================================================================================================================

Proc ImprimirFluxo( aData, aValor, aConta, cSistema )
*****************************************************
LOCAL cScreen	:= SaveScreen()
LOCAL nTamanho := Len( aData )
LOCAL nTotal	:= ATotal( aValor )
LOCAL nConta	:= ATotal( aConta )
LOCAL Tam		:= 80
LOCAL Col		:= 58
LOCAL Pagina	:= 0
LOCAL Relato	:= "FLUXO SINTETICO DE VENCIMENTOS"
LOCAL ContaFor := 0

PrintOn()
SetPrc( 0 , 0 )
FOR ContaFor := 1 To nTamanho
	IF Col >= 57
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
      Write( 02, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
		Write( 03, 00, Padc( cSistema, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "VCTO      QTD                                                          VALOR R$")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 8
	EndIF
	Qout( aData[ ContaFor ], Tran( aConta[ContaFor],"9999"), Repl(".", 48 ), Tran( aValor[ ContaFor ],"@E 9,999,999,999.99"))
	Col++
	IF Col >= 57
		Write( ++Col, 0, Repl( SEP , Tam ) )
		__Eject()
	EndIF
Next
Write( ++Col, 00, "*Total*" )
Write(	Col, 09, Tran( nConta, "99999"))
Write(	Col, 62, Tran( nTotal, "@E 999,999,999,999.99" ) )
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:==================================================================================================================================

Proc CobTitulo()
****************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Individual", "Geral" }
LOCAL nChoice	  := 0
LOCAL xDbf		  := FTempName("T*.TMP")
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL cCodi
FIELD Codi
FIELD Vcto

WHILE OK
	M_Title("CARTA DE COBRANCA")
	nChoice := FazMenu( 03 , 10, aMenuArray, Cor() )
	Do Case
	Case nChoice  = 0
		ResTela( cScreen )
		Return

	Case nChoice  = 1
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 09 , 10, 13 , 36 )
		@ 10, 11 Say  "Cliente......:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 11, 11 Say  "Vcto Inicial.:" Get dIni  Pict "##/##/##"
		@ 12, 11 Say  "Vcto Final...:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen	)
			Loop
		EndIF
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		IF Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			ResTela( cScreen )
			Loop
		EndIF
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->Codi = cCodi
			IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			EndIF
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn006()
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	Case nChoice  = 2
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 09 , 10, 12 , 36 )
		@ 10, 11 Say  "Vcto Inicial.:" Get dIni  Pict "##/##/##"
		@ 11, 11 Say  "Vcto Final...:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen	)
			Loop
		EndIF
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->( !Eof())
			IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			EndIF
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn006()
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	EndCase
EndDo

*:==================================================================================================================================

Proc Prn006()
*************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL lSair 	 := FALSO
LOCAL NovoNome  := OK
LOCAL Files 	 := "*.DOC"
LOCAL Arquivo	 := "COBRANCA.DOC"
LOCAL nAtraso	 := 0
LOCAL Total 	 := 0
LOCAL TotJur	 := 0
LOCAL nVlrAtual := 0
LOCAL nCarencia := 0
LOCAL nRow		 := 0
LOCAL lTitulo	 := FALSO
LOCAL Imprime
LOCAL UltNome
LOCAL Col
LOCAL Campo
LOCAL Linha
LOCAL Linhas
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

MaBox( 14 , 10 , 16 , 53 )
@ 15 , 11 Say	"Arquivo Carta de Cobran‡a.:" Get Arquivo Pict "@!"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
ErrorBeep()
lTitulo := Conf("Pergunta: Imprimir relacao dos titulos em atraso na carta?")
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
IF Empty( Arquivo )
	M_Title( "Setas CIMA/BAIXO Move")
	//Arquivo := Mx_PopFile( 17, 10, 23, 61, Files, Cor())
	IF Empty( Arquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ErrorBeep()
		ResTela( cScreen )
		Return
  EndIF
Else
	IF !File( Arquivo )
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		ErrorBeep()
		ResTela( cScreen )
		Alert( Rtrim( Arquivo ) + " Nao Encontrado... " )
		ResTela( cScreen )
		Return
	EndIF
EndIF
IF !InsTru80()
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen	)
	Return
EndIF
oMenu:Limpa()
Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
UltNome	:= Receber->Nome
PrintOn()
SetPrc( 0 , 0 )
WHILE !Eof() .AND. Rel_Ok()
	nAtraso	 := Atraso( Date(), Vcto )
	nCarencia := Carencia( Date(), Vcto )
	IF nAtraso <= 0
		TotJur := 0
	Else
		TotJur := ( Jurodia * nCarencia )
	EndIF
	nVlrAtual := ( TotJur + Vlr )
	IF NovoNome
		NovoNome := FALSO
		Total := 0
		Write( 02 , 0, DataExt( Date()))
		Write( 06 , 0, "A" )
		Write( 07 , 0, NG + Receber->Nome + NR )
		Write( 08 , 0, Receber->Ende )
		Write( 09 , 0, Receber->Bair )
		Write( 10 , 0, LIGSUB + Receber->Cep + "/" + Receber->( Rtrim( Cida ) ) + "/" + Receber->Esta + DESSUB )
		Campo  := MemoRead( Arquivo )
		Linhas := MlCount( Campo , 80 )
		FOR Linha  :=	1 To Linhas
			Imprime :=	MemoLine( Campo , 80 , Linha )
			Write( 15 + Linha -1 , 0, Imprime )
		Next
		IF lTitulo
			Write( 46 , 0 , "DOCTO N§  VENCTO  ATRASO   VALOR ATUAL    DOCTO N§  VENCTO  ATRASO   VALOR ATUAL")
			Qout(Repl(SEP,80))
		EndIF
		Col := 48
	EndIF
	IF nRow = 0
		IF lTitulo
			Qout( Docnr, Vcto, Tran(nAtraso,'99999'),Tran(nVlrAtual, "99,999,999.99"))
		EndIF
		nRow = 40
	Else
		IF lTitulo
			QQout(Space(3), Docnr, Vcto, Tran(nAtraso,'99999'),Tran(nVlrAtual, "99,999,999.99"))
		EndIF
		nRow := 0
		Col++
	EndIF
	UltNome := Receber->Nome
	Total   += nVlrAtual
	DbSkip(1)
	IF Col >= 55 .OR. UltNome != Receber->Nome .OR. Eof()
		NovoNome := OK
		IF lTitulo
			Qout()
			Qout(" ** Total a Pagar **", Space(12),Tran(Total,"@E 99,999,999.99"))
			Qout(Repl(SEP,80))
		EndIF
		__Eject()
	EndIF
EndDo
PrintOff()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
Return

*:==================================================================================================================================

Function AchaPortador( cPortador )
**********************************
Recebido->(Order( RECEBIDO_PORT ))
IF Recebido->(!DbSeek( cPortador ))
	ErrorBeep()
	Alert("Erro: Portador nao localizado.")
	Return( FALSO )
EndIF
Return( OK )

*:----------------------------------------------------------------------------

Function DocCerto( cDocNr )
***************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF LastKey() = UP
	Return( OK )
EndIF
IF Empty( cDocNr )
	ErrorBeep()
	Alerta( "Erro: Numero Documento Invalido...")
	Return( FALSO )
EndIF
Area("ReceMov")
Recemov->(Order( RECEMOV_DOCNR ))
Recemov->(DbGoTop())
IF Recemov->(DbSeek( cDocNr ))
	ErrorBeep()
	Alerta("Erro: Numero Documento Ja Registrado ou,; Incluido por outra Estacao...")
	cDocnr := StrZero( Val( cDocnr ) + 1, 9 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Proc PrnAlfabetica( nVctoOuEmis )
*********************************
LOCAL cScreen		:= SaveScreen()
LOCAL xAlfa 		:= FTempName()
LOCAL aMenuArray	:= {"Por Regiao", "Por Periodo *", "Por Tipo", "Individual", "Por Portador"}
LOCAL nField		:= 0
LOCAL nChoice		:= 0
LOCAL lSair 		:= FALSO
LOCAL Tam			:= CPI1280
LOCAL Col			:= 8
LOCAL Pagina		:= 0
LOCAL cNome 		:= Space(0)
LOCAL nTotal		:= 0
LOCAL nTotalDolar := 0
LOCAL nTotalAtual := 0
LOCAL nQtdDoc		:= 0
LOCAL cTitle		:= IF( nVctoOuEmis == 1, 'VCTO : ', 'EMISSAO : ') + 'ORDEM ALFABETICA'
LOCAL cTitulo		:= IF( nVctoOuEmis == 1, 'VENCIMENTO : ', 'EMISSAO : ')
LOCAL nRolRecemov := oIni:ReadInteger('relatorios', 'rolrecemov', 2 )
LOCAL cCodi 		:= ''
LOCAL cPortador	:= ''
LOCAL cFatura
LOCAL Titulo
LOCAL UltCodi
LOCAL dIni
LOCAL dFim
LOCAL bBloco
LOCAL cTipo
LOCAL aStru
LOCAL lMarcado

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
WHILE OK
	M_Title( cTitle )
	nChoice := FazMenu( 05, 22, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		cRegiao := Space(2)
		dIni	  := Date() - 30
		dFim	  := Date()
		MaBox( 17, 10, 21, 35 )
		@ 18, 11 Say "Regiao.....: " Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 19, 11 Say "Data Ini...: " Get dIni    Pict "##/##/##"
		@ 20, 11 Say "Data Fim...: " Get dFim    Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Regiao->(Order( REGIAO_REGIAO ))
		IF Regiao->(DbSeek( cRegiao))
			cNome := Regiao->Nome
		EndIF
		cIni	 := Dtoc( dIni )
		cFim	 := Dtoc( dFim )
		Titulo := "ROL DE TITULOS A RECEBER DA REGIAO " + AllTrim( cNome ) + " REF. &cIni. A &cFim."
		Mensagem(" Aguarde... ", Cor())
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_REGIAO ))
		IF Recemov->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta('Erro: Regiao nao localizada.')
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Regiao = cRegiao
			IF !lMarcado
				IF Receber->(DbSeek( Recemov->Codi ))
					IF Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					EndIF
				EndIF
			EndIF
			IF nVctoOuEmis == 1 // Vcto
				IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					IF nRolRecemov = 2
						cFatura := Recemov->Fatura
						IF Saidas->(DbSeek( cFatura ))
							IF !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							EndIF
						EndIF
					EndIF
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				EndIF
			 Else
				IF Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 EndIF
			 EndIF
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		dIni := Date()-30
		dFim := Date()
		MaBox( 17, 10, 20, 35 )
		@ 18, 11 Say "Data Ini...: " Get dIni Pict "##/##/##" Valid IF( nVctoOuEmis == 1, AchaVcto( @dIni ), AchaEmis( @dIni ))
		@ 19, 11 Say "Data Fim...: " Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		cIni	 := Dtoc( dIni )
		cFim	 := Dtoc( dFim )
		Titulo := "ROL DE TITULOS A RECEBER COM " + cTitulo + " DE &cIni. A &cFim."
		Mensagem("Aguarde... ", Cor())
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		IF nVctoOuEmis == 1
			Recemov->(Order( RECEMOV_VCTO ))
		Else
			Recemov->(Order( RECEMOV_EMIS ))
		EndIF
		IF Recemov->(!DbSeek( dIni ))
			ErrorBeep()
			Alerta('Erro: Data Emissao Inicial nao localizada.')
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		IF nVctoOuEmis == 1 // Vcto
			While Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				IF !lMarcado
					IF Receber->(DbSeek( Recemov->Codi ))
						IF Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				IF nRolRecemov = 2
					cFatura := Recemov->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				xTemp->(DbAppend())
				cCodi := Recemov->Codi
				For nField := 1 To Recemov->(FCount())
					xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
				Receber->(DbSeek( cCodi ))
				xTemp->Nome := Receber->Nome
				Recemov->(DbSkip(1))
			EndDo
		Else
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				IF !lMarcado
					IF Receber->(DbSeek( Recemov->Codi ))
						IF Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				xTemp->(DbAppend())
				cCodi := Recemov->Codi
				For nField := 1 To Recemov->(FCount())
					xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
				Receber->(DbSeek( cCodi ))
				xTemp->Nome := Receber->Nome
				Recemov->(DbSkip(1))
			EndDo
		EndIF
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 3
		cTipo := Space(06)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 17, 10, 21, 35 )
		@ 18, 11 Say "Tipo.......: " Get cTipo Pict "@!" Valid AchaTipo( cTipo )
		@ 19, 11 Say "Data Ini...: " Get dIni  Pict "##/##/##"
		@ 20, 11 Say "Data Fim...: " Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Titulo := "ROL DE TITULOS A RECEBER TIPO " + cTipo
		Mensagem(" Aguarde... ", Cor())
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_TIPO_CODI ))
		IF Recemov->(!DbSeek( cTipo ))
			ErrorBeep()
			Alerta('Erro: Tipo nao localizado.')
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Tipo = cTipo
			IF !lMarcado
			  IF Receber->(DbSeek( Recemov->Codi ))
					IF Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					EndIF
				EndIF
			EndIF
			IF nVctoOuEmis == 1 // Vcto
				IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					IF nRolRecemov = 2
						cFatura := Recemov->Fatura
						IF Saidas->(DbSeek( cFatura ))
							IF !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							EndIF
						EndIF
					EndIF
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				EndIF
			 Else
				IF Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 EndIF
			 EndIF
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 4
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 17, 10, 21, 32 )
		@ 18, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 19, 11 Say "Data Ini..: " Get dIni  Pict "##/##/##"
		@ 20, 11 Say "Data Fim..: " Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Titulo := "ROL DE TITULOS A RECEBER DO CLIENTE " + Receber->(Trim( Nome))
		Mensagem(" Aguarde... ", Cor())
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Recemov->(Order( RECEMOV_CODI ))
		IF Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Alerta('Erro: Movimento do Cliente nao localizado.')
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		While Recemov->Codi = cCodi
			IF !lMarcado
			  IF Receber->(DbSeek( Recemov->Codi ))
					IF Receber->Rol = OK
						Recemov->(DbSkip(1))
						Loop
					EndIF
				EndIF
			EndIF
			IF nVctoOuEmis == 1 // Vcto
				IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
					IF nRolRecemov = 2
						cFatura := Recemov->Fatura
						IF Saidas->(DbSeek( cFatura ))
							IF !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							EndIF
						EndIF
					EndIF
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 EndIF
			 Else
				IF Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				 EndIF
			 EndIF
			 Recemov->(DbSkip(1))
		EndDo
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop

	Case nChoice = 5
		cPortador := Space(10)
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 17, 10, 21, 40 )
		@ 18, 11 Say "Portador...: " Get cPortador Pict "@!"
		@ 19, 11 Say "Data Ini...: " Get dIni      Pict "##/##/##" Valid IF( nVctoOuEmis == 1, AchaVcto( @dIni ), AchaEmis( @dIni ))
		@ 20, 11 Say "Data Fim...: " Get dFim      Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Titulo := "ROL DE TITULOS A RECEBER DO PORTADOR " + cPortador
		Mensagem(" Aguarde... ", Cor())
		Saidas->(Order( SAIDAS_FATURA ))
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		IF nVctoOuEmis == 1
			Recemov->(Order( RECEMOV_VCTO ))
		Else
			Recemov->(Order( RECEMOV_EMIS ))
		EndIF
		IF Recemov->(!DbSeek( dIni ))
			ErrorBeep()
			Alerta('Erro: Data Emissao Inicial nao localizada.')
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"NOME",  "C", 40, 0})
		DbCreate( xAlfa, aStru )
		Use (xAlfa) Alias xTemp Exclusive New
		IF nVctoOuEmis == 1
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				IF !lMarcado
				  IF Receber->(DbSeek( Recemov->Codi ))
						IF Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				IF Recemov->Port = cPortador
					IF nRolRecemov = 2
						cFatura := Recemov->Fatura
						IF Saidas->(DbSeek( cFatura ))
							IF !Saidas->Impresso
								Recemov->(DbSkip(1))
								Loop
							EndIF
						EndIF
					EndIF
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				EndIf
				Recemov->(DbSkip(1))
			EndDo
		Else
			While Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim
				IF !lMarcado
				  IF Receber->(DbSeek( Recemov->Codi ))
						IF Receber->Rol = OK
							Recemov->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				IF Recemov->Port = cPortador
					xTemp->(DbAppend())
					cCodi := Recemov->Codi
					For nField := 1 To Recemov->(FCount())
						xTemp->(FieldPut( nField, Recemov->(FieldGet( nField ))))
					Next
					Receber->(DbSeek( cCodi ))
					xTemp->Nome := Receber->Nome
				EndIf
				Recemov->(DbSkip(1))
			EndDo
		EndIF
		PrnAlfaPrint( Titulo )
		xTemp->(DbCloseArea())
		Ferase( xAlfa )
		ResTela( cScreen )
		Loop
	EndCase
EndDo
ResTela( cScreen )
Return

Proc PrnAlfaPrint( cTitulo )
****************************
LOCAL aOrdem	 := {"Nome","Codigo","Documento","Emissao", "Portador", "Tipo", "Valor", "Vencimento *"}
LOCAL xNtx		 := FTempName()
LOCAL cScreen	 := SaveScreen()
LOCAL Tam		 := 132
LOCAL Col		 := 8
LOCAL nQtdDoc	 := 0
LOCAL nTotal	 := 0
LOCAL nAtraso	 := 0
LOCAL nCarencia := 0
LOCAL nJuros	 := 0
LOCAL nTotTit	 := 0
LOCAL nTotJur	 := 0
LOCAL cUltLetra := ''
LOCAL nParcDoc  := 0
LOCAL nParcTit  := 0
LOCAL nParcJur  := 0

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
	nOpcao := FazMenu( 05, 10, aOrdem )
	Mensagem("Aguarde, Ordenando.", Cor())
	Area("xTemp")
	IF nOpcao = 0 // Sair ?
		ResTela( cScreen )
		Return
	ElseIf nOpcao = 1
		 Inde On xTemp->Nome To ( xNtx )
	ElseIf nOpcao = 2
		 Inde On xTemp->Codi To ( xNtx )
	 ElseIf nOpcao = 3
		 Inde On xTemp->Docnr To ( xNtx )
	 ElseIf nOpcao = 4
		 Inde On xTemp->Emis To ( xNtx )
	 ElseIf nOpcao = 5
		 Inde On xTemp->Port To ( xNtx )
	 ElseIf nOpcao = 6
		 Inde On xTemp->Tipo To ( xNtx )
	 ElseIf nOpcao = 7
		 Inde On xTemp->Vlr To ( xNtx )
	 ElseIf nOpcao = 8
		 Inde On xTemp->Vcto To ( xNtx )
	EndIF
	xTemp->(DbGoTop())
	Tam		 := 132
	Col		 := 8
	nQtdDoc	 := 0
	nTotal	 := 0
	nAtraso	 := 0
	nCarencia := 0
	nJuros	 := 0
	nTotTit	 := 0
	nTotJur	 := 0
	IF !InsTru80() .OR. !LptOk()
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
	PrintOn()
	FPrint( PQ )
	SetPrc(0, 0)
	cCabec( cTitulo, Tam )
	WHILE !Eof() .AND. Rel_Ok( )
		IF Col >= 57
			__Eject()
			cCabec( cTitulo, Tam )
			Col := 8
		EndIF
		nAtraso	 := Atraso( Date(), Vcto )
		nCarencia := Carencia( Date(), Vcto )
		nJuros	 := IF( nAtraso <=0, 0, JuroDia * nCarencia )
		Qout( Codi, Left( Nome, 35), Tipo, Docnr, Emis, Vcto,;
				Vlr, Tran( Juro, "999.99"), Tran( nAtraso, "99999"),;
				Tran( Jurodia,"99999999.99"), Tran( (Vlr + nJuros), "@E 9,999,999,999.99"))
		nQtdDoc	 ++
		nParcDoc  ++
		cUltLetra := Left(Nome,1)
		nTotTit	 += Vlr
		nParcTit  += Vlr
		nTotJur	 += Vlr + nJuros
		nParcJur  += Vlr + nJuros
		Col++
		DbSkip(1)
		IF nOpcao = 1 // Ordem Nome
			IF Left(Nome,1) <> cUltLetra
				Qout()
				Col++
				Write( Col, 000, " ** Parcial ** " + Tran( nParcDoc, '99999' ))
				Write( Col, 074, Tran( nParcTit, "@E 9,999,999,999.99") )
				Write( Col, 116, Tran( nParcJur, "@E 9,999,999,999.99") )
				Qout()
				Col		++
				nParcDoc := 0
				nParcTit := 0
				nParcJur := 0
			EndIF
		EndIF
		IF Col >= 57
		  __Eject()
		  cCabec( cTitulo, Tam )
		  Col := 8
		EndIF
	EndDo
	Qout()
	Write( ++Col, 000, " ** Total ** " + Tran( nQtdDoc, '99999' ))
	Write(	Col, 074, Tran( nTotTit, "@E 9,999,999,999.99") )
	Write(	Col, 116, Tran( nTotJur, "@E 9,999,999,999.99") )
	__Eject()
	PrintOff()
EndDo
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Function AchaEmis( dEmis )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL lRetorno := OK

Recemov->(Order( RECEMOV_EMIS ))
IF Recemov->(!DbSeek( dEmis ))
	IF Conf("Erro: Data Invalida. Localizar Proxima ?")
		Mensagem('Aguarde, Localizando Proxima Emissao.')
		dEmis ++
		While Recemov->(!DbSeek( dEmis ))
			dEmis ++
			Recemov->(DbSkip(1))
		EndDo
	Else
		lRetorno := FALSO
	EndIF
EndIF
ResTela( cScreen )
Return( lRetorno )

Function AchaVcto( dVcto )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL lRetorno := OK

Recemov->(Order( RECEMOV_VCTO ))
IF Recemov->(!DbSeek( dVcto ))
	IF Conf("Erro: Data Invalida. Localizar Proxima ?")
		Mensagem('Aguarde, Localizando Proximo Vcto.')
		dVcto ++
		While Recemov->(!DbSeek( dVcto ))
			dVcto ++
			Recemov->(DbSkip(1))
		EndDo
	Else
		lRetorno := FALSO
	EndIF
EndIF
ResTela( cScreen )
Return( lRetorno )

*:---------------------------------------------------------------------------------------------------------------------------------

Function Calcula( nVlr, nVlrDolar, dEmis, dVcto )
*************************************************
LOCAL nCotacao := 0
LOCAL nRetorno := 0
IF dEmis >= dVcto
	IF dEmis >= Date()
		Return( nVlr )
	Else
		IF Taxas->(DbSeek( Date()))
			nCotacao := Taxas->Cotacao
		EndIF
	EndIF
Else
	IF dVcto >= Date()
		Return( nVlr )
	Else
		IF Taxas->(DbSeek( Date()))
			nCotacao := Taxas->Cotacao
		EndIF
	EndIF
EndIF
nRetorno := ( nVlrDolar * nCotacao )
Return( IF( nRetorno <= 0, nVlr, nRetorno ))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc cCabec( Titulo, Tam )
*************************
STATIC Pagina := 0
LOCAL nDiv	  := Tam / 2

Write( 00, 000, Padr( "Pagina N§ " + StrZero(++Pagina,5), nDiv ) + Padl(Time(), nDiv ))
Write( 01, 001, Dtoc( Date() ))
Write( 02, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
Write( 03, 000, Padc( SISTEM_NA3  , Tam ))
Write( 04, 000, Padc( Titulo , Tam ))
Write( 05, 000, Repl( SEP , Tam ) )
Write( 06, 000, "CODI  NOME DO CLIENTE                     TIPO      DOC.N§  EMISSAO   VENCTO  VALOR TITULO JR/MES   ATR    JURO/DIA      VALOR+JUROS" )
Write( 07, 000, Repl( SEP, Tam ) )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Hlp()
**********
LOCAL Tela := SaveScreen()
MaBox( 02 , 09 , 22 , 65, "HELP EDITOR" )
@ 03 , 10 Say	"Seta para cima ou Ctrl+E   - Linha para cima"
@ 04 , 10 Say	"Seta para baixo ou Ctrl+X  - Linha para baixo"
@ 05 , 10 Say	"Seta p/esquerda ou Ctrl+S  - Um caractere a esquerda"
@ 06 , 10 Say	"Seta p/direita ou Ctrl+D   - Um caractere a direita"
@ 07 , 10 Say	"Ctrl-Esquerdaa ou Ctrl+A   - Uma palavra a esquerda"
@ 08 , 10 Say	"Ctrl-Direita ou Ctrl+F     - Uma palavra a direita"
@ 09 , 10 Say	"Home                       - Inicio da linha"
@ 10 , 10 Say	"End                        - Fim da linha"
@ 11 , 10 Say	"Ctrl+Home                  - Inicio do Memo"
@ 12 , 10 Say	"Ctrl+End                   - Fim do Memo"
@ 13 , 10 Say	"PgUp                       - Uma Janela para cima"
@ 14 , 10 Say	"PgDn                       - Uma Janela para baixo"
@ 15 , 10 Say	"Ctrl+PgUp                  - Inicio da Janela Corrente"
@ 16 , 10 Say	"Ctrl+PgDn                  - Fim da Janela Corrente"
@ 17 , 10 Say	"Ctrl+Y                     - Apaga a Linha Corrente"
@ 18 , 10 Say	"Ctrl+T                     - Apaga a Palavra a Direita"
@ 19 , 10 Say	"Ctrl+B                     - Reformate memo na Janela"
@ 20 , 10 Say	"Ctrl+W                     - Termina a Edicao e Salva"
@ 21 , 10 Say	"Esc                        - Aborta a Edicao"
InKey( 0 )
ResTela( Tela )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ClientesDbedit()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Area("Receber")
Receber->(Order( RECEBER_NOME ))
Receber->(DbGoTop())
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Add( "REGIAO",    "Regiao")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE CLIENTES"
oBrowse:HotKey( F4, {|| DuplicaCli( oBrowse ) })
oBrowse:PreDoGet := {|| PreDoCli( oBrowse ) }
oBrowse:PosDoGet := {|| PosDoCli( oBrowse ) }
oBrowse:PreDoDel := {|| HotPreCli( oBrowse ) }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:---------------------------------------------------------------------------------------------------------------------------------

Function DuplicaCli( oBrowse )
******************************
LOCAL cScreen := SaveScreen()
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := Receber->(DbStruct())
LOCAL nConta  := Receber->(FCount())
LOCAL cCodi
LOCAL xRegistro
LOCAL xRegLocal

ErrorBeep()
IF !Conf('Pergunta: Duplicar registro sob o cursor ?')
	Return( OK )
EndIF
xRegistro := Receber->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
	xAlias->(FieldPut( nField, Receber->(FieldGet( nField ))))
Next
IF Receber->(Incluiu())
	For nField := 1 To nConta
		Receber->(FieldPut( nField, xAlias->(FieldGet( nField ))))
	Next
	xRegLocal := Receber->(Recno())
	Receber->(Libera())
	Receber->(Order( RECEBER_CODI ))
	Receber->(DbGoBottom())
	cCodi := ProxCodiCli( Receber->Codi )
	Receber->(DbGoto( xRegistro ))
	IF Receber->(TravaReg())
		Receber->Codi := cCodi
		Receber->(Libera())
	EndIF
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
Receber->(DbGoto( xRegistro ))
oBrowse:FreshOrder()
Receber->(DbGoto( xRegistro ))
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function ProxCodiCli( cCodi )
*****************************
Return( StrZero( Val( cCodi ) + 1, 5))

*:---------------------------------------------------------------------------------------------------------------------------------

Function PreDoCli( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

IF !PodeAlterar()
	Return( FALSO)
EndIF

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Opa! Nao pode alterar nao.")
	Return( FALSO )
OtherWise
EndCase
Return( PodeAlterar() )

*:---------------------------------------------------------------------------------------------------------------------------------

Function PosDoCli( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading = "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
OtherWise
EndCase
Receber->Atualizado := Date()
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function HotPreCli( oBrowse )
*****************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL cCodi   := Receber->Codi

Recemov->(Order( RECEMOV_CODI ))
IF Recemov->(DbSeek( cCodi ))
	ErrorBeep()
	IF !Conf("Pergunta: Cliente devendo. Excluir ?")
		Return( FALSO )
	EndIF
EndIF
Recebido->(Order( RECEBIDO_CODI ))
IF Recebido->(DbSeek( cCodi ))
	ErrorBeep()
	IF !Conf("Pergunta: Cliente com Movimento. Excluir ?")
		Return( FALSO )
	EndIF
EndIF
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

IF !UsaArquivo("RECEBER")
	MensFecha()
	Return
EndiF

IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("VENDEMOV")
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

IF !UsaArquivo("RECEBIDO")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("REGIAO")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("TAXAS")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("CHEQUE")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("CHEMOV")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("CHEPRE")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("PAGAMOV")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("CEP")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("FORMA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("GRUPO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("SAIDAS")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("PREVENDA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("RECIBO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("AGENDA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("CM")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("SUBGRUPO")
	MensFecha()
	Return
EndIF
IF !UsaArquivo("GRUPO")
	MensFecha()
	Return
EndIF
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CliAlteracao( lDeletar )
*****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nKey		 := SetKey( F9 )
LOCAL nFieldLen := Len( Receber->Codi )

Set Key F9 To
WHILE OK
	oMenu:Limpa()
	Area("Receber")
	Receber->(Order( RECEBER_CODI ))
	MaBox( 14 , 19 , 16 , 34 )
	cCodi := Space(05)
	@ 15 , 20 SAY "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	oMenu:Limpa()
	cCodi 	:= Receber->Codi
	dData 	:= Receber->Data
	cNome 	:= Receber->Nome
	cEnde 	:= Receber->Ende
	cRg		:= Receber->Rg
	cCpf		:= Receber->Cpf
	nRenda	:= Receber->Media
	cRef1 	:= Receber->RefCom
	cRef2 	:= Receber->RefBco
	cImovel	:= Receber->Imovel
	cCivil	:= Receber->Civil
	cNatural := Receber->Natural
	dNasc 	:= Receber->Nasc
	cEsposa	:= Receber->Esposa
	nDepe 	:= Receber->Depe
	cPai		:= Receber->Pai
	cMae		:= Receber->Mae
	cEnde1	:= Receber->Ende1
	cFone1	:= Receber->Fone1
	cProf 	:= Receber->Profissao
	cCargo	:= Receber->Cargo
	cTraba	:= Receber->Trabalho
	cFone2	:= Receber->Fone2
	cTempo	:= Receber->Tempo
	cVeicul	:= Receber->Veiculo
	cConhec	:= Receber->Conhecida
	cEnde3	:= Receber->Ende3
	cSpc		:= Receber->(IF( Spc, "S", "N" ))
	cCodi 	:= Receber->Codi
	cCep		:= Receber->Cep
	cCida 	:= Receber->Cida
	cEsta 	:= Receber->Esta
	cBair 	:= Receber->Bair

	lSair := FALSO
	IF !Receber->(TravaReg())
		Loop
	EndIF
	WHILE OK
		MaBox( 00 , 00 , 24 , 79, "ALTERACAO/EXCLUSAO DE CLIENTES" )
		Write( 01, 01, "Codigo.........:                                Data Cadastro..:")
		Write( 02, 01, "Nome...........:")
		Write( 03, 01, "Endereco.......:                                Estado Civil:")
		Write( 04, 01, "Cidade.........:                                Estado......:")
		Write( 05, 01, "Natural........:                                Nascimento..:")
		Write( 06, 01, "Identidade n§..:                                CPF.........:")
		Write( 07, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 08, 01, "Esposo(a)......:                                           Dependentes..:")
		Write( 09, 01, "Pai............:")
		Write( 10, 01, "Mae............:")
		Write( 11, 01, "Endereco.......:                                 Fone.:")
		Write( 12, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 13, 01, "Profissao......:                                 Cargo.:")
		Write( 14, 01, "Trabalho Atual.:                                 Fone..:")
		Write( 15, 01, "Tempo Servico..:                        Renda Mensal...:")
		Write( 16, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 17, 01, "Referencia.....:                                                  Spc...:")
		Write( 18, 01, "Referencia.....:")
		Write( 19, 01, "Bens Imoveis...:")
		Write( 20, 01, "Veiculos.......:")
		Write( 21, 01, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
		Write( 22, 01, "Pessoa Conhec..:")
		Write( 23, 01, "Endereco.......:")

		@ 01, 18 Get cCodi	  Pict PIC_RECEBER_CODI
		@ 01, 65 Get dData	  Pict "##/##/##"
		@ 02, 18 Get cNome	  Pict "@!"
		@ 03, 18 Get cEnde	  Pict "@!"
		@ 03, 63 Get cCivil	  Pict "@!"
		@ 04, 18 Get cCep 	  Pict "#####-###" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ 04, 28 Get cCida	  Pict "@!S21"
		@ 04, 63 Get cEsta	  Pict "@!"
		@ 05, 18 Get cNatural  Pict "@!"
		@ 05, 63 Get dNasc	  Pict "##/##/##"
		@ 06, 18 Get cRg		  Pict "@!"
		@ 06, 63 Get cCpf 	  Pict "999.999.999-99"
		@ 08, 18 Get cEsposa   Pict "@!"
		@ 08, 75 Get nDepe	  Pict "99"
		@ 09, 18 Get cPai 	  Pict "@!"
		@ 10, 18 Get cMae 	  Pict "@!"
		@ 11, 18 Get cEnde1	  Pict "@!"
		@ 11, 58 Get cFone1	  Pict "(9999)999-9999"
		@ 13, 18 Get cProf	  Pict "@!"
		@ 13, 58 Get cCargo	  Pict "@!"
		@ 14, 18 Get cTraba	  Pict "@!"
		@ 14, 58 Get cFone2	  Pict "(9999)999-9999"
		@ 15, 18 Get cTempo	  Pict "@!"
		@ 15, 58 Get nRenda	  Pict "99999999.99"
		@ 17, 18 Get cRef1	  Pict "@!"
		@ 17, 75 Get cSpc 	  Pict "!" Valid cSpc $ "SN"
		@ 18, 18 Get cRef2	  Pict "@!"
		@ 19, 18 Get cImovel   Pict "@!"
		@ 20, 18 Get cVeicul   Pict "@!"
		@ 22, 18 Get cConhec   Pict "@!"
		@ 23, 18 Get cEnde3	  Pict "@!"
		IF lDeletar
			Clear Gets
		Else
			Read
		EndIF
		IF LastKey() = ESC
			Receber->(Libera())
			lSair := OK
			Exit
		EndIF
		ErrorBeep()
		IF lDeletar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Excluir ", " Cancelar ", " Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar ", " Cancelar ", " Sair "})
		EndIF
		IF lDeletar
			IF nOpcao = 1		// Excluir
				Receber->(DbDelete())
				Receber->(Libera())
				Exit
			ElseIF nOpcao = 2 // Cancelar
				Receber->(Libera())
				Exit
			EndIF
		EndIF
		IF nOpcao = 1	// Incluir
			Receber->Codi		 := cCodi
			Receber->Data		 := dData
			Receber->Nome		 := cNome
			Receber->Cep		 := cCep
			Receber->Ende		 := cEnde
			Receber->Cida		 := cCida
			Receber->Esta		 := cEsta
			Receber->Rg 		 := cRg
			Receber->Cpf		 := cCpf
			Receber->Media 	 := nRenda
			Receber->RefCom	 := cRef1
			Receber->RefBco	 := cRef2
			Receber->Imovel	 := cImovel
			Receber->Civil 	 := cCivil
			Receber->Natural	 := cNatural
			Receber->Nasc		 := dNasc
			Receber->Esposa	 := cEsposa
			Receber->Depe		 := nDepe
			Receber->Pai		 := cPai
			Receber->Mae		 := cMae
			Receber->Ende1 	 := cEnde1
			Receber->Fone1 	 := cFone1
			Receber->Profissao := cProf
			Receber->Cargo 	 := cCargo
			Receber->Trabalho  := cTraba
			Receber->Fone2 	 := cFone2
			Receber->Tempo 	 := cTempo
			Receber->Veiculo	 := cVeicul
			Receber->Conhecida := cConhec
			Receber->Ende3 	 := cEnde3
			Receber->Spc		 := IF( cSpc = "S", OK, FALSO )
			Receber->(Libera())
			Exit
		ElseIf nOpcao = 2 // Cancelar
			Loop
		ElseIf nOpcao = 3 // Sair
			Receber->(Libera())
			lSair := OK
			Exit
		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit
	EndIF
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ReceGrafico()
******************
LOCAL cScreen := SaveScreen()
LOCAL cScreen1
LOCAL nChoice

WHILE OK
	DbClearFilter()
	DbGoTop()
	M_Title("GRAFICOS DE CONTAS A RECEBER" )
	nChoice := FazMenu( 07, 10, ;
				  { " Grafico Receber Por Cliente ",;
					 " Grafico Receber Geral       " }, Cor())
	cScreen1 := SaveScreen()
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		cCodi := Space( 05 )
		MaBox( 13, 10, 15, 78 )
		@ 14, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen1 )
			Loop
		EndIF
		GrafReceCodigo( cCodi )
		ResTela( cScreen1 )

	Case nChoice = 2
		GrafReceGeral()
		ResTela( cScreen1 )

	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------


Proc GrafReceGeral()
********************
LOCAL cScreen := SaveScreen()
LOCAL nAnual  := 0
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
LOCAL M[12,2]
LOCAL nBase := 1
PRIVA cAno	  := Space(02)

MaBox( 16, 10, 18, 45 )
@ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
IF LastKey() = ESC
	Restela( cScreen )
	Return
EndIF

aDataIni := { Ctod( "01/01/" + cAno ),;
			Ctod( "01/02/" + cAno ),;
			Ctod( "01/03/" + cAno ),;
			Ctod( "01/04/" + cAno ),;
			Ctod( "01/05/" + cAno ),;
			Ctod( "01/06/" + cAno ),;
			Ctod( "01/07/" + cAno ),;
			Ctod( "01/08/" + cAno ),;
			Ctod( "01/09/" + cAno ),;
			Ctod( "01/10/" + cAno ),;
			Ctod( "01/11/" + cAno ),;
			Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ),;
              IF( lAnoBissexto(cTod("28/02/" + cAno )), cTod("29/02/" + cAno ), cTod("28/02/" + cAno )),;
				  Ctod( "31/03/" + cAno ),;
				  Ctod( "30/04/" + cAno ),;
				  Ctod( "31/05/" + cAno ),;
				  Ctod( "30/06/" + cAno ),;
				  Ctod( "31/07/" + cAno ),;
				  Ctod( "31/08/" + cAno ),;
				  Ctod( "30/09/" + cAno ),;
				  Ctod( "31/10/" + cAno ),;
				  Ctod( "30/11/" + cAno ),;
				  Ctod( "31/12/" + cAno )}

Receber->(Order( RECEBER_CODI ))
Recibo->(Order( RECIBO_DOCNR ))
Area("Recemov")
Recemov->(Order( RECEMOV_VCTO ))
Mensagem( "INFO: Aguarde, calculando valores.", Cor())

For nX := 1 To 12
	M[nX,1] := 0
	dIni	  := aDataIni[nX]
	dFim	  := aDataFim[nX]
	Sx_SetScope( S_TOP, dIni )
	Sx_SetScope( S_BOTTOM, dFim )
	Recemov->(DbGoTop())
	While Recemov->(!Eof())
		IF !oAmbiente:Mostrar_Desativados
			IF Receber->(DbSeek( Recemov->Codi ))
				IF !Receber->Suporte
					Recemov->(DbSkip(1))
					Loop
				EndIF
			EndIF
		EndIF
		IF Recibo->(!DbSeek( Recemov->Docnr ))
			m[nX,1] += Recemov->Vlr
		EndIF
		Recemov->(DbSkip(1))
	EndDo
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	Recemov->(DbGoTop())
   nAnual += m[nX,1]
Next
SetColor("")
Cls

M[1,2]="JAN"
M[2,2]="FEV"
M[3,2]="MAR"
M[4,2]="ABR"
M[5,2]="MAI"
M[6,2]="JUN"
M[7,2]="JUL"
M[8,2]="AGO"
M[9,2]="SET"
M[10,2]="OUT"
M[11,2]="NOV"
M[12,2]="DEZ"

cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
Grafico( M,.T.,"EVOLUCAO MENSAL DE TITULOS A RECEBER - &cAno.", cValor,;
              AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc GrafReceCodigo( cCodi )
****************************
LOCAL cScreen := SaveScreen()
LOCAL nAnual  := 0
LOCAL nBase   := 1
LOCAL M[12,2]
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
LOCAL cValor
PRIVA cAno	  := Space(02)

MaBox( 16, 10, 18, 45 )
@ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
IF LastKey() = ESC
	Restela( cScreen )
	Return
EndIF

oMenu:Limpa()
aDataIni := { Ctod( "01/01/" + cAno ),;
		  Ctod( "01/02/" + cAno ),;
		  Ctod( "01/03/" + cAno ),;
		  Ctod( "01/04/" + cAno ),;
		  Ctod( "01/05/" + cAno ),;
		  Ctod( "01/06/" + cAno ),;
		  Ctod( "01/07/" + cAno ),;
		  Ctod( "01/08/" + cAno ),;
		  Ctod( "01/09/" + cAno ),;
		  Ctod( "01/10/" + cAno ),;
		  Ctod( "01/11/" + cAno ),;
		  Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ),;
        IF( lAnoBissexto(cTod("28/02/" + cAno )), cTod("29/02/" + cAno ), cTod("28/02/" + cAno )),;
		  Ctod( "31/03/" + cAno ),;
		  Ctod( "30/04/" + cAno ),;
		  Ctod( "31/05/" + cAno ),;
		  Ctod( "30/06/" + cAno ),;
		  Ctod( "31/07/" + cAno ),;
		  Ctod( "31/08/" + cAno ),;
		  Ctod( "30/09/" + cAno ),;
		  Ctod( "31/10/" + cAno ),;
		  Ctod( "30/11/" + cAno ),;
		  Ctod( "31/12/" + cAno )}

Area("Recemov")
Recemov->(Order( RECEMOV_CODI ))
Sx_SetScope( S_TOP, cCodi)
Sx_SetScope( S_BOTTOM, cCodi )
Recemov->(DbGoTop())
Mensagem( "INFO: Aguarde, Calculando Valores.", Cor())
For nX := 1 To 12
	M[nX,1] := 0
	Sum Recemov->Vlr To M[nX,1] For Recemov->Vcto >= aDataIni[nX] .AND. Recemov->Vcto <= aDataFim[nX]
   nAnual += m[nX,1]
Next
SetColor("")
Cls
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Recemov->(DbGoTop())

M[1,2]="JAN"
M[2,2]="FEV"
M[3,2]="MAR"
M[4,2]="ABR"
M[5,2]="MAI"
M[6,2]="JUN"
M[7,2]="JUL"
M[8,2]="AGO"
M[9,2]="SET"
M[10,2]="OUT"
M[11,2]="NOV"
M[12,2]="DEZ"

cNome  := Receber->( AllTrim( Nome ) )
cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
Grafico( M,.T.,"EVOLUCAO MENSAL DE TITULOS A RECEBER - &cNome.", cValor,;
              AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
ResTela( cScreen )
Return

Proc FechtoMes()
****************
LOCAL cScreen := SaveScreen()
LOCAL nChoice
LOCAL oBloco
LOCAL nJuro
LOCAL cPort
LOCAL nPorc
LOCAL nJdia
LOCAL dEmis
LOCAL dVcto
LOCAL nValor
LOCAL nCotacao

ErrorBeep()
Alert("ATENCAO!!;Procure conhecer esta opcao junto;ao Depto. de Suporte antes de usa-la.")

WHILE OK
	M_Title("ENTRADAS POR FORNECEDOR")
	nChoice := FazMenu( 05, 20, { "Individual", "Todos" })
	IF nChoice = 0
		ResTela( cScreen )
		Exit

	ElseIF nChoice = 1
		Area("Receber")
		Receber->( Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		cCodi := Space( 05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 11, 20, 15, 45 )
		@ 12, 21 Say "Cliente.....:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 13, 21 Say "Emis Inicial:" Get dIni  Pict "##/##/##"
		@ 14, 21 Say "Emis Final..:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		EndIF
		oCondicao := {|| Receber->Codi = cCodi }

	ElseIF nChoice = 2
		Area("Receber")
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		cCodi 	 := Space(05)
		oCondicao := {|| cProx( @cCodi ) }
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 12, 20, 15, 45 )
		@ 13, 21 Say "Emissao Ini ¯" Get dIni Pict "##/##/##"
		@ 14, 21 Say "Emissao Fim ¯" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
	EndIF
	MaBox( 16, 20, 19, 55 )
	dEmis 	:= Date()
	dVcto 	:= Date()+30
	nCotacao := 0
	MaBox( 16, 20, 19, 57 )
	@ 17, 21 Say "Emissao do Fechamento..:" Get dEmis Pict "##/##/##"
	@ 18, 21 Say "Vencto  do Fechamento..:" Get dVcto Pict "##/##/##" Valid dVcto >= dEmis
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Loop
	EndIF
	lTitulo := Conf("Pergunta: Refazer fechamento no Futuro ?")
	While Eval( oCondicao )
		IF nChoice = 1
			oCondicao := {|| FALSO }
		EndIF
		Area( "Recemov" )
		Recemov->(Order( RECEMOV_CODI ))
		IF Recemov->(!Dbseek( cCodi ))
			IF nChoice = 1
				ErrorBeep()
				oMenu:Limpa()
				Alerta("Erro: Sem registros a processar deste cliente...")
			EndIF
			Loop
		EndIF
		IF Recemov->(!TravaArq())
			Loop
		EndIF
		nJuro 		:= Recemov->Juro
		cPort 		:= Recemov->Port
		nPorc 		:= Recemov->Porc
		cTipo 		:= Recemov->Tipo
		oBloco		:= {|| Recemov->Codi = cCodi }
		cTela 		:= Mensagem("Aguarde... Verificando e Ordenando Movimento.")
		nValor		:= 0
		WHILE Eval( oBloco )
			IF Recemov->Titulo .OR. Recemov->Emis < dIni .OR. Recemov->Emis > dFim
				Recemov->(DbSkip(1))
				Loop
			EndIF
			nValor += Recemov->Vlr
			Recemov->(DbDelete())
			Recemov->(DbSkip(1))
		EndDo
		IF nValor != 0
			cDocnr := Right( cCodi,3) + StrTran( Time(), ":")
			Recemov->(DbAppend())
			Recemov->Codi	  := cCodi
			Recemov->Jurodia := JuroDia( nValor, nJuro )
			Recemov->Juro	  := nJuro
			Recemov->Port	  := cPort
			Recemov->Porc	  := nPorc
			Recemov->Emis	  := dEmis
			Recemov->Vcto	  := dVcto
			Recemov->Docnr   := cDocnr
			Recemov->Fatura  := cDocnr
			Recemov->Tipo	  := cTipo
			Recemov->Titulo  := IF( lTitulo, FALSO, OK )
			Recemov->Vlr	  := nValor
			Recemov->Regiao  := Receber->Regiao
			Recemov->(Libera())
			nValor			  := 0
		Else
			IF nChoice = 1
				Recemov->(Libera())
				ErrorBeep()
				oMenu:Limpa()
				Alerta("Erro: Sem registros a processar deste cliente...")
			EndIF
		EndIF
	EndDo
	Recemov->(Libera())
	Restela( cScreen )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Function cProx( cCodi )
***********************
Receber->(DbSkip())
cCodi := Receber->Codi
Return( Receber->(!Eof()))

*:---------------------------------------------------------------------------------------------------------------------------------

Proc EtiquetasClientes()
************************
LOCAL cScreen		 := SaveScreen()
LOCAL aMenu 		 := { " Individual ", " Por Aniversario ", " Ultima Compra", " Geral Ordem Codigo ", " Geral Ordem Nome ", " Configurar Etiquetas " }
LOCAL cCodi 		 := Space(04)
LOCAL cTemp 		 := FTempName("*.TMP")
LOCAL nChoice		 := 1
LOCAL nEtiquetas	 := 1
LOCAL aConfig		 := {}
LOCAL nRecno		 := 0
LOCAL nCampos		 := 5
LOCAL nTamanho 	 := 35
LOCAL nMargem		 := 0
LOCAL nLinhas		 := 1
LOCAL nEspacos 	 := 1
LOCAL nCarreira	 := 1
LOCAL nX 			 := 0
LOCAL aArray		 := {}
LOCAL aGets 		 := {}
LOCAL lComprimir	 := FALSO
LOCAL lSpVert		 := FALSO
LOCAL nAniversario := 5
LOCAL nDias 		 := 0
LOCAL cDebitos 	 := "N"
LOCAL oBloco

WHILE OK
	 M_Title("IMPRESSAO DE ETIQUETAS CLIENTES" )
	 nChoice := FazMenu( 03, 10, aMenu, Cor())
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		 WHILE OK
			 Area("Receber")
			 Receber->(Order( RECEBER_CODI ))
			 cCodi		 := Space(05)
			 nEtiquetas  := 1
			 cArquivo	 := Space(11)
			 MaBox( 16 , 10 , 19 , 78 )
			 @ 17, 11 Say	"Cliente....:" Get cCodi      Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col() + 5 )
			 @ 18, 11 Say	"Quantidade.:" Get nEtiquetas Pict "9999" Valid nEtiquetas > 0
			 Read
			 IF LastKey( ) = ESC
				 ResTela( cScreen )
				 Exit
			 EndIF
			 aConfig := LerEtiqueta()
			 IF !InsTru80() .OR. !LptOk()
				 ResTela( cScreen )
				 Return
			 EndIF
			 nLen := Len( aConfig )
			 IF nLen > 0
				 nCampos 	:= aConfig[1]
				 nTamanho	:= aConfig[2]
				 nMargem 	:= aConfig[3]
				 nLinhas 	:= aConfig[4]
				 nEspacos	:= aConfig[5]
				 nCarreira	:= aConfig[6]
				 lComprimir := aConfig[7] == 1
				 lSpVert 	:= aConfig[8] == 1
				 For nX := 9 To nLen
					 Aadd( aGets, aConfig[nX] )
				 Next
			 EndIF
			 aLinha := Array( aConfig[1] )
			 Afill( aLinha, "" )
			 PrintOn()
			 FPrint( _SALTOOFF ) // Inibir salto picote
			 IF lComprimir
				 FPrint( PQ )
			 EndIF
			 IF lSpVert
				 Fprint( _SPACO1_8 )
			 EndIF
			 SetPrc( 0, 0 )
			 nConta := 0
			 nCol 		:= nMargem
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + IF( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 IF nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 //Qout( aLinha[nC] )
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 EndIF
			 Next nY
			 IF nConta >0
				 For nC := 1 To nCampos
					 Qout( Space( nMargem) + aLinha[nC] )
					 aLinha[nC] := ""
				 Next
				 For nD := 1 To nLinhas
					 Qout()
				 Next
			 EndIF
			 PrintOFF()
			 ResTela( cScreen )
		 EndDo

	 Case nChoice = 2
		 IF !Selecao( nAniversario, @oBloco )
			 ResTela( cScreen )
			 Loop
		 EndIf
		 aConfig := LerEtiqueta()
		 IF !InsTru80() .OR. !LptOk()
			 xAlias->(DbCloseArea())
			 ResTela( cScreen )
			 Return
		 EndIF
		 nLen := Len( aConfig )
		 IF nLen > 0
			 nCampos 	:= aConfig[1]
			 nTamanho	:= aConfig[2]
			 nMargem 	:= aConfig[3]
			 nLinhas 	:= aConfig[4]
			 nEspacos	:= aConfig[5]
			 nCarreira	:= aConfig[6]
			 lComprimir := aConfig[7] == 1
			 lSpVert 	:= aConfig[8] == 1
			 For nX := 9 To nLen
				 Aadd( aGets, aConfig[nX] )
			 Next
		 EndIF
		 aLinha := Array( aConfig[1] )
		 Afill( aLinha, "" )
		 PrintOn()
		 FPrint( _SALTOOFF )
		 IF lComprimir
			 FPrint( PQ )
		 EndIF
		 IF lSpVert
			 Fprint( _SPACO1_8 )
		 EndIF
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 WHILE xAlias->(!Eof()) .AND. Rep_Ok()
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + IF( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 IF nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 //Qout( aLinha[nC] )
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 EndIF
			 Next nY
			 DbSkip(1)
		 EndDo
		 IF nConta >0
			 For nC := 1 To nCampos
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 EndIF
		 xAlias->(DbCloseArea())
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 3
		 oMenu:Limpa()
		 MaBox( 10, 10, 13, 45 )
		 @ 11, 11 Say "Dias da Ultima Compra........:" Get nDias    Pict "999"
		 @ 12, 11 Say "Imprimir Carta se tem debitos:" Get cDebitos Pict "!" Valid cDebitos $ "SN"
		 Read
		 IF LastKey() = ESC
			 ResTela( cScreen )
			 Loop
		 EndIF
		 Area("Receber")
		 Receber->(Order( RECEBER_CODI ))
		 Receber->(DbGoTop())
		 cUltCodigo  := Codi
		 aConfig 	 := LerEtiqueta()
		 IF !InsTru80() .OR. !LptOk()
			 ResTela( cScreen )
			 Loop
		 EndIF
		 nLen := Len( aConfig )
		 IF nLen > 0
			 nCampos 	:= aConfig[1]
			 nTamanho	:= aConfig[2]
			 nMargem 	:= aConfig[3]
			 nLinhas 	:= aConfig[4]
			 nEspacos	:= aConfig[5]
			 nCarreira	:= aConfig[6]
			 lComprimir := aConfig[7] == 1
			 lSpVert 	:= aConfig[8] == 1
			 For nX := 9 To nLen
				 Aadd( aGets, aConfig[nX] )
			 Next
		 EndIF
		 aLinha := Array( aConfig[1] )
		 Afill( aLinha, "" )
		 PrintOn()
		 FPrint( _SALTOOFF )
		 IF lComprimir
			 FPrint( PQ )
		 EndIF
		 IF lSpVert
			 Fprint( _SPACO1_8 )
		 EndIF
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 oMenu:Limpa()
		 cTela	:= Mensagem("Aguarde, Imprimindo. ", WARNING )
		 Recemov->(Order( RECEMOV_CODI ))
		 WHILE !Eof() .AND. Rep_Ok()
			 IF ( Date() - UltCompra ) >= nDias
				 IF cDebitos = "N"
					 IF Recemov->(DbSeek( cUltCodigo ))
						 cUltCodi := Codi
						 DbSkip(1)
						 Loop
					 EndIF
				 EndIF
			 Else
				 cUltCodi := Codi
				 DbSkip(1)
				 Loop
			 EndIF
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + IF( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 IF nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 EndIF
			 Next nY
			 cUltCodi := Codi
			 DbSkip(1)
		 EndDo
		 IF nConta >0
			 For nC := 1 To nCampos
				 //Qout( aLinha[nC] )
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 EndIF
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 4 .OR. nChoice = 5
		 Area("Receber")
		 IF nChoice = 2
			 Receber->(Order( RECEBER_CODI ))
		 Else
			 Receber->(Order( RECEBER_NOME ))
		 EndIF
		 Receber->(DbGoTop())
		 aConfig := LerEtiqueta()
		 IF !InsTru80() .OR. !LptOk()
			 ResTela( cScreen )
			 Loop
		 EndIF
		 nLen := Len( aConfig )
		 IF nLen > 0
			 nCampos 	:= aConfig[1]
			 nTamanho	:= aConfig[2]
			 nMargem 	:= aConfig[3]
			 nLinhas 	:= aConfig[4]
			 nEspacos	:= aConfig[5]
			 nCarreira	:= aConfig[6]
			 lComprimir := aConfig[7] == 1
			 lSpVert 	:= aConfig[8] == 1
			 For nX := 9 To nLen
				 Aadd( aGets, aConfig[nX] )
			 Next
		 EndIF
		 aLinha := Array( aConfig[1] )
		 Afill( aLinha, "" )
		 PrintOn()
		 FPrint( _SALTOOFF )
		 IF lComprimir
			 FPrint( PQ )
		 EndIF
		 IF lSpVert
			 Fprint( _SPACO1_8 )
		 EndIF
		 SetPrc( 0, 0 )
		 nConta		:= 0
		 nEtiquetas := 1
		 nCol 		:= nMargem
		 WHILE !Eof() .AND. Rep_Ok()
			 For nY := 1 To nEtiquetas
				 nConta++
				 For nB := 1 To nCampos
					 cVar := aGets[nB]
					 nTam := Len( &cVar. )
					 aLinha[nB] += &cVar. + IF( nConta = nCarreira, "", Space( ( nTamanho - nTam ) + nEspacos ))
				 Next
				 IF nConta = nCarreira
					 nConta := 0
					 For nC := 1 To nCampos
						 //Qout( aLinha[nC] )
						 Qout( Space( nMargem) + aLinha[nC] )
						 aLinha[nC] := ""
					 Next
					 For nD := 1 To nLinhas
						 Qout()
					 Next
				 EndIF
			 Next nY
			 DbSkip(1)
		 EndDo
		 IF nConta >0
			 For nC := 1 To nCampos
				 Qout( Space( nMargem) + aLinha[nC] )
				 aLinha[nC] := ""
			 Next
			 For nD := 1 To nLinhas
				 Qout()
			 Next
		 EndIF
		 PrintOFF()
		 ResTela( cScreen )

	 Case nChoice = 6
		 ConfigurarEtiqueta()
		 ResTela( cScreen )

	 EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------


Proc RelReceber()
*****************
LOCAL cScreen	 := SaveScreen()
LOCAL AtPrompt  := {"Por Data de Vencimento","Por Data de Emissao","Relatorio de Cobranca","Relatorio de Cobranca Seletiva","Totalizado","Por Vendedor","Fluxo Sintetico",'Rol Percentual Pagar/Pago'}
LOCAL cCodiVen  := Space(04)
LOCAL dIni		 := Date()-30
LOCAL dFim		 := Date()
LOCAL nChoice

WHILE OK
	oMenu:Limpa()
	M_Title( "ROL DE TITULOS A RECEBER")
	nChoice := FazMenu( 01 , 18,	AtPrompt, Cor() )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit
	Case nChoice = 1 .OR. nChoice = 2
		RelRecDual( nChoice, NIL, atPrompt[nChoice])
	Case nChoice = 3
		RelRecCobranca()
	Case nChoice = 4
		RelRecSeletiva()
	Case nChoice = 5
		RelRecTotalizado()
	Case nChoice = 6
		MaBox( 12 , 18 , 14, 77 )
		@ 13 , 19 Say	"Vendedor:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		RelRecDual( nChoice, cCodiVen, atPrompt[nChoice])
	Case nChoice = 7
		Fluxo()
	Case nChoice = 8
		RolPagarPago()
	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecDual( nVctoOuEmis, cCodiVen, cTitle )
*************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL AtPrompt  := { "Por Periodo","Individual", "Por Regiao", "Por Tipo", "Por Portador", "Ordem Alfabetica", "Por Cidade", "Por Grupo de Produtos"}
LOCAL aOrDual	 := { "Nome","Codigo", "Cidade", "Regiao", "Estado","Fantasia", "Endereco" }
LOCAL cRegiao	 := NIL
LOCAL cTipo 	 := NIL
LOCAL cPortador := NIL
LOCAL cCida 	 := NIL
LOCAL cGrupo	 := NIL
LOCAL cTitulo
LOCAL nChoice
LOCAL nOrDual

WHILE OK
	M_Title( AllTrim( Upper( cTitle )))
	nChoice := FazMenu( 03 , 20,	AtPrompt, Cor() )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		Recemov->(DbGoTop())
		M_Title('ORDEM A IMPRIMIR')
		nOrDual := FazMenu( 05 , 22, aOrDual )
		IF nOrDual = 0
			ResTela( cScreen )
			Exit
		EndIF
		Receber->( Order( nOrDual ))
		Receber->(DbGoTop())
		oBloco := {|| Receber->(!Eof()) }
		cTitulo := "ROL GERAL DE TITULOS A RECEBER NO PERIODO DE "
		RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )

	Case nChoice = 2
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cCodi := Space(05)
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Receber->( Order( RECEBER_NOME ))
			oBloco := {|| Receber->Codi = cCodi }
			cTitulo := "ROL INDIVIDUAL DE TITULOS A RECEBER NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 3
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cRegiao := Space( 02 )
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Regiao..:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DA REGIAO " + cRegiao + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 4
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cTipo := Space( 06 )
			MaBox( 15 , 20 , 17 , 36 )
			@ 16 , 21 Say	"Tipo :" Get cTipo  Pict "@!" Valid !Empty( cTipo )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Area("Recemov")
			Recemov->(Order( RECEMOV_TIPO_CODI ))
			IF Recemov->(!DbSeek( cTipo ))
				Alerta("Erro: Tipo nao Localizado.")
				Loop
			EndIF
			Receber->( Order( RECEBER_CODI ))
			Set Rela To Recemov->Codi Into Receber
			oBloco := {|| Recemov->Tipo = cTipo }
			cTitulo := "ROL GERAL TITULOS A RECEBER POR TIPO " + cTipo + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
			Recemov->(DbClearRel())
			Recemov->(DbGoTop())
		EndDo

	Case nChoice = 5
		WHILE OK
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Recemov->(DbGoTop())
			cPortador := Space( 10 )
			MaBox( 15 , 20 , 17 , 42 )
			@ 16 , 21 Say	"Portador :" Get cPortador Pict "@!" Valid !Empty( cPortador )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER POR PORTADOR " + cPortador + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen )
		EndDo

	Case nChoice = 6
		PrnAlfabetica( nVctoOuEmis)

	Case nChoice = 7
		WHILE OK
			cCida := Space(25)
			MaBox( 15 , 20 , 17 , 56 )
			@ 16 , 21 Say	"Cidade..:" Get cCida Pict "@!"
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DA CIDADE " + AllTrim( cCida ) + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida )
		EndDo

	Case nChoice = 8 // Por Grupo de Produtos
		WHILE OK
			cGrupo := Space(3)
			MaBox( 15 , 20 , 17 , 56 )
			@ 16 , 21 Say	"Grupo...:" Get cGrupo Pict "999" Valid GrupoErrado( @cGrupo )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
			Area("ReceMov")
			Recemov->(Order( RECEMOV_CODI ))
			Receber->( Order( RECEBER_NOME ))
			Receber->(DbGoTop())
			oBloco  := {|| Receber->(!Eof()) }
			cTitulo := "ROL GERAL TITULOS A RECEBER DO GRUPO " + cGrupo + " NO PERIODO DE "
			RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida, cGrupo )
		EndDo

	EndCase
	ResTela( cScreen )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RolPorPeriodo( cTitulo, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nChoice, cCodiVen, cCida, cGrupo )
***************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {"Normal", "Resumido", "Totalizado", "Juntado"}
LOCAL nResumo	 := 1
LOCAL lJuntado  := FALSO
LOCAL dIni
LOCAL dFim
LOCAL dAtual
LOCAL cCodi

dIni	  := Date() - 30
dFim	  := Date()
dAtual  := Date()
MaBox( 15 , 20 , 19, 50 )
IF nVctoOuEmis = 1  .OR. nVctoOuEmis = 5 // Por Vencimento
	@ 16 , 21 Say	"Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 17 , 21 Say	"Data Vcto Final....:" Get dFim    Pict "##/##/##"
	@ 18 , 21 Say	"Data Para Calculo..:" Get dAtual  Pict "##/##/##"
Else
	@ 16 , 21 Say	"Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 17 , 21 Say	"Data Emis Final....:" Get dFim    Pict "##/##/##"
	@ 18 , 21 Say	"Data Para Calculo..:" Get dAtual  Pict "##/##/##"
EndIF
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
M_Title("TIPO REL")
nResumo := FazMenu( 15 , 51 , aMenu, Cor())
IF nResumo = 0
	ResTela( cScreen )
	Return
EndIF
IF nResumo = 4
	nResumo = 1
	lJuntado := OK
EndIF
cTitulo += Dtoc( dIni ) + " A " + Dtoc( dFim )
IF nChoice = 4 // Por Tipo
	RolPorTipo( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen )
Else
	Prn002( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen, cCida, cGrupo, lJuntado )
EndIF
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Prn002( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen, cCida, cGrupo, lJuntado )
**************************************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL UltCodi	  := Recemov->Codi
LOCAL GrandTotal := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDesconto  := 0
LOCAL nMulta	  := 0
LOCAL nDocumento := 0
LOCAL cTela
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL lMarcado

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
cTela 	:= Mensagem("Informe: Aguarde, imprimindo.", Cor())
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
WHILE Eval( oBloco )
	cCodiReceber := Receber->Codi
	IF !lMarcado
		IF Receber->Rol = OK
			Receber->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF cCida != NIL
		IF Receber->Cida != cCida
			Receber->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF cRegiao != NIL
		IF Receber->Regiao != cRegiao
			Receber->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF Recemov->(!DbSeek( cCodiReceber ))
		Receber->(DbSkip(1))
		Loop
	EndIF
	NovoCodi := OK
	WHILE Recemov->Codi = cCodiReceber .AND. Recemov->(!Eof()) .AND. Rel_Ok()
		IF cGrupo != NIL
			IF Recemov->CodGrupo != cGrupo
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF cCodiVen != NIL
			IF Recemov->CodiVen != cCodiVen
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF cTipo != NIL
			IF Recemov->Tipo != cTipo
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF cPortador != NIL
			IF Recemov->Port != cPortador
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF dIni != NIL
			IF nVctoOuEmis = 1 .OR. nVctoOuEmis = 5 // Vencimento
				IF Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
					Recemov->(DbSkip(1))
					Loop
				EndIF
			Else
				IF Recemov->Emis < dIni .OR. Recemov->Emis > dFim
					Recemov->(DbSkip(1))
					Loop
				EndIF
			EndIF
		EndIF
		dData 	 := IF( dAtual = Nil, Date(), dAtual )
		Atraso	 := Atraso( dData, Recemov->Vcto )
		nCarencia := Carencia( dData, Recemov->Vcto )
		nMulta	 := VlrMulta( dData, Recemov->Vcto, Recemov->Vlr )
		nDesconto := VlrDesconto( dData, Recemov->Vcto, Recemov->Vlr )
		IF Atraso <= 0
			Juros := 0
		Else
			Juros  := Jurodia * nCarencia
		EndIF
		IF Col >= 57
			Write( 01, 001, "Pagina N§ " + StrZero( ++Pagina , 3 ) )
			Write( 01, 117, "Horas "+ Time())
			Write( 02, 001, Dtoc( Date() ))
         Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
			Write( 04, 000, Padc( Lista  , Tam ))
			Write( 05, 000, Padc( cTitulo , Tam ))
			Write( 06, 000, Repl( "=", Tam ) )
			#IFDEF CICLO
				Write( 07, 000, "DOC N§    TIPO    EMISSAO     VCTO NOSSONR       PORTADOR     VLR TITULO JR MES ATR  JR DIARIO              TOTAL JUROS  TOTAL GERAL")
			#ELSE
				Write( 07, 000, "DOC N§    TIPO    EMISSAO     VCTO PORTADOR     VLR TITULO JR MES ATR  JR DIARIO     DESCONTO        MULTA  TOTAL JUROS  TOTAL GERAL")
			#ENDIF
			Write( 08, 000, Repl( "=", Tam ) )
			Col := 9
		EndIF
		IF nResumo = 1 // Normal
			IF NovoCodi .OR. Col = 9
				IF NovoCodi
					NovoCodi := FALSO
				EndIF
				Qout( Codi, Receber->Regiao, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)), Receber->( Trim( Cida )), Receber->Esta )
				Qout( Space(05), "SPC:" + IF( Receber->Spc, "SIM em " + Dtoc( Receber->DataSpc ), "NAO"),Space(1), Receber->Fanta, Receber->Obs )
				Col += 2
			EndIF
		EndIF
		cCodi 	 := Codi
		cNome 	 := Receber->Nome
		dEmis 	 := Dtoc( Emis )
		dVcto 	 := Dtoc( Vcto )
		nJuro 	 := Tran( Juro,	"999.99")
		nAtraso	 := Tran( Atraso, "999")
		nJdia 	 := Tran( Jurodia,		"@E 999,999.99")
		nValor	 := Tran( Vlr, 			"@E 9,999,999.99")
		nJuros	 := Tran( Juros,			"@E 9,999,999.99")
		cDesconto := Tran( nDesconto, 	"@E 9,999,999.99")
		cMulta	 := Tran( nMulta, 		"@E 9,999,999.99")
		nJrVlr	 := Tran(((Vlr + Juros ) + nMulta ) - nDesconto,  "@E 9,999,999.99")

		IF nResumo = 1 // Normal
			#IFDEF CICLO
				Qout( Docnr, Tipo, dEmis, dVcto, NossoNr, Port, nValor, nJuro, nAtraso, nJdia, Space(11), nJuros, nJrVlr )
			#ELSE
				Qout( Docnr, Tipo, dEmis, dVcto, Port, nValor, nJuro, nAtraso, nJdia, cDesconto, cMulta, nJuros, nJrVlr )
			#ENDIF
			Col++
		EndIF
		TotalCli   += Vlr
		TotalJur   += Juros
		TotalGer   += ((( Vlr + Juros ) + nMulta ) - nDesconto )
		GrandTotal += Vlr
		GrandJuros += Juros
		GrandGeral += ((( Vlr + Juros ) + nMulta ) - nDesconto )
		nDocumento ++
		Recemov->(DbSkip(1))
		IF Col >= 57
			IF nResumo = 1 // Normal
				Col++
				Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
				Col		+= 2
				__Eject()
			EndIF
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
		EndIF
  EndDo
  IF lJuntado
	  Prevenda->(Order( PREVENDA_FATURA ))
	  Prevenda->(DbGotop())
	  WHILE Prevenda->(!Eof())
		  IF Prevenda->Codi = cCodi
			  cDesconto := Tran( 0, "@E 9,999,999.99")
			  cMulta 	:= Tran( 0, "@E 9,999,999.99")
			  nValor 	:= Tran( Prevenda->VlrFatura, "@E 9,999,999.99")
			  nJuro		:= Tran( 0, "999.99")
			  nAtraso	:= Tran( 0, "999")
			  nJdia		:= Tran( 0, "@E 999,999.99")
			  nJuros 	:= Tran( 0, "@E 9,999,999.99")
			  cMulta 	:= Tran( 0, "@E 9,999,999.99")
			  nJrVlr 	:= Tran(((Vlr + Juros ) + nMulta ) - nDesconto,  "@E 9,999,999.99")
			  #IFDEF CICLO
				  Qout( Prevenda->Fatura, 'PREVENDA', Prevenda->Emis, Prevenda->Emis, Space(13), Space(10), nValor, nJuro, nAtraso, nJdia, Space(11), nJuros, nValor )
			  #ELSE
				  Qout( Prevenda->Fatura, 'PREVENDA', Prevenda->Emis, Prevenda->Emis, Space(10), nValor, nJuro, nAtraso, nJdia, cDesconto, cMulta, nJuros, nValor )
			  #ENDIF
			  TotalCli	 += Prevenda->VlrFatura
			  TotalGer	 += Prevenda->VlrFatura
			  GrandTotal += Prevenda->VlrFatura
			  GrandGeral += Prevenda->VlrFatura
			  nDocumento ++
			  Col++
			  xFatura := Prevenda->Fatura
			  WHILE Prevenda->Fatura = xFatura
				  Prevenda->(DbSkip(1))
			  EndDo
		  EndIF
		  Prevenda->(DbSkip(1))
	  EndDO
  EndIF
  IF TotalCli != 0
	  IF nResumo = 1 // Normal
		  Col++
		  Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		  Col 	  += 2
	  ElseIF nResumo = 3 // Totalizado
		  Write(  Col , 000, cCodi )
		  Write(  Col , 005, cNome )
		  Write(  Col , 048, Tran( TotalCli, "@E 999,999.99" ))
		  Write(  Col , 109, Tran( TotalJur, "@E 999,999.99" ))
		  Write(  Col , 122, Tran( TotalGer, "@E 999,999.99" ))
		  Col++
	  EndIF
	  TotalCli := 0
	  TotalJur := 0
	  TotalGer := 0
  EndIF
  Receber->(DbSkip(1))
EndDo
Qout()
Col++
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nDocumento, 6 ))
Write(  Col , 046, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 107, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 120, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RolPorTipo( cTitulo, dIni, dFim, dAtual, oBloco, cRegiao, cTipo, cPortador, nVctoOuEmis, nResumo, cCodiVen )
*****************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL GrandTotal := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDocumento := 0
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL UltCodi
LOCAL cTela
LOCAL lMarcado
LOCAL cCodi

ErrorBeep()
lMarcado := Conf('Pergunta: Incluir no relatorio os marcados ?')
IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
cTela 	:= Mensagem("Informe: Aguarde, imprimindo.", Cor())
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
UltCodi	:= Recemov->Codi
NovoCodi := OK
WHILE Recemov->Tipo = cTipo .AND. Rel_Ok()
	cCodi := Recemov->Codi
	IF !lMarcado
		Receber->(DbSeek( cCodi ))
		IF Receber->Rol = OK
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF cCodiVen != NIL
		IF Recemov->CodiVen != cCodiVen
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF Recemov->Codi != UltCodi
		NovoCodi := OK
		UltCodi	:= Recemov->Codi
		IF TotalCli != 0
			IF nResumo = 1 // Normal
				Col++
				Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
				Col		+= 2
			EndIF
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
		EndIF
	 EndIF
	 IF dIni != NIL
		 IF nVctoOuEmis = 1 .OR. nVctoOuEmis = 5 // Por Vencimento
			 IF Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
				 Recemov->(DbSkip(1))
				 Loop
			 EndIF
		 Else
			 IF Recemov->Emis < dIni .OR. Recemov->Emis > dFim
				 Recemov->(DbSkip(1))
				 Loop
			 EndIF
		 EndIF
	 EndIF
	 IF dAtual = Nil
		 Atraso	  := Atraso( Date(), Vcto )
		 nCarencia := Carencia( Date(), Vcto )
		 IF Atraso <= 0
			 Juros := 0
		 Else
			Juros  := Jurodia * nCarencia
		 EndIF
	 Else
		 Atraso	  := Atraso( dAtual, Vcto )
		 nCarencia := Carencia( dAtual, Vcto )
		 IF Atraso <= 0
			 Juros := 0
		 Else
			Juros  := Jurodia * nCarencia
		 EndIF
	 EndIF
	 IF Col >= 57
		 Write( 01, 001, "Pagina N§ " + StrZero( ++Pagina , 3 ) )
		 Write( 01, 117, "Horas "+ Time())
		 Write( 02, 001, Dtoc( Date() ))
       Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		 Write( 04, 000, Padc( Lista	, Tam ))
		 Write( 05, 000, Padc( cTitulo , Tam ))
		 Write( 06, 000, Repl( "=", Tam ) )
		 Write( 07, 000, "DOC N§    TIPO   EMISSAO  VCTO      NOSSONR      PORTADOR         VLR TITULO JR MES ATRASO  JUROS DIA   TOTAL JUROS    VALOR + JUROS")
		 Write( 08, 000, Repl( "=", Tam ) )
		 Col := 9
	 EndIF
	 IF nResumo = 1 // Normal
		 IF NovoCodi .OR. Col = 9
	  IF NovoCodi
		  NovoCodi := FALSO
	  EndIF
	  Qout( Codi, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)),Receber->( Trim( Cida )), Receber->Esta )
	  Qout()
	  Col += 2
		 EndIF
	 EndIF
	 dEmis	:= Dtoc( Emis )
	 dVcto	:= Dtoc( Vcto )
	 nValor	:= Tran( Vlr,	"@E 9,999,999,999.99")
	 nJuro	:= Tran( Juro, "999.99")
	 nAtraso := Tran( Atraso, "999")
	 nJdia	:= Tran( Jurodia,  "@E 99,999,999.99")
	 nJuros	:= Tran( Juros,  "@E 99,999,999.99")
	 nJrVlr	:= Tran( Juros + Vlr,  "@E 9,999,999,999.99")
	 IF nResumo = 1 // Normal
		 Qout( Docnr, Tipo, dEmis, dVcto, NossoNr, Port, nValor, nJuro, nAtraso, nJdia, nJuros, nJrVlr )
		 Col++
	 EndIF
	 Totalcli	+= Vlr
	 Totaljur	+= Juros
	 Totalger	+= (Juros + Vlr)
	 GrandTotal += Vlr
	 GrandJuros += Juros
	 GrandGeral += ( Vlr+Juros )
	 nDocumento ++
	 Recemov->(DbSkip(1))
	 IF Col >= 57
		 IF nResumo = 1 // Normal
			 Col++
			 Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
			 Col		 += 2
			 __Eject()
		 EndIF
		 TotalCli := 0
		 TotalJur := 0
		 TotalGer := 0
	 EndIF
EndDo
IF TotalCli != 0
	IF nResumo = 1 // Normal
		Col++
		Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		Col		+= 2
	EndIF
	TotalCli := 0
	TotalJur := 0
	TotalGer := 0
EndIF
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nDocumento, 6 ))
Write(  Col , 060, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 099, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 116, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
*******************************************************
Write(  Col,	000, "** Total Cliente **")
Write(  Col,	046, Tran( TotalCli, "@E 9,999,999.99"))
Write(  Col,	107, Tran( TotalJur, "@E 9,999,999.99"))
Write(  Col,	120, Tran( Totalger, "@E 9,999,999.99"))
Write(  Col+1, 000, Repl( SEP , Tam ) )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecCobranca()
*********************
LOCAL cScreen		  := SaveScreen()
LOCAL aCodi 		  := {}
LOCAL aOrdem		  := {"Codigo","Nome","Endereco","Bairro", "Cidade","Selecao" }
LOCAL aTipo 		  := {"Normal", "Total"}
LOCAL nTam			  := 0
LOCAL dIni			  := Date()-30
LOCAL dFim			  := Date()
LOCAL dAtual		  := Date()
LOCAL dProxCob 	  := Date()-30
LOCAL dProxCobFim   := Date()
LOCAL cCodi 		  := Space(04)
LOCAL cCodiVen 	  := Space(04)
LOCAL cNomeVen 	  := ''
LOCAL lTotal		  := FALSO
LOCAL nChoice		  := 0
LOCAL aTodos		  := {}
LOCAL lIncluir 	  := OK
LOCAL lRolCob		  := oSci:ReadBool('permissao','imprimirrolcobranca', FALSO )
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

MaBox( 13 , 18 , 15 , 77 )
@ 14, 19 Say "Cobrador:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1, @cNomeVen )
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
Recemov->(Order( RECEMOV_CODI ))
WHILE OK
	cCodi := Space(05)
	MaBox(16, 18, 18, 77 )
	@ 17, 19 Say  "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	lIncluir := OK
	IF Ascan( aCodi, cCodi ) != 0
		ErrorBeep()
		Alerta("Erro: Cliente Jah Selecionado.")
		Loop
	EndIF
	IF Recemov->(DbSeek( cCodi ))
		WHILE Recemov->Codi = cCodi
			IF Recemov->Cobrador != Space(04) .AND. Recemov->Cobrador != cCodiven
				ErrorBeep()
				IF !Conf('Pergunta: Cobranca pertence a outro cobrador. Trocar ?')
					lIncluir := FALSO
				EndIF
				Exit
			EndIF
			Recemov->(DbSkip(1))
		EndDO
	Else
		ErrorBeep()
		Alerta("Erro: Cliente sem debito.")
		Loop
	EndIF
	IF Ascan( aCodi, cCodi ) = 0
		IF lIncluir
			ErrorBeep()
			IF Conf("Incluir " + Receber->(AllTrim( Nome )) + " ?")
				Aadd( aCodi, cCodi )
				Aadd( aTodos, { cCodi, Receber->Nome, Receber->Ende, Receber->Bair, Receber->Cida })
			EndIF
		EndIF
	Else
		ErrorBeep()
		Alerta("Erro: Cliente Jah Selecionado.")
	EndIF
EndDo
IF ( nTam := Len( aCodi )) = 0
	ResTela( cScreen )
	Return
EndIF
cTitulo := 'RELACAO DE COBRANCA DO COBRADOR: '
cTitulo += AllTrim( cNomeVen )
cTitulo += ' NO PERIODO DE '
MaBox( 19 , 18 , 23, 67 )
@ 20 , 19 Say	"Vcto Inicial.:" Get dIni        Pict "##/##/##"
@ 20 , 43 Say	"Vcto Final...:" Get dFim        Pict "##/##/##" Valid IF( dIni > dFim, ( ErrorBeep(), Alerta("Erro: Data final menor que inicial"), FALSO ), OK )
@ 21 , 19 Say	"Prox Cob Ini.:" Get dProxCob    Pict "##/##/##"
@ 21 , 43 Say	"Prox Cob Fim.:" Get dProxCobFim Pict "##/##/##" Valid IF( dProxCob > dProxCobFim, ( ErrorBeep(), Alerta("Erro: Data final menor que inicial"), FALSO ), OK )
@ 22 , 19 Say	"Data Calculo.:" Get dAtual      Pict "##/##/##"
Read
IF LastKey() = ESC
	ErrorBeep()
	IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
M_Title("TIPO")
nChoice := FazMenu( 07, 55,  aTipo )
IF nChoice = 0
	ErrorBeep()
	IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
ErrorBeep()
oMenu:Limpa()
Mensagem('Aguarde, Autenticando Permissao do Usuario.')
IF !lRolCob
	IF !lUsuarioAdmin
		IF !PedePermissao( SCI_IMPRIMIRROLCOBRANCA )
			ResTela( cScreen )
			Return
		EndIF
	EndIF
EndIF
ErrorBeep()
oMenu:Limpa()
ErrorBeep()
IF Conf('Pergunta: Anexar os antigos tambem ?')
	Mensagem('Aguarde, Localizando registros.')
	ErrorBeep()
	Recemov->(Order( RECEMOV_CODI ))
	Receber->(Order( RECEBER_CODI ))
	Receber->(DbGoTop())
	While Receber->(!Eof()) .AND. Rel_Ok()
		IF Receber->ProxCob < dProxCob .OR. Receber->ProxCob > dProxCobFim .OR. Receber->ProxCob = Ctod('//')
			Receber->(DbSkip(1))
			Loop
		EndIF
		cCodi 	:= Receber->Codi
		lIncluir := FALSO
		IF Recemov->(DbSeek( cCodi ))
			WHILE Recemov->Codi = cCodi
				IF Recemov->Cobrador = cCodiven
					lIncluir := OK
					Exit
				EndIF
				Recemov->(DbSkip(1))
			EndDO
		EndIF
		IF lIncluir
			IF Ascan( aCodi, cCodi ) = 0
				Aadd( aCodi, cCodi )
				Aadd( aTodos, { cCodi, Receber->Nome, Receber->Ende, Receber->Bair, Receber->Cida })
			EndIF
		EndIF
		Receber->(DbSkip(1))
	EndDo
EndIF
lTotal := nChoice = 2
WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
	nOpcao := FazMenu( 05, 10, aOrdem )
	Mensagem("Aguarde, Ordenando.", Cor())
	IF nOpcao = 0 // Sair ?
		Exit
	ElseIf nOpcao = 1
		Asort( aTodos,,, {| x, y | y[1] > x[1] } )
	ElseIf nOpcao = 2
		Asort( aTodos,,, {| x, y | y[2] > x[2] } )
	ElseIf nOpcao = 3
		Asort( aTodos,,, {| x, y | y[3] > x[3] } )
	ElseIf nOpcao = 4
		Asort( aTodos,,, {| x, y | y[4] > x[4] } )
	ElseIf nOpcao = 5
		Asort( aTodos,,, {| x, y | y[5] > x[5] } )
	EndIF
	nTam	 := Len( aCodi )
	aCodi  := {}
	For nX := 1 To nTam
		Aadd( aCodi, aTodos[nX,1] )
	Next
	ErrorBeep()
	IF !InsTru80() .OR. !LptOk()
		ResTela( cScreen )
		Return
	EndIF
	cTitulo += Dtoc( dIni ) + " A " + Dtoc( dFim )
	Prn002Cob( cTitulo, dIni, dFim, dAtual, aCodi, cCodiVen, lTotal, NIL, NIL, dProxCob, dProxCobFim )
EndDo
ResTela( cScreen )
Return

Proc RelRecTotalizado()
***********************
LOCAL cScreen	  := SaveScreen()
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL nTotalVlr  := 0
LOCAL nTotalJur  := 0
LOCAL nTotalGer  := 0
LOCAL nTotalMul  := 0
LOCAL nTotalDes  := 0
LOCAL nAtraso	  := 0
LOCAL nDesconto  := 0
LOCAL nMulta	  := 0
LOCAL nJuros	  := 0
LOCAL nCarencia  := 0
LOCAL nDocumento := 0
LOCAL nChoice	  := 1
LOCAL dAtual	  := Date()
LOCAL cTitulo	  := "ROL GERAL DE TITULOS A RECEBER - TOTALIZADO"
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL aMenu 	  := {"Por Vcto", "Por Emissao", "Geral"}
LOCAL cTela
LOCAL oBloco1
LOCAL oBloco2

M_Title( "TOTALIZADO")
nChoice := FazMenu( 04 , 20, aMenu, Cor() )
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Vcto Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Vcto Final....:" Get dFim    Pict "##/##/##"
	oBloco1 := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
Case nChoice = 2
	MaBox( 13 , 18 , 16, 50 )
	@ 14, 19 Say  "Data Emis Inicial..:" Get dIni    Pict "##/##/##"
	@ 15, 19 Say  "Data Emis Final....:" Get dFim    Pict "##/##/##"
	oBloco2 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
EndCase
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF Recemov->(Lastrec()) = 0
	Return
EndIF
IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
cTela := Mensagem("Informe: Aguarde, imprimindo.", Cor())
PrintOn()
FPrint( PQ )
SetPrc( 0 , 0 )
Area("ReceMov")
Recemov->(DbGoTop())
WHILE Recemov->(!Eof()) .AND. Rel_Ok()
	IF nChoice = 1
		IF !Eval( oBloco1 )
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	IF nChoice = 2
		IF !Eval( oBloco2 )
			Recemov->(DbSkip(1))
			Loop
		EndIF
	EndIF
	nAtraso	 := Atraso( dAtual, Vcto )
	nCarencia := Carencia( dAtual, Vcto )
	nMulta	 := VlrMulta( dAtual, Vcto, Vlr )
	nDesconto := VlrDesconto( dAtual, Vcto, Vlr )
	IF nAtraso <= 0
		nJuros := 0
	Else
		nJuros  := Jurodia * nCarencia
	EndIF
	IF Col >= 57
		Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
		Qout( Dtoc( Date() ))
      Qout( Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		Qout( Padc( SISTEM_NA3, Tam ))
		Qout( Padc( cTitulo , Tam ))
		Qout( Repl( "=", Tam ) )
		Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS      TOTAL MULTA   TOTAL DESCONTO      TOTAL GERAL")
		Qout( Repl( "=", Tam ) )
		Col := 9
	EndIF
	nDocumento ++
	nTotalVlr  += Vlr
	nTotalJur  += nJuros
	nTotalGer  += (( Vlr + nJuros ) + nMulta ) - nDesconto
	nTotalMul  += nMulta
	nTotalDes  += nDesconto
	Recemov->(DbSkip(1))
EndDo
Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nTotalVlr, "@E 9,999,999,999.99" ),;
								  Tran( nTotalJur, "@E 9,999,999,999.99" ),;
								  Tran( nTotalMul, "@E 9,999,999,999.99" ),;
								  Tran( nTotalDes, "@E 9,999,999,999.99" ),;
								  Tran( nTotalGer, "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc HelpReceber( cProc, nLine, cVar, nChoice )
***********************************************
LOCAL nKey := SetKey( F2 )
Set Key F2 To
PosiReceber( 1, NIL, cCaixa )
Set Key F2 To HelpReceber( 1 )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc HelpPago( cProc, nLine, cVar, nChoice )
********************************************
LOCAL nKey := SetKey( F3 )
Set Key F3 To
RecePago( 1 )
Set Key F3 To HelpPago()
Return

*:---------------------------------------------------------------------------------------------------------------------------------


Proc Prn001( dIni, dFim, cTitulo )
**********************************
LOCAL cScreen		:= SaveScreen()
LOCAL Tam			:= 132
LOCAL Col			:= 58
LOCAL nDocumentos := 0
LOCAL nParDoc		:= 0
LOCAL Pagina		:= 0
LOCAL TotTit		:= 0
LOCAL TotRec		:= 0
LOCAL nParVlr		:= 0
LOCAL nParRec		:= 0
LOCAL nAtraso		:= 0
LOCAL cIni			:= Dtoc( dIni )
LOCAL cFim			:= Dtoc( dFim )
LOCAL Relato		:= "RELATORIO DE TITULOS RECEBIDOS " + AllTrim( cTitulo ) + " REF. " + cIni + " A " + cFim

PrintOn()
FPrint( PQ )
SetPrc( 0 , 0 )
WHILE ( !Eof() .AND. Rep_Ok())
	nAtraso := Atraso( DataPag, Vcto )
	IF Col >= 56
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
      Write( 02, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
		Write( 03, 00, Padc( SISTEM_NA3, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Write( 06, 00, "CODI  NOME CLIENTE    EMISSAO  VENCTO   DOCTO N§  TIPO   VLR TITULO DATA PGT   ATR   VLR PAGO PORTADOR OBSERVACOES")
		Write( 07, 00, Repl( SEP, Tam ) )
		Col := 08
	EndIF
	Qout( Codi, Receber->(Left( Nome, 15 )), Emis, Vcto, Docnr, Tipo,;
			Tran( Vlr, "@E 999,999.99"), DataPag, Tran( nAtraso, "99999"),;
			Tran( VlrPag, "@E 999,999.99"), Left( Port, Len( Port)-2), Left( Obs, 29 ))
	Col			++
	nDocumentos ++
	nParDoc		++
	nParVlr		+= Vlr
	nParRec		+= VlrPag
	TotTit		+= Vlr
	TotRec		+= VlrPag
	DbSkip(1)
	IF Col >= 56
		Qout()
		Qout( " * Parcial *", Tran( nParDoc, "99999"), Space(31), Tran( nParVlr,"@E 9,999,999,999.99" ), Space(08), Tran( nParRec,"@E 9,999,999,999.99" ))
		nParDoc := 0
		nParVlr := 0
		nParRec := 0
		IF !Eof()
			__Eject()
		EndIF
	EndIF
EndDo
Qout()
Qout( " * Parcial *", Tran( nParDoc,     "99999"), Space(31), Tran( nParVlr,"@E 9,999,999,999.99" ), Space(08), Tran( nParRec,"@E 9,999,999,999.99" ))
Qout( " ** Total **", Tran( nDocumentos, "99999"), Space(31), Tran( TotTit, "@E 9,999,999,999.99" ), Space(08), Tran( TotRec, "@E 9,999,999,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCli()
*************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL aTipo 	:= {" Completa ", " Parcial ", " Contrato" }

WHILE OK
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 04, 17, aTipo, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		RelCliCompleta()

	Case nChoice = 2
		RelCliParcial()

	Case nChoice = 3
		ContratoMaxMotors()

	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCliCompleta()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral"}
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado"}
LOCAL xAlias
LOCAL xNtx
LOCAL aStru
LOCAL xDado
LOCAL xOrder

WHILE OK
	xAlias := FTempName("T*.TMP*")
	xNtx	 := FTempName("T*.TMP*")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 06 , 20 ,  AtPrompt, Cor())
	if nChoice = 0		
		ResTela( cScreen )
		Exit
	endif	
	MaBox( 15 , 20 , 17 , 78 )
	Do Case
		Case nChoice = 1
			xDado  := Space(05)
		   xOrder := RECEBER_CODI 
			@ 16 , 21 Say "Cliente.:" Get xDado Pict PIC_RECEBER_CODI Valid RecErrado(@xDado,, Row(), Col()+1 )
		Case nChoice = 2				
			xDado  := Space(02)
		   xOrder := RECEBER_REGIAO 
			@ 16 , 21 Say "Regiao..:" Get xDado Pict "@!"             Valid RegiaoErrada(@xDado )
		Case nChoice = 3	
			xDado  := Space(25)
			xOrder := RECEBER_CIDA
			@ 16 , 21 Say "Cidade..:" Get xDado Pict "@!"
		Case nChoice = 4	
			xDado  := Space(02)
			xOrder := RECEBER_ESTA
			@ 16 , 21 Say "Estado..:" Get xDado Pict "@!"
		Case nChoice = 5
			xOrder := NATURAL
	endCase
	Read
	IF LastKey( ) = ESC
		ResTela( cScreen )
		Loop
	EndIF
	Receber->(Order( xOrder ))
	if nChoice != 5
		if Receber->(!DbSeek( xDado ))
			Alerta("Erro: Parametros informados nao Localizado.")
			ResTela( cScreen )
			Loop
		endif
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next
	else	
		Area("Receber")
		Receber->(DbGoTop())
	endif
	
	WHILE OK
		//oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 18 , 20 , aOrdem )
		IF nChoice != 5
			IF nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			ElseIf nOpcao = 1 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 ElseIf nOpcao = 2 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 3 // Cidade+Nome
				 Mensagem(" Aguarde, Ordenando Por Cidade+Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 4 // Regiao
				 Mensagem(" Aguarde, Ordenando Por Regiao. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 ElseIf nOpcao = 5 // Esta
				 Mensagem(" Aguarde, Ordenando Por Estado. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			EndIF
			xTemp->(DbGoTop())
		Else
			IF nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			EndIF
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		EndIF
		oMenu:Limpa()
		IF !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Imprimindo.", WARNING )
		ListaCli( nOpcao )
		IF nChoice != 5
			xTemp->(DbClearIndex())
		EndIF
	EndDo
EndDo
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ContratoMaxMotors()
************************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL cCodi 	:= Space(04)
LOCAL cRegiao	:= Space(02)
LOCAL cEsta 	:= Space(02)
LOCAL cCida 	:= Space(25)
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral"}
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado"}
LOCAL xAlias
LOCAL xNtx
LOCAL aStru

WHILE OK
	xAlias := FTempName("T*.TMP")
	xNtx	 := FTempName("T*.TMP")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu(06 , 20 ,  AtPrompt)
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Receber")
		cCodi := Space(05)
		MaBox( 19 , 20 , 21 , 78 )
		@ 20 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		IF Receber->(!DbSeek( cCodi ))
			Alerta("Erro: Cliente nao Localizado.")
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next

	Case nChoice = 2
		cRegiao := Space( 02 )
		MaBox( 19 , 20 , 21 , 33 )
		@ 20 , 21 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Receber->(Order( RECEBER_REGIAO ))
		IF Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EnDDo

	Case nChoice = 3
		cCida := Space( 25 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Cidade..:" Get cCida Pict "@!"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Receber->(Order( RECEBER_CIDA ))
		IF Receber->(!DbSeek( cCida ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Cidade.")
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Cida = cCida
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 4
		cEsta := Space( 02 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Estado..:" Get cEsta Pict "@!"
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Receber->(Order( RECEBER_ESTA ))
		IF Receber->(!DbSeek( cEsta ))
			Alerta("Erro: Nenhum Cliente Registrado neste Estado.")
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Esta = cEsta
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 5
		Area("Receber")
		Receber->(DbGoTop())
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		IF nChoice != 5
			IF nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			ElseIf nOpcao = 1 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 ElseIf nOpcao = 2 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 3 // Cidade+Nome
				 Mensagem(" Aguarde, Ordenando Por Cidade+Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 4 // Regiao
				 Mensagem(" Aguarde, Ordenando Por Regiao. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 ElseIf nOpcao = 5 // Esta
				 Mensagem(" Aguarde, Ordenando Por Estado. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			EndIF
			xTemp->(DbGoTop())
		Else
			IF nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			EndIF
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		EndIF
		oMenu:Limpa()
		IF !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Imprimindo.", WARNING )
		ListaContrato( nOpcao )
		IF nChoice != 5
			xTemp->(DbClearIndex())
		EndIF
	EndDo
EndDo
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------
Proc ListaContrato( nOrdem )
****************************
LOCAL cScreen := SaveScreen()
LOCAL lSair   := OK
LOCAL cRegiao := Regiao
LOCAL Tam	  := 80
LOCAL Col	  := 6
LOCAL Pagina  := 0
LOCAL Titulo

Regiao->(Order( REGIAO_REGIAO ))
IF Regiao->(DbSeek( cRegiao))
	cRegiao := Regiao->Nome
EndIF
PrintOn()
SetPrc( 0, 0 )
FPrint( _CPI12 )
WHILE !Eof() .AND. Rel_Ok() .AND. !Eof()
	Write( 10, 00, "")
	Write( Prow()+1, 00, NG + "II - DO COMPRADOR" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Nome Completo")
	Write( Prow()+1, 00, NG + Nome  + NR )
	Write( Prow()+1, 00, "Endereco Comercial")
	Write( Prow(),   48, "Bairro")
	Write( Prow(),   69, "Fone")
	Write( Prow()+1, 00, Ende )
	Write( Prow(),   48, Bair )
	Write( Prow(),   69, Fone )
	Write( Prow()+1, 00, "Cidade")
	Write( Prow(),   48, "Estado")
	Write( Prow()+1, 00, Cep + "/" + Cida )
	Write( Prow(),   48, Esta )
	Write( Prow()+1, 00, "CIC")
	Write( Prow(),   48, "Carteira de Identidade N§")
	Write( Prow()+1, 00, Cpf )
	Write( Prow(),   48, Rg )
	Write( Prow()+1, 00, "CGC/MF")
	Write( Prow(),   48, "Inscricao Estadual")
	Write( Prow()+1, 00, Cgc )
	Write( Prow(),   48, Insc )
	Write( Prow()+1, 00, "Data Nascimento")
	Write( Prow(),   48, "Estado Civil")
	Write( Prow()+1, 00, + Dtoc( Nasc ))
	Write( Prow(),   48, Civil )

	Write( Prow()+1, 00, "Profissao")
	Write( Prow()+1, 00, Profissao )
	Write( Prow()+1, 00, "Endereco Residencial")
	Write( Prow(),   48, "Bairro")
	Write( Prow()+1, 00, Ende1 )
	Write( Prow(),   48, Bair )
	Write( Prow()+1, 00, "Cidade")
	Write( Prow(),   48, "Estado")
	Write( Prow()+1, 00, Cep + "/" + Cida )
	Write( Prow(),   48, Esta )
	Write( Prow()+1, 00, "Telefone Residencial")
	Write( Prow()+1, 00, Fone1 )
	Write( Prow()+2, 00, NG + "III - DA MERCADORIA OBJETO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Fabricante")
	Write( Prow()+1, 00, Fabricante )
	Write( Prow()+1, 00, "Produto")
	Write( Prow()+1, 00, Produto )
	Write( Prow()+1, 00, "Modelo")
	Write( Prow()+1, 00, Modelo )
	Write( Prow()+2, 00, NG + "IV - DO VALOR DA MERCADORIA OBJETO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Valor da Mercadoria nesta Data")
	Write( Prow(),   48, "Local da Venda")
	Write( Prow()+1, 00, Tran( Valor, "@E 999,999,999.99"))
	Write( Prow(),   48, Local )
	Write( Prow()+2, 00, NG + "V - DO PRAZO DE PAGAMENTO" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "N§ de Prestacoes Contratadas")
	Write( Prow()+1, 00, Tran( Prazo, "999"))
	Write( Prow()+2, 00, NG + "VI - DATA DE VENCIMENTO DAS PRESTACOES" + NR)
	Write( Prow()+1, 00, Repl( SEP , Tam ))
	Write( Prow()+1, 00, "Dia do vencimento das prestacoes mensais nos meses seguintes")
	Write( Prow()+1, 00, Tran( DataVcto, "99"))
	DbSkip(1)
	__Eject()
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc ListaCli( nOrdem )
***********************
LOCAL cScreen := SaveScreen()
LOCAL lSair   := OK
LOCAL cRegiao := Regiao
LOCAL Tam	  := CPI1280
LOCAL Col	  := 6
LOCAL Pagina  := 0
LOCAL Titulo

Regiao->(Order( REGIAO_REGIAO ))
IF Regiao->(DbSeek( cRegiao))
	cRegiao := Regiao->Nome
EndIF
IF nOrdem = 2
	Titulo := "LISTAGEM DE CLIENTES DA REGIAO " + AllTrim( cRegiao )
Else
	Titulo := "LISTAGEM DE CLIENTES"
EndIF
PrintOn()
SetPrc( 0 , 0 )
FPrint( _CPI12 )
Pagina++
Write( 00 ,  000, "Pagina N§ "+ StrZero( Pagina , 3 ))
Write( 00 ,  065, "Horas "+ Time( ) )
Write( 01 ,  000,  Dtoc( Date( ) ) )
Write( 02 ,  000,  Padc( AllTrim(oAmbiente:xNomefir), Tam ))
Write( 03 ,  000,  Padc( SISTEM_NA3, Tam))
Write( 04 ,  000,  Padc( Titulo, Tam))
Col := 5
WHILE !Eof() .AND. Rel_Ok() .AND. !Eof()
	IF Col >= 57
		__Eject()
		Pagina++
		Write( 00 ,  000, "Pagina N§ "+ StrZero( Pagina , 3 ))
		Write( 00 ,  065, "Horas "+ Time( ) )
		Write( 01 ,  000,  Dtoc( Date( ) ) )
      Write( 02 ,  000,  Padc( AllTrim(oAmbiente:xNomefir), Tam ))
		Write( 03 ,  000,  Padc( SISTEM_NA3, Tam))
		Write( 04 ,  000,  Padc( Titulo, Tam))
		Col := 5
	EndIF
	Write( Col++, 00, Repl( SEP , Tam ))
	Write( Col,   00, "Codigo.........: " + Codi )
	Write( Col++, 48, "Cadastro.: "       + Dtoc( Data ))
	Write( Col++, 00, "Nome...........: " + Nome )
	Write( Col,   00, "Endereco.......: " + Ende )
	Write( Col++, 48, "E. Civil.: "       + Civil )
	Write( Col,   00, "Cidade.........: " + Cida )
	Write( Col,   48, "Estado...: "       + Esta )
	Write( Col++, 64, "CEP.: "            + Cep )
	Write( Col,   00, "Natural........: " + Natural )
	Write( Col++, 48, "Nascto...: "       + Dtoc( Nasc ))
	Write( Col,   00, "Identidade n§..: " + Rg )
	Write( Col++, 48, "CPF......: "       + Cpf )
	Write( Col,   00, "Insc. Estadual.: " + Insc )
	Write( Col++, 48, "CGC/MF...: "       + Cgc )
	Write( Col,   00, "Telefone.......: " + Fone )
	Write( Col++, 48, "Fax......: "       + Fax )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Esposo(a)......: " + Esposa )
	Write( Col++, 58, "Dependentes..: "   + StrZero( Depe, 2))
	Write( Col++, 00, "Pai............: " + Pai )
	Write( Col++, 00, "Mae............: " + Mae )
	Write( Col,   00, "Endereco.......: " + Ende1 )
	Write( Col++, 48, "Fone.: "           + Fone )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Profissao......: " + Profissao )
	Write( Col++, 48, "Cargo.: "          + Cargo )
	Write( Col,   00, "Trabalho Atual.: " + Trabalho  )
	Write( Col++, 48, "Fone..: "          + Fone2 )
	Write( Col,   00, "Tempo Servico..: " + Tempo )
	Write( Col++, 48, "Renda Mensal...: " + Tran( Media , "@E 99,999,999.99" ))
	Write( Col,   00, "Autoriza Compra: " + IF( Autorizaca, "SIM", "NAO"))
	Write( Col++, 48, "Assinou Autoriz: " + IF( AssAutoriz, "SIM", "NAO"))
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col,   00, "Referencia.....: " + RefBco )
	Write( Col++, 65, "Spc...: " + IF( Spc, "SIM", "NAO" ))
	Write( Col++, 00, "Referencia.....: " + RefCom)
	Write( Col++, 00, "Bens Imoveis...: " + Imovel )
	Write( Col++, 00, "Veiculos.......: " + Veiculo )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col++, 00, "Avalista.......: " + Conhecida )
	Write( Col++, 00, "Endereco.......: " + Ende3 )
	Write( Col,   00, "Cidade.........: " + CidaAval )
	Write( Col++, 48, "Estado...: " + EstaAval )
	Write( Col,   00, "Endereco.......: " + Ende3 )
	Write( Col++, 48, "Bairro...: " + BairAval )
	Write( Col,   00, "Telefone.......: " + FoneAval )
	Write( Col++, 48, "Fax......: " + FaxAval )
	Write( Col,   00, "Rg n§..........: " + RgAval )
	Write( Col++, 48, "Cpf......: " + CpfAval )
	Write( Col++, 00, "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ")
	Write( Col++, 00, "Observacoes....: " + Obs )
	Write( Col++, 00, "                 " + Obs1  )
	Write( Col++, 00, "                 " + Obs2  )
	Write( Col++, 00, "                 " + Obs3  )
	Write( Col++, 00, "                 " + Obs4  )
	Write( Col++, 00, "                 " + Obs5  )
	Write( Col++, 00, "                 " + Obs6  )
	Write( Col++, 00, "                 " + Obs7  )
	Write( Col++, 00, "                 " + Obs8  )
	Write( Col++, 00, "                 " + Obs9  )
	Write( Col++, 00, "                 " + Obs10 )
	Col += 1

	Write( Col+01, 00, "________________________________________  _______________________________________")
	Write( Col+02, 00, "AUTORIZO COMPRAR EM MINHA FICHA")

	Write( Col+05, 00, "________________________________________  _______________________________________")
	Write( Col+06, 00,  Nome )
	Write( Col+06, 42,  Conhecida )

	Write( Col+09, 00, "________________________________________  _______________________________________")
	Write( Col+10, 00, Esposa )
   Write( Col+10, 42, AllTrim(oAmbiente:xNomefir) )
	Col := 58
	DbSkip(1)
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelCliParcial()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL nChoice	:= 0
LOCAL nOpcao	:= 0
LOCAL cCodi 	:= Space(05)
LOCAL cCodiFim := Space(05)
LOCAL cRegiao	:= Space(02)
LOCAL cEsta 	:= Space(02)
LOCAL cCida 	:= Space(25)
LOCAL nOrder	:= 1
LOCAL nField	:= 0
LOCAL nDias 	:= 0
LOCAL dIni		:= Date()-30
LOCAL dFim		:= Date()
LOCAL AtPrompt := { "Individual ", "Por Regiao", "Por Cidade", "Por Estado", "Geral", "Data Abertura", "Quantitativo de Clientes", "Com Debito e Negativado SPC", "Sem Debito e Negativado SPC", "Com Debito e Positivado SPC", "Clientes com Contrato Ativo", "Clientes Com Contrato Vencido", "Clientes com Contrato Cancelado", "Ultima Compra" }
LOCAL aOrdem	:= { "Ordem Nome", "Ordem Codigo", "Ordem Cidade+Nome", "Ordem Regiao", "Ordem Estado", "Ordem Fantasia"}
LOCAL aTipo 	:= { 'Geral', 'Por Regiao'}
LOCAL xAlias
LOCAL xNtx
LOCAL nTipo
LOCAL aStru
LOCAL cRegiaoIni
LOCAL cRegiaoFim

WHILE OK
	xAlias := FTempName("T*.TMP")
	xNtx	 := FTempName("T*.TMP")
	M_Title( "FICHA/RELACAO CLIENTES" )
	nChoice := FazMenu( 06, 20 ,	AtPrompt, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Receber")
		cCodi := Space(05)
		MaBox( 19 , 20 , 21 , 78 )
		@ 20 , 21 Say	"Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		IF Receber->(!DbSeek( cCodi ))
			Alerta("Erro: Cliente nao Localizado.")
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		xTemp->(DbAppend())
		For nField := 1 To FCount()
			xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
		Next

	Case nChoice = 2
		cRegiao := Space( 02 )
		MaBox( 19 , 20 , 21 , 33 )
		@ 20 , 21 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_REGIAO ))
		IF Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 3
		cCida := Space( 25 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Cidade..:" Get cCida Pict "@!"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CIDA ))
		IF Receber->(!DbSeek( cCida ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Cidade.")
			ResTela( cScreen )
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use (xAlias) Exclusive Alias xTemp New
		WHILE Receber->Cida = cCida
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 4
		cEsta := Space( 02 )
		MaBox( 19 , 20 , 21 , 56 )
		@ 20, 21 Say "Estado..:" Get cEsta Pict "@!"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_ESTA ))
		IF Receber->(!DbSeek( cEsta ))
			ResTela( cScreen )
			Alerta("Erro: Nenhum Cliente Registrado neste Estado.")
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Esta = cEsta
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		Enddo

	Case nChoice = 5
		Area("Receber")
		Receber->(DbGoTop())

	Case nChoice = 6
		dIni		  := Date()- 30
		dFim		  := Date()
		cRegiaoIni := Space(02)
		cRegiaoFim := Space(02)
		MaBox( 18 , 20 , 23 , 78 )
		@ 19, 21 Say  "Regiao Inicial...:" Get cRegiaoIni Pict "99" Valid RegiaoErrada( @cRegiaoIni )
		@ 20, 21 Say  "Regiao Final.....:" Get cRegiaoFim Pict "99" Valid RegiaoErrada( @cRegiaoFim )
		@ 21, 21 Say  "Abertura Inicial.:" Get dIni Pict "##/##/##"
		@ 22, 21 Say  "Abertura Final...:" Get dFim Pict "##/##/##" Valid IF( dFim < dIni, ( ErrorBeep(), Alerta("Erro: Data final maior que inicial."), FALSO ), OK )
		Read
		IF LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		lAchou := FALSO
		Receber->(Order( RECEBER_REGIAO ))
		For nX := Val( cRegiaoIni ) To Val( cRegiaoFim )
			IF Receber->(DbSeek( StrZero( nX, 2 )))
				lAchou := OK
				Exit
			EndIF
		Next
		IF !lAchou
			ErrorBeep()
			Nada()
			Loop
		EndIF
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->Regiao >= cRegiaoIni .AND. Receber->Regiao <= cRegiaoFim
			IF Receber->Data >= dIni .AND. Receber->Data <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			EndIF
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 7
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
			Next
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 8 // Com Debitos e Negativado SPC
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			IF Receber->Spc = OK
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			EndIF
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 9 // Sem Debitos e Negativado SPC
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			IF Receber->Spc = OK
				IF Recemov->(!DbSeek( Receber->Codi ))
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
			EndIF
			Receber->(DbSkip(1))
		EndDo

	Case nChoice = 10 // Com Debito e Positivado SPC
		cCodi 	:= Space(05)
		cCodiFim := Space(05)
		MaBox( 19 , 20 , 22 , 78 )
		@ 20 , 21 Say	"Do  Cliente.:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		@ 21 , 21 Say	"Ate Cliente.:" Get cCodiFim Pict PIC_RECEBER_CODI Valid RecErrado( @cCodiFim,, Row(), Col()+1 )
		Read
		IF LastKey( ) = ESC
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru  := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		IF Receber->(DbSeek( cCodi ))
			WHILE Receber->Codi >= cCodi .AND. Receber->Codi <= cCodiFim
				IF Receber->Spc = FALSO
					IF Recemov->(DbSeek( Receber->Codi ))
						xTemp->(DbAppend())
						For nField := 1 To FCount()
							xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
						Next
					EndIF
				EndIF
				Receber->(DbSkip(1))
			EndDo
		EndIF

	Case nChoice = 11
		M_Title( "FICHA/RELACAO CLIENTES-TIPO" )
		nTipo := FazMenu( 08, 22 , aTipo )
		Do Case
		Case nTipo = 0
			ResTela( cScreen )
			Loop
		Case nTipo = 1
			ErrorBeep()
			IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			EndIF
			Receber->(Order( RECEBER_REGIAO ))
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			Receber->(DbGoTop())
			WHILE Receber->(!Eof())
				IF Receber->Suporte = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
				Receber->(DbSkip(1))
			EndDo

		Case nTipo = 2
			cRegiao := Space( 02 )
			MaBox( 21 , 55 , 23 , 80 )
			@ 22 , 56 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada( @cRegiao)
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Loop
			EndIF
			ErrorBeep()
			IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			EndIF
			Receber->(Order( RECEBER_REGIAO ))
			IF Receber->(!DbSeek( cRegiao ))
				Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
				ResTela( cScreen )
				Loop
			EndIF
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			WHILE Receber->Regiao = cRegiao
				IF Receber->Suporte = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
				Receber->(DbSkip(1))
			EndDo

		EndCase
	Case nChoice = 12 // Contrato Suporte Vencido
		ErrorBeep()
		IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
			ResTela( cScreen )
			Loop
		EndIF
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_CODI ))
		Receber->(DbGoTop())
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		Mensagem("Aguarde, Trabalhando Duro.")
		WHILE Receber->(!Eof())
			IF Receber->Suporte = OK
				lIncluir := OK
				IF Recemov->(DbSeek( Receber->Codi ))
					While Recemov->Codi = Receber->Codi
						IF Recemov->Vcto >= Date()
							lIncluir := FALSO
						EndIF
						Recemov->(DbSkip(1))
					EndDo
				EndIF
				IF lIncluir = OK
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
			EndIF
			Receber->(DbSkip(1))
		EndDo
		
	Case nChoice = 13 // Clientes com Contrato Cancelado
		M_Title( "FICHA/RELACAO CLIENTES-TIPO" )
		nTipo := FazMenu( 08, 22 , aTipo )
		Do Case
		Case nTipo = 0
			ResTela( cScreen )
			Loop
		Case nTipo = 1
			ErrorBeep()
			IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			EndIF
			Receber->(Order( RECEBER_REGIAO ))
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			Receber->(DbGoTop())
			WHILE Receber->(!Eof())
				IF Receber->Suporte = FALSO
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
				Receber->(DbSkip(1))
			EndDo

		Case nTipo = 2
			cRegiao := Space( 02 )
			MaBox( 21 , 55 , 23 , 80 )
			@ 22 , 56 Say "Regiao..:" Get cRegiao Pict "@!" Valid RegiaoErrada(@cRegiao)
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Loop
			EndIF
			ErrorBeep()
			IF !Conf("Informa: Relatorio podera demorar. Continuar ?")
				ResTela( cScreen )
				Loop
			EndIF
			Receber->(Order( RECEBER_REGIAO ))
			IF Receber->(!DbSeek( cRegiao ))
				Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
				ResTela( cScreen )
				Loop
			EndIF
			aStru := Receber->(DbStruct())
			DbCreate( xAlias, aStru )
			Use ( xAlias ) Exclusive Alias xTemp New
			WHILE Receber->Regiao = cRegiao
				IF Receber->Suporte = FALSO
					xTemp->(DbAppend())
					For nField := 1 To FCount()
						xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
					Next
				EndIF
				Receber->(DbSkip(1))
			EndDo
		EndCase	
		
	Case nChoice = 14 // Ultima Compra
		oMenu:Limpa()
		Area("Receber")
		nDias 	:= 0
		cDebitos := Space(1)
		cRegiao	:= Space( 02 )
		MaBox( 10, 10, 14, 45 )
		@ 11, 11 Say "Regiao...................:" Get cRegiao  Pict "@!" Valid RegiaoErrada( @cRegiao )
		@ 12, 11 Say "Dias da Ultima Compra....:" Get nDias    Pict "999"
		@ 13, 11 Say "Imprimir se tem Debito...:" Get cDebitos Pict "!" Valid cDebitos $ "SN"
		Read
		IF LastKey() = ESC .OR. !Conf("Pergunta: Confirma Procura ?")
			ResTela( cScreen )
			Loop
		EndIF
		Receber->(Order( RECEBER_REGIAO ))
		IF Receber->(!DbSeek( cRegiao ))
			Alerta("Erro: Nenhum Cliente Registrado nesta Regiao.")
			ResTela( cScreen )
			Loop
		EndIF
		ErrorBeep()
		lCancelado := Conf('Pergunta: Incluir Cancelados?')
		IF !lCancelado
			IF Receber->Cancelada
				Saidas->(DbSkip(1))
				Loop
			EndIF
		EndIF
		oMenu:Limpa()
		Mensagem("Aguarde, Varrendo Arquivo." )
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_REGIAO ))
		Receber->(DbSeek( cRegiao ))
		aStru := Receber->(DbStruct())
		DbCreate( xAlias, aStru )
		Use ( xAlias ) Exclusive Alias xTemp New
		WHILE Receber->Regiao = cRegiao
			IF !lCancelado
				IF Receber->Cancelada
					Receber->(DbSkip(1))
					Loop
				EndIF
			EndIF
			cCodi := Receber->Codi
			IF ( Date() - Receber->UltCompra ) >= nDias
				IF cDebitos = "N"
					IF Recemov->(DbSeek( cCodi ))
						Receber->(DbSkip(1))
						Loop
					EndIF
				EndIF
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->(FieldPut( nField, Receber->(FieldGet( nField ))))
				Next
			EndIF
			Receber->(DbSkip(1))
		EndDo
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		IF nChoice != 5
			IF nOpcao = 0 // Sair ?
				xTemp->(DbCloseArea())
				Ferase( xAlias )
				Ferase( xNtx )
				ResTela( cScreen )
				Exit
			ElseIf nOpcao = 1 // Por Nome
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 2 // Por Codi
				 Mensagem(" Aguarde, Ordenando Por Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Codi To ( xNtx )
			 ElseIf nOpcao = 3 // Cidade+Nome
				 Mensagem(" Aguarde, Ordenando Por Cidade+Nome. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Cida + xTemp->Nome To ( xNtx )
			 ElseIf nOpcao = 4 // Regiao
				 Mensagem(" Aguarde, Ordenando Por Regiao. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Regiao To ( xNtx )
			 ElseIf nOpcao = 5 // Esta
				 Mensagem(" Aguarde, Ordenando Por Estado. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Esta To ( xNtx )
			 ElseIf nOpcao = 6 // Fantasia
				 Mensagem(" Aguarde, Ordenando Por Fantasia. ", WARNING )
				 Area("xTemp")
				 Inde On xTemp->Fanta To ( xNtx )
			EndIF
			xTemp->(DbGoTop())
		Else
			IF nOpcao = 0 // Sair ?
				ResTela( cScreen )
				Exit
			EndIF
			Area("Receber")
			Receber->(Order( nOpcao ))
			Receber->(DbGoTop())
		EndIF
		oMenu:Limpa()
		IF !Instru80() .OR. !LptOk()
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Imprimindo.", WARNING )
		Prn009( nOpcao, nChoice, atPrompt )
		IF nChoice != 5
			xTemp->(DbClearIndex())
		EndIF
	EndDo
EndDo
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc Prn009( nOpcao, nChoice, atPrompt )
****************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL cNome 	  := Space(0)
LOCAL cRegiao	  := Regiao
LOCAL nTotal	  := 0
LOCAL nCancel	  := 0
LOCAL nTotRegiao := 0
LOCAL nCanRegiao := 0
LOCAL cTitulo
LOCAL cUltRegiao
FIELD Codi
FIELD Nome
FIELD Ende
FIELD Cida
FIELD Esta
FIELD Fone
FIELD Regiao

ErrorBeep()
Regiao->(Order( REGIAO_REGIAO ))
IF Regiao->(DbSeek( cRegiao))
	cNome := Regiao->Nome
EndIF
Do Case
Case nChoice = 1
	cTitulo := "RELACAO INDIVIDUAL DE CLIENTES"
Case nChoice = 2
	cTitulo := "RELACAO DE CLIENTES DA REGIAO " + AllTrim( cNome )
Case nChoice = 3
	cTitulo := "RELACAO DE CLIENTES DA CIDADE DE " + Rtrim( Cida ) + "-" + Esta
Case nChoice = 4
	cTitulo := "RELACAO DE CLIENTES DO ESTADO DE " + esta
Case nChoice = 5
	cTitulo := "RELACAO GERAL DE CLIENTES"
Case nChoice = 6
	cTitulo := "RELACAO DE CLIENTES - DATA DE ABERTURA"
Case nChoice = 8
	cTitulo := "RELACAO GERAL DE CLIENTES COM DEBITO E NEGATIVADOS SPC"
Case nChoice = 9
	cTitulo := "RELACAO GERAL DE CLIENTES SEM DEBITO E NEGATIVADOS SPC"
Case nChoice = 10
	cTitulo := "RELACAO GERAL DE CLIENTES COM DEBITO E POSITIVADO SPC"
Case nChoice = 11
	cTitulo := "RELACAO DE " + Upper(atPrompt[nChoice])
Case nChoice = 13 // Clientes com Contrato Cancelado
	cTitulo := "RELACAO DE " + Upper(atPrompt[nChoice])
EndCase
PrintOn()
Fprint( PQ )
SetPrc( 0 , 0 )
cUltRegiao := Regiao
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 57
		Pagina++
		Col := 0
		Write( Col ,  000, "Pagina N§ " + StrZero( Pagina , 3 ))
		Write( Col ,  113, Dtoc( Date() ) + " - " + Time())                         
      #IFDEF GRUPO_MICROBRAS
			Write( ++Col,  000, Repl( '=', Tam ))
		#ELSE
			Write( ++Col,  000, Padc( AllTrim(oAmbiente:RelatorioCabec), Tam))
			Write( ++Col,  000, Padc( SISTEM_NA3, Tam))
		#ENDIF
		Write( ++Col,  000, Padc( cTitulo, Tam))
		Write( ++Col,  000, Repl( '=', Tam ))		
		#IFDEF GRUPO_MICROBRAS
			Write( ++Col,  000, "CODI  NOME                                     ENDERECO                       TORRE      CIDADE                    UF       TELEFONE")
		#ELSE
			Write( ++Col,  000, "CODI  NOME                                     ENDERECO                       BAIRRO   CIDADE                    UF       TELEFONE S")
		#ENDIF
		Write( ++Col,  000, Repl( SEP, Tam ))
	EndIF
	#IFDEF GRUPO_MICROBRAS
		Qout( Codi, Nome, Ende, Left( Fanta, 10), Cida, Esta, Fone )
	#ELSE
		Qout( Codi, Nome, Ende, Left( Bair,  8), Cida, Esta, Fone, IF( Cancelada, "C", "A"))
	#ENDIF				
	Col		  ++
	nTotal	  ++
	nTotRegiao ++
	IF Cancelada
		nCancel	  ++
		nCanRegiao ++
	EndIF
	DbSkip( 1 )
	IF nOpcao = 4 // Regiao
		IF cUltRegiao != Regiao
			Qout( Repl( SEP, Tam ))
			Qout(  Space(00), "** TOTAL REGIAO " + cUltRegiao + ' : ' + Tran( nTotRegiao,       "99999"))
			QQout( Space(06), "** ATIVAS :" + Tran( nTotRegiao-nCanRegiao, "99999"))
			QQout( Space(06), "** CANCELADAS :" + Tran( nCanRegiao,  "99999"))
			QQout( Space(07), "** STATUS : A=ATIVA|C=CANCELADA")
			Qout( Repl( SEP, Tam ))
			Qout()
			Col		  += 4
			nTotRegiao := 0
			nCanRegiao := 0
		EndIF
	EndIF
	cUltRegiao := Regiao
	IF Col >= 55 .OR. Eof()		
		Qout( Repl( SEP, Tam ))
		if !Eof()		
			Qout(  Space(00), "** SUB-TOTAL :" + Tran( nTotal,          "99999"))
		else	
			Qout(  Space(00), "** TOTAL     :" + Tran( nTotal,          "99999"))
		endif	
		#IFDEF GRUPO_MICROBRAS	
			Col += 2
		#ELSE
			QQout( Space(06), "** ATIVAS :" + Tran( nTotal-nCancel, "99999"))
			QQout( Space(06), "** CANCELADAS :" + Tran( nCancel,    "99999"))
			QQout( Space(07), "** STATUS : A=ATIVA|C=CANCELADA")
			Col += 3
		#ENDIF
		Qout( Repl( SEP, Tam ))		
	  __Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegCfop()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL aNatu   := {}
LOCAL aCfop   := {}
LOCAL aTxIcms := {}
LOCAL cCFop   := Space(05)
LOCAL nIcms   := 0
LOCAL cNatu   := ''
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	aNatu   := LerNatu()
	aCFop   := LerCfop()
	aTxIcms := LerIcms()
	cRegiao := Space(2)
	cCFop   := Space(05)
	MaBox( 13, 10, 16, 27 )
	@ 14, 11 Say "Regiao..:" Get cRegiao Pict "99"    Valid RegiaoErrada( @cRegiao )
	@ 15, 11 Say "Cfop....:" Get cCFop   Pict "9.999" Valid PickTam2( @aNatu, @aCfop, @aTxIcms, @cCfop, @cNatu, @nIcms )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Continuar com a alteracao ?")
		Receber->(Order( RECEBER_REGIAO ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		IF Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		EndIF
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			IF Receber->(TravaReg())
				Receber->Cfop	  := cCfop
				Receber->Tx_Icms := nIcms
				Receber->(LIbera())
			EndIF
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	EndIF
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegTitRec()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 10, 15, 24 )
	cRegiao := Space(2)
	@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Continuar com a alteracao ?")
		Recemov->(Order( RECEMOV_CODI ))
		Receber->(Order( RECEBER_REGIAO ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		IF Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		EndIF
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			cCodi   := Receber->Codi
			IF Recemov->(DbSeek( cCodi ))
				WHILE Recemov->Codi = cCodi
					IF Recemov->(TravaReg())
						Recemov->Regiao := cRegiao
						Recemov->(LIbera())
						Recemov->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	EndIF
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltRegTitPag()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao := Space(02)
LOCAL oBloco
LOCAL cTela

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 10, 15, 24 )
	cRegiao := Space(2)
	@ 14 , 11 Say "Regiao..:" GET cRegiao PICT "99" Valid RegiaoErrada( @cRegiao )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Continuar com a alteracao ?")
		Receber->(Order( RECEBER_REGIAO ))
		Recebido->(Order( RECEBIDO_CODI ))
		oBloco  := {|| Receber->Regiao = cRegiao }
		IF Receber->(!DbSeek( cRegiao ))
			ErrorBeep()
			Alerta("Erro: Nenhum cliente atende a condicao.")
			Loop
		EndIF
		cTela := Mensagem("Aguarde, Atualizando Registros")
		WHILE Eval( oBloco )
			cCodi   := Receber->Codi
			IF Recebido->(DbSeek( cCodi ))
				WHILE Recebido->Codi = cCodi
					IF Recebido->(TravaReg())
						Recebido->Regiao := cRegiao
						Recebido->(LIbera())
						Recebido->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			Receber->(DbSkip(1))
		EndDo
		ResTela( cTela )
	EndIF
EndDo

Proc ReajTitulos()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Individual','Por Fatura'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("REAJUSTE DE TITULOS" )
	nChoice := FazMenu( 10, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		ReajTitInd()

	Case nChoice = 2
		ReajTitFat()

	EndCase
EndDo

Proc ReajTitFat()
*****************
LOCAL cScreen	:= SaveScreen()
LOCAL cFatuIni := Space(07)
LOCAL cFatuFim := Space(07)
LOCAL xCodigo	:= 0
LOCAL nChoice	:= 0
LOCAL nPorc 	:= 0
LOCAL lAchou	:= FALSO
LOCAL oBloco
LOCAL cFatura

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 15, 79 )
	cFatuIni := Space(07)
	cFatuFim := Space(07)
	xCodigo	:= 0
	nChoice	:= 0
	nPorc 	:= 0
	@ 11, 11 Say "Fatura Inicial.:" Get cFatuIni Pict "@!"       Valid VisualAchaFatura( @cFatuIni )
	@ 12, 11 Say "Fatura Final...:" Get cFatuFim Pict "@!"       Valid VisualAchaFatura( @cFatuFim )
	@ 13, 11 Say "Produto........:" Get xCodigo  Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo,,, Row(), Col()+1)
	@ 14, 11 Say "Percentual.....:" GET nPorc    PICT "999.9999" Valid nPorc <> 0
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	oBloco := {|| Recemov->Fatura >= cFatuIni .AND. Recemov->Fatura <= cFatuFim }
	Saidas->(Order( SAIDAS_FATURA ))
	Area("Recemov")
	Recemov->(Order( RECEMOV_FATURA ))
	ErrorBeep()
	IF Conf("Pergunta: Deseja Continuar ?")
		lRedondo := FALSO
		Set( SOFT, 'on')
		Recemov->(DbSeek( cFatuIni ))
		Set( SOFT, 'off')
		While Recemov->(Eval( oBloco ))
			cFatura := Recemov->Fatura
			lAchou := FALSO
			IF Saidas->(DbSeek( cFatura ))
				While Saidas->Fatura = cFatura
					IF Saidas->Codigo = xCodigo
						lAchou				:= OK
						Exit
					EndIF
					Saidas->(DbSkip(1))
				EndDo
			EndIF
			IF lAchou
				IF Saidas->(DbSeek( cFatura ))
					While Saidas->Fatura = cFatura
						IF Saidas->(TravaReg())
							nReajuste			:= ( Saidas->VlrFatura * nPorc ) / 100
							Saidas->VlrFatura += nReajuste
							nReajuste			:= ( Saidas->Pvendido  * nPorc ) / 100
							Saidas->Pvendido	+= nReajuste
							Saidas->(Libera())
							Saidas->(DbSkip(1))
						EndIF
					EndDo
				EndIF
				While Recemov->Fatura = cFatura
					nReajuste := ( Recemov->Vlr * nPorc ) / 100
					IF Recemov->(TravaReg())
						IF lRedondo
							Recemov->Vlr := Round( Recemov->Vlr + nReajuste, 2 )
						Else
							Recemov->Vlr += nReajuste
						EndIF
						Recemov->(Libera())
					EndIF
					Recemov->(DbSkip(1))
				Enddo
				Recemov->(DbSkip(1))
			Else
				Recemov->(DbSkip(1))
			EndIF
		Enddo
	EndIF
EndDo

Proc ReajTitInd()
*****************
LOCAL cScreen := SaveScreen()
LOCAL cCodi   := Space(05)
LOCAL nChoice := 0
LOCAL nPorc   := 0

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 13, 79 )
	cCodi := Space( 05 )
	@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI  Valid RecErrado( @cCodi, NIL, Row(), Col()+1 )
	@ 12, 11 Say "Percentual.:" GET nPorc PICT "999.9999"        Valid nPorc <> 0
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Area("Recemov")
	Recemov->(Order( RECEMOV_CODI ))
	IF Recemov->(DbSeek( cCodi ))
		ErrorBeep()
		IF Conf("Pergunta: Deseja Continuar ?")
			lRedondo := Conf("Pergunta: Arredondar Centavos ")
			While Recemov->Codi = cCodi
				nReajuste := ( Recemov->Vlr * nPorc ) / 100
				IF Recemov->(TravaReg())
					IF lRedondo
						Recemov->Vlr := Round( Recemov->Vlr + nReajuste, 2 )
					Else
						Recemov->Vlr += nReajuste
					EndIF
					Recemov->(Libera())
				EndIF
				Recemov->(DbSkip(1))
			Enddo
		EndIF
	Else
		ErrorBeep()
		Alerta("Erro: Cliente Sem Movimento.")
		Loop
	EndIF
EndDo

Proc RelRecSeletiva()
*********************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aTipo 	 := {"Normal", "Total"}
LOCAL aReg		 := {}
LOCAL aCodi 	 := {}
LOCAL xReg		 := {}
LOCAL dAtual	 := Date()
LOCAL cCodi 	 := Space(04)
LOCAL cCodiVen  := Space(04)
LOCAL cNomeVen  := ''
LOCAL nChoice	 := 0
LOCAL nTam		 := 0
LOCAL nX 		 := 0
LOCAL lTotal	 := FALSO
LOCAL lSeletiva := OK
LOCAL cTitulo	 := ""
LOCAL lSemLoop  := OK

WHILE OK
	cCodi := Space(05)
	MaBox( 13 , 18 , 15 , 77 )
	@ 14, 19 Say  "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		IF Len( aCodi ) = 0
			ResTela( cScreen )
			Return
		EndIF
		ErrorBeep()
		IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
			ResTela( cScreen )
			Return
		EndIF
		Exit
	EndIF
	Keyb Chr( ENTER )
	xReg := {}
	xReg := EscolheTitulo( cCodi, lSemLoop )
	IF Len( xReg ) <> 0
		IF Ascan( aCodi, cCodi ) = 0
			Aadd( aCodi, cCodi )
		EndIF
		For nX := 1 To Len( xReg )
			Aadd( aReg, xReg[nX])
		Next
	EndIF
EndDo
nTam := Len( aCodi )
IF nTam = 0
	ResTela( cScreen )
	Return
EndIF
MaBox(16, 18, 18, 77 )
cCodiVen := Space( 04 )
@ 17 , 19 Say	"Cobrador:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1, @cNomeVen )
Read
IF LastKey() = ESC
	ErrorBeep()
	IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
cTitulo := 'RELACAO DE COBRANCA SELETIVA DO COBRADOR: '
cTitulo += AllTrim( cNomeVen )
MaBox( 19 , 18 , 21, 42 )
@ 20 , 19 Say	"Data Calculo.:" Get dAtual  Pict "##/##/##"
Read
IF LastKey() = ESC
	ErrorBeep()
	IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
M_Title("TIPO")
nChoice := FazMenu( 19, 43,  aTipo, Cor() )
IF nChoice = 0
	ErrorBeep()
	IF Conf("Pergunta: Deseja Cancelar a Selecao ?")
		ResTela( cScreen )
		Return
	EndIF
EndIF
lTotal := nChoice = 2
Receber->( Order( RECEBER_CODI ))
ErrorBeep()
IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
Prn002Cob( cTitulo, NIL, NIL, dAtual, aCodi, cCodiVen, lTotal, lSeletiva, aReg )
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CartaSpc()
****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { "Modelo Antigo", "Modelo Novo"}
LOCAL xDbf		  := FTempName("T*.TMP")
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL nChoice	  := 0
LOCAL nTamForm   := 33
LOCAL i			  := 0
LOCAL _QtDup	  := 0
LOCAL aReg
LOCAL aStru
LOCAL cCodi
FIELD Codi
FIELD Vcto

WHILE OK
	M_Title("NEGATIVAR CLIENTES NO SPC")
	nChoice := FazMenu( 03 , 10, aMenuArray )
	Do Case
	Case nChoice  = 0
		ResTela( cScreen )
		Return

	Case nChoice  = 1
		cCodi 	:= Space(05)
		dIni		:= Date()-30
		dFim		:= Date()
		nTamForm := 33
		MaBox( 09 , 10, 14 , 40 )
		@ 10, 11 Say  "Cliente..........:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		@ 11, 11 Say  "Vcto Inicial.....:" Get dIni  Pict "##/##/##"
		@ 12, 11 Say  "Vcto Final.......:" Get dFim  Pict "##/##/##"
		@ 13, 11 Say  "Comp Formulario..:" Get nTamForm Pict "99" Valid nTamForm = 33 .OR. nTamForm = 66
		Read
		IF LastKey() = ESC
			ResTela( cScreen	)
			Loop
		EndIF
		Area("ReceMov")
		Recemov->(Order( RECEMOV_CODI ))
		IF Recemov->(!DbSeek( cCodi ))
			ErrorBeep()
			Nada()
			ResTela( cScreen )
			Loop
		EndIF
		Copy Stru To ( xDbf )
		Use (xDbf) Exclusive Alias xTemp New
		WHILE Recemov->Codi = cCodi
			IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
				Next
			EndIF
			Recemov->(DbSkip(1))
		EndDo
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		CartaSpcOld( nTamForm )
		Mensagem("Aguarde, Excluindo Arquivo Temporario.")
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop

	Case nChoice  = 2
		cCodi 	 := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi )
		IF ( _QtDup := Len( aReg )) = 0
			ResTela( cScreen )
			Loop
		EndIF
		Area("Recemov")
		Recemov->(Order( RECEMOV_CODI ))
		aStru := Recemov->(DbStruct())
		Aadd( aStru, {"QTD",  "N", 3, 0})
		DbCreate( xDbf, aStru )
		Use (xDbf) Exclusive Alias xTemp New
		FOR i :=  1 TO _qtdup
			Recemov->(DbGoto( aReg[i] ))
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recemov->(FieldGet( nField ))))
			Next
			xTemp->Qtd ++
		Next
		nTamForm := 33
		Receber->( Order( RECEBER_CODI ))
		xTemp->(DbGoTop())
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		CartaSpcNew( nTamForm )
		Mensagem("Aguarde, Excluindo Arquivo Temporario.")
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		xTemp->(DbCloseArea())
		Ferase( xDbf )
		ResTela( cScreen )
		Loop
	EndCase
EndDo

Proc CartaSpcOld( nTamForm )
****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL NovoNome  := OK
LOCAL Tam		 := 80
LOCAL cVar1
LOCAL cVar2
LOCAL UltNome
LOCAL Col
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

WHILE OK
	xTemp->(DbGoTop())
	Recemov->(Order( RECEMOV_DOCNR ))
	IF !InsTru80()
		ResTela( cScreen	)
		Return
	EndIF
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
	UltNome	:= Receber->Nome
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
	SetPrc(0,0)
	WHILE !Eof() .AND. Rel_Ok()
		IF Recemov->(DbSeek( xTemp->Docnr ))
			IF Recemov->(TravaReg())
				Recemov->Port := "SPC"
				Recemov->(Libera())
			EndIf
		EndIF
		IF NovoNome
			IF Receber->(TravaReg())
				Receber->Spc	  := OK
				Receber->DataSpc := Date()
				Receber->(Libera())
			EndIF
			IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
				cVar1 := Receber->Cpf
				cVar2 := Receber->Rg
			Else
				cVar1 := Receber->Cgc
				cVar2 := Receber->Insc
			EndIf
			NovoNome := FALSO
			Qout( Repl("=", Tam ))
			Qout( Padc("SPC - SISTEMA DE PROTECAO AO CREDITO",Tam ))
			Qout( Repl("=", Tam ))
			Qout(  "Codigo no SPC..:", "______")
         Qout(  "Empresa........:", AllTrim(oAmbiente:xNomefir) )
			Qout(  "Nome do Cliente:", NG + Receber->Codi, Receber->Nome, NR)
			Qout(  "Data Nascimento:", Receber->Nasc )
			QQout( Space(16), "Est. Civil:", Receber->Civil )
			Qout(  "Cpf/Cgc........:", cVar1 )
			QQout( Space(10), "Insc/Rg...:", cVar2 )
			Qout(  "Conjuge........:", Receber->Esposa )
			Qout(  "Endereco.......:", Receber->Ende )
			Qout(  "Cidade/Uf......:", AllTrim( Receber->Cida ) + " - " + Receber->Esta )
			Qout(  "Profissao......:", Receber->Profissao )
			Qout(  "Firma..........:", Receber->Trabalho )
			Qout(  "Nome Mae.......:", Receber->Mae )
			Qout(  "Nome Pai.......:", Receber->Pai )
			Qout()
			Qout( Padc( Repl("_",22) + "P R O T O C O L O  D E  E N T R E G A" + Repl("_",21),Tam ))
			Qout( "DOCTO N§       EMISSAO   TIPO                    VALOR     DT VCTO    DATA ENVIO")
			Col := 18
		EndIF
		Qout( Docnr, Space(03), Emis, Space(03), Tipo, Space(03), Tran( Vlr,"@E 9,999,999,999.99"), Space(03), Vcto, Space(03), Date())
		Col++
		UltNome := Receber->Nome
		DbSkip(1)
		IF Col >= ( nTamForm - 10 ) .OR. UltNome != Receber->Nome .OR. Eof()
			NovoNome := OK
			Qout( Repl("=", Tam ))
			Qout( Padl("CARIMBO E ASSINATURA DA EMPRESA", Tam ))
			__Eject()
		EndIF
	EndDo
	PrintOff()
	ResTela( cScreen )
EndDO

*:---------------------------------------------------------------------------------------------------------------------------------

Proc CartaSpcNew( nTamForm )
****************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL NovoNome  := OK
LOCAL Tam		 := 80
LOCAL cVar1
LOCAL cVar2
LOCAL UltNome
LOCAL Col
FIELD Codi
FIELD Vcto
FIELD Vlr
FIELD Docnr
FIELD Emis
FIELD Juro
FIELD Cida
FIELD JuroDia

WHILE OK
	xTemp->(DbGoTop())
	Recemov->(Order( RECEMOV_DOCNR ))
	IF !InsTru80()
		ResTela( cScreen	)
		Return
	EndIF
	oMenu:Limpa()
	Mensagem("Aguarde, Imprimindo. ESC Cancela.", Cor())
	UltNome	:= Receber->Nome
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
	SetPrc(0,0)
	WHILE !Eof() .AND. Rel_Ok()
		IF Recemov->(DbSeek( xTemp->Docnr ))
			IF Recemov->(TravaReg())
				Recemov->Port := "SPC"
				Recemov->(Libera())
			EndIf
		EndIF
		IF NovoNome
			IF Receber->(TravaReg())
				Receber->Spc	  := OK
				Receber->DataSpc := Date()
				Receber->(Libera())
			EndIF
			IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
				cVar1 := Receber->Cpf
				cVar2 := Receber->Rg
			Else
				cVar1 := Receber->Cgc
				cVar2 := Receber->Insc
			EndIf
			NovoNome := FALSO
			Qout( Repl("=", Tam ))
			Qout( Padc("SPC - SISTEMA DE PROTECAO AO CREDITO",Tam ))
			Qout( Repl("=", Tam ))
			Qout(  "Codigo no SPC..:", "______")
         Qout(  "Empresa........:", AllTrim(oAmbiente:xNomefir) )
			Qout(  "Nome do Cliente:", NG + Receber->Codi, Receber->Nome, NR)
			Qout(  "Data Nascimento:", Receber->Nasc )
			QQout( Space(16), "Est. Civil:", Receber->Civil )
			Qout(  "Cpf/Cgc........:", cVar1 )
			QQout( Space(10), "Insc/Rg...:", cVar2 )
			Qout(  "Conjuge........:", Receber->Esposa )
			Qout(  "Endereco.......:", Receber->Ende )
			Qout(  "Cidade/Uf......:", AllTrim( Receber->Cida ) + " - " + Receber->Esta )
			Qout(  "Profissao......:", Receber->Profissao )
			Qout(  "Firma..........:", Receber->Trabalho )
			Qout(  "Nome Mae.......:", Receber->Mae )
			Qout(  "Nome Pai.......:", Receber->Pai )
			Qout()
			Qout( Padc( Repl("_",22) + "P R O T O C O L O  D E  E N T R E G A" + Repl("_",21),Tam ))
			Qout( "DATA ENVIO      DOCTO N§    N§ DE PREST SALDO EM ATRASO          DESDE")
			Col := 18
		EndIF
		Qout( Date(), Space(5), Docnr, Space(5), StrZero( Qtd, 3), Space(7), Tran( Vlr,"@E 9,999,999.99"), Space(5), Vcto )
		Col++
		UltNome := Receber->Nome
		DbSkip(1)
		IF Col >= ( nTamForm - 10 ) .OR. UltNome != Receber->Nome .OR. Eof()
			NovoNome := OK
			Qout( Repl("=", Tam ))
			Qout( Padl("CARIMBO E ASSINATURA DA EMPRESA", Tam ))
			__Eject()
		EndIF
	EndDo
	PrintOff()
	ResTela( cScreen )
EndDO

Proc ImpExpDados()
******************
LOCAL cScreen := SaveScreen()
LOCAL aTipo   := {'Exportacao Recebido', 'Importacao Recebido'}

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O TIPO")
	nTipo := FazMenu( 05, 08, aTipo )
	Do Case
	Case nTipo = 0
		ResTela( cScreen )
		Return
	Case nTipo = 1
		ExportaRecebido()
	Case nTipo = 2
		ImportaRecebido()
	EndCase
EndDo

Proc ExportaRecebido()
**********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL dIni	  := Date()-30
LOCAL dFim	  := Date()
LOCAL aStru   := {}
LOCAL nField  := 0
LOCAL oBloco  := {|| !Exportado }
LOCAL bBloco  := {|| Recebido->Baixa >= dIni .AND. Recebido->Baixa <= dFim }
LOCAL cReIni
LOCAL cReFim
LOCAL xBid

oMenu:Limpa()
dIni := Date()-30
dFim := Date()
MaBox( 11, 10, 14, 40 )
@ 12, 11 Say "Data Baixa Inicial." Get dIni Pict "##/##/##"
@ 13, 11 Say "Data Baixa Final..." Get dFim Pict "##/##/##" Valid dFim >= dIni
Read
IF LastKey() = ESC
	Return
EndIF
xBid	:= FTempName('BID?????.REM')
aStru := Recebido->(DbStruct())
DbCreate( xBid, aStru )
Use (xBid) Alias xRecebido Exclusive New
Area('Recebido')
Recebido->(Order( RECEBIDO_BAIXA ))
Recebido->(DbSeek( dIni ))
Mensagem('Aguarde, Exportando Recebido.')
While Recebido->(Eval( bBloco )) .AND. Recebido->(!Eof()) .AND. Rep_Ok()
	IF Eval( oBloco )
		xRecebido->(DbAppend())
		For nField := 1 To FCount()
			xRecebido->( FieldPut( nField, Recebido->(FieldGet( nField ))))
		Next
		IF Recebido->(TravaReg())
			Recebido->Exportado := OK
			Recebido->(Libera())
		EndIF
	EndIF
	Recebido->(DbSkip(1))
EndTry
xRecebido->(DbGoTop())
IF xRecebido->(Eof())
	xRecebido->(DbCloseArea())
	Ferase( xBid )
	Nada()
	ResTela( cScreen )
	Return
EndIF
xRecebido->(DbCloseArea())
ResTela( cScreen )
Return

Proc ImportaRecebido()
**********************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFiles	:= 'BID*.REM'
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL dIni
LOCAL dFim
LOCAL xArquivo
LOCAL xNtx

oMenu:Limpa()
M_Title("ESCOLHA ARQUIVO DE RECEBIDO PARA IMPORTACAO")
xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles )
IF Empty( xArquivo )
	ErrorBeep()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Importando Arquivo Recebido.")
Area("Recebido")
Appe From ( xArquivo )
Use (xArquivo) Alias xRecebido Exclu New
Recemov->(Order( RECEMOV_DOCNR ))
Area('xRecebido')
Mensagem("Aguarde, Indexando Arquivo Importado.")
Inde On xRecebido->DataPag To (xNtx)
xRecebido->(DbGoBottom())
dFim := xRecebido->DataPag
xRecebido->(DbGoTop())
dIni := xRecebido->DataPag
Mensagem("Aguarde, Baixando Registro Importados.")
While xRecebido->(!Eof())
	cDocnr := xRecebido->Docnr
	IF Recemov->(DbSeek( cDocnr ))
		IF Recemov->(Travareg())
			Recemov->(DbDelete())
		EndIF
		Recemov->(Libera())
	EndIF
	xRecebido->(DbSkip(1))
EndDo
xRecebido->(DbCloseArea())
Ferase( xNtx )
xTemp := StrTran( xArquivo, '.REM')
MsRename( xArquivo, xTemp + '.IMP')
RecebidoCx('0000','0001', dIni, dFim )
ResTela(cScreen )
Return

Proc CancelaContrato()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 17, 78 )
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Fatura............:" Get cFatura Pict "@!"             Valid VisualAchaFatura( @cFatura)
	@ 15, 06 Say "Data Cancelamento.:" GET dData   PICT "##/##/##"       Valid !Empty( dData )
	@ 16, 06 Say "Motivo............:" GET cObs    PICT "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_FATURA ))
	If Conf("Pergunta: Confirma Cancelamento ?")
		WHILE Recemov->(DbSeek( cFatura ))
			cCodi := Recemov->Codi
			Receber->(DbSeek( cCodi ))
			IF Recebido->(Incluiu())
				Recebido->Codi 	 := cCodi
				Recebido->Regiao	 := Receber->Regiao
				Recebido->Docnr	 := Recemov->Docnr
				Recebido->Emis 	 := Recemov->Emis
				Recebido->Vcto 	 := Recemov->Vcto
				Recebido->Baixa	 := Date()
				Recebido->Vlr		 := Recemov->Vlr
				Recebido->DataPag  := dData
				Recebido->VlrPag	 := 0
				Recebido->Port 	 := Recemov->Port
				Recebido->Tipo 	 := Recemov->Tipo
				Recebido->Juro 	 := Recemov->Juro
				Recebido->NossoNr  := Recemov->NossoNr
				Recebido->Bordero  := Recemov->Bordero
				Recebido->Fatura	 := Recemov->Fatura
				Recebido->Obs		 := cObs
				Recebido->Parcial  := 'Q'
				Recebido->(Libera())
				Recebido->(Libera())
				IF Recemov->(TravaReg())
					Recemov->(DbDelete())
					Recemov->(Libera())
				EndIF
			EndIF
		EndDo
	EndIf
EndDo

Proc TrocaCliente(cCaixa)
************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Por Fatura','Por Cliente'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("TROCA DE FATURA" )
	nChoice := FazMenu( 03, 20, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		TrCliFatura( cCaixa )

	Case nChoice = 2
		TrCliIndividual( cCaixa )

	EndCase
EndDo

Proc TrCliFatura(cCaixa)
************************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 16, 78 )
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Fatura.......:" Get cFatura Pict "@!"    Valid VisualAchaFatura( @cFatura)
	@ 15, 06 Say "Novo Cliente.:" GET cCodi   Pict "99999" Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	Nota->(Order( NOTA_NUMERO ))
	Vendemov->(Order( VENDEMOV_FATURA ))
	Recibo->(Order( RECIBO_FATURA))
	If Conf("Pergunta: Confirma Alteracao?")
		Mensagem('Informa: Aguarde...')
		IF Recemov->(DbSeek( cFatura ))
			WHILE Recemov->Fatura = cFatura
				IF Recemov->(TravaReg())
					Recemov->Codi = cCodi
					Recemov->(Libera())
					Recemov->(DbSkip(1))
				EndIF
			EndDo
		EndIF
		IF Recebido->(DbSeek( cFatura ))
			WHILE Recebido->Fatura = cFatura
				IF Recebido->(TravaReg())
					Recebido->Codi = cCodi
					Recebido->(Libera())
					Recebido->(DbSkip(1))
				EndIF
			EndDo
		EndIF
		IF Saidas->(DbSeek( cFatura ))
			WHILE Saidas->Fatura = cFatura
				IF Saidas->(TravaReg())
					Saidas->Codi		 = cCodi
					Saidas->Situacao	 = 'ALTERADA'
					Saidas->Atualizado = Date()
					Saidas->Caixa		 = cCaixa
					Saidas->(Libera())
					Saidas->(DbSkip(1))
				EndIF
			EndDo
		EndIF
		IF Nota->(DbSeek( cFatura ))
			WHILE Nota->Numero = cFatura
				IF Nota->(TravaReg())
					Nota->Codi		  = cCodi
					Nota->Situacao   = 'ALTERADA'
					Nota->Atualizado = Date()
					Nota->Caixa 	  = cCaixa
					Nota->(Libera())
					Nota->(DbSkip(1))
				EndIF
			EndDo
		EndIF
		IF Vendemov->(DbSeek( cFatura ))
			WHILE Vendemov->Fatura = cFatura
				IF Vendemov->(TravaReg())
					Vendemov->Codi = cCodi
					Vendemov->(Libera())
					Vendemov->(DbSkip(1))
				EndIF
			EndDo
		EndIF
		IF Recibo->(DbSeek( cFatura ))
			WHILE Recibo->Fatura = cFatura
				IF Recibo->(TravaReg())
					Recibo->Codi = cCodi
					Recibo->(Libera())
					Recibo->(DbSkip(1))
				EndIF
			EndDo
		EndIF
	EndIF
EndDo

Proc TrCliIndividual(cCaixa)
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL cVelho	:= Space(05)
LOCAL cCodi 	:= Space(05)
LOCAL cFatura	:= Space(07)
LOCAL cObs		:= Space(40)
LOCAL dData 	:= Date()

WHILE OK
	oMenu:Limpa()
	MaBox( 13, 05, 16, 78 )
	cVelho  := Space(05)
	cCodi   := Space(05)
	cFatura := Space(07)
	@ 14, 06 Say "Cliente Velho.:" GET cVelho  Pict "99999" Valid RecErrado( @cVelho,, Row(), Col()+1 )
	@ 15, 06 Say "Cliente Novo..:" GET cCodi   Pict "99999" Valid RecErrado( @cCodi,,Row(),Col()+1 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	Vendemov->(Order( VENDEMOV_FATURA ))	
	Nota->(Order( NOTA_CODI ))
	Recibo->(Order( RECIBO_FATURA ))		
	If Conf("Pergunta: Confirma Alteracao?")
		Mensagem('Informa: Aguarde...')
		IF Nota->(!DbSeek( cVelho ))
			ErrorBeep()
			Alerta("Erro: Nenhuma fatura encontrada.")
			Loop
		EndIF
		Nota->(Order( NOTA_CODI ))
		WHILE Nota->(DbSeek( cVelho ))
			cFatura := Nota->Numero
			IF Recemov->(DbSeek( cFatura ))
				WHILE Recemov->Fatura = cFatura
					IF Recemov->(TravaReg())
						Recemov->Codi = cCodi
						Recemov->(Libera())
					  Recemov->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			IF Recebido->(DbSeek( cFatura ))
				WHILE Recebido->Fatura = cFatura
					IF Recebido->(TravaReg())
						Recebido->Codi = cCodi
						Recebido->(Libera())
						Recebido->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			IF Saidas->(DbSeek( cFatura ))
				WHILE Saidas->Fatura = cFatura
					IF Saidas->(TravaReg())
						Saidas->Codi		 = cCodi
						Saidas->Situacao	 = 'ALTERADA'
						Saidas->Atualizado = Date()
						Saidas->Caixa		 = cCaixa
						Saidas->(Libera())
						Saidas->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			Nota->(Order( NOTA_NUMERO ))
			IF Nota->(DbSeek( cFatura ))
				WHILE Nota->Numero = cFatura
					IF Nota->(TravaReg())
						Nota->Codi		  = cCodi
						Nota->Situacao   = 'ALTERADA'
						Nota->Atualizado = Date()
						Nota->Caixa 	  = cCaixa
						Nota->(Libera())
						Nota->(DbSkip(1))
					EndIF
				EndDo
			EndIF
			Nota->(Order( NOTA_CODI ))
			IF Vendemov->(DbSeek( cFatura ))
				WHILE Vendemov->Fatura = cFatura
					IF Vendemov->(TravaReg())
						Vendemov->Codi = cCodi
						Vendemov->(Libera())
						Vendemov->(DbSkip(1))
				  EndIF
				EndDo
			EndIF
			Recibo->(Order( RECIBO_FATURA ))
			IF Recibo->(DbSeek( cFatura ))
				WHILE Recibo->Fatura = cFatura
					IF Recibo->(TravaReg())
						Recibo->Codi = cCodi
						Recibo->(Libera())
						Recibo->(DbSkip(1))
				  EndIF
				EndDo
			EndIF			
		EndDo
	EndIF
EndDo

Proc RolPagarPago()
*******************
LOCAL cScreen	  := SaveScreen()
LOCAL cFatuIni   := Space(07)
LOCAL cFatuFim   := Space(07)
LOCAL nChoice	  := 0
LOCAL nPorc 	  := 0
LOCAL nVlrFatura := 0
LOCAL nPagarPerc := 0
LOCAL nPagoPerc  := 0
LOCAL nTotPagar  := 0
LOCAL nTotPago   := 0
LOCAL lAchou	  := FALSO
LOCAL aRelato	  := {}
LOCAL cCodi 	  := ''
LOCAL cNome 	  := ''
LOCAL nX
LOCAL oRelato
LOCAL oBloco
LOCAL cFatura
LOCAL cPagar
LOCAL cPago

WHILE OK
	oMenu:Limpa()
	MaBox( 10, 10, 14, 79 )
	cFatuIni := Space(07)
	cFatuFim := Space(07)
	xCodigo	:= 0
	nChoice	:= 0
	nPorc 	:= 0
	aRelato	:= {}
	@ 11, 11 Say "Fatura Inicial..:" Get cFatuIni Pict "@!"       Valid VisualAchaFatura( @cFatuIni )
	@ 12, 11 Say "Fatura Final....:" Get cFatuFim Pict "@!"       Valid VisualAchaFatura( @cFatuFim )
	@ 13, 11 Say "Percentual Pago.:" GET nPorc    PICT "999.9999" Valid nPorc <> 0
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	oBloco := {|| Saidas->Fatura >= cFatuIni .AND. Saidas->Fatura <= cFatuFim }
	Receber->(Order( RECEBER_CODI ))
	Recebido->(Order( RECEBIDO_FATURA ))
	Recemov->(Order( RECEMOV_FATURA ))
	Saidas->(Order( SAIDAS_FATURA ))
	ErrorBeep()
	IF Conf("Pergunta: Deseja Continuar ?")
		lCancelado := Conf('Pergunta: Incluir Cancelados ?')
		Saidas->(DbSeek( cFatuIni ))
		While Saidas->(Eval( oBloco ))
			nTotPagar  := 0
			nTotPago   := 0
			cCodi 	  := Saidas->Codi
			cFatura	  := Saidas->Fatura
			nVlrFatura := Saidas->VlrFatura
			Receber->(DbSeek( cCodi ))
			cNome 	  := Receber->Nome
			IF !lCancelado
				IF Receber->Cancelada
					Saidas->(DbSkip(1))
					Loop
				EndIF
			EndIF
			IF Recemov->(DbSeek( cFatura ))
				While Recemov->Fatura = cFatura
					nTotPagar += Recemov->Vlr
					Recemov->(DbSkip(1))
				Enddo
			EndIF
			IF Recebido->(DbSeek( cFatura ))
				While Recebido->Fatura = cFatura
					nTotPago += Recebido->Vlr
					Recebido->(DbSkip(1))
				Enddo
			EndIF
			nPagoPerc  := ( nTotPago / nVlrFatura ) * 100
			nPagarPerc := ( 100 - nPagoPerc )
			IF nPagarPerc < 0
				nPagarPerc := 0
			EndIF
			cPago 	  := Tran( nPagoPerc,  "999%")
			cPagar	  := Tran( nPagarPerc, "999%")
			cVlrFatura := Tran( nVlrFatura, '@E 9,999,999.99')
			IF Ascan2( aRelato, cFatura, 3 ) <= 0
				IF nPagarPerc >= nPorc
					Aadd( aRelato, { cCodi, cNome, cFatura, cVlrFatura, cPago, cPagar })
				EndIF
			EndIF
			Saidas->(DbSkip(1))
		Enddo
		IF !InsTru80()
			ResTela( cScreen )
			Return
		EndIF
		PrintOn()
		SetPrc( 0,0 )
		oRelato				:= TRelatoNew()
		oRelato:Sistema	:= SISTEM_NA3
		oRelato:Titulo 	:= "RELATORIO DE PERCENTUAL PAGO/PAGAR"
		oRelato:Cabecalho := "CODI  NOME DO CLIENTE                          FATURA      VLR FATURA PAGO PAGAR"
		oRelato:Inicio()
		For nX := 1 To Len( aRelato )
			Qout( aRelato[nX,1], aRelato[nX,2], aRelato[nX,3], aRelato[nX,4], aRelato[nX,5], aRelato[nX,6])
			oRelato:RowPrn ++
		Next
		__Eject()
		PrintOff()
	EndIF
EndDo


Proc MarDesMarcaCliente()
*************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Receber")
Receber->(Order( RECEBER_NOME ))
Receber->(DbGoTop())
oBrowse:Add( "ROL",       "Rol")
oBrowse:Add( "CODIGO",    "Codi")
oBrowse:Add( "NOME",      "Nome")
oBrowse:Add( "CIDADE",    "Cida")
oBrowse:Add( "UF",        "Esta")
oBrowse:Titulo   := "MARCA/DESMARCA CLIENTES PARA RELATORIO COBRANCA"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := {|| HotPreCli( oBrowse ) }
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Proc RemoveAgenda()
*******************
LOCAL aMenu 	:= {'Individual','Por Cliente','Geral'}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodiVen := Space(04)
LOCAL cCodi 	:= Space(05)
LOCAL nChoice	:= 0

WHILE OK
	oMenu:Limpa()
	M_Title('REMOVER AGENDAMENTO COBRANCA')
	nChoice := FazMenu( 03, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		MaBox( 10, 10, 12, 78 )
		cCodiVen := Space( 04 )
		@ 11 , 11 Say "Cobrador..:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return
		EndIF
		ErrorBeep()
		If Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Removendo Agendamento por Cobrador.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				IF Recemov->Cobrador = cCodiVen
					cCodi   := Recemov->Codi
					oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
					Ferase( oAgenda )
			  EndIF
			  Recemov->(DbSkip(1))
			EndDo
		EndIf

	Case nChoice = 2
		cCodi := Space( 05 )
		MaBox( 10, 10, 12, 78 )
		@ 11, 11 Say "Cliente....:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Return
		EndIF
		ErrorBeep()
		IF Conf("Pergunta: Continua ?")
			Mensagem("Aguarde, Removendo Agendamento por Cliente.")
			Recemov->(Order( RECEMOV_CODI ))
			IF Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
					Ferase( oAgenda )
					Recemov->(DbSkip(1))
				EndDo
			EndIf
		EndIF

	Case nChoice = 3
		ErrorBeep()
		If Conf("Pergunta: Alteracao podera demorar. Continua ?")
			Recemov->(DbGotop())
			Mensagem("Aguarde, Removendo Agendamento Geral.")
			While Recemov->(!Eof()) .AND. Rep_Ok()
				cCodi   := Recemov->Codi
				oAgenda := oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
				Ferase( oAgenda )
				Recemov->(DbSkip(1))
			EndDo
		EndIF
	EndCase
EndDo

Proc Prn002Cob( cTitulo, dIni, dFim, dAtual, aCodi, cCodiVen, lTotal, lSeletiva, aReg, dProxCob, dProxCobFim )
**************************************************************************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL lSair 	  := FALSO
LOCAL Lista 	  := SISTEM_NA3
LOCAL Tam		  := 132
LOCAL Col		  := 58
LOCAL Pagina	  := 0
LOCAL NovoCodi   := OK
LOCAL lSub		  := FALSO
LOCAL UltCodi	  := Recemov->Codi
LOCAL GrandTotal := 0
LOCAL nCarencia  := 0
LOCAL GrandJuros := 0
LOCAL GrandGeral := 0
LOCAL Atraso	  := 0
LOCAL Juros 	  := 0
LOCAL TotalCli   := 0
LOCAL TotalJur   := 0
LOCAL TotalGer   := 0
LOCAL nJrVlr	  := 0
LOCAL nJuros	  := 0
LOCAL nJdia 	  := 0
LOCAL nAtraso	  := 0
LOCAL nJuro 	  := 0
LOCAL nValor	  := 0
LOCAL nDocumento := 0
LOCAL nClientes  := 0
LOCAL nY 		  := 0
LOCAL nConta	  := 0
LOCAL aRelato	  := {}
LOCAL nResuVlr   := 0
LOCAL nResuDocs  := 0
LOCAL nResuJrVlr := 0
LOCAL cTela
LOCAL dEmis
LOCAL dVcto
LOCAL NovoNome
LOCAL UltNome
LOCAL oAgenda
LOCAL cAgenda1
LOCAL cAgenda2
LOCAL cData1
LOCAL cData2

cTela := Mensagem("Informe: Aguarde, imprimindo.", Cor())
PrintOn()
FPrint(PQ)
SetPrc( 0 , 0 )
Area("ReceMov")
nLenCodi := Len( aCodi )
For nY := 1 To nLenCodi
	Receber->( Order( RECEBER_CODI ))
	cCodiReceber := aCodi[nY]
	IF Receber->(DbSeek( cCodiReceber ))
		Recemov->(Order( RECEMOV_CODI ))
		IF Recemov->(!DbSeek( cCodiReceber ))
			Loop
		EndIF
	Else
		Loop
	EndIF
	NovoCodi := OK
	WHILE Recemov->Codi = cCodiReceber .AND. Recemov->(!Eof()) .AND. Rel_Ok()
		/*
		IF dProxCob != NIL
			// IF Receber->ProxCob > dProxCob .AND. Receber->ProxCob < dProxCobFim
			IF Receber->ProxCob < dProxCob .OR. Receber->ProxCob > dProxCobFim
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		*/
		IF lSeletiva = NIL .OR. lSeletiva = FALSO
			IF Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
				Recemov->(DbSkip(1))
				Loop
			EndIF
		Else
			xRecno := Recemov->(Recno())
			IF Ascan( aReg, xRecno ) = 0
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		Atraso	 := Atraso(   dAtual, Vcto )
		nDesconto := VlrDesconto( dAtual, Vcto, Vlr )
		nMulta	 := VlrMulta( dAtual, Vcto, Vlr )
		nCarencia := Carencia( dAtual, Vcto )
		IF Atraso <= 0
			Juros := 0
		Else
			Juros := Jurodia * nCarencia
		EndIF
		IF Col >= 57
			Write( 01, 001, "Pagina N§ " + StrZero( ++Pagina , 3 ) )
			Write( 01, 117, "Horas "+ Time())
			Write( 02, 001, Dtoc( Date() ))
         Write( 03, 000, Padc( AllTrim(oAmbiente:xNomefir), Tam ))
			Write( 04, 000, Padc( Lista  , Tam ))
			Write( 05, 000, Padc( cTitulo , Tam ))
			Write( 06, 000, Repl( "=", Tam ) )
			Write( 07, 000, "DOC N§ RG TIPO    EMISSAO     VCTO PORTADOR     VLR TITULO JR MES ATR  JR DIARIO     DESCONTO        MULTA  TOTAL JUROS  TOTAL GERAL")
			Write( 08, 000, Repl( "=", Tam ) )
			Col := 9
		EndIF
		IF NovoCodi .OR. Col = 9
			IF NovoCodi
				NovoCodi := FALSO
			EndIF
			Qout( Codi, Receber->Regiao, Receber->Nome, Receber->Fone, Receber->( Trim( Ende )), Receber->(Trim(Bair)),Receber->( Trim( Cida )), Receber->Esta )
			Qout( Space(05), "SPC:" + IF( Receber->Spc, "SIM em " + Dtoc( Receber->DataSpc ), "NAO"), Space(1), Receber->Fanta, Receber->Obs )
			Qout( Space(05), 'PROFISSAO: ' + Receber->Profissao, 'TRABALHO:' + Receber->Trabalho, 'CARGO : ' + Receber->Cargo )
			Qout( Space(05), 'AVALISTA : ' + Receber->Conhecida,  'ENDERECO:' + Receber->Ende3 )
			Col += 4
			oAgenda := TIniNew( oAmbiente:xBaseDados + '\AGE' + cCodiReceber + '.INI')
			nConta := oAgenda:ReadInteger( Codi, 'soma', 0 )
			For nV = 1 To nConta Step 2
				cAgenda1 := Left( oAgenda:ReadString( Codi, StrZero(nV,	2), Repl('_',40), 1), 40)
				cData1	:= Dtoc( oAgenda:ReadDate( Codi,   StrZero(nV,	2), cTod('//'), 2))
				cAgenda2 := Left( oAgenda:ReadString( Codi, StrZero(nV+1,2), Repl('_',40), 1), 40)
				cData2	:= Dtoc( oAgenda:ReadDate( Codi,   StrZero(nV+1,2), cTod('//'), 2))
				Qout(  Space(05), 'AGENDA ' + StrZero( nV,   2) + ': ' + cData1 + ' ' + cAgenda1 )
				QQout( Space(05), 'AGANDA ' + StrZero( nV+1, 2) + ': ' + cData2 + ' ' + cAgenda2 )
				Col++
			Next
			oAgenda:Close()
		EndIF
		cEmis 	 := Dtoc( Emis )
		cVcto 	 := Dtoc( Vcto )
		cJuro 	 := Tran( Juro,	"999.99")
		cAtraso	 := Tran( Atraso, "999")
		cJdia 	 := Tran( Jurodia,		"@E 999,999.99")
		cValor	 := Tran( Vlr, 			"@E 9,999,999.99")
		cJuros	 := Tran( Juros,			"@E 9,999,999.99")
		cDesconto := Tran( nDesconto, 	"@E 9,999,999.99")
		cMulta	 := Tran( nMulta, 		"@E 9,999,999.99")
		cJrVlr	 := Tran((( Juros + Vlr ) + nMulta ) - nDesconto,	"@E 9,999,999.99")
		nJrVlr	 := ((( Juros + Vlr ) + nMulta ) - nDesconto)
		IF !lTotal
			xPos := Ascan2( aRelato, Codi, 2 )
			IF xPos <= 0
				Aadd( aRelato, { 1, Codi, Receber->Nome, Vlr, nJrVlr })
			Else
				aRelato[xPos,1] += 1
				aRelato[xPos,4] += Vlr
				aRelato[xPos,5] += nJrVlr
			EndIF
			Qout( Docnr, Tipo, cEmis, cVcto,Port, cValor, cJuro, cAtraso, cJdia, cDesconto, cMulta,cJuros, cJrVlr )
			Col++
		EndIF
		Totalcli   += Vlr
		Totaljur   += Juros
		Totalger   += nJrVlr
		GrandTotal += Vlr
		GrandJuros += Juros
		GrandGeral += nJrVlr
		nDocumento ++
		IF Recemov->(TravaReg())
			Recemov->Cobrador := cCodiVen
			Recemov->RelCob	:= OK
			Recemov->(Libera())
		EndIF
		Recemov->(DbSkip(1))
		IF Col >= 57
			Col++
			Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
			TotalCli := 0
			TotalJur := 0
			TotalGer := 0
			Col		+= 2
			__Eject()
		EndIF
	EndDo
	IF TotalCli != 0
		Col++
		Terminou( Tam, Col, TotalCli, TotalJur, TotalGer )
		TotalCli := 0
		TotalJur := 0
		TotalGer := 0
		Col		+= 2
	EndIF
Next
Write(  Col , 000, "** Total Geral **" )
Write(  Col , 020, StrZero( nLenCodi, 6 ) + ' - ' + StrZero( nDocumento, 6 ))
Write(  Col , 046, Tran( GrandTotal, "@E 9,999,999.99" ))
Write(  Col , 107, Tran( GrandJuros, "@E 9,999,999.99" ))
Write(  Col , 120, Tran( GrandGeral, "@E 9,999,999.99" ))
__Eject()
PrintOff()
oMenu:Limpa()
ErrorBeep()
IF Conf('Pergunta: Confirma Impressao do Resumo ?')
	Asort( aRelato,,, {| x, y | y[3] > x[3] } )
	IF !InsTru80()
		ResTela( cScreen )
		Return
	EndIF
	PrintOn()
	FPrint(PQ)
	SetPrc( 0,0 )
	oRelato				:= TRelatoNew()
	oRelato:Tamanho	:= 132
	oRelato:Sistema	:= SISTEM_NA3
	oRelato:Titulo 	:= cTitulo
	oRelato:Cabecalho := 'CODI  NOME DO CLIENTE                       QTD DOC        VALOR    VLR C/ JR'
	oRelato:Inicio()
	nResuVlr   := 0
	nResuJrVlr := 0
	nResuDocs  := 0
	For nX := 1 To Len( aRelato )
		Qout( aRelato[nX,2], aRelato[nX,3], Tran( aRelato[nX,1], '9999'), Tran( aRelato[nX,4], '@E 9,999,999.99'), Tran( aRelato[nX,5], '@E 9,999,999.99'))
		oRelato:RowPrn ++
		nResuVlr   += aRelato[nX,4]
		nResuJrVlr += aRelato[nX,5]
		nResuDocs  += aRelato[nX,1]
	Next
	Qout()
	Qout('** Total Geral **', Space(28), Tran( nResuDocs, '9999'), Tran( nResuVlr, '@E 9,999,999.99'), Tran( nResuVlr, '@E 9,999,999.99'))
	__Eject()
	PrintOff()
EndIF
ResTela( cScreen )
Return


Function ReciboDiv( cCaixa, cVendedor )
***************************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Recibo Diarias Semanal','Recibo Diversos','Vale Diversos'}
LOCAL nChoice := 0

WHILE OK
	oMenu:Limpa()
	M_Title("RECIBOS/VALES DIVERSOS" )
	nChoice := FazMenu( 10, 10, aMenu )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
      DivDiaria( cCaixa, cVendedor, "RECIBO")

	Case nChoice = 2
      DivRecibo( cCaixa, cVendedor, 'RECIBO', nChoice)

	Case nChoice = 3
      DivRecibo( cCaixa, cVendedor, 'VALE', nChoice)
	EndCase
END

Function DivDiaria( cCaixa, cVendedor, cTipo )
**********************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cCodiven  := Space(04)
LOCAL dIni		 := Date()-5
LOCAL dFim		 := Date()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL cDocnr	 := StrZero( Chemov->(LastRec()), 9 )
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow

WHILE OK
	oMenu:Limpa()
	cCodiven := Space(04)
	dIni		:= Date()-5
	dFim		:= Date()
	cNome 	:= Space(40)
	cEnde 	:= Space(40)
	cCida 	:= Space(40)
	cHist 	:= 'QUITACAO DIARIAS SERVICO DE INSTALACAO ANTENAS REF '
	cRef		:= cHist
	cCodiCx	:= '0000'
	cDc		:= 'D'
	cDc1		:= 'D'
	cDc2		:= 'D'
	nValor	:= 0
	cDocnr	:= AllTrim( cDocnr )
	nTamDoc	:= Len( cDocnr )
	cDocnr	:= StrZero( Val( cDocnr ) + 1, nTamDoc ) + Space( 9 - nTamDoc )
	MaBox( 07, 00, 13, 79, 'IMPRESSAO DE ' + cTipo + ' DIVERSOS' )
	@ 08, 01 Say "Funcionario....: " Get cCodiven Pict "9999" Valid FunErrado( @cCodiven,,Row(),Col()+1)
	@ 09, 01 Say "Data Inicio....: " Get dIni     Pict "##/##/##" Valid IF(Empty(dIni),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 10, 01 Say "Data Final.....: " Get dFim     Pict "##/##/##" Valid IF(Empty(dFim),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma data!"), FALSO ), OK )
	@ 11, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid IF(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 12, 01 Say "Documento N§...: " Get cDocnr   Pict "@!" Valid CheqDoc(cDocnr)
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	EndIF
	nVlrLcto := nValor
	cHist 	:= 'QUITACAO DIARIAS SERVICO DE INSTALACAO ANTENAS REF '
	cHist 	+= dToc( dIni )
	cHist 	+= ' A '
	cHist 	+= dToc( dFim )
	cRef		:= cHist

	Vendedor->(Order( VENDEDOR_CODIVEN ))
	IF Vendedor->(DbSeek( cCodiven ))
		cNome := Alltrim(Vendedor->Nome)
		cEnde := AllTrim(Vendedor->Ende)
		cEnde += IF(!Empty(Vendedor->Bair),' - ','')
		cEnde += AllTrim(Vendedor->Bair)
		cCida := AllTrim(Vendedor->Cida)
		cCida += IF(!Empty(Vendedor->Esta),'/','')
		cCida += Vendedor->Esta
	EndIF

	IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF
	*:-------------------------------------------------------

	IF Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := dFim
      Recibo->Tipo    := "PAGDIA"

      Recibo->Codi    := cCodiven
		Recibo->Docnr	 := cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := Date()
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))

		Recibo->Caixa	 := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF


   *:-------------------------------------------------------
	IF !Instru80() .OR. !LptOk()
		Restela( cScreen )
		Return
	EndIF
	cTela := Mensagem("Aguarde, Imprimindo Recibo.", Cor())
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( 33 ))
	nVlrTotal := nValor
	cValor	 := AllTrim(Tran( nVlrTotal,'@E 9,999,999.99'))
	nValor	 := Extenso( nVlrTotal, 1, 3, Larg )
	SetPrc(0,0)
	nRow := 2
	Write( nRow+00, 00, Repl("=",80))
	Write( nRow+01, 00, GD + Padc( Trim( cNome ), 40) + CA )
	Write( nRow+02, 00, Padc( Trim(cEnde) + " - " + Trim(cCida), 80 ))
	Write( nRow+03, 00, Repl("-",80))
	Write( nRow+04, 40, GD + cTipo + CA + NR)
	Write( nRow+05, 00, "N§ " + NG + cDocnr + NR )
	Write( nRow+05, 66, "R$ " + NG + cValor + NR )
   Write( nRow+07, 00, "Recebemos de    : " + NG + AllTrim(oAmbiente:xNomefir)+ NR )
	Write( nRow+08, 00, "Estabelecido  a : " + NG + XENDEFIR + NR )
	Write( nRow+09, 00, "na Cidade de    : " + NG + XCCIDA + ' - ' + XCESTA + NR )
	Write( nRow+11, 00, "A Importancia por extenso abaixo relacionada")
	Write( nRow+12, 00, NG + Left( nValor, Larg ) + NR  )
	Write( nRow+13, 00, NG + SubStr( nValor, Larg + 1, Larg ) + NR  )
	Write( nRow+14, 00, NG + Right( nValor, Larg ) + NR  )
	Write( nRow+16, 00, "Referente a")
	Write( nRow+17, 00, NG + cRef + NR )
	Write( nRow+19, 00, "Para maior clareza firmo(amos) o presente")
	Write( nRow+20, 00, NG + Padl(DataExt( Date()), 80) + NR)
	Write( nRow+24, 00, Padl(Repl("-",40),80))
	Write( nRow+25, 00, Repl("=",80))
	__Eject()
	PrintOff()
	ResTela( cTela )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc DivRecibo( cCaixa, cVendedor, cTipo, nChoice )
***************************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL cNome 	 := Space(40)
LOCAL cEnde 	 := Space(40)
LOCAL cCida 	 := Space(40)
LOCAL cValor	 := Space(0)
LOCAL cHist 	 := Space(40)
LOCAL cRef		 := Space(40)
LOCAL cCodiCx1  := Space(04)
LOCAL cCodiCx2  := Space(04)
LOCAL cCodiCx	 := '0000'
LOCAL cDc		 := 'D'
LOCAL cDc1		 := 'D'
LOCAL cDc2		 := 'D'
LOCAL nOpcao	 := 1
LOCAL nVlrTotal := 0
LOCAL Larg		 := 80
LOCAL nValor	 := 0
LOCAL nChSaldo  := 0
LOCAL cDocnr	 := StrZero( Chemov->(LastRec()), 9 )
LOCAL nTamDoc	 := 0
LOCAL nVlrLcto  := 0
LOCAL cTela
LOCAL nRow
LOCAL cNomeFir
LOCAL cStr

cNome 	:= Space(40)
cEnde 	:= Space(40)
cCida 	:= Space(40)
cHist 	:= Space(40)
cRef		:= Space(40)
cCodiCx1 := Space(04)
cCodiCx2 := Space(04)
cCodiCx	:= '0000'
cDc		:= 'D'
cDc1		:= 'D'
cDc2		:= 'D'
nValor	:= 0
cDocnr	:= AllTrim( cDocnr )
nTamDoc	:= Len( cDocnr )
cNomeFir := oAmbiente:xNomefir
WHILE OK
	oMenu:Limpa()
	cDocnr	:= StrZero( Val( cDocnr ) + 1, nTamDoc ) + Space( 9 - nTamDoc )
   MaBox( 06, 00, 18, 79, 'IMPRESSAO DE ' + cTipo + ' DIVERSOS' )
   @ 07, 01 Say "Recebemos de...: " Get cNomeFir Pict "@!" Valid IF(Empty(cNomeFir),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!"), FALSO ), OK )
   @ 08, 01 Say "Nome Emitente..: " Get cNome    Pict "@!" Valid IF(Empty(cNome),  ( ErrorBeep(), Alerta("Ooops!: Entre com um nome!"), FALSO ), OK )
	@ 09, 01 Say "Estabelecido a : " Get cEnde    Pict "@!" Valid IF(Empty(cEnde),  ( ErrorBeep(), Alerta("Ooops!: Entre com um Endereco!"), FALSO ), OK )
	@ 10, 01 Say "Na Cidade de   : " Get cCida    Pict "@!" Valid IF(Empty(cCida),  ( ErrorBeep(), Alerta("Ooops!: Entre com uma Cidade!"), FALSO ), OK )
	@ 11, 01 Say "Documento N§...: " Get cDocnr   Pict "@!" Valid CheqDoc(cDocnr)
	@ 12, 01 Say "Referente......: " Get cRef     Pict "@!" Valid IF(Empty(cRef),   ( ErrorBeep(), Alerta("Ooops!: Entre com a referencia!"), FALSO ), (ValidarcHist(cRef,@cHist), OK))
	@ 13, 01 Say "Historico Cx...: " Get cHist    Pict "@!" Valid IF(Empty(cHist),  ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	@ 14, 01 Say "Valor R$.......: " Get nValor   Pict "@E 9,999,999.99" Valid IF(Empty(nValor), ( ErrorBeep(), Alerta("Ooops!: Entre com um valor!"), FALSO ), OK )
	@ 15, 01 Say "Conta Caixa....: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), 32, OK )
	@ 15, 24 Say "D/C.:"             GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
	@ 16, 01 Say "C. Partida.....: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), 32, OK )
	@ 16, 24 Say "D/C.:"             GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
	@ 17, 01 Say "C. Partida.....: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), 32, OK )
	@ 17, 24 Say "D/C.:"             GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF !Conf('Pergunta: Confirma lancamento ?')
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Loop
	EndIF
	nVlrLcto := nValor
	IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF
	*:-------------------------------------------------------
	IF Cheque->(DbSeek( cCodiCx1 )) .OR. !Empty( cCodiCx1 )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc1 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx1
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF
	*:-------------------------------------------------------
	IF Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
		IF Cheque->(TravaReg())
			nChSaldo := Cheque->Saldo
			IF Chemov->(Incluiu())
				IF cDc2 = "C"
					nChSaldo 	  += nVlrLcto
					Cheque->Saldo += nVlrLcto
					Chemov->Cre   := nVlrLcto
				Else
					nChSaldo 	  -= nVlrLcto
					Cheque->Saldo -= nVlrLcto
					Chemov->Deb   := nVlrLcto
				EndIF
				Chemov->Codi	:= cCodiCx2
				Chemov->Docnr	:= cDocnr
				Chemov->Emis	:= Date()
				Chemov->Data	:= Date()
				Chemov->Baixa	:= Date()
				Chemov->Hist	:= cHist
				Chemov->Saldo	:= nChSaldo
				Chemov->Tipo	:= 'OU'
				Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
				Chemov->Fatura := cDocnr
			EndIF
			Chemov->(Libera())
		EndIF
		Cheque->(Libera())
	EndIF

	*:-------------------------------------------------------

   IF Recibo->(Incluiu())
		Recibo->Nome	 := cNome
      Recibo->Vcto    := Date()
      Recibo->Tipo    := IF( nChoice = 2, "PAGDIV", "PAGDIV")
      Recibo->Codi    := "00000"
		Recibo->Docnr	 := cDocnr
      Recibo->Hora    := Time()
      Recibo->Data    := Date()
      Recibo->Usuario := oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario ))
      Recibo->Caixa   := cCaixa
      Recibo->Vlr     := -nValor
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF

   *:-------------------------------------------------------

   IF !Instru80() .OR. !LptOk()
		Restela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo Recibo.", Cor())
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( 33 ))
	nVlrTotal := nValor
   cStr   := AllTrim(Tran( nVlrTotal,'@E 9,999,999.99'))
   cValor := Extenso( nVlrTotal, 1, 3, Larg )
	SetPrc(0,0)
	nRow := 2
	Write( nRow+00, 00, Repl("=",80))
	Write( nRow+01, 00, GD + Padc( Trim( cNome ), 40) + CA )
	Write( nRow+02, 00, Padc( Trim(cEnde) + " - " + Trim(cCida), 80 ))
	Write( nRow+03, 00, Repl("-",80))
	Write( nRow+04, 40, GD + cTipo + CA + NR)
	Write( nRow+05, 00, "N§ " + NG + cDocnr + NR )
   Write( nRow+05, 66, "R$ " + NG + cStr + NR )
   Write( nRow+07, 00, "Recebemos de    : " + NG + cNomeFir + NR )
	Write( nRow+08, 00, "Estabelecido  a : " + NG + XENDEFIR + NR )
	Write( nRow+09, 00, "na Cidade de    : " + NG + XCCIDA + ' - ' + XCESTA + NR )
	Write( nRow+11, 00, "A Importancia por extenso abaixo relacionada")
   Write( nRow+12, 00, NG + Left( cValor, Larg ) + NR  )
   Write( nRow+13, 00, NG + SubStr( cValor, Larg + 1, Larg ) + NR  )
   Write( nRow+14, 00, NG + Right( cValor, Larg ) + NR  )
	Write( nRow+16, 00, "Referente a")
	Write( nRow+17, 00, NG + cRef + NR )
	Write( nRow+19, 00, "Para maior clareza firmo(amos) o presente")
	Write( nRow+20, 00, NG + Padl(DataExt( Date()), 80) + NR)
	Write( nRow+24, 00, Padl(Repl("-",40),80))
	Write( nRow+25, 00, Repl("=",80))
	__Eject()
	PrintOff()
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc ValidarcHist(cRef,cHist)
*****************************
cHist = cRef
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc RelRecebido()
******************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aTPrompt 	 := {" Individual ", " Por Portador ", " Por Vendedor ", " Por Forma Pgto", " Por Regiao"," Por Data Baixa *", " Por Tipo", " Por Caixa ", " Totalizado ", " Geral " }
LOCAL aOrdem		 := {"Codigo","Data Pgto *", "Documento","Emissao", "Observacoes", "Portador", "Tipo", "Valor", "Valor Pago", "Vencimento"}
LOCAL nRolRecebido := oIni:ReadInteger('relatorios', 'rolrecebido', 1)
LOCAL xArquivo 	 := TempNew()
LOCAL xNtx			 := TempNew()
LOCAL cForma		 := Space(02)
LOCAL cCodi 		 := Space(05)
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL cRegiao		 := Space(02)
LOCAL dBaixaIni	 := Date()-30
LOCAL dBaixaFim	 := Date()
LOCAL cTipo 		 := Space(06)
LOCAL cCaixa		 := Space(04)
LOCAL nConta		 := 0
LOCAL nOpcao		 := 0
LOCAL cTela
LOCAL bPeriodo
LOCAL bTipo
LOCAL nField
LOCAL nChoice
LOCAL oBloco
LOCAL cPortador
LOCAL cCodiVen
LOCAL Tam
LOCAL Col
LOCAL Pagina
LOCAL nTotalVlr
LOCAL nTotalJur
LOCAL nTotalRec
LOCAL nDocumento
LOCAL cFatura
LOCAL bCaixa

WHILE OK
	oMenu:Limpa()
	Saidas->(Order( SAIDAS_FATURA ))
	Area("ReceBido")
	M_Title( "ROL TITULOS RECEBIDOS" )
	nChoice := FazMenu( 01, 20, AtPrompt )
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1 // Cliente
		cCodi := Space(05)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 15, 20 , 19, 79 )
		@ 16, 21 Say "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+3 )
		@ 17, 21 Say "Inicio..:" Get dIni  Pict "##/##/##"
		@ 18, 21 Say "Fim.....:" Get dFim  Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_CODI ))
		IF Recebido->(!DbSeek( cCodi ))
			Nada()
			Restela( cScreen )
			Loop
		EndIF
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Codi = cCodi
			IF Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 2 // Portador
		cPortador := Space( 10 )
		dIni		 := Date()-30
		dFim		 := Date()
		MaBox( 15 , 20 , 19 , 75 )
		@ 16, 21 Say "Portador......... :" Get cPortador Pict "@!" Valid AchaPortador( @cPortador )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_PORT ))
		IF Recebido->(!DbSeek( cPortador ))
			Nada()
			Restela( cScreen )
			Loop
		EndIF
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Port = cPortador
			IF Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 3 // Vendedor
		cCodiVen := Space(04)
		dIni		:= Date()-30
		dFim		:= Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Vendedor..........:" Get cCodiVen Pict "9999" Valid FunErrado( @cCodiVen )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni     Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim     Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_CODIVEN ))
		IF Recebido->(!DbSeek( cCodiVen ))
			Nada()
			Restela( cScreen )
			Loop
		EndIF
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->CodiVen = cCodiVen
			IF Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 4 // Forma
		cForma := Space(02)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Forma.............:" Get cForma Pict "99" Valid FormaErrada( @cForma )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_FORMA ))
		IF Recebido->(!DbSeek( cForma ))
			Nada()
			Restela( cScreen )
			Loop
		EndIF
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Forma = cForma
			IF Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 5 // Por Regiao
		cRegiao := Space(02)
		dIni	  := Date()-30
		dFim	  := Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Regiao............:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni     Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim     Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_REGIAO ))
		IF Recebido->(!DbSeek( cRegiao ))
			Nada()
			Restela( cScreen )
			Loop
		EndIF
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Regiao = cRegiao
			IF Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ErrorBeep()
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 6 // Data da Baixa
		dBaixaIni := Date()-30
		dBaixaFim := Date()
		MaBox( 15 , 20 , 18, 75 )
		@ 16, 21 Say  "Data Baixa Inicial..¯" Get dBaixaIni Pict "##/##/##"
		@ 17, 21 Say  "Data Baixa Final....¯" Get dBaixaFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		dIni := dBaixaIni
		dFim := dBaixaFim
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_BAIXA ))
		Set Soft On
		Recebido->(DbSeek( dBaixaIni ))
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->Baixa >= dBaixaIni .AND. Recebido->Baixa <= dBaixaFim
			IF nRolRecebido = 2
				cFatura := Recebido->Fatura
				IF Saidas->(DbSeek( cFatura ))
					IF !Saidas->Impresso
						Recebido->(DbSkip(1))
						Loop
					EndIF
				EndIF
			EndIF
			nConta++
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
			Next
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 7 // Por Tipo
		cTipo := Space(06)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 15 , 20 , 19, 75 )
		@ 16, 21 Say "Tipo..............:" Get cTipo Pict "@!"
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta	:= 0
		bPeriodo := {| dDataPag | dDataPag >= dIni .AND. dDataPag <= dFim }
		bTipo 	:= {| xTipo 	| xTipo		= cTipo }
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE ( Eval( bPeriodo, Recebido->DataPag ) .AND. Rel_Ok() )
			IF Eval( bTipo, Recebido->Tipo )
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 8 // Por Caixa
		cCaixa := Space(04)
		dIni	 := Date()-30
		dFim	 := Date()
		MaBox( 15 , 20 , 19, 79 )
		@ 16, 21 Say "Caixa.............:" Get cCaixa Pict "9999" Valid FunErrado( @cCaixa,, Row(), Col()+1)
		@ 17, 21 Say "Data Pgto Inicial.:" Get dIni   Pict "##/##/##"
		@ 18, 21 Say "Data Pgto Final...:" Get dFim   Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta	:= 0
		bPeriodo := {| dDataPag | dDataPag >= dIni .AND. dDataPag <= dFim }
		bCaixa	:= {| xCaixa	| xCaixa 	= cCaixa }
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE ( Eval( bPeriodo, Recebido->DataPag ) .AND. Rel_Ok() )
			IF Eval( bCaixa, Recebido->Caixa )
				IF nRolRecebido = 2
					cFatura := Recebido->Fatura
					IF Saidas->(DbSeek( cFatura ))
						IF !Saidas->Impresso
							Recebido->(DbSkip(1))
							Loop
						EndIF
					EndIF
				EndIF
				nConta++
				xTemp->(DbAppend())
				For nField := 1 To FCount()
					xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
				Next
			EndIF
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		EndIF

	Case nChoice = 9 // Totalizado
		Tam		  := 132
		Col		  := 58
		Pagina	  := 0
		nTotalVlr  := 0
		nTotalJur  := 0
		nTotalRec  := 0
		nDocumento := 0
		IF Recebido->(Lastrec()) = 0
			Nada()
			Loop
		EndIF
		IF !InsTru80() .OR. !LptOk()
			Loop
		EndIF
		cTela := Mensagem("Informe: Aguarde, imprimindo.", Cor())
		PrintOn()
		FPrint( PQ )
		SetPrc( 0 , 0 )
		Area("Recebido")
		Recebido->(DbGoTop())
		WHILE Recebido->(!Eof()) .AND. Rel_Ok()
			IF nRolRecebido = 2
				cFatura := Recebido->Fatura
				IF Saidas->(DbSeek( cFatura ))
					IF !Saidas->Impresso
						Recebido->(DbSkip(1))
						Loop
					EndIF
				EndIF
			EndIF
			IF Col >= 57
				Qout( Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ))
				Qout( Dtoc( Date() ))
            Qout( Padc( AllTrim(oAmbiente:xNomefir), Tam ))
				Qout( Padc( SISTEM_NA3, Tam ))
				Qout( Padc( "ROL GERAL DE TITULOS RECEBIDOS - TOTALIZADO" , Tam ))
				Qout( Repl( "=", Tam ) )
				Qout("              QTDE DCTOS    TOTAL NOMINAL      TOTAL JUROS      TOTAL GERAL")
				Qout( Repl( "=", Tam ) )
				Col := 9
			EndIF
			nDocumento ++
			nTotalVlr  += Recebido->Vlr
			nTotalRec  += Recebido->VlrPag
			nTotalJur  += ( Recebido->VlrPag - Recebido->Vlr )
			Recebido->(DbSkip(1))
		EndDo
		Qout("** Total Geral **", Tran( nDocumento, "999999" ),;
								  Tran( nTotalVlr, "@E 9,999,999,999.99" ),;
								  Tran( nTotalJur, "@E 9,999,999,999.99" ),;
								  Tran( nTotalRec, "@E 9,999,999,999.99" ))
		__Eject()
		PrintOff()
		ResTela( cScreen )
		Loop

	Case nChoice = 10 // Geral
		dIni := Date()-30
		dFim := Date()
		MaBox( 15 , 20 , 18 , 75 )
		@ 16, 21 Say "Data Pgto Inicial.:" Get dIni Pict "##/##/##"
		@ 17, 21 Say "Data Pgto Final...:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Area("ReceBido")
		Recebido->(Order( RECEBIDO_DATAPAG ))
		Set Soft On
		Recebido->(DbSeek( dIni ))
		nConta := 0
		Copy Stru To ( xArquivo )
		Use (xArquivo) Exclusive Alias xTemp New
		WHILE Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim
		  IF nRolRecebido = 2
			  cFatura := Recebido->Fatura
			  IF Saidas->(DbSeek( cFatura ))
				  IF !Saidas->Impresso
					  Recebido->(DbSkip(1))
					  Loop
				  EndIF
			  EndIF
		  EndIF
			nConta++
			xTemp->(DbAppend())
			For nField := 1 To FCount()
				xTemp->( FieldPut( nField, Recebido->(FieldGet( nField ))))
			Next
			Recebido->(DbSkip(1))
		EndDo
		Set Soft Off
		IF nConta = 0 // Nao Encontrou Nada.
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			Nada()
			Restela( cScreen )
			Loop
		EndIF
	EndCase
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A ORDEM A IMPRIMIR. ESC RETORNA")
		nOpcao := FazMenu( 05, 10, aOrdem )
		Mensagem(" Aguarde...", Cor())
		Area("xTemp")
		IF nOpcao = 0 // Sair ?
			xTemp->(DbCloseArea())
			Ferase( xArquivo )
			Ferase( xNtx )
			ResTela( cScreen )
			Exit
		ElseIf nOpcao = 1
			 Inde On xTemp->Codi To ( xNtx )
		 ElseIf nOpcao = 2
			 Inde On xTemp->DataPag To ( xNtx )
		 ElseIf nOpcao = 3
			 Inde On xTemp->Docnr To ( xNtx )
		 ElseIf nOpcao = 4
			 Inde On xTemp->Emis To ( xNtx )
		 ElseIf nOpcao = 5
			 Inde On xTemp->Obs To ( xNtx )
		 ElseIf nOpcao = 6
			 Inde On xTemp->Port To ( xNtx )
		 ElseIf nOpcao = 7
			 Inde On xTemp->Tipo To ( xNtx )
		 ElseIf nOpcao = 8
			 Inde On xTemp->Vlr To ( xNtx )
		 ElseIf nOpcao = 9
			 Inde On xTemp->VlrPag To ( xNtx )
		 ElseIf nOpcao = 10
			 Inde On xTemp->Vcto To ( xNtx )
		EndIF
		oMenu:Limpa()
		IF !InsTru80()
			ResTela( cScreen )
			Loop
		EndIF
		Mensagem("Aguarde, Processando Pesado.", Cor())
		Receber->( Order( RECEBER_CODI ))
		Set Rela To xTemp->Codi Into Receber
		xTemp->(DbGoTop())
		Prn001( dIni, dFim, Upper( AtPrompt[ nChoice ]) )
		xTemp->(DbClearRel())
		xTemp->(DbGoTop())
		ResTela( cScreen )
	EndDo
EndDo


Proc AgendaDbedit(nRecno)
************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
DEFAU nRecno TO Agenda->(LastRec())
Set Key -8 To

oMenu:Limpa()
Agenda->(DbClearRel())
Receber->(Order( RECEBER_CODI ))
Area("Agenda")
Agenda->(Order(0))
Set Rela To Agenda->Codi Into Receber
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Agenda->(DbGoTo(nRecno))

oBrowse:Add( "ID",         "Id")
oBrowse:Add( "CODI",      "Codi")
//oBrowse:Add( "NOME",      "Nome", NIL, "RECEBER")
oBrowse:Add( "DATA",      "Data")
oBrowse:Add( "HORARIO",   "Hora")
oBrowse:Add( "HISTORICO", "Hist")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE AGENDAMENTO"
SetKey( F2,         {|| FiltraAgenda(oBrowse) } )
oBrowse:HotKey( F4, {|| DuplicaAgenda( oBrowse )})
oBrowse:PreDoGet := {|| PreDoAgenda( oBrowse )}
oBrowse:PosDoGet := {|| PosDoAgenda( oBrowse )}
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Agenda->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function DuplicaAgenda( oBrowse )
*********************************
LOCAL cScreen := SaveScreen()
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := Agenda->(DbStruct())
LOCAL nConta  := Agenda->(FCount())
LOCAL cCodi
LOCAL xRegistro
LOCAL xRegLocal

ErrorBeep()
IF !Conf('Pergunta: Duplicar registro sob o cursor ?')
	Return( OK )
EndIF
xRegistro := Agenda->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
	xAlias->(FieldPut( nField, Agenda->(FieldGet( nField ))))
Next
IF Agenda->(Incluiu())
	For nField := 1 To nConta
		Agenda->(FieldPut( nField, xAlias->(FieldGet( nField ))))
	Next
	xRegLocal := Agenda->(Recno())
	Agenda->(Libera())
	Agenda->(Order( Ind_Ant ))
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
oBrowse:FreshOrder()
Return( OK )


Function PosDoAgenda( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading = "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
OtherWise
EndCase
Agenda->Atualizado := Date()
Return( OK )

Function PreDoAgenda( oBrowse )
****************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

IF !PodeAlterar()
	Return( FALSO)
EndIF

Do Case
Case oCol:Heading = "CLIENTE"
   ErrorBeep()
	Alerta("Opa! Alteracao n„o permitida. Altere o cadastro do cliente..")
	Return( FALSO )

Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Opa! Nao pode alterar nao.")
	Return( FALSO )
OtherWise
EndCase
Return( PodeAlterar() )

*:---------------------------------------------------------------------------------------------------------------------------------

Function FiltraAgenda( oBrowse )
***********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi

WHILE OK
	oMenu:Limpa()
	Receber->(Order( RECEBER_CODI ))
	MaBox( 14 , 19 , 16 , 35 )
	cCodi := Space(05)
	@ 15 , 20 SAY "Cliente.:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	Agenda->(Order( AGENDA_CODI ))
	Sx_SetScope( S_TOP, cCodi)
	Sx_SetScope( S_BOTTOM, cCodi )
	Agenda->(DbGoTop())
	IF Sx_KeyCount() == 0
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Loop
	EndIF
	Exit
EndDo
ResTela( cScreen )
oBrowse:FreshOrder()
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AgeCobranca( cCodi )
*************************
LOCAL cScreen	:= SaveScreen()
LOCAL dData
LOCAL dDataPro
LOCAL cObs
LOCAL cObs1
LOCAL cCodiVen
LOCAL lAlterar
LOCAL lIncluir

WHILE OK
	oMenu:Limpa()
	IF cCodi == NIL
		cCodi := Space(05)
		PutKey( K_ENTER )
	EndIF
	cObs		:= Space(132)
	cObs1 	:= Space(132)
	cCodiVen := Space(04)
	dData 	:= Date()
	dDataPro := cTod("//")
	MaBox(10, 01, 17, 141)
	@ 11, 02 Say "Cliente..........:" GET cCodi    PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	@ 12, 02 Say "Cobrador.........:" Get cCodiVen Pict "9999"           Valid FunErrado( @cCodiVen,, Row(), Col()+1 )
	@ 13, 02 Say "Data.............:" GET dData    PICT "##/##/##"       Valid IF(Empty(dData), ( ErrorBeep(), Alerta("Ooops!: Entre com a Data!"), FALSO ), OK )
	@ 14, 02 Say "Hist.:"             GET cObs     PICT "@!S80"          Valid IF(Empty(cObs), ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	@ 15, 02 Say "Prox Agendamento.:" GET dDataPro PICT "##/##/##"
	@ 16, 02 Say "Hist.:"             GET cObs1    PICT "@!S80"          Valid IF(!Empty(dDataPro) .AND. Empty(cObs1), ( ErrorBeep(), Alerta("Ooops!: Entre com o historico!"), FALSO ), OK )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Recemov->(Order( RECEMOV_CODI ))
	Receber->(Order( RECEBER_CODI ))
	IF Receber->(DbSeek( cCodi ))
		ErrorBeep()
		If Conf("Pergunta: Confirma inclusao?")
			lAlterar := FALSO
			lIncluir := OK
			IF !lAlterar
				IF !lIncluir
					Loop
				EndIF
			EndIF
			IF Receber->(TravaReg())
				Receber->ProxCob := dData
				Receber->(Libera())
				Agenda->(Order( AGENDA_CODI ))
				While Agenda->Codi = cCodi
					IF Agenda->(TravaReg())
						Agenda->Ultimo := FALSO
						Agenda->(Libera())
						Agenda->(DbSkip(1))
					EndIF
				EndDo
				IF Agenda->(Incluiu())
					Agenda->Codi	 := cCodi
					Agenda->Data	 := dData
               Agenda->Hora    := Time()
					Agenda->Hist	 := cObs
					Agenda->Caixa	 := cCodiVen
					Agenda->Usuario := oAmbiente:xUsuario
					Agenda->Ultimo  := OK
					Agenda->(Libera())
					IF !Empty( dDataPro ) .AND. Agenda->(Incluiu())
						Agenda->Codi	 := cCodi
						Agenda->Data	 := dDataPro
                  Agenda->Hora    := Time()
						Agenda->Hist	 := cObs1
						Agenda->Caixa	 := cCodiVen
						Agenda->Usuario := oAmbiente:xUsuario
						Agenda->Ultimo  := OK
						Agenda->(Libera())
					EndIF
					IF Recemov->(DbSeek( cCodi ))
						While Recemov->Codi = cCodi
							IF Recemov->(TravaReg())
								Recemov->Cobrador := cCodiVen
								Recemov->(Libera())
							EndIF
							Recemov->(DbSkip(1))
						EndDo
					EndIf
				EndIf
			EndIf
		EndIf
	EndIf
EndDo

Proc AnexarAgendaAntiga()
*************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL dCalculo := Date()
LOCAL cString	:= ""
LOCAL cCodi
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aTodos
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
LOCAL oAgenda

ErrorBeep()
IF !Conf("Pergunta: Tem absoluta certeza?")
	Return
EndIF
oMenu:Limpa()
cCodi 	:= Space(05)
dIni		:= Date()-30
dFim		:= Date()
dCalculo := Date()
aTodos	:= {}
aCodi 	:= {}
nConta	:= 0
cTela 	:= Mensagem("Aguarde. Anexando registros da agenda velha.")
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())
While Receber->(!Eof())
	cCodi   := Receber->Codi
	oAgenda := TIniNew( oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI')
	dAtual  := cTod('//')
	nConta := oAgenda:ReadInteger( cCodi, 'soma', 0 )
	For nV = 1 To nConta
		cHist := oAgenda:ReadString( cCodi, StrZero(nV,2), Repl('_',40), 1)
		dData := oAgenda:ReadDate(   cCodi, StrZero(nV,2), cTod('//'), 2)
		IF Agenda->(Incluiu())
			Agenda->Codi	 := cCodi
			Agenda->Data	 := dData
			Agenda->Hist	 := cHist
			Agenda->Ultimo  := FALSO
			Agenda->(Libera())
			Loop
		EndIF
	Next
	oAgenda:Close()
	Receber->(DbSkip(1))
EndDo
ResTela( cTela )

Proc AnexarLogRecibo()
**********************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFileLog := "RECIBO.LOG"
LOCAL xLog		:= "RECIBO.TXT"
LOCAL xLixo 	:= "LIXO.TXT"
LOCAL nErro 	:= 0
LOCAL aRecibo	:= {}
LOCAL Handle
LOCAL nNew
LOCAL nLixo

ErrorBeep()
IF !Conf("Pergunta: Tem absoluta certeza?")
	Return
EndIF
oMenu:Limpa()
cTela := Mensagem("FASE #1: Aguarde. Anexando registros do log.")
IF !File( cFileLog )
	oMenu:Limpa()
	ErrorBeep()
	Alert("Erro: Arquivos de Log nao disponiveis.;" + ;
				"Verifique os arquivos com extensao .LOG.")
	ResTela( cScreen )
	Return
EndIF
Handle := Fopen( cFileLog )
IF ( Ferror() != 0 )
	ErroConfiguracaoArquivo( Handle, "Abertura do Arquivo", cFileLog )
	ResTela( cScreen )
	Return
EndIF

IF !File( xLog )
	nNew := Fcreate( xLog, FC_NORMAL )
	FClose( nNew )
EndIF
nNew := FOpen( xLog, FO_READWRITE + FO_SHARED )
IF ( Ferror() != 0 ) // Erro
	Return
EndIF

IF !File( xLixo )
	nLixo := Fcreate( xLixo, FC_NORMAL )
	FClose( nLixo )
EndIF
nLixo := FOpen( xLixo, FO_READWRITE + FO_SHARED )
IF ( Ferror() != 0 ) // Erro
	Return
EndIF

nCount := FLineCount(Handle)
nSoma  := 0
Alerta("Registros no Log: " + Str(nCount))
While !Feof( Handle )
	cLinha := FReadLine( Handle )
	IF Left( cLinha, 6) = "BAIXAS" .OR. Left( cLinha, 6) = "RECIBO"
		FWriteLine( nNew, cLinha )
	Else
		FWriteLine( nLixo, cLinha )
	EndIF
	Mensagem("Reg: " + Str(++nSoma))
EndDo
Close( Handle )
Close( nNew )
Close( nLixo )

// Fase 2

xLog := "RECIBO.TXT"
IF !File( xLog )
	Handle := Fcreate( xLog, FC_NORMAL )
	FClose( Handle )
EndIF
Handle := FOpen( xLog, FO_READWRITE + FO_SHARED )
IF ( Ferror() != 0 ) // Erro
	Return
EndIF
cTela := Mensagem("FASE #2: Aguarde. Anexando registros no banco de dados.")
Receber->(Order( RECEBER_CODI ))
Recebido->(Order( RECEBIDO_DOCNR ))
Area("RECIBO")
nSoma := 0
While nSoma <= 2285 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )
	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cDocnr	:= SubStr( cLinha,14,9)
	cHora 	:= SubStr( cLinha,24,8)
	dData 	:= cTod(SubStr( cLinha,33,8))
	cUsuario := SubStr( cLinha,42,10)
	cCaixa	:= SubStr( cLinha,53,04)
	nVlr		:= Val( SubStr(cLinha,58,18))
	cHist 	:= SubStr( cLinha,77,80)

	cNome 	:= Space(0)
	IF Receber->(DbSeek( cCodi ))
		cNome := Receber->Nome
	EndIF

	dVcto 	:= cTod("//")
	IF Recebido->(DbSeek( cDocnr ))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "Q"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "R"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "P"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	EndIF

	IF Recibo->(Incluiu())
		Recibo->Nome	 := cNome
		Recibo->Vcto	 := dVcto

		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
		Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF
	nSoma++
EndDo

// Fase 3

cTela := Mensagem("FASE #3: Aguarde. Anexando registros no banco de dados.")
While nSoma <= 9621 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )

	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cNome 	:= SubStr( cLinha,14,40)
	cDocnr	:= SubStr( cLinha,55,9)
	cHora 	:= SubStr( cLinha,65,8)
	dData 	:= cTod(SubStr( cLinha,74,8))
	cUsuario := SubStr( cLinha,83,10)
	cCaixa	:= SubStr( cLinha,94,04)
	nVlr		:= Val( SubStr(cLinha,99,18))
	cHist 	:= SubStr( cLinha,118,80)

	dVcto 	:= cTod("//")
	IF Recebido->(DbSeek( cDocnr ))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "Q"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "R"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	ElseIF Recebido->(DbSeek( "P"+ Right(cDocnr,8)))
		dVcto := Recebido->Vcto
	EndIF

	IF Recibo->(Incluiu())
		Recibo->Vcto	 := dVcto
		Recibo->Nome	 := cNome
		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
      Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF
	nSoma++
EndDo

// Fase 4

cTela := Mensagem("FASE #4: Aguarde. Anexando registros no banco de dados.")
While nSoma > 9621 .AND. !FEof( Handle )
	cLinha	:= FReadLine( Handle )
	cTipo 	:= Left( cLinha,6)
	cCodi 	:= SubStr( cLinha,08,5)
	cNome 	:= SubStr( cLinha,14,40)
	cDocnr	:= SubStr( cLinha,55,9)
	dVcto 	:= cTod(SubStr( cLinha,65,8))
	cHora 	:= SubStr( cLinha,74,8)
	dData 	:= cTod(SubStr( cLinha,83,8))
	cUsuario := SubStr( cLinha,92,10)
	cCaixa	:= SubStr( cLinha,103,04)
	nVlr		:= Val( SubStr(cLinha,108,18))
	cHist 	:= SubStr( cLinha,127,60)

	IF Recibo->(Incluiu())
		Recibo->Vcto	 := dVcto
		Recibo->Nome	 := cNome
		Recibo->Tipo	 := cTipo
		Recibo->Codi	 := cCodi
		Recibo->Docnr	 := cDocnr
		Recibo->Hora	 := cHora
		Recibo->Data	 := dData
		Recibo->Usuario := cUsuario
		Recibo->Caixa	 := cCaixa
		Recibo->Vlr 	 := nVlr
		Recibo->Hist	 := cHist
		Recibo->(Libera())
	EndIF
	nSoma++
EndDo
Close( Handle )

Proc BidoToRecibo()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()

ErrorBeep()
IF !Conf("Pergunta: Tem absoluta certeza?")
	Return
EndIF
oMenu:Limpa()
cTela := Mensagem("FASE #1: Aguarde. Anexando registros do log.")

Vendedor->(Order( VENDEDOR_CODIVEN ))
Receber->(Order( RECEBER_CODI ))
Recibo->(Order( RECIBO_DOCNR ))
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGotop())
While Recebido->(!Eof())
   IF Recibo->(DbSeek( Recebido->Docnr ))
      Recebido->(DbSkip(1))
      Loop
   EndIF
	IF Recibo->(Incluiu())
      Receber->(DbSeek( Recebido->Codi ))
      Recibo->Nome    := Receber->Nome
      Recibo->Codi    := Recebido->Codi
      Recibo->Vcto    := Recebido->Vcto
      Recibo->Tipo    := "RECIBO"
      Recibo->Docnr   := Recebido->Docnr
      Recibo->Hora    := Time()
      Recibo->Data    := Recebido->DataPag
      IF Vendedor->(DbSeek( Recebido->Caixa ))
         Recibo->Usuario := Left(Vendedor->Nome, 10)
      EndIF
      Recibo->Caixa   := Recebido->Caixa
      Recibo->Vlr     := Recebido->VlrPag
      Recibo->Hist    := Recebido->Obs
		Recibo->(Libera())
	EndIF
   Recebido->(DbSkip(1))
EndDo
Return

Proc JuroComposto()
*******************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nJuro 	:= 0
LOCAL nJuroDia := 0
LOCAL cCodi 	:= Space(05)
LOCAL dData 	:= Date()
LOCAL nAtraso	:= 0
LOCAL nAtraso1 := 0
LOCAL nJuros	:= 0
LOCAL nBase 	:= 31
LOCAL nTotJr	:= 0
LOCAL nX 		:= 0

Set Deci To 5
MaBox( 10, 05, 14, 78 )
@ 11, 06 Say "Cliente...............:" GET cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
@ 12, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99"
@ 13, 06 Say "Calcular ate o dia....:" Get dData Pict "##/##/##"
Read
IF LastKey() = ESC
   Set Deci To 2
	ResTela( cScreen )
	Return
EndIF
IF Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
	Recemov->(Order( RECEMOV_CODI ))
	IF Recemov->(DbSeek( cCodi ))
		Mensagem("Informa: Aguarde. Atualizando.", Cor())
		IF Recemov->(TravaArq())
			WHILE Recemov->Codi = cCodi
            nTipo     := 6 // Tx Efetiva Juros Anual
            nAtraso   := dData - Recemov->Vcto
            nTxJuros  := TxEfetiva( nJuro, Recemov->Vcto, dData, nTipo )
            nCapital  := Recemov->Vlr
            nMontante := nCapital * nTxJuros
            nJuros    := nMontante - nCapital
            Recemov->Juro      := nTxJuros
            Recemov->JuroTotal := nJuros
            Recemov->JuroDia   := ( nJuros / nAtraso )
				Recemov->(DbSkip(1))
			EndDo
		EndIF
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	EndIF
EndIF
Set Deci To 2

Function TxEfetiva( nJuroMes, dVcto, dAtual, nTipo )
****************************************************
LOCAL nPeriodo
LOCAL nTxJuros
IfNil( nTipo,   1 )

nAtraso       := (dAtual - dVcto)
nPeriodo      := nAtraso / (IF(lAnoBissexto(dAtual), 366, 365))
IF nTipo = 1     //Anual
   nTxEfetiva := (((1 + nJuroMes/100)^12)-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nPeriodo)
ElseIF nTipo = 2 // Semestral
   nTxEfetiva := (((1 + nJuroMes/100)^6)-1)*100
ElseIF nTipo = 3 // Trimestral
   nTxEfetiva := (((1 + nJuroMes/100)^3)-1)*100
ElseIF nTipo = 4 // Bimestral
   nTxEfetiva := (((1 + nJuroMes/100)^2)-1)*100
ElseIF nTipo = 5 // Semanal
   nTxEfetiva := (((1 + nJuroMes/100)^(7/30))-1)*100
ElseIF nTipo = 6 // Diaria
   nTxEfetiva := (((1 + nJuroMes/100)^(1/30))-1)*100
   nTxJuros   := ((1 + nTxEfetiva/100)^nAtraso)
EndIF
Return( nTxJuros )

/*
Qout("Tx Efetiva Anual  :", nTxAnoEfetiva )
Qout("Tx Efetiva Diaria :", nTxDiaEfetiva )
Qout("Dias              :", nDias )
Qout("Periodo de Dias   :", nPeriodo )
Qout("Capital           :", nValor)
Qout("Taxa de Juros     :", nTxJuros )
Qout("Juros             :", nJuros )
Qout("Montante          :", nValor * nTxJuros )
Qout("===========================================")
nTxJuros      := ((1 + nTxDiaEfetiva/100)^nAtraso)
Qout("Capital           :", nValor)
//Qout("Juros             :", nJuros )
Qout("Montante          :", nValor * nTxJuros )
*/


*:---------------------------------------------------------------------------------------------------------------------------------

/*
IF Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
	Recemov->(Order( RECEMOV_CODI ))
	IF Recemov->(DbSeek( cCodi ))
		Mensagem("Informa: Aguarde. Atualizando.", Cor())
		IF Recemov->(TravaArq())
			WHILE Recemov->Codi = cCodi
				nAtraso	:= dData - Recemov->Vcto
				nAtraso1 := dData - Recemov->Vcto
				nValor	:= Recemov->Vlr
				nJurodia := ((nValor * nJuro) / 100 ) / 30
				nJuros	:= 0
				nBase 	:= 31
				nTotJr	:= 0
				nX 		:= 0
				For nX := 1 To nAtraso
					IF nX = nBase
						nAtraso	-= 30
						nX 		:= 0
						nValor	+= nJuros
						nJuros	:= 0
						nJurodia := ((nValor * nJuro ) / 100 ) / 30
						Loop
					EndIF
					nTotJr += nJuroDia
				Next
				Recemov->JuroDia := ( nTotJr / nAtraso1 )
				Recemov->Juro	  := nTotJr
				Recemov->(DbSkip(1))
			EndDo
		EndIF
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	EndIF
EndIF
*/

Proc MenuTxJuros( nChoice )
***************************
LOCAL GetList  := {}
LOCAL cScreen  := SaveScreen()
LOCAL aMenu1   := {'Geral','Individual'}
LOCAL aMenu2   := {'Juros Simples','Juros Composto','Juros Capitalizado','Juros Sobre Juro'}
LOCAL nChoice1 := 0
LOCAL nChoice2 := 0

WHILE OK
	oMenu:Limpa()
   IF nChoice = NIL
      M_Title("ESCOLHA ALCANCE" )
      nChoice1 := FazMenu( 02, 05, aMenu1 )
      IF nChoice1 = 0
         ResTela( cScreen )
         Exit
      Else
         IF nChoice1 = 1
            nChoice = 3.03
         ElseIF nChoice1 = 2
            nChoice = 3.04
         EndIF
      EndIF
   EndIF
   WHILE OK
      M_Title("ESCOLHA TIPO DE CALCULO" )
      nChoice2  := FazMenu( 04, 05, aMenu2 )
      IF nChoice2 = 0
         Restela( cScreen)
         Exit
      EndIF
      Do Case
      Case nChoice2 = 0
         ResTela( cScreen )
         Exit

      Case nChoice = 3.03 .AND. nChoice2 = 1    // Simples Geral
         AltJrGeral(1, oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES])

      Case nChoice = 3.03 .AND. nChoice2 >= 2   // Composto Geral
         AltJrGeral(2, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])

      Case nChoice = 3.04 .AND. nChoice2 = 1    // Simples Individual
         AltJrInd(1, oAmbiente:aSciArray[1,SCI_JUROMESSIMPLES])

      Case nChoice = 3.04 .AND. nChoice2 >= 2   // Composto Individual
         AltJrInd(2, oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO])
     EndCase
   EndDo
   IF LastKey() = ESC
      Exit
   EndIF
EndDo

Function AltJrInd( nChoice, nJuro, xCodi, lMsg)
***********************************************
LOCAL GetList    := {}
LOCAL cScreen    := SaveScreen()
LOCAL nJuroDia   := 0
LOCAL nValorCm   := 0
LOCAL nVlr       := 0
LOCAL nCm        := 0
LOCAL nJuroTotal := 0
LOCAL dVcto      := Date()
LOCAL dData      := Date()
LOCAL cCodi      := Space(05)
LOCAL aJuro      := {}
LOCAL lResult

IF xCodi = NIL
   MaBox( 12, 05, 16, 78 )
   @ 13, 06 Say "Cliente...............:" GET cCodi PICT PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
   @ 14, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99"
   @ 15, 06 Say "Atualizar ate Data....:" Get dData Pict "##/##/##"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
Else
   cCodi := xCodi
	if nJuro = nil
      nJuro := oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO]
	endif	
   dData := oReceposi:dCalculo
	if nJuro <= 0 .OR. nJuro == NIL
		nJuro := 1
	   MaBox( 13, 05, 15, 78 )
	   @ 14, 06 Say "Taxa de Juros ao Mes..:" Get nJuro Pict "999.99" Valid nJuro > 0
		Read
		if LastKey() = ESC
			ResTela( cScreen )		
			return( lResult := FALSO )
		endif
		oini:WriteInteger( 'financeiro', 'JuroMesComposto', nJuro )
	   oAmbiente:aSciArray[1,SCI_JUROMESCOMPOSTO] := nJuro
		lMsg    := OK
		lResult := OK
	endif
EndIF

IF lMsg = NIL
   lResult := Conf("Pergunta: Confirma atualizacao da taxa de juro ?")
Else
   lResult := OK
EndIF
IF lResult
	Recemov->(Order( RECEMOV_CODI ))
	IF Recemov->(DbSeek( cCodi ))
      IF lMsg = NIL
         Mensagem("Informa: Aguarde. Atualizando.")
      EndIF
		IF Recemov->(TravaArq())
         WHILE Recemov->Codi = cCodi .AND. LastKey() != ESC
            IF lMsg = NIL
               Mensagem("INFO: Aguarde. Atualizando Taxas de Juros # " + Recemov->(Barra()))
            EndIF
            IF nJuro <> 0
               dVcto              := Recemov->Vcto
               nVlr               := Recemov->Vlr
               nDias              := (dData-dVcto)
               nValorCm           := CalculaCm(nVlr, dVcto, dData)
               nCm                := (nValorCm - nVlr)
               IF nChoice = 1
                  nJuroDia        := JuroDia( nValorCm, nJuro, XJURODIARIO)
                  nJuroTotal      := (nJuroDia * nDias)
                  nJuroTotal      += nCm
                  nJuroDia        := (nJuroTotal / nDias)
               Else
                  aJuro           := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
                  nJuroDia        := aJuro[6]
                  nJuroTotal      := aJuro[5]
                  nJuroTotal      += nCm
                  nJuroDia        := (nJuroTotal / nDias)
               EndIF
               Recemov->Juro      := nJuro
               Recemov->JuroDia   := nJuroDia
               Recemov->JuroTotal := nJuroTotal
            Else
               Recemov->Juro      := 0
               Recemov->JuroDia   := 0
               Recemov->JuroTotal := 0
            EndIF
            Recemov->(DbSkip(1))
            IF LastKey() = ESC
               IF Conf("Pergunta: Cancelar?")
                  Exit
               EndIF
            EndIF
         EndDo
		EndIF
		Recemov->(Libera())
		ResTela( cScreen )
      IF lMsg = NIL
         ErrorBeep()
         Alerta("Informa: Taxas Atualizadas.")
      EndIF
	EndIF
EndIF
Return lResult

*:---------------------------------------------------------------------------------------------------------------------------------

Proc AltJrGeral(nChoice, nJuro)
*******************************
LOCAL GetList    := {}
LOCAL aJuro      := {}
LOCAL cScreen    := SaveScreen()
LOCAL nJuroDia   := 0
LOCAL nJuroTotal := 0
LOCAL nValorCm   := 0
LOCAL nCm        := 0
LOCAL nVcto      := 0
LOCAL dData      := Date()
LOCAL nDias      := 0

MaBox( 12, 05, 15, 54 )
@ 13, 06 Say "Entre com a Taxa de Juros...:" Get nJuro Pict "999.99"
@ 14, 06 Say "Atualizar ate Data..........:" Get dData Pict "##/##/##"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF Conf("Pergunta: Confirma atualizacao geral da taxa de juro ?")
   oMenu:Limpa()
   Mensagem("Informa: Aguarde. Atualizando.")
	IF Recemov->(TravaArq())
      Recemov->(Order(0))
      Recemov->(DbGoTop())
      WHILE Recemov->(!Eof()) .AND. LastKey() != ESC
         Mensagem("INFO: Aguarde. Atualizando Taxas de Juros # " + Recemov->(Barra()))
         IF nJuro <> 0
            dVcto              := Recemov->Vcto
            nVlr               := Recemov->Vlr
            nDias              := (dData-dVcto)
            nValorCm           := CalculaCm(nVlr, dVcto, dData)
            nCm                := (nValorCm - nVlr)
            IF nChoice = 1
               nJuroDia        := JuroDia( nValorCm, nJuro, XJURODIARIO)
               nJuroTotal      := (nJuroDia * nDias)
               nJuroTotal      += nCm
               nJuroDia        := (nJuroTotal / nDias)
            Else
               aJuro           := aAntComposto( nValorCm, nJuro, nDias, XJURODIARIO)
               nJuroDia        := aJuro[6]
               nJuroTotal      := aJuro[5]
               nJuroTotal      += nCm
               nJuroDia        := (nJuroTotal / nDias)
            EndIF
            Recemov->Juro      := nJuro
            Recemov->JuroDia   := nJuroDia
            Recemov->JuroTotal := nJuroTotal
         Else
            Recemov->Juro      := 0
            Recemov->JuroDia   := 0
            Recemov->JuroTotal := 0
         EndIF
			Recemov->(DbSkip(1))
         IF LastKey() = ESC
            IF Conf("Pergunta: Cancelar?")
               Exit
            EndIF
         EndIF
		EndDo
		Recemov->(Libera())
		ResTela( cScreen )
		ErrorBeep()
		Alerta("Informa: Taxas Atualizadas.")
	EndIF
EndIF

*:---------------------------------------------------------------------------------------------------------------------------------

Function BidoGrafico(nOp)
*************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Por Cliente","Mensal Por Ano", "Ultimos 12 anos"}
LOCAL cScreen1
LOCAL nChoice

WHILE OK
	DbClearFilter()
	DbGoTop()
   M_Title("GRAFICO DE CONTAS RECEBIDAS" )
   nChoice  := FazMenu( 06, 10, aMenu )
	cScreen1 := SaveScreen()
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
      cCodi := Space( 05 )
      WHILE OK
         Area("Receber")
         Receber->(Order( RECEBER_CODI ))
         MaBox( 13, 10, 15, 78 )
         @ 14, 11 Say "Cliente...: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
         Read
         IF LastKey() = ESC
            ResTela( cScreen1 )
            Exit
         EndIF
         GrafBidoCodigo(cCodi, nOp)
         ResTela(cScreen1)
      BEGOUT

	Case nChoice = 2
      GrafBidoGeral(nOp)
      ResTela(cScreen1)
		
	Case nChoice = 3
      GrafBidoAnual(nOp)
      ResTela(cScreen1)		

	EndCase
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc GrafBidoCodigo(cCodi, nOp)
*******************************
LOCAL cScreen  := SaveScreen()
LOCAL nBase    := 1
LOCAL nAnual   := 0
LOCAL lFiltrar := FALSO
LOCAL m[12,2]
LOCAL n[12,2]
LOCAL aDataIni
LOCAL aDataFim
LOCAL nConta
LOCAL cValor
PRIVA cAno     := Space(02)

MaBox( 16, 10, 18, 45 )
@ 17, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
IF LastKey() = ESC
	Restela( cScreen )
	Return
EndIF

oMenu:Limpa()
IF     nOp = 7.07
   oAmbiente:cTipoRecibo := "RECCAR"
   lFiltrar := OK
ElseIF nOp = 7.08
   oAmbiente:cTipoRecibo := "RECBCO"
   lFiltrar := OK
ElseIF nOp = 7.09
   oAmbiente:cTipoRecibo := "RECOUT"
   lFiltrar := OK
Else
   lFiltrar := FALSO
EndIF

aDataIni := { Ctod( "01/01/" + cAno ),;
		  Ctod( "01/02/" + cAno ),;
		  Ctod( "01/03/" + cAno ),;
		  Ctod( "01/04/" + cAno ),;
		  Ctod( "01/05/" + cAno ),;
		  Ctod( "01/06/" + cAno ),;
		  Ctod( "01/07/" + cAno ),;
		  Ctod( "01/08/" + cAno ),;
		  Ctod( "01/09/" + cAno ),;
		  Ctod( "01/10/" + cAno ),;
		  Ctod( "01/11/" + cAno ),;
		  Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ),;
        IF( lAnoBissexto(cTod("28/02/" + cAno )), cTod("29/02/" + cAno ), cTod("28/02/" + cAno )),;
		  Ctod( "31/03/" + cAno ),;
		  Ctod( "30/04/" + cAno ),;
		  Ctod( "31/05/" + cAno ),;
		  Ctod( "30/06/" + cAno ),;
		  Ctod( "31/07/" + cAno ),;
		  Ctod( "31/08/" + cAno ),;
		  Ctod( "30/09/" + cAno ),;
		  Ctod( "31/10/" + cAno ),;
		  Ctod( "30/11/" + cAno ),;
		  Ctod( "31/12/" + cAno )}

Area("Recebido")
Recebido->(Order( RECEBIDO_CODI ))
Recebido->(Sx_SetScope( S_TOP, cCodi))
Recebido->(Sx_SetScope( S_BOTTOM, cCodi ))
Recebido->(DbGoTop())
Mensagem( "INFO: Aguarde, calculando valores.", Cor())

For nX := 1 To 12
   m[nX,1] := 0
   Sum Recebido->VlrPag To M[nX,1] For Recebido->DataPag >= aDataIni[nX] .AND. Recebido->DataPag <= aDataFim[nX]
   nAnual += m[nX,1]
Next
Recebido->(Sx_ClrScope( S_TOP ))
Recebido->(Sx_ClrScope( S_BOTTOM ))
Recebido->(DbGoTop())

Area("Recibo")
Recibo->(Order( RECIBO_CODI ))
Recibo->(Sx_SetScope( S_TOP, cCodi))
Recibo->(Sx_SetScope( S_BOTTOM, cCodi ))
Recibo->(DbGotop())
For nX := 1 To 12
   n[nX,1] := 0
   IF lFiltrar
      Sum Recibo->Vlr To n[nX,1] For Recibo->Data >= aDataIni[nX] .AND. Recibo->Data <= aDataFim[nX] .AND. Recibo->Tipo = oAmbiente:cTipoRecibo
   Else
      Sum Recibo->Vlr To n[nX,1] For Recibo->Data >= aDataIni[nX] .AND. Recibo->Data <= aDataFim[nX]
   EndIF
   m[nX,1] += n[nX,1]
   nAnual += n[nX,1]
Next
Recibo->(Sx_ClrScope( S_TOP ))
Recibo->(Sx_ClrScope( S_BOTTOM ))
Recibo->(DbGoTop())

SetColor("")
Cls
M[1,2]="JAN"
M[2,2]="FEV"
M[3,2]="MAR"
M[4,2]="ABR"
M[5,2]="MAI"
M[6,2]="JUN"
M[7,2]="JUL"
M[8,2]="AGO"
M[9,2]="SET"
M[10,2]="OUT"
M[11,2]="NOV"
M[12,2]="DEZ"

cNome  := Receber->( AllTrim( Nome ) )
cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
Grafico( M,.T.,"EVOLUCAO MENSAL DE TITULOS RECEBIDOS - &cNome.", cValor,;
              AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
ResTela( cScreen )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Function GrafBidoGeral(nOp)
***************************
LOCAL cScreen := SaveScreen()
LOCAL nBase   := 1
LOCAL nAnual  := 0
LOCAL lFiltrar := FALSO
LOCAL aDataIni
LOCAL aDataFim
LOCAL dIni
LOCAL dFim
LOCAL nConta
LOCAL m[12,2]
LOCAL n[12,2]
LOCAL cValor
PRIVA cAno	  := Space(02)

MaBox( 13, 10, 15, 45 )
@ 14, 11 Say "Entre o ano para Grafico...:" Get cAno Pict "99"
Read
IF LastKey() = ESC
	Restela( cScreen )
	Return NIL
EndIF

IF     nOp = 7.07
   oAmbiente:cTipoRecibo := "RECCAR"
   lFiltrar := OK
ElseIF nOp = 7.08
   oAmbiente:cTipoRecibo := "RECBCO"
   lFiltrar := OK
ElseIF nOp = 7.09
   oAmbiente:cTipoRecibo := "RECOUT"
   lFiltrar := OK
Else
   lFiltrar := FALSO
EndIF
aDataIni := { Ctod( "01/01/" + cAno ),;
			Ctod( "01/02/" + cAno ),;
			Ctod( "01/03/" + cAno ),;
			Ctod( "01/04/" + cAno ),;
			Ctod( "01/05/" + cAno ),;
			Ctod( "01/06/" + cAno ),;
			Ctod( "01/07/" + cAno ),;
			Ctod( "01/08/" + cAno ),;
			Ctod( "01/09/" + cAno ),;
			Ctod( "01/10/" + cAno ),;
			Ctod( "01/11/" + cAno ),;
			Ctod( "01/12/" + cAno )}

aDataFim := { Ctod( "31/01/" + cAno ),;
              IF( lAnoBissexto(cTod("28/02/" + cAno )), cTod("29/02/" + cAno ), cTod("28/02/" + cAno )),;
				  Ctod( "31/03/" + cAno ),;
				  Ctod( "30/04/" + cAno ),;
				  Ctod( "31/05/" + cAno ),;
				  Ctod( "30/06/" + cAno ),;
				  Ctod( "31/07/" + cAno ),;
				  Ctod( "31/08/" + cAno ),;
				  Ctod( "30/09/" + cAno ),;
				  Ctod( "31/10/" + cAno ),;
				  Ctod( "30/11/" + cAno ),;
				  Ctod( "31/12/" + cAno )}

/*
Area("Recebido")
Recebido->(Order( RECEBIDO_DATAPAG ))
Mensagem( "INFO: Aguarde, Calculando Valores.", Cor())
For nX := 1 To 12
   m[nX,1] := 0
	dIni	  := aDataIni[nX]
	dFim	  := aDataFim[nX]
	Sx_SetScope( S_TOP, dIni )
	Sx_SetScope( S_BOTTOM, dFim )
	Recebido->(DbGoTop())
	Sum Recebido->VlrPag To M[nX,1]
   nAnual += m[nX,1]
Next
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Recebido->(DbGotop())
*/

Area("Recibo")
Recibo->(Order( RECIBO_DATA ))
For nX := 1 To 12
   ContaReg()
   m[nX,1] := 0
   n[nX,1] := 0
	dIni	  := aDataIni[nX]
	dFim	  := aDataFim[nX]
   Recibo->(Sx_SetScope( S_TOP,    dIni))
   Recibo->(Sx_SetScope( S_BOTTOM, dFim ))
   Recibo->(DbGotop())
   IF lFiltrar
      IF nOp = 7.07
         Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo .OR. Recibo->Tipo = "RECIBO"
      Else
         Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo
      EndIF
   Else
      Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo <> "BAIXAS"
   EndIF
   m[nX,1] += n[nX,1]
   nAnual  += n[nX,1]
Next 
Recibo->(Sx_ClrScope( S_TOP ))
Recibo->(Sx_ClrScope( S_BOTTOM ))
Recibo->(DbGoTop())

SetColor("")
Cls

M[1,2]  := "JAN"
M[2,2]  := "FEV"
M[3,2]  := "MAR"
M[4,2]  := "ABR"
M[5,2]  := "MAI"
M[6,2]  := "JUN"
M[7,2]  := "JUL"
M[8,2]  := "AGO"
M[9,2]  := "SET"
M[10,2] := "OUT"
M[11,2] := "NOV"
M[12,2] := "DEZ"

cValor := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
Grafico( M,.T.,"EVOLUCAO MENSAL DE TITULOS RECEBIDO - &cAno.", cValor,;
                AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
ResTela( cScreen )
Return NIL

*:---------------------------------------------------------------------------------------------------------------------------------

Function GrafBidoAnual(nOp)
***************************
LOCAL cScreen := SaveScreen()
LOCAL nBase   := 1
LOCAL nAnual  := 0
LOCAL lFiltrar := FALSO
LOCAL aDataIni
LOCAL aDataFim
LOCAL dIni
LOCAL dFim
LOCAL nConta
LOCAL m[12,2]
LOCAL n[12,2]
LOCAL cValor
PRIVA cUltimo
PRIVA cAno	  := Tran(Year(Date()), "9999")

MaBox( 13, 10, 15, 58 )
@ 14, 11 Say "Entre com o ultimo ano para o Grafico...:" Get cAno Pict "9999"
Read
IF LastKey() = ESC
	Restela( cScreen )
	Return NIL
EndIF

IF     nOp = 7.07
   oAmbiente:cTipoRecibo := "RECCAR"
   lFiltrar := OK
ElseIF nOp = 7.08
   oAmbiente:cTipoRecibo := "RECBCO"
   lFiltrar := OK
ElseIF nOp = 7.09
   oAmbiente:cTipoRecibo := "RECOUT"
   lFiltrar := OK
Else
   lFiltrar := FALSO
EndIF
nAno := val( cAno )
aDataIni := { 	Ctod( "01/01/" + Tran( nAno-11, "9999")),;
					Ctod( "01/01/" + Tran( nAno-10, "9999")),;
					Ctod( "01/01/" + Tran( nAno-9,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-8,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-7,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-6,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-5,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-4,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-3,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-2,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-1,  "9999")),;
					Ctod( "01/01/" + Tran( nAno-0,  "9999"))}

aDataFim := { 	Ctod( "31/12/" + Tran( nAno-11, "9999")),;
					Ctod( "31/12/" + Tran( nAno-10, "9999")),;
					Ctod( "31/12/" + Tran( nAno-9,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-8,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-7,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-6,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-5,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-4,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-3,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-2,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-1,  "9999")),;
					Ctod( "31/12/" + Tran( nAno-0,  "9999"))}

Area("Recibo")
Recibo->(Order( RECIBO_DATA ))
Recibo->(Sx_ClrScope( S_TOP ))
Recibo->(Sx_ClrScope( S_BOTTOM ))
Recibo->(DbGoTop())
oAmbiente:nRegistrosImpressos := 0
Mensagem("Aguarde, Processando Registros...")
For nX := 1 To 12 
	m[nX,1] := 0
   n[nX,1] := 0
	dIni	  := aDataIni[nX]
	dFim	  := aDataFim[nX]
   Recibo->(Sx_SetScope( S_TOP,    dIni))
   Recibo->(Sx_SetScope( S_BOTTOM, dFim ))
   Recibo->(DbGotop())
   IF lFiltrar
      IF nOp = 7.07
         Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo .OR. Recibo->Tipo = "RECIBO" .AND. ContaReg()
      Else
         Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo = oAmbiente:cTipoRecibo .AND. ContaReg()
      EndIF
   Else
      Sum Recibo->Vlr To n[nX,1] For Recibo->Tipo <> "BAIXAS" .AND. ContaReg()
   EndIF
   m[nX,1] += n[nX,1]
   nAnual  += n[nX,1]
Next 
Recibo->(Sx_ClrScope( S_TOP ))
Recibo->(Sx_ClrScope( S_BOTTOM ))
Recibo->(DbGoTop())

SetColor("")
Cls

nAno := val( cAno )
M[1,2]  := Tran( nAno-11, "9999")
M[2,2]  := Tran( nAno-10, "9999")
M[3,2]  := Tran( nAno-9,  "9999")
M[4,2]  := Tran( nAno-8,  "9999")
M[5,2]  := Tran( nAno-7,  "9999")
M[6,2]  := Tran( nAno-6,  "9999")
M[7,2]  := Tran( nAno-5,  "9999")
M[8,2]  := Tran( nAno-4,  "9999")
M[9,2]  := Tran( nAno-3,  "9999")
M[10,2] := Tran( nAno-2,  "9999")
M[11,2] := Tran( nAno-1,  "9999")
M[12,2] := Tran( nAno-0,  "9999")

cUltimo := Tran( nAno-11,  "9999")
cValor  := "R$" + AllTrim(Tran( nAnual, "@E 9,999,999,999.99"))
Grafico( M,.T.,"EVOLUCAO MENSAL DE TITULOS RECEBIDO - &cUltimo. AT &cAno.", cValor, AllTrim(oAmbiente:xNomefir), nBase )
Inkey(0)
ResTela( cScreen )
Return NIL


*:---------------------------------------------------------------------------------------------------------------------------------

Function ReciboDbedit()
***********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()
Set Key -8 To

oMenu:Limpa()
Receber->(Order( RECEBER_CODI ))
Area("Recibo")
Recibo->(Order( NATURAL ))
Set Rela To Recibo->Codi Into Receber
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Recibo->(DbGoBottom())
oBrowse:Add( "ID",         "Id")
oBrowse:Add( "TIPO",       "Tipo")
oBrowse:Add( "CODI",       "Codi")
oBrowse:Add( "CLIENTE",    "Nome", NIL, "RECEBER")
oBrowse:Add( "DOCNR",      "Docnr")
oBrowse:Add( "VCTO",       "Vcto")
oBrowse:Add( "HORA",       "Hora")
oBrowse:Add( "DATA PGTO",  "Data")
oBrowse:Add( "VLR RECIBO", "Vlr")
oBrowse:Add( "CAIXA",      "Caixa")
oBrowse:Add( "USUARIO",    "Usuario")
oBrowse:Add( "HISTORICO",  "Hist")
oBrowse:Titulo   := "CONSULTA/ALTERACAO DE RECIBOS EMITIDOS"
oBrowse:HotKey( F3, {|| FiltraRecibo( oBrowse )})
oBrowse:HotKey( F4, {|| DuplicaRecibo( oBrowse )})
oBrowse:HotKey( F5, {|| FiltraSoma( oBrowse )})
oBrowse:HotKey( F7, {|| SomaRecibo( oBrowse )})
oBrowse:PreDoGet := {|| PreDoRecibo( oBrowse )}
oBrowse:PosDoGet := {|| PosDoRecibo( oBrowse )}
//oBrowse:PreDoDel := {|| HotPreCli( oBrowse )}
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Recibo->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:---------------------------------------------------------------------------------------------------------------------------------


Function PreDoRecibo( oBrowse )
*******************************
LOCAL oCol			  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant		  := Alias()
LOCAL Ind_Ant		  := IndexOrd()
LOCAL lUsuarioAdmin := oSci:ReadBool('permissao','usuarioadmin', FALSO )

IF !PodeAlterar()
	Return( FALSO)
EndIF

do case 
case oCol:Heading == "CLIENTE"
   ErrorBeep()
	Alerta( oCol:Heading + ";;Opa! Alteracao n„o permitida!;Altere o cadastro do cliente.")
	Return( FALSO )
case oCol:Heading == "DATA"
	IF !lUsuarioAdmin
		ErrorBeep()
		Alerta(oCol:Heading + ";;Opa! Nao pode alterar nao.")
		Return( FALSO )
	EndIF
endcase
return( PodeAlterar() )

*:---------------------------------------------------------------------------------------------------------------------------------

Function SomaRecibo( oBrowse )
******************************
LOCAL cScreen	:= SaveScreen()
LOCAL nConta   := 0

Mensagem("INFO: Aguarde, somando registros. ESC cancelar")
While !Eof() .AND. !Tecla_ESC()
   nConta += Recibo->Vlr
   Recibo->(DbSkip(1))
EndDo
ResTela( cScreen )
Alerta("Valor Recebido: R$ " + Alltrim(Tran( nConta, "@E 999,999,999,999.99")))
oBrowse:FreshOrder()
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function DuplicaRecibo( oBrowse )
*********************************
LOCAL cScreen := SaveScreen()
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := Recibo->(DbStruct())
LOCAL nConta  := Recibo->(FCount())
LOCAL cCodi
LOCAL xRegistro
LOCAL xRegLocal

ErrorBeep()
IF !Conf('Pergunta: Duplicar registro sob o cursor ?')
	Return( OK )
EndIF
xRegistro := Recibo->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
	xAlias->(FieldPut( nField, Recibo->(FieldGet( nField ))))
Next
IF Recibo->(Incluiu())
	For nField := 1 To nConta
		Recibo->(FieldPut( nField, xAlias->(FieldGet( nField ))))
	Next
	xRegLocal := Recibo->(Recno())
	Recibo->(Libera())
	Recibo->(Order( Ind_Ant ))
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
Receber->(DbGoto( xRegistro ))
oBrowse:FreshOrder()
Receber->(DbGoto( xRegistro ))
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function FiltraSoma( oBrowse )
******************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL dIni
LOCAL dFim
LOCAL nConta

WHILE OK
	oMenu:Limpa()
	MaBox( 14 , 19 , 17 , 43 )
	dIni	 := Date()-30
	dFim	 := Date()
	nConta := 0
	@ 15, 20 SAY "Data Inicial.:" Get dIni Pict "##/##/##"
	@ 16, 20 SAY "Data Fim.....:" Get dFim Pict "##/##/##"
	Read
	IF LastKey() = ESC
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Exit
	EndIF
	Recibo->(Order( RECIBO_DATA ))
	Sx_SetScope( S_TOP, dIni)
	Sx_SetScope( S_BOTTOM, dFim )
	Recibo->(DbGoTop())
	IF Sx_KeyCount() == 0
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Loop
	EndIF
   Mensagem("INFO: Aguarde, somando registros. ESC cancelar")
   While !Eof() .AND. !Tecla_ESC()
      nConta += Recibo->Vlr
      Recibo->(DbSkip(1))
   EndDo
   Exit
EndDo
ResTela( cScreen )
Recibo->(DbGotop())
oBrowse:FreshOrder()
Alerta("Valor Recebido: R$ " + Alltrim(Tran( nConta, "@E 999,999,999,999.99")))
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Function PosDoRecibo( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL cRegiao	 := Space(02)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Do Case
Case oCol:Heading == "REGIAO"
	cRegiao := Receber->Regiao
	RegiaoErrada( @cRegiao )
	Receber->Regiao := cRegiao
	AreaAnt( Arq_Ant, Ind_Ant )
EndCase
Recibo->Atualizado := Date()
Return( OK )

*:---------------------------------------------------------------------------------------------------------------------------------

Function FiltraRecibo( oBrowse )
********************************
   LOCAL cScreen := SaveScreen()
   LOCAL cProcura

   IF Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      Return(OK)
   EndIF
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
   cProcura := FieldGet(FieldPos( IndexKey()))
   IF cProcura = NIL
      cProcura := Space(40)
   EndIF
   @ 11, 11 Say "Filtrar por : " Get cProcura Pict "@K!"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return(OK)
   EndIF
   IF ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   EndIF
   Sx_SetScope( S_TOP, cProcura)
   Sx_SetScope( S_BOTTOM, cProcura )
	Recibo->(DbGoTop())
   Restela( cScreen )
   ResTela( cScreen )
   oBrowse:FreshOrder()
Return(OK)

*:==================================================================================================================================

Proc ExtratoImp( oBloco, lTribunal, dIni, dFim, dCalculo )
**********************************************************
LOCAL cScreen		 := SaveScreen()
LOCAL Tam			 := 132
LOCAL Col			 := 58
LOCAL Pagina		 := 0
LOCAL NovoCodi 	 := OK
LOCAL UltCodi		 := Codi
LOCAL o            := TExtratoImp():New()
DEFAU dCalculo TO Date()

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF

Recibo->(Order(RECIBO_DOCNR))
Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
FPrint( NG )
SetPrc( 0, 0 )
While Eval( oBloco ) .AND. !Eof() .AND. Rel_Ok() 
	if Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
		IF Col >=  58
			Col := 0
			Write( Col , 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), (Tam / 2)) + Padl( Dtoc(Date()) + ' - ' + Time(), (Tam / 2 )))
			if lTribunal
				Write( ++Col, 00, Repl( SEP, Tam ) )
			else
				Write( ++Col, 00, Padc( AllTrim(oAmbiente:xNomefir), Tam ) )
				Write( ++Col, 00, Padc( SISTEM_NA3, Tam ) )
			endif
			if lTribunal
				Write( ++Col, 00, Padc( "RELATORIO DE CONTA JUDICIAL E CALCULO DA CORRECAO - TABELA TJ/RO", Tam ) )
			else	
				Write( ++Col, 00, Padc( "EXTRATO DE CONTA", Tam ) )
			endif	
			Write( ++Col, 00, Repl( SEP, Tam ) )
			Write( ++Col, 00, "CLIENTE....: " + Codi + " " + Receber->Nome )
			Write( ++Col, 00, "ENDERECO...: " + Receber->Ende + " " + Receber->Bair )
			Write( ++Col, 00, "CIDADE.....: " + Receber->Cep + "/"+ Receber->Cida + " " + "ESTADO..: " + Receber->Esta + Space( 07 ) + "REGIAO..: " + Receber->Regiao )
			Write( ++Col, 00, Repl( SEP, Tam ))		
			if lTribunal
				Write( ++Col, 00, "                              DATA     VALOR    DATA    INICIO        VALOR  DIAS                CORRIGIDO       VALOR         TOTAL")
				Write( ++Col, 00, "TITULO #  TIPO   EMISSAO   INICIAL   INICIAL    FINAL    JUROS    CORRIGIDO JUROS       JUROS      + JUROS    MULTA(2.0%)     +MULTA")
			else
				Write( ++Col, 00,"TITULO #  TIPO   EMISSAO  VENCTO   DESCRICAO                                 PRINCIPAL ATRA DATA_PAG      VLR_PAGO VLR_ATUALIZADO")
			endif
			Write( ++Col, 00, Repl( SEP, Tam ))
		EndIF
		if NovoCodi
		   NovoCodi := FALSO
			o:Zerar()
		EndIF	
		o:nVlr     := Recemov->Vlr
		o:dVcto    := Recemov->Vcto
		o:nJurodia := Recemov->Jurodia
		o:dCalculo := dCalculo
		o:CalculaPorraToda()		//o:nVlr, o:dCalculo, o:dVcto, o:nJurodia)
		if lTribunal
			if !Recibo->(DbSeek( Recemov->Docnr ))
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc( o:dVcto ), Tran( o:nVlr, "@E 99,999.99"), o:dCalculo, o:dCalculo, Tran( o:nVlrCorrigido, "@E 9,999,999.99"), Tran(o:nAtraso, "9999"), Tran( o:nSoJuros, "@E 9,999,999.99"), Tran( o:nVlrCorrigido + o:nSoJuros, "@E 9,999,999.99"), Tran( o:nMulta, "@E 9,999,999.99"), Tran( O:nVlrCorrigido + o:nSoJuros + o:nMulta, "@E 9,999,999.99")) 
				o:ContaTribunal()
				Col++
			endif	
		else	
			if Recibo->(DbSeek( Recemov->Docnr ))
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc(o:dVcto), Left(Field->Obs, 40), Tran( o:nVlr, "@E 999,999.99"), Tran(Recibo->Data - o:dVcto, "9999"), Recibo->Data, Recibo->Vlr )
				o:ContaRecibo()				
				Col++
			else
				Qout( Field->Docnr, Field->Tipo, Dtoc(Field->Emis), Dtoc(o:dVcto), Left(Field->Obs, 40), Tran( o:nVlr, "@E 999,999.99"), Tran(o:nAtraso, "9999"), space(5), "NC", space(10), "NC", Tran( o:nSoma, "@E 9,999,999.99")) 
				If Recemov->Vcto <= dCalculo // vencido
				   o:ContaVencido()					
				else
				   o:ContaVencer()					
				endif	
				Col++
			endif
		endif	
	endif	
	UltCodi := Field->Codi		
	Recemov->(DbSkip(1))
	IF Col >= 54 .OR. UltCodi != Field->Codi
		Qout(Repl( SEP, Tam ))
		if lTribunal
			Qout("TOTAIS          ¯¯ {" + StrZero(o:nRegTribunal, 5) + "}", Space(7), Tran(o:nVlrPrincipalTribunal, "@E 99,999.99"), Space(17), Tran( o:nVlrCorrigidoTotal, "@E 9,999,999.99"),;
					Space(4), Tran( o:nSoJurosTotal, "@E 9,999,999.99"), Tran( o:nVlrCorrigidoMaisnSoJuros, "@E 9,999,999.99"), Tran( o:nMultaTotal, "@E 9,999,999.99"), Tran( o:nTotalGeral, "@E 9,999,999.99")) 
		else	
			Qout(NG + "RECIBO EMITIDO  ¯¯ {" + StrZero(o:nRegRecibo,  5) + "}", space(46), Tran( o:nVlrPrincipalRecibo,  "@E 9,999,999.99" ), space(14), Tran( o:nTotalRecibo, "@E 9,999,999.99" ) + NR)
			Qout(NG + "VENCIDO ABERTO  ¯¯ {" + StrZero(o:nRegVencido, 5) + "}", Space(46), Tran( o:nVlrPrincipalVencido, "@E 9,999,999.99" ), space(14), Tran( 0,              "@E 9,999,999.99" ), Tran( o:nTotalVencido, "@E 9,999,999.99" ) + NR)
			Qout(NG + " VENCER ABERTO  ¯¯ {" + StrZero(o:nRegVencer,  5) + "}", Space(46), Tran( o:nVlrPrincipalVencer,  "@E 9,999,999.99" ), space(14), Tran( 0,              "@E 9,999,999.99" ), Tran( o:nTotalVencer,  "@E 9,999,999.99" ) + NR)						
			Qout()
			Qout("EXTRATO PARA SIMPLES CONFERENCIA. NAO VALE COMO RECIBO.")
			Qout("NOS RESERVAMOS DE COBRAR VALORES QUE NAO ESTEJAM LANCADOS E EXPRESSOS NOS TERMOS E CONDICOES DO CONTRATO.")
		endif	
		IF UltCodi != Field->Codi
			NovoCodi := OK
		EndIF
		Col := 58
		 __Eject()
	EndIF
EndDo
PrintOff()
ResTela( cScreen )
Return NIL

*:==================================================================================================================================

CLASS TExtratoImp
	VAR nRegTribunal              INIT 0
	VAR nRegRecibo                INIT 0
	VAR nRegVencido               INIT 0
	VAR nRegVencer                INIT 0
	VAR nVlrPrincipalTribunal     INIT 0
	VAR nVlrPrincipalRecibo       INIT 0
	VAR nVlrPrincipalVencido      INIT 0
	VAR nVlrPrincipalVencer       INIT 0
	VAR nTotalRecibo              INIT 0 
	VAR nTotalVencido             INIT 0 
	VAR nTotalVencer              INIT 0 
	VAR nVlrCorrigido             INIT 0
	VAR nVlrCorrigidoTotal        INIT 0
	VAR nSoJuros                  INIT 0
	VAR nSoJurosTotal             INIT 0
	VAR nVlrCorrigidoMaisnSoJuros INIT 0
	VAR nMultaTotal               INIT 0
	VAR nTotalGeral               INIT 0
	VAR nMulta                    INIT 0
	VAR nSoma                     INIT 0
	VAR nAtraso                   INIT 0
	VAR nCarencia                 INIT 0
	VAR nDesconto                 INIT 0
	VAR nJuros	                  INIT 0
	VAR nSoma 		               INIT 0
	VAR nMulta		               INIT 0
	VAR nValorCm                  INIT 0
	VAR nCm                       INIT 0
	VAR nVlrCorrigido             INIT 0
	VAR nDias                     INIT 0
	VAR nJuro 			            INIT 0
	VAR aJuro                     INIT {}
	VAR nJuroDia                  INIT 0
	VAR nJuroTotal                INIT 0
	VAR nSoJuros                  INIT 0
	VAR nJuroTotal                INIT 0
	VAR nJuroDia                  INIT 0
	VAR nVlr                      INIT 0	
	VAR dVcto                     INIT Date()	
	VAR dCalculo                  INIT Date()  	
	METHOD New() INLINE Self
	METHOD Zerar() 
	METHOD CalculaPorraToda()
	METHOD ContaTribunal() 
	METHOD ContaRecibo() 
	METHOD ContaVencido() 
	METHOD ContaVencer() 	
ENDCLASS

METHOD Zerar() class TExtratoImp
**************
	::nRegTribunal              := 0
	::nRegRecibo                := 0
	::nRegVencido               := 0
	::nRegVencer                := 0
	::nVlrPrincipalTribunal     := 0
	::nVlrPrincipalRecibo       := 0
	::nVlrPrincipalVencido      := 0
	::nVlrPrincipalVencer       := 0
	::nTotalRecibo              := 0 
	::nTotalVencido             := 0 
	::nTotalVencer              := 0 
	::nVlrCorrigido             := 0
	::nVlrCorrigidoTotal        := 0
	::nSoJuros                  := 0
	::nSoJurosTotal             := 0
	::nVlrCorrigidoMaisnSoJuros := 0
	::nMultaTotal               := 0
	::nTotalGeral               := 0
	::nMulta                    := 0
	::nSoma                     := 0
	::nAtraso                   := 0
	::nCarencia                 := 0
	::nDesconto                 := 0
	::nJuros	                   := 0
	::nSoma 		                := 0
	::nMulta		                := 0
	::nValorCm                  := 0
	::nCm                       := 0
	::nVlrCorrigido             := 0
	::nDias                     := 0
	::nJuro 			             := 0
	::aJuro                     := {}
	::nJuroDia                  := 0
	::nJuroTotal                := 0
	::nSoJuros                  := 0
	::nJuroTotal                := 0
	::nJuroDia                  := 0
	::nVlr                      := 0
	::dVcto                     := Date()
	::dVcto                     := Date()
return self

METHOD CalculaPorraToda() class TExtratoImp
   ::nAtraso       := Atraso(      ::dCalculo, ::dVcto )
	::nCarencia	    := Carencia(    ::dCalculo, ::dVcto )
	::nDesconto	    := VlrDesconto( ::dCalculo, ::dVcto, ::nVlr )

	::nJuros	       := IF( ::nAtraso <= 0, 0, ( ::nCarencia * ::nJurodia ))
	::nSoma 		    := ((::nVlr + ::nJuros ) - ::nDesconto)		
	::nMulta		    := VlrMulta( ::dCalculo, ::dVcto, ::nSoma )		
	::nSoma 		    += ::nMulta
	
	::nValorCm      := CalculaCm(::nVlr, ::dVcto, ::dCalculo)
	::nCm           := (::nValorCm - ::nVlr)		
	::nVlrCorrigido := ::nValorCm		
	::nDias         := (::dCalculo - ::dVcto)
	::nJuro 			 := oAmbiente:aSciArray[1 , SCI_JUROMESCOMPOSTO] 
	::aJuro         := aAntComposto( ::nVlr, ::nJuro, ::nDias, XJURODIARIO)
	::nJuroDia      := ::aJuro[6]
	::nJuroTotal    := ::aJuro[5]		
	::nSoJuros      := ::aJuro[5]
	::nJuroTotal    += ::nCm
	::nJuroDia      := (::nJuroTotal / ::nDias)			
return self

METHOD ContaTribunal() class TExtratoImp
	::nRegTribunal++
	::nVlrPrincipalTribunal     += ::nVlr
	::nVlrCorrigidoTotal        += ::nVlrCorrigido
	::nSoJurosTotal             += ::nSoJuros
	::nVlrCorrigidoMaisnSoJuros += ::nVlrCorrigido + ::nSoJuros
	::nMultaTotal               += ::nMulta
	::nTotalGeral               += ::nVlrCorrigido + ::nSoJuros + ::nMulta
return self

METHOD ContaRecibo() class TExtratoImp
	::nRegRecibo++
	::nVlrPrincipalRecibo += ::nVlr
	::nTotalRecibo        += Recibo->Vlr
return self

METHOD ContaVencido() class TExtratoImp
	::nRegVencido++
	::nVlrPrincipalVencido += ::nVlr
	::nTotalVencido        += ::nSoma
return self

METHOD ContaVencer() class TExtratoImp
	::nRegVencer++
	::nVlrPrincipalVencer += ::nVlr
	::nTotalVencer        += ::nSoma
return self	

*:==================================================================================================================================