/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³	Programa.....: ORCALAN.PRG 														 ³
 Ý³	Aplicacaoo...: SISTEMA DE CONTROLE DE ESTOQUE/FATURAMENTO				 ³
 Ý³	Versao.......: 4.3.26																 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³   Ult.Atual....: 23 de agosto de 2014.                                  ³
 Ý³	Compilacao...: Clipper 5.2e														 ³
 Ý³	Linker.......: Blinker 3.20														 ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Lista.ch"
#Include "Inkey.ch"
#Include "Fileman.Ch"
#Include "Permissao.Ch" // Permissao de Usuarios
#Include "Indice.Ch"    // Ordem dos Indice
#include "Fileio.Ch"    // Arquivos
#include "Directry.Ch"  // Arquivos
#include "Ctnnet.Ch"    // Clipper Tools
#include "Picture.ch"   // Picture de Entrada de Dados SCI
#include "Status.ch"    // Codigo de Erro da ECF Bematech

*:----------------------------------------------------------------------------
Static lAlterarDescricao
Static nLarguraTicketVenda
Static nCompTicketVenda
Static cTipoVenda
Static lPrecoTicket
Static lPrecoPrevenda
Static lSerieProduto
Static lIpi
Static lIndexador
Static lDuplicidade
Static lAutoPreco
Static lMediaPonderada
Static nOrderTicket
Static lZerarDesconto
Static cFaturaPrevenda
Static cRamoIni
Static cCabecIni
Static cPriLinPv
Static cSegLinPv
Static lMinimoMens
Static oOrca
Static oEntradas
Static nIniEcf
Static aOrcaLanIni
Static lAutoEcf
Static lNomeEcf
Static lUsarTeclaCtrlP
Static cVendedor
Static lEditarQuant
Static lEcfRede
Static cPathRede
Static lUsuarioAdmin
Static lAutoVenda
*:----------------------------------------------------------------------------

Proc Orcamento( lTestelan )
***************************
LOCAL cScreen				:= SaveScreen()
LOCAL nChoice				:= 2
LOCAL lVarejo				:= 2
LOCAL cCaixa				:= Space(4)
LOCAL aMenu 				:= {"Manualmente - Varejo ", "Manualmente - Atacado" , "Manualmente - Custo","Codigo Barra - Varejo", "Codigo Barra - Atacado", "Codigo Barra - Custo" }
LOCAL aPreco				:= { 2, 1, 3, 2, 1 ,3 }
LOCAL aString				:= { "VAREJO", "ATACADO", "CUSTO", "VAREJO", "ATACADO", "PCUSTO"}
LOCAL xNtx					:= FTempName("T*.TMP")
LOCAL nVlrMercadoria 	:= 0
LOCAL nTimeSaver			:= oIni:ReadInteger('sistema','screensaver', 60 )
LOCAL oVenlan				:= TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL aPermite 			:= {}
LOCAL cDrive				:= oAmbiente:xBase
LOCAL lMnuOpcao2
LOCAL lMnuOpcao3
LOCAL lMnuOpcao4
LOCAL lMnuOpcao5
LOCAL lMnuOpcao6
LOCAL Handle
LOCAL Coluna
LOCAL nKey
LOCAL cTela
LOCAL Arq_Ant
LOCAL Ind_Ant
LOCAL cString
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Total
PUBLI lFatCodebar := FALSO

*:----------------------------------------------------------------------------
lMnuOpcao2			:= oVenLan:ReadBool('opcoesfaturamento', '#2.02', FALSO )
lMnuOpcao3			:= oVenLan:ReadBool('opcoesfaturamento', '#2.03', FALSO )
lMnuOpcao4			:= oVenLan:ReadBool('opcoesfaturamento', '#2.04', FALSO )
lMnuOpcao5			:= oVenLan:ReadBool('opcoesfaturamento', '#2.05', FALSO )
lMnuOpcao6			:= oVenLan:ReadBool('opcoesfaturamento', '#2.06', FALSO )
lAutoVenda			:= oVenlan:ReadBool('permissao','autovenda', FALSO )
lUsuarioAdmin		:= oSci:ReadBool('permissao','usuarioadmin', FALSO )
lUsarTeclaCtrlP	:= oSci:ReadBool('permissao','usarteclactrlp', OK )
lAlterarDescricao := oIni:ReadBool('sistema','alterardescricao', FALSO )
cTipoVenda			:= oIni:ReadString('sistema','tipovenda', "N" )
lPrecoTicket		:= oIni:ReadBool('sistema','precoticket', OK )
lPrecoPrevenda 	:= oIni:ReadBool('sistema','precoprevenda', OK )
lSerieProduto		:= oIni:ReadBool('sistema','serieproduto', FALSO )
lDuplicidade		:= oIni:ReadBool('sistema','duplicidade', FALSO )
nOrderTicket		:= oIni:ReadInteger('sistema','orderticket', 1 )
lZerarDesconto 	:= oIni:ReadBool('sistema','zerardesconto', OK )
cRamoIni 			:= oIni:ReadString('sistema','ramo', Left( XRAMO, 40))
cCabecIni         := oIni:ReadString('sistema','cabec',    Left(AllTrim(oAmbiente:xFanta),40))
cPriLinPv         := oIni:ReadString('sistema','prilinpv', Left(AllTrim(oAmbiente:xFanta),40))
cSegLinPv			:= oIni:ReadString('sistema','seglinpv', Left( XRAMO, 40))
lMinimoMens 		:= oIni:ReadBool('sistema','minimomens', FALSO )
nIniEcf				:= oIni:ReadInteger('ecf','modelo', 1 )
lAutoEcf 			:= oIni:ReadBool('ecf','autoecf', FALSO )
lNomeEcf 			:= oIni:ReadBool('ecf','nomeecf', FALSO )
lEcfRede 			:= oIni:ReadBool('ecf','ecfrede', FALSO )
cPathRede			:= oIni:ReadString('ecf','pathrede', cDrive + '\CMD' )
lEditarQuant		:= oIni:ReadBool('sistema','editarquant', FALSO )
aOrcalanIni 		:= OrcalanRegedit()
aPermite 			:= { SnOrcaLan(2.01), SnOrcaLan(2.02), SnOrcaLan(2.03), SnOrcaLan(2.04), SnOrcaLan(2.05), SnOrcaLan(2.06) }
cVendedor			:= Space(40)
cFaturaPrevenda	:= Space(07)

*:----------------------------------------------------------------------------
IF !lTestelan
	AbreArea()
EndIF
WHILE OK
	oMenu:Limpa()
	M_Title( "ESCOLHA A OP€AO DE FATURAMENTO" )
	nChoice := FazMenu( 05, 11, aMenu, Cor(), aPermite)
	IF nChoice = 0
		IF !lTestelan
			Mensagem("Aguarde, Fechando Arquivos.", Cor())
			FechaTudo()
		EndIF
		ResTela( cScreen )
		Return
	EndIF
	Do Case
	Case nChoice = 2
		IF lMnuOpcao2 == FALSO
			ErrorBeep()
			Alerta('Erro: Opcao nao autorizada.')
			Loop
		EndIF
	Case nChoice = 3
		IF lMnuOpcao3 == FALSO
			ErrorBeep()
			Alerta('Erro: Opcao nao autorizada.')
			Loop
		EndIF
	Case nChoice = 4
		IF lMnuOpcao4 == FALSO
			ErrorBeep()
			Alerta('Erro: Opcao nao autorizada.')
			Loop
		EndIF
	Case nChoice = 5
		IF lMnuOpcao5 == FALSO
			ErrorBeep()
			Alerta('Erro: Opcao nao autorizada.')
			Loop
		EndIF
	Case nChoice = 6
		IF lMnuOpcao6 == FALSO
			ErrorBeep()
			Alerta('Erro: Opcao nao autorizada.')
			Loop
		EndIF
	EndCase
	IF !VerSenha( @cCaixa, @cVendedor )
		Loop
	EndIF
	Exit
EndDo
cString := "CAIXA: " + cCaixa
oMenu:Limpa()
ErrorBeep()
cString		+= " - FATURAMENTO " + aString[ nChoice ]
lVarejo		:= aPreco[ nChoice ]
lFatCodeBar := ( nChoice >= 4 )
//NNetExtAtt("*.DBF", EXA_TTS )
Set Key F5 To
Handle := FaturaNew()
Use ( Handle ) Alias xAlias Exclusive New
Area("xAlias")
Inde On xAlias->Codigo To ( xNtx )
Print( 00, 01, Padc( cString, (MaxCol()-1)), 31 )
StatusInf( oMenu:CodiFirma + ':' + oMenu:NomeFirma, "ESC=RETORNA ³F5-PRECOS ³F10-CALC ³")
oOrca := FazBrowse( 01, 01, 15, (MaxCol()-1) )
WHILE OK
	SetCursor(0)
	Imprime_Soma()
	oOrca:ForceStable()
	IF oOrca:HitTop .OR. oOrca:HitBottom
		ErrorBeep()
	EndIf
	WHILE ( nKey := Inkey( nTimeSaver )) = 0
		Shuffle()
	EndDo
	Arq_Ant := Alias()
	Ind_Ant := IndexOrd()
	IF nKey == K_ESC
		 ErrorBeep()
		 IF Conf("Pergunta: Sair do Faturamento ?")
			 ResTela( cScreen )
			 Exit
		 EndIF
	ElseIf nKey == TECLA_INSERT .OR. nKey == TECLA_MAIS .OR. nKey = ENTER
	  xIncluiRegistro( lVarejo, oOrca, lFatCodebar )
	  oOrca:RefreshAll()
	  DbGoBoTTom()
  ElseIf nKey == ASTERISTICO
	  Imprime_Soma(,,, OK)
  ElseIf nKey == TECLA_DELETE
	  xDeletar()
	  oOrca:refreshCurrent():forceStable()
	  oOrca:up():forceStable()
	  Freshorder( oOrca)
  ElseIf nKey == F1
	  cTela := SaveScreen()
     VerPosicao(cCaixa)
	  ResTela( cTela )
  ElseIf nKey == F2
	  cTela := SaveScreen()
	  oMenu:Limpa()
	  VerBaixa(cCaixa, cVendedor)
	  ResTela( cTela )
  ElseIf nKey == F3
	  nNivel := SCI_PAGAMENTOS
	  IF !aPermissao[ nNivel ]
		  IF PedePermissao( nNivel )
			  cTela := SaveScreen()
			  oMenu:Limpa()
			  Paga22( cCaixa )
		  EndIF
	  Else
		  cTela := SaveScreen()
		  oMenu:Limpa()
		  Paga22( cCaixa )
	  EndIF
	  ResTela( cTela )
  ElseIf nKey == F4
	  cTela := SaveScreen()
	  VerCaixa(cCaixa)
	  ResTela( cTela )
  ElseIf nKey == F5
	  #IFNDEF CENTRALCALCADOS
		  cTela := SaveScreen()
		  OrcaLista( lVarejo )
		  ResTela( cTela )
	  #ENDIF
  ElseIf nKey == F6
	  cTela := SaveScreen()
	  DevPreVenda()
	  ResTela( cTela )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == F7
	  cTela := SaveScreen()
	  Ped_Cli9()
	  ResTela( cTela )
  ElseIf nKey == F8
	  oMenu:Limpa()
	  PreVenda(cCaixa)
	  ResTela( cScreen )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == F9
	  CliInclusao()
  ElseIf nKey == F10
	  oMenu:Limpa()
	  Fecha( cCaixa,,, lVarejo )
	  ResTela( cScreen )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == F11
	  cTela := SaveScreen()
	  xAlias->(DbCloseArea())
	  ManuFatura( cCaixa, lFatCodeBar )
	  Use ( Handle ) Alias xAlias Exclusive New
	  xAlias->(DbSetIndex(( xNtx )))
	  Arq_Ant := Alias()
	  Ind_Ant := IndexOrd()
	  ResTela( cTela )
  ElseIf nKey == F12
	  cTela := SaveScreen()
	  CalcValor()
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_F1
	  cTela := SaveScreen()
	  oMenu:Limpa()
	  ReciboIndividual()
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_F2
	  cTela := SaveScreen()
	  OrdemServico(FALSO)
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_F3
	  cTela := SaveScreen()
	  #IFDEF MICROBRAS
		  FechaDia()
	  #ENDIF
	  #IFDEF TRADICAO
		  FechaDia()
	  #ENDIF
	  #IFDEF VILADELA
		  FechaDia()
	  #ENDIF
	  #IFDEF COLCHOES
		  FechaDia()
	  #ENDIF
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_F12
	  cTela := SaveScreen()
	  IncPorGrupo( oOrca )
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_F9
	  oMenu:Limpa()
	  MoviTeste( oOrca )
	  ResTela( cScreen )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == K_CTRL_F10
	  oMenu:Limpa()
	  ImprimeOrcamento()
	  ResTela( cScreen )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == K_CTRL_F11
	  oMenu:Limpa()
	  ZerarPrevenda()
	  ResTela( cScreen )
	  Mostra_Soma()
	  oOrca:RefreshAll()
  ElseIf nKey == CTRL_Q
	  xLimpaFatura()
	  oOrca:RefreshAll()
  ElseIf nKey == CTRL_ENTER
	  xAlterar( lVarejo, lFatCodeBar )
	  oOrca:RefreshAll()
  ElseIf nKey == K_SH_F10
	  AutorizaVenda()
	  oOrca:RefreshAll()
  ElseIf nKey == CTRL_P
	  cTela := SaveScreen()
	  oMenu:Limpa()
	  IF !lUsarTeclaCtrlP
		  IF !PedePermissao( SCI_USARTECLACTRLP )
			  Restela( cTela )
			  Loop
		  EndIF
	  EndIF
	  WHILE OK
		  M_Title("ESCOLHA A OPCAO")
		  nOp := FazMenu( 00, 20, {" Ticket de Venda",;
											" Cupom Fiscal",;
											" Promissoria Form Branco",;
											" Promissoria Form Padrao",;
											" Duplicata Form Branco",;
											" Duplicata Form Padrao",;
											" Boleto Bancario",;
											" Carne Pagamento",;
											" Carne Pagamento Caixa",;
											" Carne Recebimento",;
											" Nota Fiscal",;
											" Espelho Nota",;
											" Espelho Nota Parcial",;
											" Documentos Diversos",;
											" Contrato Venda",;
											" Ficha/Relacao Cliente",;
											" Debito Conta Corrente",;
											" Cancelar/Fechar Cupom Fiscal",;
                                 " Rol Carga/Descarga",;
                                 " Manutencao Prevenda",;
                                 " Contrato Confissao Divida"})
		  IF nOp = 0
			  Exit
		  ElseIF nOp = 1
			  ReTicket(cCaixa)
		  ElseIF nOp = 2
			  ReCupom(cCaixa)
		  ElseIF nOp = 3
           ProBranco()
		  ElseIF nOp = 4
           ProPersonalizado()
		  ElseIF nOp = 5
			  DupPapelBco()
		  ElseIF nOp = 6
           DupPersonalizado()
		  ElseIF nOp = 7
			  DiretaLivre()
		  ElseIF nOp = 8
			  CarnePag()
		  ElseIF nOp = 9
			  CarneCaixa()
		  ElseIF nOp = 10
			  CarneRec()
		  ElseIF nOp = 11
			  NotaFiscal( NIL )
		  ElseIF nOp = 12
			  Espelho()
		  ElseIF nOp = 13
			  EspelhoParcial()
		  ElseIF nOp = 14
			  oMenu:Limpa()
           PrnDiversos(NIL,NIL,cCaixa,cVendedor)
		  ElseIF nOp = 15
			  oMenu:Limpa()
           ImprimeContrato(1)
		  ElseIF nOp = 16
			  oMenu:Limpa()
			  RelCli()
		  ElseIF nOp = 17
			  ImprimeDebito()
		  ElseIF nOp = 18
			  Cancel_Cupom()
		  ElseIF nOp = 19
			  CargaDescarga()
		  ElseIF nOp = 20
			  ManuPrevenda()
        ElseIF nOp = 21
           ImprimeContrato(2)
		  EndIF
	  EndDo
	  ResTela( cTela )
  ElseIf nKey == K_CTRL_RIGHT .OR. nKey = K_RIGHT
	  IF !aPermissao[ SCI_DEVOLUCAO_FATURA ]
		  IF PedePermissao( SCI_VERIFICAR_PCUSTO )
			  TestaTecla( nKey, oOrca )
		  EndIF
	  Else
		  TestaTecla( nKey, oOrca )
	  EndIF
  Else
	  TestaTecla( nKey, oOrca )
  EndIf
  Print(00,01, Padc( cString, (MaxCol()-1)), 31 )
  AreaAnt( Arq_Ant, Ind_Ant )
EndDo
Mensagem("Aguarde...", Cor())
xAlias->(DbCloseArea())
FClose( Handle )
FClose( xNtx )
Ferase( Handle )
Ferase( xNtx )
IF !lTesteLan
	FechaTudo()
EndIF
Return

Proc ManuPrevenda()
*******************
LOCAL cScreen			:= SaveScreen()
LOCAL Arq_Ant			:= Alias()
LOCAL Ind_Ant			:= IndexOrd()
LOCAL nChoice			:= 0
LOCAL aMenu 			:= {" Exportar Arquivo Prevenda",;
								 " Importar Arquivo Prevenda",;
								 " Espelho Nota Parcial Prevenda",;
								 " Relacao de Separacao Prevenda"}

WHILE OK
	oMenu:Limpa()
	M_Title("MANUTENCAO PREVENDA")
	nChoice := FazMenu( 10, 10, aMenu )
	Do Case
	Case nChoice = 0
	  ResTela( cScreen )
	  Return
	Case nChoice = 1
		ExPrevenda()
	Case nChoice = 2
		ImPrevenda()
	Case nChoice = 3
		EspelhoTicket()
	Case nChoice = 4
		SeparaPrevenda()
	EndCase
EndDo

Function ProxFatura()
*********************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTamCampo := 7

Nota->(Order(ZERO))
Nota->(DbGoBottom())
cFatura := StrZero( Val( Nota->Numero ) + 1, nTamCampo )
AreaAnt( Arq_Ant, Ind_Ant )
Return( cFatura )

Function Fecha( cCaixa, lManutencao, aDevolucao, lVarejo )
**********************************************************
STATIC aArray				:= {}
LOCAL lAutoFatura 		:= oIni:ReadBool('sistema','autofatura', OK )
LOCAL lAutoDocumento 	:= oIni:ReadBool('sistema','autodocumento', OK )
LOCAL lAutoEmissao		:= oIni:ReadBool('sistema','autoemissao', FALSO )
LOCAL lAutoDesconto		:= oIni:ReadBool('sistema','autodesconto', FALSO )
LOCAL lAutoLiquido		:= oIni:ReadBool('sistema','autoliquido', FALSO )
LOCAL lAutoFecha			:= oIni:ReadBool('sistema','autofecha', FALSO )
LOCAL cAutoTipo			:= oIni:ReadString('sistema','autotipo', 'DM    ')
LOCAL lTrocarVendedor	:= oIni:ReadBool('sistema','trocarvendedor', OK )
LOCAL oVenlan				:= TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL GetList				:= {}
LOCAL nTransacao			:= 0
LOCAL Arq_Ant				:= Alias()
LOCAL Ind_Ant				:= IndexOrd()
LOCAL cScreen				:= SaveScreen()
LOCAL cForma				:= Space(02)
LOCAL cVendedor			:= cCaixa
LOCAL cTecnico 			:= Space(04)
LOCAL cOldVendedor		:= cCaixa
LOCAL cVendedor1			:= Space(04)
LOCAL cCond 				:= Space(40)
LOCAL dEmis 				:= Date()
LOCAL nJuro             := oAmbiente:aSciArray[1,SCI_JUROMES]
LOCAL nTotal				:= 0
LOCAL nBruto				:= 0
LOCAL nVlrMerc 			:= 0
LOCAL xDesconto			:= 0
LOCAL nDesconto			:= 0
LOCAL nUnitario			:= 0
LOCAL nPvendido			:= 0
LOCAL nComissaoMedia 	:= 0
LOCAL nPorc 				:= 0
LOCAL nCotacao 			:= 0
LOCAL nComis_Disp 		:= 0
LOCAL nComis_Bloq 		:= 0
LOCAL nConta				:= 0
LOCAL cPlaca				:= Space(08)
LOCAL cFatura				:= Space(07)
LOCAL cFaturaAnt			:= Space(07)
LOCAL cFatuParaDeletar	:= NIL
LOCAL cRegiao				:= Space(02)
LOCAL cCodiCaixa			:= "0000"
LOCAL aReg					:= {}
LOCAL aLog					:= {}
LOCAL aVcto 				:= {}
LOCAL aRegistro			:= {}
LOCAL cNomeCliente		:= ""
LOCAL cCodi 				:= ""
LOCAL xCodigo				:= ""
LOCAL cAutorizado 		:= ""
LOCAL nLimite				:= 0
LOCAL nDescMedio			:= 0
LOCAL nTotalSemDesconto := 0
LOCAL nPorcAnt 			:= 0
LOCAL cDivisao 			:= "N"
LOCAL cTecSimNao			:= "N"
LOCAL nTamCampo			:= 7
LOCAL nOrdemAnt			:= 0
LOCAL nIof					:= 0
LOCAL lFinanceiro 		:= FALSO
LOCAL lDesdobrar			:= FALSO
LOCAL nDia					:= 0
LOCAL xGrupo
LOCAL cTela
LOCAL cTam_Ped
LOCAL nVer_val
LOCAL nRecno
LOCAL nQt_Eleme
LOCAL nContaData
LOCAL I
LOCAL nCh
LOCAL nX
LOCAL nVlr_Comissao
LOCAL aComis
LOCAL aDocnr
LOCAL aVlr
LOCAL aTipo
LOCAL aJuro
LOCAL aPort
LOCAL aObs
LOCAL nCol
LOCAL nLetra
LOCAL nVlr_Total
LOCAL nQtd_Dup
LOCAL dVctoDup
LOCAL Sobra
LOCAL cTam_Fatu
LOCAL nSoma
LOCAL cTipo
LOCAL cCodiVen
LOCAL Comis_Lib
LOCAL nChSaldo
FIELD NrPedido
FIELD Numero
FIELD Codigo
FIELD ComDisp
FIELD Comissao
FIELD CodiVen
FIELD ComBloq

lAutoVenda := oVenlan:ReadBool('permissao','autovenda', FALSO )
IF lManutencao = OK
	lAutoVenda := FALSO
EndIF
IF lAutoVenda == OK
	lAutoFatura 		:= OK
	lAutoDocumento 	:= OK
	lAutoEmissao		:= OK
	lAutoDesconto		:= OK
	lAutoLiquido		:= OK
	lAutoFecha			:= OK
	cAutoTipo			:= 'DH    '
Else
	TelaFechaCli()
EndIF
Imprime_Soma( @nVlrMerc, @nComissaoMedia, OK )
DescMedio( lVarejo, @nDescMedio, @nTotalSemDesconto )
dEmis 		:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[01], Date()		), aDevolucao[01])
cVendedor	:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[02], cCaixa		), aDevolucao[02])
cForma		:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[03], Space(02)	), aDevolucao[03])
cCodi 		:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[04], Space(05)	), aDevolucao[04])
nPorc 		:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[05], 0				), aDevolucao[05])
cFatura		:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[06], ProxFatura()), aDevolucao[06])
cFaturaAnt	:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[06], ProxFatura()), aDevolucao[06])
cTecnico 	:= IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[07], cTecnico 	), aDevolucao[07])
nTotal		:= nVlrMerc
nBruto		:= nVlrMerc
nVer_val 	:= nVlrMerc
nDesc 		:= 0
IF lAutoVenda == OK
	cForma := '00'
	nDia	 := 0
	FormaErrada( @cForma, @cCond, NIL, NIL, @nPorc, nComissaoMedia, @nIof, @lDesdobrar )
Else
	Write( 05, 15, cFatura )
	Print 01, 15 Get cForma   Pict "@R99" Valid LastKey() = UP .OR. FormaErrada( @cForma, @cCond, 01, 37, @nPorc, nComissaoMedia, @nIof, @lDesdobrar )
	Print 01, 22 Get nDia	  Pict "99" When lDesdobrar Valid nDia >= 0 .OR. LastKey() = UP
EndIF
nPorcAnt   := nPorc
cTecSimNao := IF( !Empty( cTecnico ), "S","N")
IF lAutoVenda == OK
	cVendedor  := cCaixa
	cVendedor1 := Space(04)
	cTecnico   := Space(04)
	cDivisao   := 'N'
	cTecSimNao := 'N'
Else
	Print 02, 15 Get nPorc		  Pict "99.99"    Valid ValidanPorc( nPorc, nPorcAnt ) WHEN aPermissao[SCI_ALTERAR_COMISSAO_DE_VENDA]
	Print 02, 37 Get cVendedor   Pict "9999"     Valid LastKey() = UP .OR. Vendedor( @cVendedor, Row(), Col()+1, lTrocarVendedor, cOldVendedor) When nPorc > 0
	Print 03, 15 Get cDivisao	  Pict "!"        Valid LastKey() = UP .OR. cDivisao $ "SN" When nPorc > 0
	Print 03, 37 Get cVendedor1  Pict "9999"     Valid LastKey() = UP .OR. Vendedor( @cVendedor1, Row(), Col()+1 ) .AND. VendVend1( cVendedor, cVendedor1 ) When nPorc > 0 .AND. cDivisao == "S"
	Print 04, 15 Get cTecSimNao  Pict "!"        Valid LastKey() = UP .OR. cTecSimNao $ "SN"
	Print 04, 37 Get cTecnico	  Pict "9999"     Valid LastKey() = UP .OR. Vendedor( @cTecnico, Row(), Col()+1 ) When cTecSimNao == "S"
	Print 05, 15 Get cFatura	  Pict "@!"       When !lAutoFatura   Valid VerNumero( @cFatura, cFaturaAnt, lManutencao, cCodi, dEmis )
	Print 05, 37 Get dEmis		  Pict PIC_DATA	When !lAutoEmissao  Valid Cotacao( dEmis, @nCotacao ) .AND. PodeMudarData( dEmis )
	Print 06, 15 Get nDesc		  Pict "99.99"    When !lAutoDesconto Valid CalculaDesc( nDesc, @nTotal, nBruto, nIof )
	Print 06, 37 Get nTotal 	  Pict "@E 9,999,999,999.99" When !lAutoLiquido Valid LastKey() = UP .OR. TotalComDescontoMaximo( @nTotal, nTotalSemDesconto, nDescMedio )
EndIF
IF lAutoVenda == OK
	cCodi := '00000'
	Receber->(Order( RECEBER_CODI ))
	Receber->(DbSeek( cCodi))
	cNomeCliente := Receber->Nome
	cTipoVenda	 := 'N'
Else
	Print 08, 15 Get cCodi		  Pict "99999"    Valid LastKey() = UP .OR. ;
																xCliente( @cCodi, @cNomeCliente, @cRegiao, RTrim( cCond )) .AND. ;
																oIniWrite( cForma, cCond, nComissaoMedia, cCodi, cVendedor, cDivisao, cVendedor1, cFatura, dEmis, nDesc, nTotal, cNomeCliente ) .AND. ;
																VerificaLimite( cCodi, nTotal, @nLimite, @cAutorizado, RTrim( cCond), cFatura ) .AND. ;
																VerificaPosicao( cCodi, RTrim(cCond), cFatura)
	Print 09, 15 Get cTipoVenda  Pict "!"        Valid PickTam({"Normal", "Conta Corrente"}, {'N','S'}, @cTipoVenda ) .OR. LastKey() = UP
	#IFDEF XPLACA
	Print 10, 15 Get cPlaca 	 Pict "@!"
	#ENDIF
	Read
EndIF
aArray := { dEmis, cVendedor, cForma, cCodi, nPorc, cFatura, cTecnico }
nTotal := Round( nTotal, 2)
xAlias->(DbGotop())
IF LastKey() = ESC .OR. nTotal = 0 .OR. xAlias->(Empty( Codigo ))
	AreaAnt( Arq_Ant, Ind_Ant )
	oIniErase( cFatura )
	Restela( cScreen )
	Return( FALSO )
EndIF
IF Empty( cCodi )
	Alerta("Erro: Entre com o cliente.")
	AreaAnt( Arq_Ant, Ind_Ant )
	Restela( cScreen )
	Return( FALSO )
EndIF
cCond  := RTrim( cCond )
IF cTipoVenda = 'S'
	lDesdobrar	 := FALSO
	nConta		 := 1
	xData 		 := dEmis
	aVcto 		 := {} ; Aadd( aVcto,  dEmis + 30 )
	aDocnr		 := {} ; Aadd( aDocnr, cFatura + '-A' )
	aVlr			 := {} ; Aadd( aVlr,   nTotal )
	aJuro 		 := {} ; Aadd( aJuro,  nJuro )
	aTipo 		 := {} ; Aadd( aTipo,  'CC')
	aPort 		 := {} ; Aadd( aPort,  'CARTEIRA')
   aObs         := {} ; Aadd( aObs,   Space(40))
	aComis		 := {} ; Aadd( aComis, 'S' )
	aRequisicao  := {} ; Aadd( aRequisicao, 'S' )
EndIF
IF lDesdobrar .AND. cTipoVenda = 'N'
	nConta		:= Forma->Parcelas
	lVista		:= Forma->Vista
	xData 		:= dEmis
	aDocnr		:= Array( nConta )
	aVlr			:= Array( nConta )
	aTipo 		:= Array( nConta )
	aJuro 		:= Array( nConta )
	aPort 		:= Array( nConta )
   aObs        := Array( nConta )
	aComis		:= Array( nConta )
	aRequisicao := Array( nConta )
	aVcto 		:= Array( nConta )
	nSoma 		:= 0
	Sobra 		:= 0
	nMes			:= Month(dEmis)
	nAno			:= Val(Right(StrZero(Year(dEmis),4),2))
	For x := 1 To nConta
		IF nDia <> 0
			IF x == 1 .AND. lVista
			  nMes += 0
			Else
			  nMes++
			EndIF
			IF nMes > 12
				nMes := 1
				nAno++
			EndIF
			IF nMes = 2
				IF nDia > 28
					nDia = 28
				EndIF
			EndIF
			IF x == 1 .AND. lVista
				cData := Dtoc( xData )
			Else
				cData := Strzero( nDia, 2) + '/' +  StrZero(nMes,2) + '/' + StrZero( nAno, 2 )
			EndIF
			aVcto[x] := Ctod( cData )
		Else
			IF x == 1 .AND. lVista
				xData += 0
			Else
				xData += Forma->Dias
			EndIF
			aVcto[x] := xData
		EndIF
		aDocnr[x]		:= Right( cFatura, 6 ) + "-" + StrZero( x, 2 )
		aTipo[x] 		:= "DM"
		aComis[x]		:= "S"
		aRequisicao[x] := "S"
		aPort[x] 		:= "CARTEIRA  "
      aObs[x]        := Space(40)
		aJuro[x] 		:= nJuro
		IF x == nConta
			nVlr	:= (Sobra := ( nTotal - nSoma ))
			nVlr	+= nTotal % ( nSoma + nVlr )
		Else
			nVlr	:= nTotal / nConta
		EndIf
		aVlr[x]	:= nVlr
		nVlr		:= Round( nVlr, 2 )
		nSoma 	:= Round( aTotal( aVlr ), 2 )
	Next
EndIF
IF !lDesdobrar .AND. cTipoVenda = 'N'
	nConta := ChrCount("/", cCond ) + 1
	IF nConta > 1
		nConta := ChrCount("/", cCond ) + 1
		For x := 1 To nConta
			 Aadd( aVcto, dEmis + Val( StrExtract( cCond,"/", x )))
		 Next
	Else
		nConta := ChrCount("+", cCond ) + 1
		For x := 1 To nConta
			Aadd( aVcto, dEmis + Val( StrExtract( cCond,"+", x )))
		Next
	EndIF
EndIF
IF cTipoVenda = "N" // Venda Normal
	IF !lDesdobrar
		IF !lAutoFecha
			TelaFechaTit()
		EndIF
		aDocnr		:= Array( nConta )
		aVlr			:= Array( nConta )
		aTipo 		:= Array( nConta )
		aJuro 		:= Array( nConta )
		aPort 		:= Array( nConta )
      aObs        := Array( nConta )
		aComis		:= Array( nConta )
		aRequisicao := Array( nConta )
      nCol        := 17
		nLetra		:= 65
		nVlr_Total	:= nTotal
		nQtd_Dup 	:= nConta
		nQt_Eleme	:= nConta
		nSoma 		:= 0
		nContaData	:= 0

		Area("Recemov")
		Recemov->(Order( RECEMOV_DOCNR ))
		For i = 1 To nConta
			dVctoDup 		 := aVcto[i]
			nContaData		 := ( dVctoDup - dEmis )
			aTipo[i] 		 := IF( nContaData = 0, "DH    ", IF( i = 1, cAutoTipo, aTipo[(i-1)]))
			aComis[i]		 := IF( i = 1, "S",          aComis[(i-1)])
			aRequisicao[i]  := IF( i = 1, "S",          aRequisicao[(i-1)])
			aPort[i] 		 := IF( i = 1, "CARTEIRA  ", aPort[(i-1)])
         aObs[i]         := IF( i = 1, Space(40),    aObs[(i-1)])
			aJuro[i] 		 := IF( i = 1, nJuro 		, aJuro[(i-1)])
			aDocnr[i]		 := cFatura + "-" + Chr( nLetra )
			IF i == nConta
				nVlr := (Sobra := ( nTotal - nSoma ))
				nVlr += nTotal % ( nSoma + nVlr )
			Else
				nVlr := nTotal / nConta
			EndIf
			nVlr	:= Round( nVlr, 2 )
			cTipo := IF( nContaData != 0 .AND. aTipo[i] = "DH    ", cAutoTipo, aTipo[i] )
         //Write(nCol,   04, Space(74))
			IF !lAutoFecha
            @ nCol,   04 Get aDocnr[i]       Pict "@!" When !lAutoDocumento Valid DocCerto( aDocnr[i])
            @ nCol,   14 Get nVlr            Pict "@E 9,999,999,999.99" Valid Somatudo( nVlr, nSoma, nTotal )
            @ nCol,   31 Get nContaData      Pict "999" Valid SomaData( @dVctoDup, dEmis, nContaData )
            @ nCol,   35 Get dVctoDup        Pict PIC_DATA Valid Tqme( dEmis, @dVctoDup )
            @ nCol,   46 Get cTipo           Pict "@!" Valid Pick( @cTiPo, nContaData )
            @ nCol,   53 Get aComis[i]       Pict "!" Valid aComis[i]       $ "SN"
            @ nCol,   56 Get aRequisicao[i]  Pict "!" Valid aRequisicao[i]  $ "SN"
            @ nCol,   59 Get aJuro[i]        Pict "999.99"
            @ nCol,   67 Get aPort[i]        Pict "@!"
            @ 14,     20 Get aObs[i]         Pict "@!"
				Read
				IF LastKey() = ESC
					AreaAnt( Arq_Ant, Ind_Ant )
					ResTela( cScreen )
					Return( FALSO )
				EndIF
				IF cTipo = Space(6)
					Pick( @cTipo )
				EndIF
			EndIF
			aVlr[i]	:= nVlr
			aTipo[i] := cTipo
			aVcto[i] := dVctoDup
			nSoma 	:= Round( aTotal( aVlr ), 2 )
			nJuro 	:= aJuro[i]
			nLetra	++
			nQtd_Dup --
         IF i >= 7
				nCol := 23
				Scroll( 16, 01, 23, 78, 1 )
				Write( 23, 1 , Chr( nLetra ) + ":")
			Else
            nCol++
			EndIf
			IF nSoma < nTotal .AND. i == nConta
				nConta++
				nQtd_dup++
				Aadd( aComis,		 "N")
				Aadd( aRequisicao, "S")
				Aadd( aTipo,		 "")
				Aadd( aPort,		 "" )
            Aadd( aObs,        Space(40))
				Aadd( aDocnr,		 "" )
				Aadd( aJuro,		 0 )
				Aadd( aVlr, 		 0 )
				Aadd( aVcto,		 Date() )
				aVcto[ nConta ] := aVcto[ ( nConta - 1 ) ]
			EndIF
		Next
	EndIF
EndIF
ErrorBeep()
lFinanceiro := FALSO
IF lManutencao != NIL
	lFinanceiro := Conf("Alterar financeiro ?")
EndIF
IF Conf("Fechar Fatura Agora ?")
	xAlias->(DbGoTop())
	cTela := Mensagem("Aguarde.", WARNING )
	IF lManutencao != NIL
		cFaturaParaDeletar := IF( cFaturaAnt == cFatura, NIL, cFaturaAnt )
		IF !Devolver( cFaturaAnt, cFaturaParaDeletar, cCaixa, lFinanceiro )
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return( OK )
		EndIF
	EndIF
	IF !Empty( cFaturaPrevenda )
		DeletaPrevenda( cFaturaPrevenda )
	EndIf
Else
	AreaAnt( Arq_Ant, Ind_Ant )
	oIniErase( cFatura )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Set Deci To 4
nDescPerc := ( nTotal / nVlrMerc )
/*---------------------------------------------------------------------------*/
//NNetEnTts()
//NNetTtsBeg()
/*---------------------------------------------------------------------------*/

IF lManutencao = NIL
	IF lAutoFatura
		cFatura := NumeroNota( cFatura, cCodi, dEmis, lAutoFatura )
	EndIF
	Nota->(Order( NOTA_NUMERO ))
	IF Nota->(DbSeek( cFatura ))
	  IF Nota->(TravaReg())
		  Nota->Situacao	 := IF( lManutencao != NIL, 'ALTERADA', 'FATURADA')
		  Nota->Caixa		 := cCaixa
		  Nota->(Libera())
	  EndIF
	EndIF
Else
	nOrdemAnt := Nota->( IndexOrd())
	Nota->(Order( NOTA_NUMERO ))
	IF Nota->(DbSeek( cFatura ))
		IF Nota->(TravaReg())
			Nota->Codi		  := cCodi
			Nota->Atualizado := Date()
			Nota->Situacao   := IF( lManutencao != NIL, 'ALTERADA', 'FATURADA')
			Nota->Caixa 	  := cCaixa
			Nota->(Libera())
		EndIF
	EndIF
	Nota->(Order( nOrdemAnt ))
EndIF
/*---------------------------------------------------------------------------*/

IF lManutencao != NIL
   Recibo->(Order( RECIBO_DOCNR ))
   IF Recibo->(DbSeek(SubStr(cFaturaAnt,2,6)))
      IF Recibo->(TravaArq())
         WHILE Recibo->Docnr = SubStr(cFaturaAnt,2,6)
            Recibo->Fatura := cFaturaAnt
            Recibo->(DbSkip(1))
         EndDo
      EndIF
      Recibo->(Libera())
   EndIF
EndIF

IF lFinanceiro .OR. lManutencao = NIL
   Recibo->(Order( RECIBO_DOCNR ))
   For i := 1 To nConta
      IF Recibo->(DbSeek(aDocnr[i]))
         IF Recibo->(TravaReg())
            Recibo->Vcto       := aVcto[i]
            //Recibo->Vlr        := aVlr[i]
            Recibo->(Libera())
         EndIF
      EndIF
   Next
EndIF

/*---------------------------------------------------------------------------*/
Lista->(Order( LISTA_CODIGO ))
Area("xAlias")
xAlias->(DbGoTop())
WHILE xAlias->(!Eof())
	xCodigo := xAlias->Codigo
	IF Lista->(DbSeek( xCodigo ))
		xGrupo := Lista->CodGrupo
		IF Lista->(TravaReg())
			Lista->Quant		-= xAlias->Quant
			Lista->Data 		:= Date()
			Lista->Atualizado := Date()
		EndIF
		Lista->(Libera())
	EndIF
	nUnitario := xAlias->Unitario
	nPvendido := ( nUnitario * nDescPerc )
	xDesconto := ( nUnitario - nPvendido )
	IF Saidas->(Incluiu())
		Saidas->Codigo 	 := xCodigo
		Saidas->Pvendido	 := nPvendido
		Saidas->Diferenca  := xDesconto
		Saidas->Desconto	 := xAlias->Desconto
		Saidas->Saida		 := xAlias->Quant
		Saidas->Pcusto 	 := xAlias->Pcusto
		Saidas->Pcompra	 := xAlias->Pcompra
		Saidas->Atacado	 := xAlias->Atacado
		Saidas->Varejo 	 := xAlias->Varejo
		Saidas->Docnr		 := cFatura
		Saidas->Data		 := dEmis
		Saidas->Porc		 := nPorc
		Saidas->VlrFatura  := nTotal
		Saidas->Forma		 := cForma
		Saidas->CodiVen	 := cVendedor
		Saidas->Tecnico	 := IF( cTecSimNao = "S", cTecnico, Space(04))
		Saidas->Qtd_D_Fatu := nConta
		Saidas->Codi		 := cCodi
		Saidas->Pedido 	 := cFatura
		Saidas->Emis		 := dEmis
		Saidas->Fatura 	 := cFatura
		Saidas->Regiao 	 := cRegiao
		Saidas->Placa		 := cPlaca
		Saidas->Tipo		 := IF( cTipoVenda = 'S', 'CC', aTipo[1] )
		Saidas->C_C 		 := IF( cTipoVenda = 'S', OK, FALSO )
		Saidas->Atualizado := Date()
		Saidas->Impresso	 := xAlias->Impresso
		Saidas->Serie		 := xAlias->Serie
		Saidas->Situacao	 := IF( lManutencao != NIL, 'ALTERADA', 'FATURADA')
		Saidas->Caixa		 := cCaixa
	EndIF
	Saidas->(Libera())
	xAlias->(DbSkip(1))
EndDo
/*---------------------------------------------------------------------------*/
Receber->(Order( RECEBER_CODI ))
IF Receber->(DbSeek( cCodi )) 				// Localiza Cliente
	IF Receber->(TravaReg())
		Receber->UltCompra  := dEmis			// Registra data da Compra
		Receber->VlrCompra  := nTotal 		// Registra Vlr da Compra
		Receber->Atualizado := Date()
	EndIF
	Receber->(Libera())
EndIF
/*---------------------------------------------------------------------------*/
Set Deci To 2
lBaixarAvista := PodeBaixarTituloAVista()
IF lAutoDocumento
	For nY := 1 To nConta
		IF lDesdobrar
			aDocnr[nY] := Right( cFatura, 6 ) + "-" + StrZero( nY, 2 )
		Else
			aDocnr[nY] := cFatura + "-" + Chr( 64+nY )
		EndIF
	Next
EndIF
IF lFinanceiro .OR. lManutencao = NIL
	For i := 1 To nConta
		IF aVcto[i] = dEmis .AND. lBaixarAVista
			IF Recebido->(Incluiu())
				Recebido->Codi 		:= cCodi
				Recebido->Vlr			:= aVlr[i]
				Recebido->Emis 		:= dEmis
				Recebido->Vcto 		:= aVcto[i]
				Recebido->Docnr		:= aDocnr[i]
				Recebido->Fatura		:= cFatura
				Recebido->DataPag 	:= aVcto[i]
				Recebido->Baixa		:= Date()
				Recebido->VlrPag		:= aVlr[i]
				Recebido->Port 		:= aPort[i]
				Recebido->Juro 		:= aJuro[i]
				Recebido->Tipo 		:= aTipo[i]
				Recebido->Forma		:= cForma
				Recebido->Atualizado := Date()
			EndIF
			Recebido->(Libera())
		Else
			IF Recemov->(Incluiu())
				Recemov->Codi		  := cCodi
				Recemov->CodiVen	  := cVendedor
				Recemov->Caixa 	  := cCaixa
				Recemov->Docnr 	  := aDocnr[i]
				Recemov->Fatura	  := cFatura
				Recemov->Vcto		  := aVcto[i]
				Recemov->Vlr		  := aVlr[i]
				Recemov->Port		  := aPort[i]
            Recemov->Obs        := aObs[i]
				Recemov->Tipo		  := aTipo[i]
				Recemov->Juro		  := aJuro[i]
				Recemov->Regiao	  := cRegiao
				Recemov->VlrFatu	  := nTotal
				Recemov->VlrDolar   := IF( nCotacao = 0, 0, aVlr[i] / nCotacao )
				Recemov->Emis		  := dEmis
				Recemov->Porc		  := nPorc
				Recemov->Jurodia	  := JuroDia( aVlr[i], aJuro[i] )
				Recemov->Forma 	  := cForma
				Recemov->Qtd_D_Fatu := nConta
				Recemov->Titulo	  := IF( aRequisicao[i] = "S", OK, FALSO )
				Recemov->Comissao   := IF( aComis[i]		= "S", OK, FALSO )
				Recemov->Atualizado := Date()
				Recemov->CodGrupo   := xGrupo
				Aadd( aRegistro, Recemov->(Recno()))
				Aadd( aReg, 	  Recemov->(Recno()))
			EndIF
			Recemov->(Libera())
		EndIF
	Next
EndIF
IF nPorc <> 0			  // Lancado Comissao ?
	nPorcDiv := nPorc
	aVend 	:= {}
	Aadd( aVend, cVendedor )
	IF cDivisao == "S"  // Comissao Dividida
		nPorcDiv := ( nPorc / 2 )
		Aadd( aVend, cVendedor1 )
	EndIF
	Area("Vendedor")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	nTamVend := Len( aVend )
	For nV := 1 To nTamVend
		Vendedor->(DbSeek( aVend[nV] ))
		IF Vendedor->(TravaReg())
			For i := 1 To nConta
				nTemp 	  := (( aVlr[i] * nPorcDiv ) / 100 )
				nVlr_Comis := IF( nTemp <= 0, 0, nTemp )
				IF aVcto[I] = dEmis
					IF aComis[i] = "S"
						IF lBaixarAvista
							Vendedor->Comdisp  += nVlr_Comis
						Else
							Vendedor->ComBloq  += nVlr_Comis
						EndIF
					EndIF
				Else
					IF aComis[i] = "S"
						Vendedor->ComBloq  += nVlr_Comis
					 EndIF
				EndIF
				IF aComis[i] = "S"
					Vendedor->Comissao	 += nVlr_Comis
				EndiF
			Next
		EndIF
		Vendedor->(Libera())
		nComis_Disp 	 := 0
		nComis_Bloq 	 := 0
		nVlr_Comis		 := 0
		nComissaoAPagar := 0
		For I := 1 To nConta
			IF aVcto[I] = dEmis
				IF aComis[i] = "S"
					nTemp := (( aVlr[i] * nPorcDiv ) / 100 )
					nTemp := IF( nTemp <= 0, 0, nTemp )
					IF lBaixarAvista
						nComis_Disp += nTemp
					Else
						nComis_Bloq += nTemp
					EndIF
				EndIF
			Else
				IF aComis[i] = "S"
					nTemp 		:= (( aVlr[i] * nPorcDiv ) / 100 )
					nTemp 		:= IF( nTemp <= 0, 0, nTemp )
					nComis_Bloq += nTemp
				EndIF
			EndIF
			IF aComis[i] = "S"
				nTemp 			 := (( aVlr[i] * nPorcDiv ) / 100 )
				nTemp 			 := IF( nTemp <= 0, 0, nTemp )
				nVlr_Comis		 += nTemp
				nComissaoAPagar += aVlr[i]
			EndIF
		Next
		Area("Vendemov")
		IF Vendemov->(Incluiu())
			Vendemov->Pedido		:= cFatura
			Vendemov->DataPed 	:= dEmis
			Vendemov->CodiVen 	:= aVend[nV]
			Vendemov->Vlr			:= nComissaoAPagar
			Vendemov->Data 		:= dEmis
			Vendemov->DocNr		:= cFatura
			Vendemov->Porc 		:= nPorcDiv
			Vendemov->Forma		:= cForma
			Vendemov->Fatura		:= cFatura
			Vendemov->Codi 		:= cCodi
			Vendemov->Regiao		:= cRegiao
			Vendemov->Comissao	:= nVlr_Comis
			Vendemov->Combloq 	:= nComis_Bloq
			Vendemov->Comdisp 	:= nComis_Disp
			Vendemov->Atualizado := Date()
		EndIF
		Vendemov->(Libera())
	Next
EndIF
Cheque->(Order( CHEQUE_CODI ))
IF !Cheque->(DbSeek( cCodiCaixa ))
	IF Cheque->(Incluiu())
		Cheque->Codi		 := cCodiCaixa
		Cheque->Data		 := dEmis
		Cheque->Titular	 := "MOVIMENTO DE CAIXA"
		Cheque->Atualizado := Date()
		Cheque->(Libera())
	EndIF
EndIF
nChSaldo := Cheque->Saldo
Area("Chemov")
IF cTipoVenda = "N"
	IF lFinanceiro .OR. lManutencao = NIL
		For nCh := 1 To nConta
			IF lBaixarAvista
				IF aVcto[nCh] = dEmis
					nChSaldo   += aVlr[nCh]
					IF Chemov->(Incluiu())
						Chemov->Codi		 := cCodiCaixa
						Chemov->Docnr		 := aDocnr[nCh]
						Chemov->Fatura 	 := cFatura
						Chemov->Cre 		 := aVlr[nCh]
						Chemov->Emis		 := dEmis
						Chemov->Data		 := aVcto[nCh]
						Chemov->Baixa		 := Date()
						Chemov->Hist		 := "REC " + cNomeCliente
						Chemov->Saldo		 := nChSaldo
						Chemov->Caixa		 := cCaixa
						Chemov->Tipo		 := aTipo[nCh]
						Chemov->Atualizado := Date()
					EndIF
					Chemov->(Libera())
				EndIF
			EndIF
		Next
	EndIF
EndIF
IF Cheque->(TravaReg())
	Cheque->Saldo := nChSaldo
	Cheque->(Libera())
EndIF
Cheque->(Libera())
//nTransacao := NNetTtsEnd()
ResTela( cTela )
Area("xAlias")
oMenu:Limpa()
cTela 			  := Mensagem("Aguarde, Criando Log.", WARNING )
cScrNota 		  := SaveScreen()
cArquivoAnterior := Alias()
nIndiceAnterior  := IndexOrd()
/*---------------------------------------------------------------------------*/
Aadd( aLog, "FAT" )
Aadd( aLog, Date() )
Aadd( aLog, Time() )
Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
Aadd( aLog, cCaixa )
Aadd( aLog, cVendedor )
Aadd( aLog, Left( cFatura, 7))       // Fatura
Aadd( aLog, Dtoc( dEmis )) 			 // Data de Emissao
Aadd( aLog, cCodi )						 // Cliente
Aadd( aLog, cForma	)					 // Forma Pagamento
Aadd( aLog, Tran( nPorc, '99.99'))   // Comissao
Aadd( aLog, Tran( nTotal,	"@E 9,999,999,999.99")) // Total Venda
Aadd( aLog, Tran( nLimite, "@E 9,999,999,999.99")) // Limite de Credito do Cliente
Aadd( aLog, cAutorizado )									// Venda autorizada Por
LogEvento( aLog, '.FAT', XCABEC_FAT1, XCABEC_FAT2 )
oIniErase( cFatura )
/*---------------------------------------------------------------------------*/
IF lAutoEcf
	CupomFiscal(cCodi, cFatura, nTotal, cForma )
EndIF
WHILE OK
	oMenu:Limpa()
	AreaAnt( cArquivoAnterior, nIndiceAnterior )
	M_Title("ESCOLHA A OPCAO A IMPRIMIR")
	aOpcao := {" Ticket de Venda",;
				  " Cupom Fiscal",;
				  " Promissorias Form Branco",;
				  " Promissorias Form Padrao",;
				  " Duplicata Form Branco",;
				  " Duplicata Form Padrao",;
				  " Boleto Bancario",;
				  " Nota Fiscal",;
				  " Espelho Nota",;
				  " Espelho Nota Parcial",;
				  " Contrato de Venda",;
				  " Carne de Pagamento",;
				  " Posicao de Faturamento",;
				  " Ordem de Servico",;
				  " Ficha/Relacao Cliente",;
				  " Documentos Diversos",;
				  " Cancelar/Fechar Cupom Fiscal",;
				  " Rol Carga/Descarga",;
              " Contrato Confissao Divida"}
	nEscolha := FazMenu( 02, 20, aOpcao, Roloc(Cor()))
	IF nEscolha = 0
		Exit
	ElseIF nEscolha = 1
	  #IFDEF CENTRALCALCADOS
		  TicketCentral( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, cCond, nVlrMerc )
	  #ELSE
			Ticket( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, NIL, cTecnico )
	  #ENDIF
	ElseIF nEscolha = 2
		ErrorBeep()
		IF Conf("Pergunta: Ecf Pronta ?")
			CupomFiscal(cCodi, cFatura, nTotal, cForma )
		EndIF
	ElseIF nEscolha = 3
      ProBranco( cCodi, aReg )
	ElseIF nEscolha = 4
      ProPersonalizado( cCodi, aReg )
	ElseIF nEscolha = 5
		DupPapelBco( cCodi, aReg )
	ElseIF nEscolha = 6
      DupPersonalizado( cCodi, aReg )
	ElseIF nEscolha = 7
		oMenu:Limpa()
		DiretaLivre( cCodi, aReg )
	ElseIF nEscolha = 8
		oMenu:Limpa()
		NotaFiscal( cFatura )
	ElseIF nEscolha = 9
		oMenu:Limpa()
		Espelho( cFatura )
	ElseIF nEscolha = 10
		oMenu:Limpa()
		EspelhoParcial( cFatura )
	ElseIF nEscolha = 11
		ContratoVenda( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, aDocnr, aVcto, aVlr )
	ElseIF nEscolha = 12
		CarnePag( cCodi, aReg )
	ElseIF nEscolha = 13
		PosicaoFatura( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal )
	ElseIF nEscolha = 14
		TicketOrdem( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, aDocnr, aVcto, nTotal )
	ElseIF nEscolha = 15
		oMenu:Limpa()
		RelCli()
	ElseIF nEscolha = 16
      PrnDiversos( cCodi,aReg,cCaixa,cVendedor)
	ElseIF nEscolha = 17
		Cancel_Cupom()
	ElseIF nEscolha = 18
		CargaDescarga()
   ElseIF nEscolha = 19
      ConfDivida( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, aDocnr, aVcto, aVlr )
   ElseIF nEscolha = 20
		Exit
	EndIF
	ResTela( cScrNota )
EndDo
/*---------------------------------------------------------------------------*/
AreaAnt( cArquivoAnterior, nIndiceAnterior )
Area("xAlias")
__DbZap()
aArray := {}
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Imprime_Soma( nTotal )
Return( OK )

Function Vendedor( cCodiVen, nRow, nCol, lTrocarVendedor, cOldVendedor )
************************************************************************
LOCAL aRotina := {{|| Func11() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

IfNil( lTrocarVendedor, OK )
IfNil( cOldVendedor, cCodiVen )
IF Vendedor->(Lastrec() = 0)
	ErrorBeep()
	IF Conf( "Pergunta: Nenhum Vendedor Registrado. Registrar ?" )
		Func11()
	EndIF
	ResTela( cScreen )
	Return( FALSO )
EndIF
Area("Vendedor")
Vendedor->(Order( VENDEDOR_CODIVEN ))
IF Vendedor->(!DbSeek( cCodiVen ))
	Vendedor->(Order( VENDEDOR_NOME ))
	Vendedor->(Escolhe( 03, 01, 22, "CodiVen + 'Ý' + Nome", "CODI NOME DO VENDEDOR", aRotina ))
	cCodiven := Vendedor->Codiven
EndIF
IF Vendedor->Rol = OK
	ErrorBeep()
	AreaAnt( Arq_Ant, Ind_Ant )
	Alerta("Erro: Vendedor Desativado !")
	Return( FALSO )
EndIF
IF lTrocarVendedor == FALSO
	IF cCodiVen != cOldVendedor
		ErrorBeep()
		AreaAnt( Arq_Ant, Ind_Ant )
		Alerta("Erro: Troca de Vendedor nao Permitida.")
		Return( FALSO )
	EndIF
EndIF
IF nRow != NIL
	Write( nRow, nCol, Left( Vendedor->Nome, 37 ))
EndIF
cCodiVen  := Vendedor->CodiVen
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function Tqme( dEmis, dVctoDup )
********************************
IF dVctoDup < dEmis
	ErrorBeep()
	Alerta('Erro: Ta querendo me enganar ?')
	Return( FALSO )
EndIF
Return( OK )

Proc TelaFechaCli()
*******************
MaBox( 00, 0, 12, MaxCol() )
Write( 01, 1 , "Forma Pagto.:    Dia:  ³Prazo.....:")
Write( 02, 1 , "Comissao....:          ³Vendedor 1:")
Write( 03, 1 , "Dividir.....:          ³Vendedor 2:")
Write( 04, 1 , "Tecnico.....:          ³Nome......:")
Write( 05, 1 , "Fatura N§...:          ³Emissao...:")
Write( 06, 1 , "Desconto %..:          ³Liquido...:")
Write( 07, 1 , "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÄDADOS DO CLIENTEÄÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ")
Write( 08, 1 , "Cliente.....:          ³                                                      ")
Write( 09, 1 , "C/C/........:          ³                                                      ")
Write( 10, 1 , "Placa.......:          ³                                                      ")
Write( 11, 1 , "Observacoes.:          ³                                                      ")
Return

Proc TelaFechaTit()
*******************
MaBox( 13, 0, 24, MaxCol() )
Write( 14, 1, "  OBSERVACOES                                                                 " )
Write( 15, 1, "  TITULO N§        VALOR R$  DIAS VENCTO    TIPO  COM TIT JR/MES   PORTADOR   " )
Write( 16, 1 , "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ")
Write( 17, 1 , "A:                                                                            ")
Write( 18, 1 , "B:                                                                            ")
Write( 19, 1 , "C:                                                                            ")
Write( 20, 1 , "D:                                                                            ")
Write( 21, 1 , "E:                                                                            ")
Write( 22, 1 , "F:                                                                            ")
Write( 23, 1 , "G:                                                                            ")
Return

Function PickList( cEntrega )
*****************************
LOCAL aList   := { "RETIRA ", "ENTREGA" }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
IF cEntrega $ aList[1] .OR. cEntrega $ aList[2]
	Return( OK )
Else
	MaBox( 02, 69, 05, 79 )
	IF (nChoice := AChoice( 03, 70, 04, 78, aList )) != 0
		cEntrega := aList[ nChoice ]
	EndIf
EndIF
ResTela( cScreen )
Return( OK )

Function Pick( cTipo, nContaData )
**********************************
LOCAL nLen	  := 1
LOCAL aLista  := { "DH    ", "NP    ","DM    ","CH    ","RQ    ", "BN    ", "CP    ", "DF    ",                   "DL    ", "CT    " }
LOCAL aList   := { " DH-DINHEIRO          ",;
						 " NP-N. PROMISSORIA    ",;
						 " DM-DUPLICATA         ",;
						 " CH-CHEQUE A VISTA    ",;
						 " RQ-REQUISICAO        ",;
						 " BN-BONUS             ",;
						 " CP-CHEQUE PRE-DATADO ",;
						 " DF-DIFERENCA REC/PAG ",;
						 " DL-DIRETA LIVRE      ",;
						 " CT-CARTAO            " }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
LOCAL nX
#IFDEF CICLO
	Return( OK )
#ENDIF
IF LastKey() = ESC .OR. LastKey() = UP
	Return( OK )
EndiF
nLen := Len( aLista )
For nX := 1 To nLen
	 IF cTipo $ aLista[ nX ]
		 IF nContaData > 0 .AND. aLista[ nx ] = aLista[1]
			 ErrorBeep()
			 Alerta("Titulo a Prazo. Nao Pode ser dinheiro.")
			 ResTela( cScreen )
			 Return(FALSO)
		 Else
			 ResTela( cScreen )
			 Return( OK )
		 EndiF
	 EndiF
Next
MaBox( 03, 55, 14, 79 )
IF (nChoice := AChoice( 04, 56, 13, 78, aList )) != 0
	cTipo := aLista[ nChoice ]
	IF nContaData > 0 .AND. cTipo = aLista[1]
		ErrorBeep()
		Alerta("Titulo a Prazo. Nao Pode ser dinheiro.")
		ResTela( cScreen )
		Return(FALSO)
	EndIF
	ResTela( cScreen )
	Return( OK )
EndIF
ResTela( cScreen )
Return( FALSO )

Function VendVend1( cVend, cVend1 )
***********************************
IF cVend == cVend1
	Alerta("Erro: Escolha um vendedor diferente.")
	Return( FALSO )
EndIF
Return( OK )

Function CalculaDesc( nDesc, nTotal, nBruto, nIof )
***************************************************
LOCAL nVlrFin := 0
nTotal  := nBruto
nTotal  -= Round(((nBruto * nDesc ) / 100 ), 2 )
nVlrFin := ( nTotal * nIof ) / 100
nTotal  += nVlrFin
Return( OK )

Function VendaVista( cCond )
****************************
LOCAL nConta := ChrCount("/", cCond ) + 1
LOCAL nCond  := Val( StrExtract( cCond,"/", nConta ))

IF nCond = 0 // Venda a Vista ?
	Return( OK )
EndIF
Return( FALSO )

Function VerificaLimite( xCliente, nTotalCompra, nLimite, cAutorizado, cCond, cFatura )
***************************************************************************************
LOCAL cScreen			:= SaveScreen()
LOCAL Arq_Ant			:= Alias()
LOCAL Ind_Ant			:= IndexOrd()
LOCAL nSoma 			:= 0
LOCAL nRegistroAtual := Recemov->(Recno())
LOCAL nNivel			:= SCI_VENDER_COM_LIMITE_ESTOURADO
LOCAL nResult			:= 0
LOCAL nSdv				:= 0

IF xCliente = "00000" .OR. VendaVista( cCond ) // Venda a Vista ?
	Return( OK )
EndIF
IF oIniValida( cFatura )
	Return( OK )
EndIF

Receber->( Order( RECEBER_CODI ))
Receber->(DbSeek( xCliente ))
nLimite := Receber->Limite
IF VerificarLimiteCredito()
	IF !PodeVenderComLimiteEstourado()
		Recemov->(Order( RECEMOV_CODI ))
		nSoma := 0
		IF Recemov->(DbSeek( xCliente ))
			WHILE Recemov->Codi = xCliente
				nSoma += Recemov->Vlr
				Recemov->(DbSkip(1))
			EndDo
			Recemov->(DbGoTo( nRegistroAtual ))
		EndIF
		nSdv	:= nSoma
		nSoma += nTotalCompra
		IF nSoma > nLimite
			MaBox( 15, 00, 20, MaxCol() )
			nResult := ( nLimite - nSdv ) - nTotalCompra
			nPerc   := ( nResult / nLimite )
			nPerc   *= 100
			Write( 16, 01, "Lc                  + " + Tran( nLimite,        "@E 999,999,999.99"))
			Write( 17, 01, "Saldo Devedor       - " + Tran( nSdv,           "@E 999,999,999.99"))
			Write( 18, 01, "Valor Compra        - " + Tran( nTotalCompra  , "@E 999,999,999.99"))
			Write( 19, 01, "Saldo               = " + Tran( nResult,        "@E 999,999,999.99") + " = " + Tran( nPerc, "[9999.99%]"))
			ErrorBeep()
			IF Alert("Compra + Saldo Devedor Ultrapassa Limite de Credito.;Solicitar Autorizacao para Venda?", {"Sim", "Nao"}) = 1
				IF PedePermissao( nNivel, @cAutorizado )
					ResTela( cScreen )
					Return( OK )
				EndIF
			EndIF
			ResTela( cScreen )
			Return( FALSO )
		EndIF
	EndIF
EndIF
Return( OK )

Function VerificaPosicao( xCliente, cCond, cFatura )
****************************************************
LOCAL cScreen				:= SaveScreen()
LOCAL Arq_Ant				:= Alias()
LOCAL Ind_Ant				:= IndexOrd()
LOCAL nSoma 				:= 0
LOCAL nChoice				:= 0
LOCAL lAtraso				:= FALSO
LOCAL aMenu 				:= {"Cancelar", "Continuar", "Consultar"}
LOCAL lVenderComDebito	:= oSci:ReadBool('permissao','vendercomdebito', FALSO )
LOCAL lUsuarioAdmin		:= oSci:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL nBloqueio			:= oIni:ReadInteger('sistema','bloqueio', 0 )
LOCAL nAtraso				:= 0

IF xCliente = "0000" .OR. VendaVista(cCond)  // Venda a Vista ?
	Return( OK )
EndIF

IF oIniValida( cFatura )
	Return( OK )
EndIF

IF !VerDebitosEmAtraso()
	Return( OK )
EndIF

Recemov->(Order( RECEMOV_CODI ))
IF Recemov->(DbSeek( xCliente ))
	While Recemov->Codi = xCliente
		nAtraso := Date() - Recemov->Vcto
		IF nAtraso > nBloqueio
			lAtraso := OK
			Exit
		EndIF
		Recemov->(DbSkip(1))
	EndDo
EndIF
IF lAtraso
	ErrorBeep()
	WHILE OK
		M_Title("INFORMA: CLIENTE EM ATRASO. ESCOLHA UMA OPCAO")
		nChoice := FazMenu( 15, 10, aMenu )
		Do Case
		Case nChoice = 0 .OR. nChoice = 1
		  ResTela( cScreen )
		  Return( FALSO )

		Case nChoice = 2
			IF !lVenderComDebito
				IF !lUsuarioAdmin
					IF !PedePermissao( SCI_VENDERCOMDEBITOEMATRASO )
						ResTela( cScreen )
						Return( FALSO )
					EndIF
				EndIF
			EndIF
			ResTela( cScreen )
			Return( OK )

		Case nChoice = 3
			RecePosi( 1, xCliente )
		EndCase
	EndDo
EndIF
Return( OK )

Procedure TicketOrdem( cFatu, ARG2, ARG3, ARG4, ARG5, cNomeCliente, nTotal )
****************************************************************************
LOCAL  LOCAL2, LOCAL3, LOCAL4
LOCAL cScreen	 := SaveScreen()
LOCAL cAparelho := Space(40)
LOCAL cMarca	 := Space(40)
LOCAL cModelo	 := Space(29)
LOCAL cDefeito  := Space(64)
LOCAL cTecnico  := Space(64)
LOCAL cObs1 	 := Space(64)
LOCAL cObs2 	 := Space(64)
LOCAL2			 := 51
LOCAL3			 := 0
LOCAL4			 := 66
oMenu:Limpa()
MaBox( 10, 01, 18, 78, "ORDEM DE SERVICO - INFORMACOES COMPLEMENTARES")
@ 11,  02 Say "Aparelho..." Get cAparelho Picture "@!"
@ 12,  02 Say "Marca......" Get cMarca    Picture "@!"
@ 13,  02 Say "Modelo....." Get cModelo   Picture "@!"
@ 14,  02 Say "Defeito...." Get cDefeito  Picture "@!"
@ 15,  02 Say "Tecnico...." Get cTecnico  Picture "@!"
@ 16,  02 Say "Obs........" Get cObs1     Picture "@!"
@ 17,  02 Say "           " Get cObs2     Picture "@!"
Read
IF ( LastKey() = ESC )
	Restela( cScreen )
EndIF
IF Instru80() .OR. Lptok()
	Printon()
	Setprc(0, 0)
	Fprint(Pq)
	nRow := 2
	Write( nRow, 75, cFatu )
	Write( nRow + 5, 15, cNomeCliente )
	Write( nRow + 6, 15, Receber->Ende)
	Write( nRow + 6, 67, Receber->Fone)
	Write( nRow + 7, 15, cAparelho )
	Write( nRow + 8, 15, cMarca )
	Write( nRow + 8, 61, cModelo )
	Write( nRow + 9, 15, cDefeito )
	Write( nRow + 10, 15, cTecnico )
	Write( nRow + 11, 15, cObs1 )
	Write( nRow + 12, 15, cObs2 )
	Write( nRow + 14, 9, Date())
	Write( nRow + 14, 75, Tran( nTotal, "@E 999,999.99"))
	nRow += 21
	Write( nRow, 75, cFatu )
	Write( nRow + 05, 15, cNomeCliente )
	Write( nRow + 06, 15, Receber->Ende)
	Write( nRow + 06, 67, Receber->Fone)
	Write( nRow + 07, 15, cAparelho )
	Write( nRow + 08, 15, cMarca )
	Write( nRow + 08, 61, cModelo )
	Write( nRow + 09, 15, cDefeito )
	Write( nRow + 10, 15, "CONFORME ORCAMENTO N§ " + cFatu )
	Write( nRow + 11, 15, cTecnico )
	Write( nRow + 12, 15, cObs1 )
	Write( nRow + 13, 15, cObs2 )
	Write( nRow + 17, 09, Date())
	Write( nRow + 17, 75, Tran( nTotal, "@E 999,999.99"))
	nRow += 24
	Write( nRow, 75, cFatu )
	Write( nRow + 05, 15, cNomeCliente )
	Write( nRow + 06, 15, Receber->Ende)
	Write( nRow + 06, 67, Receber->Fone)
	Write( nRow + 07, 15, cAparelho )
	Write( nRow + 08, 15, cDefeito )
	Write( nRow + 09, 15, cObs1 )
	Write( nRow + 10, 15, cObs2 )
	Write( nRow + 13, 09, Date())
	Write( nRow + 13, 75, Tran( nTotal, "@E 999,999.99"))
	__Eject()
	Printoff()
EndIF
Return

Function ValidanPorc( nPorc, nPorcAnt )
***************************************
#IFDEF LUIS
	IF nPorc != nPorcAnt
		ErrorBeep()
		Alerta("Erro: Comissao diferente.")
		Return( FALSO )
	EndIF
#ENDIF
Return( OK )

Proc DeletaNota( cFatuNova )
****************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Nota->(Order( NOTA_NUMERO ))
IF Nota->(DbSeek( cFatuNova ))
	IF Nota->(TravaReg())
		Nota->(DbDelete())
		Nota->(Libera())
	EndIF
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return

Function NF( cFatu, cFatu2, lManutencao, cFatuAnt, cFatuNova )
**************************************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL nTam

IF ( Empty( cFatu ) )
	ErrorBeep()
	Alerta( "Erro: Entrada Invalida. ")
	Return( FALSO )
EndIF

IF lManutencao = NIL
	IF Len( AllTrim( cFatu )) < 7
		ErrorBeep()
		Alerta("Erro: Numero Invalido.")
		cFatu := StrZero( Val( cFatu ), 7 )
		Return( FALSO )
	EndIF
EndIF
IF lManutencao != NIL
	IF cFatuAnt == cFatu
		Return( OK )
	EndIF
EndIF

IF cFatu == cFatuNova
	cFatu2 := cFatu
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( OK )
EndIF
Area("Nota")
Nota->(Order( NOTA_NUMERO ))
IF Nota->(DbSeek( cFatu ))
	ErrorBeep()
	IF Conf("Erro: Ja Registrada. Procurar Proxima ?")
		FaturaNaoRegistrada( @cFatu, @cFatuNova )
	Else
		nTam		 := Len( cFatu )
		cFatu 	 := StrZero( Val( cFatu ) +1, nTam)
	EndIF
	cFatu2	 := cFatu
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
cFatu2 := cFatu
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Ticket( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, lPrevenda, cTecnico)
*********************************************************************************************
LOCAL cScreen			:= SaveScreen()
LOCAL xNtx1 			:= FTempName("T*.TMP")
LOCAL cCgc				:= IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
LOCAL cRg				:= IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Rg,  Receber->Insc )
LOCAL cFanta			:= Receber->Fanta
LOCAL cBair 			:= Receber->Bair
LOCAL cEnde 			:= Receber->Ende
LOCAL cNome 			:= Receber->Nome
LOCAL nTotal			:= 0
LOCAL nQuant			:= 0
LOCAL nParcial 		:= 0
LOCAL nCusto			:= 0
LOCAL nRodape			:= 6
LOCAL nCol				:= 33
LOCAL nLinhas			:= 33
LOCAL nDif				:= 0
LOCAL Tam				:= 40
LOCAL nAtiva			:= oIni:ReadInteger('ecf', 'ativa', 2 )
LOCAL cEndeFir 		:= oIni:ReadString('sistema','ramo', Left( XENDEFIR + ' - ' + XFONE + ' - ' + XCCIDA + '/' + XCESTA, 40))
LOCAL nTipoBusca		:= oIni:ReadInteger('sistema','tipobusca', 1 )
LOCAL lMarcaNoTicket := oIni:ReadBool('sistema','nrmarcaticket', FALSO)
STATI nTamForm 		:= 33
STATI xTam				:= 40

Vendedor->(Order( VENDEDOR_CODIVEN ))
IF Vendedor->(DbSeek( cTecnico ))
	cTecnico += ':' + Vendedor->Nome
Else
	cTecnico += Space(36)
EndIF
IF Vendedor->(DbSeek( cVend ))
	cVend += ':' + Vendedor->Nome
Else
	cVend += Space(36)
EndIF
oMenu:Limpa()
MaBox( 10, 05, 17, 72 )
@ 11, 06 Say "Cliente............." Get cNomeCliente Pict "@!"
@ 12, 06 Say "Endereco............" Get cEnde        Pict "@!"
@ 13, 06 Say "Bairro.............." Get cBair        Pict "@!"
@ 14, 06 Say "Vendedor............" Get cVend        Pict "@!"
@ 15, 06 Say "Tecnico............." Get cTecnico     Pict "@!"
@ 16, 06 Say "Comp do Formulario.." Get nTamForm     Pict "99" Valid PickTam({"33 Linhas ", "66 Linhas "}, {33,66}, @nTamForm )
@ 16, 40 Say "Largura Formulario.." Get xTam         Pict "99" Valid PickTam({"40 Colunas", "80 Colunas"}, {40,80}, @xTam )
Read
IF LastKey() = ESC .OR. !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
IF xTam = 40
	Tam = 66
Else
	Tam = 93
EndIF
nLinhas	:= nTamForm
nCol		:= nTamForm
nDif		:= Tam-66
IF cNome <> cNomeCliente
	cFanta := cNomeCliente
EndIF
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
IF Tam = 66
	Fprint( PQ )
Else
	Fprint( _CPI12 )
EndIF
SetPrc(0,0)
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
Qout( GD + Padc( AllTrim( cCabecIni ), Tam/2 ) + CA )
Qout( Padc( Trim( cEndeFir ), Tam ))
Qout( GD + Padc( "ORCAMENTO N§ " + cFatu, Tam/2 ) + CA )
Qout( GD + Padc( "NAO TEM VALOR FISCAL", Tam/2 ) + CA )
Qout( Repl("-", Tam))
Qout( "Cliente..:", cCodi + "  " + AllTrim(cNomeCliente) + "/" + cFanta )
Qout( "CPF/CGC..:", AllTrim(cCgc),  Space(nDif+13), "RG/IE.:", cRg )
Qout( "Endereco.:", AllTrim(cEnde), Space(nDif+12), "Fone..:", Receber->Fone )
Qout( "Cidade...:", Receber->(AllTrim(Cida)) + "/" + Receber->Esta, Space(nDif+15), "Bairro.: " + Left( cBair, 14))
Qout( "Data.....:", Dtoc( dEmis ),'as ' + Time(), 'HR', Space(nDif+08), "Oper..:", cCaixa )
Qout( Repl("-", Tam))
IF Tam = 66
	Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                         TOTAL")
Else
	IF lMarcaNoTicket = OK
		Qout( "CODIGO MARCA         QUANT DESCRICAO DO PRODUTO                           UNITARIO      TOTAL")
	Else
		IF nTipoBusca = 1 // Codigo
			Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                                      UNITARIO      TOTAL")
		Else
			Qout( "N§ ORIGINAL        QUANT DESCRICAO DO PRODUTO                             UNITARIO      TOTAL")
		EndIF
	EndIF
EndIF
Qout( Repl("-", Tam))
nCol	:= 15
While xAlias->(!Eof())
	nCusto	 += ( xAlias->Pcusto * xAlias->Quant )
	nQuant	 += xAlias->Quant
	nPreco	 := ( xAlias->Unitario * xAlias->Quant )
	cPreco	 := Tran( nPreco, "@E 999,999.99")
	cUnitario := Tran( xAlias->Unitario, "@E 999,999.99")
	nTotal	 += nPreco
	nParcial  += nPreco
	IF lPrevenda != NIL
		If !lPrecoPrevenda // Nao Imprimir preco no ticket Prevenda?
			nPreco	 := 0
			nParcial  := 0
			nTotal	 := 0
			nLiquido  := 0
			nDesconto := 0
			cPreco	 := Tran( 0, "@E 999,999.99")
			cUnitario := Tran( 0, "@E 999,999.99")
		EndIF
	Else
		If !lPrecoTicket // Nao Imprimir preco no ticket Normal?
			nPreco	 := 0
			nParcial  := 0
			nTotal	 := 0
			nLiquido  := 0
			nDesconto := 0
			cPreco	 := Tran( 0, "@E 999,999.99")
			cUnitario := Tran( 0, "@E 999,999.99")
		EndIF
	EndIF
	IF Tam = 66
		Qout( xAlias->Codigo, xAlias->Quant, Left( xAlias->Descricao,39), cPreco )
	Else
		IF lMarcaNoTicket = OK
			Qout( xAlias->Codigo, xAlias->Sigla, xAlias->Quant, xAlias->Descricao, Space(03), cUnitario, cPreco )
		Else
			IF nTipoBusca = 1 // Codigo
				Qout( xAlias->Codigo, xAlias->Quant, xAlias->Descricao, Space(14), cUnitario, cPreco )
			Else
				Qout( xAlias->N_Original, xAlias->Quant, xAlias->Descricao, Space(05), cUnitario, cPreco )
			EndIF
		EndIF
	EndIF
	xAlias->(DbSkip(1))
	IF nCol + nRodape >= nTamForm
		IF xAlias->(!Eof())
			IF nCol >= ( nTamForm - 3 )
				__Eject()
				SetPrc( 0, 0 )
				Qout( Repl("-", Tam))
				Qout( GD + Padc( "ORCAMENTO N§ " + cFatu, Tam/2 ) + CA)
				Qout( "N§ Docto.: " + cFatu, Space(nDif+31), "Data : " + Dtoc( dEmis ))
				Qout( Repl("-", Tam))
				IF Tam = 66
					Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                         TOTAL")
				Else
					IF lMarcaNoTicket = OK
						Qout( xAlias->Codigo, xAlias->Sigla, xAlias->Quant, xAlias->Descricao, Space(02), cUnitario, cPreco )
					Else
						IF nTipoBusca = 1 // Codigo
							Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                                      UNITARIO      TOTAL")
						Else
							Qout( "N§ ORIGINAL        QUANT DESCRICAO DO PRODUTO                             UNITARIO      TOTAL")
						EndIF
					EndIF
				EndIF
				Qout( Repl("-", Tam))
				nCol := 6
				Loop
			EndIF
		EndIF
	EndIF
	nCol++
Enddo
Qout( Repl("-", Tam))
nDesconto := ( nLiquido - nTotal )
Qout( "Totais:  " + Tran( nQuant, "999.99") + Space(nDif+38 ) + Tran( nParcial,  "@E 99,999,999.99"))
Qout( "Desc/Acresc..: " + Space(nDif+38 ) + Tran( nDesconto, "@E 99,999,999.99"))
Qout( "Liquido......: " + Space(nDif+38 ) + Tran( nLiquido,  "@E 99,999,999.99"))
Qout( "Vendedor.....: " + Left( cVend, (nDif+20)) + " Tecnico......: " + Left( cTecnico, IF( Tam = 66, 15, 22 )))
IF nAtiva = 1
	Qout( GD + Padc( "EXIJA O CUPOM FISCAL", Tam/2 ) + CA)
EndIF
TickVcto( cFatu )
__Eject()
PrintOff()
Return

Proc TickVcto( cFatu )
**********************
LOCAL cVista	 := "A VISTA "
Recemov->(Order( RECEMOV_FATURA ))
IF Recemov->(DbSeek( cFatu ))
	Qout( "DOCTO N§  TIPO     VCTO       JR DIA     VLR TITULO")
	WHILE Recemov->Fatura = cFatu
		Recemov->(Qout( Docnr, Tipo, IF( Vcto == Emis, cVista, Vcto), Tran( Jurodia, "@E 999,999.99"), Tran( Vlr, "@E 999,999,999.99")))
		Recemov->(DbSkip(1))
	EndDo
EndIF

Proc TicketCentral(cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, cCond )
**************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 51
LOCAL nTotal	 := 0
LOCAL Tam		 := 88
LOCAL nLinhas	 := 16
LOCAL nConta	 := 0

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrInt(_SPACO1_8 )
FPrInt( Chr(ESC) + "C" + Chr(22))
Fprint( PQ )
SetPrc(0,0)
xAlias->(DbGoTop())
While xAlias->(!Eof())
	IF nCol >= nLinhas
      Write( 00, 00, GD + Padc( AllTrim(oAmbiente:xNomefir) - ' - ' + XFONE, Tam/2 ) + CA)
		Write( 01, 00, GD + Padc( "ORCAMENTO", Tam/2 ) + CA)
		Write( 02, 00, GD + Padc( "NAO TEM VALOR FISCAL", Tam/2 ) + CA)
		Fprint( PQ )
		Write( 03, 000, "N§ Docto.: " + cFatu  + " Caixa.: " + cCaixa + " Data.: " + Dtoc( dEmis ) + " Hora..: " + Time())
		Write( 03, 117, "TICKET.:" + cFatu )
		Write( 04, 000, "Cliente..: "+ cCodi + "  " + Left( cNomeCliente, 32)   + " Vendedor..: " + cVend )
		Write( 04, 117, "Data...:" + Dtoc( dEmis ))
		Write( 05, 000, Repl("-", Tam))
		Write( 05, 117, "Hora...:" + Time() )
		Write( 06, 000, "CODIGO DESCRICAO DO PRODUTO                     TAMANH      QTD      UNITARIO      TOTAL")
		Write( 06, 117, "Vend...:" + cVend )
		Write( 07, 000, Repl("-", Tam))
		Write( 07, 117, "Cliente:" + cCodi )
		nCol := 08
	EndIF
	nPreco := ( xAlias->Unitario * xAlias->Quant )
	Qout( xAlias->Codigo, xAlias->Descricao, xAlias->Tam, xAlias->Quant, xAlias->Unitario, Tran( nPreco, "@E 999,999.99"))
	nConta += xAlias->Quant
	nTotal += nPreco
	nCol++
	xAlias->(DbSkip(1))
	IF nCol >= nLinhas .AND. !Eof()
		Write(	nCol, 000, Repl("-", Tam))
		Write( ++nCol, 000, "Total do Ticket....: " + Space( 54) + Tran( nTotal, "@E 99,999,999.99"))
		Write(	nCol, 117, "Total..:" + Tran( nTotal, "@E 99,999,999.99"))
		__Eject()
	EndIF
Enddo
Write(	nCol, 00, Repl("-", Tam))
nDesconto := ( nTotal - nLiquido )
Write( ++nCol, 000, "Total do Ticket....: " + Space( 35 ) + Tran( nConta, "9999.99") + Space(12) + Tran( nTotal,    "@E 99,999,999.99"))
Write( ++nCol, 000, "Desconto...........: " + Space( 54 ) + Tran( nDesconto, "@E 99,999,999.99"))
Write( ++nCol, 000, "Valor Liquido......: " + Space( 54 ) + Tran( nLiquido,  "@E 99,999,999.99"))
Write(	nCol, 117, "Liquido:"              + Tran( nLiquido, "@E 99,999.99"))
Write( ++nCol, 000, Repl("-", Tam ))
Write( ++nCol, 000, GD + Padc( "EXIJA O CUPOM FISCAL", Tam/2 ) + CA)
Fprint( PQ )
Write( ++nCol, 000, Repl("-", Tam ))
Write( ++nCol, 000, "COND.PGTO : " + cCond )
__Eject()
PrintOff()
Return

Proc TicketInter(cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, cCond )
************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 51
LOCAL nTotal	 := 0
LOCAL Tam		 := 132
LOCAL nLinhas	 := 16
LOCAL nConta	 := 0

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrInt(_SPACO1_8 )
FPrInt( Chr(ESC) + "C" + Chr(22))
Fprint( PQ )
SetPrc(0,0)
xAlias->(DbGoTop())
While xAlias->(!Eof())
	IF nCol >= nLinhas
		Write( 00, 00, GD + Padc( "ORCAMENTO - INTERLOJAS", Tam/2 ) + CA)
		Fprint( PQ )
		Write( 01, 000, "N§ Docto.: " + cFatu  + " Caixa.: " + cCaixa + " Data.: " + Dtoc( dEmis ) + " Hora..: " + Time())
		Write( 02, 000, "Cliente..: "+ cCodi + "  " + Left( cNomeCliente, 32)   + " Vendedor..: " + cVend )
		Write( 03, 000, Repl("-", Tam))
		Write( 04, 000, "CODIGO DESCRICAO DO PRODUTO                     TAMANH      QTD      CUSTO         UNITARIO      TOTAL")
		Write( 05, 000, Repl("-", Tam))
		nCol := 06
	EndIF
	nPreco := ( xAlias->Unitario * xAlias->Quant )
	Qout( xAlias->Codigo, xAlias->Descricao, xAlias->Tam, xAlias->Quant, xAlias->Pcusto, xAlias->Unitario, Tran( nPreco, "@E 999,999.99"))
	nConta += xAlias->Quant
	nTotal += nPreco
	nCol++
	xAlias->(DbSkip(1))
	IF nCol >= nLinhas .AND. !Eof()
		Write(	nCol, 000, Repl("-", Tam))
		Write( ++nCol, 000, "Total do Ticket....: " + Space( 68) + Tran( nTotal, "@E 99,999,999.99"))
		__Eject()
	EndIF
Enddo
Write(	nCol, 00, Repl("-", Tam))
nDesconto := ( nTotal - nLiquido )
Write( ++nCol, 000, "Total do Ticket....: " + Space( 35 ) + Tran( nConta, "9999.99") + Space(26) + Tran( nTotal,    "@E 99,999,999.99"))
Write( ++nCol, 000, "Desconto...........: " + Space( 68 ) + Tran( nDesconto, "@E 99,999,999.99"))
Write( ++nCol, 000, "Valor Liquido......: " + Space( 68 ) + Tran( nLiquido,  "@E 99,999,999.99"))
Write( ++nCol, 000, Repl("-", Tam ))
Write( ++nCol, 000, "COND.PGTO : " + cCond )
__Eject()
PrintOff()
Return

Proc PosicaoFatura( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido )
********************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 51
LOCAL nTotal	 := 0
LOCAL Tam		 := 66
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr(33))
nCol	  := 33
nLinhas := 33
SetPrc(0,0)
Qout( GD + Padc(AllTrim(oAmbiente:xFanta),33 ) + CA )
#IFNDEF XRAMO
   Qout( GD + Padc( AllTrim(oAmbiente:xNomefir), 33 ) + CA )
#ELSE
	Qout( GD + Padc( XRAMO, 33 ) + CA )
#ENDIF
Qout( Padc( XENDEFIR + " - " + XCCIDA + " - " + XFONE, 66 ))
Qout( Repl("-", Tam))
Qout( GD + Padc( "POSICAO DE FATURAMENTO", 33 ) + CA)
Qout(  "N§ Docto.: ", cFatu, Space(29), "Data : ", Dtoc( dEmis ))
Qout(  "Cliente..: ", cCodi, cNomeCliente )
Qout(  "Endereco.: ", Receber->Ende, Receber->Fone )
Qout(  Repl("-", Tam))
Qout(  "DOCTO N§              VENCTO                     VALOR")
Qout(  Repl("-", Tam))
nCol := 08

Recemov->(Order( RECEMOV_FATURA ))
IF Recemov->(DbSeek( cFatu ))
	WHILE( Recemov->Fatura = cFatu )
		Qout( Recemov->Docnr, Space(10), Recemov->Vcto, Space(10), Recemov->(Tran( Vlr, "@E 99,999,999.99")))
		nTotal += Recemov->Vlr
		nCol++
		Recemov->(DbSkip(1))
	EndDo
EndIF
IF nCol >= nLinhas .AND. !Eof()
	Qout( Repl("-", Tam))
	Qout( "Total", Space( 35 ) + Tran( nTotal, "@E 99,999,999.99"))
	nTotal := 0
	__Eject()
EndIF
Qout( Repl("-", Tam))
Qout( "Total", Space( 35 ) + Tran( nTotal, "@E 99,999,999.99"))
Qout()
Qout( aMensagem[1] )
Qout( aMensagem[2] )
Qout( aMensagem[3] )
Qout( aMensagem[4] )
__Eject()
PrintOff()
Return

Proc OrcaTicket(cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, cForma, Dpnr, aVcto, VlrDup )
*********************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 10
LOCAL nTotal	 := 0
LOCAL Tam		 := 66
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)

oMenu:Limpa()
MaBox( 10, 10, 13, 65 )
@ 11, 11 Say "Obs........" Get cVendedor Pict "@!"
@ 12, 11 Say "           " Get cMecanico Pict "@!"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
SetPrc(0,0)
FPrint( PQ )
FPrInt( Chr(ESC) + "C" + Chr(48))
//FPrint( _SALTOOFF )  // Inibe Salto de Picote
//FPrInt( Chr(ESC) + "C" + Chr(33))
xAlias->(DbGoTop())
Write( nCol, 04, "")
While xAlias->(!Eof())
	nPreco := ( xAlias->Unitario * xAlias->Quant )
	Qout( Space(04), xAlias->Codigo, Space(01), xAlias->Un, Tran( xAlias->Quant, "9999.99"),  xAlias->Descricao, Space(07), Tran( xAlias->Unitario, "@E 999,999.99"), Space(02), Tran( nPreco, "@E 999,999.99"))
	nTotal += nPreco
	nCol++
	xAlias->(DbSkip(1))
Enddo
nDesconto := ( nTotal - nLiquido )
Write( 33, 05, cCodi + " " + cNomeCliente )
Write( 33, 83, Tran( nTotal,	  "@E 99,999,999.99"))
Write( 35, 83, Tran( nDesconto, "@E 99,999,999.99"))
Write( 37, 05, cVendedor )
Write( 37, 83, Tran( nLiquido, "@E 99,999,999.99"))
Write( 38, 05, cMecanico )
Write( 40, 04, cForma )
Write( 40, 60, cVend )
Write( 40, 81, cFatu )
nTam := Len( Dpnr )
IF nTam > 0
	nRow	:= 42
	nCol	:= 5
	For nX := 1 To nTam
		IF nX > 2
			nRow++
			nCol := 5
		EndIF
		Write( nRow, nCol,	 Dpnr[nX] )
		Write( nRow, nCol+15, Tran( VlrDup[nX],"@E 999,999,999.99"))
		Write( nRow, nCol+37, aVcto[nX] )
		nCol += 47
	Next
EndiF
__Eject()
FPrInt( Chr(ESC) + "C" + Chr(66))
PrintOff()
Return

Proc Pagamentos(cCaixa)
***********************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL cTexto  := "LANCAMENTOS DEB/CRE"
LOCAL cCodi   := "0000"
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL lSair, nSaldo, cDocnr, dEmis, cHist, nVlr, lOpcional
LOCAL cDebCre, cDebCre1, cCodi1, nOpcao, nTotal
FIELD Saldo
cDebCre	:= "C"
cDebCre1 := "C"
oMenu:Limpa()
Area("Cheque")
Cheque->(Order( CHEQUE_CODI ))
IF !DbSeek( cCodi )
	IF Cheque->(!Incluiu())
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	Cheque->Codi	 := cCodi
	Cheque->Data	 := Date()
	Cheque->Titular := "MOVIMENTO DE CAIXA"
EndIF
dEmis   := Date()
cDocnr  := Space(09)
cHist   := Space(40)
nVlr	  := 0
lSair   := FALSO
MaBox( 12, 10, 20, 73 )
Write( 13, 11 , "Codigo....:¯ ")
Write( 14, 11 , "Saldo R$. ¯¯ ")
WHILE OK
	Write( 13, 24 , cCodi + " " + Cheque->Titular )
	Write( 14, 24 , Cheque->(Tran( Saldo, "@ECX 9,999,999,999.99")))
	lOpcional := OK
	cCodi1	 := Space(04)
	@ 15, 11 Say "Data......:¯" Get dEmis    Pict PIC_DATA
	@ 16, 11 Say "Docto. N§.:¯" Get cDocnr   Pict "@K!" Valid CheqDoc( cDocnr ) .OR. LastKey() = UP
	@ 17, 11 Say "Historico.:¯" Get cHist    Pict "@K!" Valid !Empty( cHist ) .OR. LastKey() = UP
	@ 18, 11 Say "Valor.....:¯" Get nVlr     Pict "@E 9,999,999,999.99" Valid nVlr > 0 .OR. LastKey() = UP
	@ 19, 11 Say "D/C.......:¯" GET cDebCre  Pict "!" Valid cDebCre $("CD") .OR. LastKey() = UP
	Read
	IF LastKey() = ESC
		lSair := OK
		Cheque->(Libera())
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Exit

	EndIf
	IF cDebCre = "D" // Debito
		nOpcao := Alerta("Voce Deseja ? ", {" Incluir ", " Alterar "," Sair "} )
		IF nOpcao = 1	// Incluir
			IF CheqDoc( cDocnr )
				Area("CheMov")
				IF Chemov->(Incluiu())
					Cheque->( DbSeek( cCodi ))
					IF Cheque->(TravaReg())
						Cheque->Saldo	:= Cheque->Saldo - nVlr
						nTotal			:= Cheque->Saldo
						Chemov->Codi	:= cCodi
						Chemov->Deb 	:= nVlr
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dEmis
						Chemov->Data	:= dEmis
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nTotal
						Chemov->Caixa	:= cCaixa
						Chemov->Tipo	:= "PG"
						Chemov->(Libera())
						Cheque->(Libera())
					 Else
						Chemov->(DbDelete()) // Registro Branco
						Chemov->(Libera())
						Loop
					 EndIF
				EndIF
			Else
				Loop // Alterar

			EndIf
		ElseIf nOpcao = 2   // Alterar
			Loop

		ElseIF nOpcao = 3  // Sair
			lSair := OK
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Exit

		EndIf

	ElseIf cDebCre = "C"  // Credito
		nOpcao := Alerta("Voce Deseja ? ", {" Incluir ", " Alterar "," Sair "} )
		IF nOpcao = 1 // Incluir
			IF CheqDoc( cDocnr )
				Area("CheMov")
				IF Chemov->(Incluiu())
					Cheque->( DbSeek( cCodi ))
					IF Cheque->(TravaReg())
						Cheque->Saldo	:= Cheque->Saldo + nVlr
						nTotal			:= Cheque->Saldo
						Chemov->Codi	:= cCodi
						Chemov->Cre 	:= nVlr
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dEmis
						Chemov->Data	:= dEmis
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nTotal
						Chemov->Caixa	:= cCaixa
						Chemov->Tipo	:= "RC"
						Chemov->(Libera())
						Cheque->(Libera())
					Else
						Chemov->(DbDelete()) // Registro Branco
						Chemov->(Libera())
						Loop
					EndIF
				Else
					Loop
				EndIF
			Else
				Loop // Alterar
			EndIf
		ElseIf nOpcao = 2 // Alterar
			Loop

		ElseIF nOpcao = 3  // Sair
			lSair := OK
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Exit
		EndIf
	EndIf
EndDo
Return

Function OrcaFunc( Modo, ponteiro )
*********************************
LOCAL GetList := {}
LOCAL Key	  := LastKey()
LOCAL nCol	  := 24
LOCAL nLin	  := 01
LOCAL Registro, Salva_tela, cCodigo, Ind_Ant
		cCampo := aVetor1[2]
		nTam	 := Len( &cCampo. )
Do Case
Case Modo = 1 .OR. Modo = 2 // Topo/Fim de Arquivo
	ErrorBeep()
	Return(1)

Case Modo < 4
	Return(1)

Case LastKey() = ESC
	Return(0)

CASE LastKey() >= 48 .AND. LastKey() <= 122	&&  1 a Z
	IF ValType( cCampo ) = "C"
		xVar := Upper(Chr(Key))
		xVar := xVar + Space( nTam - Len( xVar))
		Keyb(Chr(K_RIGHT))
		@ nCol, nLin Get xVar Pict "@!"
		Read
	EndIF
	xVar := IF( ValType( cCampo ) = "C", AllTrim( xVar ), xVar)
	DbSeek( xVar )
	Return(1)

Case LastKey() = -1	//F2
	Salva_Tela := SaveScreen()
	nRegistro  := Recno()
	Ind_Ant	  := IndexOrd()
	xCodigo	  := 0
	Lista->(Order( LISTA_CODIGO ))
	SetCursor(1)
	MaBox( 04, 09, 06, 36 )
	@ 05, 11 Say  "Codigo a Procurar :" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo)
	Read
	IF LastKey() = ESC
		DbGoto( nRegistro )
	EndIF
	Order( Ind_Ant )
	SetCursor(0)
	ResTela( Salva_Tela )
	Return( 1 )

Case LastKey() = -5 // F6- TROCAR ORDEM
	Order( IF( IndexOrd() = 2, 3, 2 ))
	Return(2)

Otherwise
	Return(1)
EndCase

Function xCliente( cCodi, cNomeCliente, cRegiao, cCond )
********************************************************
LOCAL aRotina			  := {{||CliInclusao()}}
LOCAL aRotinaAlteracao := {{||CliInclusao( OK )}}
LOCAL cScreen			  := SaveScreen()
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL nConta			  := ChrCount("/", cCond ) + 1
LOCAL nCond 			  := Val( StrExtract( cCond,"/", nConta ))
FIELD Codi
FIELD Esta
FIELD Cep
FIELD Cida
FIELD Nome

Area("Receber")
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())
IF Receber->(Eof())
	ErrorBeep()
	IF Conf( "Nenhum Cliente Registrado... Registrar ? " )
		CliInclusao()
	EndIF
	ResTela( cScreen )
	Return( FALSO )
EndIf
IF !DbSeek( cCodi )
	Receber->(Order( RECEBER_NOME ))
	Receber->(DbGoTop())
	Receber->(Escolhe( 03, 00, 22,"Codi + 'Ý' + Nome + 'Ý' + Fone + 'Ý' + Left( Fanta, 15 )", "CODI NOME DO CLIENTE                          TELEFONE       FANTASIA", aRotina,, aRotinaAlteracao ))
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
	EndIF
EndIF
IF !VendaVista(cCond)
	IF Receber->Cancelada	// Ficha Cancelada
		ErrorBeep()
		Alerta("Erro: Ficha cancelada.")
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
	EndIF
EndIF
cNomeCliente := Receber->Nome
cCodi 		 := Receber->Codi
cEsta 		 := Receber->Esta
cRegiao		 := Receber->Regiao
Write( 08, 25, cNomeCliente )
Write( 09, 25, Space( 53 ) )
Write( 09, 25, AllTrim( Ende ) + " - " + AllTrim( Bair ))
Write( 10, 25, Space( 53 ) )
Write( 10, 25, Cep + "/" + AllTrim( Cida ) + " - " + Esta )
Write( 11, 25, Space( 53 ))
Write( 11, 25, Receber->(Left( Obs, 53 )))
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc xIncluiRegistro( lVarejo, oObjeto, lFatCodeBar )
*****************************************************
LOCAL nDesc 			:= 0
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL xCodigo			:= 0
LOCAL nPreco			:= 0
LOCAL nQuant			:= 0
LOCAL nSoma 			:= 0
LOCAL nMerc 			:= 0
LOCAL lSub				:= OK
LOCAL cSerie			:= Space(10)
LOCAL nPrecoAnterior := 0 // Para evitar desconto em cascata
LOCAL nDescMax 		:= 0
LOCAL nItems			:= 0
LOCAL oVenlan			:= TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")

lAutoVenda := oVenlan:ReadBool('permissao','autovenda', FALSO )
Imprime_Soma( @nMerc,, FALSO )
Write( 15, 61, Tran( nMerc, "@E 9,999,999,999.99"))
WHILE OK
	IF ( nItens := xAlias->(Reccount())) >= aItemNff[1]
		ErrorBeep()
		Alerta("A quantidade maxima de registros para emissao da NFF;foi excedida. Caso necessario altere a quantidade de;items da NFF em Arquivos/Configuracao da Base Dados")
		Return
	EndIF
	xCodigo	  := 0
	nPreco	  := 0
	nQuant	  := 0
	nSoma 	  := 0
	lExiste	  := FALSO
	nDescMax   := 0
	IF lZerarDesconto
		nDesc 	  := 0
	EndIF
	TelaSai("INCLUINDO REGISTROS PARA FATURAMENTO")
	If lAutoVenda
		lFatCodeBar := OK
	EndIF
	IF !lFatCodeBar
		@ 18, 09 Get xCodigo Pict PIC_LISTA_CODIGO Valid Produto( @xCodigo, @nPreco, lVarejo, 18, 34, lSub, @nPrecoAnterior, @nQuant, @nDescMax ) .AND. JaExiste( xCodigo, @nQuant, @lExiste )
	  Read
	Else
		Set Conf On
		@ 18, 09 Get xCodigo Pict "9999999999999" Valid Produto( @xCodigo, @nPreco, lVarejo, 18, 34, lSub, @nPrecoAnterior, @nQuant, @nDescMax ) .AND. JaExiste( xCodigo, @nQuant, @lExiste, @nDescMax )
		Read
		Set Conf Off
	EndIF
	IF LastKey() = ESC
		ResTela( cScreen )
		Imprime_Soma()
		Exit
	EndIF
	cDescricao := Lista->Descricao
	IF !lFatCodeBar
		IF lAlterarDescricao
			@ 18, 34 Get cDescricao Pict "@K!" Valid !Empty( cDescricao )
		EndIF
		@ 19, 09 Get nQuant		Pict "99999.99"         Valid nConta_Quant( nQuant ) .OR. LastKey() = UP
		@ 20, 09 Get nDesc		Pict "999.9"            Valid Preco_Desc( @nPreco, nDesc, nPrecoAnterior, NIL, nDescMax )
		@ 21, 09 Get nPreco		Pict "@E 99,999,999.99" Valid ValidaPreco( nPreco, nDesc, nPrecoAnterior ) .AND. nPreco > 0
		IF lSerieProduto	// Entrar com n§ serie Produto ?
			@ 22, 09 Get cSerie	Pict "@!"
		EndIF
	Else
		IF lEditarQuant
			nQuant := 0
		EndIF
		IF nQuant = 0 // Normal
			IF lAlterarDescricao
				@ 18, 34 Get cDescricao Pict "@K!" Valid !Empty( cDescricao )
			EndIF
			@ 19, 09 Get nQuant		Pict "99999.99"         Valid nConta_Quant( nQuant ) .OR. LastKey() = UP
			@ 20, 09 Get nDesc		Pict "99.9"             Valid Preco_Desc( @nPreco, nDesc, nPrecoAnterior, NIL, nDescMax )
			@ 21, 09 Get nPreco		Pict "@E 99,999,999.99" Valid ValidaPreco( nPreco, nDesc, nPrecoAnterior ) .AND. nPreco > 0
			IF lSerieProduto	// Entrar com n§ serie Produto ?
				@ 22, 09 Get cSerie	Pict "@!"
			EndIF
		Else
			IF !nConta_Quant( nQuant )
				Loop
			EndIF
		EndIF
	EndiF
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Imprime_Soma()
		Exit
	EndIF
	IF !lExiste
		xAlias->(DbAppend())
	EndIF
	nSoma 				 := nPreco * nQuant
	xAlias->Codigo 	 := xCodigo
	xAlias->N_Original := Lista->N_Original
	xAlias->Sigla		 := Lista->Sigla
	xAlias->Local		 := Lista->Local
	xAlias->Quant		 := nQuant
	xAlias->Desconto	 := nDesc
	xAlias->DescMax	 := Lista->Desconto
	xAlias->Un			 := Lista->Un
	xAlias->Tam 		 := Lista->Tam
	xAlias->Descricao  := cDescricao
	xAlias->Unitario	 := nPreco
	xAlias->Atacado	 := Lista->Atacado
	xAlias->Varejo 	 := Lista->Varejo
	xAlias->Pcusto 	 := Lista->Pcusto
	xAlias->Pcompra	 := Lista->Pcompra
	xAlias->Porc		 := Lista->Porc
	xAlias->Total		 := nSoma
	xAlias->Serie		 := cSerie
	IF xAlias->(Recno()) <= 11
		oObjeto:gotop()			  // move o cursor para baixo
	Else
		oObjeto:goBottom()		  // move o cursor para esquerda
	EndIF
	oObjeto:ForceStable()
	Imprime_Soma( @nMerc,, FALSO )
	Write( 15, 58, Tran( nMerc, "@E 999,999,999,999.99"))
EndDo

Proc MoviTeste( oOrca )
***********************
LOCAL cScreen := SaveScreen()
LOCAL nReg	  := Lista->(LastRec())
LOCAL nConta  := 0
LOCAL nSoma   := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

MaBox( 10, 10, 12, 50 )
@ 11, 11 Say "Qtde de Registros a anexar :" Get nReg Pict "99999"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF !Conf("Pergunta: Continuar com a anexacao ?")
	ResTela( cScreen )
	Return
EndIF
Lista->(DbGoTop())
While Lista->(!Eof())
	IF nConta = nReg
		Exit
	EndIF
	nConta++
	xAlias->(DbAppend())
	nSoma 				:= Lista->Varejo * 1
	xAlias->Codigo 	:= Lista->Codigo
	xAlias->Quant		:= 1
	xAlias->Un			:= Lista->Un
	xAlias->Descricao := Lista->Descricao
	xAlias->Unitario	:= Lista->Varejo
	xAlias->Atacado	:= Lista->Atacado
	xAlias->Varejo 	:= Lista->Varejo
	xAlias->Pcusto 	:= Lista->Pcusto
	xAlias->Porc		:= Lista->Porc
	xAlias->Total		:= nSoma
	Lista->(DbSkip(1))
EnDdo
oOrca:ForceStable()
ResTela( cScreen )
Return

Function Produto( cCodigo, nPreco, lVarejo, nLine, nCol, lSub, nPrecoAnterior, nQuant, nDescMax  )
**************************************************************************************************
LOCAL GetList			  := {}
LOCAL aRotina			  := {{|| InclusaoProdutos() }}
LOCAL aRotinaAlteracao := {{|| InclusaoProdutos(OK) }}
LOCAL nTipoBusca		  := oIni:ReadInteger('sistema','tipobusca', 1 )
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL nTam				  := 6
LOCAL cTemp
LOCAL cScreen

Set Key F9 To InclusaoProdutos()
IF nPreco = VOID
	IF Empty( cCodigo )
		cCodigo := StrCodigo( cCodigo )
		Set Key F9 To
		Return(OK)
	EndIF
EndIF
cTemp   := IF( ValType(cCodigo) = "N", Str(cCodigo, 13), cCodigo)
nTam	  := Len( AllTrim( cTemp ))
IF nTam <= 6
	nTam	  := 6
	cCodigo :=IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
ElseIF nTam = 8
	nTam	  := 8
	cCodigo := IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
 Else
	nTam	  := 13
	cCodigo := IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
EndIF
Area("Lista")
IF ( Lista->(DbGoTop()), Lista->(Eof()))
	ErrorBeep()
	IF Conf( "Pergunta: Nenhum Produto Registrado. Registrar ? " )
		cScreen := SaveScreen()
		InclusaoProdutos()
		ResTela( cScreen )
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	Set Key F9 To
	Return( FALSO )
EndIF
IF nTam = 6
	Lista->(Order( LISTA_CODIGO ))
ElseIF nTam = 13 .OR. nTam = 8
	Lista->(Order( LISTA_CODEBAR ))
EndIF
IF Lista->( !DbSeek( cCodigo ))
	IF nTipoBusca = 1
		#IFDEF MICROBRAS
			Lista->(Order( LISTA_DESCRICAO ))
			Escolhe( 03, 00, 22, "Codigo + 'Ý' + Left( N_Original, 12 ) + 'Ý' + Descricao + 'Ý' + Tran( Quant, '999.99') + 'Ý' + Tran( Varejo, '@E 9,999.99')","CODI  COD FABR   DESCRICAO DO PRODUTO                      ESTOQUE     PRECO", aRotina,, aRotinaAlteracao )
		#ELSE
			Lista->(Order( LISTA_DESCRICAO ))
         Escolhe( 03, 00, 22, "Codigo + 'Ý' + Sigla + 'Ý' + Left( Descricao, 39 ) + 'Ý' + Tran( Quant, '99999.99') + 'Ý' + Tran( Varejo, '@E 99,999.99')","CODI  MARCA      DESCRICAO DO PRODUTO                      ESTOQUE     PRECO", aRotina,, aRotinaAlteracao )
		#ENDIF
	Else
		Lista->(Order( LISTA_N_ORIGINAL ))
		Escolhe( 03, 00, 22, "N_Original + 'Ý' + Sigla + 'Ý' + Left( Descricao, 31 ) + 'Ý' + Tran( Quant, '9999.99') + 'Ý' + Tran( Varejo, '@E 99,999.99')","COD FABR        MARCA      DESCRICAO DO PRODUTO            ESTOQUE    PRECO", aRotina,, aRotinaAlteracao )
	EndIF
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Set Key F9 To
		Return( FALSO )
	EndIF
EndIF
cCodigo := Lista->Codigo
IF lVarejo != VOID
	Do Case
	Case lVarejo = 1
		nPreco			:= Lista->Atacado
		nPrecoAnterior := Lista->Atacado
	Case lVarejo = 2
		nPreco			:= Lista->Varejo
		nPrecoAnterior := Lista->Varejo
	Case lVarejo = 3
		nPreco			:= Lista->Pcusto
		nPrecoAnterior := Lista->Pcusto
	EndCase
EndIF
IF nLine != VOID
	Write( nLine,	 nCol, Lista->Descricao )
	Write( nLine+3, 09,	 Tran( nPreco, "@E 99,999,999.99"))
	Write( nLine+3, nCol, Lista->N_Original )
	Write( nLine+3, 62,	 Lista->Sigla )
	IF lSub != VOID
		SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
		Grupo->(Order( GRUPO_CODGRUPO ))
		Grupo->(DbSeek( Lista->CodGrupo ))
		Write( nLine+1, nCol, Grupo->CodGrupo + ":"+ Grupo->DesGrupo )
		SubGrupo->(DbSeek( Lista->CodSGrupo ))
		Write( nLine+2, nCol, SubGrupo->CodSgrupo + ":" + SubGrupo->( Left( DessGrupo, 38)))
	EndIF
	Write( nLine+4, nCol, Lista->Tam )
	Write( nLine+4, 62,	 Lista->Desconto )
EndIF
IF nTam = 13 .OR. nTam = 8 .OR. lAutoVenda = OK
	nQuant := 1
EndIF
nDescMax := Lista->Desconto
AreaAnt( Arq_Ant, Ind_Ant )
Set Key F9 To
Return( OK )

Function JaExiste( xCodigo, nQuant, lExiste )
*********************************************
IF !lDuplicidade
	IF xAlias->(DbSeek( xCodigo ))
		IF nQuant = 0
			nQuant++
		EndIF
		nQuant  += xAlias->Quant
		lExiste := OK
	EndiF
EndIF
Return( OK )

Proc xAlterar( lVarejo, lFatCodeBar )
*************************************
LOCAL GetList			:= {}
LOCAL nRecno			:= Recno()
LOCAL lSub				:= OK
LOCAL nDescMax 		:= 0
LOCAL nPrecoAnterior := 0 // Para evitar desconto em cascata
LOCAL xCodigo
LOCAL cSerie
LOCAL nQuant
LOCAL nDesc
LOCAL nPreco
LOCAL nSomaAnt
LOCAL nSomaAtual
FIELD Codigo
FIELD Un
FIELD Descricao
FIELD N_Original

IF Recco() = ZERO
	ErrorBeep()
	Alerta("Erro: Sem Registros...")
	Return
EndIF
DbGoto( nRecno )
SetColor( "W+/R")
TelaSai("ALTERANDO REGISTROS DO FATURAMENTO")
xCodigo		:= xAlias->(Val( Codigo ))
nQuant		:= xAlias->Quant
nDesc 		:= xAlias->Desconto
nPreco		:= xAlias->Unitario
cSerie		:= xAlias->Serie
cDescricao	:= xAlias->Descricao
nSomaAnt 	:= ( nQuant * xAlias->Unitario )

IF !lFatCodeBar
	@ 18, 09 Get xCodigo Pict PIC_LISTA_CODIGO Valid Produto( @xCodigo, @nPreco, lVarejo, 18, 34, lSub, @nPrecoAnterior, NIL, @nDescMax )
	Read
Else
	Set Conf On
	@ 18, 09 Get xCodigo Pict "9999999999999"  Valid Produto( @xCodigo, @nPreco, lVarejo, 18, 34, lSub, @nPrecoAnterior, NIL, @nDescMax )
	Read
	Set Conf Off
EndIF
IF lAlterarDescricao
	@ 18, 34 Get cDescricao Pict "@K!" Valid !Empty( cDescricao )
EndIF
@ 19, 09 Get nQuant		Pict "99999.99"         Valid nConta_Quant( nQuant ) .OR. LastKey() = UP
@ 20, 09 Get nDesc		Pict "99.9"             Valid Preco_Desc( @nPreco, nDesc, nPrecoAnterior, NIL, nDescMax )
@ 21, 09 Get nPreco		Pict "@E 99,999,999.99" Valid ValidaPreco( nPreco, nDesc, nPrecoAnterior )
IF lSerieProduto	// Entrar com n§ serie Produto ?
	@ 22, 09 Get cSerie		Pict "@!"
EndIF
Read
IF LastKey() = ESC
	Imprime_Soma()
	Return
EndIF
nSomaAtual			:= nPreco * nQuant
xAlias->Codigo 	:= xCodigo
xAlias->Quant		:= nQuant
xAlias->Desconto	:= nDesc
xAlias->Un			:= Lista->Un
IF lAlterarDescricao
	xAlias->Descricao := cDescricao
Else
	xAlias->Descricao := Lista->Descricao
EndIF
xAlias->Atacado	:= Lista->Atacado
xAlias->Pcusto 	:= Lista->Pcusto
xAlias->Porc		:= Lista->Porc
xAlias->Tam 		:= Lista->Tam
xAlias->Unitario	:= nPreco
xAlias->Total		:= nSomaAtual
xAlias->Serie		:= cSerie
Imprime_Soma()
Return

Function Preco_Desc( nPv_Atual, nPerc, nPrecoAnterior, lArredondar, nDescMax )
******************************************************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL nNivel  := SCI_PODE_EXCEDER_DESCONTO_MAXIMO
LOCAL nPv_c_Desc

IF nDescMax != NIL
	IF nPerc > nDescMax	// Desconto Maximo Permitido
		IF !PodeExcederDescMax()
			IF !aPermissao[ nNIvel ]
				AreaAnt( Arq_Ant, Ind_Ant )
				ErrorBeep()
				Alert("Erro: Desconto Maximo Excedido.")
				Return( FALSO )
			EndIF
		EndIF
	EndIF
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
nPv_c_Desc := ( nPrecoAnterior * nPerc ) / 100
nPv_Atual  := Round(( nPrecoAnterior - nPv_c_Desc ), 2 )
Return(OK)

Function ValidaPreco( nPv_Atual, nPerc, nPrecoAnterior, lArredondar )
********************************************************************
LOCAL nPv_c_Desc := 0
LOCAL nAtual	  := 0

nPv_c_Desc := ( nPrecoAnterior * nPerc ) / 100
IF lArredondar = NIL
	nAtual  := Round(( nPrecoAnterior - nPv_c_Desc ), 2 )
Else
	nAtual  := ( nPrecoAnterior - nPv_c_Desc )
EndIF
IF nPv_Atual < nAtual
	IF !PodeExcederDescMax()
		ErrorBeep()
		Alerta("Erro: Valor menor que o minimo.")
		Return( FALSO )
	EndIF
EndIF
Return(OK)

Proc Troco( nVlrMercadoria)
***************************
LOCAL nTroco := 0

MaBox( 17, 00, 23, 79, "ESC Retorna     CALCULO DE TROCO")
WHILE OK
	@ 19, 25 Say "DH/CH......: [+]" Get nTroco         Pict "@E 999,999,999.99"
	@ 20, 25 Say "MERCADORIA.: [-]" Get nVlrMercadoria Pict "@E 999,999,999.99"
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	Write( 21, 25, Repl("_",31))
	Write( 22, 25, "TROCO......:     " + Tran((nTroco - nVlrMercadoria),"@E 999,999,999.99"))
EndDo

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()
IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("SAIDAS")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("RECEBER")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("VENDEMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("RECEMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("NOTA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("RECEBIDO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CHEQUE")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CHEMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("TAXAS")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("GRUPO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("SUBGRUPO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("PAGAR")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("PAGAMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("REGIAO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CHEPRE")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("PAGO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("FORMA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CEP")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("REPRES")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("PREVENDA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("AGENDA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("RECIBO")
	MensFecha()
	Return
EndiF
Return

Proc VerPosicao( cCaixa)
************************
LOCAL cScreen	  := SaveScreen()
LOCAL Op 		  := 1
LOCAL nChoice	  := 1
LOCAL aMenu 	  := {"Contas a Receber", "Contas Recebidas","Conta Corrente Individual", "Conta Corrente Geral", "Saldo Comissao Vendedor"}
LOCAL aMenuArray := {"Receber Por Codigo",;
							"Receber Por Regiao",;
							"Receber Por Periodo",;
							"Receber Por Tipo",;
							"Receber Geral",;
							"ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ",;
							"Recebido Por Codigo",;
							"Recebido Por Periodo",;
							"Recebido Por Regiao",;
							"Recebido Geral"}


M_Title("TIPO DE CONSULTA")
oMenu:Limpa()
nChoice := FazMenu( 05, 07, aMenu, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 3
	Debitoc_c()
	ResTela( cScreen )
	Return
Case nChoice = 4
	DebitoValor()
	ResTela( cScreen )
	Return
Case nChoice = 5
	SaldoConsulta()
	ResTela( cScreen )
	Return
EndCase
WHILE OK
	M_Title("POSICAO DO CLIENTE")
	Op := FazMenu( 07, 10, aMenuArray, Cor())
	IF Op = 0
		Exit
	ElseIF Op <= 5
      RecePosi( Op, NIL, cCaixa )
	ElseIF Op = 7
		RecePago( 1 )
	ElseIF Op = 8
		RecePago( 2 )
	ElseIF Op = 9
		RecePago( 4 )
	ElseIF Op = 10
		RecePago( 3 )
	EndIF
EndDo
ResTela( cScreen )
Return

Proc ManuFatura( cCaixa, lFatCodeBar )
**************************************
LOCAL cScreen			:= SaveScreen()
LOCAL nChoice			:= 2
LOCAL lVarejo			:= 2
LOCAL aDevolucao		:= {}
LOCAL cVendedor		:= Space(40)
LOCAL cString			:= "INCLUSAO/DEVOLUCAO/EXCLUSAO DE FATURAMENTO"
LOCAL xNtx				:= FTempName("T*.TMP")
LOCAL nNivel			:= SCI_DEVOLUCAO_FATURA
LOCAL nVlrMercadoria := 0
LOCAL cFaturaAnt		:= Space(07)
LOCAL lFinanceiro 	:= OK
LOCAL Handle
LOCAL oOrca
LOCAL Coluna
LOCAL nKey
LOCAL cTela
LOCAL Arq_Ant
LOCAL Ind_Ant
LOCAL cFatu
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Total
LOCAL cDocnr
PRIVA xAlias

lFatCodeBar := IF( lFatCodeBar = NIL, FALSO, lFatCodeBar )
IF cCaixa = NIL .OR. Empty( cCaixa	)
	IF !VerSenha( @cCaixa, @cVendedor )
		ResTela( cScreen )
		Return
	EndIF
EndIF
oMenu:Limpa()
M_Title( "MANUTENCAO DA FATURA" )
nChoice := FazMenu( 05, 10, {"Pre‡o Atacado","Pre‡o Varejo", "Pre‡o Custo"} )
IF nChoice = 0
	ResTela( cScreen )
	Return
EndIF
lVarejo := nChoice
oMenu:Limpa()
Set Key F5 To
WHILE OK
	oMenu:Limpa()
	cFatu 	  := Space(7)
	aDevolucao := {}
	MaBox( 18, 10, 20, 32 )
	@ 19, 11 Say "Fatura N§...:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Mensagem("Aguarde...", Cor())
		Return
	EndIF
	IF !aPermissao[ nNivel ]
		IF !PedePermissao( nNivel )
			Restela( cScreen )
			Loop
		EndIF
	EndIF
	Handle := FaturaNew()
	Use (Handle ) Alias xAlias Exclusive New
	oMenu:Limpa()
	Area("xAlias")
	Lista->(Order( LISTA_CODIGO ))
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	Area("Saidas")
	Set Rela To Codigo Into Lista
	Saidas->(Order( SAIDAS_FATURA ))
	Saidas->(DbGoTop())
	Saidas->(DbSeek( cFatu ))
	aDevolucao := { Saidas->Emis, Saidas->CodiVen, Saidas->Forma,;
						 Saidas->Codi, Saidas->Porc, Left( Saidas->Fatura,7),;
						 Saidas->Tecnico }
	oBloco := {|| Saidas->Fatura = cFatu }
	WHILE Eval( oBloco )
		xAlias->(DbAppend())
		xAlias->Codigo 	:= Saidas->Codigo
		xAlias->Quant		:= Saidas->Saida
		xAlias->Desconto	:= Saidas->Desconto
		xAlias->Unitario	:= Saidas->Pvendido
		xAlias->Atacado	:= Saidas->Atacado
		xAlias->Varejo 	:= Saidas->Varejo
		xAlias->Pcusto 	:= Saidas->Pcusto
		xAlias->Pcompra	:= Saidas->Pcompra
		xAlias->Porc		:= Saidas->Porc
		xAlias->Total		:= Saidas->VlrFatura
		xAlias->Impresso	:= Saidas->Impresso
		xAlias->Un			:= Lista->Un
		xAlias->Descricao := Lista->Descricao
		xAlias->Local		:= Lista->Local
		Saidas->(DbSkip(1))
	EndDo
	Area("xAlias")
	Inde On Codigo To ( xNtx )
	Print(00,01, Padc( cString, MaxCol()-1), 31 )
	oOrca := FazBrowse( 01, 01, 15, (MaxCol()-1) )
	WHILE OK
		Mostra_Soma()
		oOrca:ForceStable()
		IF oOrca:HitTop .OR. oOrca:HitBottom
			ErrorBeep()
		EndIf
		nKey	  := InKey( ZERO )
		Arq_Ant := Alias()
		Ind_Ant := IndexOrd()
		IF nKey == K_ESC
			 ErrorBeep()
			 IF Conf("Pergunta: Cancelar Alteracoes ?")
				Exit
			 EndIF
	  ElseIf nKey == TECLA_INSERT .OR. nKey == TECLA_MAIS .OR. nKey = ENTER
		  xIncluiRegistro( lVarejo, oOrca, lFatCodebar )
		  oOrca:RefreshAll()
		  DbGoBoTTom()
	  ElseIf nKey == ASTERISTICO
		  Mostra_Soma()
	  ElseIf nKey == TECLA_DELETE
		  xDeletar()
		  oOrca:refreshCurrent():forceStable()
		  oOrca:up():forceStable()
		  Freshorder( oOrca)
	  ElseIf nKey == CTRL_Q
		  xLimpaFatura()
		  oOrca:RefreshAll()
	  ElseIf nKey == CTRL_ENTER
		  xAlterar( lVarejo, lFatCodeBar )
		  oOrca:RefreshAll()
	  ElseIf nKey == F5
		  cTela := SaveScreen()
		  OrcaLista( lVarejo )
		  ResTela( cTela )
	  ElseIf nKey == F10
		  oMenu:Limpa()
		  lManutencao := OK
		  lSair := Fecha( cCaixa, lManutencao, aDevolucao )
		  ResTela( cScreen )
		  Mostra_Soma()
		  oOrca:RefreshAll()
		  IF lSair
			  Exit
		  EndIF
	  ElseIf nKey == F11
		  ErrorBeep()
		  IF Conf("Pergunta: Fazer Devolucao total desta Fatura ?")
			  cFaturaAnt  := aDevolucao[06]
			  cScr		  := SaveScreen()
			  lFinanceiro := OK
			  Devolver( cFaturaAnt, cFatu, cCaixa, lFinanceiro )
			  ResTela( cScr )
			  Exit
		  EndIF
	  ElseIf nKey == F12
		  cTela := SaveScreen()
		  CalcValor()
		  ResTela( cTela )
	  Else
		  TestaTecla( nKey, oOrca )
	  EndIf
	  Print(00,01, Padc( cString, MaxCol()-1), 31 )
	  AreaAnt( Arq_Ant, Ind_Ant )
	  Mostra_Soma()
	EndDo
	ResTela( cScreen )
	Mensagem("Aguarde...", Cor())
	xAlias->(DbCloseArea())
	FClose( Handle )
	Ferase( Handle )
	Return
EndDo

Proc xLimpaFatura()
*******************
ErrorBeep()
IF Conf(" Limpar Fatura ?")
	cFaturaPrevenda := Space(07)
	Sele xAlias
	__DbZap()
EndIF
Return

Function Devolver( cFatuAnt, cFatuParaDeletar, cCaixa, lFinanceiro )
********************************************************************
LOCAL GetList		  := {}
LOCAL cScreen		  := SaveScreen()
LOCAL nComis_Disp   := 0
LOCAL nComis_Bloq   := 0
LOCAL nVlrMovimento := 0
LOCAL nVlrDebito	  := 0
LOCAL nConta		  := 0
LOCAL cVendedor	  := ""
LOCAL cCodiCheque   := Space(4)
LOCAL cCodiCliente  := Space(4)
LOCAL xCodigo		  := Space(6)
LOCAL aLog			  := {}
LOCAL dEmis 		  := Date()
LOCAL nSaida
lOCAL cTela
LOCAL oBloco
LOCAL Vlr_Dev
LOCAL Codi_Ven
LOCAL cForma
LOCAL cRegiao
LOCAL cPlaca
LOCAL cTipo
LOCAL nQtd_d_Fatu
LOCAL nVlrFatura

/*---------------------------------------------------------------------------*/
ccFatu := cFatuAnt
Mensagem("Aguarde, Devolvendo Fatura &ccFatu.", Roloc(Cor()))
/*---------------------------------------------------------------------------*/
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatuAnt ))
	cCodiCliente  := Saidas->Codi
	cCodiCheque   := Space(04)
	dEmis 		  := Saidas->Data
	cForma		  := Saidas->Forma
	Codi_Ven 	  := Saidas->CodiVen
	cRegiao		  := Saidas->Regiao
	cPlaca		  := Saidas->Placa
	cTipo 		  := Saidas->Tipo
	nQtd_d_Fatu   := Saidas->Qtd_d_Fatu
	nVlrFatura	  := Saidas->VlrFatura
	nComis_Disp   := 0
	nComis_Bloq   := 0
	nVlrMovimento := 0
	oBloco		  := {|| Saidas->Fatura = cFatuAnt }
	Vlr_Dev		  := ( Saidas->VlrFatura * Saidas->Porc ) / 100
	WHILE EVal( oBloco )
		nSaida  := Saidas->Saida
		xCodigo := Saidas->Codigo
		IF Lista->(DbSeek( xCodigo ))
			IF Lista->(TravaReg())
				Lista->Quant += nSaida
				Lista->(Libera())
			EndIF
		EndIF
		IF Saidas->(TravaReg())
			Saidas->(DbDelete())
			Saidas->(Libera())
		EndIF
		Saidas->(DbSkip(1))
	EndDo
/*---------------------------------------------------------------------------*/
	IF cFatuParaDeletar != NIL
		IF Saidas->(Incluiu())
			Saidas->Codi		 := cCodiClient
			Saidas->Fatura 	 := cFatuAnt
			Saidas->Docnr		 := cFatuAnt
			Saidas->Forma		 := cForma
			Saidas->Pedido 	 := cFatuAnt
			Saidas->Regiao 	 := cRegiao
			Saidas->Placa		 := cPlaca
			Saidas->Tipo		 := cTipo
			Saidas->Emis		 := dEmis
			Saidas->Data		 := dEmis
			Saidas->Qtd_d_Fatu := nQtd_d_Fatu
			Saidas->VlrFatura  := nVlrFatura
			Saidas->Atualizado := Date()
			Saidas->Impresso	 := OK
			Saidas->Situacao	 := 'EXCLUIDA'
			Saidas->Caixa		 := cCaixa
			Saidas->(Libera())
		EndIF
		Nota->( Order( NOTA_NUMERO ))
		IF Nota->( DbSeek( cFatuParaDeletar ))
			IF Nota->(TravaReg())
				Nota->Situacao := 'EXCLUIDA'
				Nota->Caixa 	:= cCaixa
				Nota->(Libera())
			EndIF
		EndIF
	EndIF
/*---------------------------------------------------------------------------*/
IF lFinanceiro
	Recemov->(Order( RECEMOV_FATURA ))
	oBloco := {|| Recemov->Fatura = cFatuAnt }
	IF Recemov->( DbSeek( cFatuAnt ))
		WHILE Eval( oBloco )
			nComis_Bloq += ( Recemov->Vlr * Recemov->Porc) / 100
			IF Recemov->(TravaReg())
				Recemov->(DbDelete())
				Recemov->(Libera())
			EndIF
			Recemov->(DbSkip(1))
		EndDo
	EndIF
/*---------------------------------------------------------------------------*/
	nComis_Disp := ( Vlr_Dev - nComis_Bloq )
	Recebido->(Order( RECEBIDO_FATURA ))
	oBloco := {|| Recebido->Fatura = cFatuAnt }
	IF Recebido->( DbSeek( cFatuAnt ))
		WHILE Eval( oBloco )
			IF Recebido->(TravaReg())
				Recebido->(DbDelete())
				Recebido->(Libera())
			EndIF
			Recebido->(DbSkip(1))
		EndDo
	EndIF
/*---------------------------------------------------------------------------*/
	Chemov->(Order( CHEMOV_FATURA ))
	WHILE Chemov->( DbSeek( cFatuAnt ))
		cCodiCheque 		 := Chemov->Codi
		nVlrCredito 		 := Chemov->Cre
		nVlrDebito			 := Chemov->Deb
		IF Chemov->(TravaReg())
			Chemov->(DbDelete())
			Chemov->(Libera())
		EndIF
		IF Cheque->(DbSeek( cCodiCheque ))
			IF Cheque->(TravaReg())
				Cheque->Debitos	 -= nVlrDebito
				Cheque->Saldo		 -= nVlrDebito
				Cheque->Creditos	 += nVlrCredito
				Cheque->Saldo		 += nVlrCredito
				Cheque->Atualizado := Date()
				Cheque->(Libera())
			EndIF
		EndIF
	EndDo
Endif lFinanceiro
/*---------------------------------------------------------------------------*/
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	VendeMov->(Order( VENDEMOV_FATURA ))
	IF Vendemov->( DbSeek( cFatuAnt ))
		WHILE Vendemov->Fatura = cFatuant
			nConta++ 					// Soma vendedores da Fatura
			Vendemov->(DbSkip(1))
		EndDo
	EndIF
	nConta := IF( nConta = 0, 1, nConta )
	IF Vendemov->( DbSeek( cFatuAnt ))
		WHILE Vendemov->Fatura = cFatuant
			cVendedor := Vendemov->CodiVen
			IF Vendemov->(TravaReg())
				Vendemov->(DbDelete())
				Vendemov->(Libera())
			EndIF
			Vendemov->(DbSkip(1))
			IF Vendedor->(DbSeek( cVendedor ))
				IF Vendedor->( TravaReg())
					Vendedor->ComBloq  -= ( nComis_Bloq / nConta )
					Vendedor->ComDisp  -= ( nComis_Disp / nConta )
					Vendedor->Comissao -= ( Vlr_Dev		/ nConta )
					Vendedor->(Libera())
				EndIF
			EndIF
		EndDo
	EndIF
	/*---------------------------------------------------------------------------*/
   Aadd( aLog, "DEV" )
	Aadd( aLog, Dtoc( Date())) 			 // Data da Devolucao
	Aadd( aLog, Time())						 // Hora do Sistema
	Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
   Aadd( aLog, cCaixa )                 // Caixa
   Aadd( aLog, cVendedor )              // Vendedor
   Aadd( aLog, Left( cFatuAnt, 7))      // Fatura
	Aadd( aLog, Dtoc( dEmis )) 			 // Data do Faturamento
   Aadd( aLog, cCodiCliente )           // Cliente
   LogEvento( aLog, '.FAT', XCABEC_FAT1, XCABEC_FAT2 )
	/*---------------------------------------------------------------------------*/
Else
	ErrorBeep()
	Alerta("Erro: Registros de saidas nao localizados.")
	ResTela( cScreen )
	Return( FALSO )
EndIF
Return( OK )

Proc DevolverEntra( cDocnr )
****************************
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi
LOCAL nEntrada
LOCAL xCodigo
LOCAL oBloco

/*---------------------------------------------------------------------------*/
ccFatu := cDocnr
Mensagem("Aguarde, Devolvendo Fatura &ccFatu.")
/*---------------------------------------------------------------------------*/
Lista->(Order( LISTA_CODIGO ))
Entradas->(Order( ENTRADAS_FATURA ))
IF Entradas->(DbSeek( cDocnr ))
	cCodi  := Entradas->Codi
	oBloco := {|| Entradas->Fatura = cDocnr }
	WHILE EVal( oBloco )
		nEntrada := Entradas->Entrada
		xCodigo	:= Entradas->Codigo
		IF Lista->(DbSeek( xCodigo ))
			IF Lista->(TravaReg())
				Lista->Quant -= nEntrada
				Lista->(Libera())
			EndIF
		EndIF
		IF Entradas->(TravaReg())
			Entradas->(DbDelete())
			Entradas->(Libera())
		EndIF
		Entradas->(DbSkip(1))
	EndDo
	Pagamov->(Order( PAGAMOV_CODI ))
	IF Pagamov->(DbSeek( cCodi ))
		WHILE Pagamov->Codi = cCodi
			IF Pagamov->Fatura = cDocnr
				IF Pagamov->(TravaReg())
					Pagamov->(DbDelete())
					Pagamov->(Libera())
				EndIF
			EndIF
			Pagamov->(DbSkip(1))
		EndDo
	EndIF
	EntNota->(Order( ENTNOTA_NUMERO ))
	IF EntNota->(DbSeek( cDocnr ))
		IF EntNota->(TravaReg())
			EntNota->(DbDelete())
			EntNota->(Libera())
		EndIF
	EndIF
Else
	ErrorBeep()
	Alerta("Erro: Registros de Entradas nao localizados.")
	ResTela( cScreen )
	Return( FALSO )
EndIF
DbUnLockAll()
Return( OK )

Proc ImprimeContrato( nTipo )
*****************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL cFatura		 := Space(07)
LOCAL cCaixa		 := ""
LOCAL cVendedor	 := ""
LOCAL dEmis 		 := Date()
LOCAL cCodi 		 := Space(04)
LOCAL cNomeCliente := ""
LOCAL nTotal		 := 0
LOCAL aDocnr		 := {}
LOCAL aVcto 		 := {}
LOCAL aVlr			 := {}

oMenu:Limpa()
MaBox( 18, 10, 20, 32 )
@ 19, 11 Say "Fatura N§...¯" Get cFatura Pict "@!" Valid VisualAchaFatura( @cFatura )
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
cCodi  := Saidas->Codi
nTotal := Saidas->VlrFatura
Receber->(Order( RECEBER_CODI ))
IF Receber->(DbSeek( cCodi ))
	cNomeCliente := Receber->Nome
EndIF
Recemov->(Order( RECEMOV_FATURA ))
IF Recemov->( DbSeek( cFatura ))
	While Recemov->Fatura = cFatura
		Aadd( aDocnr, Recemov->Docnr )
		Aadd( aVcto,  Recemov->Vcto )
		Aadd( aVlr,   Recemov->Vlr )
		Recemov->(DbSkip(1))
	EndDo
EndIF
Recebido->(Order( RECEBIDO_FATURA ))
IF Recebido->( DbSeek( cFatura ))
	While Recebido->Fatura = cFatura
		Aadd( aDocnr, Recebido->Docnr )
		Aadd( aVcto,  Recebido->Vcto )
		Aadd( aVlr,   Recebido->Vlr )
		Recebido->(DbSkip(1))
	EndDo
EndIF
IF nTipo = NIL .OR. nTipo = 1
   ContratoVenda( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, aDocnr, aVcto, aVlr )
Else
   ConfDivida( cFatura, cCaixa, cVendedor, dEmis, cCodi, cNomeCliente, nTotal, aDocnr, aVcto, aVlr )
EndIF
ResTela( cScreen )
Return

STATIC Proc ContratoVenda( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
************************************************************************************************************
#IFDEF MICROBRAS
	ComVenContrato( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
	Return
#ENDIF
#IFDEF COMVEN
	ComVenContrato( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
	Return
#ENDIF
#IFDEF SANTAMARIA
	ContratoStaMaria( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
	Return
#ENDIF
#IFDEF COLCHOES
	ContratoColchoes( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
	Return
#ENDIF
#IFDEF CENTRALCALCADOS
	ContratoCentral( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
	Return
#ENDIF
ContratoOutros( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
Return

STATIC Proc ContratoColchoes( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
***************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 00
LOCAL nTotal	 := 0
LOCAL Tam		 :=  CPI1280
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
PrintOn()
FPrint( _CPI12 )
FPrint( _SPACO1_8 )
SetPrc(0,0)
Write(	nCol, 00, "")
Write( ++nCol, 00, NG + Padc("INSTRUMENTO PARTICULAR DE CONTRATO DE COMPRA E VENDA COM RESERVA DE DOMINIO - N§ " + cFatu, Tam ) + NR )
Write( ++nCol, 00, Repl("-", Tam ))
nCol++
Write( ++nCol, 00, "        Os infra assinados, de um lado CASA DOS COLCHOES LTDA, pessoa juridica de direitos pri-")
Write( ++nCol, 00, "vado, estabelecida nesta cidade de Pimenta Bueno/Ro., sito a Av Castelo Branco, 773, devidamen-")
Write( ++nCol, 00, "te inscrita no CGC/MF sob o n§ 15.875.594/00001-51, Inscricao Estadual n§ 407.15974-3, simples-")
Write( ++nCol, 00, "mente denominada VENDEDORA, e, do outro lado o Sr(a) " + cNomeCliente +".")
Write( ++nCol, 00, "simplesmente denominado(a) COMPRADOR, tem justos e contratados a venda e compra do seguinte:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "CODIGO PRODUTO                                  MARCA      MODELO              QTDE")
Write( ++nCol, 00, Repl("-", Tam ))
Lista->(Order( LISTA_CODIGO ))
Area("SAIDAS")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Saidas->Codigo Into Lista
Saidas->(DbSeek( cFatu ))
While Saidas->Fatura = cFatu
	nPreco := Saidas->Pvendido
	Qout( Saidas->Codigo, Lista->Descricao, Lista->Sigla, Lista->N_Original, Saidas->Saida, Saidas->Serie )
	nCol++
	Saidas->(DbSkip(1))
Enddo
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "de propriedade da primeira contratante, mediante as condicoes e clausulas seguintes:")
nCol++
Write( ++nCol, 00, "1¦) - O preco de venda e de R$ " + AllTrim( Tran( nLiquido, "@E 999,999,999.99")) + " cujo pagamento o COMPRADOR se obriga a realizar")
Write( ++nCol, 00, "do seguinte modo:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "N§ DUPLICATA         VENCIMENTO                  VALOR       OBS")
Write( ++nCol, 00, Repl("-", Tam ))
nLen := Len( Dpnr )
nSoma := 0
For nY := 1 To nLen
	Qout( Dpnr[nY], Space(10), aVcto[nY], Space(10), Tran( VlrDup[nY],"@E 99,999,999.99"), Space(05), "_______" )
	nCol++
	nSoma += VlrDup[nY]
Next
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "com duplicata de emissao da VENDEDORA e aceite do COMPRADOR e avalizada por:")
Write( ++nCol, 00, Receber->Conhecida )
Write( ++nCol, 00, "as quais ficam fazendo parte integral no presente instrumento.")
nCol++
Write( ++nCol, 00, "2¦) - Por forca do pagamento de reserva de dominio, aqui expressamente instituido, e aceito pe-")
Write( ++nCol, 00, "las partes, fica reservado a VENDEDORA a propriedade do(s) objeto(s) descrito(s) no inicio   do")
Write( ++nCol, 00, "presente contrato, ate que se liquida a ultima das prestacoes acima mencionadas.")
nCol++
Write( ++nCol, 00, "3¦) - Em consequencia do disposto na Clausula precedente, caso faltar o COMPRADOR, ao   pontual")
Write( ++nCol, 00, "pagamento de qualquer das referidas prestacoes, ficara desde logo, constituido em mora e  obri-")
Write( ++nCol, 00, "gado sob as penas da Lei, a devolver 'incontinenti', o(s) objeto(s) condicionalmente comprados,")
Write( ++nCol, 00, "devolucao que se fara amigavelmente ou em juizo, perdendo o COMPRADOR em  favor  da  VENDEDORA,")
Write( ++nCol, 00, "toda a importancia ja paga.")
nCol++
Write( ++nCol, 00, "4¦) - A falencia do COMPRADOR tambem resolve este contrato, podendo a VENDEDORA reivindicar  da")
Write( ++nCol, 00, "massa o(s) objeto(s) condicionalmente vendido(s).")
nCol++
Write( ++nCol, 00, "5¦) - Enquanto nao tiver pago integralmente o preco, fica expressamente proibido o COMPRADOR, a")
Write( ++nCol, 00, "vender, ceder, transferir a terceiros, bem como, a manter em perfeito estado de conservacao o(s)")
Write( ++nCol, 00, "objeto(s) recebido(s), protegendo-o(s) das turbacoes de terceiros, permitindo a VENDEDORA a ins-")
Write( ++nCol, 00, "pecao, quanto esta julgar conveniente, e avisando-lhe, por escrito, sempre que mudar de residen-")
Write( ++nCol, 00, "cia.")
nCol++
Write( ++nCol, 00, "        E, assim, por estarem justos e acordados assinam o presente instrumento em 02(duas) vias")
Write( ++nCol, 00, "vias de igual teor e forma, para um sao efeito, na presenca de testemunhas  abaixo  nomeadas   a")
Write( ++nCol, 00, "tudo presentes.")
nCol++
Write( ++nCol, 00, DataExt( Date()))
nCol++
Write( ++nCol, 00, "Testemunhas:")
nCol++
Write( ++nCol, 00, Repl("_", 35) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + AllTrim(oAmbiente:xNomefir) )
nCol++
nCol++
Write( ++nCol, 00, Repl("_", 35) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + cNomeCliente )
__Eject()
PrintOff()
xAlias->(DbClearRel())
xAlias->(DbGoTop())
Return

STATIC Proc ContratoOutros( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 00
LOCAL nTotal	 := 0
LOCAL Tam		 :=  CPI1280
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrint( _CPI12 )
FPrint( _SPACO1_8 )
SetPrc(0,0)
Write(	nCol, 00, "")
Write( ++nCol, 00, NG + Padc("CONTRATO PARTICULAR DE COMPRA E VENDA COM RESERVA DE DOMINIO - N§ " + cFatu, Tam ) + NR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "A " + AllTrim(oAmbiente:xNomefir) )
Write( ++nCol, 00, XENDEFIR + " - " + XCEPCIDA + " - " + XCESTA )
Write( ++nCol, 00, "CPF/CGC-MF :" + XCGCFIR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "por seu representante legal, doravante denominada simplesmente 'VENDEDORA' " + GD + "VENDE" + CA)
FPrint( _CPI12 )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "a(o) " + cNomeCliente )
Write( ++nCol, 00, AllTrim( Receber->Ende ) + " - " + Receber->Bair + " - " + Receber->Cep + "/" + Receber->(AllTrim( Cida )) + " - " + Receber->Esta )
Write( ++nCol, 00, "CPF/CGC-MF : " + IF( Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 ), Receber->Cpf, Receber->Cgc ))
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "doravante denominado simplesmente 'COMPRADOR' por este contrato  elaborado  e firmado em (02)")
Write( ++nCol, 00, "vias de igual teor e forma, com 'RESERVA DE DOMINIO', as seguintes mercadorias:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "CODIGO DESCRICAO DO PRODUTO                     MARCA      MODELO               QTDE")
Lista->(Order( LISTA_CODIGO ))
Area("SAIDAS")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Saidas->Codigo Into Lista
Saidas->(DbSeek( cFatu ))
While Saidas->Fatura = cFatu
	nPreco := Saidas->Pvendido
	Qout( Saidas->Codigo, Lista->Descricao, Lista->Sigla, Lista->N_Original, Saidas->Saida )
	nCol++
	Saidas->(DbSkip(1))
Enddo
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "de propriedade da 'VENDEDORA', mediante as clausulas e condicoes seguintes:")
nCol++
Write( ++nCol, 00, NG + "PRIMEIRA: " + NR + "A 'VENDEDORA' ampara-se na clausula 'RESERVAT DOMINI'.")
nCol++
Write( ++nCol, 00, NG + "SEGUNDA: " + NR + "O preco de venda e de R$ " + AllTrim( Tran( nLiquido, "@E 999,999,999.99")) + " cujo pagamento o COMPRADOR se obriga a realizar")
Write( ++nCol, 00, "do seguinte modo:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "N§ DOCTO  VENCIMENTO       VALOR OBS                 N§ DOCTO  VENCIMENTO       VALOR OBS")
nLen := Len( Dpnr )
nSoma := 0
nSum	:= 1
For nY := 1 To nLen
	IF nSum = 1
		Qout( Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 0
		nCol++
	Else
		QQout( Space(12), Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 1
	EndIF
	nSoma += VlrDup[nY]
Next
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "com emissao de titulos da VENDEDORA e aceite do COMPRADOR, avalizada, em favor da 'VENDEDORA'")
Write( ++nCol, 00, "as quais ficam fazendo parte integral no presente instrumento.")
nCol++
Write( ++nCol, 00, NG + "TERCEIRA: " + NR + "Por forca do pagamento de reserva de dominio, aqui expressamente instituido, e  a-")
Write( ++nCol, 00, "aceito pelas partes, fica reservado a VENDEDORA a propriedade do(s) objeto(s) descrito(s)  no")
Write( ++nCol, 00, "inicio do presente contrato, ate que se liquida a ultima das prestacoes acima mencionadas.")
nCol++
Write( ++nCol, 00, NG + "QUARTA: " + NR + "Em consequencia do disposto na Clausula precedente, caso faltar o COMPRADOR, ao pon-")
Write( ++nCol, 00, "tual pagamento de qualquer prestacao, a VENDEDORA podera executar os titulos, protestar,  mo-")
Write( ++nCol, 00, "ver ACAO DE BUSCA E APREENSAO, e ficara desde logo, constituido em mora e obrigado sob as pe-")
Write( ++nCol, 00, "nas da Lei, devolver 'incontinenti', o(s) objeto(s) condicionalmente comprados, devolucao que")
Write( ++nCol, 00, "se fara amigavelmente ou em juizo, perdendo o COMPRADOR em favor da VENDEDORA, toda a  impor-")
Write( ++nCol, 00, "tancia ja paga.")
nCol++
Write( ++nCol, 00, NG + "QUINTA: " + NR + "A 'VENDEDORA' declara, para todos os fins de direito que as mercadorias ora vendidas")
Write( ++nCol, 00, "acham-se em perfeito estado de conservacao e funcionamento pois encontram-se sem uso anterior.")
nCol++
Write( ++nCol, 00, NG + "SEXTA: " + NR + "Na vigencia deste contrato nao podera o 'COMPRADOR' alienar sob  qualquer  forma, dar")
Write( ++nCol, 00, "a penhora, transferir ou ceder a terceiros as mercadorias objeto do presente, sob pena de res-")
Write( ++nCol, 00, "ponder penalmente.")
nCol++
Write( ++nCol, 00, NG + "SETIMA: " + NR + "A 'VENDEDORA' e assegurado o direito de vistoriar as mercadorias ora vendidas a qual-")
Write( ++nCol, 00, "quer momento, e o 'COMPRADOR' com o direito de uso em raso, nao se exime da  obrigacao de con-")
Write( ++nCol, 00, "serva-las assistindo a 'VENDEDORA' o direito de propor medidas judiciais cautelatorias em caso")
Write( ++nCol, 00, "de mau uso ou ma conservacao das mercadorias.")
nCol++
Write( ++nCol, 00, NG + "OITAVA : " + NR + "Aos casos omissos sera aplicada subsidiariamente a norma cabivel na legislacao em vi-")
Write( ++nCol, 00, "gor. Para dirimir quaisquer duvidas oriundas deste contrato, fica eleito o foro da comarca de:")
Write( ++nCol, 00,  XCCIDA + " - " + XCESTA + " com renuncia de qualquer outra, por mais previlegiada que seja.")
nCol++
Write( ++nCol, 00, "             E por estarem justos e contratados, assinam o presente em duas vias de igual teor")
Write( ++nCol, 00, "e forma, que apos lido e achado conforme, na presenca de testemunhas, vair assinado por todos,")
Write( ++nCol, 00, "para que surta seus juridicos e legais efeitos.")
nCol++
Write( ++nCol, 00, DataExt( Date()))
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + AllTrim(oAmbiente:xNomefir) )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + cNomeCliente )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + "AVAL " + Receber->Conhecida )
__Eject()
PrintOff()
Saidas->(DbClearRel())
Saidas->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
Return

STATIC Proc ComVenContrato( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
*************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 00
LOCAL nTotal	 := 0
LOCAL Tam		 := CPI1280
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrint( _CPI12 )
FPrint( _SPACO1_8 )
SetPrc(0,0)
Write(	nCol, 00, "")
Write( ++nCol, 00, NG + Padc("CONTRATO PARTICULAR DE COMPRA E VENDA COM RESERVA DE DOMINIO - N§ " + cFatu, Tam ) + NR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "A " + AllTrim(oAmbiente:xNomefir) )
Write( ++nCol, 00, XENDEFIR + " - " + XCEPCIDA + " - " + XCESTA )
Write( ++nCol, 00, "CPF/CGC-MF :" + XCGCFIR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "por seu representante legal, doravante denominada simplesmente 'VENDEDORA' " + GD + "VENDE" + CA)
FPrint( _CPI12 )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "a(o) " + cNomeCliente )
Write( ++nCol, 00, AllTrim( Receber->Ende ) + " - " + Receber->Bair + " - " + Receber->Cep + "/" + Receber->(AllTrim( Cida )) + " - " + Receber->Esta )
Write( ++nCol, 00, "CPF/CGC-MF : " + IF( Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 ), Receber->Cpf, Receber->Cgc ))
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "doravante denominado simplesmente 'COMPRADOR' por este contrato  elaborado  e firmado em (02)")
Write( ++nCol, 00, "vias de igual teor e forma, com 'RESERVA DE DOMINIO', as seguintes mercadorias:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "CODIGO DESCRICAO DO PRODUTO                     MARCA      MODELO               QTDE")
Lista->(Order( LISTA_CODIGO ))
Area("SAIDAS")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Saidas->Codigo Into Lista
Saidas->(DbSeek( cFatu ))
While Saidas->Fatura = cFatu
	nPreco := Saidas->Pvendido
	Qout( Saidas->Codigo, Lista->Descricao, Lista->Sigla, Lista->N_Original, Saidas->Saida )
	nCol++
	Saidas->(DbSkip(1))
Enddo
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "de propriedade da 'VENDEDORA', mediante as clausulas e condicoes seguintes:")
nCol++
Write( ++nCol, 00, NG + "PRIMEIRA: " + NR + "A 'VENDEDORA' ampara-se na clausula 'RESERVAT DOMINI'.")
nCol++
Write( ++nCol, 00, NG + "SEGUNDA: " + NR + "O preco de venda e de R$ " + AllTrim( Tran( nLiquido, "@E 999,999,999.99")) + " cujo pagamento o COMPRADOR se obriga a realizar")
Write( ++nCol, 00, "do seguinte modo:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "N§ DOCTO  VENCIMENTO       VALOR OBS                 N§ DOCTO  VENCIMENTO       VALOR OBS")
nLen := Len( Dpnr )
nSoma := 0
nSum	:= 1
For nY := 1 To nLen
	IF nSum = 1
		Qout( Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 0
		nCol++
	Else
		QQout( Space(12), Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 1
	EndIF
	nSoma += VlrDup[nY]
Next
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "com emissao de titulos da VENDEDORA e aceite do COMPRADOR, avalizada, em favor da 'VENDEDORA'")
Write( ++nCol, 00, "as quais ficam fazendo parte integral no presente instrumento.")
nCol++
Write( ++nCol, 00, NG + "TERCEIRA: " + NR + "Por forca do pagamento de reserva de dominio, aqui expressamente instituido, e  a-")
Write( ++nCol, 00, "aceito pelas partes, fica reservado a VENDEDORA a propriedade do(s) objeto(s) descrito(s)  no")
Write( ++nCol, 00, "inicio do presente contrato, ate que se liquida a ultima das prestacoes acima mencionadas.")
nCol++
Write( ++nCol, 00, NG + "QUARTA: " + NR + "Em consequencia do disposto na Clausula precedente, caso faltar o COMPRADOR, ao pon-")
Write( ++nCol, 00, "tual pagamento de qualquer prestacao, a VENDEDORA podera executar os titulos, protestar,  mo-")
Write( ++nCol, 00, "ver ACAO DE BUSCA E APREENSAO, e ficara desde logo, constituido em mora e obrigado sob as pe-")
Write( ++nCol, 00, "nas da Lei, devolver 'incontinenti', o(s) objeto(s) condicionalmente comprados, devolucao que")
Write( ++nCol, 00, "se fara amigavelmente ou em juizo, perdendo o COMPRADOR em favor da VENDEDORA, toda a  impor-")
Write( ++nCol, 00, "tancia ja paga.")
nCol++
Write( ++nCol, 00, NG + "QUINTA: " + NR + "Fica acordado entre as partes, multa contratual de 10% (dez por cento) sobre o valor")
Write( ++nCol, 00, "contratado, devidos pelo inadimplente do presente termo, que vencera antecipadamente as demais")
Write( ++nCol, 00, "parcelas.")
nCol++
Write( ++nCol, 00, NG + "SEXTA: " + NR + "Na vigencia deste contrato nao podera o 'COMPRADOR' alienar sob  qualquer  forma, dar")
Write( ++nCol, 00, "em penhora, transferir ou ceder a terceiros as mercadorias objeto do presente, sob pena de res-")
Write( ++nCol, 00, "ponder penalmente, alem das perdas e danos.")
nCol++
Write( ++nCol, 00, NG + "SETIMA: " + NR + "A 'VENDEDORA' e assegurado o direito de vistoriar as mercadorias ora vendidas a qual-")
Write( ++nCol, 00, "quer momento, e o 'COMPRADOR' com o direito de uso em raso, nao se exime da  obrigacao de con-")
Write( ++nCol, 00, "serva-las assistindo a 'VENDEDORA' o direito de propor medidas judiciais cautelatorias em caso")
Write( ++nCol, 00, "de mau uso ou ma conservacao das mercadorias antes do fim do pagamento.")
nCol++
Write( ++nCol, 00, NG + "OITAVA : " + NR + "Aos casos omissos sera aplicada subsidiariamente a norma cabivel na legislacao em vi-")
Write( ++nCol, 00, "gor. Para dirimir quaisquer duvidas oriundas deste contrato, fica eleito o foro da comarca de:")
Write( ++nCol, 00,  XCCIDA + " - " + XCESTA + " com renuncia de qualquer outra, por mais previlegiada que seja.")
nCol++
Write( ++nCol, 00, "             E por estarem justos e contratados, assinam o presente em duas vias de igual teor")
Write( ++nCol, 00, "e forma, que apos lido e achado conforme, na presenca de testemunhas, vair assinado por todos,")
Write( ++nCol, 00, "para que surta seus juridicos e legais efeitos.")
nCol++
Write( ++nCol, 00, DataExt( Date()))
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + AllTrim(oAmbiente:xNomefir) )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + cNomeCliente )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + "AVAL " + Receber->Conhecida )
__Eject()
PrintOff()
Saidas->(DbClearRel())
Saidas->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
Return

Function FreshOrder( oObjeto)
*****************************
LOCAL nRecno := RecNo()
oOBjeto:Refreshall()
oObjeto:ForceStable()
If ( nRecno  !=  LastRec() + 1 )
	Do While ( RecNo()  !=	nRecno .AND. !BOF() )
		oObjeto:Up()
		oObjeto:ForceStable()
	EndDo
EndIf
Return( NIL )

Proc DescMedio( lVarejo, nDescMedio, nTotalSemDesconto )
********************************************************
LOCAL nDesc 		:= 0
LOCAL nSoma 		:= 0
LOCAL nTotal		:= 0
LOCAL nTotSemDesc := 0

xAlias->(DbGoTop())
WHILE !Eof()
	 nTotal += ( nSoma := ( xAlias->Quant * xAlias->Varejo ))
	 nDesc  += ( nSoma * xAlias->DescMax ) / 100
	 Do Case
	 Case lVarejo = 1 // Atacado
		 nTotSemDesc += ( xAlias->Quant * xAlias->Atacado)
	 Case lVarejo = 2 // Varejo
		 nTotSemDesc += ( xAlias->Quant * xAlias->Varejo)
	 Case lVarejo = 3 // Pcusto
		 nTotSemDesc += ( xAlias->Quant * xAlias->Pcusto)
	 EndCase
	 xAlias->(DbSkip(1))
EndDo
nDescMedio			:= Round((( nDesc * 100 ) / nTotal), 2 )
nTotalSemDesconto := nTotSemDesc
Return

Function TotalComDescontoMaximo( nTotal, nTotalSemDesconto, nDescMedio )
************************************************************************
LOCAL cScreen			  := SaveScreen()
LOCAL nTemp 			  := 0
LOCAL nTotalComDescMax := 0
LOCAL nNivel			  := SCI_PODE_EXCEDER_DESCONTO_MAXIMO
LOCAL lRetorno 		  := OK

nTotal				:= Round( nTotal, 2 )
nTotalSemDesconto := Round( nTotalSemDesconto, 2 )
nTemp 				:= Round(( nTotalSemDesconto * nDescMedio ) / 100, 2 )
nTotalComDescMax	:= Round(( nTotalSemDesconto - nTemp ), 2 )
IF nTotal < nTotalComDescMax
	IF !PodeExcederDescMax()
		nTotal := nTotalComDescMax
		lRetorno := FALSO
	EndIF
	ResTela( cScreen )
EndIF
Return( lRetorno )


Function VerSenha( cCaixa, cNome )
**********************************
LOCAL cScreen   := SaveScreen()
LOCAL cPassword := Space(10)
LOCAL GetList := {}
LOCAL cCodi
FIELD Senha

WHILE OK
	Area("Vendedor")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
   cCodi     := Space(4)
   cPassword := Space(10)
   MaBox( 15, 05, 18, 72 )
   @ 16, 06 Say "Codigo Caixa....:" Get cCodi     Pict "9999" Valid FunErrado( @cCodi,, Row(), Col()+1 )
   @ 17, 06 Say "Senha de Acesso.:" Get cPassword Pict "@S"   Valid SenhaCerta( cCodi, cPassword )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return( FALSO )
	EndIF
   cNome  := Vendedor->Nome
   cCaixa := cCodi
   ResTela( cScreen )
   Return( OK )
EndDo

Function SenhaCerta( cLogin, cPassword )
****************************************
LOCAL Passe
LOCAL cSenha
FIELD Senha

IF Vendedor->(Empty(Senha))
   ErrorBeep()
   IF Conf("ERRO: Vendedor sem Senha. Deseja Registra-la ?")
      CadastraSenha( cLogin )
   Else
      Return(FALSO)
	EndIF
EndIF

Passe  := Upper(cPassword)
cSenha := Vendedor->(Decrypt(Senha))

IF !Empty( Passe) .AND. ( AllTrim( cSenha ) == AllTrim( Passe ))
   Return( OK )
EndIF
ErrorBeep()
Alerta("ERRO: Senha Nao Confere.")
Return(FALSO)

Proc Imprime_Soma( pTotal, pComissaoMed, lMostrar, lMedias )
************************************************************
LOCAL nQuant		 := 0
LOCAL nTotalCusto  := 0
LOCAL nTotal		 := 0
LOCAL nSoma 		 := 0
LOCAL nComissao	 := 0
LOCAL nComissaoMed := 0
LOCAL nMargemMedia := 0
LOCAL nCurrente	 := xAlias->(Recno())
LOCAL cTela
FIELD Quant
FIELD Unitario
FIELD Porc

xAlias->(DbGoTop())
WHILE !Eof()
	 nSoma		 := xAlias->Quant * xAlias->Unitario
	 nQuant		 += xAlias->Quant
	 nTotal		 += nSoma
	 nTotalCusto += xAlias->Quant * xAlias->Pcusto
	 nComissao	 += ( nSoma * Porc ) / 100
	 xAlias->(DbSkip(1))
EndDo
nMargemMedia := (( nTotal / nTotalCusto ) * 100 )- 100
xAlias->(DbGoTo( nCurrente ))
pComissaoMed := ( nComissaoMed := ( nComissao * 100 ) / nTotal )
pTotal		 := nTotal
IF lMedias != NIL
	IF oOrca:Colpos = 1 .OR. oOrca:ColPos = 5
		Write( 15, 02, Tran( nQuant, "@E 99999.99"))
		Write( 15, 61, Tran( nTotal, "@E 9,999,999,999.99"))
	ElseIF oOrca:Colpos = 7 .OR. oOrca:ColPos = 8
		Write( 15, 51, Tran( nTotalCusto,  "@E 99,999,999.99"))
		Write( 15, 68, Tran( nMargemMedia, "@E 999.99"))
	EndIF
EndIF
IF lMostrar = Nil
	MaBox( 17, 00, 23, MaxCol(),"TOTAL FATURA R$  " + Tran( nTotal, "@E 9,999,999,999.99"))
	Write( 18, 01,"INSERT  Incluir RegistrosÝ  F1 Consulta Debito      Ý F11 Devol/Incl Fatura   ")
	Write( 19, 01,"DELETE  Excluir RegistrosÝ  F2 Baixar Dup/Prom/Cc   Ý F3  Pagamentos          ")
	Write( 20, 01,"F4      Lanc/Pos Caixa   Ý  F5 Lista Pre‡os         Ý F6  Manutencao Pre-Venda")
	Write( 21, 01,"F7      Visualizar FaturaÝ  F8 Fechar Pre-Venda     Ý F9  Inclusao Clientes   ")
	Write( 22, 01,"F10     Fechar Fatura    Ý^F10 Imprime Orcamento    Ý ^P  Menu de Impressao   ")
EndiF
Return

Proc Mostra_Soma( pTotal, pComissaoMed, lMostrar )
**************************************************
LOCAL nSoma 		 := 0
LOCAL nTotal		 := 0
LOCAL nComissao	 := 0
LOCAL nComissaoMed := 0
LOCAL nCurrente	 := xAlias->(Recno())
FIELD Quant, Unitario, Porc
xAlias->(DbGoTop())
WHILE !Eof()
	 nSoma	  := xAlias->Quant * xAlias->Unitario
	 nTotal	  += nSoma
	 nComissao += ( nSoma * Porc ) / 100
	 xAlias->(DbSkip(1))
EndDo
xAlias->(DbGoTo( nCurrente ))
pComissaoMed := ( nComissaoMed := ( nComissao * 100 ) / nTotal )
pTotal		 := nTotal
IF lMostrar = Nil
	MaBox( 17, 00, 23, MaxCol(),"TOTAL FATURA R$  " + Tran( nTotal, "@E 9,999,999,999.99"))
	Write( 18, 01,"ENTER   Incluir RegistrosÝ  ^ENTER Alterar          Ý  ^Q  Limpar Fatura    ")
	Write( 19, 01,"DELETE  Excluir RegistrosÝ  F10    Fechar Fatura    Ý  F11 Devolucao Total  ")
	Write( 20, 01,"F5      Lista Precos     Ý                          Ý                       ")
	Write( 21, 01,"                         Ý                          Ý                       ")
	Write( 22, 01,"                         Ý                          Ý                       ")
EndiF
Return

Proc xDeletar()
***************
xAlias->(DbDelete())
xAlias->(Libera())
xAlias->(__DbPack())
Return

Proc Informa()
**************
ErrorBeep()
Alerta("Devolucao nao completada. Tente Novamente !")
Return


Function NumeroNota( cFatura, cCodi, dEmis, lAutoFatura )
*********************************************************
LOCAL GetList		:= {}
LOCAL Arq_Ant		:= Alias()
LOCAL Ind_Ant		:= IndexOrd()
LOCAL nTamCampo	:= 7

Area("Nota")
IF lAutoFatura
	Nota->(Order(ZERO))
	Nota->(DbGoBottom())
	cFatura := StrZero( Val( Nota->Numero ) + 1, nTamCampo )
EndIF
Nota->(Order( NOTA_NUMERO ))
IF Nota->(DbSeek( cFatura ))
	cFatura := FaturaNaoRegistrada( cFatura )
	Nota->(Order( NOTA_NUMERO ))
	IF Nota->(DbSeek( cFatura ))
		Alerta("Erro: Arquivos de indices corrompidos. Favor reindexar.")
	EndIf
EndIF
Saidas->(Order(SAIDAS_FATURA))
IF Saidas->(DbSeek( cFatura ))
	IF Nota->(Incluiu())
		Nota->Numero	  := cFatura
		Nota->Codi		  := Saidas->Codi
		Nota->Data		  := Saidas->Emis
		Nota->Atualizado := Saidas->Atualizado
		Nota->(Libera())
	EndIF
	cFatura := FaturaNaoRegistrada( cFatura )
	Nota->(Order( NOTA_NUMERO ))
	IF Nota->(DbSeek( cFatura ))
		Alerta("Erro: Arquivos de indices corrompidos. Favor reindexar.")
	EndIF
EndIF
IF Nota->(Incluiu())
	Nota->Numero	  := cFatura
	Nota->Codi		  := cCodi
	Nota->Data		  := dEmis
	Nota->Atualizado := Date()
	Nota->(Libera())
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( cFatura )

Function FaturaNaoRegistrada( cFatu )
*************************************
LOCAL nTam		 := 7
LOCAL nTemp 	 := Int( Val( cFatu ))
LOCAL cTela 	 := Mensagem("Aguarde, Localizando Proxima Fatura Disponivel.")
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

Nota->(Order( NOTA_NUMERO ))
Recemov->(Order( RECEMOV_FATURA ))
Recebido->(Order( RECEBIDO_FATURA ))
Saidas->(Order( SAIDAS_FATURA))
WHILE Nota->(DbSeek( cFatu )) .OR. Saidas->(DbSeek( cFatu )) .OR. Recemov->(DbSeek( cFatu )) .OR. Recebido->(DbSeek( cFatu ))
	nTemp++
	cFatu := StrZero( nTemp, nTam )
EndDo
ResTela( cTela )
AreaAnt( Arq_Ant, Ind_Ant )
Return( cFatu )

Function VerNumero( cFatura, cFaturaAnt, lManutencao, cCodi, dEmis )
********************************************************************
LOCAL GetList		:= {}
LOCAL Arq_Ant		:= Alias()
LOCAL Ind_Ant		:= IndexOrd()

IF lManutencao != NIL
	IF cFatura == cFaturaAnt
		Return( OK )
	EndIF
EndIF
Nota->(Order( NOTA_NUMERO ))
Saidas->(Order( SAIDAS_FATURA ))
IF Nota->(!DbSeek( cFatura ))
	IF Saidas->(!DbSeek( cFatura ))
		RegistraNota( cFatura, cCodi, dEmis )
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	EndIF
EndIF
ErrorBeep()
IF Conf("Numero de Fatura existente. Localizar Proxima ?")
	cFatura := FaturaNaoRegistrada( cFatura )
	RegistraNota( cFatura, cCodi, dEmis )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( OK )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Proc RegistraNota( cFatura, cCodi, dEmis )
******************************************
IF Nota->(Incluiu())
	Nota->Numero	  := cFatura
	Nota->Codi		  := cCodi
	Nota->Data		  := dEmis
	Nota->Atualizado := Date()
	Nota->(Libera())
EndIF
Return

Function FaturaNew()
********************
LOCAL Handle

Mensagem("Aguarde, Criando Arquivo de Trabalho.")
Handle := FTempName( "*.TMP" )
DbCreate( Handle, {{ "CODIGO",     "C", 06, 0 }, ; // Codigo do Produto
						 { "UN",         "C", 02, 0 }, ;
						 { "CODI",       "C", 05, 0 }, ;
						 { "QUANT",      "N", 08, 2 }, ;
						 { "SERIE",      "C", 10, 0 }, ;
						 { "DESCONTO",   "N", 05, 2 }, ;
						 { "DESCRICAO",  "C", 40, 0 }, ;
						 { "PCOMPRA",    "N", 13, 2 }, ;
						 { "PCUSTO",     "N", 13, 2 }, ;
						 { "VAREJO",     "N", 13, 2 }, ;
						 { "ATACADO",    "N", 13, 2 }, ;
						 { "UNITARIO",   "N", 13, 2 }, ;
						 { "CUSTOFINAL", "N", 13, 2 }, ;
						 { "TOTAL",      "N", 13, 2 }, ;
						 { "MARVAR",     "N", 06, 2 }, ;
						 { "MARATA",     "N", 06, 2 }, ;
						 { "IMPOSTO",    "N", 06, 2 }, ;
						 { "FRETE",      "N", 06, 2 }, ;
						 { "UFIR",       "N", 07, 2 }, ;
						 { "IPI",        "N", 05, 2 }, ;
						 { "II",         "N", 05, 2 }, ;
						 { "FUNRURAL",   "N", 13, 2 }, ;
						 { "DESCMAX",    "N", 06, 2 }, ;
						 { "SIGLA",      "C", 10, 0 }, ;
						 { "LOCAL",      "C", 10, 0 }, ;
						 { "TAM",        "C", 06, 0 }, ;
						 { "N_ORIGINAL", "C", 15, 0 }, ;
						 { "FATURA",     "C", 09, 0 }, ; // Usado em FechaDiaEcf()
						 { "FORMA",      "C", 02, 0 }, ; // Usado em FechaDiaEcf()
						 { "IMPRESSO",   "L", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "EMIS",       "D", 08, 0 }, ; // Usado em FechaDiaEcf()
						 { "CLASSE",     "C", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "SERVICO",    "L", 01, 0 }, ; // Usado em FechaDiaEcf()
						 { "CODEBAR",    "C", 13, 0 }, ; // Usado em FechaDiaEcf()
						 { "PORC",       "N", 05, 2 }})
Return( Handle )

Function Somatudo( nVlr, nSoma, nTotal )
****************************************
IF Round( nVlr + nSoma, 2 ) > nTotal
	ErrorBeep()
	Alerta("Erro: Valor ultrapassa faturamento.")
	Return( FALSO )
EndIF
Return( OK )

Proc IncPorGrupo( oOrca )
***************************
LOCAL cScreen := SaveScreen()
LOCAL nConta  := 0
LOCAL nSoma   := 0
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cGrupo  := Space(03)

oMenu:Limpa()
MaBox( 15, 10, 17, 67 )
@ 16, 11 Say "Incluir o Grupo..:" Get cGrupo Pict "999" Valid GrupoErrado( @cGrupo )
Read
ErrorBeep()
IF LastKey() = ESC .OR. !Conf("Pergunta: Continuar com a anexacao ?")
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return
EndIF
Lista->(Order( LISTA_CODGRUPO ))
IF Lista->(!DbSeek( cGrupo ))
	AreaAnt( Arq_Ant, Ind_Ant )
	ErrorBeep()
	Alerta("Erro: Nenhum produto atende a condicao")
	ResTela( cScreen )
	Return
EndIF
While Lista->CodGrupo = cGrupo
	xAlias->(DbAppend())
	nSoma 				:= Lista->Varejo * 1
	xAlias->Codigo 	:= Lista->Codigo
	xAlias->Quant		:= 1
	xAlias->Un			:= Lista->Un
	xAlias->Descricao := Lista->Descricao
	xAlias->Unitario	:= Lista->Varejo
	xAlias->Atacado	:= Lista->Atacado
	xAlias->Varejo 	:= Lista->Varejo
	xAlias->Pcusto 	:= Lista->Pcusto
	xAlias->Porc		:= Lista->Porc
	xAlias->Total		:= nSoma
	Lista->(DbSkip(1))
EndDo
oOrca:RefreshAll()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Proc Entradas()
***************
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL lVarejo			:= 2
LOCAL nVlrMercadoria := 0
LOCAL cCaixa			:= Space(04)
LOCAL xNtx				:= FTempName("T*.TMP")
LOCAL cString			:= "ENTRADAS DE MERCADORIAS"
LOCAL aMenu 			:= {"Manualmente", "Codigo Barra"}
LOCAL Handle
LOCAL nKey
LOCAL cTela
LOCAL Arq_Ant
LOCAL Ind_Ant
LOCAL cVendedor
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Total
PUBLI lCereais := FALSO

lIpi				 := oIni:ReadBool('sistema', 'ipi',            FALSO )
lIndexador		 := oIni:ReadBool('sistema', 'indexador',      FALSO )
lMediaPonderada := oIni:ReadBool('sistema', 'mediaponderada', FALSO )
lAutoPreco		 := oIni:ReadBool('sistema', 'autopreco',      OK)

oMenu:Limpa()
IF !VerSenha( @cCaixa, @cVendedor )
	ResTela( cScreen )
	Return
EndIF
#IFDEF DEF_CEREAIS
	ErrorBeep()
	lCereais := Conf("Pergunta: Faturar Cereais ?")
#ENDIF
Handle := FaturaNew()
Use ( Handle ) Alias xAlias Exclusive New
Area("xAlias")
Inde On xAlias->Codigo To ( xNtx )
Print( 00, 01, Padc( cString, (MaxCol()-1)), 31 )
oEntradas := BrowseEntradas( 01, 01, 15, (MaxCol()-1) )
oEntradas:ForceStable()
WHILE OK
	SetCursor(0)
	SomaEntrada()
	oEntradas:ForceStable()
	IF oEntradas:HitTop .OR. oEntradas:HitBottom
		ErrorBeep()
	EndIf
	nKey	  := InKey( ZERO )
	Arq_Ant := Alias()
	Ind_Ant := IndexOrd()
	IF nKey == K_ESC
		 ErrorBeep()
		 IF Conf("Pergunta: Sair do Faturamento ?")
			 ResTela( cScreen )
			 Exit
		 EndIF
  ElseIf nKey == TECLA_INSERT .OR. nKey == TECLA_MAIS .OR. nKey = ENTER
	  xEntraRegistro( oEntradas)
	  oEntradas:RefreshAll()
	  DbGoBoTTom()
  ElseIf nKey == ASTERISTICO
	  SomaEntrada(,,,OK)
  ElseIf nKey == TECLA_DELETE
	  xDeletar()
	  oEntradas:refreshCurrent():forceStable()
	  oEntradas:up():forceStable()
	  Freshorder( oEntradas )
  ElseIf nKey == CTRL_ENTER
	  xAltEntradas()
	  oEntradas:RefreshAll()
  ElseIf nKey == CTRL_Q
	  ErrorBeep()
	  IF Conf(" Limpar Fatura ?")
		  Sele xAlias
		  __DbZap()
		  SomaEntrada()
	  EndIF
	  oEntradas:RefreshAll()
  ElseIF nKey == F3
	  nNivel := SCI_PAGAMENTOS
	  IF !aPermissao[ nNivel ]
		  IF PedePermissao( nNivel )
			  cTela := SaveScreen()
			  oMenu:Limpa()
			  Paga22( cCaixa )
		  EndIF
	  Else
		  cTela := SaveScreen()
		  oMenu:Limpa()
		  Paga22( cCaixa )
	  EndIF
	  ResTela( cTela )
  ElseIF nKey == F4
	  cTela := SaveScreen()
	  ConLista()
	  ResTela( cTela )
  ElseIf nKey == K_F1
	  cTela := SaveScreen()
	  VerPosicao()
	  ResTela( cTela )
  ElseIf nKey == F2
	  cTela	:= SaveScreen()
	  VerBaixa(cCaixa, cVendedor)
	  ResTela( cTela )
  ElseIF nKey == F5
	  cTela := SaveScreen()
	  Conlista()
	  ResTela( cTela )
  ElseIF nKey == F6
	  cTela := SaveScreen()
	  Lista21()
	  ResTela( cTela )
  ElseIF nKey == F7
	  cTela := SaveScreen()
	  ForAlteracao()
	  ResTela( cTela )
  ElseIF nKey == F8
	  cTela := SaveScreen()
	  PagaPosi(1)
	  ResTela( cTela )
  ElseIF nKey == F9
	  ForInclusao()
  ElseIF nKey == F10
	  oMenu:Limpa()
	  FechaEntra( cCaixa )
	  ResTela( cScreen )
	  SomaEntrada()
	  oEntradas:RefreshAll()
  ElseIF nKey == F11
	  cTela := SaveScreen()
	  xAlias->(DbCloseArea())
	  ManuEntrada( cCaixa )
	  Use ( Handle ) Alias xAlias Exclusive New
	  xAlias->(DbSetIndex(( xNtx )))
	  Arq_Ant := Alias()
	  Ind_Ant := IndexOrd()
	  ResTela( cTela )
  ElseIf nKey == F12
	  cTela := SaveScreen()
	  CalcValor()
	  ResTela( cTela )
  ElseIF nKey == K_CTRL_F1
	  cTela := SaveScreen()
	  IF PodeAlterar()
		  AlteraPagar()
	  EndIF
	  ResTela( cTela )
  ElseIF nKey == K_CTRL_F2
	  cTela := SaveScreen()
	  IF PodeAlterar()
		  AlteraPago()
	  EndIF
	  ResTela( cTela )
  ElseIF nKey == K_CTRL_F10
  Else
	  TestaTecla( nKey, oEntradas )
  EndIf
  Print(00,01, Padc( cString, (MaxCol()-1)), 31 )
  AreaAnt( Arq_Ant, Ind_Ant )
EndDo
Mensagem("Aguarde...", Cor())
xAlias->(DbCloseArea())
FClose( Handle )
FClose( xNtx )
Ferase( Handle )
Ferase( xNtx )
Return

Function CalculaCusto( nQuant, nPreco, nFunrural )
**************************************************
LOCAL nPorcSubProduto := 0
LOCAL cScreen			 := SaveScreen()
LOCAL xCodigo			 := 0
LOCAL nPesoBruto		 := 0
LOCAL nTaraSacas		 := 0
LOCAL nTaraLiquida	 := 0
LOCAL nRenda			 := 0
LOCAL nValorUnitario  := 0
LOCAL nTaxaFunrural	 := 0
LOCAL nValorLiquido	 := 0
LOCAL nPesoLiquido	 := 0

IF !lCereais
	Return( OK )
EndIF
nQuant	 := 0
nFunrural := 0
IF xAlias->(LastRec() != 0 )
	IF Conf("Pergunta: SubProduto ?")
		MaBox( 17, 00, 24, MaxCol() )
		Write( 18, 01, "Codigo do Produto.......:")
		Write( 19, 01, "Peso Beneficiado........:")
		Write( 20, 01, "Porcentagem SubProduto..:")
		@ 18, 27 Get xCodigo Pict PIC_LISTA_CODIGO Valid ProcuraSub( @xCodigo, @nQuant, Row(), Col()+5 )
		@ 20, 27 Get nPorcSubProduto Picture "999.99"
		Read
		ResTela( cScreen )
		IF LastKey() == ESC
			Return( FALSO )
		EndIf
		nQuant *= ( nPorcSubProduto / 100 )
		Return( OK )
	EndIF
EndIF
MaBox( 17, 00, 24, MaxCol() )
Write( 18, 01, "PESO BRUTO...:                 VALOR UNITARIO.....:")
Write( 19, 01, "TARA SACAS...:                 TAXA FUNRURAL......:")
Write( 20, 01, "TARA LIQUIDA.:                 TOTAL BRUTO........:")
Write( 21, 01, "RENDA % .....:                 FUNRURAL...........:")
Write( 22, 01, "PESO BENEFIC.:                 TOTAL LIQUIDO......:")
@ 18, 20 Get nPesoBruto 	 Pict "99999.99" Valid nPesoBruto   != 0
@ 19, 20 Get nTaraSacas 	 Pict "99999.99" Valid nTaraSacas   != 0
@ 20, 20 Get nTaraLiquida	 Pict "99999.99" Valid nTaraLiquida != 0
@ 21, 20 Get nRenda			 Pict "99999.99" Valid MosTraPeso( nRenda, nPesoBruto, nTaraSacas, @nPesoLiquido )
@ 18, 55 Get nValorUnitario Pict "99999.99"
@ 19, 55 Get nTaxaFunrural  Pict "999.99" Valid MostraLiquido( nPesoLiquido, nValorUnitario, nTaxaFunrural, @nValorLiquido, @nFunrural )
@ 22, 55 Get nValorLiquido  Pict "@E 99,999,999.99"
Read
SetColor("W+/G")
Restela( cScreen )
nQuant := nPesoLiquido
nPreco := nValorUnitario
IF LastKey() == ESC
	Return( FALSO )
EndIf
Return( OK )

Function ProcuraSub( xCodigo, nQuant, nRow, nCol )
**************************************************
LOCAL aRotina			  := {{||CliInclusao()}}
LOCAL aRotinaAlteracao := {{||CliInclusao( OK )}}

xCodigo := StrCodigo( xCodigo )
IF xAlias->(!DbSeek( xCodigo ))
	xAlias->(Escolhe( 03, 01, 22,"Codigo + 'Ý' + Descricao","CODIG DESCRICAO DO PRODUTO", aRotina,,aRotinaAlteracao))
EndIF
nQuant := xAlias->Quant
Write( nRow+0, nCol, xAlias->Descricao )
Write( nRow+1, 27, TransForm( nQuant, "99999.99"))
Return( OK )

Function MosTraPeso( nRenda, nPesoBruto, nTaraSacas, nPesoLiquido)
******************************************************************
nPesoLiquido := Round((nPesoBruto / nTaraSacas ) * nRenda, 2 )
//nPesoLiquido := Round((nPesoBruto * nRenda ) / 100, 2 )
Write(22, 20, Transform( nPesoLiquido, "99999.99"))
Return( OK )

Function MostraLiquido( nPesoLiquido, nValorUnitario, nTaxaFunrural, nValorLiquido, nFunrural )
***********************************************************************************************
nTotalBruto   := Round( nPesoLiquido * nValorUnitario, 2 )
nFunrural	  := nTotalBruto * nTaxaFunrural / 100
nValorLiquido := Round( nTotalBruto - nFunRural, 2 )
Write(20, 55, Transform( nTotalBruto,	 "@E 99,999,999.99"))
Write(21, 55, Transform( nFunRural, 	 "@E 99,999,999.99"))
Write(22, 55, Transform( nValorLiquido, "@E 99,999,999.99"))
Return( OK )

Proc SomaEntrada( pTotal, lMostrar, nFunrural, lMedias, nTotCustoFinal )
************************************************************************
LOCAL nQuant		 := 0
LOCAL nSoma 		 := 0
LOCAL nTotal		 := 0
LOCAL nCusto		 := 0
LOCAL nCurrente	 := xAlias->(Recno())
FIELD Quant
FIELD Unitario
FIELD Porc

xAlias->(DbGoTop())
nTotCustoFinal := 0
nFunrural		:= 0
WHILE !Eof()
	 nQuant			 += xAlias->Quant
	 nSoma			 := xAlias->Quant * xAlias->Unitario
	 nCusto			 := xAlias->Quant * xAlias->CustoFinal
	 nTotal			 += nSoma
	 nTotCustoFinal += nCusto
	 nFunRural		 += xalias->FunRural
	 xAlias->(DbSkip(1))
EndDo
xAlias->(DbGoTo( nCurrente ))
pTotal		 := nTotal
IF lMedias != NIL
	IF oEntradas:Colpos = 1 .OR. oEntradas:ColPos = 5
		Write( 15, 02, Tran( nQuant, "@E 99999.99"))
		Write( 15, 61, Tran( nTotal, "@E 9,999,999,999.99"))
	ElseIF oEntradas:Colpos = 7 .OR. oEntradas:ColPos = 8
		Write( 15, 60, Tran( nTotCustoFinal,  "@E 99,999,999.99"))
	EndIF
EndIF
IF lMostrar = NIL
	MaBox( 17, 00, MaxRow(), MaxCol(),"TOTAL COMPRA R$ " + Tran( nTotal, "@E 9,999,999,999.99") + " Ý TOTAL CUSTO R$  " + Tran( nTotCustoFinal, "@E 9,999,999,999.99"))
	Write( 18, 01, "INSERT Incluir Registro  Ý  F1  Posicao Cliente    Ý  F2  Recebimentos      ")
	Write( 19, 01, "DELETE Excluir Registro  Ý  F3  Pagamentos         Ý  F4  Alterar Produtos  ")
	Write( 20, 01, "^ENTER Alterar Registro  Ý  F5  Lista Precos       Ý  F6  Consulta Entradas ")
	Write( 21, 01, "^Q     Limpar Fatura     Ý  F7  Alterar Fornecedor Ý  F8  Posicao Fornecedor")
	Write( 22, 01, "F10    Fechar Fatura     Ý  F9  Incluir Fornecedor Ý  F11 Devolucao Fatura  ")
	Write( 23, 01, "F12                      Ý ^F1  Alteracao Pagar    Ý ^F2  Alteracao Pago    ")
EndiF
Return

Proc Entrada_Soma( nTotal, lMostrar, nFunrural, nTotCustoFim )
**************************************************************
LOCAL nSoma 		 := 0
LOCAL nCurrente	 := xAlias->(Recno())
FIELD Quant
FIELD Unitario
FIELD Porc

xAlias->(DbGoTop())
nTotal				 := 0
nTotCustoFim		 := 0
nFunrural			 := 0
WHILE !Eof()
	 nTotal		  += xAlias->Quant * xAlias->Unitario
	 nTotCustoFim += xAlias->Quant * xAlias->CustoFinal
	 nFunRural	  += xalias->FunRural
	 xAlias->(DbSkip(1))
EndDo
xAlias->(DbGoTo( nCurrente ))
IF lMostrar = Nil
	MaBox( 17, 00, MaxRow(), MaxCol(),"TOTAL COMPRA R$ " + Tran( nTotal, "@E 9,999,999,999.99") + " Ý TOTAL CUSTO R$  " + Tran( nTotCustoFinal, "@E 9,999,999,999.99"))
	Write( 18, 01,"--+    Incluir RegistrosÝ  ^--+ Alterar           Ý  ^Q  Limpar Fatura    ")
	Write( 19, 01,"DELETE  Excluir RegistrosÝ  F10   Fechar Fatura     Ý  F11 Devolucao Total  ")
	Write( 20, 01,"F5      Lista Precos     Ý                          Ý                       ")
	Write( 21, 01,"                         Ý                          Ý                       ")
	Write( 22, 01,"                         Ý                          Ý                       ")
	Write( 23, 01,"                         Ý                          Ý                       ")
EndiF
Return

Proc TelaFechaEntra()
*********************
MaBox( 00, 00, 10, MaxCol() )
Write( 01, 01, "Forma Pagto   :")
Write( 02, 01, "N§ Nff        :                 N§ Duplicata :           Cfop    :")
Write( 03, 01, "Data Emissao  :                 Data Entrada :           % Icms  :")
Write( 04, 01, "Valor Real    :                 Valor NFF    :")
Write( 05, 01, "Valor Frete   :                 Conhecimento :           Emissao :")
Write( 06, 01, "Valor Imposto :                 N§ Documento :           Emissao :")
Write( 07, 01, "Fornecedor    :")
Write( 08, 01, "Transportador :")
Write( 09, 01, "Imposto       :")
#IFDEF DEF_CEREAIS
	IF lCereais
		MaBox( 11, 00, 13, MaxCol())
		Write( 12, 1 , "Fornecedor..:                                          Funrural.:             ")
	EndIF
#ENDIF
Return

Function FechaEntra( cCaixa, lManutencao, aDevolucao, lVarejo )
****************************************************************
STATIC aArray		  := {}
LOCAL GetList		  := {}
LOCAL cScreen		  := SaveScreen()
LOCAL cCond 		  := Space(24)
LOCAL dEmissao 	  := Date()
LOCAL dEntrada 	  := Date()
LOCAL cFatura		  := Space(07)
LOCAL cDocnr		  := Space(07)
LOCAL cCodi 		  := Space(04)
LOCAL cCodi1		  := Space(04)
LOCAL nValor		  := 0
LOCAL nMarCus		  := 0
LOCAL Arq_Ant		  := Alias()
LOCAL Ind_Ant		  := IndexOrd()
LOCAL aVcto 		  := {}
LOCAL VlrDup		  := {}
LOCAL aCodi 		  := {}
LOCAL aFatura		  := {}
LOCAL aVlrFatu 	  := {}
LOCAL aEmis 		  := {}
LOCAL nConta		  := 0
LOCAL nJuro 		  := 0
LOCAL nDesconto	  := 0
LOCAL nUfir 		  := 0
LOCAL nIcms 		  := 0
LOCAL nTotCustoFim  := 0
LOCAL nVlrIcms 	  := 0
LOCAL cDocIcms
LOCAL aDocnr
LOCAL aVlr
LOCAL aTipo
LOCAL aJuro
LOCAL aObs1
LOCAL aObs2
LOCAL aDesconto
LOCAL aPortador
LOCAL nCol
LOCAL nLetra
LOCAL nQtd_dup
LOCAL cFatu3
LOCAL nQt_Eleme
LOCAL nSoma
LOCAL nContaData := 0
LOCAL nFunrural  := 0
LOCAL cConhecimento
LOCAL dEmisFrete
LOCAL dEmisIcms
LOCAL dVctoFrete
LOCAL dVctoIcms
LOCAL cCodiFrete
LOCAL cCodiGov
LOCAL nValorFrete
LOCAL dVctoDup
LOCAL nSobra
LOCAL Sobra
LOCAL cTipo
LOCAL xConhecimento
LOCAL xValorFrete
LOCAL xEmisFrete
LOCAL xVctoFrete
LOCAL xObs1
LOCAL xObs2
LOCAL xDesconto
LOCAL cPortador
LOCAL cTela
LOCAL xVar
LOCAL i
LOCAL x
LOCAL cCfop
LOCAL cNatu 	:= ""
LOCAL aCfop 	:= {}
LOCAL aNatu 	:= {}
LOCAL aTxIcms	:= {}

oMenu:Limpa()
TelaFechaEntra()
SomaEntrada( @nValor, OK, @nFunrural, NIL, @nTotCustoFim )
xAlias->(DbGoTop())

aNatu 		  := LerNatu()
aCFop 		  := LerCfop()
aTxIcms		  := LerIcms()
cCond 		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[01], Space(23) 	), aDevolucao[01])
dEmissao 	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[02], Date() 		), aDevolucao[02])
dEntrada 	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[03], Date() 		), aDevolucao[03])
cFatura		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[04], Space(07) 	), aDevolucao[04])
cDocnr		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[05], Space(07) 	), aDevolucao[05])
cCodi 		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[06], xAlias->Codi ), aDevolucao[06])
nIcms 		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[07], 0				), aDevolucao[07])
cCfop 		  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[08], Space(05) 	), aDevolucao[08])
cConhecimento := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[09], Space(07) 	), Space(07)	  )
nValorFrete   := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[10], 0				), 0				  )
dEmisFrete	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[11], Date() 		), Date()		  )
cCodiFrete	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[12], Space(04) 	), Space(04)	  )
nVlrIcms 	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[13], 0				), 0				  )
cDocIcms 	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[14], Space(07) 	), Space(07)	  )
dEmisIcms	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[15], Date() 		), Date()		  )
cCodiGov 	  := IF( lManutencao = NIL, IF( !Empty( aArray ), aArray[16], Space(04) 	), Space(04)	  )

Set Conf On
@ 01, 18 Get cCond			 Pict "@!"  Valid !Empty( cCond )
@ 02, 18 Get cFatura 		 Pict "@K!" Valid !Empty( cFatura ) .OR. LastKey() = UP
@ 02, 49 Get cDocnr			 Pict "@K!" Valid !Empty( cDocnr ) .OR. LastKey() = UP
@ 02, 69 Get cCfop			 Pict "9.999" Valid PickTam2( @aNatu, @aCfop, @aTxIcms, @cCfop, @cNatu, @nIcms ) .OR. LastKey() = UP
@ 03, 18 Get dEmissao		 Pict PIC_DATA
@ 03, 49 Get dEntrada		 Pict PIC_DATA
@ 03, 69 Get nIcms			 Pict "99" Valid nIcms > 0 .OR. LastKey() = UP
@ 04, 18 Get nTotCustoFim	 Pict "@E 999,999,999.99" Valid nTotCustoFim > 0 .OR. LastKey() = UP
@ 04, 49 Get nValor			 Pict "@E 999,999,999.99" Valid nValor > 0 .OR. LastKey() = UP
@ 05, 18 Get nValorFrete	 Pict "@E 999,999,999.99"
@ 05, 49 Get cConhecimento  Pict "@K!" When nValorFrete != 0 Valid !Empty( cConhecimento ) .OR. LastKey() = UP
@ 05, 69 Get dEmisFrete 	 Pict PIC_DATA When nValorFrete != 0 Valid !Empty( dEmisFrete ) .OR. LastKey() = UP
@ 06, 18 Get nVlrIcms		 Pict "@E 999,999,999.99"
@ 06, 49 Get cDocIcms		 Pict "@K!" When nVlrIcms    != 0 Valid !Empty( cDocIcms ) .OR. LastKey() = UP
@ 06, 69 Get dEmisIcms		 Pict PIC_DATA When nVlrIcms != 0 Valid !Empty( dEmisIcms ) .OR. LastKey() = UP
@ 07, 18 Get cCodi			 Pict "9999" Valid Fornecedor( @cCodi,, Row(), Col()+1 ) .OR. LastKey() = UP
@ 08, 18 Get cCodiFrete 	 Pict "9999" When nValorFrete !=0  Valid Fornecedor( @cCodiFrete,, Row(), Col()+1 ) .OR. LastKey() = UP
@ 09, 18 Get cCodiGov		 Pict "9999" When nVlrIcms    !=0  Valid Fornecedor( @cCodiGov,, Row(), Col()+1 ) .OR. LastKey() = UP
#IFDEF DEF_CEREAIS
	IF lCereais
		@ 13, 66 Get cCodi1		Pict "9999" Valid Pagarrado(@cCodi1, Row(), 15)
	EndIF
#ENDIF
Read
Set Conf Off
aArray := { cCond,dEmissao,dEntrada,cFatura,cDocnr,cCodi,nIcms, cCfop, cConhecimento, nValorFrete, dEmisFrete, cCodiFrete, nVlrIcms, cDocIcms, dVctoIcms, cCodiGov }
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
cCond  := RTrim( cCond )
nConta := ChrCount("/", cCond ) + 1
For x := 1 To nConta
	 Aadd( aVcto, dEmissao + Val( StrExtract( cCond,"/", x )))
Next
MaBox( 11, 0, 24, MaxCol() )
Write( 12, 1, Padc("DESDOBRAMENTO DOS TITULOS A PAGAR", MaxCol()-2 ))
Write( 13, 1, Repl( "Ä", MaxCol()-1))
Write( 14, 1, "  TITULO N§        VALOR DIAS VENCTO    TIPO  JR/MES  DESC PORTADOR  " )
Write( 15, 1, Repl( "Ä", MaxCol()-1))
Write( 16, 1, "A:                                                                           " )
Write( 17, 1, "B:                                                                           " )
Write( 18, 1, "C:                                                                           " )
Write( 19, 1, "D:                                                                           " )
Write( 20, 1, "E:                                                                           " )
Write( 21, 1, Repl( "Ä", MaxCol()-1))
Write( 22, 1, "OBS:                                                                         " )
Write( 23, 1, "                                                                             " )

// Pagamento a Fornecedor
aDocnr	  := Array( nConta )
VlrDup	  := Array( nConta )
aTipo 	  := Array( nConta )
aJuro 	  := Array( nConta )
aObs1 	  := Array( nConta )
aObs2 	  := Array( nConta )
aDesconto  := Array( nConta )
aPortador  := Array( nConta )
nQtd_dup   := nConta
nQt_Eleme  := nConta
nCol		  := 16
nLetra	  := 1
nSoma 	  := 0
nContaData := 0
nJuro 	  := 0
nDesconto  := 0
Recemov->(Order( RECEMOV_DOCNR ))
//nValor 		 -= nFunRural
nTotCustoFim  -= nFunRural
For i = 1 To nConta
	dVctoDup 	 := aVcto[i]
	nContaData	 := (dVctoDup-dEmissao )
	aTipo[i] 	 := IF( i = 1, "DM    ",     aTipo[(i-1)])
	aPortador[i] := IF( i = 1, "CARTEIRA  ", aPortador[(i-1)])
	aJuro[i] 	 := IF( i = 1, nJuro 		, aJuro[(i-1)])
	aDesconto[i] := IF( i = 1, nDesconto	, aDesconto[(i-1)])
	nSobra		 := ( 7 - Len( Trim( cFatura )))
	aObs1[i] 	 := Space(60)
	aObs2[i] 	 := Space(60)
	aDocnr[i]	 := Trim( cDocnr ) + "-" + AllTrim(Str( nLetra )) + Space( nSobra )
	IF i == nConta
		VlrDup[i] := (Sobra := ( nTotCustoFim - nSoma ))
	Else
		VlrDup[i] := Int((( nTotCustoFim - nSoma ) / nQtd_dup ))
	EndIf
	cTipo := IF( nContaData = 0, "DM    ", aTiPo[i] )
	@ nCol, 04 Get aDocnr[i]	 Pict "@!" Valid Recemov->(DocFucer( aDocnr[i] ))
	@ nCol, 15 Get VlrDup[i]	 Pict "@E 999,999.99"
	@ nCol, 26 Get nContaData	 Pict "999" Valid SomaData( @dVctoDup, dEmissao, nContaData )
	@ nCol, 30 Get dVctoDup 	 Pict PIC_DATA
	@ nCol, 41 Get cTipo 		 Pict "@!"
	@ nCol, 48 Get aJuro[i] 	 Pict "99.99"
	@ nCol, 54 Get aDesconto[i] Pict "99.99"
	@ nCol, 60 Get aPortador[i] Pict "@!"
	@ 22,   04 Get aObs1[i] 	 Pict "@!"
	@ 23,   04 Get aObs2[i] 	 Pict "@!"
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	aTipo[i] := cTipo
	aVcto[i] := dVctoDup
	nSoma 	+= VlrDup[i]
	nJuro 	:= aJuro[i]
	nLetra++
	nQtd_Dup--
	IF i >= 5
		nCol := 20
		Scroll( 16, 01, 20, 78, 1 )
		Write( nCol, 01, Chr( nLetra ) + ":" )
	Else
		nCol++
	EndIF
	Aadd( aEmis,		dEmissao )
	Aadd( aVlrFatu,	nTotCustoFim )
	Aadd( aFatura, 	cFatura )
	Aadd( aCodi,		cCodi )
	IF nSoma < nTotCustoFim .AND. i == nConta
		nConta++
		nQtd_dup++
		Aadd( aTipo,		"")
		Aadd( aJuro,		nJuro )
		Aadd( aPortador,	"" )
		Aadd( aDocnr,		"" )
		Aadd( VlrDup,		0 )
		Aadd( aVcto,		dVctoDup )
		Aadd( aObs1,		Space(60))
		Aadd( aObs2,		Space(60))
		Aadd( aDesconto,	0 )
	EndIF
Next

// Pagamento Frete
IF nValorFrete > 0
	nSobra		  := ( 7 - Len( Trim( cConhecimento )))
	xConhecimento := Trim( cConhecimento ) + "-A" + Space( nSobra )
	xValorFrete   := nValorFrete
	xEmisFrete	  := dEmisFrete
	xVctoFrete	  := dEmisFrete + 30
	nContaData	  := (xVctoFrete-dEmisFrete )
	cTipo 		  := "DM    "
	nJuro 		  := 0
	xObs1 		  := Space(60)
	xObs2 		  := Space(60)
	xDesconto	  := 0
	cPortador	  := "CARTEIRA  "
	MaBox( 11, 0, 24, MaxCol() )
	Write( 12, 1, Padc("TITULO PAGAR A TRANSPORTADOR", MaxCol()-2 ))
	Write( 13, 1, Repl( "Ä", MaxCol()-1))
	Write( 14, 1, "  TITULO N§        VALOR DIAS VENCTO  TIPO  JR/MES  DESC PORTADOR    " )
	Write( 15, 1, Repl( "Ä", MaxCol()-1))
	Write( 16, 1, "A:                                                                           " )
	Write( 17, 1, "B:                                                                           " )
	Write( 18, 1, "C:                                                                           " )
	Write( 19, 1, "D:                                                                           " )
	Write( 20, 1, "E:                                                                           " )
	Write( 21, 1, Repl( "Ä", MaxCol()-1))
	Write( 22, 1, "OBS:                                                                         " )
	Write( 23, 1, "                                                                             " )
	nCol := 16
	@ nCol, 04 Get xConhecimento Pict "@!" Valid Recemov->(DocFucer( xConhecimento ))
	@ nCol, 15 Get xValorFrete   Pict "@E 999,999.99"
	@ nCol, 26 Get nContaData	  Pict "999" Valid SomaData( @dVctoFrete, dEmisFrete, nContaData )
	@ nCol, 30 Get dVctoFrete	  Pict PIC_DATA
	@ nCol, 39 Get cTipo 		  Pict "@!"
	@ nCol, 46 Get nJuro 		  Pict "99.99"
	@ nCol, 52 Get xDesconto	  Pict "99.99"
	@ nCol, 58 Get cPortador	  Pict "@!"
	@ 22,   04 Get xObs1 		  Pict "@!"
	@ 23,   04 Get xObs2 		  Pict "@!"
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	nConta++
	Aadd( aEmis,	  dEmisFrete )
	Aadd( aVlrFatu,  nValorFrete )
	Aadd( aCodi,	  cCodiFrete )
	Aadd( aFatura,   cConhecimento )
	Aadd( aTipo,	  cTipo )
	Aadd( aJuro,	  nJuro )
	Aadd( aPortador, cPortador )
	Aadd( aDocnr,	  xConhecimento )
	Aadd( VlrDup,	  xValorFrete )
	Aadd( aVcto,	  xVctoFrete )
	Aadd( aObs1,	  xObs1	)
	Aadd( aObs2,	  xObs2	)
	Aadd( aDesconto, xDesconto )
EndIF
// Pagamento Imposto
IF nVlrIcms > 0
	nSobra		  := ( 7 - Len( Trim( cDocIcms )))
	xDocIcms 	  := Trim( cDocIcms ) + "-A" + Space( nSobra )
	xVlrIcms 	  := nVlrIcms
	xEmisIcms	  := dEmisIcms
	xVctoIcms	  := dEmisIcms + 30
	nContaData	  := (xVctoIcms-dEmisIcms )
	cTipo 		  := "DM    "
	nJuro 		  := 0
	xObs1 		  := Space(60)
	xObs2 		  := Space(60)
	xDesconto	  := 0
	cPortador	  := "CARTEIRA  "
	MaBox( 11, 0, 24, MaxCol() )
	Write( 12, 1, Padc("LANCAMENTO DE IMPOSTO A PAGAR", MaxCol()-2 ))
	Write( 13, 1, Repl( "Ä", MaxCol()-1))
	Write( 14, 1, "  TITULO N§        VALOR DIAS VENCTO  TIPO  JR/MES  DESC PORTADOR    " )
	Write( 15, 1, Repl( "Ä", MaxCol()-1))
	Write( 16, 1, "A:                                                                           " )
	Write( 17, 1, "B:                                                                           " )
	Write( 18, 1, "C:                                                                           " )
	Write( 19, 1, "D:                                                                           " )
	Write( 20, 1, "E:                                                                           " )
	Write( 21, 1, Repl( "Ä", MaxCol()-1))
	Write( 22, 1, "OBS:                                                                         " )
	Write( 23, 1, "                                                                             " )
	nCol := 16
	@ nCol, 04 Get xDocIcms 	  Pict "@!" Valid Recemov->(DocFucer( xDocIcms ))
	@ nCol, 15 Get xVlrIcms 	  Pict "@E 999,999.99"
	@ nCol, 26 Get nContaData	  Pict "999" Valid SomaData( @dVctoIcms, dEmisIcms, nContaData )
	@ nCol, 30 Get dVctoIcms	  Pict PIC_DATA
	@ nCol, 39 Get cTipo 		  Pict "@!"
	@ nCol, 46 Get nJuro 		  Pict "99.99"
	@ nCol, 52 Get xDesconto	  Pict "99.99"
	@ nCol, 58 Get cPortador	  Pict "@!"
	@ 22,   04 Get xObs1 		  Pict "@!"
	@ 23,   04 Get xObs2 		  Pict "@!"
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	nConta++
	Aadd( aEmis,	  dEmisIcms )
	Aadd( aVlrFatu,  nVlrIcms )
	Aadd( aCodi,	  cCodiGov )
	Aadd( aFatura,   cDocIcms )
	Aadd( aTipo,	  cTipo )
	Aadd( aJuro,	  nJuro )
	Aadd( aPortador, cPortador )
	Aadd( aDocnr,	  xDocIcms )
	Aadd( VlrDup,	  xVlrIcms )
	Aadd( aVcto,	  xVctoIcms )
	Aadd( aObs1,	  xObs1	)
	Aadd( aObs2,	  xObs2	)
	Aadd( aDesconto, xDesconto )
EndIF
ErrorBeep()
IF Conf("Fechar Fatura Agora ?")
	xAlias->(DbGoTop())
	cTela := Mensagem("Aguarde.", WARNING )
	IF lManutencao != NIL
		IF !DevolverEntra( cFatura )
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return( OK )
		EndIF
	EndIF
Else
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
IF lIndexador // Usar indexadores ?
	WHILE Taxas->(!DbSeek( dEmissao ))
		ErrorBeep()
		IF Conf("Ufir Valida para " + Dtoc(dEmissao) + " Nao Encontrada. Registrar ? ")
			InclusaoTaxas( dEmissao )
		EndIF
	EndDo
	nRec := Taxas->(Recno())
	WHILE ( nUfir := Taxas->Ufir ) = 0
		ErrorBeep()
		Alerta(" Registre Valor para Ufir de " + Dtoc(dEmissao ))
		TaxasDbEdit()
		DbGoTo( nRec )
	EndDo
	nUfir := Taxas->Ufir
EndIF
cTela := Mensagem("Aguarde...", WARNING )
Select xAlias
xAlias->(DbGoTop())
Lista->(Order( LISTA_CODIGO ))
WHILE xAlias->(!Eof())
	xCodigo := xAlias->Codigo
	IF Lista->(DbSeek( xCodigo ))
		IF Lista->(TravaReg())
			nMarCus := (( xAlias->CustoFinal / xAlias->Unitario ) * 100 ) - 100
			IF nMarCus > 999.99
				nMarCus := 999.99
			ElseIF nMarCus < -99.99
				nMarCus := -99.99
			EndIF
			Lista->Atualizado := Date()
			Lista->Data 		:= dEntrada
			Lista->MarVar		:= xAlias->MarVar
			Lista->MarAta		:= xAlias->MarAta
			Lista->Marcus		:= nMarCus
			Lista->Ipi			:= xAlias->Ipi
			Lista->Ii			:= xAlias->Ii
			Lista->Ufir 		:= nUfir
			Lista->Imposto 	:= xAlias->Imposto
			Lista->Frete		:= xAlias->Frete
			Lista->PCompra 	:= xAlias->Unitario
			nPcAtu				:= xAlias->CustoFinal
			IF lMediaPonderada
				nQtAnt  := Lista->Quant
				IF nQtAnt >= 1
					nPcAnt  := Lista->PCusto
					nPcEnt  := xAlias->CustoFinal
					nQtEnt  := xAlias->Quant
					nTotAnt := nPcAnt * nQtAnt
					nTotAtu := nPcEnt * nQtEnt
					nPcAtu  := ( nTotAnt + nTotAtu ) / ( nQtAnt + nQtEnt )
				EndIF
			EndIF
			Lista->Quant  += xAlias->Quant
			IF Lista->MarVar > 0 // Margem Varejo ?
				xVar := (( xAlias->CustoFinal * Lista->Marvar ) / 100 ) + xAlias->CustoFinal
				IF lAutoPreco
					Lista->Varejo	:= xVar
					Lista->Pcusto	:= nPcAtu
				EndIF
			EndIF
			IF Lista->MarAta > 0 // Margem Atacado ?
				xVar := (( xAlias->CustoFinal * Lista->MarAta ) / 100 ) + xAlias->CustoFinal
				IF lAutoPreco
					Lista->Atacado := xVar
					Lista->Pcusto	:= nPcAtu
				EndIF
			EndIF
		EndIF
		Lista->(Libera())
	EndIF
	IF Entradas->(Incluiu())
		Entradas->Codigo		:= xAlias->Codigo
		Entradas->Pcusto		:= xAlias->Unitario
		Entradas->CustoFinal := xAlias->CustoFinal
		Entradas->Entrada 	:= xAlias->Quant
		Entradas->Data 		:= dEntrada
		Entradas->VlrFatura	:= nValor
		Entradas->VlrNff		:= nTotCustoFim
		Entradas->Condicoes	:= cCond
		Entradas->Codi 		:= cCodi
		Entradas->Fatura		:= cFatura
		Entradas->Icms 		:= nIcms
		Entradas->Dentrada	:= dEntrada
		Entradas->Cfop 		:= cCfop
		Entradas->Imposto 	:= xAlias->Imposto
		Entradas->Frete		:= xAlias->Frete
		Entradas->(Libera())
	EndIF
	xAlias->(DbSkip(1))
EndDo
For i := 1 To nConta
	IF Pagamov->(Incluiu())
		Pagamov->Codi		  := aCodi[i]
		Pagamov->Docnr 	  := aDocnr[i]
		Pagamov->Fatura	  := aFatura[i]
		Pagamov->Vcto		  := aVcto[i]
		Pagamov->Vlr		  := VlrDup[i]
		Pagamov->Port		  := aPortador[i]
		Pagamov->Tipo		  := aTiPo[i]
		Pagamov->Juro		  := aJuRo[i]
		Pagamov->VlrFatu	  := aVlrFatu[i]
		Pagamov->Emis		  := aEmis[i]
		Pagamov->Jurodia	  := JuroDia( Vlrdup[i], aJuRo[i] )
		Pagamov->Obs1		  := aObs1[i]
		Pagamov->Obs2		  := aObs2[i]
		Pagamov->Desconto   := aDesconto[i]
		Pagamov->Atualizado := dEntrada
		Pagamov->(Libera())
	EndIf
Next
IF nFunrural > 0
	IF Pagamov->(Incluiu())
		Pagamov->Codi		  := cCodi1
		Pagamov->Docnr 	  := aDocnr[1]
		Pagamov->Fatura	  := cFatura
		Pagamov->Vcto		  := dEmissao
		Pagamov->Vlr		  := nFunRural
		Pagamov->Port		  := aPortador[1]
		Pagamov->Tipo		  := aTiPo[1]
		Pagamov->Juro		  := aJuRo[1]
		Pagamov->VlrFatu	  := aVlrFatu[1]
		Pagamov->Emis		  := aEmis[1]
		Pagamov->Jurodia	  := JuroDia( nFunRural, aJuRo[1] )
		Pagamov->Atualizado := dEntrada
		Pagamov->(Libera())
	EndIF
EndIF
IF EntNota->(Incluiu())
	EntNota->Codi		 := cCodi
	EntNota->Numero	 := cFatura
	EntNota->Data		 := dEmissao
	EntNota->Entrada	 := dEntrada
	EntNota->VlrFatura := nValor
	EntNota->VlrNff	 := nTotCustoFim
	EntNota->Icms		 := nIcms
	EntNota->Condicoes := cCond
	EntNota->(Libera())
EndIF
Select xAlias
xAlias->(__DbZap())
xAlias->(DbGoTop())
aArray := {}
ResTela( cTela )
AreaAnt( Arq_Ant, Ind_Ant )
SomaEntrada( @nValor,NIL,NIL,NIL, @nTotCustoFim )
Return( OK )

Proc ManuEntrada( cCaixa )
**************************
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL lVarejo			:= 2
LOCAL aDevolucao		:= {}
LOCAL cVendedor		:= Space(40)
LOCAL cString			:= "INCLUSAO/DEVOLUCAO/EXCLUSAO DE ENTRADAS"
LOCAL xNtx				:= FTempName("T*.TMP")
LOCAL nNivel			:= SCI_DEVOLUCAO_ENTRADAS
LOCAL lManutencao
LOCAL lSair
LOCAL cFatura
LOCAL cScr
LOCAL Handle
LOCAL oOrca
LOCAL nKey
LOCAL cTela
LOCAL Arq_Ant
LOCAL Ind_Ant
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Total
PUBLIC lCereais := FALSO

IF cCaixa = NIL .OR. Empty( cCaixa	)
	IF !VerSenha( @cCaixa, @cVendedor )
		ResTela( cScreen )
		Return
	EndIF
EndIF
IF !aPermissao[ nNivel ]
	IF !PedePermissao( nNivel )
		Restela( cScreen )
		Return
	EndIF
EndIF
#IFDEF DEF_CEREAIS
	ErrorBeep()
	lCereais := Conf("Pergunta: Faturar Cereais ?")
#ENDIF
WHILE OK
	oMenu:Limpa()
	cFatura	  := Space(07)
	aDevolucao := {}
	MaBox( 18, 10, 20, 32 )
	@ 19, 11 Say "Fatura N§...:" Get cFatura Pict "@!" Valid VisualEntraFatura( @cFatura )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde...", Cor())
	Handle := FaturaNew()
	Use ( Handle ) Alias xAlias Exclusive New
	Lista->(Order( LISTA_CODIGO ))
	Entradas->(Order( ENTRADAS_FATURA ))
	Entradas->(DbGoTop())
	IF Entradas->(!DbSeek( cFatura ))
		ErrorBeep()
		Alerta("Erro: Documento nao Localizado.")
		Loop
	EndIF
	aDevolucao := { Entradas->Condicoes, Entradas->Data, Entradas->dEntrada, Entradas->Fatura, Entradas->Fatura, Entradas->Codi, Entradas->Icms, Entradas->Cfop }
	WHILE Entradas->Fatura = cFatura
		xAlias->(DbAppend())
		xAlias->Codigo 	 := Entradas->Codigo
		xAlias->Quant		 := Entradas->Entrada
		xAlias->Descricao  := ( Lista->(DbSeek( Entradas->Codigo )), Lista->Descricao )
		xAlias->Un			 := ( Lista->(DbSeek( Entradas->Codigo )), Lista->Un			)
		xAlias->Unitario	 := Entradas->Pcusto
		xAlias->CustoFinal := Entradas->CustoFinal
		xAlias->Pcusto 	 := Entradas->Pcusto
		xAlias->MarVar 	 := Lista->MarVar
		xAlias->MarAta 	 := Lista->MarAta
		xAlias->Imposto	 := Entradas->Imposto
		xAlias->Frete		 := Entradas->Frete
		xAlias->Total		 := Entradas->Pcusto * Entradas->Entrada
		Entradas->(DbSkip(1))
	EndDo
	oMenu:Limpa()
	Area("xAlias")
	Inde On xAlias->Codigo To ( xNtx )
	Print( 00, 01, Padc( cString, MaxCol()-1), 31 )
	oOrca := BrowseEntradas( 01, 01, 15, (MaxCol()-1) )
	oOrca:ForceStable()
	WHILE OK
		SetCursor(0)
		Entrada_Soma()
		oOrca:ForceStable()
		IF oOrca:HitTop .OR. oOrca:HitBottom
			ErrorBeep()
		EndIf
		nKey	  := InKey( ZERO )
		Arq_Ant := Alias()
		Ind_Ant := IndexOrd()
		IF nKey == K_ESC
			ErrorBeep()
			IF Conf("Pergunta: Sair do Faturamento ?")
				ResTela( cScreen )
				Exit
			EndIF
	  ElseIf nKey == TECLA_INSERT .OR. nKey == TECLA_MAIS .OR. nKey = ENTER
		  xEntraRegistro( oOrca)
		  oOrca:RefreshAll()
		  DbGoBoTTom()
	  ElseIf nKey == ASTERISTICO
		  Entrada_Soma()
	  ElseIf nKey == TECLA_DELETE
		  xDeletar()
		  oOrca:refreshCurrent():forceStable()
		  oOrca:up():forceStable()
		  Freshorder( oOrca)
	  ElseIf nKey == CTRL_Q
		  ErrorBeep()
		  IF Conf(" Limpar Fatura ?")
			  Sele xAlias
			  __DbZap()
			  Entrada_Soma()
		  EndIF
	  ElseIf nKey == CTRL_ENTER
	  ElseIf nKey == F5
		  cTela := SaveScreen()
		  OrcaLista( lVarejo )
		  ResTela( cTela )
	  ElseIf nKey == F10
		  oMenu:Limpa()
		  lManutencao := OK
		  lSair		  := FechaEntra( cCaixa, lManutencao, aDevolucao )
		  ResTela( cScreen )
		  Entrada_Soma()
		  oOrca:RefreshAll()
		  IF lSair
			  Exit
		  EndIF
	  ElseIf nKey == F11
		  ErrorBeep()
		  IF Conf("Pergunta: Fazer Devolucao total desta Fatura ?")
			  cFatura	:= aDevolucao[04]
			  cScr		:= SaveScreen()
			  DevolverEntra( cFatura )
			  ResTela( cScr )
			  Exit
		  EndIF
	  Else
		  TestaTecla( nKey, oOrca )
	  EndIf
	  Print(00,01, Padc( cString, MaxCol()-1), 31 )
	  AreaAnt( Arq_Ant, Ind_Ant )
	  Mostra_Soma()
	EndDo
	ResTela( cScreen )
	Mensagem("Aguarde...", Cor())
	xAlias->(DbCloseArea())
	FClose( Handle )
	Ferase( Handle )
	Ferase( xNtx	)
EndDo

Proc CalcValor()
****************
LOCAL cScreen		  := SaveScreen()
LOCAL nUnitario	  := 0
LOCAL nQuant		  := 0
LOCAL nPago 		  := 0
LOCAL nTotalVendido := 0
LOCAL nDiferenca	  := 0
LOCAL nKilosA		  := 0
LOCAL nTotal1		  := 0
LOCAL nTotal2		  := 0
LOCAL nKilosB		  := 0
LOCAL nGeral		  := 0

MaBox( 17, 00, MaxRow(), MaxCol())
Write( 18, 01, "Quantidade..............:")
Write( 19, 01, "Unitario................:")
Write( 20, 01, "Valor Pago..............:")
Write( 21, 01, "Resultado A.............:")
Write( 22, 01, "Resultado B.............:")
@ 18, 27 Get nQuant	  Pict "999999999.99"
@ 19, 27 Get nUnitario Pict "999999999.99"
@ 20, 27 Get nPago	  Pict "999999999.99"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF

nTotalVendido := ( nUnitario * nQuant )
nDiferenca	  := ( nPago - nTotalVendido )

nKilosA	:= ( nDiferenca * 100 )
nTotal1 := ( nKilosA * (nUnitario + 0.01))

nTotal2 := ( ( nQuant - nKilosA ) * nUnitario)
nKilosB := ( nQuant - nKilosA )

nGeral := ( nTotal1 + nTotal2 )

Write( 21, 27, Tran( nKilosA,"@E 999,999,999.99") + " x " + Tran( nUnitario + 0.01, "999999999.99"))
Write( 22, 27, Tran( nKilosB,"@E 999,999,999.99") + " x " + Tran( nUnitario,        "999999999.99"))
Inkey(0)
ResTela( cScreen )

Function StrCodigo( cCodigo )
*****************************
Return(IF( ValType(cCodigo) = "N", StrZero(cCodigo, 6), cCodigo))

Function SpCodigo()
*******************
Return( Len( Lista->Codigo ))

Proc CaixaNew( cDeleteFile)
***************************
LOCAL xDbfCaixa := "T" + StrTran( Time(),":") + ".TMP"
LOCAL cTela 	 := Mensagem("Aguarde... Criando Arquivo de Trabalho.")
WHILE File(( xDbfCaixa ))
	xDbfCaixa := "T" + StrTran( Time(),":") + ".TMP"
EndDo
Dbf1 := {{ "TIPO",     "C", 06, 0 },;
			{ "POSICAO",  "C", 01, 0 },;
			{ "DATA",     "D", 08, 0 },;
			{ "VCTO",     "D", 08, 0 },;
			{ "NOME",     "C", 40, 0 },;
			{ "DOCNR",    "C", 09, 2 },;
			{ "DEB",      "N", 13, 2 },;
			{ "CRE",      "N", 13, 2 },;
			{ "VLR",      "N", 13, 2 },;
			{ "LCTO",     "N", 01, 0 },;
			{ "FATURA",   "C", 09, 0 },;
			{ "PARCIAL",  "C", 01, 0 },;
			{ "CAIXA",    "C", 04, 0 }}
DbCreate( xDbfCaixa, Dbf1 )
Use (xDbfCaixa ) Alias xDbfCaixa Exclusive New
ResTela( cTela )
Return(( xDbfCaixa ))

Proc CabecCaixa( Pagina, Tam, cTitulo, cCaixa, cTitular )
*********************************************************
Write( 00, 00, Padr( "Pagina N§ " + StrZero( Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
Write( 01, 00, Date())
Write( 02, 00, Padc( AllTrim(oAmbiente:xFanta), Tam ))
Write( 03, 00, Padc( SISTEM_NA1, Tam ))
Write( 04, 00, Padc( cTitulo, Tam ))
Write( 05, 00, Repl( SEP, Tam ))
Return

Proc ImprimeOrcamento()
***********************
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL Col		  := 58
LOCAL nTotal	  := 0
LOCAL Tam		  := 132
LOCAL dValidade  := Date()
LOCAL cCond 	  := Space(30)
LOCAL cCodiVen   := Space(04)
LOCAL cPrazo	  := Space(30)
LOCAL cCliente   := Space(40)
LOCAL cEnde 	  := Space(40)
LOCAL nDesconto  := 0
LOCAL nAcrescimo := 0
LOCAL nVlrDesc   := 0
LOCAL nVlrAume   := 0
LOCAL nTotDesc   := 0
LOCAL nConta	  := 0
LOCAL x			  := 0
LOCAL aVcto 	  := {}
LOCAL aValor	  := {}
LOCAL cString

Lista->(Order( LISTA_CODIGO ))
Area("xAlias")
xAlias->(DbGoTop())
IF xAlias->(Eof())
	ErrorBeep()
	Alerta("Erro: Relacione os produtos para orcamento.")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return
EndIF
Set Rela To Codigo Into Lista
cString := "Vendedor................:"
#IFDEF PANORAMA
	cString := "Mecanico................:"
#ENDIF
MaBox( 05, 05, 14, 72 )
cCodiVen := Vendedor->Nome
@ 06, 06 Say "Percentual de Desconto..:" Get nDesconto  Pict "999.99"
@ 07, 06 Say "Percentual de Acrescimo.:" Get nAcrescimo Pict "999.99"
@ 08, 06 Say "Validade do Orcamento...:" Get dValidade  Pict PIC_DATA
@ 09, 06 Say "Prazo de Pagamento......:" Get cCond      Pict "@!"
@ 10, 06 Say "Prazo de Entrega........:" Get cPrazo     Pict "@!"
@ 11, 06 Say cString 						  Get cCodiVen   Pict "@!"
@ 12, 06 Say "Cliente.................:" Get cCliente   Pict "@!"
@ 13, 06 Say "Endereco................:" Get cEnde      Pict "@!"
Read
IF LastKey() = ESC .OR. !InsTru80()
	xAlias->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
While !Eof()
	IF Col >= 58
		Qout( NG + Padc( AllTrim( cCabecIni ), Tam/2 ) + NR )
		Qout( NG + Padc( "NAO TEM VALOR FISCAL", Tam/2 ) + NR )
		FPrint( PQ )
		Qout( Padc( XENDEFIR + ' - ' + XFONE + ' - ' + AllTrim( XCEPCIDA ) + " - " + XCESTA, Tam ))
		Qout( Repl("-", Tam ))
		Qout( "DATA..............: " + Dtoc( Date()))
		Qout( "VALIDO ATE........: " + Dtoc( dValidade ))
		Qout( "PRAZO DE PAGTO....: " + cCond )
		Qout( "PRAZO DE ENTREGA..: " + cPrazo )
		#IFDEF PANORAMA
			Qout( "MECANICO..........: " + cCodiVen )
		#ELSE
			Qout( "VENDEDOR..........: " + cCodiVen )
		#ENDIF
		Qout( "CLIENTE...........: " + cCliente )
		Qout( "ENDERECO..........: " + cEnde    )
		Qout( Repl("-", Tam ))
		FPrint( C18 )
		Qout( NG + Padc("ORCAMENTO/ORDEM DE SERVICO", Tam/2 ) + NR )
		FPrint( PQ )
		Qout( Repl("-", Tam ))
		Qout( "CODIGO DESCRICAO DO PRODUTO                     UN COD FABRICANTE  MARCA         QUANT  UNITARIO     TOTAL")
		Qout( Repl("-", Tam))
		Col := 16
	EndIF
	Qout( Codigo, Descricao, Un, Lista->N_Original, Lista->Sigla, Quant, Tran(Unitario,"@E 99,999.99"), Tran(Unitario * Quant, "@E 99,999.99"))
	nTotal += ( Unitario * Quant )
	DbSkip()
	Col++
	IF Col >= 55 .OR. Eof()
		Col++
		Qout()
		nTotDesc := nTotal
		IF nDesconto <> 0
			nVlrDesc := 0
			nVlrDesc := (nTotal * nDesconto) / 100
			nTotDesc -= nVlrDesc
		EndIF
		IF nAcrescimo <> 0
			nVlrAume := 0
			nVlrAume := (nTotal * nAcrescimo ) / 100
			nTotDesc += nVlrAume
		EndIF
		nConta	:= ChrCount("/", cCond ) + 1
		nParcela := nTotDesc / nConta
		nSoma 	:= 0
		IF nConta > 1
			nConta := ChrCount("/", cCond ) + 1
			For x := 1 To nConta
				Aadd( aVcto, Date() + Val( StrExtract( cCond,"/", x )))
				IF x = nConta
					Aadd( aValor, nTotDesc - nSoma )
				Else
					Aadd( aValor, nParcela )
				EndIF
				nSoma += Val( Str( nParcela, 13, 2 ))
			 Next
		Else
			nConta := ChrCount("+", cCond ) + 1
			For x := 1 To nConta
				Aadd( aVcto, Date() + Val( StrExtract( cCond,"+", x )))
				IF x = nConta
					Aadd( aValor, nTotDesc - nSoma )
				Else
					Aadd( aValor, nParcela )
				EndIF
				nSoma += Val( Str( nParcela, 13, 2 ))
			Next
		EndIF
		Qout( "** Total Mercadorias ** " + Space(72) + Tran( nTotal,   "@E 999,999.99"))
		Qout( "** Total Acrescimo   ** " + Space(72) + Tran( nVlrAume, "@E 999,999.99"))
		Qout( "** Total Desconto    ** " + Space(72) + Tran( nVlrDesc, "@E 999,999.99"))
		Qout( "** Total Geral       ** " + Space(72) + Tran( nTotDesc, "@E 999,999.99"))
		Qout( Repl("-", Tam))
		Qout("PARCELA  VENCTO               VALOR")
		Qout( Repl("-", Tam))
		For x := 1 To nConta
			Qout( StrZero(x,3), Space(3), aVcto[x], Space(3), Tran( aValor[x], "@E 999,999,999.99"))
		Next
		__Eject()
		Col	 := 58
		nTotal := 0
	EndIF
Enddo
xAlias->(DbClearRel())
PrintOff()

Proc BaixaDebitoC_C( cCaixa )
****************************
LOCAL cScreen	  := SaveScreen()
LOCAL cCodi 	  := Space(05)
LOCAL cFatura	  := Space(07)
LOCAL dData 	  := Date()
LOCAL aMenuArray := {"Baixar Debito Geral", "Baixar Debito Por Fatura", "Baixar Debito Parcial" }
LOCAL nApagar	  := 0
LOCAL nPerc 	  := 0
LOCAL nSobra	  := 0
LOCAL nChoice	  := 0
LOCAL nPvenda	  := 0
LOCAL nChSaldo   := 0
LOCAL nPago 	  := 0
LOCAL cCodigo	  := 0
LOCAL nQuant	  := 0
LOCAL nNivel	  := SCI_RECEBIMENTOS
LOCAL cCodiCx	  := '0000'
LOCAL nVlrLcto   := 0
LOCAL cVendedor  := Space(40)
LOCAL oBloco

IF !aPermissao[ nNivel ]
	IF !PedePermissao( nNivel )
		ResTela( cScreen )
		Return
	EndIf
EndIF
oMenu:Limpa()
IF cCaixa = NIL
	cCaixa := Space(04)
	IF !VerSenha( @cCaixa, @cVendedor )
		ResTela( cScreen )
		Return
	EndIF
EndIF
M_Title("BAIXAR DEBITO")
nChoice := FazMenu( 02, 10, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	WHILE OK
		nApagar	  := 0
		nPago 	  := 0
		MaBox( 10, 10, 15, 78 )
		@ 11, 11 Say "Data............: " Get dData   Pict "##/##/##"
		@ 12, 11 Say "Codigo Cliente..: " Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, 12, 35 ) .AND. BaixaGeral( cCodi, @nApagar, @nPago )
		@ 13, 11 Say "Valor a Pagar...: " Get nApagar Pict "@E 9,999,999,999.99"
		@ 14, 11 Say "Valor Pago......: " Get nPago   Pict "@E 9,999,999,999.99"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		IF Conf(" Confirma a Baixa Geral deste Cliente ?")
			Mensagem(" Aguarde...", Cor(), 20)
			IF Saidas->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Chemov->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Cheque->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			Area("Saidas")
			Saidas->(Order( SAIDAS_CODI ))
			oBloco := {|| Saidas->Codi = cCodi }
			IF Saidas->(Dbseek( cCodi ))
				WHILE Eval( oBloco ) .AND. !Eof()
					IF Saidas->C_c
						Saidas->C_c 		:= FALSO
						Saidas->SaidaPaga := Saidas->Saida
						cFatura				:= Saidas->Fatura
					EndIF
					Saidas->(DbSkip(1))
				EndDo
				Saidas->(Libera())
				Cheque->(Order( CHEQUE_CODI ))
				IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
					IF Chemov->(Incluiu())
						nVlrLcto 		  := nPago
						nChSaldo 		  := Cheque->Saldo
						nChSaldo 		  += nVlrLcto
						IF nChSaldo < 999999999999999.99
							Cheque->Saldo	  += nVlrLcto
							Cheque->Creditos += nVlrLcto
						EndIF
						Chemov->Deb 	  := 0
						Chemov->Cre 	  := nVlrLcto
						Chemov->Codi	  := cCodiCx
						Chemov->Docnr	  := cFatura
						Chemov->Emis	  := dData
						Chemov->Data	  := dData
						Chemov->Baixa	  := Date()
						Chemov->Hist	  := "CRE REF FATURA N§ " + cFatura
						Chemov->Saldo	  := nChSaldo
						Chemov->Tipo	  := "DH"
						Chemov->Caixa	  := IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura   := cFatura
					 EndIF
				EndIF
			EndIF
			Chemov->(Libera())
			Cheque->(Libera())
			Saidas->(Libera())
		EndIF
		ResTela( cScreen )
	EndDo

Case nChoice = 2
	WHILE OK
		nApagar	  := 0
		nPerc 	  := 0
		nSobra	  := 0
		nPago 	  := 0
		nApagar	  := 0
		MaBox( 10, 10, 17, 78 )
		@ 11, 11 Say "Codigo Cliente..: " Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, 11, 35 )
		@ 12, 11 Say "Fatura n§.......: " Get cFatura Pict "@!"   When BaixaLocaliza( cCodi, @cFatura ) Valid VisualAchaFatura( @cFatura, @nApagar, @cCodi )
		@ 13, 11 Say "Data............: " Get dData   Pict "##/##/##" Valid SomaPago( @nApagar, cFatura, @nPago )
		@ 14, 11 Say "Valor a Pagar...: " Get nApagar Pict "@E 9,999,999,999.99"
		@ 15, 11 Say "Desconto........: " Get nPerc   Pict "999.99" Valid nPerc >= 0 .AND. CalcSobra( nApagar, nPerc, @nSobra )
		@ 16, 11 Say "Valor Pago......: " Get nSobra  Pict "@E 9,999,999,999.99"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		IF Conf(" Confirma a Baixa desta Fatura ?")
			Mensagem(" Aguarde...", Cor(), 20)
			IF Saidas->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Chemov->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Cheque->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			Lista->(Order( LISTA_CODIGO ))
			Area("Saidas")
			Saidas->(Order( SAIDAS_FATURA ))
			Set Rela To Codigo Into Lista
			oBloco := {|| Saidas->Fatura = cFatura }
			IF Saidas->(Dbseek( cFatura ))
				WHILE Eval( oBloco ) .AND. !Eof()
					IF Saidas->C_c
						nPvenda				:= Lista->Varejo
						IF nPerc > 0
							nDiferenca		:= ( nPvenda * nPerc ) / 100
						Else
							nDiferenca		:= 0
						EndIF
						Saidas->C_c 		:= FALSO
						Saidas->Pvendido	:= ( nPvenda - nDiferenca )
						Saidas->Desconto	:= nPerc
						Saidas->Diferenca := nDiferenca
						Saidas->VlrFatura := IF( nPerc = 0, ( nApagar + nPago ), nSobra )
					EndIF
					Saidas->(DbSkip(1))
				EndDo
				Saidas->(DbClearRel())
				Saidas->(Libera())
				Cheque->(Order( CHEQUE_CODI ))
				IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
					IF Chemov->(Incluiu())
						nVlrLcto 		  := nSobra
						nChSaldo 		  := Cheque->Saldo
						nChSaldo 		  += nVlrLcto
						IF nChSaldo < 999999999999999.99
							Cheque->Saldo	  += nVlrLcto
							Cheque->Creditos := ( Cheque->Creditos + nVlrLcto )
						EndIF
						Chemov->Deb 	  := 0
						Chemov->Cre 	  := nVlrLcto
						Chemov->Codi	  := cCodiCx
						Chemov->Docnr	  := cFatura
						Chemov->Emis	  := dData
						Chemov->Data	  := dData
						Chemov->Baixa	  := Date()
						Chemov->Hist	  := "CRE REF FATURA N§ " + cFatura
						Chemov->Saldo	  := nChSaldo
						Chemov->Tipo	  := "DH"
						Chemov->Caixa	  := IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura   := cFatura
					EndIF
				EndIF
				Chemov->(Libera())
				Cheque->(Libera())
			EndIF
		EndIF
		ResTela( cScreen )
	EndDo

Case nChoice = 3
	WHILE OK
		nApagar	  := 0
		nPerc 	  := 0
		nSobra	  := 0
		nPago 	  := 0
		nApagar	  := 0
		cCodigo	  := 0
		nQuant	  := 0
		nRegistro  := 0
		MaBox( 15, 10, 23, 78 )
		@ 16, 11 Say "Codigo Cliente  : " Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, 16, 35 )
		@ 17, 11 Say "Codigo Produto  : " Get cCodigo Pict "999999" Valid BaixaProcura( cCodi, @cFatura, @cCodigo, @nQuant, @nApagar, @nRegistro )
		@ 18, 11 Say "Quant a Baixar  : " Get nQuant  Pict "999999.99" Valid SomaPagoInd( @nApagar, cFatura, nQuant, cCodigo, nRegistro )
		@ 19, 11 Say "Data            : " Get dData   Pict "##/##/##"
		@ 20, 11 Say "Valor a Pagar   : " Get nApagar Pict "@E 9,999,999,999.99"
		@ 21, 11 Say "Desconto        : " Get nPerc   Pict "999.99" Valid nPerc >= 0 .AND. CalcSobra( nApagar, nPerc, @nSobra )
		@ 22, 11 Say "Valor Pago      : " Get nSobra  Pict "@E 9,999,999,999.99"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		IF Conf(" Confirma a Baixa desta Fatura ?")
			Mensagem(" Aguarde...", Cor(), 20)
			IF Saidas->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Chemov->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			IF Cheque->(!TravaArq()) ; Restela( cScreen ) ; Loop ; EndIF
			Area("Saidas")
			Saidas->(DbGoTo( nRegistro )) // Localiza Registro
			IF Saidas->C_c
				IF Saidas->Codigo != cCodigo
					Saidas->(Libera())
					Chemov->(Libera())
					Cheque->(Libera())
					ErrorBeep()
					Alerta("Erro: Baixa nao Efetuada.")
					Loop
				EndIF
				nSoma 				:= Saidas->SaidaPaga + nQuant
				Saidas->SaidaPaga += nQuant
				Saidas->C_c 		:= IF( Saidas->Saida = nSoma, FALSO, OK )
			Else
				Saidas->(Libera())
				Chemov->(Libera())
				Cheque->(Libera())
				ErrorBeep()
				Alerta("Erro: Baixa nao Efetuada.")
				Loop
			EndIF
			Saidas->(Libera())
			Cheque->(Order( CHEQUE_CODI ))
			IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
				IF Chemov->(Incluiu())
					nVlrLcto 		  := nSobra
					nChSaldo 		  := Cheque->Saldo
					nChSaldo 		  += nVlrLcto
					IF nChSaldo < 999999999999999.99
						Cheque->Saldo	  += nChSaldo
						Cheque->Creditos := ( Cheque->Creditos + nVlrLcto )
					EndIF
					Chemov->Codi	  := cCodiCx
					Chemov->Deb 	  := 0
					Chemov->Cre 	  := nVlrLcto
					Chemov->Docnr	  := cFatura
					Chemov->Emis	  := dData
					Chemov->Data	  := dData
					Chemov->Baixa	  := Date()
					Chemov->Hist	  := "CRE REF FATURA N§ " + cFatura
					Chemov->Saldo	  := nChSaldo
					Chemov->Tipo	  := "DH"
					Chemov->Caixa	  := IF( cCaixa = Nil, Space(4), cCaixa )
					Chemov->Fatura   := cFatura
				 EndIF
			EndIF
			Chemov->(Libera())
			Cheque->(Libera())
		EndIF
		ResTela( cScreen )
	EndDo
EndCase

Proc VerBaixa(cCaixa, cVendedor)
********************************
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL aMenu 	  := {"Contas a Receber", "Conta Corrente"}

M_Title("ESCOLHA TIPO DE BAIXA")
oMenu:Limpa()
nChoice := FazMenu( 04, 10, aMenu, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	BaixasRece(cCaixa, cVendedor)
Case nChoice = 2
	BaixaDebitoC_C( cCaixa )
EndCase
ResTela( cScreen )
Return

Proc VerCaixa( cCaixa )
***********************
LOCAL cScreen	  := SaveScreen()
LOCAL nChoice	  := 1
LOCAL aMenu 	  := {"Lanc Debito/Credito", "Rol Resumo Caixa", "Rol Detalhe Caixa", "Inclusao Che-Predatados"}

M_Title("MENU DO CAIXA")
oMenu:Limpa()
nChoice := FazMenu( 04, 10, aMenu, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return
Case nChoice = 1
	LancaMovimento( cCaixa )
Case nChoice = 2
	DetalheCaixa( cCaixa, FALSO )
Case nChoice = 3
	DetalheCaixa( cCaixa, OK )
Case nChoice = 4
	Cheq_Pre1()
EndCase
ResTela( cScreen )
Return

Proc xEntraRegistro( oObjeto )
******************************
STATIC nDesc		 := 0
LOCAL nCol			 := 11
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL xCodigo		 := 0
LOCAL nPreco		 := 0
LOCAL nQuant		 := 0
LOCAL nSoma 		 := 0
LOCAL nMarVar		 := 0
LOCAL nMarAta		 := 0
LOCAL lSub			 := OK
LOCAL nFunrural	 := 0
LOCAL nIpi			 := 0
LOCAL nIi			 := 0
LOCAL nKey			 := 0
LOCAL nCustoFinal  := 0
LOCAL nPercFrete	 := 0
LOCAL nPercImposto := 0
LOCAL nMerc 		 := 0
LOCAL nTotCustoFim := 0
LOCAL yCodigo		 := 0

SomaEntrada( @nMerc,NIL,NIL,NIL, @nTotCustoFim )
Write( 15, 61, Tran( nMerc, "@E 9,999,999,999.99"))
WHILE OK
	xCodigo		 := 0
	nDesc 		 := 0
	nPreco		 := 0
	nQuant		 := 0
	nSoma 		 := 0
	nFrete		 := 0
	nIpi			 := 0
	nIi			 := 0
	nCustoFinal  := 0
	nPercFrete	 := 0
	nPercImposto := 0
	SetColor("W+/G")
	TelaEnt()
	@ 18, nCol Get xCodigo		 Pict "9999999999999" Valid EntraProduto( @xCodigo, @nPreco, 18, 38, lSub, @nMarVar, @nMarAta, @nCustoFinal, @nIpi, @yCodigo ) .AND. CalculaCusto( @nQuant, @nPreco, @nFunrural )
	@ 19, nCol Get nQuant		 Pict "99999.99" Valid nQuant != 0
	@ 19, 38   Get nPreco		 Pict "99,999,999.99"
	@ 20, nCol Get nDesc 		 Pict "99.99"
	@ 20, 38   Get nPercFrete	 Pict "99.99"
	@ 21, nCol Get nPercImposto Pict "99.99" Valid Calc_Custo( nPreco, @nCustoFinal, nDesc, nPercImposto, nPercFrete )
	@ 21, 38   Get nCustoFinal  Pict "99,999,999.99"
	@ 22, nCol Get nMarVar Pict "999.99"
	@ 22, 38   Get nMarAta Pict "999.99"
	If lIpi
		@ 23, nCol Get nIpi Pict "99.99"
		@ 23, 38   Get nIi  Pict "99.99"
	EndIF
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		SomaEntrada()
		Exit
	EndIF
	DbAppend()
	nSoma 				 := nPreco * nQuant
	xAlias->Codigo 	 := yCodigo
	xAlias->Codebar	 := xCodigo
	xAlias->Quant		 := nQuant
	xAlias->Desconto	 := nDesc
	xAlias->Un			 := Lista->Un
	xAlias->Descricao  := Lista->Descricao
	xAlias->CustoFinal := nCustoFinal
	xAlias->Unitario	 := nPreco
	xAlias->Atacado	 := Lista->Atacado
	xAlias->Pcusto 	 := Lista->Pcusto
	xAlias->Porc		 := Lista->Porc
	xAlias->Codi		 := Lista->Codi
	xAlias->Total		 := nSoma
	xAlias->MarVar 	 := nMarVar
	xAlias->MarAta 	 := nMarAta
	xAlias->Imposto	 := nPercImposto
	xAlias->Frete		 := nPercFrete
	xAlias->Ipi 		 := nIpi
	xAlias->Ii			 := nIi
	xAlias->FunRural	 := nFunRural
	IF xAlias->(Recno()) <= 11
		oObjeto:gotop()			  // move o cursor para baixo
	Else
		oObjeto:goBottom()		  // move o cursor para esquerda
	EndIF
	oObjeto:ForceStable()
	SomaEntrada( @nMerc,NIL,NIL,NIL, @nTotCustoFim )
	Write( 15, 61, Tran( nMerc, "@E 9,999,999,999.99"))
EndDo

Function EntraProduto( cCodigo, nPcusto, nLine, nCol, lSub, nMarVar, nMarAta, nCustoFinal, nIpi, yCodigo )
**********************************************************************************************************
LOCAL GetList			  := {}
LOCAL aRotina			  := {{|| InclusaoProdutos() }}
LOCAL aRotinaAlteracao := {{|| InclusaoProdutos(OK) }}
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()
LOCAL nTam				  := 6
LOCAL nTipoBusca		  := oIni:ReadInteger('sistema','tipobusca', 1 )
LOCAL cTemp
LOCAL cScreen
LOCAL cGrupo
LOCAL cSub

Set Key F9 To InclusaoProdutos()
IF nPcusto = VOID
	IF Empty( cCodigo )
		cCodigo := StrCodigo( cCodigo )
		Set Key F9 To
		Return(OK)
	EndIF
EndIF
Pagar->(Order( PAGAR_CODI ))
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
Grupo->(Order( GRUPO_CODGRUPO ))
cTemp   := IF( ValType(cCodigo) = "N", Str(cCodigo, 13), cCodigo)
nTam	  := Len( AllTrim( cTemp ))
IF nTam <= 6
	nTam	  := 6
	cCodigo :=IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
ElseIF nTam = 8
	nTam	  := 8
	cCodigo := IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
 Else
	nTam	  := 13
	cCodigo := IF( ValType(cCodigo) = "N", StrZero(cCodigo, nTam), cCodigo)
EndIF
Area("Lista")
IF nTam = 6
	Lista->(Order( LISTA_CODIGO ))
ElseIF nTam = 13 .OR. nTam = 8
	Lista->(Order( LISTA_CODEBAR ))
EndIF
Lista->(DbGoTop())
IF Lista->(Eof())
	ErrorBeep()
	IF !Conf( "Pergunta: Nenhum Produto Registrado... Registrar ? " )
		AreaAnt( Arq_Ant, Ind_Ant )
		Set Key F9 To
		ResTela( cScreen )
		Return( FALSO )
	Else
		cScreen := SaveScreen()
		InclusaoProdutos()
		AreaAnt( Arq_Ant, Ind_Ant )
		Set Key F9 To
		ResTela( cScreen )
		Return( FALSO )
	EndIF
EndIF
IF !( DbSeek( cCodigo ))
	IF nTipoBusca = 1
		Lista->(Order( LISTA_DESCRICAO ))
		Escolhe( 03, 00, 22, "Codigo + 'Ý' + Sigla + 'Ý' + Left( Descricao, 39 ) + 'Ý' + Tran( Quant, '99999.99') + 'Ý' + Tran( Pcusto, '@E 99,999.99')","CODI  MARCA      DESCRICAO DO PRODUTO                      ESTOQUE     CUSTO", aRotina,, aRotinaAlteracao )
	Else
		Lista->(Order( LISTA_N_ORIGINAL ))
		Escolhe( 03, 00, 22, "N_Original + 'Ý' + Sigla + 'Ý' + Left( Descricao, 31 ) + 'Ý' + Tran( Quant, '9999.99') + 'Ý' + Tran( Varejo, '@E 99,999.99')","COD FABR        MARCA      DESCRICAO DO PRODUTO            ESTOQUE    PRECO", aRotina,, aRotinaAlteracao )
	EndIF
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Set Key F9 To
		Return( FALSO )
	EndIF
EndIF
cCodigo		:= Lista->CodeBar
yCodigo		:= Lista->Codigo
nIpi			:= Lista->Ipi
nCustoFinal := Lista->Pcusto
nPcusto		:= Lista->PCompra
nMarVar		:= Lista->MarVar
nMarAta		:= Lista->MarAta
Pagar->(DbSeek( Lista->Codi ))
IF nLine != VOID
	Write( nLine,	 nCol, Lista->Descricao )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Set Key F9 To
Return( OK )

Function Calc_Custo( nPreco, nCustoFinal, nDesc, nPercImposto, nPercFrete )
***************************************************************************
LOCAL xVlrComDesconto := 0
LOCAL xImposto 		 := 0
LOCAL xFrete			 := 0

IF nCustoFinal != 0
	IF nDesc = 0
		IF nPercImposto = 0
			IF nPercFrete = 0
				Return( OK )
			EndIF
		EndIF
	EndIF
EndIF
xVlrComDesconto := ( nPreco - ((nPreco * nDesc ) / 100))
xImposto 		 := ((xVlrComDesconto * nPercImposto ) / 100)
xVlrComDesconto += xImposto
xFrete			 := ((xVlrComDesconto * nPercFrete	 ) / 100)
xVlrComDesconto += xFrete
nCustoFinal 	 := xVlrComDesconto
Return(OK)

Proc TelaSai( cString )
***********************
MaBox( 17, 00, 23, MaxCol(), cString, NIL, Roloc( Cor() ))
Write( 18, 01, "Codigo.:             ³Descricao.:                                             ")
Write( 19, 01, "Quant..:             ³Grupo.....:                                             ")
Write( 20, 01, "Desc...:             ³SubGrupo..:                                             ")
Write( 21, 01, "Preco..:             ³Cod Fabr..:                  Marca....:                 ")
Write( 22, 01, "Serie..:             ³Tamanho...:                  Desc Max.:                 ")
Return

Proc TelaEnt()
**************
MaBox( 17, 00, MaxRow(), MaxCol())
Write( 18, 01, "Codigo...:               Descricao..:                            ")
Write( 19, 01, "Entrada..:               Custo Nota.:                            ")
Write( 20, 01, "Desconto.:               Frete......:                            ")
Write( 21, 01, "Imposto..:               Custo Real.:                            ")
Write( 22, 01, "Mar Vare.:               Mar Atac...:                            ")
Write( 23, 01, "Ipi......:               Ii.........:                            ")
Return

Proc xAltEntradas()
*******************
LOCAL GetList		:= {}
LOCAL nRecno		:= Recno()
LOCAL lSub			:= OK
LOCAL nCol			:= 11
LOCAL xCodigo
LOCAL nQuant
LOCAL nPreco
LOCAL cSerie
LOCAL cDescricao
LOCAL nMarVar
LOCAL nMarAta
LOCAL nFunRural
LOCAL nDesc
LOCAL nIpi
LOCAL nIi
LOCAL yCodigo
LOCAL nCustoFinal  := 0
LOCAL nPercFrete	 := 0
LOCAL nPercImposto := 0

IF Recco() = ZERO
	ErrorBeep()
	Alerta("Erro: Sem Registros...")
	Return
EndIF
DbGoto( nRecno )
SetColor( "W+/R")
TelaEnt()
xCodigo		 := xAlias->(Val( Codebar ))
yCodigo		 := xAlias->Codigo
nQuant		 := xAlias->Quant
nDesc 		 := xAlias->Desconto
nPreco		 := xAlias->Unitario
cSerie		 := xAlias->Serie
cDescricao	 := xAlias->Descricao
nMarVar		 := xAlias->MarVar
nMarAta		 := xAlias->MarAta
nFunRural	 := xAlias->FunRural
nIpi			 := xAlias->Ipi
nIi			 := xAlias->Ii
nCustoFinal  := xAlias->CustoFinal
nPercImposto := xAlias->Imposto
nPercFrete	 := xAlias->Frete

@ 18, nCol Get xCodigo		 Pict "9999999999999" Valid EntraProduto( @xCodigo, @nPreco, 18, 38, lSub, @nMarVar, @nMarAta, @nCustoFinal, @nIpi, @yCodigo ) .AND. CalculaCusto( @nQuant, @nPreco, @nFunrural )
@ 19, nCol Get nQuant		 Pict "99999.99" Valid nQuant != 0
@ 19, 38   Get nPreco		 Pict "99,999,999.99"
@ 20, nCol Get nDesc 		 Pict "99.99"
@ 20, 38   Get nPercFrete	 Pict "99.99"
@ 21, nCol Get nPercImposto Pict "99.99" Valid Calc_Custo( nPreco, @nCustoFinal, nDesc, nPercImposto, nPercFrete )
@ 21, 38   Get nCustoFinal  Pict "99,999,999.99"
@ 22, nCol Get nMarVar		 Pict "999.99"
@ 22, 38   Get nMarAta		 Pict "999.99"
If lIpi
	@ 23, nCol Get nIpi		 Pict "99.99"
	@ 23, 38   Get nIi		 Pict "99.99"
EndIF
Read
IF LastKey() = ESC
	SomaEntrada()
	Return
EndIF
nSoma 				:= nPreco * nQuant
xAlias->Codebar	:= xCodigo
xAlias->Codigo 	:= yCodigo
xAlias->Quant		:= nQuant
xAlias->Desconto	:= nDesc
xAlias->Un			:= Lista->Un
xAlias->Descricao := Lista->Descricao
xAlias->Unitario	:= nPreco
xAlias->Atacado	:= Lista->Atacado
xAlias->Pcusto 	:= Lista->Pcusto
xAlias->Porc		:= Lista->Porc
xAlias->Codi		:= Lista->Codi
xAlias->Total		:= nSoma
xAlias->MarVar 	:= nMarVar
xAlias->MarAta 	:= nMarAta
xAlias->Ipi 		:= nIpi
xAlias->Ii			:= nIi
xAlias->FunRural	:= nFunRural
xAlias->Imposto	:= nPercImposto
xAlias->Frete		:= nPercFrete
Return

Proc PreVenda(cCaixa)
*********************
LOCAL GetList			:= {}
LOCAL Arq_Ant			:= Alias()
LOCAL Ind_Ant			:= IndexOrd()
LOCAL cScreen			:= SaveScreen()
LOCAL nComissaoMedia := 0
LOCAL nTotal			:= 0
LOCAL cNome 			:= Space(40)
LOCAL cCodiVen 		:= Space(04)
LOCAL cCodi 			:= Space(05)
LOCAL cForma			:= Space(02)
LOCAL cEnde 			:= Space(25)
LOCAL cFone 			:= Space(13)
LOCAL cAparelho		:= Space(20)
LOCAL cMarca			:= Space(20)
LOCAL cModelo			:= Space(20)
LOCAL cNrSerie 		:= Space(20)
LOCAL cObs				:= Space(40)
LOCAL cObs1 			:= Space(40)
LOCAL cObs2 			:= Space(40)
LOCAL cRegiao			:= Space(02)
LOCAL cAno				:= Space(04)
LOCAL cCor				:= Space(20)
LOCAL cPlaca			:= Space(08)
LOCAL cEstadoGeral	:= Space(20)
oMenu:Limpa()
WHILE OK
	xAlias->(DbGoTop())
	IF Empty( xAlias->Codigo )
		ErrorBeep()
		Alerta("Erro: Fatura Vazia.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Restela( cScreen )
		Return
	EndIF
	IF !Empty( cFaturaPrevenda )
		cFaturaPrevenda := AllTrim( cFaturaPrevenda )
		cFaturaPrevenda += Space(07 - Len(AllTrim( cFaturaPrevenda)))
	EndIF
	MaBox( 05, 0, 18, MaxCol())
	@ 06, 	  01 Say "Documento n§....:" Get cFaturaPrevenda Pict "@!"    Valid VerNrPrevenda( @cFaturaPrevenda, @cForma, @cCodiVen, @cCodi, @cNome, @cEnde, @cFone, @cAparelho, @cMarca, @cModelo, @cNrSerie, @cObs, @cObs1, @cObs2, @cAno, @cCor, @cPlaca, @cEstadoGeral )
	@ Row()+1, 01 Say "Forma Pgto......:" Get cForma          Pict "@R99"  Valid LastKey() = UP .OR. FormaErrada( @cForma )
	@ Row()+1, 01 Say "Vendedor........:" Get cCodiVen        Pict "####"  Valid Vendedor( @cCodiVen, Row(), Col()+1)
	@ Row()+1, 01 Say "Nome Cliente....:" Get cCodi           Pict "99999" Valid RecErrado( @cCodi, NIL, Row(), Col()+1, @cNome )
	@ Row(),   25								  Get cNome 			 Pict "@K!"
	@ Row()+1, 01 Say "Endereco........:" Get cEnde           Pict "@!"
	@ Row(),   45 Say "Fone........:"     Get cFone           Pict "(999)999-9999"
	@ Row()+1, 01 Say "Aparelho/Veiculo:" Get cAparelho       Pict "@!"
	@ Row(),   45 Say "Marca.......:"     Get cMarca          Pict "@!"
	@ Row()+1, 01 Say "Modelo..........:" Get cModelo         Pict "@!"
	@ Row(),   45 Say "Serie/Chassi:"     Get cNrSerie        Pict "@!"
	@ Row()+1, 01 Say "Ano.............:" Get cAno            Pict "@!"
	@ Row(),   45 Say "Cor.........:"     Get cCor            Pict "@!"
	@ Row()+1, 01 Say "Placa...........:" Get cPlaca          Pict "@!"
	@ Row(),   45 Say "Estado Geral:"     Get cEstadoGeral    Pict "@!"
	@ Row()+1, 01 Say "Observacoes.....:" Get cObs            Pict "@!"
	@ Row()+1, 01 Say "................:" Get cObs1           Pict "@!"
	@ Row()+1, 01 Say "................:" Get cObs2           Pict "@!"
	Read
	IF LastKey() = ESC .OR. xAlias->(Empty( Codigo ))
		AreaAnt( Arq_Ant, Ind_Ant )
		Restela( cScreen )
		Return( FALSO )
	EndIF
	IF !Conf("Fechar Pre-Venda Agora ?")
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
	EndIF
	DeletaPrevenda( cFaturaPrevenda )
	cTela   := Mensagem("Aguarde.", WARNING )
	cRegiao := Receber->Regiao
	Area("Lista")
	Lista->(Order( LISTA_CODIGO ))
	Area("xAlias")
	xAlias->(DbGoTop())
	Imprime_Soma( @nTotal, @nComissaoMedia, OK )
	WHILE xAlias->(!Eof())
		IF Prevenda->(Incluiu())
			IF Lista->(DbSeek( xAlias->Codigo ))
				IF Lista->(TravaReg())
					Lista->Vendida += xAlias->Quant
					Lista->(Libera())
				EndIF
			EndIF
			Prevenda->Codigo		:= xAlias->Codigo
			Prevenda->Quant		:= xAlias->Quant
			Prevenda->Desconto	:= xAlias->Desconto
			Prevenda->DescMax 	:= xAlias->DescMax
			Prevenda->Descricao	:= xAlias->Descricao
			Prevenda->Un			:= xAlias->Un
			Prevenda->Tam			:= xAlias->Tam
			Prevenda->Unitario	:= xAlias->Unitario
			Prevenda->Atacado 	:= xAlias->Atacado
			Prevenda->Varejo		:= xAlias->Varejo
			Prevenda->Pcusto		:= xAlias->Pcusto
			Prevenda->Porc 		:= xAlias->Porc
			Prevenda->Total		:= xAlias->Total
			Prevenda->Serie		:= xAlias->Serie
			Prevenda->Pvendido	:= xAlias->Unitario
			Prevenda->Saida		:= xAlias->Quant
			Prevenda->Sigla		:= xAlias->Sigla
			Prevenda->CodiVen 	:= cCodiVen
			Prevenda->Emis 		:= Date()
			Prevenda->Atualizado := Date()
			Prevenda->VlrFatura	:= nTotal
			Prevenda->Codi 		:= cCodi
			Prevenda->Nome 		:= cNome
			Prevenda->Forma		:= cForma
			Prevenda->Fatura		:= cFaturaPrevenda
			Prevenda->Aparelho	:= cAparelho
			Prevenda->Marca		:= cMarca
			Prevenda->Modelo		:= cModelo
			Prevenda->NrSerie 	:= cNrSerie
			Prevenda->Obs			:= cObs
			Prevenda->Obs1 		:= cObs1
			Prevenda->Obs2 		:= cObs2
			Prevenda->Fone 		:= cFone
			Prevenda->Ende 		:= cEnde
			Prevenda->Regiao		:= cRegiao
			Prevenda->Ano			:= cAno
			Prevenda->Cor			:= cCor
			Prevenda->Placa		:= cPlaca
			Prevenda->Estado		:= cEstadoGeral
		EndIF
		Prevenda->(Libera())
		xAlias->(DbSkip(1))
	EndDo
	WHILE OK
		oMenu:Limpa()
		M_Title("ESCOLHA A OPCAO A IMPRIMIR")
		aOpcao	:= {"Ticket Prevenda", "Espelho Prevenda", "Relacao Separacao Prevenda"}
		nEscolha := FazMenu( 03, 20, aOpcao, Roloc(Cor()))
		IF nEscolha = 0
			Exit
		ElseIF nEscolha = 1
			TicketPv( "PV-" + cFaturaPrevenda, cCaixa, cCodiVen, Date(), cCodi, cNome, nTotal, lPrecoPrevenda, cAparelho, cMarca, cModelo, cNrSerie, cObs, cEnde, cFone, cAno, cCor, cPlaca, cEstadoGeral, cObs1, cObs2 )
		ElseIF nEscolha = 2
			EspelhoTicket( cFaturaPrevenda )
		ElseIF nEscolha = 3
			SeparaPrevenda()
		EndIF
	EndDo
	cFaturaPrevenda := Space(07)
	Area("xAlias")
	__DbZap()
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Imprime_Soma( nTotal )
	Return( OK )
EndDo

Proc TicketPv( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, lPrevenda, cAparelho, cMarca, cModelo, cNrSerie, cObs, cEnde, cFone, cAno, cCor, cPlaca, cEstadoGeral, cObs1, cObs2 )
************************************************************************************************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL xNtx1 	 := FTempName("T*.TMP")
LOCAL cCgc		 := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
LOCAL cRg		 := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Rg,  Receber->Insc )
LOCAL cFanta	 := Receber->Fanta
LOCAL cBair 	 := Receber->Bair
LOCAL cNome 	 := Receber->Nome
LOCAL cMecanico := Space(40)
LOCAL nTotal	 := 0
LOCAL nParcial  := 0
LOCAL nCusto	 := 0
LOCAL nRodape	 := 6
LOCAL nCol		 := 33
LOCAL nLinhas	 := 33
LOCAL nDif		 := 0
LOCAL Tam		 := 40
LOCAL nAtiva	 := oIni:ReadInteger('ecf', 'Ativa', 2 )
LOCAL lAparelhoMarca := oIni:ReadBool('prevenda', 'aparelhomarca', FALSO )
LOCAL lModeloSerie	:= oIni:ReadBool('prevenda', 'modeloserie', FALSO )
LOCAL lAnoCor			:= oIni:ReadBool('prevenda', 'anocor', FALSO )
LOCAL lPlacaEstado	:= oIni:ReadBool('prevenda', 'placaestado', FALSO )
LOCAL lObs2 			:= oIni:ReadBool('prevenda', 'obs2', FALSO )
LOCAL lObs3 			:= oIni:ReadBool('prevenda', 'obs3', FALSO )
LOCAL lMarcaNoTicket := oIni:ReadBool('sistema',  'pvmarcaticket', FALSO)
STATI nTamForm 		:= 33
STATI xTam				:= 40

cVend += Space(36)
oMenu:Limpa()
MaBox( 10, 05, 17, 70 )
@ 11, 06 Say "Cliente............." Get cNomeCliente Pict "@!"
@ 12, 06 Say "Endereco............" Get cEnde        Pict "@!"
@ 13, 06 Say "Bairro.............." Get cBair        Pict "@!"
@ 14, 06 Say "Vendedor............" Get cVend        Pict "@!"
@ 15, 06 Say "Tecnico............." Get cMecanico    Pict "@!"
@ 16, 06 Say "Comp do Formulario.." Get nTamForm     Pict "99" Valid PickTam({"33 Linhas ", "66 Linhas "}, {33,66}, @nTamForm )
@ 16, 40 Say "Largura Formulario.." Get xTam         Pict "99" Valid PickTam({"40 Colunas", "80 Colunas"}, {40,80}, @xTam )
Read
IF LastKey() = ESC .OR. !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
IF xTam = 40
	Tam = 66
Else
	Tam = 93
EndIF
nLinhas	:= nTamForm
nCol		:= nTamForm
nDif		:= Tam-66
IF cNome <> cNomeCliente
	cFanta := cNomeCliente
EndIF
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr( nTamForm ))
IF Tam = 66
	Fprint( PQ )
Else
	Fprint( _CPI12 )
EndIF
SetPrc(0,0)
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
Qout( GD + Padc( AllTrim( cPriLinPv ), Tam/2 ) + CA )
Qout( GD + Padc( AllTrim( cSegLinPv ), Tam/2 ) + CA )
Qout( Padc( XENDEFIR + " - " + XCCIDA + " - " + XFONE, Tam ))
Qout( Repl("-", Tam))
Qout( GD + Padc( "ORCAMENTO N§ " + cFatu, Tam/2 ) + CA )
IF xTam = 40
	Qout( "Cliente..:", cCodi, cNomeCliente )
	Qout( "Fantasia.:", Left( cFanta, 26), "Bairro.: " + Left( cBair, 14))
Else
	Qout( "Cliente..:", cCodi, cNomeCliente, Space(07), 'CGC/CPF.:' + cCgc )
	Qout( "Fantasia.:", cFanta, Space(12), "Bairro.: " + Left( cBair, 14))
EndIF
Qout( "Endereco.:", cEnde, Space(nDif), "Fone..:", cFone )
Qout( "Data.....:", Dtoc( dEmis ),'as ' + Time(), 'HR', Space(nDif+2), "Caixa :", cCaixa )
IF lAparelhoMarca
	Qout( "Aparelho.:", cAparelho, Space(nDif+5), "Marca :", AllTrim(cMarca))
EndIF
IF lModeloSerie
	Qout( "Modelo...:", cModelo, Space(nDif+05), "Serie :", AllTrim( cNrSerie ))
EndIF
IF lAnoCor
	Qout( "Ano......:", cAno,    Space(nDif+21), "Cor   :", AllTrim( cNrSerie ))
EndIF
IF lPlacaEstado
	Qout( "Placa....:", cPlaca,  Space(nDif+17), "Estado:", AllTrim( cEstadoGeral ))
EndIF
Qout( "Obs......:", AllTrim( cObs ))
IF lObs2
	Qout( ".........:", AllTrim( cObs1 ))
EndIF
IF lObs3
	Qout( ".........:", AllTrim( cObs2 ))
EndIF
Qout( Repl("-", Tam))
IF Tam = 66
	Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                         TOTAL")
Else
	IF lMarcaNoTicket = OK
		Qout( "CODIGO MARCA         QUANT DESCRICAO DO PRODUTO                           UNITARIO      TOTAL")
	Else
		Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                                      UNITARIO      TOTAL")
	EndIF
EndIF
Qout( Repl("-", Tam))
nCol	:= 16
While xAlias->(!Eof())
	nCusto	 += ( xAlias->Pcusto * xAlias->Quant )
	nPreco	 := ( xAlias->Unitario * xAlias->Quant )
	cPreco	 := Tran( nPreco, "@E 999,999.99")
	cUnitario := Tran( xAlias->Unitario, "@E 999,999.99")
	nTotal	 += nPreco
	nParcial  += nPreco
	IF lPrevenda != NIL
		If !lPrecoPrevenda // Nao Imprimir preco no ticket Prevenda?
			nPreco	 := 0
			nParcial  := 0
			nTotal	 := 0
			nLiquido  := 0
			nDesconto := 0
			cPreco	 := Tran( 0, "@E 999,999.99")
			cUnitario := Tran( 0, "@E 999,999.99")
		EndIF
	Else
		If !lPrecoTicket // Nao Imprimir preco no ticket Normal?
			nPreco	 := 0
			nParcial  := 0
			nTotal	 := 0
			nLiquido  := 0
			nDesconto := 0
			cPreco	 := Tran( 0, "@E 999,999.99")
			cUnitario := Tran( 0, "@E 999,999.99")
		EndIF
	EndIF
	IF Tam = 66
		Qout( xAlias->Codigo, xAlias->Quant, Left( xAlias->Descricao,39), cPreco )
	Else
		IF lMarcaNoTicket = OK
			Qout( xAlias->Codigo, xAlias->Sigla, xAlias->Quant, xAlias->Descricao, Space(03), cUnitario, cPreco )
		Else
			Qout( xAlias->Codigo, xAlias->Quant, xAlias->Descricao, Space(14), cUnitario, cPreco )
		EndIF
	EndIF
	xAlias->(DbSkip(1))
	IF nCol + nRodape >= nTamForm
		IF xAlias->(!Eof())
			IF nCol >= ( nTamForm - 3 )
				__Eject()
				SetPrc( 0, 0 )
				Qout( Repl("-", Tam))
				Qout( GD + Padc( "ORCAMENTO N§ " + cFatu, Tam/2 ) + CA)
				Qout( "N§ Docto.: " + cFatu, Space(nDif+28), "Data : " + Dtoc( dEmis ))
				Qout( Repl("-", Tam))
				IF Tam = 66
					Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                         TOTAL")
				Else
					Qout( "CODIGO    QUANT DESCRICAO DO PRODUTO                                      UNITARIO      TOTAL")
				EndIF
				Qout( Repl("-", Tam))
				nCol := 6
				Loop
			EndIF
		EndIF
	EndIF
	nCol++
Enddo
Qout( Repl("-", Tam))
nDesconto := ( nLiquido - nTotal )
Qout( "Total do Ticket....: " + Space(nDif+32 ) + Tran( nParcial,  "@E 99,999,999.99"))
Qout( "Desconto/Acrescimo.: " + Space(nDif+32 ) + Tran( nDesconto, "@E 99,999,999.99"))
Qout( "Valor Liquido......: " + Space(nDif+32 ) + Tran( nLiquido,  "@E 99,999,999.99"))
Qout( Repl("-", Tam))
Qout( "Vendedor...........: " + cVend )
Qout( "Tecnico............: " + cMecanico )
IF nAtiva = 1
	Qout( GD + Padc( "EXIJA O CUPOM FISCAL", Tam/2 ) + CA)
EndIF
TickVcto( cFatu )
__Eject()
PrintOff()
Return

Function VerNrPrevenda( cFaturaPrevenda, cForma, cCodiVen, cCodi, cNome, cEnde, cFone, cAparelho, cMarca, cModelo, cNrSerie, cObs, cObs1, cObs2, cAno, cCor, cPlaca, cEstadoGeral )
***********************************************************************************************************************************************************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := cFaturaPrevenda

IF Empty( cFaturaPrevenda )
	ErrorBeep()
	IF Conf("Pergunta: Numerar Prevenda Automaticamente ?")
		cFaturaPrevenda := ProxPre()
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	EndIF
EndIF
Prevenda->(Order( PREVENDA_FATURA ))
IF Prevenda->(DbSeek( cFaturaPrevenda ))
	ErrorBeep()
	IF !Conf("Pergunta: Prevenda existente regrava-la ?")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	cForma	 := Prevenda->Forma
	cCodiVen  := Prevenda->Codiven
	cCodi 	 := Prevenda->Codi
	cNome 	 := Prevenda->Nome
	cAparelho := Prevenda->Aparelho
	cMarca	 := Prevenda->Marca
	cModelo	 := Prevenda->Modelo
	cNrSerie  := Prevenda->NrSerie
	cObs		 := Prevenda->Obs
	cObs1 	 := Prevenda->Obs1
	cObs2 	 := Prevenda->Obs2
	cEnde 	 := Prevenda->Ende
	cFone 	 := Prevenda->Fone
	cAno		 := Prevenda->Ano
	cCor		 := Prevenda->Cor
	cPlaca	 := Prevenda->Placa
	cEstadoGeral := Prevenda->Estado
	//DeletaPrevenda( cFaturaPrevenda )
	cFaturaPrevenda := xTemp
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function ProxPre()
******************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cFatura
LOCAL nTemp

Area("PreVenda")
Prevenda->(Order( PREVENDA_FATURA ))
Prevenda->(DbGoBottom())
nTemp := Val( Prevenda->Fatura ) + 1
cFatura := StrZero( nTemp, 7 )
AreaAnt( Arq_Ant, Ind_Ant )
Return( cFatura )

Proc DeletaPreVenda( cFaturaPrevenda )
**************************************
LOCAL GetList := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cTela

Prevenda->(Order( PREVENDA_FATURA ))
IF Prevenda->(DbSeek( cFaturaPrevenda ))
	cTela := Mensagem("Aguarde.", WARNING )
	While Prevenda->Fatura = cFaturaPrevenda
		IF Prevenda->(TravaReg())
			Prevenda->(DbDelete())
			Prevenda->(Libera())
			Prevenda->(DbSkip(1))
		EndIF
	EndDo
	Restela( cTela )
EndIF
cFaturaPrevenda := Space(07)
AreaAnt( Arq_Ant, Ind_Ant )
Return

Proc ZerarPreVenda()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL nNivel  := SCI_DEVOLUCAO_FATURA

IF !aPermissao[ nNivel ]
	IF !PedePermissao( nNivel )
		Restela( cScreen )
		Return
	EndIF
EndIF
WHILE OK
	oMenu:Limpa()
	cFaturaPrevenda := Space(07)
	MaBox( 18, 10, 20, 44 )
	@ 19, 11 Say "N§ Pre-Venda a Excluir.:" Get cFaturaPrevenda Pict "@!" Valid AchaPreVenda( @cFaturaPrevenda )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	DeletaPrevenda( cFaturaPrevenda )
EndDo

Proc DevPreVenda()
******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL oBloco

WHILE OK
	oMenu:Limpa()
	cFaturaPrevenda := Space(07)
	MaBox( 18, 10, 20, 34 )
	@ 19, 11 Say "Pre-Venda n§.:" Get cFaturaPrevenda Pict "@!" Valid AchaPreVenda( @cFaturaPrevenda )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde...", Cor())
	oBloco := {|| Prevenda->Fatura = cFaturaPrevenda }
	Lista->(Order( LISTA_CODIGO ))
	Area("Prevenda")
	Prevenda->(Order( PREVENDA_FATURA ))
	IF Prevenda->(DbSeek( cFaturaPrevenda ))
		WHILE Eval( oBloco )
			Lista->(DbSeek( Prevenda->Codigo ))
			xAlias->(DbAppend())
			xAlias->Codigo 	:= PreVenda->Codigo
			xAlias->Quant		:= PreVenda->Quant
			xAlias->Desconto	:= PreVenda->Desconto
			xAlias->DescMax	:= PreVenda->DescMax
			xAlias->Un			:= Lista->Un
			xAlias->Descricao := Lista->Descricao
			xAlias->Sigla		:= Lista->Sigla
			xAlias->Unitario	:= PreVenda->Unitario
			xAlias->Atacado	:= PreVenda->Atacado
			xAlias->Varejo 	:= PreVenda->Varejo
			xAlias->Pcusto 	:= Lista->Pcusto
			xAlias->Porc		:= PreVenda->Porc
			xAlias->Total		:= PreVenda->Total
			xAlias->Serie		:= PreVenda->Serie
			Prevenda->(DbSkip(1))
		EndDo
	EndiF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela(cScreen )
	Return
EndDo

Function AchaPreVenda( cFatura )
********************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL aFatura := {}
LOCAL aTodos  := {}
LOCAL xFatura

oMenu:Limpa()
Area("PreVenda")
PreVenda->(Order( PREVENDA_FATURA ))
IF Prevenda->(!DbSeek( cFatura ))
	Mensagem("Aguarde...", Cor())
	Prevenda->(DbGoTop())
	IF Prevenda->(Eof())
		AreaAnt( Arq_Ant, Ind_Ant )
		Nada()
		ResTela( cScreen )
		Return( FALSO )
	EndIF
	WHILE Prevenda->(!Eof())
		xFatura := Prevenda->Fatura
		IF Ascan( aFatura, xFatura ) = 0
			Aadd( aFatura, xFatura )
			Aadd( aTodos, xFatura + '³' + Prevenda->CodiVen + '³' + PreVenda->Nome )
		EndIF
		Prevenda->(DbSkip(1))
	EndDo
	MaBox( 00, 10, 23, 71,"PREVEND VEND NOME" + Space(44))
	nChoice := aChoice( 01, 11, 22, 70, aTodos )
	ResTela( cScreen )
	IF nChoice = 0
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
	EndIF
	cFatura := aFatura[nChoice]
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( OK )
EndIF
cFatura := Prevenda->Fatura
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Proc ReCupom( cCaixa )
**********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cVend
LOCAL dEmis
LOCAL cFatu
LOCAL oBloco
LOCAL cCodi
LOCAL cNome

WHILE OK
	oMenu:Limpa()
	cFatu 	  := Space(07)
	MaBox( 18, 10, 20, 34 )
	@ 19, 11 Say "Fatura n§....:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	Mensagem("Aguarde...", Cor())
	oBloco := {|| Saidas->Fatura = cFatu }
	Receber->(Order( RECEBER_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_FATURA ))
	IF Saidas->(DbSeek( cFatu ))
		cVend 	:= Saidas->CodiVen
		dEmis 	:= Saidas->Emis
		cCodi 	:= Saidas->Codi
		cForma	:= Saidas->Forma
		nLiquido := Saidas->VlrFatura
		cNome 	:= ""
		IF Receber->(DbSeek( cCodi ))
			cNome := Receber->Nome
		EndIF
		WHILE Eval( oBloco )
			Lista->(DbSeek( Saidas->Codigo ))
			xAlias->(DbAppend())
			xAlias->Codigo 	:= Saidas->Codigo
			xAlias->Quant		:= Saidas->Saida
			xAlias->Desconto	:= Saidas->Desconto
			xAlias->Unitario	:= Saidas->Pvendido
			xAlias->Atacado	:= Saidas->Atacado
			xAlias->Varejo 	:= Saidas->Varejo
			xAlias->Pcusto 	:= Saidas->Pcusto
			xAlias->Total		:= Saidas->VlrFatura
			xAlias->Un			:= Lista->Un
			xAlias->Descricao := Lista->Descricao
			xAlias->Serie		:= Saidas->Serie
			Saidas->(DbSkip(1))
		EndDo
		oMenu:Limpa()
		ErrorBeep()
		IF Conf("Pergunta: Ecf Pronta ?")
			CupomFiscal( cCodi, cFatu, nLiquido, cForma )
		EndIF
		Area("xAlias")
		__DbZap()
	EndiF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela(cScreen )
	Return
EndDo

Proc ReTicket( cCaixa )
***********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cVend
LOCAL dEmis
LOCAL cFatu
LOCAL oBloco
LOCAL cCodi
LOCAL cNome
LOCAL cTecnico

WHILE OK
	oMenu:Limpa()
	cFatu 	  := Space(07)
	MaBox( 18, 10, 20, 34 )
	@ 19, 11 Say "Ticket n§....:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	Mensagem("Aguarde...", Cor())
	oBloco := {|| Saidas->Fatura = cFatu }
	Receber->(Order( RECEBER_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Area("Saidas")
	Saidas->(Order( SAIDAS_FATURA ))
	IF Saidas->(DbSeek( cFatu ))
		cVend 	:= Saidas->CodiVen
		dEmis 	:= Saidas->Emis
		cCodi 	:= Saidas->Codi
		nLiquido := Saidas->VlrFatura
		cTecnico := Saidas->Tecnico
		cNome 	:= ""
		IF Receber->(DbSeek( cCodi ))
			cNome := Receber->Nome
		EndIF
		WHILE Eval( oBloco )
			Lista->(DbSeek( Saidas->Codigo ))
			xAlias->(DbAppend())
			xAlias->Codigo 	 := Saidas->Codigo
			xAlias->Quant		 := Saidas->Saida
			xAlias->Desconto	 := Saidas->Desconto
			xAlias->Unitario	 := Saidas->Pvendido
			xAlias->Atacado	 := Saidas->Atacado
			xAlias->Varejo 	 := Saidas->Varejo
			xAlias->Pcusto 	 := Saidas->Pcusto
			xAlias->Total		 := Saidas->VlrFatura
			xAlias->N_Original := Lista->N_Original
			xAlias->Sigla		 := Lista->Sigla
			xAlias->Un			 := Lista->Un
			xAlias->Descricao  := Lista->Descricao
			Saidas->(DbSkip(1))
		EndDo
		Ticket( cFatu, cCaixa, cVend, dEmis, cCodi, cNome, nLiquido, NIL, cTecnico )
		Area("xAlias")
		__DbZap()
	EndiF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela(cScreen )
	Return
EndDo

Function PickTam( cList, aList, nTam )
**************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nLen		 := Len( aList )
LOCAL nChoice

IF Ascan( aList, nTam ) != 0
	Return( OK )
EndIF

MaBox( 11, 01, 12+nLen, 44, NIL, NIL, Roloc( Cor()) )
IF (nChoice := AChoice( 12, 02, 11+nLen, 43, cList )) != 0
	nTam := aList[ nChoice ]
EndIf
ResTela( cScreen )
Return( OK )

Function nConta_Quant( nQtdProdu )
**********************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL ok
LOCAL Retorno
LOCAL nQuant
LOCAL cQuant

IF ( nQtdProdu = 0 )
	Return(FALSO)
EndIF
nQuant  := Lista->Quant
Retorno := IF( nQuant < nQtdProdu, FALSO, OK )
IF Retorno = FALSO
	cQuant := AllTrim( Str( nQuant, 6 ) )
	ErrorBeep()
	IF PodeFaturarComEstoqueNegativo()
		IF Conf("Quantidade Indisponivel. Continua ? ")
			Return(OK)
		EndIF
	Else
		IF Conf("Qtde Indisponivel. O produto esta correto?")
			IF PedePermissao( SCI_FATURAR_COM_ESTOQUE_NEGATIVO )
				AreaAnt( Arq_Ant, Ind_Ant )
				Return(OK)
			EndIF
		EndIF
		AreaAnt( Arq_Ant, Ind_Ant )
		Alerta("Quantidade Indisponivel.")
	EndIF
EndIF
#IFDEF CENTRALCALCADOS
	IF nQtdProdu != Int( nQtdProdu )
		ErrorBeep()
		Alerta("Erro: Quantidade Invalida.")
		Return( FALSO )
	EndIF
#ENDIF
IF ( nQuant - nQtdProdu ) <= Lista->Qmin
	IF lMinimoMens
		Alerta("Informa: Produto no estoque minimo.")
	EndIF
EndIF
Return( Retorno )

Function Comunica_Com_Impressora( nPorta, Buffer, Retorno )
***********************************************************
LOCAL lEcfRede := oIni:ReadBool('ecf','ecfrede', FALSO )
LOCAL cDrive
LOCAL cTemp
LOCAL cReal
LOCAL cPathRede
LOCAL cFileTemp
LOCAL cFileReal

IF lEcfRede
	cDrive	 := oAmbiente:xBase
	cTemp 	 := FTempName('BEMA????.$$$')
	cReal 	 := FTempName('BEMAFI32.CMD')
	cPathRede := oIni:ReadString('ecf','pathrede', cDrive + '\CMD' )
	cFileTemp := cPathRede + '\' + cTemp
	cFileReal := cPathRede + '\' + cReal
	nPorta	 := Fcreate( cFileTemp, FC_NORMAL )
	FWrite( nPorta, @Buffer, Len( Buffer ))
	FClose( nPorta )
	__CopyFile( cFileTemp, cFileReal )
	Ferase( cFileTemp )
	Retorno_Bema()
	Return(NIL)
Else
	FWrite( nPorta, @Buffer, Len( Buffer ))
EndIF
Return(NIL)

Proc Retorno_Bema()
*******************
LOCAL cScreen := SaveScreen()
LOCAL cPathRede
LOCAL cFile
LOCAL cTemp
LOCAL cDrive
LOCAL cArquivo
LOCAL cTamanho
LOCAL cRetorno
LOCAL cAck
LOCAL cProcura
LOCAL cSt1

cDrive	 := oAmbiente:xBase
cPathRede := oIni:ReadString('ecf','pathrede', cDrive + '\CMD' )
cTemp 	 := 'STATUS.TXT'
cFile 	 := cPathRede + '\' + cTemp

oMenu:Limpa()
WHILE OK
	Mensagem('Mensagem: Aguardando pelo status da impressora')
	IF File( cFile ) //.AND. FReadStr( File( cFile ) ) <> "0"
		cArquivo := Fopen( cFile )
		cTamanho := FSeek( cArquivo, 0, 2 )
		FClose( cArquivo )
		IF cTamanho <> 0
			cArquivo := FOpen( cFile )
			cRetorno := " "
			cAck		:= ""
			WHILE OK
				For cProcura := 1 to 3
					FRead( cArquivo, @cRetorno, 1 )
					IF cRetorno = ","
						cProcura := 4
					Else
						cAck += cRetorno
					EndIF
				Next
				IF cAck = "0"
					ErrorBeep()
					IF Conf("Erro de comunicacao com a impressora fiscal. Abortar?")
						ResTela( cScreen )
						Return
					EndIF
				Else
					Exit
				EndIF
			EndDO
			cSt1 := ""
			For cProcura := 1 to 3
				FRead( cArquivo, @cRetorno, 1 )
				IF cRetorno = ","
					cProcura := 4
				Else
					cSt1 += cRetorno
				EndIF
			Next
			cSt2 := ""
			For cProcura := 1 to 3
				FRead( cArquivo, @cRetorno, 1 )
				IF cRetorno = "," .OR. Asc( cRetorno ) = 13
					cProcura := 4
				Else
					cSt2 += cRetorno
				endIF
			Next
			FClose( cArquivo )
			Ferase( cFile )
			cSt1 := Val( cSt1 )
			cSt2 := val( cSt2 )
			IF cSt1 <> 0 .OR. cSt2 <> 0
				oMenu:Limpa()
				MaBox( 05, 03, 18, 77)
				@ 05, 03 to 18,77
				@ 06, 24 say " -> Retorno da Impressora <- "
				@ 07, 03 say "Ã"
				@ 07, 04 to 07,76
				@ 07, 77 say "´"
				@ 07, 38 say "Â"
				@ 08, 15 say "-> ST1 <-"
				@ 08, 38 say "³"
				@ 08, 53 say "-> ST2 <-"
				@ 09, 03 say "Ã"
				@ 09, 04 to 09,76
				@ 09, 38 say "Å"
				@ 09, 77 say "´"
				@ 10, 38 say "³"
				@ 11, 38 say "³"
				@ 12, 38 say "³"
				@ 13, 38 say "³"
				@ 14, 38 say "³"
				@ 15, 38 say "³"
				@ 16, 38 say "³"
				@ 17, 38 say "³"
				@ 18, 38 say "Á"

				setcolor( "N+/G+" )
				@ 10, 04 say ST1_BIT_7
				@ 11, 04 say ST1_BIT_6
				@ 12, 04 say ST1_BIT_5
				@ 13, 04 say ST1_BIT_4
				@ 14, 04 say ST1_BIT_3
				@ 15, 04 say ST1_BIT_2
				@ 16, 04 say ST1_BIT_1
				@ 17, 04 say ST1_BIT_0

				@ 10, 39 say ST2_BIT_7
				@ 11, 39 say ST2_BIT_6
				@ 12, 39 say ST2_BIT_5
				@ 13, 39 say ST2_BIT_4
				@ 14, 39 say ST2_BIT_3
				@ 15, 39 say ST2_BIT_2
				@ 16, 39 say ST2_BIT_1
				@ 17, 39 say ST2_BIT_0

				// Verificando o ST1
				if cSt1 >= 128; setcolor( "W+/G+" ); @ 10, 04 say ST1_BIT_7; cSt1 = cSt1 - 128; endif
				if cSt1 >= 64;  setcolor( "W+/G+" ); @ 11, 04 say ST1_BIT_6; cSt1 = cSt1 - 64;  endif
				if cSt1 >= 32;  setcolor( "W+/G+" ); @ 12, 04 say ST1_BIT_5; cSt1 = cSt1 - 32;  endif
				if cSt1 >= 16;  setcolor( "W+/G+" ); @ 13, 04 say ST1_BIT_4; cSt1 = cSt1 - 16;  endif
				if cSt1 >= 8;	 setcolor( "W+/G+" ); @ 14, 04 say ST1_BIT_3; cSt1 = cSt1 - 8;   endif
				if cSt1 >= 4;	 setcolor( "W+/G+" ); @ 15, 04 say ST1_BIT_2; cSt1 = cSt1 - 4;   endif
				if cSt1 >= 2;	 setcolor( "W+/G+" ); @ 16, 04 say ST1_BIT_1; cSt1 = cSt1 - 2;   endif
				if cSt1 >= 1;	 setcolor( "W+/G+" ); @ 17, 04 say ST1_BIT_0; cSt1 = cSt1 - 1;   endif

				// Verificando o ST2
				if cSt2 >= 128; setcolor( "W+/G+" ); @ 10, 39 say ST2_BIT_7; cSt2 = cSt2 - 128; endif
				if cSt2 >= 64;  setcolor( "W+/G+" ); @ 11, 39 say ST2_BIT_6; cSt2 = cSt2 - 64;  endif
				if cSt2 >= 32;  setcolor( "W+/G+" ); @ 12, 39 say ST2_BIT_5; cSt2 = cSt2 - 32;  endif
				if cSt2 >= 16;  setcolor( "W+/G+" ); @ 13, 39 say ST2_BIT_4; cSt2 = cSt2 - 16;  endif
				if cSt2 >= 8;	 setcolor( "W+/G+" ); @ 14, 39 say ST2_BIT_3; cSt2 = cSt2 - 8;   endif
				if cSt2 >= 4;	 setcolor( "W+/G+" ); @ 15, 39 say ST2_BIT_2; cSt2 = cSt2 - 4;   endif
				if cSt2 >= 2;	 setcolor( "W+/G+" ); @ 16, 39 say ST2_BIT_1; cSt2 = cSt2 - 2;   endif
				if cSt2 >= 1;	 setcolor( "W+/G+" ); @ 17, 39 say ST2_BIT_0; cSt2 = cSt2 - 1;   endif
				inkey( 3 )
				Exit
			Else
				Exit
			EndIF
		Else
			Loop
		EndIF
	EndIF
EndDo
Restela( cScreen )
Return

Function StrSemComma( nValor, nInteiro, nDec, nLen )
****************************************************
LOCAL cValor :=  Str( nValor, nInteiro, nDec )
LOCAL xValor :=  StrTran( Strtran( cValor, '.'), ',')
LOCAL xVal	 := 0

IF nLen <> NIL
	IF Len( xValor ) = nLen
		xVal := Val( xValor )
		Return( StrZero( xVal, nLen ))
	ElseIF Len( xValor ) > nLen
		xValor := Right( xValor, nLen )
		xVal	 := Val( xValor )
		Return( StrZero( xVal, nLen ))
	ElseIF Len( xValor ) < nLen
		xVal	 := Val( xValor )
		Return( StrZero( xVal, nLen ))
	EndIF
EndIF
Return( xValor )

Function IntToStrSemPonto( nQuant, nTam, nDec )
*****************************************
LOCAL xVal := Str( nQuant, nTam, nDec )
Return( StrTran( xVal, "." ))

Proc CupomFiscal( cCodi, cFatura, nLiquido, cForma )
****************************************************
IF nIniEcf = 1
	Cf_ZantIz11( cCodi, cFatura, nLiquido, cForma )
ElseIF nIniEcf = 2
	Cf_Bema( cCodi, cFatura, nLiquido, cForma )
ElseIF nIniEcf = 3
	Cf_ZantIz20( cCodi, cFatura, nLiquido, cForma )
ElseIF nIniEcf = 4
	Cf_Sigtron( cCodi, cFatura, nLiquido, cForma )
ElseIF nIniEcf = 5
	Cf_Sweda( cCodi, cFatura, nLiquido, cForma )
ElseIF nIniEcf = 6
	Cf_Daruma( cCodi, cFatura, nLiquido, cForma )
EndIF
Return

Proc Cancel_Cupom()
*******************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {'Cancelar Cupom', 'Fechar Cupom'}

oMenu:Limpa()
M_Title( "ESCOLHA UMA OP€AO" )
nChoice := FazMenu( 10, 10, aMenu )
ErrorBeep()
IF nChoice = 0 .OR. !Conf("Pergunta: Ecf Pronta ?")
	ResTela( cScreen )
	Return
EndIF
IF nIniEcf = 1
	IF nChoice = 1
		Cancel_Zanthus()
	Else
	EndIf
ElseIF nIniEcf = 2
	IF nChoice = 1
		Cancel_Bema()
	Else
		Fechar_Bema()
	EndIf
ElseIF nIniEcf = 3
	IF nChoice = 1
		Cancel_Zanthus()
	Else
	EndIf
ElseIF nIniEcf = 4
	IF nChoice = 1
		Cancel_Sigtron()
	Else
		Fechar_Sigtron()
	EndIf
ElseIF nIniEcf = 5
	IF nChoice = 1
		Cancel_Sweda()
	Else
		Fechar_Sweda()
	EndIf
ElseIF nIniEcf = 6
	Cancel_Daruma()
EndIF
ResTela( cScreen )
Return

Proc Fechar_Sweda()
*******************
SwedaOn()
Write( Prow(), Pcol(), Chr(27) + ".12NN}" )
SwedaOff()
Return

Proc Cancel_Sweda()
*******************
SwedaOn()
Write( Prow(), Pcol(), Chr(27) + ".05}" )
SwedaOff()
Return

Proc Cancel_Bema()
******************
LOCAL Retorno := 0
LOCAL cIni	  := chr(27) + chr(251)
LOCAL cFim	  := '|' + Chr(27)
LOCAL cBuffer := cIni + "14" + cFim
LOCAL cTela
LOCAL nPorta

IF lEcfRede
	cBuffer := '009|'
EndIF
oMenu:Limpa()
nPorta := BemaIniciaDriver()
cTela  := Mensagem("Aguarde, Cancelando Ultimo Cupom Fiscal.")
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
FClose( nPorta )
ResTela( cTela )
Return

Proc Fechar_Bema()
******************
LOCAL cBuffer := '029|'
LOCAL cTela
LOCAL nPorta
LOCAL Retorno

cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
cBuffer += '*** FECHAMENTO FORCADO ***' + Chr(13) + Chr(10)
cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
cBuffer += '|'

IF lEcfRede
	oMenu:Limpa()
	nPorta := BemaIniciaDriver()
	cTela  := Mensagem("Aguarde, Fechando Ultimo Cupom Fiscal.")
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	FClose( nPorta )
	ResTela( cTela )
EndIF
Return

Proc Cancel_Zanthus()
*********************
LOCAL cBuffer := Space(134)
LOCAL nPorta  := ZaIniciaDrive(cBuffer)
LOCAL cTela

oMenu:Limpa()
cTela := Mensagem("Aguarde, Cancelando Ultimo Cupom Fiscal.")
cBuffer := "~1/@/" // Cancelamento do Ultimo Cupom Fiscal
FWrite( nPorta, @cBuffer, Len( cBuffer ))
cBuffer := "~2/U/$08$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cTela )
Return

Proc Cancel_Daruma()
********************
LOCAL cBuffer := Space(134)
LOCAL nPorta  := DarumaIniciaDrive(cBuffer)
LOCAL cTela

oMenu:Limpa()
cTela   := Mensagem("Aguarde, Cancelando Ultimo Cupom Fiscal.")
cBuffer := '1014;'
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cTela )
Return

Proc Cancel_Sigtron()
*********************
LOCAL cBuffer := Space(134)
LOCAL nPorta  := SigTronIniciaDrive(cBuffer)
LOCAL cTela

oMenu:Limpa()
cTela := Mensagem("Aguarde, Cancelando Ultimo Cupom Fiscal.")
cBuffer := Chr(27) + Chr(206)
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cTela )
Return

Function DarumaIniciaDriver( cBuffer )
**************************************
LOCAL cScreen := SaveScreen()
LOCAL cFile   := FTempname('DARUMA.CMD')
LOCAL cDrive  := oAmbiente:xBase
LOCAL cPorta
LOCAL nHandle

cPathRede := oIni:ReadString('ecf','pathrede', cDrive + '\CMD' )
cPorta	 := cPathRede + '\' + cFile
nHandle	 := Fcreate( cPorta, FC_NORMAL )
IF Ferror () != 0
	FClose( nHandle )
	Alerta("Daruma: Erro de Abertura de Arquivo - DOS error : ", FERROR())
	ResTela( cScreen )
	Break
EndIF
Return( nHandle )

Function SigtronIniciaDriver( cBuffer )
***************************************
LOCAL nHandle
LOCAL Qtde

nHandle := Fopen("SIGFIS", FO_READWRITE)
IF Ferror() != 0
	 Alerta("Sigtron: Erro de Abertura de Arquivo - DOS error : ", FERROR())
	 Break
EndIF
Return( nHandle )

Function ZaIniciaDriver( cBuffer )
**********************************
LOCAL nHandle
LOCAL Qtde

nHandle := Fopen("ECF$ZANT", FO_READWRITE)
IF Ferror() != 0
	 Alerta("Zanthus: Erro de Abertura de Arquivo - DOS error : ", FERROR())
	 Break
EndIF
FWrite(nHandle, "~1/0/", 5)     // Pedido de Versao da ECF Zanthus
FRead(nHandle, @cBuffer, 134)
FWrite(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
Qtde := FRead(nHandle, @cBuffer, 134)
IF !Response_Zanthus( nHandle, cBuffer )
	 Break
EndIF
Return( nHandle )

Function ValueToStr( Value )
****************************
LOCAL str

Str := Str( Value, 14, 2)
Str := Left( Str, 11 ) + "," + Right( Str, 2)
IF ( SubStr( Str, 8, 1 ) != " ")
	Str := Left( Str, 8 ) +"." + Right( Str, 6)
	Str := Right( Str, 14 )
EndIF
IF ( SubStr( Str, 4, 1 ) != " " )
	Str := Left( Str, 4 ) + "." + Right( Str, 10)
	Str := Right( Str, 14)
EndIF
Return( Str )

Proc OrdemServico()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL oOs	  := TIniNew( oAmbiente:xBaseDados + "\OS.INI")
LOCAL dEmis
LOCAL cNome
LOCAL cAparelho
LOCAL cMarca
LOCAL cModelo
LOCAL cSerie
LOCAL cCor
LOCAL cAno
LOCAL cGarantia
LOCAL cDefRec1
LOCAL cDefRec2
LOCAL cDefRec3
LOCAL cDefRec4
LOCAL cDefDet1
LOCAL cDefDet2
LOCAL cDefDet3
LOCAL cDefDet4
LOCAL cCodiVen
LOCAL nRow
LOCAL nCol
LOCAL lAlterar := FALSO

WHILE OK
	cOs  := Space(07)
	MaBox( 00, 00, 15, 78, "ABERTURA DE ORDEM DE SERVICO" )
	@ 01, 01 Say "Numero....:" Get cOS Pict "@!" Valid AchaOs( cOs, oOS, @lAlterar )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	dEmis 	 := IF( lAlterar, oOS:ReadDate( cOs, 'Data'), Date())
	cNome 	 := IF( lAlterar, oOS:ReadString( cOs, 'Nome'), Space(40))
	cAparelho := IF( lAlterar, oOS:ReadString( cOs, 'Aparelho'), Space(60))
	cModelo	 := IF( lAlterar, oOS:ReadString( cOs, 'Modelo'), Space(30))
	cSerie	 := IF( lAlterar, oOS:ReadString( cOs, 'Serie'), Space(20))
	cMarca	 := IF( lAlterar, oOS:ReadString( cOs, 'Marca'), Space(30))
	cGarantia := IF( lAlterar, oOS:ReadString( cOs, 'Garantia'), "N")
	cCor		 := IF( lAlterar, oOS:ReadString( cOs, 'Cor'), Space(20))
	cAno		 := IF( lAlterar, oOS:ReadString( cOs, 'Ano'), Space(04))
	cDefRec1  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado1'), Space(60))
	cDefRec2  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado2'), Space(60))
	cDefRec3  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado3'), Space(60))
	cDefRec4  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado4'), Space(60))
	cDefDet1  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado1'), Space(60))
	cDefDet2  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado2'), Space(60))
	cDefDet3  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado3'), Space(60))
	cDefDet4  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado4'), Space(60))
	lAtiva	 := IF( lAlterar, oOS:ReadBool( cOs, 'Ativa'), OK )

	nRow := 01
	nCol := 00
	@ nRow,	  nCol+44 Say "Data......:" Get dEmis     Pict "##/##/##"
	@ Row()+1, nCol+1  Say "Cliente...:" Get cNome     Pict "@!"
	@ Row()+1, nCol+1  Say "Aparelho..:" Get cAparelho Pict "@!"
	@ Row()+1, nCol+1  Say "Modelo....:" Get cModelo   Pict "@!"
	@ Row(),   nCol+44 Say "Serie.....:" Get cSerie    Pict "@!"
	@ Row()+1, nCol+1  Say "Marca.....:" Get cMarca    Pict "@!"
	@ Row(),   nCol+44 Say "Garantia..:" Get cGarantia Pict "!" Valid cGarantia $ "SN"
	@ Row()+1, nCol+1  Say "Cor.......:" Get cCor      Pict "@!"
	@ Row(),   nCol+44 Say "Ano.......:" Get cAno      Pict "9999"
	@ Row()+1, nCol+1  Say "Reclamado.:" Get cDefRec1 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefRec2 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefRec3 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefRec4 Pict "@!"
	@ Row()+1, nCol+1  Say "Detectado.:" Get cDefDet1 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefDet2 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefDet3 Pict "@!"
	@ Row()+1, nCol+1  Say "           " Get cDefDet4 Pict "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma ?")
		oOS:WriteDate(   cOs, 'Data',     dEmis )
		oOS:WriteString( cOs, 'Nome',     cNome )
		oOS:WriteString( cOs, 'Aparelho', cAparelho )
		oOS:WriteString( cOs, 'Modelo',   cModelo )
		oOS:WriteString( cOs, 'Serie',    cSerie )
		oOS:WriteString( cOs, 'Marca',    cMarca )
		oOS:WriteString( cOs, 'Garantia', cGarantia )
		oOS:WriteString( cOs, 'Cor',      cCor )
		oOS:WriteString( cOs, 'Ano',      cAno )
		oOS:WriteString( cOs, 'Reclamado1', cDefRec1 )
		oOS:WriteString( cOs, 'Reclamado2', cDefRec2 )
		oOS:WriteString( cOs, 'Reclamado3', cDefRec3 )
		oOS:WriteString( cOs, 'Reclamado4', cDefRec4 )
		oOS:WriteString( cOs, 'Detectado1', cDefDet1 )
		oOS:WriteString( cOs, 'Detectado2', cDefDet2 )
		oOS:WriteString( cOs, 'Detectado3', cDefDet3 )
		oOS:WriteString( cOs, 'Detectado4', cDefDet4 )
		oOS:WriteBool( cOs, 'Ativa', lAtiva )
		ErrorBeep()
		IF Conf("Pergunta: Deseja Imprimir ?")
			ImprimeOS( cOs, oOS, lAlterar )
		EndIf
	EndIF
EndDo
Return

Proc ImprimeOS( cOs, oOS, lAlterar )
************************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Pagina  := 0
LOCAL nRow
LOCAL nCol

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
dEmis 	 := IF( lAlterar, oOS:ReadDate( cOs, 'Data'), Date())
cNome 	 := IF( lAlterar, oOS:ReadString( cOs, 'Nome'), Space(40))
cAparelho := IF( lAlterar, oOS:ReadString( cOs, 'Aparelho'), Space(60))
cModelo	 := IF( lAlterar, oOS:ReadString( cOs, 'Modelo'), Space(30))
cSerie	 := IF( lAlterar, oOS:ReadString( cOs, 'Serie'), Space(20))
cMarca	 := IF( lAlterar, oOS:ReadString( cOs, 'Marca'), Space(30))
cGarantia := IF( lAlterar, oOS:ReadString( cOs, 'Garantia'), "N")
cCor		 := IF( lAlterar, oOS:ReadString( cOs, 'Cor'), Space(20))
cAno		 := IF( lAlterar, oOS:ReadString( cOs, 'Ano'), Space(04))
cDefRec1  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado1'), Space(60))
cDefRec2  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado2'), Space(60))
cDefRec3  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado3'), Space(60))
cDefRec4  := IF( lAlterar, oOS:ReadString( cOs, 'Reclamado4'), Space(60))
cDefDet1  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado1'), Space(60))
cDefDet2  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado2'), Space(60))
cDefDet3  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado3'), Space(60))
cDefDet4  := IF( lAlterar, oOS:ReadString( cOs, 'Detectado4'), Space(60))
lAtiva	 := IF( lAlterar, oOS:ReadBool( cOs, 'Ativa'), OK )
nRow		 := 06
nCol		 := 00
Printon()
Setprc(0, 0)
Write( 00, 00, Linha1( Tam, @Pagina))
Write( 01, 00, Linha2())
Write( 02, 00, Linha3(Tam))
Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
Write( 04, 00, Padc( "ORDEM DE SERVICO",Tam ) )
Write( 05, 00, Linha5(Tam))
Write( nRow,	  nCol,	  "Data......:" + DToc( dEmis ))
Write( pRow()+1, nCol,	  "Cliente...:" + cNome )
Write( pRow()+1, nCol,	  "Aparelho..:" + cAparelho )
Write( pRow()+1, nCol,	  "Modelo....:" + cModelo )
Write( pRow(),   nCol+42, "Serie.....:" + cSerie )
Write( pRow()+1, nCol,	  "Marca.....:" + cMarca )
Write( pRow(),   nCol+42, "Garantia..:" + cGarantia )
Write( pRow()+1, nCol,	  "Cor.......:" + cCor )
Write( pRow(),   nCol+42, "Ano.......:" + cAno )
Write( pRow()+1, nCol,	  "Reclamado.:" + cDefRec1 )
Write( pRow()+1, nCol,	  "           " + cDefRec2 )
Write( pRow()+1, nCol,	  "           " + cDefRec3 )
Write( pRow()+1, nCol,	  "           " + cDefRec4 )
Write( pRow()+1, nCol,	  "Detectado.:" + cDefDet1 )
Write( pRow()+1, nCol,	  "           " + cDefDet2 )
Write( pRow()+1, nCol,	  "           " + cDefDet3 )
Write( pRow()+1, nCol,	  "           " + cDefDet4 )
PrintOff()
Return

Function AchaOs( cOs, oOS, lAlterar )
*************************************
IF Empty( cOs )
	ErrorBeep()
	Alerta("Erro: Numero Invalido.")
	Return( FALSO )
EndIF
IF oOs:ReadBool( cOs, 'Ativa', FALSO )
	ErrorBeep()
	IF Conf("Pergunta: Ordem Existente. Alterar ?")
		lAlterar := OK
		Return( OK )
	EndIF
	Return( FALSO )
EndIF
Return( OK )

*:==================================================================================================================================

Proc OrcalanRegedit()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL aOrcalan := {}
LOCAL oOrcalan := AbreIniOrcalan()

Mensagem("Aguarde, Verificando Direitos do Usuario.")
Aadd( aOrcalan, { 2.01, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.01', OK )})
Aadd( aOrcalan, { 2.02, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.02', OK )})
Aadd( aOrcalan, { 2.03, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.03', OK )})
Aadd( aOrcalan, { 2.04, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.04', OK )})
Aadd( aOrcalan, { 2.05, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.05', OK )})
Aadd( aOrcalan, { 2.06, oOrcalan:ReadBool( 'opcoesfaturamento', '#2.06', OK )})
ResTela( cScreen )
Return( aOrcalan )

Function AbreIniOrcalan()
*************************
LOCAL oOrcalan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
Return( oOrcalan )

Function SnOrcalan( nChoice )
*****************************
LOCAL nPos := 0

nPos := Ascan2( aOrcaLanIni, nChoice, 1 )
IF nPos = 0
	Return( FALSO )
EndIF
Return( aOrcaLanIni[nPos, 2])

Proc Cf_ZantIZ20( cCodi, cFatura, nLiquido, cForma )
****************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cBuffer	  := Space(134)
LOCAL Retorno	  := 0
LOCAL nPreco	  := 0
LOCAL nTotal	  := 0
LOCAL cDescForma := ""
LOCAL cTx_Icms   := 0
LOCAL cAliquota  := ""

Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
cDescForma := Left( Forma->Condicoes, 16 )
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cTx_Icms := Str( Receber->Tx_Icms, 2 )

IF cTx_Icms == "12"
	cAliquota := "01"
ElseIF cTx_Icms == "17"
	cAliquota := "03"
Else
	cAliquota := "03"
EndIF

oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
nPorta := ZaIniciaDrive(cBuffer)
FWrite( nPorta, "~1/1/", 5)
FWrite( nPorta, "~1/8/", 5)
FRead( nPorta, @cBuffer, 134)
IF !Response_Zanthus( nPorta, cBuffer )
	Return
EndIF
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
nGeral := 0
While xAlias->(!Eof())
	nQuant	  := xAlias->Quant
	IF nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIf

	nTotal	  := ( xAlias->Unitario * xAlias->Quant )
	nGeral	  += nTotal
	cDescricao := Left( xAlias->Descricao, 10)
	cTotal	  := ValueToStr( nTotal )
	cDescri	  := Left( xAlias->Descricao, 20 )
	cDescri1   := Right( xAlias->Descricao, 20 )
	cCodigo	  := xAlias->Codigo
	cQuant	  := AllTrim(Str( nQuant, 5, 2 ))
	cUnitario  := ValueToStr( xAlias->Unitario )
	cIcms 	  := " T17.00%"

	cString1   := "~2/g/$00" + cCodigo   + ' ' + cDescri  + "$"
	cString2   := "~2/g/$01" + Space(06) + ' ' + cDescri1 + "$"

	cEsq		  := "~3/;/$" + cQuant + " x " + AllTrim(cUnitario ) + cIcms
	cDir		  := AllTrim( cTotal ) + " T $"
	cString3   := cEsq + Space(49-(Len(cEsq)+Len(cDir))) + cDir

	FWrite( nPorta, cString1, Len( cString1))
	FWrite( nPorta, cString2, Len( cString2))
	FWrite( nPorta, cString3, Len( cString3))
	xAlias->(DbSkip(1))
EndDo
cGeral	  := ValueToStr( nGeral )
cEsq		  := "~2/O/$TOTAL"
cDir		  := AllTrim( cGeral ) + "   $"
cString4   := cEsq + Space(49-(Len(cEsq)+Len(cDir))) + cDir
FWrite( nPorta, cString4, Len( cString4 ))

cEsq		  := "~2/i/$01"
cDir		  := AllTrim( cGeral ) + "   $"
cString5   := cEsq + Space(49-(Len(cEsq)+Len(cDir))) + cDir
FWrite( nPorta, cString5, Len( cString5 ))
FWrite( nPorta, "~1/9/", 5)
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
ResTela( cScreen )
Return

Proc EspelhoTicket( cNoFatura )
*******************************
LOCAL Tam			 := CPI1280
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL aAp			 := {}
LOCAL nTamanho 	 := 0
LOCAL nDesconto	 := 0
LOCAL nRow			 := 0
LOCAL nTotal		 := 0
LOCAL nItens		 := 0
LOCAL nLen			 := 0
LOCAL cForma		 := ""
LOCAL cCodiVen 	 := ""
LOCAL cTela

IF cNoFatura = NIL
	BuscaPrevenda( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "ESPELHO NOTA PARCIAL" )
Else
	Aadd( aFatura, cNofatura )
EndIF
IF ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	IF Conf("Pergunta: Imprimir Espelho de Nota Parcial ?" )
		nDesconto := 0
		MaBox( 10, 10, 12, 70, "INFORMACOES COMPLEMENTARES")
		@ 11, 11 Say "Desconto.........:" Get nDesconto Pict "99.99"
		Read
		IF LastKey() = ESC .OR. !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			Return
		EndIF
		Cep->(Order( CEP_CEP ))
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Prevenda->(Order( PREVENDA_FATURA ))
		cTela 	 := SaveScreen()
		nTamanho  := Len( aFatura )
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		FPrint( _CPI12 )
		For nX := 1 To nTamanho
			cFatura := aFatura[ nX ]
			nRow	  := 11
			nTotal  := 0
			bBloco  := {|| Prevenda->Fatura = cFatura }
			IF Prevenda->(DbSeek( cFatura ))
				cForma	:= Prevenda->Forma
				cCodiVen := Prevenda->CodiVen
				dEmis 	:= Prevenda->Emis
				nItens	:= 0
				aP 		:= {}
				Receber->(DbSeek( Prevenda->Codi ))
				Cep->(DbSeek( Receber->Cep ))
				WHILE Prevenda->(EVal( bBloco )) .AND. Rel_Ok()
					nVlr		 := Prevenda->Pvendido
					nVlr		 -= ( nVlr * nDesconto ) / 100
					Lista->(DbSeek( Prevenda->Codigo ))
					Aadd( aP, { Prevenda->Saida,;
									Lista->Un,;
									Lista->Codigo,;
									Lista->(Left( Descricao, 34 )),;
									Lista->Sigla,;
									nVlr,;
									( Prevenda->Saida * nVlr ),;
									Lista->Varejo})
					Prevenda->(DbSkip(1))
				EndDo
				Asort( aP,,, {|x, y| y[4] > x[4]} ) // Ordenar Por Descricao
				nItens := 0
				Pagina := 1
				nLen	 := Len( aP )
				For nT := 1 To nLen
					IF nItens = 0
						FrontParcial( Pagina, 'PV-' + cFatura, dEmis, cForma, cCodiven )
					EndIF
					FPrint( _CPI12 )
					Qout( Tran( Ap[nT, 1 ], "999999.99"),;
							Ap[nT, 2 ],;
							Ap[nT, 3 ],;
							Space(05),;
							Ap[nT, 4 ],;
							Ap[nT, 5 ],;
							IF( Ap[nT,6] < Ap[nT,8], NG + Tran( Ap[nT, 6 ],"@E 999,999.99") + NR, Tran( Ap[nT, 6 ],"@E 999,999.99")),;
							Tran( Ap[nT, 7 ],"@E 999,999.99"))
					nItens++
					nRow++
					nTotal += Ap[nT, 7]
					IF nItens = 49
						Pagina++
						nRow	 := 11
						nItens := 0
					  __Eject()
					EndIF
				Next
				Write(  nRow, 00, Repl( SEP, Tam ))
				Write(++nRow, 40, "*** Valor Total do Faturamento ***" )
				Write(  nRow, 77, Tran( nTotal,"@E 9,999,999,999.99" ) )
				nRow += 2
				IF nRow >= 45
					__Eject()
					FrontParcial( ++Pagina, 'PV-' + cFatura, dEmis, cForma, cCodiven )
					nRow := 11
				EndIF
				//FechaTit( nRow, nDesconto )
				__Eject()
			EndIf
		Next
		PrintOff()
		ResTela( cTela )
	EndIF
EndIF
ResTela( cScreen )
Return

Proc Cf_ZantIZ11( cCodi, cFatura, nLiquido, cForma )
****************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cBuffer	  := Space(134)
LOCAL Retorno	  := 0
LOCAL nPreco	  := 0
LOCAL nTotal	  := 0
LOCAL cTx_Icms   := ''
LOCAL cAliquota  := ''
LOCAL lServico   := FALSO
LOCAL lVista	  := FALSO
LOCAL cCodiCliente
LOCAL cNomeCliente
LOCAL cEndeCliente
LOCAL cBairCliente
LOCAL cCidaCliente
LOCAL cEstaCliente
LOCAL cCgcCliente
LOCAL cSerie

Lista->(Order( LISTA_CODIGO ))
Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCodiCliente := AllTrim( Receber->Codi )
cNomeCliente := Left( AllTrim( Receber->Nome ),38)
cEndeCliente := AllTrim( Receber->Ende )
cBairCliente := AllTrim( Receber->Bair )
cCidaCliente := AllTrim( Receber->Cida )
cEstaCliente := Receber->Esta
cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
cTx_Icms 	 := Str( Receber->Tx_Icms, 2 )
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
lVista  := oIni:ReadBool('ecf', 'vista', OK )
nPorta  := ZaIniciaDrive(cBuffer)
cBuffer := "~1/1/" // Inicio de Dia
FWrite( nPorta, @cBuffer, Len( cBuffer ))

cBuffer := "~1/8/" // Inicio de Cupom Fiscal
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FRead( nPorta, @cBuffer, 134)

IF !Response_Zanthus( nPorta, cBuffer )
	Cancel_Zanthus()
	Return
EndIF
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
cSerie := xAlias->Serie

// Mensagem Promocional
cBuffer := "~2/o/$00========================================$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
#IFDEF COLCHOES
	xFatura := ''
#ELSE
	xFatura := cFatura
#ENDIF

IF lNomeEcf
	cBuffer := "~2/o/$01" + 'Cliente.: ' + cNomeCliente + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$02" + 'Endereco: ' + cEndeCliente + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$03" + 'Cidade..: ' + cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$04" + 'Cgc/Cpf.: ' + cCgcCliente + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	IF Empty( cSerie )
		cBuffer := "~2/o/$05========================================$"
	Else
		cBuffer := "~2/o/$05" + 'Serie...: ' + cSerie + '$'
	EndIF
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := "~2/o/$06" + Padc(Left(AllTrim( cRamoIni ),39),39) + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := '~2/o/$07' + Repl('=', 40-Len(AllTrim(xFatura))) + AllTrim(xFatura) + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
Else
	cBuffer := "~2/o/$01" + Padc(Left(AllTrim( cRamoIni ),39),39) + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	cBuffer := '~2/o/$02' + Repl('=', 40-Len(AllTrim(xFatura))) + AllTrim(xFatura) + '$'
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
EndIF

// Espacejamento
cBuffer := "~2/U/$01$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
nGeral := 0
While xAlias->(!Eof())
	nQuant	  := xAlias->Quant
	if nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIF
	nTotal	  := ( xAlias->Unitario * xAlias->Quant )
	nGeral	  += nTotal
	cDescricao := Left( xAlias->Descricao, 33)
	cTotal	  := ValueToStr( nTotal )
	cDescri	  := Left( xAlias->Descricao, 20 )
	cDescri1   := Right( xAlias->Descricao, 20 )
	cCodigo	  := xAlias->Codigo
	IF Right( Str( nQuant, 6, 2 ), 1 ) == '0'
		cQuant := AllTrim(Str( nQuant, 5, 1 ))
	Else
		cQuant := AllTrim(Str( nQuant, 5, 2 ))
	EndiF
	cUnitario  := ValueToStr( xAlias->Unitario )
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
	xAlias->(DbSkip(1))
EndDo
// Totalizacao do Cupom Fiscal
cGeral	  := ValueToStr( nGeral )
cBuffer	  := '~3/O/$' + Space(37-Len(cGeral)) + cGeral + '   $ '
FWrite( nPorta, @cBuffer, Len( cBuffer ))

IF lVista
	cForma := '01' // Vista
Else
	cForma := '05' // Prazo
EndIF

// Registro do Pagamento
cBuffer	  := '~3/i/$' + cForma + Space(35-Len(cGeral)) + cGeral  + '   $'
FWrite( nPorta, @cBuffer, Len( cBuffer ))

// Fechamento do Cupom
FWrite( nPorta, "~1/9/", 5)

// Espacejamento
cBuffer := "~2/U/$08$"
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )

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
ResTela( cScreen )
Return


Proc ExPrevenda()
*****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cFaturaIni := Space(07)
LOCAL cFaturaFim := Space(07)
LOCAL xSaida	  := StrTran( Dtoc( Date()),'/') + '.EXP'

LOCAL oBloco

WHILE OK
	oMenu:Limpa()
	cFaturaIni := Space(07)
	cFaturaFim := Space(07)
	MaBox( 17, 10, 20, 41 )
	@ 18, 11 Say "Pre-Venda n§ Inicial.:" Get cFaturaIni Pict "@!" Valid AchaPreVenda( @cFaturaIni )
	@ 19, 11 Say "Pre-Venda n§ Final...:" Get cFaturaFim Pict "@!" Valid AchaPreVenda( @cFaturaFim )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde...", Cor())
	oBloco := {|| Prevenda->Fatura >= cFaturaIni .AND. Prevenda->Fatura <= cFaturaFim }
	Area("Prevenda")
	Copy To ( xSaida ) For Eval( oBloco )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela(cScreen )
	Return
EndDo

Proc ImPrevenda()
*****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL Files 	  := "*.EXP"
LOCAL Arquivo	  := Space(08)
LOCAL xTemp

oMenu:Limpa()
MaBox( 16, 10, 18, 61 )
@ 17, 11 Say "Arquivo a Importar..:" Get Arquivo PICT "@!"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
IF Empty( Arquivo )
	M_Title( "Setas CIMA/BAIXO Move")
	Arquivo := Mx_PopFile( 03, 10, 15, 61, Files, Cor())
	IF Empty( Arquivo )
		ErrorBeep()
		ResTela( cScreen )
		Return
  EndIF
Else
	IF !File( Arquivo )
		ErrorBeep()
		ResTela( cScreen )
		Alert( Rtrim( Arquivo ) + " Nao Encontrado... " )
		ResTela( cScreen )
		Return
	EndIF
EndIF
Mensagem("Aguarde, Importando Arquivo.")
Area("Prevenda")
Appe From ( Arquivo )
xTemp := StrTran( Arquivo, '.EXP')
MsRename( Arquivo, xTemp + '.IMP')
AreaAnt( Arq_Ant, Ind_Ant )
ResTela(cScreen )
Return

Proc BuscaPrevenda( aFatuTemp, aFatura, aRegis, aRegiTemp, cTitulo )
******************************************************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aMenuArray	 := { "Por Periodo", "Por Regiao", "Selecionar", "Por Produto", "Geral"}
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL nRecno		 := 0
LOCAL nItens		 := 0
LOCAL nConta		 := 0
LOCAL nContaFatura := 0
LOCAL nTamanho 	 := 0
LOCAL cRegiao		 := Space(02)
LOCAL cFatura		 := Space(07)
LOCAL nChoice		 := 1
LOCAL Col			 := 0
LOCAL nQuant
LOCAL cSigla
LOCAL cDescricao
LOCAL cCodi
LOCAL cNome
LOCAL bBloco
LOCAL cTela
LOCAL cRelato
LOCAL nTam
LOCAL Pos1
LOCAL Line
LOCAL nPagina
LOCAL Ok
LOCAL Tot_Reg
LOCAL nReg
LOCAL nSobra
LOCAL Escolha
LOCAL aCodigo
LOCAL cCodigo
LOCAL cDesc
LOCAL nSaida
LOCAL cCabecalho
LOCAL PosCur
LOCAL nX
LOCAL nPos
LOCAL xCodigo
FIELD Codigo
Field Saida

oMenu:Limpa()
M_Title( cTitulo )
nChoice := FazMenu( 09, 44, aMenuArray, Cor())
Do Case
Case nChoice = 0
	ResTela( cScreen )
	Return

Case nChoice = 1
	dIni	 := Date() - 30
	dFim	 := Date()
	nRecno := 0
	MaBox( 18, 20, 21, 56 )
	@ 19, 21 Say "Digite Emissao Inicial.:" Get dIni Pict "@K##/##/##" Valid AchaDataPre( dIni, @nRecno )
	@ 20, 21 Say "Digite Emissao Final...:" Get dFim Pict "@K##/##/##"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	Prevenda->(Order( PREVENDA_EMIS ))
	oMenu:Limpa()
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| Prevenda->Emis >= dIni .AND. Prevenda->Emis <= dFim }
	cFatura		 := Space(07)
	nContaFatura := 0
	Prevenda->(DbGoTo( nRecno ))
	While Prevenda->(Eval( bBloco ))
		cFatura := Prevenda->Fatura
		nRecno  := Prevenda->(Recno())
		IF nContaFatura >= 4096 // Maximo
			ErrorBeep()
			Alerta("Erro: Maximo de 4096 Faturas.")
			Exit
		EndIF
		IF Ascan( aFatuTemp, cFatura ) = 0
			nContaFatura++
			Aadd( aFatuTemp, cFatura  )
			Aadd( aRegiTemp, nRecno )
		EndIF
		Prevenda->(DbSkip(1))
	EndDo

Case nChoice = 2
	nRecno	:= 0
	cRegiao	:= Space(2)
	dIni		:= Date()-30
	dFim		:= Date()
	MaBox( 18, 20, 22, 56 )
	@ 19, 21 Say "Digite a Regiao........:" Get cRegiao Pict "99"     Valid RegiaoErrada( @cRegiao )
	@ 20, 21 Say "Digite Emissao Inicial.:" Get dIni    Pict PIC_DATA Valid AchaDataPre( dIni, @nRecno )
	@ 21, 21 Say "Digite Emissao Final...:" Get dFim    Pict PIC_DATA
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	oMenu:Limpa()
	Prevenda->( Order( PREVENDA_EMIS ))
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| Prevenda->Emis >= dIni .AND. Prevenda->Emis <= dFim }
	cFatura		 := Space(07)
	nContaFatura := 0
	Prevenda->(DbGoto( nRecno ))
	While Prevenda->(Eval( bBloco ))
		IF Prevenda->Regiao = cRegiao
			cFatura := Prevenda->Fatura
			nRecno  := Prevenda->(Recno())
			IF nContaFatura >= 4096 // Maximo
				ErrorBeep()
				Alerta("Erro: Maximo de 4096 Faturas.")
				Exit
			EndIF
			IF Ascan( aFatuTemp, cFatura ) = 0
				nContaFatura++
				Aadd( aFatuTemp, cFatura  )
				Aadd( aRegiTemp, nRecno )
			EndIF
		EndIF
		Prevenda->(DbSkip(1))
	EndDo

Case nChoice = 3
	oMenu:Limpa()
	nConta := 0
	nItens := Nota->(Lastrec())
	MaBox( 00, 00, 02, 79 )
	Write( 01, 01, "Total de Faturas.: " + StrZero( nItens, 4 ))
	Write( 01, 26, "Selecionadas.....: " + StrZero( nConta, 4 ))
	Write( 01, 51, "Disponiveis......: " + StrZero( nItens - nConta, 4 ))
	aRegis		 := {}
	aFatura		 := {}
	Col			 := 4
	nContaFatura := 0
	MaBox( 03, 26, 22, 79 , "FATURA   CODI NOME CLIENTE                      " )
	WHILE OK
		cFatura := Space( 07 )
		MaBox( 20, 01, 22, 25 )
		@ 21, 02 Say "Fatura N§...:" Get cFatura Pict "@!" Valid AchaPrevenda( @cFatura )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Lista->(Order( LISTA_CODIGO ))
		Prevenda->(Order( PREVENDA_FATURA ))
		IF Prevenda->( DbSeek( cFatura ))
			cCodi   := Prevenda->Codi
			cFatura := Prevenda->Fatura
			nRecno  := Prevenda->(Recno())
			IF Receber->(!DbSeek( cCodi ))
				cNome := "CLIENTE NAO LOCALIZADO"
			Else
				cNome := Receber->Nome
			EndIF
			IF nContaFatura >= 4096 // Maximo
				ErrorBeep()
				Alerta("Erro: Maximo de 4096 Faturas.")
				Exit
			EndIF
			nContaFatura++
			Aadd( aFatura,   cFatura )
			Aadd( aRegis,	  nRecno )
			Write( 01,	45, StrZero( ++nConta,	4 ) ,"R/W")
			Write( 01,	70, StrZero( --nItens, 4 ) ,"R/W")
			Write( Col, 27, cFatura + "  " + cCodi + " " + Left( cNome, 36 ) , "R/W")
			IF Col = 21
				Scroll( 04, 27, 21, 78, 1 )
				Col := 21
			Else
				Col++
			EndIF
		Else
			ErrorBeep()
			Alerta("Erro: Favor reindexar.")
		EndIF
	Enddo
Case nChoice = 4
	nRecno	:= 0
	xCodigo	:= 0
	MaBox( 18, 20, 20, 56 )
	@ 19, 21 Say "Codigo a Procurar.....:" Get xCodigo Pict PIC_LISTA_CODIGO Valid CodiErrado(@xCodigo)
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	oMenu:Limpa()
	Prevenda->( Order( PREVENDA_FATURA ))
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| !Eof() }
	cFatura		 := Space(07)
	nContaFatura := 0
	Prevenda->(DbGoTop())
	While Prevenda->(Eval( bBloco ))
		IF Prevenda->Codigo = xCodigo
			cFatura := Prevenda->Fatura
			nRecno  := Prevenda->(Recno())
			IF nContaFatura >= 4096 // Maximo
				ErrorBeep()
				Alerta("Erro: Maximo de 4096 Faturas.")
				Exit
			EndIF
			IF Ascan( aFatuTemp, cFatura ) = 0
				nContaFatura++
				Aadd( aFatuTemp, cFatura  )
				Aadd( aRegiTemp, nRecno )
			EndIF
		EndIF
		Prevenda->(DbSkip(1))
	EndDo

Case nChoice = 5
	ErrorBeep()
	IF !Conf("Pergunta: Poder  demorar. Continuar ?")
		ResTela( cScreen )
		Return
	EndIF
	nRecno := 0
	Prevenda->(Order( PREVENDA_FATURA ))
	oMenu:Limpa()
	Mensagem("Aguarde, Incluindo.", WARNING )
	aFatuTemp	 := {}
	aRegiTemp	 := {}
	bBloco		 := {|| !Eof() }
	cFatura		 := Space(07)
	nContaFatura := 0
	Prevenda->(DbGoTop())
	While Prevenda->(Eval( bBloco ))
		cFatura := Prevenda->Fatura
		nRecno  := Prevenda->(Recno())
		IF nContaFatura >= 4096 // Maximo
			ErrorBeep()
			Alerta("Erro: Maximo de 4096 Faturas.")
			Exit
		EndIF
		IF Ascan( aFatuTemp, cFatura ) = 0
			nContaFatura++
			Aadd( aFatuTemp, cFatura  )
			Aadd( aRegiTemp, nRecno )
		EndIF
		Prevenda->(DbSkip(1))
	EndDo
EndCase
IF nContaFatura = 0
	oMenu:Limpa()
	ErrorBeep()
	Alerta( "Erro: Nenhuma Prevenda Disponivel.")
	ResTela( cScreen )
	Return
EndIF
IF nChoice != 3
	oMenu:Limpa()
	nConta := 0
	nSobra := nContaFatura
	MaBox( 00, 00, 02, 79 )
	Write( 01, 01, "Total de Faturas.¯ " + StrZero( nContaFatura, 4 ))
	Write( 01, 26, "Selecionadas.....¯ " + StrZero( nConta,       4 ))
	Write( 01, 51, "Disponiveis......¯ " + StrZero( nSobra,       4 ))
	aRegis	:= {}
	aFatura	:= {}
	Col		:= 4
	Receber->(Order( RECEBER_CODI ))
	Lista->(Order( LISTA_CODIGO ))
	Prevenda->(Order( PREVENDA_FATURA ))
	MaBox( 03, 26, 22, 79 , "FATURA   CODI NOME CLIENTE                      " )
	WHILE OK
		MaBox( 03, 00, 22, 20 , "FATURAS")
		Escolha := Achoice( 04, 03, 21, 19, aFatuTemp )
		IF Escolha = 0 			  // Esc ?
			Exit						  // ... Entao Vaza.
		EndIF
		Prevenda->(DbGoTo( aRegiTemp[ Escolha ] ))
		Aadd( aFatura,   aFatuTemp[ Escolha ] )
		Aadd( aRegis,	  aRegiTemp[ Escolha ] )
		Write( 01, 45, StrZero( ++nConta,  4 ) ,"R/W")
		Write( 01, 70, StrZero( --nSobra,  4 ) ,"R/W")
		cFatura := aFatuTemp[ Escolha ]
		nRecno  := aRegiTemp[ Escolha ]
		cNome   := "CLIENTE NAO LOCALIZADO"
		IF Prevenda->( DbSeek( cFatura ))
			cCodi   := Prevenda->Codi
			cFatura := Prevenda->Fatura
			nRecno  := Prevenda->(Recno())
			IF Receber->(DbSeek( cCodi ))
				cNome := Receber->Nome
			EndIF
		EndIF
		Write( Col, 27, cFatura + "  " + cCodi + ' ' + Left( cNome, 36 ) , "R/W")
		Adel( aFatuTemp, Escolha )
		Adel( aRegiTemp, Escolha )
		IF Col = 21
			Scroll( 04, 27, 21, 78, 1 )
			Col := 21
		Else
			Col++
		EndIF
	Enddo
EndIF

Function AchaDataPre( dIni, nRecno )
************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Prevenda->(Order( PREVENDA_EMIS ))
IF Prevenda->(!DbSeek( dIni ))
	ErrorBeep()
	Alerta("Erro: Data Inicial nao encontrada. ")
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(FALSO)
EndIF
nRecno := Prevenda->(Recno())
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Proc Cf_Sigtron( cCodi, cFatura, nLiquido, cForma )
***************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cBuffer	  := Space(134)
LOCAL nTotal	  := 0
LOCAL nGeral	  := 0
LOCAL lServico   := FALSO
LOCAL cGeral	  := '000000000000'
LOCAL cDesconto  := '000000000000'
LOCAL cUnitario  := '000000000'
LOCAL nIcms 	  := 17
LOCAL lVista	  := FALSO
LOCAL nQuant	  := 0
LOCAL nSigLinha  := 1
LOCAL nBloco	  := 128
LOCAL nDesconto  := 0
LOCAL cRetorno   := Space( nBloco )
LOCAL cLetraDesc := '1'
LOCAL cCodiCliente
LOCAL cNomeCliente
LOCAL cEndeCliente
LOCAL cBairCliente
LOCAL cCidaCliente
LOCAL cEstaCliente
LOCAL cCgcCliente
LOCAL nConta
LOCAL cCondicoes

Lista->(Order( LISTA_CODIGO ))
Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
cCondicoes := Forma->Condicoes
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCodiCliente := AllTrim( Receber->Codi )
cNomeCliente := Left( AllTrim( Receber->Nome ),39)
cEndeCliente := Left( AllTrim( Receber->Ende ),39)
cBairCliente := AllTrim( Receber->Bair )
cCidaCliente := AllTrim( Receber->Cida )
cEstaCliente := Receber->Esta
cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
nIcms 		 := Receber->Tx_Icms
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
IF nIcms = 0
	nIcms = oIni:ReadInteger('ecf', 'uficms', 17 )
EndIF
nSigLinha := oIni:ReadInteger('ecf', 'siglinha', 2 )
lVista	 := oIni:ReadBool('ecf', 'vista', OK )
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
nPorta  := SigtronIniciaDrive(cBuffer)
cBuffer := Chr(27) + Chr(228) + '1100100010110391505000025500001110000000'
FWrite( nPorta, @cBuffer, Len( cBuffer ))
cBuffer := Chr(27) + Chr(200) // Inicio de Cupom Fiscal
FWrite( nPorta, @cBuffer, Len( cBuffer ))
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
While xAlias->(!Eof())
	cCodigo	  := xAlias->Codigo
	cDescricao := Left( xAlias->Descricao, 37)
	nQuant	  := xAlias->Quant
	IF nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIF
	IF Right( Str( nQuant, 7, 2 ), 2 ) == '00'
		cQuant := StrZero(Int( nQuant ), 5)
	Else
		IF Right( Str( nQuant, 6, 2 ), 1 ) == '0'
			cQuant := StrTran( Str( nQuant, 5, 1 ), '.', ',')
		Else
			cQuant := StrTran( Str( nQuant, 5, 2 ), '.', ',')
		EndiF
	EndIF
	cUnitario  := StrSemComma( xAlias->Unitario, 13, 2, 9 )
	nTotal	  := ( xAlias->Unitario * xAlias->Quant )
	nGeral	  += nTotal

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
	cBuffer += '0000'             // Right(Strzero(Val(IntToStrSemPonto( xAlias->Desconto, 5, 2)), 5), 4)
	cBuffer += cUnitario 			// Preco Unitario 9 digitos sem virgula
	cBuffer += cQuant 				// Quantidade
	IF nSigLinha = 1
		cBuffer += Left( cDescricao,14)	// Descricao com 14 caracteres
	Else
		cBuffer += cUn 						// Unidade
		cBuffer += Left( cDescricao,37)	// Descricao com 37 caracteres
	EndIF
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	xAlias->(DbSkip(1))
EndDo
nDesconto  := Round((nLiquido-nGeral),2)
cDesconto  := '000000000000'
cGeral	  := StrSemComma( nGeral, 13, 2, 12 )
cLetraDesc := '1'
IF nDesconto < 0 // Desconto
	xDesconto  := 0
	xDesconto  -= nDesconto
	nDesconto  := xDesconto
	cDesconto  := StrSemComma( nDesconto, 13, 2, 12 )
	cGeral	  := StrSemComma( nGeral, 13, 2, 12 )
	cLetraDesc := '1'
ElseIF nDesconto > 0 // Acrescimo
	cDesconto  := StrSemComma( nDesconto, 13, 2, 12 )
	cGeral	  := StrSemComma( nLiquido, 13, 2, 12 )
	cLetraDesc := '3'
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
cBuffer += cLetra 			// Forma de Pagamento
cBuffer += cGeral 			// Valor Total com 12 digitos sem virgula/ponto
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
cBuffer += Left(AllTrim(oAmbiente:xFanta), 13 ) + Chr(13) + Chr(10)
FWrite( nPorta, @cBuffer, Len( cBuffer ))
*/

/* Cupom Fiscal Adicional
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
ResTela( cScreen )
Return

Proc Cf_Daruma( cCodi, cFatura, nLiquido, cForma )
**************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cBuffer	  := Space(134)
LOCAL nTotal	  := 0
LOCAL nGeral	  := 0
LOCAL lServico   := FALSO
LOCAL cGeral	  := '000000000000'
LOCAL cDesconto  := '000000000000'
LOCAL cUnitario  := '000000000'
LOCAL nIcms 	  := 17
LOCAL lVista	  := FALSO
LOCAL nQuant	  := 0
LOCAL nSigLinha  := 1
LOCAL nBloco	  := 128
LOCAL nDesconto  := 0
LOCAL cRetorno   := Space( nBloco )
LOCAL cLetraDesc := '1'
LOCAL cFimLinha  := Chr(13) + Chr(10)
LOCAL cBrkDir    := ']'
LOCAL cBrkEsq    := '['
LOCAL cAssinatura := ''
LOCAL cCodiCliente
LOCAL cNomeCliente
LOCAL cEndeCliente
LOCAL cBairCliente
LOCAL cCidaCliente
LOCAL cEstaCliente
LOCAL cCgcCliente
LOCAL nConta
LOCAL cCondicoes
LOCAL cLiquido
               
Lista->(Order( LISTA_CODIGO ))
Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
cCondicoes := Forma->Condicoes
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCodiCliente := AllTrim( Receber->Codi )
cNomeCliente := Left( AllTrim( Receber->Nome ),39)
cEndeCliente := Left( AllTrim( Receber->Ende ),39)
cBairCliente := AllTrim( Receber->Bair )
cCidaCliente := AllTrim( Receber->Cida )
cEstaCliente := Receber->Esta
cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
cCgcCliente  := IF( Empty(cCgcCliente), '00.000.000/0000-00', cCgcCliente )
nIcms 		 := Receber->Tx_Icms
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
IF nIcms = 0
	nIcms = oIni:ReadInteger('ecf', 'uficms', 17 )
EndIF
nSigLinha   := oIni:ReadInteger('ecf', 'siglinha', 2 )
lVista      := oIni:ReadBool('ecf', 'vista', OK )
cAssinatura := cBrkEsq + cFatura + cBrkDir
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
nPorta  := DarumaIniciaDrive(cBuffer)
cBuffer := cAssinatura + '1000;' + cCgcCliente + ';' // Inicio de Cupom Fiscal
cBuffer += cFimLinha
FWrite( nPorta, @cBuffer, Len( cBuffer ))
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
While xAlias->(!Eof())
	cCodigo	  := xAlias->Codigo
	cDescricao := Left( xAlias->Descricao, 37)
	nQuant	  := xAlias->Quant
	IF nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIF
	IF Right( Str( nQuant, 7, 2 ), 2 ) == '00'
		cQuant := StrZero(Int( nQuant ), 4)
	Else
		IF Right( Str( nQuant, 6, 2 ), 1 ) == '0'
			cQuant := StrTran( Str( nQuant, 5, 1 ), '.', ',')
		Else
			cQuant := StrTran( Str( nQuant, 5, 2 ), '.', ',')
		EndiF
	EndIF
	cQuant	  := AllTrim(Transform( xAlias->Quant, '@E 99999.99'))
	cUnitario  := AllTrim(Transform( xAlias->Unitario, '@E 999,999,999.99'))
	nTotal	  := ( xAlias->Unitario * xAlias->Quant )
	nGeral	  += nTotal

	Lista->(DbSeek( cCodigo ))
	cUn		:= Lista->Un
	lServico := Lista->Servico
	cClasse	:= Lista->Classe

	cLetra := 'TD'
	IF cClasse = '00'
		IF nIcms = 5
			cLetra := 'TA'
		ElseIF nIcms = 7
			cLetra := 'TB'
		ElseIF nIcms = 12
			cLetra := 'TC'
		ElseIF nIcms = 17
			cLetra := 'TD'
		ElseIF nIcms = 25
			cLetra := 'TE'
		EndIF
	ElseIF cClasse = '10'
		cLetra := 'FF'
	ElseIF cClasse = '20'
		cLetra := 'NN'
	ElseIF cClasse = '30'
		cLetra := 'FF'
	ElseIF cClasse = '40'
		cLetra := 'II'
	ElseIF cClasse = '41'
		cLetra := 'II'
	ElseIF cClasse = '50'
		cLetra := 'II'
	ElseIF cClasse = '51'
		cLetra := 'II'
	ElseIF cClasse = '60'
		cLetra := 'FF'
	ElseIF cClasse = '70'
		cLetra := 'NN'
	ElseIF cClasse = '90'
		cLetra := 'NN'
	EndIF
	IF lServico
		cLetra := 'TA'
	EndIF
   cBuffer := cAssinatura                 // Assinatura do Cupom
   cBuffer += '1001;'                     // Vende Item
	cBuffer += cCodigo + ';'               // Codigo Produto 6 Digitos
	cBuffer += Left( cDescricao,14) + ';'  // Descricao com 14 caracteres
	cBuffer += cLetra + ';'                // Situacao Tributaria
	cBuffer += 'F' + ';'                   // F=Fracao I=Inteiro
	cBuffer += cQuant + ';'                // Quantidade
	cBuffer += '2' + ';'                   // Casas Decimais
   cBuffer += cUnitario + ';'             // Valor Unitario
   cBuffer += '%;'                        // Desconto em %percentual, ou $valor
   cBuffer += '0000;'                     // Valor do Desconto
	cBuffer += cFimLinha
	FWrite( nPorta, @cBuffer, Len( cBuffer ))
	xAlias->(DbSkip(1))
EndDo
nDesconto  := Round((nLiquido-nGeral),2)
cLiquido   := AllTrim(Transform(nLiquido, '@E 999,999,999.99'))
cLetraDesc := 'A' //Acrescimo
IF nDesconto < 0  // Desconto
   cLetraDesc := 'D'
	xDesconto  := 0
	xDesconto  -= nDesconto
	nDesconto  := xDesconto
   cDesconto  := AllTrim(Transform(nDesconto,'@E 999,999,999.99'))
EndIF
cDesconto := AllTrim(Transform(nDesconto,'@E 999,999,999.99'))
// Registro do Pagamento
cLetra := 'DINHEIRO'
IF lVista
	cLetra := 'DINHEIRO'
Else
	cLetra := cCondicoes
EndIF

// Fechamento do Cupom Resumido
//cBuffer := cAssinatura
//cBuffer += '1012;'
//cBuffer += cLetra + ';'
//cBuffer += cRamoIni + ';'
//cBuffer += cFimLinha
//FWrite( nPorta, @cBuffer, Len( cBuffer ))

// Inicia Fechamento do Cupom com Desconto/Acrescimo
cBuffer := cAssinatura
cBuffer += '1007;'
cBuffer += cLetraDesc + ';'
cBuffer += "$" + ';'
cBuffer += cDesconto + ';'
cBuffer += cFimLinha
FWrite( nPorta, @cBuffer, Len( cBuffer ))

// Efetua Forma de Pagamento
cBuffer := cAssinatura
cBuffer += '1008;'
cBuffer += cLetra + ';'
cBuffer += cLiquido + ';'
cBuffer += cFimLinha
FWrite( nPorta, @cBuffer, Len( cBuffer ))

// Identifica Consumidor
cBuffer := cAssinatura
cBuffer += '1013;'
cBuffer += cNomeCliente + ';'
cBuffer += cEndeCliente  +  ' - ' + cBairCliente + ' - ' + cCidaCliente +  '/' + cEstaCliente + ';'
cBuffer += cCgcCliente	+ ';'
cBuffer += cFimLinha
FWrite( nPorta, @cBuffer, Len( cBuffer ))

// Termina Fechamento Cupom
cBuffer := cAssinatura
cBuffer += '1010;'
cBuffer += Padc(cRamoIni,48) + Repl('=', 48-Len(AllTrim(cFatura))) + AllTrim(cFatura)
cBuffer += cFimLinha
FWrite( nPorta, @cBuffer, Len( cBuffer ))
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
ResTela( cScreen )
Return

Proc Cf_Bema( cCodi, cFatura, nLiquido, cForma )
************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cIni		  := chr(27) + chr(251)
LOCAL cFimLinha  := Chr(13) + Chr(10)
LOCAL cFim		  := '|'+ chr(27)
LOCAL cBuffer	  := ""
LOCAL Retorno	  := 0
LOCAL nPreco	  := 0
LOCAL nTotal	  := 0
LOCAL cIcmsCli   := 0
LOCAL cAliquota  := ''
LOCAL cPipe 	  := '|'
LOCAL nDesconto  := 0
LOCAL lVista	  := FALSO
LOCAL aAliquota  := {}
LOCAL aIcmsIss   := {}
LOCAL nY 		  := 0
LOCAL cIcmsEsta  := ''
LOCAL cIssMuni   := ''
LOCAL xTx_Icms   := 0
LOCAL nPos		  := 0
LOCAL cLiquido
LOCAL cLetra
LOCAL cCodigo
LOCAL cDescricao
LOCAL cQuant
LOCAL cUnitario
LOCAL cDesconto
LOCAL cClasse
LOCAL lServico
LOCAL xCodigo
LOCAL cPosicao1
LOCAL cPosicao2
LOCAL cPosicao3
LOCAL cPosicao4
LOCAL cPosicao5
LOCAL cCodiCliente
LOCAL cNomeCliente
LOCAL cEndeCliente
LOCAL cBairCliente
LOCAL cCidaCliente
LOCAL cEstaCliente
LOCAL cCgcCliente
LOCAL cRgCliente

Lista->(Order( LISTA_CODIGO ))
Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCodiCliente := AllTrim( Receber->Codi )
cNomeCliente := Left( AllTrim( Receber->Nome ),38)
cEndeCliente := AllTrim( Receber->Ende )
cBairCliente := AllTrim( Receber->Bair )
cCidaCliente := AllTrim( Receber->Cida )
cEstaCliente := Receber->Esta
cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
cRgCliente	 := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Rg, Receber->Insc )
cIcmsCli 	 := StrZero( Receber->Tx_Icms, 5,2 )
lVista		 := oIni:ReadBool('ecf', 'vista', OK )
cIcmsEsta	 := StrZero(oIni:ReadInteger('ecf', 'uficms', 17), 5, 2 )
cIssMuni 	 := StrZero(oIni:ReadInteger('ecf', 'iss', 5), 5, 2 )
For nY := 1 To 9
	Aadd( aAliquota, oIni:ReadString('ecf', 'pos' + str(nY,1) + 'icms', cIcmsEsta, 1))
	Aadd( aIcmsIss,  oIni:ReadString('ecf', 'pos' + str(nY,1) + 'icms', 1,  2))
Next
IF lVista
	IF lEcfRede
		cForma := 'DINHEIRO'
	Else
		cForma := '01'
	EndIF
Else
	IF lEcfRede
		cForma := 'VENDA A PRAZO'
	EndIF
EndIF
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
nPorta := BemaIniciaDriver()
Mensagem("Aguarde, Emitindo Cupom Fiscal.")
IF lEcfRede
	cBuffer := '003' + cPipe + cCgcCliente + cPipe
Else
	cBuffer := cIni + "00" + cFim
EndIF
Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
While xAlias->(!Eof())
	nQuant	  := xAlias->Quant
	if nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIF
	nPreco	  := ( xAlias->Unitario * xAlias->Quant )
	nTotal	  += nPreco
	xCodigo	  := xAlias->Codigo
	cCodigo	  := StrZero( Val( xAlias->Codigo ),13 )
	cDescricao := Left( xAlias->Descricao, 29)
	cQuant	  := Right( Strzero( Val( IntToStrSemPonto( xAlias->Quant, 10, 3)), 10),7)
	cUnitario  := Right( Strzero( Val( IntToStrSemPonto( xAlias->Unitario, 11, 2 )),11),8)
	cDesconto  := "0000"         // Right( Strzero( Val( IntToStrSemPonto( xAlias->Desconto, 5, 2 )), 5), 4)

	Lista->(DbSeek( xCodigo ))
	lServico := Lista->Servico
	cClasse	:= Lista->Classe

	IF cIcmsCli = '00.00'
		cTx_Icms := cIcmsEsta
	Else
		cTx_Icms := cIcmsCli
	EndIF

	IF cClasse = '20' // Reducao da Base de Calculo
		xTx_Icms := ReducaoBase( cEstaCliente )
		IF xTx_Icms = 0
			cTx_Icms := cIcmsEsta
		Else
			cTx_Icms := Tran(Int(Val(Str( xTx_Icms, 5, 2 ))),'99.99')
		EndIF
	EndIF
	nPos := Ascan( aAliquota, cTx_Icms )
	IF nPos <> 0
		cAliquota := StrZero( nPos, 2 )
	Else
		cAliquota := '01' // Nao achou ? Define como sendo a primeira.
	EndIF
	IF cClasse = '00'
		cLetra := cAliquota
	ElseIF cClasse = '10'
		cLetra := 'FF'
	ElseIF cClasse = '20' // Reducao da Base de Calculo
		// cLetra := 'NN'
		cLetra := cAliquota
	ElseIF cClasse = '30'
		cLetra := 'FF'
	ElseIF cClasse = '40'
		cLetra := 'II'
	ElseIF cClasse = '41'
		cLetra := 'II'
	ElseIF cClasse = '50'
		cLetra := 'II'
	ElseIF cClasse = '51'
		cLetra := 'II'
	ElseIF cClasse = '60'
		cLetra := 'FF'
	ElseIF cClasse = '70'
		cLetra := 'NN'
	ElseIF cClasse = '90'
		cLetra := 'NN'
	EndIF

	IF lServico
		For nY := 1 To Len( aIcmsIss )
			IF aIcmsIss[nY] == '2' // Iss
				cLetra := StrZero( nY, 2 )
				IF aAliquota[nY] == cIssMuni
					cLetra := StrZero( nY, 2 )
					Exit
				EndIF
			EndIF
		Next
	EndIF
	IF lEcfRede
		cFracao	  := 'F'
		cDecimal   := '2'
		cBuffer	  := '089'       + cPipe
		cBuffer	  += cCodigo	  + cPipe
		cBuffer	  += cDescricao  + cPipe
		cBuffer	  += cLetra 	  + cPipe
		cBuffer	  += cFracao	  + cPipe
		cBuffer	  += cQuant 	  + cPipe
		cBuffer	  += cDecimal	  + cPipe
		cBuffer	  += cUnitario   + cPipe
		cBuffer	  += '$'         + cPipe
		cBuffer	  += cDesconto   + cPipe
	Else
		cBuffer	  := cIni + "09" + cPipe
		cBuffer	  += cCodigo	  + cPipe
		cBuffer	  += cDescricao  + cPipe
		cBuffer	  += cLetra 	  + cPipe
		cBuffer	  += cQuant 	  + cPipe
		cBuffer	  += cUnitario   + cPipe
		cBuffer	  += cDesconto
		cBuffer	  += cFim
	EndIF
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	xAlias->(DbSkip(1))
EndDo
nDesconto := ( nLiquido - nTotal )
IF nDesconto <= 0
	cDesconto := Right( Strzero( Val( IntToStrSemPonto( nDesconto, 15, 2 )), 15 ),15)
	cDescTemp := Right(Strtran( cDesconto,'-'),8)
	cDesconto := Right(Strtran( cDesconto,'-'),14)
	cLiquido  := Right( Strzero( Val( IntToStrSemPonto( nLiquido, 15, 2 )), 15 ),14)
	IF lEcfRede
		cLetra := 'D'
		cBuffer	 := '040'  + cPipe
		cBuffer	 += cLetra + cPipe
		cBuffer	 += '$'    + cPipe
		cBuffer	 += cDescTemp + cPipe
	Else
		cLetra := 'd'
		cBuffer	 := cIni + "32|" + cLetra + cPipe + cDesconto + cFim
	EndIF
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
Else
	cDescTemp := Right( Strzero( Val( IntToStrSemPonto( nDesconto, 15, 2 )), 15 ),8)
	cDesconto := Right( Strzero( Val( IntToStrSemPonto( nDesconto, 15, 2 )), 15 ),14)
	cLiquido  := Right( Strzero( Val( IntToStrSemPonto( nLiquido, 15, 2 )), 15 ),14)
	IF lEcfRede
		cLetra := 'A'
		cBuffer	 := '040'  + cPipe
		cBuffer	 += cLetra + cPipe
		cBuffer	 += '$'    + cPipe
		cBuffer	 += cDescTemp + cPipe
	Else
		cLetra := 'a'
		cBuffer	 := cIni + "32|" + cLetra + cPipe + cDesconto + cFim
	EndIF
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
EndIF
IF lEcfRede
	cBuffer := '023' + cPipe
	cBuffer += cForma + cPipe
	cBuffer += cLiquido + cPipe
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	IF lNomeEcf
		cBuffer	  := '082' + cPipe + ;
		'Codigo..: ' + cCodiCliente + Chr(13) + Chr(10) +;
		'Cliente.: ' + cNomeCliente + Chr(13) + Chr(10) +;
		'Endereco: ' + cEndeCliente + Chr(13) + Chr(10) +;
		'Cidade..: ' + cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente + Chr(13) + Chr(10) + ;
		'Cgc/Cpf.: ' + cCgcCliente  + Chr(13) + Chr(10) + ;
		'Rg/IE...: ' + cRgCliente   + Chr(13) + Chr(10) + ;
		Repl("_", 48) + Chr(13) + Chr(10) + ;
		Padc(AllTrim( cRamoIni),48) + cPipe
		Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	Else
		cBuffer	  := '082' + cPipe + Padc(AllTrim( cRamoIni ),48) + cPipe
		Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	EndIF
Else
	cBuffer	  := cIni + "72|" + cForma + cPipe + cLiquido + cFim
	Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	IF lNomeEcf
		cBuffer	  := cIni + "34|" + ;
		'Codigo..: ' + cCodiCliente + Chr(13) + Chr(10) +;
		'Cliente.: ' + cNomeCliente + Chr(13) + Chr(10) +;
		'Endereco: ' + cEndeCliente + Chr(13) + Chr(10) +;
		'Cidade..: ' + cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente + Chr(13) + Chr(10) + ;
		'Cgc/Cpf.: ' + cCgcCliente  + Chr(13) + Chr(10) + ;
		'Rg/IE...: ' + cRgCliente   + Chr(13) + Chr(10) + ;
		Repl("_", 48) + Chr(13) + Chr(10) + ;
		Padc(AllTrim( cRamoIni),48) + Chr(13) + Chr(10) + cFim
		Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	Else
		cBuffer	  := cIni + "34|" + Padc(AllTrim( cRamoIni ),48) + Chr(13) + Chr(10) + cFim
		Comunica_Com_Impressora( nPorta, cBuffer, Retorno )
	EndIF
EndIF
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
ResTela( cScreen )
Return

Function BemaIniciaDriver()
***************************
LOCAL cScreen	:= SaveScreen()
LOCAL lEcfRede := oIni:ReadBool('ecf','ecfrede', FALSO )
LOCAL cPorta
LOCAL nHandle

IF !lEcfRede
	cPorta  := 'COM' + Str( oIni:ReadInteger('ecf', 'porta', 1 ), 1 )
	nHandle := Fopen( cPorta, FO_READWRITE + FO_COMPAT)
	IF Ferror () != 0
		FClose( nHandle )
		Alerta('Bematech : Problemas de gravacao para : ' + cPorta )
		ResTela( cScreen )
		Break
	EndIF
EndIF
Return( nHandle )

STATIC Proc ContratoCentral( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, aDpnr, aVcto, aVlrDup )
****************************************************************************************************************
LOCAL cScreen		:= SaveScreen()
LOCAL nTotal		:= 0
LOCAL nX 			:= 0
LOCAL nEntrada 	:= 0
LOCAL nFinanciado := 0
LOCAL Tam			:= 132
LOCAL nLinhas		:= 51
LOCAL nLen			:= Len( aVcto )
LOCAL cVendedor	:= Space(40)
LOCAL cMecanico	:= Space(40)
LOCAL nLargura 	:= 0
LOCAL cExtenso 	:= ''
LOCAL nCol			:= -1
LOCAL cCgc			:= ''
LOCAL cRg			:= ''

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCgc := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
cRg  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Rg,  Receber->Insc )
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr( 36 ))
FPrint( PQ )
SetPrc(0,0)
Write( nCol+01, 094, cFatu )
Write( nCol+18, 007, cCodi )
For nX := 1 To nLen
	IF( dEmis = aVcto[nx])
		nEntrada += aVlrDup[nx]
	EndIF
Next
nFinanciado := ( nLiquido - nEntrada )
Write( nCol+18, 070, nLiquido )
Write( nCol+18, 090, nEntrada )
Write( nCol+18, 120, nFinanciado )
Write( nCol+19, 007, cNomeCliente )
Write( nCol+20, 007, Receber->Ende )
IF nLen >= 1
	Write( nCol+20, 059, aDpnr[1]  )
	Write( nCol+20, 074, aVcto[1]  )
	Write( nCol+20, 082, aVlrDup[1])
	IF nLen >= 2
		Write( nCol+20, 100, aDpnr[2]  )
		Write( nCol+20, 115, aVcto[2]  )
		Write( nCol+20, 124, aVlrDup[2])
	EndIF
EndIF
Write( nCol+21, 007, Receber->Bair )
Write( nCol+21, 031, Receber->Cep )
IF nLen >= 3
	Write( nCol+21, 059, aDpnr[3]  )
	Write( nCol+21, 074, aVcto[3]  )
	Write( nCol+21, 082, aVlrDup[3])
	IF nLen >= 4
		Write( nCol+21, 100, aDpnr[4]  )
		Write( nCol+21, 115, aVcto[4]  )
		Write( nCol+21, 124, aVlrDup[4])
	EndIF
EndIF
Write( nCol+22, 007, Receber->Cida )
Write( nCol+22, 049, Receber->Esta )
IF nLen >= 5
	Write( nCol+22, 059, aDpnr[5]  )
	Write( nCol+22, 074, aVcto[5]  )
	Write( nCol+22, 082, aVlrDup[5])
	IF nLen >= 6
		Write( nCol+22, 100, aDpnr[6]  )
		Write( nCol+22, 115, aVcto[6]  )
		Write( nCol+22, 124, aVlrDup[6])
	EndIF
EndIF
Write( nCol+23, 007, cCgc )
Write( nCol+23, 040, cRg )
Write( nCol+24, 007, Receber->Conhecida )
Write( nCol+24, 116, cFatu )
Write( nCol+25, 007, Receber->Ende3 )
Write( nCol+25, 049, Receber->EstaAval )
Write( nCol+25, 110, nLen )
Write( nCol+26, 007, Receber->CidaAval )

nLargura := 62
cExtenso := Extenso( nFinanciado, 1, 2, nLargura )
Write( nCol+26, 074, Left( cExtenso, nLargura ))
Write( nCol+27, 007, Receber->BairAval )
Write( nCol+27, 074, Right( cExtenso, nLargura ))
Write( nCol+28, 007, Receber->CpfAval )
Write( nCol+28, 031, Receber->RgAval )
Write( nCol+28, 088, aDesconto[1])
Write( nCol+28, 108, Trim(Str(aDiasApos[1])))
Write( nCol+28, 129, aDescApos[1])
Write( nCol+30, 000, AllTrim(oAmbiente:xNomefir) )
Write( nCol+30, 080, Upper(DataExt1(Date())))
__Eject()
PrintOff()
xAlias->(DbClearRel())
xAlias->(DbGoTop())
Return

STATIC Proc ContratoSta( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
**********************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 00
LOCAL nTotal	 := 0
LOCAL Tam		 :=  CPI1280
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrint( _CPI12 )
FPrint( _SPACO1_8 )
SetPrc(0,0)
Write(	nCol, 00, "")
Write( ++nCol, 00, NG + Padc("CONTRATO PARTICULAR DE COMPRA E VENDA COM RESERVA DE DOMINIO - N§ " + cFatu, Tam ) + NR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "A " + AllTrim(oAmbiente:xNomefir) )
Write( ++nCol, 00, XENDEFIR + " - " + XCEPCIDA + " - " + XCESTA )
Write( ++nCol, 00, "CPF/CGC-MF :" + XCGCFIR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "por seu representante legal, doravante denominada simplesmente 'VENDEDORA' " + GD + "VENDE" + CA)
FPrint( _CPI12 )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "a(o) " + cNomeCliente )
Write( ++nCol, 00, AllTrim( Receber->Ende ) + " - " + Receber->Bair + " - " + Receber->Cep + "/" + Receber->(AllTrim( Cida )) + " - " + Receber->Esta )
Write( ++nCol, 00, "CPF/CGC-MF : " + IF( Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 ), Receber->Cpf, Receber->Cgc ))
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "doravante denominado simplesmente 'COMPRADOR' por este contrato  elaborado  e firmado em (02)")
Write( ++nCol, 00, "vias de igual teor e forma, com 'RESERVA DE DOMINIO', as seguintes mercadorias:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "CODIGO DESCRICAO DO PRODUTO                     MARCA      MODELO               QTDE")
Lista->(Order( LISTA_CODIGO ))
Area("SAIDAS")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Saidas->Codigo Into Lista
Saidas->(DbSeek( cFatu ))
While Saidas->Fatura = cFatu
	nPreco := Saidas->Pvendido
	Qout( Saidas->Codigo, Lista->Descricao, Lista->Sigla, Lista->N_Original, Saidas->Saida )
	nCol++
	Saidas->(DbSkip(1))
Enddo
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "de propriedade da 'VENDEDORA', mediante as clausulas e condicoes seguintes:")
nCol++
Write( ++nCol, 00, NG + "PRIMEIRA: " + NR + "A 'VENDEDORA' ampara-se na clausula 'RESERVAT DOMINI'.")
nCol++
Write( ++nCol, 00, NG + "SEGUNDA: " + NR + "O preco de venda e de R$ " + AllTrim( Tran( nLiquido, "@E 999,999,999.99")) + " cujo pagamento o COMPRADOR se obriga a realizar")
Write( ++nCol, 00, "do seguinte modo:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "N§ DOCTO  VENCIMENTO       VALOR OBS                 N§ DOCTO  VENCIMENTO       VALOR OBS")
nLen := Len( Dpnr )
nSoma := 0
nSum	:= 1
For nY := 1 To nLen
	IF nSum = 1
		Qout( Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 0
		nCol++
	Else
		QQout( Space(12), Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"), "_______" )
		nSum := 1
	EndIF
	nSoma += VlrDup[nY]
Next
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "com emissao de titulos da VENDEDORA e aceite do COMPRADOR, avalizada, em favor da 'VENDEDORA'")
Write( ++nCol, 00, "as quais ficam fazendo parte integral no presente instrumento.")
nCol++
Write( ++nCol, 00, NG + "TERCEIRA: " + NR + "Por forca do pacto de reserva de dominio, aqui expressamente instituido, e  aceito")
Write( ++nCol, 00, "pelas partes, fica reservado a VENDEDORA a propriedade do(s) objeto(s) descrito(s) no  inicio")
Write( ++nCol, 00, "do presente contrato, ate que se liquida a ultima das prestacoes acima mencionadas.")
nCol++
Write( ++nCol, 00, NG + "QUARTA: " + NR + "Em consequencia do disposto na Clausula precedente, caso faltar o COMPRADOR, ao pon-")
Write( ++nCol, 00, "tual pagamento de qualquer prestacao, a VENDEDORA podera executar os titulos, protestar,  mo-")
Write( ++nCol, 00, "ver ACAO DE BUSCA E APREENSAO, e ficara desde logo, constituido em mora e obrigado sob as pe-")
Write( ++nCol, 00, "nas da Lei, devolver 'incontinenti', o(s) objeto(s) condicionalmente comprados, devolucao que")
Write( ++nCol, 00, "se fara amigavelmente ou em juizo, perdendo o COMPRADOR em favor da VENDEDORA, toda a  impor-")
Write( ++nCol, 00, "tancia ja paga.")
nCol++
Write( ++nCol, 00, NG + "QUINTA: " + NR + "A 'VENDEDORA' declara, para todos os fins de direito que as mercadorias ora vendidas")
Write( ++nCol, 00, "sao de 1§ qualidade, e apropriada para o fim que se destina.")
nCol++
Write( ++nCol, 00, NG + "SEXTA: " + NR + "Na vigencia deste contrato nao podera o 'COMPRADOR' alienar sob  qualquer  forma, dar")
Write( ++nCol, 00, "a penhora, transferir ou ceder a terceiros as mercadorias  objeto  do  presente, sob pena  de")
Write( ++nCol, 00, "responder penalmente.")
nCol++
Write( ++nCol, 00, NG + "SETIMA: " + NR + "A 'VENDEDORA' e assegurado o direito de  vistoriar  as  mercadorias ora  vendidas, a")
Write( ++nCol, 00, "qualquer momento, e o 'COMPRADOR' com o direito de uso em raso, nao se exime da  obrigacao de")
Write( ++nCol, 00, "conserva-las assistindo a 'VENDEDORA' o direito de propor medidas judiciais cautelatorias  em")
Write( ++nCol, 00, "caso de mau uso ou ma conservacao das mercadorias.")
nCol++
Write( ++nCol, 00, NG + "OITAVA: " + NR + "Um dos requisitos para aquisicao da mercadoria nessas condicoes, e de que o  compra-")
Write( ++nCol, 00, "dor seja empregado da empresa, o qual desde ja autoriza a debitar em sua conta as parcelas.")
nCol++
Write( ++nCol, 00, NG + "PARAGRAFO UNICO : " + NR + "Quando da rescisao do contrato de trabalho, dar-se-a como vencidas   todas")
Write( ++nCol, 00, "as prestacoes, as quais autoriza desde ja a descontar em rescisao.")
nCol++
Write( ++nCol, 00, NG + "NONA : " + NR + "Aos casos omissos sera aplicada subsidiariamente a norma cabivel na legislacao em vi-")
Write( ++nCol, 00, "gor. Para dirimir quaisquer duvidas oriundas deste contrato, fica eleito o foro da comarca de:")
Write( ++nCol, 00,  XCCIDA + " - " + XCESTA + " com renuncia de qualquer outra, por mais previlegiada que seja.")
nCol++
Write( ++nCol, 00, "             E por estarem justos e contratados, assinam o presente em duas vias de igual teor")
Write( ++nCol, 00, "e forma, que apos lido e achado conforme, na presenca de testemunhas, vair assinado por todos,")
Write( ++nCol, 00, "para que surta seus juridicos e legais efeitos.")
nCol++
Write( ++nCol, 00, DataExt( Date()))
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + AllTrim(oAmbiente:xNomefir) )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + cNomeCliente )
nCol++
Write( ++nCol, 00, "TESTEMUNHA" + Repl("_", 25) + Space(10) + Repl("_", Tam/2 ))
Write( ++nCol, 00, Space(45) + "AVAL " + Receber->Conhecida )
__Eject()
PrintOff()
Saidas->(DbClearRel())
Saidas->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
Return

Proc DetalheCaixa( cCaixa, lDetalhe, nOpcao )
*********************************************
LOCAL GetList			 := {}
LOCAL aTodos			 := {}
LOCAL cScreen			 := SaveScreen()
LOCAL Arq_Ant			 := Alias()
LOCAL Ind_Ant			 := IndexOrd()
LOCAL xNtx				 := FTempName("T*.TMP")
LOCAL nRolCaixa		 := oIni:ReadInteger('relatorios','rolcaixa', 1 )
LOCAL nTipoCaixa		 := oIni:ReadInteger('relatorios','tipocaixa', 2 )
LOCAL nPartida 		 := oIni:ReadInteger('relatorios','rolcontrapartida', 2 )
LOCAL cString			 := IF( nTipoCaixa = 1, "TIPO:NORMAL", "TIPO:ORDEM BAIXA")
LOCAL lVisualizarDetalheCaixa := oSci:ReadBool('permissao','visualizardetalhecaixa', OK )
LOCAL nChemovDh		 := 0
LOCAL nChemovNp		 := 0
LOCAL nChemovDm		 := 0
LOCAL nChemovCh		 := 0
LOCAL nChemovRq		 := 0
LOCAL nChemovBn		 := 0
LOCAL nChemovCp		 := 0
LOCAL nChemovDf		 := 0
LOCAL nChemovDl		 := 0
LOCAL nChemovCt		 := 0
LOCAL nChemovPg		 := 0
LOCAL nChemovRc		 := 0
LOCAL nChemovCc		 := 0
LOCAL nChemovOu		 := 0
LOCAL nChemovDeb		 := 0
LOCAL nChemovCre		 := 0
LOCAL nRecemovDh		 := 0
LOCAL nRecemovNp		 := 0
LOCAL nRecemovDm		 := 0
LOCAL nRecemovCh		 := 0
LOCAL nRecemovRq		 := 0
LOCAL nRecemovBn		 := 0
LOCAL nRecemovCp		 := 0
LOCAL nRecemovDf		 := 0
LOCAL nRecemovDl		 := 0
LOCAL nRecemovCt		 := 0
LOCAL nRecemovPg		 := 0
LOCAL nRecemovRc		 := 0
LOCAL nRecemovCc		 := 0
LOCAL nRecemovOu		 := 0
LOCAL nRecemovDeb 	 := 0
LOCAL nRecemovCre 	 := 0
LOCAL nRecebido		 := 0
LOCAL nDescAbat		 := 0
LOCAL Pagina			 := 0
LOCAL nTamArray		 := 0
LOCAL Col				 := 6
LOCAL Tam				 := 132
LOCAL dIni				 := Date()
LOCAL dFim				 := Date()
LOCAL nDif				 := 0
LOCAL nDf				 := 0
LOCAL dData
LOCAL dVcto
LOCAL dDataPag
LOCAL cDeleteFile
LOCAL cSp
LOCAL nVr
LOCAL nSaldo
LOCAL cTitular
LOCAL oBloco1
LOCAL oBloco2
LOCAL xVista	 := "A"
LOCAL xRecebido := "B"
LOCAL xPago 	 := "C"
LOCAL xFaturado := "D"
LOCAL xOutros	 := "E"
LOCAL cPosicao  := ""
LOCAL aTipo 	 := Array(13)
LOCAL cParcial  := "Q"
LOCAL cConta	 := '0000'
LOCAL cFatura
LOCAL cTipo
FIELD Caixa
FIELD Tipo
FIELD Cre
FIELD Deb
FIELD Data
FIELD Hist
FIELD Docnr
FIELD Codi
FIELD Vlr
FIELD Vcto

oMenu:Limpa()
IF nOpcao = NIL
	IF cCaixa = Nil
		cCaixa := Space(4)
		IF !VerSenha( @cCaixa )
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return
		EndIF
	EndIF
EndIF
IF lDetalhe = Nil
	lDetalhe := OK
EndIF
IF !lVisualizarDetalheCaixa
	IF !PedePermissao( SCI_VISUALIZAR_DETALHE_CAIXA )
		Restela( cScreen )
		Return
	EndIF
EndIF
MaBox( 10, 10, 13, 37 )
@ 11, 11 Say "Data Inicial : " Get dIni Pict PIC_DATA
@ 12, 11 Say "Data Final   : " Get dFim Pict PIC_DATA Valid dFim >= dIni
Read
IF LasTkey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return
EndIF
IF nOpcao = NIL
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	Vendedor->(DbSeek( cCaixa ))
	cTitular := Vendedor->Nome
Else
	Cheque->(Order( CHEQUE_CODI ))
	Cheque->(DbSeek( cConta ))
	cCaixa	:= cConta
	cTitular := Cheque->Titular
EndIF
IF nTipoCaixa = 1
	oBloco1 := {|| Chemov->Data >= dIni .AND. Chemov->Data <= dFim }
Else
	oBloco1 := {|| Chemov->Baixa >= dIni .AND. Chemov->Baixa <= dFim }
EndIf
oBloco2 := {|| Recemov->Emis >= dIni .AND. Recemov->Emis <= dFim }
cIni	  := Dtoc( dIni )
cFim	  := Dtoc( dFim )
IF lDetalhe
	cTitulo	:= "DETALHE DO MOVIMENTO DO CAIXA " + cCaixa + " - " + Trim( cTitular ) + " REF &cIni. A &cFim. " + cString
Else
	cTitulo	:= "RESUMO DO MOVIMENTO DO CAIXA " + cCaixa + " - " + Trim( cTitular ) + " REF &cIni. A &cFim. " + cString
EndIF
Mensagem("Aguarde... Verificando Movimento.", Cor())
cDeleteFile := CaixaNew()
Select xDbfCaixa				 // Seleciona o arquivo temporario
Index On Posicao + Tipo + Docnr To ( xNtx )
Saidas->(Order( SAIDAS_FATURA ))
Recebido->(Order( RECEBIDO_DOCNR ))
Area("Chemov")
Chemov->(Order( IF( nTipoCaixa = 1, CHEMOV_CODI_DATA, CHEMOV_CODI_BAIXA )))
nDiferenca := ( dFim - dIni )
IF nDiferenca = 0
	lAchou := Chemov->(DbSeek( cConta + DateToStr( dIni )))
Else
	lAchou := Chemov->(DbSeek( cConta + DateToStr( dIni )))
	IF !lAchou
		For nT := 1 To nDiferenca
			IF (lAchou := Chemov->(DbSeek( cConta + DateToStr( dIni + nT ))))
				Exit
			EndIF
		Next
	EndiF
EndiF
aTipo := Array(13)
Afill( aTipo, 0 )
IF lAchou
	WHILE Eval( oBloco1 ) .AND. Rel_Ok()
		IF nRolCaixa = 2
			cFatura := Chemov->Fatura
			IF Saidas->(DbSeek( cFatura ))
				IF !Saidas->Impresso
					Chemov->(DbSkip(1))
					Loop
				EndIf
			EndIf
		EndIf
		IF nPartida = 1 // Sem Contra Partida
			IF Chemov->CPartida
				Chemov->(DbSkip(1))
				Loop
			EndIf
		EndIf
		IF Chemov->Codi != cConta
			Chemov->(DbSkip(1))
			Loop
		EndIf
		IF nOpcao = NIL
			IF Chemov->Caixa != cCaixa
				Chemov->(DbSkip(1))
				Loop
			EndIF
		Else
			IF Chemov->(Empty( Caixa ))
				Chemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF 	 "DH" $ Chemov->Tipo // Dinheiro
			nChemovDh += Chemov->Cre
			nChemovDh -= Chemov->Deb
			cPosicao  := xRecebido
			aTipo[1]++
		ElseIF "NP" $ Chemov->Tipo // Nota Promissoria
			nChemovNp += Chemov->Cre
			nChemovNp -= Chemov->Deb
			cPosicao  := xRecebido
			aTipo[2]++
		ElseIF "DM" $ Chemov->Tipo // Duplicata Mercantil
			nChemovDm += Chemov->Cre
			nChemovDm -= Chemov->Deb
			cPosicao  := xRecebido
			aTipo[3]++
		ElseIF "CH" $ Chemov->Tipo // Cheques a vista
			nChemovCh += Cre
			nChemovCh -= Deb
			cPosicao := xRecebido
			aTipo[4]++
		ElseIF "RQ" $ Chemov->Tipo // Recebimentos
			nChemovRq += Chemov->Cre
			nChemovRq -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[5]++
		ElseIF "BN" $ Chemov->Tipo // Recebimentos
			nChemovBn += Chemov->Cre
			nChemovBn -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[6]++
		ElseIF "CP" $ Chemov->Tipo // Recebimentos
			nChemovCp += Chemov->Cre
			nChemovCp -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[7]++
		ElseIF "DF" $ Chemov->Tipo // Descontos Abatimentos
			Chemov->(DbSkip(1))
			Loop
		ElseIF "DL" $ Chemov->Tipo // Direta Livre
			nChemovDl += Chemov->Cre
			nChemovDl -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[8]++
		ElseIF "CT" $ Chemov->Tipo // Cartao
			nChemovCt += Chemov->Cre
			nChemovCt -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[9]++
		ElseIF "PG" $ Chemov->Tipo // Pagamentos
			nChemovDeb += Chemov->Deb
			nChemovDeb -= Chemov->Cre
			cPosicao := xPago
			aTipo[10]++
		ElseIF "RC" $ Chemov->Tipo // Recebimentos
			nChemovRc += Chemov->Cre
			nChemovRc -= Chemov->Deb
			cPosicao := xRecebido
			aTipo[11]++
		ElseIF "CC" $ Chemov->Tipo // Conta Corrente
			nChemovCC += Chemov->Deb // Isso Mesmo
			nChemovCC -= Chemov->Cre // Isso Mesmo
			cPosicao := xRecebido
			aTipo[12]++
		Else
			nChemovOu += Cre
			nChemovOu -= Deb
			cPosicao := xOutros
			aTipo[13]++
		EndIF
		nVlr		:= 0
		cDocnr	:= Chemov->Docnr
		dData 	:= Chemov->Data
		dEmis 	:= Chemov->Data
		dVcto 	:= Chemov->Data
		cTipo 	:= Chemov->Tipo
		cParcial := "Q"
		IF Recebido->(DbSeek( cDocnr ))
			nVlr		 := Recebido->Vlr
			WHILE Recebido->Docnr = cDocNr
				IF Recebido->VlrPag = Chemov->Cre .OR. Recebido->VlrPag = Chemov->Deb
					nVlr		 := Recebido->Vlr
					dEmis 	 := Recebido->Emis
					dVcto 	 := Recebido->Vcto
					dData 	 := Recebido->DataPag
					cParcial  := Recebido->Parcial
				EndIF
				Recebido->(DbSkip(1))
			EndDo
		Else
			nVlr := IF( Cre = 0, Deb, Cre )
		EndIF
		IF dVcto == dData .AND. dEmis == dData .AND. dVcto == dIni .AND. cTipo <> 'PG' .AND. cTipo <> 'OU'
			cPosicao := xVista
		EndIF
		xDbfCaixa->(DbAppend())
		xDbfCaixa->Tipo	 := Tipo
		xDbfCaixa->Posicao := cPosicao
		xDbfCaixa->Vcto	 := dVcto
		xDbfCaixa->Data	 := dData
		xDbfCaixa->Nome	 := Hist
		xDbfCaixa->Docnr	 := Docnr
		xDbfCaixa->Deb 	 := Deb
		xDbfCaixa->Cre 	 := Cre
		xDbfCaixa->Vlr 	 := nVlr
		xDbfCaixa->Fatura  := IF( Empty(Fatura), Docnr, Fatura )
		xDbfCaixa->Caixa	 := Caixa
		xDbfCaixa->Parcial := cParcial
		Chemov->(DbSkip(1))
	EndDo
EndIF
Receber->(Order( RECEBER_CODI ))
Area("Recemov")
Recemov->(Order( RECEMOV_EMIS))
Set Rela To Codi Into Receber
IF nDiferenca = 0
	lAchou := DbSeek( dIni )
Else
	lAchou := DbSeek( dIni )
	IF !lAchou
		For nT := 1 To nDiferenca
			IF (lAchou := DbSeek( dIni + nT ))
				Exit
			EndIF
		Next
	EndiF
EndiF
IF lAchou
	WHILE Eval( oBloco2 ) .AND. Rel_Ok()
		IF nRolCaixa = 2
			cFatura := Recemov->Fatura
			IF Saidas->(DbSeek( cFatura ))
				IF !Saidas->Impresso
					Recemov->(DbSkip(1))
					Loop
				EndIf
			EndIf
		EndIF
		IF nOpcao = NIL
			IF Recemov->Caixa != cCaixa
				Recemov->(DbSkip(1))
				Loop
			EndIF
		Else
			IF Recemov->(Empty( Caixa ))
				Recemov->(DbSkip(1))
				Loop
			EndIF
		EndIF
		IF 	 "NP" $ Recemov->Tipo // Nota Promissoria
			nRecemovNp += Vlr
			aTipo[2]++
		ElseIF "DH" $ Recemov->Tipo // Vendas a Vista
			nRecemovDh += Vlr
			aTipo[1]++
		ElseIF "DM" $ Recemov->Tipo  // Duplicata Mercantil
			nRecemovDm += Vlr
			aTipo[3]++
		ElseIF "CH" $ Recemov->Tipo  //  Cheque a Vista
			nRecemovCh += Vlr
			aTipo[4]++
		ElseIF "RQ" $ Recemov->Tipo  // Requisicao
			nRecemovRq += Vlr
			aTipo[5]++
		ElseIF "BN" $ Recemov->Tipo  // Bonus
			nRecemovBn += Vlr
			aTipo[6]++
		ElseIF "CP" $ Recemov->Tipo // Cheque Pre-Datado
			nRecemovCp += Vlr
			aTipo[7]++
		ElseIF "DL" $ Recemov->Tipo  // Direta Livre
			nRecemovDl += Vlr
			aTipo[8]++
		ElseIF "CT" $ Recemov->Tipo  // Cartao
			nRecemovCt += Vlr
			aTipo[9]++
		Else
			nRecemovOu += Vlr
			aTipo[13]++
		EndIF
		cPosicao := xFaturado
		dData 	:= Vcto
		dVcto 	:= Vcto
		xDbfCaixa->(DbAppend())
		xDbfCaixa->Tipo	 := Tipo
		xDbfCaixa->Posicao := cPosicao
		xDbfCaixa->Data	 := Ctod("")
		xDbfCaixa->Vcto	 := dVcto
		xDbfCaixa->Nome	 := Receber->Nome
		xDbfCaixa->Docnr	 := Docnr
		xDbfCaixa->Deb 	 := 0
		xDbfCaixa->Cre 	 := Vlr
		xDbfCaixa->Vlr 	 := Vlr
		xDbfCaixa->Fatura  := Fatura
		xDbfCaixa->Caixa	 := Caixa
		xDbfCaixa->Parcial := "Q"
		Recemov->(DbSkip(1))
	EndDo
EndIF
IF xDbfCaixa->(Lastrec()) > 0
	IF !Instru80()
		xDbfCaixa->(DbCloseArea())
		Ferase( cDeleteFile )
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo Caixa.", Cor())
	PrintOn()
	FPrint( PQ )
	SetPrc(0,0)
	CabecCaixa( ++Pagina, Tam, cTitulo, cCaixa, cTitular )
	IF lDetalhe
		Write( 06, 00,"TIPO   ORC/FAT   VENCTO   PAGTO    HISTORICO/CLIENTE                DOCTO N§       NOMINAL       DEBITO      CREDITO         DF   CX")
		Write( 07, 00, Repl( SEP, Tam ))
		Col := 10
	Else
		Col := 08
	EndIF
	IF lDetalhe
		xDbfCaixa->(DbGoTop())
		nTotalDif	 := 0
		nTotalTipo	 := 0
		nQtDocumento := 0
		nTotalDeb	 := 0
		nTotalCre	 := 0
		nTemp 		 := 0
		xUltPos		 := xDbfCaixa->Posicao
		WHILE xDbfCaixa->(!Eof()) .AND. Rel_Ok()
			IF Col >= 58
				__Eject()
				CabecCaixa( ++Pagina, Tam, cTitulo, cCaixa, cTitular )
				Write( 08, 00,"TIPO   ORC/FAT   VENCTO   PAGTO    HISTORICO/CLIENTE                DOCTO N§       NOMINAL       DEBITO      CREDITO         DF   CX")
				Write( 09, 00, Repl( SEP, Tam ))
				Col := 10
			EndIF
			IF xUltPos != xDbfCaixa->Posicao
				Qout()
				Qout( xNome + " = " + StrZero( nQtDocumento, 4 ), "LCTOS", Space(51), Tran( nTotalTipo, "@E 9,999,999.99"), Tran( nTotalDeb, "@E 9,999,999.99"), Tran( nTotalCre, "@E 9,999,999.99"), Tran( nTotalDif, "@E 999,999.99"))
				xUltPos		 := xDbfCaixa->Posicao
				nQtDocumento := 0
				nTotalDif	 := 0
				nTotalTipo	 := 0
				nTotalDeb	 := 0
				nTotalCre	 := 0
				nTemp 		 := 0
				Qout( Repl( SEP, Tam ))
				Col++
				Col++
			EndIF
			nTemp += xDbfCaixa->Cre
			nTemp -= xDbfCaixa->Deb
			nDif	:= 0
			IF xDbfCaixa->Cre = 0
				IF xDbfCaixa->Parcial = "Q"
					nDif := xDbfCaixa->Deb - XDbfCaixa->Vlr
				EndiF
			Else
				IF xDbfCaixa->Parcial = "Q"
					nDif := xDbfCaixa->Cre - XDbfCaixa->Vlr
				EndIF
			EndIF
			nDf += nDif
			xDbfCaixa->( Qout( Tipo, Fatura, Vcto, Data, Left( Nome, 31), Docnr, Tran( Vlr, "@E 9,999,999.99") + Parcial,  Tran( Deb,"@E 9,999,999.99"), Tran( Cre, "@E 9,999,999.99"), Tran( nDif, "@E 999,999.99"), Caixa ))
			nQtDocumento++
			nTotalDif  += nDif
			nTotalTipo += xDbfCaixa->Vlr
			nTotalDeb  += xDbfCaixa->Deb
			nTotalCre  += xDbfCaixa->Cre
			Col++
			IF xDbfCaixa->Posicao	  == "A"
				xNome := "RECEB VISTA "
			ElseIF xDbfCaixa->Posicao == "B"
				xNome := "RECEB PRAZO "
			ElseIF xDbfCaixa->Posicao == "C"
				xNome := "PAGAMENTOS  "
			ElseIF xDbfCaixa->Posicao == "D"
				xNome := "VENDAS      "
			ElseIF xDbfCaixa->Posicao == "E"
				xNome := "OUTROS      "
			EndIF
			xDbfCaixa->(DbSkip(1))
		EndDo
		Qout()
		Qout( xNome + " = " + StrZero( nQtDocumento, 4 ), "LCTOS", Space(51), Tran( nTotalTipo, "@E 9,999,999.99"), Tran( nTotalDeb, "@E 9,999,999.99"), Tran( nTotalCre, "@E 9,999,999.99"), Tran( nTotalDif, "@E 999,999.99"))
		nQtDocumento := 0
		nTotalDif	 := 0
		nTotalTipo	 := 0
		nTotalDeb	 := 0
		nTotalCre	 := 0
		nTemp 		 := 0
		Qout( Repl( SEP, Tam ))
		Col++
		Col++
	EndIF
	nRecebimentos := ( nChemovDh + nChemovNp + nChemovDm + nChemovCh + nChemovRq + nChemovBn + nChemovCp + nChemovDl + nChemovCt + nChemovRc )
	nReceber 	  := ( nRecemovDh + nRecemovNp + nRecemovDm + nRecemovCh + nRecemovRq + nRecemovBn + nRecemovCp + nRecemovDl + nRecemovCt + nRecemovRc )
	nPagamentos   := nChemovDeb
	nSaldoChemov  := ( nRecebimentos + nChemovOu ) - nPagamentos
	nSaldoRecemov := ( nReceber		+ nRecemovOu )
	nEspacos 	  := 30
	Qout()
	Qout( Padc( NG + "RESUMO DA OPERACOES DE CAIXA" + NR, Tam ))
	Qout( Repl( SEP, Tam ))
	Qout("DESCRICAO                 DOCTS           RECEBIDO          A RECEBER              TOTAL")
	Qout( Repl( SEP, Tam ))
	Qout("DINHEIRO..............{DH}", Tran( aTipo[1], "9999"), Tran( nChemovDh,  "@E 999,999,999,999.99"), Tran( nRecemovDh,  "@E 999,999,999,999.99"),Tran( nChemovDh+nRecemovDh,  "@E 999,999,999,999.99"))
	Qout("NOTAS PROMISSORIAS....{NP}", Tran( aTipo[2], "9999"), Tran( nChemovNp,  "@E 999,999,999,999.99"), Tran( nRecemovNp,  "@E 999,999,999,999.99"),Tran( nChemovNp+nRecemovNp,  "@E 999,999,999,999.99"))
	Qout("DUPLICATAS............{DM}", Tran( aTipo[3], "9999"), Tran( nChemovDm,  "@E 999,999,999,999.99"), Tran( nRecemovDm,  "@E 999,999,999,999.99"),Tran( nChemovDm+nRecemovDm,  "@E 999,999,999,999.99"))
	Qout("CHEQUES A VISTA.......{CH}", Tran( aTipo[4], "9999"), Tran( nChemovCh,  "@E 999,999,999,999.99"), Tran( nRecemovCh,  "@E 999,999,999,999.99"),Tran( nChemovCh+nRecemovCh,  "@E 999,999,999,999.99"))
	Qout("REQUISICOES...........{RQ}", Tran( aTipo[5], "9999"), Tran( nChemovRq,  "@E 999,999,999,999.99"), Tran( nRecemovRq,  "@E 999,999,999,999.99"),Tran( nChemovRq+nRecemovRq,  "@E 999,999,999,999.99"))
	Qout("BONUS.................{BN}", Tran( aTipo[6], "9999"), Tran( nChemovBn,  "@E 999,999,999,999.99"), Tran( nRecemovBn,  "@E 999,999,999,999.99"),Tran( nChemovBn+nRecemovBn,  "@E 999,999,999,999.99"))
	Qout("CHEQUES PRE-DATADOS...{CP}", Tran( aTipo[7], "9999"), Tran( nChemovCp,  "@E 999,999,999,999.99"), Tran( nRecemovCp,  "@E 999,999,999,999.99"),Tran( nChemovCp+nRecemovCp,  "@E 999,999,999,999.99"))
	Qout("DIRETA LIVRE..........{DL}", Tran( aTipo[8], "9999"), Tran( nChemovDl,  "@E 999,999,999,999.99"), Tran( nRecemovDl,  "@E 999,999,999,999.99"),Tran( nChemovDl+nRecemovDl,  "@E 999,999,999,999.99"))
	Qout("CARTAO................{CT}", Tran( aTipo[9], "9999"), Tran( nChemovCt,  "@E 999,999,999,999.99"), Tran( nRecemovCt,  "@E 999,999,999,999.99"),Tran( nChemovCt+nRecemovCt,  "@E 999,999,999,999.99"))
	Qout("CONTA CORRENTE........{CC}", Tran( aTipo[12], "9999"), Tran( nChemovCC,  "@E 999,999,999,999.99"), Tran( nRecemovCC,  "@E 999,999,999,999.99"),Tran( nChemovCc+nRecemovCc,  "@E 999,999,999,999.99"))
	Qout( Repl( SEP, Tam ))
	Qout("ENTRADAS..............{++}", Space(04), Tran( nRecebimentos, "@E 999,999,999,999.99"), Tran( nReceber,     "@E 999,999,999,999.99"), Tran( nRecebimentos+nReceber,      "@E 999,999,999,999.99"))
	Qout("ENT/SAIDAS OUTROS.....{-+}", Tran( aTipo[13], "9999"), Tran( nChemovOu,     "@E 999,999,999,999.99"), Tran( nRecemovOu,   "@E 999,999,999,999.99"), Tran( nChemovOu+nRecemovOu,        "@E 999,999,999,999.99"))
	Qout("PAGAMENTOS............{--}", Tran( aTipo[10], "9999"), Tran( nChemovDeb,    "@E 999,999,999,999.99"), Tran( nRecemovDeb, "@E 999,999,999,999.99"),  Tran( nChemovDeb+nRecemovDeb,      "@E 999,999,999,999.99"))
	Qout( Repl("=", Tam ))
	Qout("SALDO CAIXA...........{==}", Space(04), Tran( nSaldoChemov,  "@E 999,999,999,999.99"), Tran( nSaldoRecemov,"@E 999,999,999,999.99"), Tran( nSaldoChemov + nSaldoRecemov,"@E 999,999,999,999.99"))
	Qout("DESC/ABAT/SOBRAS......{##}", Space(04), Tran( nDf,           "@E 999,999,999,999.99"))
	__Eject()
	PrintOff()
EndIF
Recemov->(DbClearRel())
Recemov->(DbGoTop())
xDbfCaixa->(DbCloseArea())
Ferase( cDeleteFile )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Proc SeparaPrevenda()
**********************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL aFatuTemp	 := {}
LOCAL aFatura		 := {}
LOCAL aRegis		 := {}
LOCAL aRegiTemp	 := {}
LOCAL dIni			 := Date()-30
LOCAL dFim			 := Date()
LOCAL nRecno		 := 0
LOCAL nItens		 := 0
LOCAL nConta		 := 0
LOCAL nContaFatura := 0
LOCAL nTamanho 	 := 0
LOCAL cRegiao		 := Space(02)
LOCAL cFatura		 := Space(07)
LOCAL nChoice		 := 1
LOCAL Col			 := 0
LOCAL nQuant
LOCAL cSigla
LOCAL cDescricao
LOCAL cCodi
LOCAL cNome
LOCAL bBloco
LOCAL cTela
LOCAL cRelato
LOCAL nTam
LOCAL Pos1
LOCAL Line
LOCAL nPagina
LOCAL Ok
LOCAL Tot_Reg
LOCAL nReg
LOCAL nSobra
LOCAL Escolha
LOCAL aCodigo
LOCAL cCodigo
LOCAL cDesc
LOCAL nPrevenda
LOCAL cCabecalho
LOCAL PosCur
LOCAL nX
LOCAL nPos
FIELD Codigo
FIELD Saida
#Define DEFPREVENDA 3
#Define DEFQUANT	  4
#Define DEFVENDIDA  6

BuscaPrevenda( @aFatuTemp, @aFatura, @aRegis, @aRegiTemp, "RELACAO DE SEPARACAO" )
IF ( nTamanho := Len( aFatura )) > 0
	oMenu:Limpa()
	ErrorBeep()
	IF Conf("Pergunta: Imprimir Relacao de Separacao ?" )
		IF !InsTru80() .OR. !LptOk()
			ResTela( cScreen )
			Return
		EndIF
		Lista->(Order( LISTA_CODIGO ))
		Prevenda->(Order( PREVENDA_FATURA ))
		Prevenda->(DbGoTop())
		aCodigo	 := {}
		cDesc 	 := {}
		cTela 	 := SaveScreen()
		Mensagem("Aguarde, Somando.", Cor())
		cRelato	  := "RELACAO DE PRODUTOS PARA SEPARACAO - PREVENDA"
		cCabecalho := "CODIGO|DESCRICAO DO PRODUTO                     FORNECEDOR| ESTOQUE | VENDIDO | PREVENDA| DIFER PV| DIF TOTAL"
		nTam		  := 132
		Line		  := 08
		nPagina	  := 00
		PosCur	  := 00
		nTamanho   := Len( aFatura )
		For nX := 1 To nTamanho
			nRecno := aRegis[ nX ]
			Prevenda->(DbGoTo( nRecno ))
			bBloco := {|| Prevenda->Fatura = aFatura[ nX ] }
			While Prevenda->(Eval( bBloco ))
				cCodigo	  := Prevenda->Codigo
				nPrevenda  := Prevenda->Saida
				nQuant	  := 0
				nVendida   := 0
				cDescricao := Lista->(Space(Len( Descricao )))
				cSigla	  := Lista->(Space(Len( Sigla 	 )))
				IF ( nPos := Ascan2( aCodigo, cCodigo, 1 )) = 0 // Nao Encontrado ? Inclui.
					IF Lista->(DbSeek( cCodigo ))
						nVendida   := Lista->Vendida
						nQuant	  := Lista->Quant
						cDescricao := Lista->Descricao
						cSigla	  := Lista->Sigla
					EndIF
					Aadd( aCodigo, { cCodigo, cDescricao, nPrevenda, nQuant, cSigla, nVendida } )
				Else
				  aCodigo[ nPos, DEFPREVENDA ] += nPrevenda
				EndIF
				Prevenda->(DbSkip(1))
			EndDo
		Next
		Asort( aCodigo,,, {| x, y | y[2] > x[2] } )
		Mensagem("Aguarde, Somando e Imprimindo.", Cor())
		PrintOn()
		FPrint( PQ )
		SetPrc( 0, 0 )
		Cabec002( ++nPagina, cRelato, nTam, cCabecalho)
		For nX := 1 To Len( aFatura )
			IF Poscur >= 128
				Poscur := 0
				Line++
			 EndIF
			 Write( Line, PosCur, NG + aFatura[nX] + NR )
			 PosCur += 8
		Next
		Line += 2
		For nX := 1 To Len( aCodigo )
			IF Line >=	58
				__Eject()
				Cabec002( ++nPagina, cRelato, nTam, cCabecalho)
				Line := 8
			EndIF
			nDif := aCodigo[nX,DEFVENDIDA] - aCodigo[nX,DEFPREVENDA]
			Qout( aCodigo[ nX,1 ],;
			Ponto( aCodigo[ nX,2 ],40),;
			Left( aCodigo[nX,5], 14),;
			StrZero( aCodigo[nX,DEFQUANT],9,2),;
			StrZero( nDif, 9, 2 ),;
			StrZero( aCodigo[nX,DEFPREVENDA],9,2),;
			StrZero(aCodigo[nX,DEFQUANT] - aCodigo[nX,DEFPREVENDA], 9, 2 ),;
			StrZero(aCodigo[nX,DEFQUANT] - nDif - aCodigo[nX,DEFPREVENDA], 9, 2 ))
			Line ++
		Next
		__Eject()
		PrintOff()
		ResTela( cTela )
	EndIF
EndIF
ResTela( cScreen )
Return

Proc Fechar_Sigtron()
*********************
LOCAL cBuffer := Space(134)
LOCAL nPorta  := SigTronIniciaDrive(cBuffer)
LOCAL cTela

oMenu:Limpa()
cTela   := Mensagem("Aguarde, Fechando Ultimo Cupom Fiscal.")
cBuffer := Chr(27) + Chr(241)
cBuffer += '1000000000000'
cBuffer += Chr(255)
FWrite( nPorta, @cBuffer, Len( cBuffer ))

cBuffer := Chr(27) + Chr(242)
cBuffer += 'A000000000000'
cBuffer += Chr(255)
FWrite( nPorta, @cBuffer, Len( cBuffer ))

cBuffer := Chr(27) + Chr(243)
cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
cBuffer += '*** FECHAMENTO FORCADO ***' + Chr(13) + Chr(10)
cBuffer += Repl('=', 48 ) + Chr(13) + Chr(10)
cBuffer += Chr(255)
FWrite( nPorta, @cBuffer, Len( cBuffer ))
FClose( nPorta )
ResTela( cTela )
Return

Function FormaErrada( cForma, cCondicoes, nRow, nCol, nComissao, nComissaoMedia, nIof, lDesdobrar )
***************************************************************************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL aRotina := {{|| InclusaoForma() }}

Area("Forma")
IF Forma->(!DbSeek( cForma ))
	Forma->(Escolhe( 03, 01, 22,"Forma + 'Ý' + Condicoes + 'Ý' + Str( Comissao,5,2)", "CODIGO CONDICOES                             COMISSAO", aRotina ))
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIf
EndIF
cForma		:= Forma->Forma
cCondicoes	:= Forma->Condicoes
nIof			:= Forma->Iof
lDesdobrar	:= Forma->Desdobrar
IF nComissaoMedia != Nil
	IF nComissaoMedia = 0
		nComissao  := Forma->Comissao
	Else
		nComissao  := nComissaoMedia
	EndIF
EndIF
IF nRow != NIL
	Write( nRow, nCol, Forma->Condicoes )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Cf_Sweda( cCodi, cFatura, nLiquido, cForma )
*************************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cScreen	  := SaveScreen()
LOCAL nPorta	  := 0
LOCAL cBuffer	  := Space(134)
LOCAL nTotal	  := 0
LOCAL nGeral	  := 0
LOCAL lServico   := FALSO
LOCAL cGeral	  := ''
LOCAL cDesconto  := ''
LOCAL cUnitario  := ''
LOCAL cTotal	  := ''
LOCAL nIcms 	  := 17
LOCAL lVista	  := FALSO
LOCAL nQuant	  := 0
LOCAL nSigLinha  := 1
LOCAL nBloco	  := 128
LOCAL nDesconto  := 0
LOCAL cRetorno   := Space( nBloco )
LOCAL cLetraDesc := '1'
LOCAL cCodiCliente
LOCAL cNomeCliente
LOCAL cEndeCliente
LOCAL cBairCliente
LOCAL cCidaCliente
LOCAL cEstaCliente
LOCAL cCgcCliente
LOCAL nConta
LOCAL cCondicoes

Lista->(Order( LISTA_CODIGO ))
Forma->(Order( FORMA_FORMA ))
Forma->(DbSeek( cForma ))
cCondicoes := Forma->Condicoes
Receber->(Order( RECEBER_CODI ))
Receber->(DbSeek( cCodi ))
cCodiCliente := AllTrim( Receber->Codi )
cNomeCliente := Left( AllTrim( Receber->Nome ),39)
cEndeCliente := Left( AllTrim( Receber->Ende ),39)
cBairCliente := AllTrim( Receber->Bair )
cCidaCliente := AllTrim( Receber->Cida )
cEstaCliente := Receber->Esta
cCgcCliente  := IF( Receber->(Empty( Cgc )) .OR. Receber->Cgc = "  .   .   /    -  ", Receber->Cpf, Receber->Cgc )
nIcms 		 := Receber->Tx_Icms
oMenu:Limpa()
Saidas->(Order( SAIDAS_FATURA ))
IF Saidas->(DbSeek( cFatura ))
	IF !lAutoEcf
		IF Saidas->Impresso
			ErrorBeep()
			IF Conf("Erro: Cupom Fiscal ja Impresso. Retornar ?")
				Restela( cScreen )
				Return
			EndIF
		EndIF
	EndIF
EndIF
IF nIcms = 0
	nIcms = oIni:ReadInteger('ecf', 'uficms', 17 )
EndIF
nSigLinha := oIni:ReadInteger('ecf', 'siglinha', 2 )
lVista	 := oIni:ReadBool('ecf', 'vista', OK )

Mensagem("Aguarde, Emitindo Cupom Fiscal.")
SwedaOn()
cBuffer := Chr(27) + '.17}' // Abrir Cupom Fiscal
Write( Prow(), Pcol(), cBuffer )
xAlias->(Order( nOrderTicket-1 ))
xAlias->(DbGoTop())
While xAlias->(!Eof())
	cCodigo	  := xAlias->Codigo
	cDescricao := Left( xAlias->Descricao, 24)
	nTotal	  := ( xAlias->Unitario * xAlias->Quant )
	nQuant	  := xAlias->Quant
	IF nQuant <= 0
		xAlias->(DbSkip(1))
		Loop
	EndIF
	cQuant	  := Right( Strzero( Val( IntToStrSemPonto( xAlias->Quant, 10, 3)), 10),7)
	cUnitario  := Right( Strzero( Val( IntToStrSemPonto( xAlias->Unitario, 11, 2 )),11),9)
	cTotal	  := Right( Strzero( Val( IntToStrSemPonto( nTotal, 12, 2 )),12),12)
	nGeral	  += nTotal
	Lista->(DbSeek( cCodigo ))
	lServico := Lista->Servico
	cClasse	:= Lista->Classe

	cLetra := 'F  '
	IF cClasse = '00'
		IF nIcms = 7
			cLetra := 'T07'
		ElseIF nIcms = 12
			cLetra := 'T12'
		ElseIF nIcms = 17
			cLetra := 'T17'
		ElseIF nIcms = 25
			cLetra := 'T25'
		EndIF
	ElseIF cClasse = '10'
		cLetra := 'F  '
	ElseIF cClasse = '20'
		cLetra := 'N  '
	ElseIF cClasse = '30'
		cLetra := 'F  '
	ElseIF cClasse = '40'
		cLetra := 'I  '
	ElseIF cClasse = '41'
		cLetra := 'I  '
	ElseIF cClasse = '50'
		cLetra := 'I  '
	ElseIF cClasse = '51'
		cLetra := 'I  '
	ElseIF cClasse = '60'
		cLetra := 'F  '
	ElseIF cClasse = '70'
		cLetra := 'N  '
	ElseIF cClasse = '90'
		cLetra := 'N  '
	EndIF
	IF lServico
		cLetra := 'T05'
	EndIF
	cBuffer := Chr(27) + '.01'    // Registrar Item
	cBuffer += cCodigo + Space(7) // Codigo Produto 13 Digitos
	cBuffer += cQuant 				// Quantidade 7 posicoes sem virgula
	cBuffer += cUnitario 			// Preco Unitario 9 posicoes sem virgula
	cBuffer += cTotal 				// Preco Total 	12 digitos sem virgula
	cBuffer += cDescricao			// Descricao Produto 24 posicoes.
	cBuffer += cLetra
	cBuffer += '}'
	Write( Prow(), Pcol(), cBuffer )
	xAlias->(DbSkip(1))
EndDo
// Desconto
nDesconto  := Round((nLiquido-nGeral),2)
cDesconto  := Repl('0',12)
cGeral	  := StrSemComma( nGeral, 13, 2, 12 )
IF nDesconto < 0 // Desconto
	xDesconto  := 0
	xDesconto  -= nDesconto
	nDesconto  := xDesconto
	cDesconto  := StrSemComma( nDesconto, 13, 2, 12 )
	cGeral	  := StrSemComma( nGeral, 13, 2, 12 )
	cBuffer := Chr(27) + '.03'
	cBuffer += 'DESCONTO  '
	cBuffer += cDesconto
	cBuffer += 'S'
	cBuffer += '}'
	Write( Prow(), Pcol(), cBuffer )
ElseIF nDesconto > 0 // Acrescimo
	cDesconto  := StrSemComma( nDesconto, 13, 2, 11 )
	cGeral	  := StrSemComma( nLiquido, 13, 2, 12 )
	cBuffer := Chr(27) + '.11'
	cBuffer += '51'
	cBuffer += '0000'
	cBuffer += cDesconto
	cBuffer += 'S'
	cBuffer += '}'
	Write( Prow(), Pcol(), cBuffer )
EndIF

//Totalizacao do Cupom Fiscal
//cGeral  := Right( Strzero( Val( IntToStrSemPonto( nGeral, 12, 2 )),12),12)
cForma  := '01' // DINHEIRO
cBuffer := Chr(27) + '.10'
cBuffer += cForma
cBuffer += cGeral
cBuffer += '}'
Write( Prow(), Pcol(), cBuffer )

// Fechamento do Cupom
cBuffer := Chr(27) + '.12NN'
cBuffer += '0' + Repl('=', 40 )
IF lNomeEcf
	cBuffer += '0' + cCodiCliente + Space(40-Len(cCodiCliente))
	cBuffer += '0' + cNomeCliente + Space(40-Len(cNomeCliente))
	cBuffer += '0' + cEndeCliente + Space(40-Len(cEndeCliente))
	cEnde   := cBairCliente + '/' + cCidaCliente + '-' + cEstaCliente
	cBuffer += '0' + cEnde + Space(40-Len(cEnde))
	cBuffer += '0' + cCgcCliente + Space(40-Len(cCgcCliente))
	cBuffer += '0' + Repl('=', 40-Len(AllTrim(cFatura))) + AllTrim(cFatura)
EndIF
cBuffer += '0' + Padc( cRamoIni, 40) + Space(40-Len(cRamoIni))
cBuffer += '}'
Write( Prow(), Pcol(), cBuffer )
SwedaOff()

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
ResTela( cScreen )
Return

Proc AutorizaVenda()
********************
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL bSetKey	:= SetKey( K_SH_F10 )
LOCAL cFatura	:= Space(07)
LOCAL nNivel	:= SCI_DEVOLUCAO_FATURA
LOCAL cArquivo := ''
LOCAL oFatura	:= ''

oMenu:Limpa()
IF !aPermissao[ nNivel ]
	IF !PedePermissao( nNivel )
		Restela( cScreen )
		Return
	EndIF
EndIF
SetKey( K_SH_F10, NIL )
oMenu:Limpa()
Try OK
	TelaFechaCli()
	Print 05, 15 Get cFatura Pict "@!" Valid oIniRecall( @cFatura, @cArquivo )
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	ErrorBeep()
	IF Conf('Pergunta: Autorizar venda ?')
		oFatura	:= TIniNew( cArquivo )
		oFatura:WriteBool( cFatura, 'info13', OK )
		oFatura:Close()
	EndIF
End
Restela( cScreen )
SetKey( K_SH_F10, bSetKey )
Return

Function oIniWrite( cForma, cCond, nComissaoMedia, cCodi, cVendedor, cDivisao, cVendedor1, cFatura, dEmis, nDesc, nTotal, cNomeCliente )
****************************************************************************************************************************************
LOCAL oFatura		:= TIniNew( oAmbiente:xBaseDados + '\' + cFatura + '.FAT')
LOCAL lAutorizado := FALSO

oFatura:WriteString( cFatura, 'info01',  cForma )
oFatura:WriteString( cFatura, 'info02', Trim( cCond ))
oFatura:WriteString( cFatura, 'info03', nComissaoMedia )
oFatura:WriteString( cFatura, 'info04', cCodi )
oFatura:WriteString( cFatura, 'info05', cVendedor )
oFatura:WriteString( cFatura, 'info06', cDivisao )
oFatura:WriteString( cFatura, 'info07', cVendedor1 )
oFatura:WriteString( cFatura, 'info08', cFatura )
oFatura:WriteDate( cFatura, 'info09', dEmis )
oFatura:WriteString( cFatura, 'info10', nDesc )
oFatura:WriteString( cFatura, 'info11', nTotal )
oFatura:WriteString( cFatura, 'info12', cNomeCliente )
oFatura:Close()
Return( OK )

Function oIniRecall( cFatura, cArquivo )
****************************************
LOCAL lAutorizado := FALSO
LOCAL cString		:= ''

cArquivo 	:= oAmbiente:xBaseDados + '\' + cFatura + '.FAT'
IF !File( cArquivo )
	ErrorBeep()
	Alerta('Informa: Numero de fatura nao localizada.')
	Return( FALSO )
End
oFatura		:= TIniNew( cArquivo )
Write( 01, 15, oFatura:ReadString( cFatura, 'info01',  cString ))
Write( 01, 37, oFatura:ReadString( cFatura, 'info02',  cString ))
Write( 02, 15, oFatura:ReadString( cFatura, 'info03',  cString ))
Write( 02, 37, oFatura:ReadString( cFatura, 'info05',  cString ))
Write( 03, 15, oFatura:ReadString( cFatura, 'info06',  cString ))
Write( 03, 37, oFatura:ReadString( cFatura, 'info07',  cString ))
Write( 05, 37, oFatura:ReadDate( cFatura, 'info09',  cString ))
Write( 06, 15, oFatura:ReadString( cFatura, 'info10',  cString ))
Write( 06, 37, oFatura:ReadString( cFatura, 'info11',  cString ))
Write( 08, 15, oFatura:ReadString( cFatura, 'info04',  cString ))
Write( 08, 25, oFatura:ReadString( cFatura, 'info12',  cString ))
oFatura:Close()
Return( OK )

Function oIniErase( cFatura )
*****************************
Ferase( oAmbiente:xBaseDados + '\' + cFatura + '.FAT' )
Return( NIL )

Function oIniValida( cFatura )
******************************
LOCAL oFatura := TIniNew( oAmbiente:xBaseDados + '\' + cFatura + '.FAT')
Return( oFatura:ReadBool( cFatura, 'info13', FALSO ))

STATIC Proc ConfDivida( cFatu, cCaixa, cVend, dEmis, cCodi, cNomeCliente, nLiquido, Dpnr, aVcto, VlrDup )
************************************************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL nCol		 := 00
LOCAL nTotal	 := 0
LOCAL Tam		 :=  CPI1280
LOCAL nLinhas	 := 51
LOCAL cVendedor := Space(40)
LOCAL cMecanico := Space(40)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant   := IndexOrd()
LOCAL cExtenso  := Extenso(nLiquido,1,1,127)
LOCAL cCpf      := IF( Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space(18), Receber->Cpf, Receber->Cgc )
LOCAL cRg       := IF( Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space(18), Receber->Rg, Receber->Insc )

IF !InsTru80() .OR. !LptOk()
	Return
EndIF
PrintOn()
FPrint( _CPI12 )
FPrint( _SPACO1_8 )
SetPrc(0,0)
Write(	nCol, 00, "")
Write( ++nCol, 00, NG + Padc("CONTRATO PARTICULAR DE CONFISSAO DE DIVIDA E COMPROMISSO DE PAGAMENTO - N§ " + cFatu, Tam ) + NR )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, NG + "CREDORA: " + NR + AllTrim(AllTrim(oAmbiente:xNomefir)) + ", empresa de direito privado, estabelecida na")
Write( ++nCol, 00, XENDEFIR + "/" + XCCIDA + "-" + XCESTA + ",inscrita no CPF/CNPJ n§ " + XCGCFIR )
Write( ++nCol, 00, "por seu representante legal, doravante denominada simplesmente 'CREDORA'.")
FPrint( _CPI12 )
++nCol
Write( ++nCol, 00, NG + "DEVEDOR: " + NR + Alltrim(cNomeCliente) + ", Brasileiro, " + AllTrim(Receber->Civil) + ", " + AllTrim(Receber->Profissao))
Write( ++nCol, 00, AllTrim( Receber->Ende ) + " - " + AllTrim(Receber->Bair) + " - " + Receber->Cep + "/" + AllTrim(Receber->( Cida )) + " - " + Receber->Esta )
Write( ++nCol, 00, "inscrita no CPF/CNPJ sob n§ " + cCpf + " RG/IE : " + cRg )
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "doravante denominado simplesmente 'DEVEDOR' pelo presente instrumento particular e na  melhor")
Write( ++nCol, 00, "forma de direito, tem entre si justo contratados as Clausulas e condicoes a seguir:")
nCol++
Write( ++nCol, 00, NG + "PRIMEIRA: " + NR + "Ressalvadas quaisquer outras obrigacoes aqui nao incluidas, pelo presente instrumen-")
Write( ++nCol, 00, "to e na melhor forma de direito, o DEVEDOR e AVALISTA confessam dever a CREDORA a quantia li-")
Write( ++nCol, 00, "quida, certa e exigivel da importancia de R$ " + Tran(nLiquido,'@E 999,999.99') + ' (' + Left( cExtenso, 36))
Write( ++nCol, 00, Right(cExtenso, (127-36)) + "),")
Write( ++nCol, 00, "cujo pagamento o DEVEDOR e o AVALISTA se obrigam a realizar do seguinte modo:")
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "N§ DOCTO  VENCIMENTO       VALOR                     N§ DOCTO  VENCIMENTO       VALOR")
nLen := Len( Dpnr )
nSoma := 0
nSum	:= 1
For nY := 1 To nLen
	IF nSum = 1
      Qout( Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"))
		nSum := 0
		nCol++
	Else
      QQout( Space(19), Dpnr[nY], aVcto[nY], Tran( VlrDup[nY],"@E 99,999,999.99"))
		nSum := 1
	EndIF
	nSoma += VlrDup[nY]
Next
Write( ++nCol, 00, Repl("-", Tam ))
Write( ++nCol, 00, "A titulo de garantia, foi emitida nesta data pelo DEVEDOR as  respectivas  NOTAS PROMISSORIAS")
Write( ++nCol, 00, "em favor da CREDORA, que serao resgatadas pelo DEVEDOR nos respectivos  vencimentos, as quais")
Write( ++nCol, 00, "ficam fazendo parte integral no presente instrumento.")
nCol++
Write( ++nCol, 00, "O DEVEDOR no gozo pleno de suas faculdades mentais, livres de qualquer constrangimento, renun-")
Write( ++nCol, 00, "cia qualquer direito que possua em revisar ou questionar, seja na esfera administrativa, seja")
Write( ++nCol, 00, "na esfera judicial a origem do debito ora confessado e originario da compra de mercadorias pe-")
Write( ++nCol, 00, "lo DEVEDOR em estabelecimento comercial da CREDORA, no qual o DEVEDOR neste ato,  declara ter")
Write( ++nCol, 00, "conferido e recebido as mercadorias adquiridas, ter conferido o demonstrativo de valores, re-")
Write( ++nCol, 00, "conhecendo tudo como correto, certo e valioso, reconhecendo ser devedor a favor da CREDORA os")
Write( ++nCol, 00, "titulos correspondentes ao debito originalmente aberto de comum acordo entre as partes.")
nCol++
Write( ++nCol, 00, NG + "SEGUNDA: " + NR + "Embora reconhecendo como boa a origem da divida, o DEVEDOR, compromete-se a  efetuar")
Write( ++nCol, 00, "o pagamento das parcelas contratadas, ate o vencimento, em qualquer dos  estabelecimentos  da")
Write( ++nCol, 00, "CREDORA, ou outros locais por ela indicados, mediante apresentacao do respectivo titulo.")
nCol++
Write( ++nCol, 00, "O nao pagamento de qualquer parcela no seu vencimento, importara no vencimento integral e ante-")
Write( ++nCol, 00, "cipado do debito, sujeitando o DEVEDOR, alem da execucao do presente instrumento, ao pagamento")
Write( ++nCol, 00, "do valor integral do debito, sobre qual incidira a aplicacao de multa de 10%, juros de mora e ")
Write( ++nCol, 00, "correcao monetaria e mais custas processuais e honorarios advocaticios na base de 20% sobre o")
Write( ++nCol, 00, "valor total do debito.")
nCol++
Write( ++nCol, 00, NG + "TERCEIRA: " + NR + "A divida ora reconhecida e assumida pelo DEVEDOR e AVALISTA, como liquida, certa  e")
Write( ++nCol, 00, "exigivel, no valor acima mencionado, aplica-se o disposto no art. 585, Inciso II, do CPC,  ha")
Write( ++nCol, 00, "ja visto o carater de titulo executivo extrajudicial do presente instrumento de confissao  de")
Write( ++nCol, 00, "divida.")
nCol++
Write( ++nCol, 00, NG + "QUARTA: " + NR + "O DEVEDOR esta ciente, ainda, que o atraso no pagamento de qualquer das parcelas, en-")
Write( ++nCol, 00, "sejara inscricao de seu nome junto ao Servico de Protecao ao Credito (SPC), independente  de")
Write( ++nCol, 00, "nova comunicacao ou de protesto.")
nCol++
Write( ++nCol, 00, NG + "QUINTA: " + NR + "A eventual tolerancia a infringencia de qualquer das clausulas deste  instrumento  ou")
Write( ++nCol, 00, "nao exercicio de qualquer direito nele previsto constituira mera liberalidade, nao implicando")
Write( ++nCol, 00, "em novacao ou transacao de qualquer especie.")
nCol++
Write( ++nCol, 00, NG + "OITAVA : " + NR + "Aos casos omissos sera aplicada subsidiariamente a norma cabivel na legislacao em vi-")
Write( ++nCol, 00, "gor. Para dirimir quaisquer duvidas oriundas deste contrato, fica eleito o foro da comarca de:")
Write( ++nCol, 00,  XCCIDA + " - " + XCESTA + " com renuncia de qualquer outra, por mais previlegiada que seja.")
nCol++
Write( ++nCol, 00, "             E por estarem justos e contratados, assinam o presente em duas vias de igual teor")
Write( ++nCol, 00, "e forma, que apos lido e achado conforme, na presenca de testemunhas, assinado por todos, para")
Write( ++nCol, 00, "que surta seus juridicos e legais efeitos.")
nCol++
Write( ++nCol, 00, DataExt(Date()))
nCol++
nCol++
Write( ++nCol, 00, "CREDORA   : " + Repl("_", 40))
Write( ++nCol, 00, Space(13) + AllTrim(oAmbiente:xNomefir) )
nCol++
Write( ++nCol, 00, "DEVEDOR   : " + Repl("_", 40))
Write( ++nCol, 00, Space(13) + cNomeCliente )
nCol++
Write( ++nCol, 00, "AVALISTA  : " + Repl("_", 40))
Write( ++nCol, 00, Space(13) + Receber->Conhecida )
nCol++
Write( ++nCol, 00, "TESTEMUNHA: " + Repl("_", 40))
Write( ++nCol, 00, Space(13) + "")
nCol++
Write( ++nCol, 00, "TESTEMUNHA: " + Repl("_", 40))
Write( ++nCol, 00, Space(13) + "")
__Eject()
PrintOff()
Saidas->(DbClearRel())
Saidas->(DbGoTop())
AreaAnt( Arq_Ant, Ind_Ant )
Return
