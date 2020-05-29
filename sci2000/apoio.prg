/*
  �������������������������������������������������������������������������Ŀ
 ݳ																								 �
 ݳ	Programa.....: APOIO.PRG															 �
 ݳ	Aplicacaoo...: MODULO DE APOIO AO SCI											 �
 ݳ	Versao.......: 19.50 																 �
 ݳ	Programador..: Vilmar Catafesta													 �
 ݳ	Empresa......: Microbras Com de Prod de Informatica Ltda 				 �
 ݳ	Inicio.......: 12 de Novembro de 1991. 										 �
 ݳ	Ult.Atual....: 06 de Dezembro de 1998. 										 �
 ݳ	Compilacao...: Clipper 5.02														 �
 ݳ	Linker.......: Blinker 3.20														 �
 ݳ	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic �
 ����������������������������������������������������������������������������
 ��������������������������������������������������������������������������
*/
#Include "rddname.Ch"
#Include "Lista.Ch"
#Include "Inkey.Ch"
#Include "GetExit.Ch"
#Include "Fileman.Ch"
#Include "Setcurs.Ch"
#Include "Error.Ch"
#Include "Permissao.Ch"
#Include "Indice.Ch"
#Include "Picture.Ch"
#include "Directry.Ch"  // Arquivos
#include "Ctnnet.Ch"    // Clipper Tools
#include "Fileio.Ch"    // Arquivos
#include "Achoice.Ch"
#include "oclip.ch"
#Include "common.ch"

#Define TURN_ON_APPEND_MODE(b)		(b:cargo := .T.)
#Define TURN_OFF_APPEND_MODE(b)		(b:cargo := .F.)
#Define IS_APPEND_MODE(b)				(b:cargo)
#Define MY_HEADSEP						"-�-"
#Define MY_COLSEP 						" � "
#Define XMESES   2
#Define XCREDITO 1
#Define XDEBITO  3
#define APP_MODE_ON( b )				 ( b:cargo := OK	)
#define APP_MODE_OFF( b )				 ( b:cargo := FALSO )
#define APP_MODE_ACTIVE( b )			 ( b:cargo )

Proc Integridade( Dbf1, cCor, nLinha )
**************************************
LOCAL aStruct	 := DbStruct()
LOCAL cArquivo  := Alias()
LOCAL lCriarDbf := OK
LOCAL cTela
LOCAL nConta
LOCAL nX

cCor	 := IIF( cCor = Nil, Cor(), cCor )
nLinha := IIF( nLinha = Nil, Nil, nLinha )
nConta := Len(Dbf1)
cTela := Mensagem(" Verificando Integridade de " + cArquivo, CorBox(), nLinha )
For nX := 1 To nConta
	cCampo := Dbf1[nX,1] // NOME DO CAMPO
	IF !AchaCampo( aStruct, Dbf1, nX, cCampo )
		NovoDbf( Dbf1, cCor, nLinha, cCampo, lCriarDbf )
		IF lCriarDbf = OK
			lCriarDbf := FALSO
		EndIF
	EndIF
Next
DbCloseArea()
ResTela( cTela )
Return

Proc NovoDbf( Dbf1, cCor, nLinha, cCampo, lCriarDbf )
*****************************************************
LOCAL cArquivo  := Alias()
LOCAL cLocalNtx := cArquivo + '.' + CEXT
LOCAL cTela

IF lCriarDbf
	DbCloseArea()
	cTela := Mensagem("Aguarde, Renomeando Arquivo.", CorBox(), nLinha )
	Ferase((cArquivo + ".OLD"))
	MsRename((cArquivo + ".DBF"), (cArquivo + ".OLD"))
	ResTela( cTela )
	cTela := Mensagem("Aguarde, Criando Arquivo Novo.", CorBox(), nLinha )
	DbCreate( cArquivo, Dbf1 )
	ResTela( cTela )
	cTela := Mensagem("Aguarde, Incluindo Registros no arquivo Novo.", CorBox(), nLinha )
	Use (cArquivo) New
	Appe From ( cArquivo + ".OLD")
	Ferase( cLocalNtx )
EndIF
ResTela( cTela )

/*
Necessario converter campos, devido
aumento de digitos nos campos:
------------------------------------
Arquivo:LISTA.DBF 	- Campo:CLASSE   // VC - 11/03/03
Arquivo:LISTA.DBF 	- Campo:CODIGO   // VC - 08/03/99
Arquivo:SAIDAS.DBF	- Campo:CODIGO   // VC - 08/03/99
Arquivo:ENTRADAS.DBF - Campo:CODIGO   // VC - 08/03/99
Arquivo:ENTRADAS.DBF - Campo:CFOP	  // VC - 24/04/03
Arquivo:SAIDAS.DBF	- Campo:CODI	  // VC - 24/07/99
Arquivo:RECEBER.DBF	- Campo:CODI	  // VC - 24/07/99
Arquivo:RECEMOV.DBF	- Campo:CODI	  // VC - 24/07/99
Arquivo:RECEBIDO.DBF - Campo:CODI	  // VC - 24/07/99
Arquivo:NOTA.DBF		- Campo:CODI	  // VC - 24/07/99
Arquivo:VENDEMOV.DBF - Campo:CODI	  // VC - 19/08/99
Arquivo:CURSADO.DBF	- Campo:CODI	  // VC - 19/08/99
Arquivo:CURSADO.DBF	- Campo:CODI	  // VC - 19/08/99
Arquivo:RETORNO.DBF	- Campo:CODI	  // VC - 19/08/99
Arquivo:GRPSER.DBF	- Campo:GRUPO	  // VC - 02/07/01
Arquivo:SERVICO.DBF	- Campo:GRUPO	  // VC - 02/07/01
Arquivo:CORTES.DBF	- Campo:TABELA   // VC - 02/07/01
Arquivo:CORTES.DBF	- Campo:CODISER  // VC - 02/07/01
Arquivo:MOVI.DBF		- Campo:TABELA   // VC - 02/07/01
Arquivo:MOVI.DBF		- Campo:CODISER  // VC - 02/07/01
*/
IF cArquivo = "LISTA" .AND. cCampo = "CLASSE"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Lista->(DbGoTop())
	WHILE Lista->(!Eof())
		Lista->Classe := AllTrim( Lista->Classe ) + '0'
		Lista->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "LISTA" .AND. cCampo = "CODIGO"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Lista->(DbGoTop())
	WHILE Lista->(!Eof())
		Lista->Codigo := StrZero( Val( Lista->Codigo ), 6 )
		Lista->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "ENTRADAS" .AND. cCampo = "CODIGO"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Entradas->(DbGoTop())
	WHILE Entradas->(!Eof())
		Entradas->Codigo := StrZero( Val( Entradas->Codigo ), 6 )
		Entradas->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "ENTRADAS" .AND. cCampo = "CFOP"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Entradas->(DbGoTop())
	WHILE Entradas->(!Eof())
		Entradas->Cfop := Left( Entradas->cFop, 3) + '0' + SubStr( Entradas->Cfop, 4, 1 )
		Entradas->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "SAIDAS" .AND. cCampo = "CODIGO" .OR. cArquivo = "SAIDAS" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Saidas->(DbGoTop())
	WHILE Saidas->(!Eof())
		Saidas->Codigo   := StrZero( Val( Saidas->Codigo ), 6 )
		Saidas->Codi	  := StrZero( Val( Saidas->Codi	 ), 5 )
		Saidas->(DbSkip(1))
	EndDo
EndIF
IF cArquivo = "RECEBER" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Receber->(DbGoTop())
	WHILE Receber->(!Eof())
		Receber->Codi	 := StrZero( Val( Receber->Codi ), 5 )
		Receber->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "RECEMOV" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Recemov->(DbGoTop())
	WHILE Recemov->(!Eof())
		Recemov->Codi	 := StrZero( Val( Recemov->Codi ), 5 )
		Recemov->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "RECEBIDO" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Recebido->(DbGoTop())
	WHILE Recebido->(!Eof())
		Recebido->Codi   := StrZero( Val( Recebido->Codi ), 5 )
		Recebido->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "NOTA" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Nota->(DbGoTop())
	WHILE Nota->(!Eof())
		Nota->Codi		:= StrZero( Val( Nota->Codi ), 5 )
		Nota->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "VENDEMOV" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Vendemov->(DbGoTop())
	WHILE Vendemov->(!Eof())
		Vendemov->Codi   := StrZero( Val( Vendemov->Codi ), 5 )
		Vendemov->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "CURSADO" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Cursado->(DbGoTop())
	WHILE Cursado->(!Eof())
		Cursado->Codi	 := StrZero( Val( Cursado->Codi ), 5 )
		Cursado->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "RETORNO" .AND. cCampo = "CODI"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Retorno->(DbGoTop())
	WHILE Retorno->(!Eof())
		Retorno->Codi	 := StrZero( Val( Retorno->Codi ), 5 )
		Retorno->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "GRPSER" .AND. cCampo = "GRUPO"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	GrpSer->(DbGoTop())
	WHILE GrpSer->(!Eof())
		GrpSer->Grupo := StrZero( Val( GrpSer->Grupo ), 3 )
		GrpSer->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "SERVICO" .AND. cCampo = "GRUPO" .OR. cArquivo = "SERVICO" .AND. cCampo = "CODISER"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Servico->(DbGoTop())
	WHILE Servico->(!Eof())
		Servico->Grupo   := StrZero( Val( Servico->Grupo ), 3 )
		Servico->Codiser := StrZero( Val( Servico->CodiSer ), 3 )
		Servico->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "CORTES" .AND. cCampo = "TABELA" .OR. cArquivo = "CORTES" .AND. cCampo = "CODISER"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Cortes->(DbGoTop())
	WHILE Cortes->(!Eof())
		Cortes->Tabela  := Left( Cortes->Tabela, 5 ) + StrZero( Val( SubStr( Cortes->Tabela, 6, 2 )), 3 )
		Cortes->Codiser := StrZero( Val( Cortes->CodiSer ), 3 )
		Cortes->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
IF cArquivo = "MOVI" .AND. cCampo = "TABELA" .OR. cArquivo = "MOVI" .AND. cCampo = "CODISER"
	cTela := Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo, CorBox(), nLinha )
	Movi->(DbGoTop())
	WHILE Movi->(!Eof())
		Movi->Tabela  := Left( Movi->Tabela, 5 ) + StrZero( Val( SubStr( Movi->Tabela, 6, 2 )), 3 )
		Movi->Codiser := StrZero( Val( Movi->CodiSer ), 3 )
		Movi->(DbSkip(1))
	EndDo
EndIF
ResTela( cTela )
Return

Function AchaCampo( aStruct, Dbf1, nX, cCampo )
***********************************************
LOCAL cTipo, nTam, nDec
LOCAL nPos := Ascan2( aStruct, cCampo, 1 )
IF nPos > 0
	cTipo := Dbf1[nX,2]
	nTam	:= Dbf1[nX,3]
	nDec	:= Dbf1[nX,4]
	Return(( aStruct[ nPos, 2 ] == cTipo .AND. ;
				aStruct[ nPos, 3 ] == nTam  .AND. ;
				aStruct[ nPos, 4 ] == nDec ))
EndIf
Return(FALSO)


Proc InclusaoProdutos( lAlteracao )
***********************************
LOCAL cScreen	  := SaveScreen()
LOCAL GetList	  := {}
LOCAL lModificar := FALSO
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL cCodi 	  := Space(04)
LOCAL cCodi1	  := Space(04)
LOCAL cCodi2	  := Space(04)
LOCAL cCodi3	  := Space(04)
LOCAL cCodi4	  := Space(04)
LOCAL cRepres	  := Space(04)
LOCAL cCodigo	  := "000000"
LOCAL cGrupo	  := "000"
LOCAL cSub		  := "000.00"
LOCAL cDesc 	  := Space( 40 )
LOCAL cFab		  := Space(15)
LOCAL cCodeBar   := Space(13)
LOCAL cLocal	  := Space(10)
LOCAL cUn		  := "PC"
LOCAL nOpcao	  := 0
LOCAL nEmb		  := 0
LOCAL nQmin 	  := 0
LOCAL nQmax 	  := 0
LOCAL nPorc 	  := 0
LOCAL nTx_Icms   := 0
LOCAL nReducao   := 0
LOCAL nAtacado   := 0
LOCAL nVarejo	  := 0
LOCAL nPCompra   := 0
LOCAL nMarVar	  := 0
LOCAL nMarCus	  := 0
LOCAL nMarAta	  := 0
LOCAL nPcusto	  := 0
LOCAL nAm		  := 0
LOCAL nAc		  := 0
LOCAL nRo		  := 0
LOCAL nRr		  := 0
LOCAL nMt		  := 0
LOCAL cSituacao  := Space(01)
LOCAL cClasse	  := Space(02)
LOCAL cTam		  := Space(06)
LOCAL cSigla	  := Space(10)
LOCAL nDescMax   := 0
LOCAL cServico   := 'N'
LOCAL cSwap
LOCAL cSwapBar
LOCAL cString

IF lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
	IF !PodeAlterar()
		ResTela( cScreen )
		Return
	EndIF
EndIF
IF !lModificar
	IF !PodeIncluir()
		 Restela( cScreen )
		Return
	EndIF
EndIF
oMenu:Limpa()
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
#IFDEF DEMO
	IF !lModificar
		IF Lista->(LastRec()) >= 100
			ErrorBeep()
			Alerta("Erro: Limite de Inclusao de Produtos Excedido.;Por favor, registre sua copia.")
			ResTela( cScreen )
			Return
		EndIF
	EndIF
#ENDIF
WHILE OK
	oMenu:Limpa()
	cClasse	 := IF( lModificar, Lista->Classe,			Lista->( Space( Len( Classe	  ))))
	cGrupo	 := IF( lModificar, Lista->CodGrupo,		Lista->( Space( Len( CodGrupo   ))))
	cSub		 := IF( lModificar, Lista->CodSGrupo,		Lista->( Space( Len( CodsGrupo  ))))
	cDesc 	 := IF( lModificar, Lista->Descricao,		Lista->( Space( Len( Descricao  ))))
	cFab		 := IF( lModificar, Lista->N_Original, 	Lista->( Space( Len( N_Original ))))
	cLocal	 := IF( lModificar, Lista->Local,			Lista->( Space( Len( Local 	  ))))
	cUn		 := IF( lModificar, Lista->Un,				Lista->( Space( Len( Un 		  ))))
	cUn		 := IF( lModificar, Lista->Un,				Lista->( Space( Len( Un 		  ))))
	cTam		 := IF( lModificar, Lista->Tam,				Lista->( Space( Len( Tam		  ))))
	cSituacao := IF( lModificar, Lista->Situacao,		Lista->( Space( Len( Situacao   ))))
	cCodi 	 := IF( lModificar, Lista->Codi, 			Lista->( Space( Len( Codi		  ))))
	cCodi1	 := IF( lModificar, Lista->Codi1,			Lista->( Space( Len( Codi1 	  ))))
	cCodi2	 := IF( lModificar, Lista->Codi2,			Lista->( Space( Len( Codi2 	  ))))
	cCodi3	 := IF( lModificar, Lista->Codi3,			Lista->( Space( Len( Codi3 	  ))))
	cRepres	 := IF( lModificar, Lista->Repres,			Lista->( Space( Len( Repres	  ))))
	cCodeBar  := IF( lModificar, Lista->CodeBar, 		Lista->( Space( Len( Codebar	  ))))
	nAm		 := IF( lModificar, Lista->Am,				0 )
	nAc		 := IF( lModificar, Lista->Ac,				0 )
	nMt		 := IF( lModificar, Lista->Mt,				0 )
	nRo		 := IF( lModificar, Lista->Ro,				0 )
	nRr		 := IF( lModificar, Lista->Rr,				0 )
	nEmb		 := IF( lModificar, Lista->Emb,				0 )
	nQmin 	 := IF( lModificar, Lista->Qmin, 			0 )
	nQmax 	 := IF( lModificar, Lista->Qmax, 			0 )
	nPorc 	 := IF( lModificar, Lista->Porc, 			0 )
	nDescMax  := IF( lModificar, Lista->Desconto,		0 )
	nMarVar	 := IF( lModificar, Lista->MarVar,			0 )
	nMarCus	 := IF( lModificar, Lista->MarCus,			0 )
	nMarAta	 := IF( lModificar, Lista->Marata,			0 )
	nPcusto	 := IF( lModificar, Lista->Pcusto,			0 )
	nVarejo	 := IF( lModificar, Lista->Varejo,			0 )
	nPCompra  := IF( lModificar, Lista->PCompra, 		0 )
	nAtacado  := IF( lModificar, Lista->Atacado, 		0 )
	nTx_Icms  := IF( lModificar, Lista->Tx_Icms, 		0 )
	nReducao  := IF( lModificar, Lista->Reducao, 		0 )
	cServico  := IF( lModificar, IF( Lista->Servico, 'S', 'N'), 'N')

	IF( !lModificar, Lista->(DbGoBottom()),)
	lSair 	:= FALSO
	cCodigo	:= IF( lModificar, Lista->Codigo, ProxCodigo( Lista->Codigo ))
	cString	:= IF( lModificar, "ALTERACAO DE PRODUTOS", "INCLUSAO DE NOVOS PRODUTOS")
	cSwap 	:= cCodigo
	cSwapBar := AllTrim(cCodeBar)

	WHILE OK
		MaBox( 01, 01, 23, 77, cString )
		@		 02, 02 Say "Codigo..............:" Get cCodigo   Pict "999999"  Valid CodiCerto( @cCodigo, lModificar, cSwap )
      @ Row()+1, 02 Say "Grupo...............:" Get cGrupo    Pict "999"     Valid GrupoCerto( @cGrupo, Row(), Col()+1 )
      @ Row()+1, 02 Say "SubGrupo............:" Get cSub      Pict "999.99"  Valid SubCerto( @cSub, Row(), Col()+1, cGrupo )
		@ Row()+1, 02 Say "Descricao...........:" Get cDesc     Pict "@!"
		@ Row()+1, 02 Say "Codigo Fabricante...:" Get cFab      Pict "@!"
		@ Row(),   40 Say "Localizacao.........:" Get cLocal    Pict "@!"
		@ Row()+1, 02 Say "Unidade.............:" Get cUn       Pict "@!"
		@ Row(),   40 Say "Embalagem...........:" Get nEmb      Pict "999"
		@ Row()+1, 02 Say "Estoque Minimo......:" Get nQmin     Pict "999999.99"
		@ Row(),   40 Say "Estoque Maximo......:" Get nQmax     Pict "999999.99"
		@ Row()+1, 02 Say "Porc.Vendedor.......:" Get nPorc     Pict "99.99"
		@ Row()	, 40 Say "Tamanho.............:" Get cTam      Pict "@!"
		@ Row()+1, 02 Say "Produto � servi�o...:" Get cServico  Pict "!" Valid PickSimNao( @cServico )
		@ Row(),   40 Say "Desconto Maximo.....:" Get nDescMax  Pict "99.99"
		@ Row()+1, 02 Say "Pre�o de Compra.....:" Get nPCompra  Pict "99999999.99"

		@ Row()+1, 02 Say "Margem Custo........:" Get nMarCus   Pict "999.99" Valid CalculaVenda( nPCompra, nMarCus, @nPcusto )
		@ Row(),   40 Say "Pre�o de Custo......:" Get nPcusto   Pict "99999999.99"
		@ Row()+1, 02 Say "Margem Varejo.......:" Get nMarVar   Pict "999.99" Valid CalculaVenda( nPcusto, nMarVar, @nVarejo )
		@ Row(),   40 Say "Pre�o Varejo........:" Get nVarejo   Pict "99999999.99"
		@ Row()+1, 02 Say "Margem Atacado......:" Get nMarAta   Pict "999.99" Valid CalculaVenda( nPcusto, nMarAta, @nAtacado )
		@ Row(),   40 Say "Pre�o Atacado.......:" Get nAtacado  Pict "99999999.99"
      @ Row()+1, 02 Say "Situa�ao Tributaria.:" Get cSituacao Pict "9"  Valid PickSituacao( @cSituacao )
		@ Row(),   40 Say "Classificao Fiscal..:" Get cClasse   Pict "99" Valid PickClasse( @cClasse ) .AND. CadReducao( cClasse, @nAm, @nRo, @nMt, @nAc, @nRr, cDesc)
		@ Row()+1, 02 Say "Icms Substituicao...:" Get nTx_Icms  Pict "999"
		@ Row(),   40 Say "Reducao Base Calculo:" Get nReducao  Pict "999"
		@ Row()+1, 02 Say "Fabricante..........:" Get cCodi     Pict "9999" Valid Pagarrado( @cCodi,  Row(), Col()+5, @cSigla ) .AND. BarNewCode( @cCodebar, cCodi, cCodigo )
		@ Row()+1, 02 Say "Fornecedor 1........:" Get cCodi1    Pict "9999" Valid Pagarrado( @cCodi1, Row(), Col()+5 )
		@ Row()+1, 02 Say "Fornecedor 2........:" Get cCodi2    Pict "9999" Valid Pagarrado( @cCodi2, Row(), Col()+5 )
		@ Row()+1, 02 Say "Fornecedor 3........:" Get cCodi3    Pict "9999" Valid Pagarrado( @cCodi3, Row(), Col()+5 )
		@ Row()+1, 02 Say "Representante.......:" Get cRepres   Pict "9999" Valid Represrrado( @cRepres, Row(), Col()+5 )
		@ Row()+1, 02 Say "Codigo de Barra.....:" Get cCodeBar  Pict "9999999999999" Valid BarErrado( @cCodeBar, lModificar, cSwapBar )
		Read
		IF LastKey() = ESC
			Set Key -4 To TabPreco	// F5
			Set Key -8 To
			Set Key F2 To
			Set Key F3 To
			AreaAnt( Arq_Ant, Ind_Ant )
			lSair := OK
			Exit
		EndIF
		ErrorBeep()
		IF lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		EndIF
		IF nOpcao = 1 // Incluir
			IF lModificar
			  IF !Lista->(TravaReg()) ; Loop ; EndIF
			Else
			  IF !CodiCerto( @cCodigo, lModificar ) ; Loop ; EndIF
			  IF !Lista->(Incluiu())					 ; Loop ; EndIF
			EndIF
			Lista->Codigo		:= cCodigo
			Lista->CodGrupo	:= cGrupo
			Lista->CodsGrupo	:= cSub
			Lista->Descricao	:= cDesc
			Lista->N_Original := cFab
			Lista->Un			:= cUn
			Lista->Emb			:= nEmb
			Lista->Qmin 		:= nQmin
			Lista->Qmax 		:= nQmax
			Lista->Porc 		:= nPorc
			Lista->Sigla		:= cSigla
			Lista->Data 		:= Date()
			Lista->Pcusto		:= nPcusto
			Lista->PCompra 	:= nPCompra
			Lista->Varejo		:= nVarejo
			Lista->Atacado 	:= nAtacado
			Lista->MarVar		:= CalcMargem( nPcusto,  nVarejo,  nMarVar )
			Lista->MarAta		:= CalcMargem( nPcusto,  nAtacado, nMarAta )
			Lista->MarCus		:= CalcMargem( nPCompra, nPcusto,  nMarCus )
			Lista->Classe		:= cClasse
			Lista->Situacao	:= cSituacao
			Lista->Tx_Icms 	:= nTx_Icms
			Lista->Reducao 	:= nReducao
			Lista->Local		:= cLocal
			Lista->Repres		:= cRepres
			Lista->Tam			:= cTam
			Lista->CodeBar 	:= cCodeBar
			Lista->Desconto	:= nDescMax
			Lista->Servico 	:= IF( cServico = 'S', OK, FALSO )
			Lista->Atualizado := Date()
			Lista->Am			:= nAm
			Lista->Ac			:= nAc
			Lista->Mt			:= nMt
			Lista->Ro			:= nRo
			Lista->Rr			:= nRr
			Lista->Codi 		:= cCodi
			Lista->Codi1		:= cCodi1
			Lista->Codi2		:= cCodi2
			Lista->Codi3		:= cCodi3
			Lista->(Libera())
			IF lModificar
				lSair := OK
				Exit
			EndIF
			cCodigo := ProxCodigo( cCodigo)
		ElseIF nOpcao = 2 // Alterar
			Loop
		ElseIF nOpcao = 3 // Sair
			Set Key -4 To TabPreco	// F5
			Set Key -8 To
			Set Key F2 To
			Set Key F3 To
			AreaAnt( Arq_Ant, Ind_Ant )
			lSair := OK
			Exit
		EndIF
	EndDo
	IF lSair
		If !lModificar
			ResTela( cScreen )
		EndIF
		Exit
	EndIF
EndDo
ResTela( cScreen )
Set Key F5 To TabPreco
Set Key F9 To InclusaoProdutos()
Return

Function CalcMargem( nCusto, nVenda, nMargem )
**********************************************
LOCAL nPorc := nMargem
IF nVenda != 0
	nPorc := (( nVenda / nCusto ) * 100 ) - 100
	IF nPorc > 999.99
		nPorc := 999.99
	ElseIF nMargem < 0
		nPorc := 0
	EndIF
EndIF
IF nPorc > 999.99
	nPorc := 999.99
EndIF
IF nPorc < -99.99
	nPorc := -99.99
EndIF
Return( nPorc )

Function CadReducao( cClasse, nAm, nRo, nMt, nAc, nRr, cDescricao)
******************************************************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()

IF cClasse != "20" .OR. LastKey() = UP
	Return( OK )
EndIF

oMenu:Limpa()
MaBox( 10, 10, 17, 70, "INCLUSAO DE REDUCAO BASE CALCULO")
@ 11, 11 Say "Produto.....: " + cDescricao
@ 12, 11 Say "Acre........:" Get nAc Pict "999.99"
@ 13, 11 Say "Amazonas....:" Get nAm Pict "999.99"
@ 14, 11 Say "Mato Grosso.:" Get nMt Pict "999.99"
@ 15, 11 Say "Rondonia....:" Get nRo Pict "999.99"
@ 16, 11 Say "Roraima.....:" Get nRr Pict "999.99"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return( FALSO )
EndIF
ErrorBeep()
IF Conf("Pergunta: Confirma Inclusao ?")
	ResTela( cScreen )
	Return( OK )
EndIF
ResTela( cScreen )
Return( FALSO )

Function NovoArquivo()
**********************
LOCAL cTela
LOCAL xAlias := "T" + StrTran( Time(),":") + ".TMP"

Mensagem("Aguarde... Criando Arquivo de Trabalho.")
WHILE File((xAlias))
	xAlias := "T" + StrTran( Time(),":") + ".TMP"
EndDo
Return((xAlias))

Function RecErrado( Var, cCodi, nRow, nCol, cNome )
***************************************************
LOCAL aRotina			  := {{||CliInclusao()}}
LOCAL aRotinaAlteracao := {{||CliInclusao( OK )}}
LOCAL Arq_Ant			  := Alias()
LOCAL Ind_Ant			  := IndexOrd()

Area("Receber")
Receber->(Order( IF( Len( Var ) < 40, RECEBER_CODI, RECEBER_NOME )))
IF Receber->(!DbSeek( Var ))
	Receber->(Order( RECEBER_NOME ))
	Receber->(DbGoTop())
	Receber->(Escolhe( 03, 00, MaxRow()-2,"Codi + '�' + Nome + '�' + Fone + '�' + Left( Fanta, 15 )", "CODI NOME DO CLIENTE                          TELEFONE       FANTASIA", aRotina,, aRotinaAlteracao ))
	Var := IF( Len(Var) > 5, Receber->Nome, Receber->Codi )
EndIF
IF nRow != Nil
	Write( nRow, nCol, Receber->Nome )
EndIF
cNome := Receber->Nome
cCodi := Receber->Codi
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Func11()
*************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL cCida   := Space( 25 )
LOCAL cEnde   := Space( 25 )
LOCAL cNome   := Space( 40 )
LOCAL cBair   := Space( 20 )
LOCAL cCon	  := Space( 20 )
LOCAL dData   := Date()
LOCAL cCpf	  := Space( 14 )
LOCAL cRg1	  := Space( 18 )
LOCAL cEsta   := Space( 02 )
LOCAL cCep	  := Space( 09 )
LOCAL cFone   := Space( 13 )
LOCAL cObs	  := Space( 30 )
LOCAL cCt	  := Space( 10 )
LOCAL nPorc   := 0

oMenu:Limpa()
WHILE OK
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	Vendedor->(DbGoBottom())
	cCodi := StrZero(Val( Vendedor->Codiven ) + 1, 4 )
	MaBox( 06, 02, 22, 78, "INCLUSAO DE FUNCIONARIOS")
	@ 07, 24 Say Vendedor->CodiVen + " " + Vendedor->Nome
	@ 07, 03 Say "Codigo........:" Get cCodi Pict "9999" Valid FunCerto( @cCodi )
	@ 08, 03 Say "Data Cadastro.:" Get dData Pict "##/##/##"
	@ 09, 03 Say "Nome..........:" Get cNome Pict "@!"
	@ 10, 03 Say "CPF...........:" Get cCpf  Pict "999.999.999-99" Valid TestaCpf( cCpf )
	@ 11, 03 Say "Rg............:" Get cRg1  Pict "@!"
	@ 12, 03 Say "Cart.Trabalho.:" Get cCt   Pict "@!"
	@ 13, 03 Say "Endereco......:" Get cEnde Pict "@!"
	@ 14, 03 Say "Bairro........:" Get cBair Pict "@!"
	@ 15, 03 Say "Cep...........:" Get cCep  Pict "99999-999" Valid Funpleta( cCep, @cCida, @cEsta)
	@ 16, 03 Say "Cidade........:" Get cCida Pict "@!"
	@ 17, 03 Say "Estado........:" Get cEsta Pict "@!"
	@ 18, 03 Say "Telefone......:" Get cFone Pict PIC_FONE
	@ 19, 03 Say "Contato.......:" Get cCon  Pict "@!"
	@ 20, 03 Say "Observacoes...:" Get cObs  Pict "@!"
	@ 21, 03 Say "Porc Cobranca.:" Get nPorc Pict "99.99"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	nOpcao := Conf(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
	IF nOpcao = 1 // Incluir
		IF FunCerto( @cCodi )
			IF Vendedor->(Incluiu())
				Vendedor->CodiVen := cCodi
				Vendedor->Data 	:= dData
				Vendedor->Nome 	:= cNome
				Vendedor->Rg		:= cRg1
				Vendedor->Ende 	:= cEnde
				Vendedor->Bair 	:= cBair
				Vendedor->Cida 	:= cCida
				Vendedor->Con		:= cCon
				Vendedor->Obs		:= cObs
				Vendedor->Cpf		:= cCpf
				Vendedor->Esta 	:= cEsta
				Vendedor->Cep		:= cCep
				Vendedor->Fone 	:= cFone
				Vendedor->Ct		:= cCt
				Vendedor->PorcCob := nPorc
				Vendedor->(Libera())
			EndIF
			IF Conf("Cadastar Senha Deste Vendedor/Cobrador ?")
				CadastraSenha( cCodi )
			EndIF
		EndIF
	ElseIF nOpcao = 2 // Alterar
		Loop
	ElseIF nOpcao = 3 // Sair
		ResTela( cScreen )
		Exit
	EndIF
EndDo

Function FunCerto( cCodi )
**************************
LOCAL _Indice	:= IndexOrd()
LOCAL _Arquivo := Alias()
IF Empty( cCodi )
	ErrorBeep()
   Alerta( "Erro: Codigo de vendedor invalido.")
	Return( FALSO )
EndIF
Vendedor->(Order( VENDEDOR_CODIVEN ))
IF Vendedor->(!DbSeek(cCodi))
	AreaAnt( _Arquivo, _Indice )
	Return(OK)
EndIF
ErrorBeep()
Alerta( "Erro: Codigo de vendedor ja registrado.")
cCodi := StrZero( Val( cCodi ) + 1,4)
AreaAnt( _Arquivo, _Indice )
Return( FALSO )

Function FunPleta( cCep, cCida, cEsta )
***************************************
IF cCep	= XCCEP
	cCida := XCCIDA
	cEsta := XCESTA
	KEYB Chr(ENTER) + Chr(ENTER)
EndIF
Return( OK )

Proc CadastraSenha( cCodi )
***************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lParametro := FALSO
LOCAL Passe
LOCAL cSenha

oMenu:Limpa()
WHILE OK
	Area("Vendedor")
	Vendedor->(Order( VENDEDOR_CODIVEN ))
	MaBox( 15, 11, 17, 67 )
	IF cCodi = NIL
		cCodi := Space(04)
	EndIF
	@ 16, 12 Say "Codigo..:" Get cCodi Pict "9999" Valid FunErrado( @cCodi,, 16, 27 )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Exit
	EndIF
	IF !Empty( Vendedor->Senha )
		ErrorBeep()
		IF !Conf("Pergunta: Senha do Vendedor Ja Registrada, Trocar ?")
			Loop
		EndIF
		cSenha := Decrypt( Vendedor->Senha )
		MaBox( 18, 11, 20, 40 )
		Write( 19, 12, "Anterior..: " )
		Passe  := Senha( 19, 25, 14 )
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		IF ( RTrim( cSenha ) != RTrim( Passe ))
			ErrorBeep()
			Alerta("Erro: Senha Nao Confere.")
			ResTela( cScreen )
			Loop
		EndIF
	EndIF
	MaBox( 18, 11, 20, 45 )
	Write( 19, 12, "Nova Senha.....: " )
	Passe := Senha( 19, 30, 14 )
	ErrorBeep()
	IF Conf( "Pergunta: Confirma Registro da Senha ?")
		Passe := Encrypt( Passe )
		IF Vendedor->(TravaReg())
			Vendedor->Senha := Passe
			Vendedor->(Libera())
		EndIF
	EndIF
	ResTela( cScreen )
	AreaAnt( Arq_Ant, Ind_Ant )
	Exit
EndDo

Function FunErrado( Var, cCodi, nCol, nRow, cNome )
***************************************************
LOCAL aRotina := {{||Func11()}}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area( "VendeDor")
Vendedor->(Order( IF( Len( Var ) < 40, VENDEDOR_CODIVEN, VENDEDOR_NOME )))
IF Vendedor->(!DbSeek( Var ))
	Vendedor->(Order( VENDEDOR_NOME ))
	Vendedor->(Escolhe( 03, 01, MaxRow()-2, "CodiVen + '�' + Nome", "CODI NOME DO VENDEDOR", aRotina ))
	Var := IF( Len( Var ) > 4, Vendedor->Nome, Vendedor->CodiVen )
EndIF
cCodi := Vendedor->CodiVen
IF cNome != NIL
	cNome := Vendedor->Nome
EndIF
IF nCol != NIL
	Write( nCol, nRow, Vendedor->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function FunAcha( cCpf )
***********************
LOCAL aRotina := {{||Func11()}}

IF Vendedor->(!DbSeek( cCpf ))
	Vendedor->(Escolhe( 03, 01, MaxRow()-2, "CodiVen + '�' + Nome", "CODI NOME DO VENDEDOR", aRotina ))
	IF( Len( cCpf ) > 14, cCpf := Vendedor->Nome, cCpf := Vendedor->Cpf )
EndIF
Return( OK )

Function FazBrowse( nLinT, nColT, nLinB, nColb, cCabecalho )
************************************************************
LOCAL oBrowse		:= TBrowseDb( nLint, nColt, nLinb, nColb )
LOCAL cFrame2		:= SubStr( oAmbiente:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oAmbiente:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oAmbiente:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oAmbiente:Frame, 6, 1 )
LOCAL oColuna1
LOCAL oColuna2
LOCAL oColuna3
LOCAL oColuna4
LOCAL oColuna5
LOCAL oColuna6
LOCAL oColuna7
LOCAL oColuna8
LOCAL oColuna9
LOCAL oColuna10

FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario
FIELD Local

oBrowse:HeadSep	:= cFrame2 + cFrame3 + cFrame2
oBrowse:ColSep 	:= Chr(032) + cFrame4 + Chr(032)
oBrowse:FootSep	:= cFrame2	+ cFrame2 + cFrame2
oBrowse:colorSpec := "N/W, W+/G, B/W, B/BG, B/W, B/BG, R/W, W+/R"
oColuna1 			:= TBColumnNew( "QUANT"             ,  {|| Quant } )
oColuna2 			:= TBColumnNew( "CODI",                {|| Codigo } )
oColuna3 			:= TBColumnNew( "DESCRICAO DO PRODUTO",{|| Descricao } )
oColuna4 			:= TBColumnNew( "UNITARIO",            {|| Tran(Unitario,"@E 99,999,999.99")})
oColuna5 			:= TBColumnNew( "TOTAL ITEM",          {|| Tran(Unitario * Quant ,"@E 9,999,999,999.99")})
oColuna6 			:= TBColumnNew( "CUSTO",               {|| Tran(Pcusto, "@E 999,999.99")})
oColuna7 			:= TBColumnNew( "TOTAL CUSTO",         {|| Tran(Pcusto * Quant, "@E 999,999.99")})
oColuna8 			:= TBColumnNew( "MARGEM",              {|| Tran(((Unitario/Pcusto)*100)-100, "@E 999.99%")})
oColuna9 			:= TBColumnNew( "CMV",                 {|| Tran(((Pcusto/Unitario)*100), "@E 999.99%")})
oColuna10			:= TBColumnNew( "LOCAL",               {|| Local })
oBrowse:AddColumn( oColuna1 )
oBrowse:AddColumn( oColuna2 )
oBrowse:AddColumn( oColuna3 )
oBrowse:AddColumn( oColuna4 )
oBrowse:AddColumn( oColuna5 )
oBrowse:AddColumn( oColuna6 )
oBrowse:AddColumn( oColuna7 )
oBrowse:AddColumn( oColuna8 )
oBrowse:AddColumn( oColuna9 )
oBrowse:AddColumn( oColuna10)
oColuna1:DefColor := {7,8 }
oColuna4:DefColor := {7,8 }
oColuna5:DefColor := {7,8 }
oColuna6:DefColor := {7,8 }
oColuna7:DefColor := {7,8 }
oColuna8:DefColor := {7,8 }
oColuna9:DefColor := {7,8 }
oColuna2:Width 	:= 6
oColuna3:Width 	:= 20
Return( oBrowse )

Function BrowseEntradas( nLinT, nColT, nLinB, nColb, cCabecalho )
****************************************************************
LOCAL oBrowse		:= TBrowseDb( nLint, nColt, nLinb, nColb )
LOCAL cFrame2		:= SubStr( oAmbiente:Frame, 2, 1 )
LOCAL cFrame3		:= SubStr( oAmbiente:Frame, 3, 1 )
LOCAL cFrame4		:= SubStr( oAmbiente:Frame, 4, 1 )
LOCAL cFrame6		:= SubStr( oAmbiente:Frame, 6, 1 )
LOCAL oColuna1
LOCAL oColuna2
LOCAL oColuna3
LOCAL oColuna4
LOCAL oColuna5
FIELD Quant
FIELD Codigo
FIELD Descricao
FIELD Unitario

oBrowse:HeadSep	:= cFrame2 + cFrame3 + cFrame2
oBrowse:ColSep 	:= Chr(032) + cFrame4 + Chr(032)
oBrowse:FootSep	:= cFrame2	+ cFrame2 + cFrame2
oBrowse:colorSpec := "N/W, W+/G, B/W, B/BG, B/W, B/BG, R/W, W+/R"
oColuna1 			:= TBColumnNew( "QUANT"             ,  {|| Quant } )
oColuna2 			:= TBColumnNew( "CODI",                {|| Codigo } )
oColuna3 			:= TBColumnNew( "DESCRICAO DO PRODUTO",{|| Descricao } )
oColuna4 			:= TBColumnNew( "CUSTO NFF",           {|| Tran(Unitario,"@E 99,999,999.99")})
oColuna5 			:= TBColumnNew( "TOTAL ITEM",          {|| Tran(Unitario * Quant ,"@E 9,999,999,999.99")})
oColuna6 			:= TBColumnNew( "FRETE",               {|| Tran(Frete,    "999.99")})
oColuna7 			:= TBColumnNew( "IMPOSTO",             {|| Tran(Imposto,  "999.99")})
oColuna8 			:= TBColumnNew( "CUSTO FINAL",         {|| Tran(CustoFinal, "@E 999,999.99")})
oBrowse:AddColumn( oColuna1 )
oBrowse:AddColumn( oColuna2 )
oBrowse:AddColumn( oColuna3 )
oBrowse:AddColumn( oColuna4 )
oBrowse:AddColumn( oColuna5 )
oBrowse:AddColumn( oColuna6 )
oBrowse:AddColumn( oColuna7 )
oBrowse:AddColumn( oColuna8 )
oColuna1:DefColor := {7,8 }
oColuna4:DefColor := {7,8 }
oColuna5:DefColor := {7,8 }
oColuna6:DefColor := {7,8 }
oColuna7:DefColor := {7,8 }
oColuna2:Width 	:= 6
oColuna3:Width 	:= 20
Return( oBrowse )

Function BaixaDocnr( cDocnr, nRegistro )
****************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL xTodos	 := {}
LOCAL cCodi 	 := Space(05)
LOCAL nChoice	 := 0
LOCAL xLen		 := 0
LOCAL nT 		 := 0

oMenu:Limpa()
MaBox( 15, 01, 17, 78 )
@ 16, 02 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, 16, 35 )
Read
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Area("Recemov")
Recemov->(Order( RECEMOV_CODI ))
IF Recemov->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
WHILE Recemov->Codi = cCodi
	Recemov->(Aadd( xTodos, {Docnr, Emis, Vcto, Vlr, Recno(), Obs}))
	Recemov->(DbSkip(1))
EndDo
IF (nTam := Len( xTodos )) = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Asort( xTodos,,, {|x,y|y[3]>x[3]}) // ordenar por vcto
xLen := Len(xTodos)
For nT := 1 To xLen
	Aadd( aDocnr,	  xTodos[nT,1])
	Aadd( aRegistro, xTodos[nT,5])
	Aadd( aTodos,	  xTodos[nT,1] + " " + Dtoc(xTodos[nT,2]) + " " + Dtoc(xTodos[nT,3]) + " " + Tran(xTodos[nT,4],"@E 999,999,999.99") + " " + xTodos[nT,6])
Next
MaBox( 01, 01, 14, 78, "DOCTO  N�  EMISSAO   VENCTO          VALOR OBSERVACAO" + Space(23))
nChoice := aChoice( 02, 02, 13, 77, aTodos )
ResTela( cScreen )
IF nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	Alerta( "Erro: Procura Cancelada..." )
	ResTela( cScreen )
	Return( FALSO )
EndIF
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Proc Autenticar( nRecno, nSobra )
*********************************
LOCAL cScreen := SaveScreen()
LOCAL cValor  := Space(0)
LOCAL nValor  := Space(0)
LOCAL cHist   := Space(60)
LOCAL nVlr	  := 0
LOCAL Larg	  := 76
LOCAL nOpcao  := 1
LOCAL cDocnr

Receber->(Order( RECEBER_CODI ))
Area("Recebido")
Set Rela To Codi Into Receber
Recebido->(Order( RECEBIDO_DOCNR ))
Recebido->(DbGoTo( nRecno ))
cDocnr := Recebido->Docnr
nVlr	 := Recebido->VlrPag
cValor := AllTrim( Tran( nVlr,'@E 999,999.99'))
ErrorBeep()
For i := 1 To 3
	IF !Instru80()
		Recebido->(DbClearRel())
		Restela( cScreen )
		Return
	EndIF
	Mensagem("Aguarde, Autenticando.")
	PrintOn()
	FPrInt( PQ )
	SetPrc(0,0)
	Qout("*MP*" + cDocnr + "*" + Dtoc( Date()) + "*" + cValor + "*" + Left( Receber->Nome,4 ) + "*")
	Qout("*MP*" + cDocnr + "*" + Dtoc( Date()) + "*" + cValor + "*" + Left( Receber->Nome,4 ) + "*")
	PrintOff()
Next
ResTela( cScreen )
Return

Function DocErrado( Var, nValor, nVlrTotal, dVcto, cHist, nRow, nCol )
**********************************************************************
LOCAL Arq_Ant		 := Alias()
LOCAL Ind_Ant		 := IndexOrd()
LOCAL nRegistro	 := 0
LOCAL cComplemento := Space(0)
LOCAL cString		 := Space(0)
LOCAL nTam

#IFDEF MICROBRAS
	cComplemento := "PAG PARCIAL "
	cString		 := "PARCELA CONTRATO SERVICOS DE INTERNET."
	cHist 		 := cString + Space(60-Len(cString))
#ENDIF

Receber->(Order( RECEBER_CODI ))
Area("Recemov")
IF ( Recemov->(DbGoTop()), Recemov->(Eof()))
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	Return( FALSO )
EndIF
IfNil( nVlrTotal, 0)
IF ( Recemov->(Order( RECEMOV_DOCNR )), Recemov->(!DbSeek( Var )))
	ErrorBeep()
	IF Conf("Erro: Documento nao Encontrado. Localizar por Nome?")
		IF BaixaDocnr( @Var, @nRegistro )
			Recemov->( DbGoTo( nRegistro ))
         nValor    := Round(IF( nVlrTotal <= 0, Recemov->Vlr, nVlrTotal),2)
         nVlrTotal := Round(IF( nVlrTotal <= 0, CalcJuros(), nVlrTotal),2)
			dVcto 	 := Recemov->Vcto
			nTam		 := Len(AllTrim(Recemov->Obs))
			cHist 	 := IF( Empty(Recemov->Obs), cComplemento + cHist, cComplemento + Left(Recemov->Obs,nTam) + Space((60-12-nTam)))
			IF nRow != NIL
				Write( nRow, nCol, Receber->Nome )
			EndIF
			AreaAnt( Arq_Ant, Ind_Ant )
			Return( OK )
		EndIF
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Area("Recemov")
	Recemov->(Order( RECEMOV_DOCNR ))
	Set Rela To Recemov->Codi Into Receber
	Recemov->(DbGoTop())
	Recemov->(Escolhe( 03, 01, MaxRow()-2, "Docnr + '�' + Receber->Nome", "DOCTO N�  NOME DO CLIENTE" ))
EndIF
Var		 := Recemov->Docnr
nValor    := Round(IF( nVlrTotal <= 0, Recemov->Vlr, nVlrTotal),2)
nVlrTotal := Round(IF( nVlrTotal <= 0, CalcJuros(), nVlrTotal),2)
dVcto 	 := Recemov->Vcto
nTam		 := Len(AllTrim(Recemov->Obs))
cHist 	 := IF( Empty(Recemov->Obs), cComplemento + cHist, cComplemento + Left(Recemov->Obs,nTam) + Space((60-12-nTam)))
IF nRow != NIL
	Write( nRow, nCol, Receber->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function CheErrado( cCodi, cCodi1, nLinha, nCol, lOpcional )
************************************************************
LOCAL aRotina := {{|| Cheq11() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Codi
FIELD Titular
MEMVAR cField_Name
MEMVAR cName_Cabec

IF LastKey() = UP
	Return( OK )
EndIF
IF lOpcional != Nil
	IF Empty( cCodi )
		IF nLinha != Nil
			Write( nLinha, nCol, "MOVIMENTO CONTRA PARTIDA NAO LANCADO")
		EndIF
		Keyb Chr( ENTER )
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	EndIF
EndIF
Area("Cheque")
Order( IF( Len( cCodi ) < 40, CHEQUE_CODI, CHEQUE_TITULAR ))
IF !( DbSeek( cCodi ) )
	Order( CHEQUE_TITULAR )
	DbGoTop()
	Escolhe( 03, 01, MaxRow()-2, "Codi + '�' + Titular","CODI TITULAR DA CONTA", aRotina  )
	cCodi  := IF( Len( cCodi ) = 4, Codi,	  Titular )
	IF cCodi1 != Nil
		cCodi1 := IF( Len( cCodi1 ) = 4, Codi, 	Titular )
	EndIF
EndIF
IF nLinha != Nil
	Write( nLinha, nCol, Titular )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Proc Paga22( cCaixa )
*********************
LOCAL cScreen := SaveScreen( )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL GetList := {}
LOCAL nLancar := 0
LOCAL cDocnr
LOCAL dData
LOCAL nVlr
LOCAL cFone
LOCAL cPort
LOCAL nDebito
LOCAL nJuro
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cEnde
LOCAL nRecno
LOCAL cCodi
LOCAL cNome
LOCAL dEmis
LOCAL dVcto
LOCAL ctipo
LOCAL cDc
LOCAL nAtraso
LOCAL nTotJuros
LOCAL nVlrTotal
LOCAL nVlrPago
LOCAL cCodiCx
LOCAL lOk_Baixo
LOCAL nRecno1
LOCAL cFatura
LOCAL cCodiCx1
LOCAL cCodiCx2
LOCAL cCodiCx3
LOCAL cDc1
LOCAL cDc2
LOCAL cDc3
LOCAL cObs1
LOCAL cObs2
LOCAL cHist
LOCAL nCol
LOCAL nRow
LOCAL nJuroDia
LOCAL lEmitir
LOCAL nChSaldo
LOCAL cHist2
LOCAL nDiferenca

FIELD Nome
FIELD CodiVen
FIELD Vlr
FIELD Fone
FIELD Port
FIELD Tipo
FIELD Cida
FIELD Ende
FIELD Codi
FIELD Emis
FIELD Vcto
FIELD Esta
FIELD Cep
FIELD Juro
FIELD Docnr

IF !PodePagar()
	ResTela( cScreen )
	Return
EndIF

WHILE OK
	oMenu:Limpa()
	MaBox( 15, 10, 17, 31 )
	cDocnr := Space( 09 )
	@ 16, 11 Say "Doc.No.." Get cDocnr Pict  "@!" Valid PgDocErrad( @cDocnr )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	IF Pagamov->(!TravaReg())
		Loop
	EndIF
	Pagar->(Order( PAGAR_CODI ))
	Area( "PagaMov" )
	Set Rela To Codi Into Pagar
	dData 	 := Date()
	nVlr		 := Pagamov->Vlr
	cPort 	 := Pagamov->Port
	cTipo 	 := Pagamov->Tipo
	nJuro 	 := Pagamov->Juro
	cDocnr	 := Pagamov->Docnr
	cFatura	 := Pagamov->Fatura
	cCodiCx	 := "0000"
	cCodiCx1  := Space(04)
	cCodiCx2  := Space(04)
	cCodiCx3  := Space(04)
	cDc		 := "D"
	cDc1		 := "D"
	cDc2		 := "C"
	cDc3		 := "C"
	cCodi 	 := Pagamov->Codi
	dEmis 	 := Pagamov->Emis
	dVcto 	 := Pagamov->Vcto
	nVlr		 := Pagamov->Vlr
	cObs1 	 := Pagamov->Obs1
	cObs2 	 := Pagamov->Obs2
	cNome 	 := Pagar->Nome
	cHist 	 := "PAG " + cNome
	WHILE OK
		nCol := 06
		nRow := 02
		MaBox( 02, 05 , nRow+18 , 79, "PAGAMENTOS" )
		@ nRow+01, nCol	 SAY "Fornecedor..: " + Pagar->Codi + " " + Pagar->Nome
		@ nRow+02, nCol	 SAY "Tipo........: " + cTipo
		@ nRow+02, nCol+35 SAY "Docto N�....: " + cDocnr
		@ nRow+03, nCol	 SAY "Emissao.....: " + Dtoc( Emis )
		@ nRow+03, nCol+35 SAY "Vencto......: " + Dtoc( Vcto )
		@ nRow+04, nCol	 SAY "Juros Mes...: " + Tran( nJuro , "@E 9,999,999,999.99" )
		@ nRow+04, nCol+35 SAY "Dias Atraso.: "
		@ nRow+05, nCol	 SAY "Valor.......: " + Tran( Vlr ,      "@E 9,999,999,999.99" )
		@ nRow+05, nCol+35 SAY "Desconto....: " + Tran( Desconto , "@E 999.99" )
		@ nRow+06, nCol	 SAY "Jrs Devidos.: "
		@ nRow+07, nCol	 SAY "Vlr c/Juros.: "
		@ nRow+07, nCol+35 SAY "Vlr c/ Desc.: "
		@ nRow+08, nCol	 SAY "Data Pgto...: " Get dData Pict "##/##/##"
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		nAtraso	:= Atraso( dData, Vcto )
		nJuroDia := JuroDia( Vlr, nJuro )
		IF nAtraso <= 0
			nTotJuros := 0
			nVlrTotal := Vlr
			nVlrTotal -= Desconto
		Else
			nTotJuros := ( nAtraso * nJuroDia )
			nVlrTotal := ( nTotJuros + Vlr )
		EndIF
		nVlrPago := nVlrTotal

		Write( nRow+04, nCol+35, "Dias Atraso.: " + Tran( nAtraso,   "99999") + " Dias" )
		Write( nRow+06, nCol,	 "Jrs Devidos.: " + Tran( nTotJuros, "@E 9,999,999,999.99"))
		Write( nRow+07, nCol,	 "Vlr c/juros.: " + Tran( nVlrTotal, "@E 9,999,999,999.99"))
		Write( nRow+07, nCol+35, "Vlr c/ Desc.: " + Tran( nVlrPago,  "@E 9,999,999,999.99"))

		@ nRow+09, nCol	 Say "Valor Pago..: " GET nVlrPago Pict "@E 9,999,999,999.99"
		@ nRow+10, nCol	 Say "Portador....: " GET cPort    Pict "@!"
		@ nRow+11, nCol	 Say "Conta Caixa.: " GET cCodiCx  Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx,,  Row(), 35 )
		@ nRow+11, nCol+20 Say "D/C.:"          GET cDc      Pict "!" Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )
		@ nRow+12, nCol	 Say "C. Partida..: " GET cCodiCx1 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx1,, Row(), 35, OK )
		@ nRow+12, nCol+20 Say "D/C.:"          GET cDc1     Pict "!" Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )
		@ nRow+13, nCol	 Say "C. Partida..: " GET cCodiCx2 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx2,, Row(), 35, OK )
		@ nRow+13, nCol+20 Say "D/C.:"          GET cDc2     Pict "!" Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )
		@ nRow+14, nCol	 Say "C. Partida..: " GET cCodiCx3 Pict "9999" Valid LastKey() = UP .OR. CheErrado( @cCodiCx3,, Row(), 35, OK )
		@ nRow+14, nCol+20 Say "D/C.:"          GET cDc3     Pict "!" Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc3 )
		@ nRow+15, nCol	 Say "Historico...: " GET cHist    Pict "@!" Valid LastKey() = UP .OR. !Empty( cHist )
		@ nRow+16, nCol	 Say "Observacoes.: " GET cObs1    Pict "@!"
		@ nRow+17, nCol	 Say "Observacoes.: " GET cObs2    Pict "@!"
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		lOk_Baixo := Conf(" Pergunta: Baixar Registro ? ", {" Sim ", " Alterar ", " Sair " })
		IF 	 lOk_Baixo = 2 // Alterar
			Loop
		ElseIf lOk_Baixo = 1 // Baixar
			lEmitir := 1
			IF nVlrPago <> nVlrTotal
				ErrorBeep()
				lEmitir := Conf("Valor pago diferente que o devido.;;Pergunta: Fazer Baixa como:",;
									  {"Quitar", "Parcial", "Diferenca C/C", "Cancelar"})
				IF lEmitir = 4
					Loop
				EndIF
				IF lEmitir = 3
					cCodiCx2 := Space(04)
					cDc2		:= " "
					cHist2	:= cHist
					MaBox( nRow+15, 05 , nRow+18 , 74, "LANCAMENTOS DIFERENCA C/C")
					@ nRow+16, nCol	 Say "Conta Caixa.: " GET cCodiCx2  Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28 )
					@ nRow+16, nCol+20 Say "D/C.:"          GET cDc2      Pict "!" Valid cDc2 $ "DC"
					@ nRow+17, nCol	 Say "Historico...: " GET cHist2    Pict "@!" Valid !Empty( cHist2 )
					Read
					IF LastKey() = ESC
						Loop
					EndIF
					ErrorBeep()
					IF !Conf("Pergunta: Confirma Lancamento ?")
						Loop
					EndIF
				EndIF
			EndIF
			//:**************************************************
			IF Pago->(!Incluiu())	  ; DbUnLockAll() ; Loop ; EndIF
			IF Chemov->(!Incluiu())   ; DbUnLockAll() ; Loop ; EndIF
			Cheque->(Order( CHEQUE_CODI ))
			IF Cheque->(!DbSeek( cCodiCx )) ; DbUnLockAll() ; Loop ; EndIF
			IF Cheque->(!TravaReg())		  ; DbUnLockAll() ; Loop ; EndIF
			//:**************************************************
			IF lEmitir = 2 // Parcial
				IF nVlrPago < nVlrTotal
					IF lEmitir = 2 // Parcial
						Pagamov->Emis := dData
						Pagamov->Vcto := dData
						Pagamov->Vlr  := ( nVlrTotal - nVlrPago )
					EndIF
				EndIF
			Else
				Pagamov->(DbDelete())
			EndIF
			Pagamov->(Libera())

			Pago->Codi	  := cCodi
			Pago->Docnr   := cDocnr
			Pago->Fatura  := cFatura
			Pago->Emis	  := dEmis
			Pago->Vcto	  := dVcto
			Pago->Vlr	  := nVlr
			Pago->DataPag := dData
			Pago->VlrPag  := nVlrPago
			Pago->Port	  := cPort
			Pago->Tipo	  := cTipo
			Pago->Juro	  := nJuro
			Pago->nDeb	  := "NAO"
			Pago->Obs1	  := cObs1
			Pago->Obs2	  := cObs2
			Pago->(Libera())

			//*********************************************************************//
			nChSaldo := Cheque->Saldo
			IF cDc = "C"
				nChSaldo 	+= nVlrPago
				Chemov->Cre := nVlrPago
			Else
				nChSaldo 	 -= nVlrPago
				Chemov->Deb  := nVlrPago
			EndIF
			Chemov->Codi	  := cCodiCx
			Chemov->Docnr	  := cDocnr
			Chemov->Fatura   := cFatura
			Chemov->Emis	  := dData
			Chemov->Data	  := dData
			Chemov->Baixa	  := Date()
			Chemov->Hist	  := cHist
			Chemov->Saldo	  := nChSaldo
			Chemov->Tipo	  := "PG"
			Chemov->Caixa	  := IF( cCaixa = Nil, Space(4), cCaixa )
			Chemov->CPartida := FALSO
			Chemov->(Libera())
			Cheque->Saldo	:= nChSaldo
			//*********************************************************************//
			IF Cheque->(DbSeek( cCodiCx1 ))
				IF Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc1 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						EndIF
						Chemov->Codi	:= cCodiCx1
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->CPartida := OK
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					EndIF
				EndIF
			EndIF
			//*********************************************************************//
			IF Cheque->(DbSeek( cCodiCx2 ))
				IF Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc2 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						EndIF
						Chemov->Codi	:= cCodiCx2
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					EndIF
				EndIF
			EndIF
			//*********************************************************************//
			IF Cheque->(DbSeek( cCodiCx3 ))
				IF Cheque->(TravaReg())
					nChSaldo   := Cheque->Saldo
					IF Chemov->(Incluiu())
						IF cDc3 = "C"
							nChSaldo 	+= nVlrPago
							Chemov->Cre := nVlrPago
						Else
							nChSaldo 	 -= nVlrPago
							Chemov->Deb  := nVlrPago
						EndIF
						Chemov->Codi	:= cCodiCx3
						Chemov->Docnr	:= cDocnr
						Chemov->Fatura := cFatura
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= "PG"
						Chemov->(Libera())
						Cheque->Saldo := nChSaldo
					EndIF
				EndIF
			EndIF
			//*********************************************************************//
			IF lEmitir = 3
				IF Cheque->(DbSeek( cCodiCx2 ))
					IF Cheque->(TravaReg())
						nChSaldo := Cheque->Saldo
						IF nVlrTotal < nVlrpago
							nDiferenca := nVlrPago - nVlrTotal
						Else
							nDiferenca := nVlrTotal - nVlrPago
						EndIF
						IF Chemov->(Incluiu())
							IF cDc2 = "C"
								nChSaldo 	+= nDiferenca
								Chemov->Cre := nDiferenca
							Else
								nChSaldo 	 -= nDiferenca
								Chemov->Deb  := nDiferenca
							EndIF
							Chemov->Codi	:= cCodiCx2
							Chemov->Docnr	:= cDocnr
							Chemov->Fatura := cFatura
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= cHist2
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= "DF"  // Tipo Diferenca C/C
							//Chemov->Caixa  := IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->(Libera())
							Cheque->Saldo	:= nChSaldo
						EndIF
					EndIF
				EndIF
			EndIF
			Cheque->(Libera())
		EndIF
		Exit
	EndDo
	DbUnLockAll()
	Pagamov->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
EndDo

Function PgDocErrad( cDocnr )
****************************
LOCAL cScreen	 := SaveScreen()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL Arq_Ant	 := Alias()
LOCAL nRegistro := 0
FIELD Docnr
FIELD Emis
FIELD Vcto
FIELD Vlr

Pagar->(Order( PAGAR_CODI ))
Area("Pagamov")
IF ( Pagamov->(DbGoTop()), Pagamov->(Eof()))
	AreaAnt( Arq_Ant, Ind_Ant )
	Nada()
	Return( FALSO )
EndIF
IF ( Pagamov->(Order( PAGAMOV_DOCNR )), Pagamov->(!DbSeek( cDocnr )))
	ErrorBeep()
	IF Conf("Erro: Documento nao Encontrado. Localizar por Nome ?.")
		IF BaixaPag( @cDocnr, @nRegistro )
			Pagamov->( DbGoTo( nRegistro ))
			AreaAnt( Arq_Ant, Ind_Ant )
			Return( OK )
		EndIF
		Pagar->(Order( PAGAR_CODI ))
		Area("Pagamov")
		Pagamov->(Order( PAGAMOV_DOCNR ))
		Set Rela To Pagamov->Codi Into Pagar
	EndIF
	Pagamov->(DbGoTop())
	Pagamov->(Escolhe( 03, 00, 22, "Docnr + '�' + Dtoc( Emis ) + '�' + Dtoc( Vcto ) + '�' + Tran( Vlr, '@E 999,999.99') + '�' + Left( Pagar->Nome, 37 )", "DOCTO N�  EMISSAO  VCTO         VALOR  NOME DO FORNECEDOR"))
	cDocnr := Pagamov->Docnr
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function BaixaPag( cDocnr, nRegistro )
**************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(04)
LOCAL nChoice	 := 0

oMenu:Limpa()
MaBox( 15, 10, 17, 78 )
@ 16, 11 Say "Fornecedor......: " Get cCodi Pict '9999' Valid Pagarrado( @cCodi,, Row(), Col()+1 )
Read
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Area("Pagamov")
Pagamov->(Order( PAGAMOV_CODI ))
IF Pagamov->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto Deste fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
WHILE Pagamov->Codi = cCodi
	Aadd( aDocnr,	  Pagamov->Docnr )
	Aadd( aRegistro, Pagamov->(Recno()))
	Aadd( aTodos,	  Pagamov->Docnr + " " + Dtoc( Pagamov->Emis ) + " " + Dtoc( Pagamov->Vcto ) + " " + Tran( Pagamov->Vlr, "@E 999,999,999.99"))
	Pagamov->(DbSkip(1))
EndDo
nTam := Len( aTodos )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Debito em Aberto deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
MaBox( 00, 10, 14, 53, "DOCTO  N�  EMISSAO   VENCTO          VALOR")
nChoice := aChoice( 01, 11, 13, 52, aTodos )
ResTela( cScreen )
IF nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	Alerta( "Erro: Procura Cancelada..." )
	ResTela( cScreen )
	Return( FALSO )
EndIF
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function TestaTecla( nKey, oBrowse )
************************************
IF 	 nKey == K_UP
	oBrowse:up()				  // move o cursor para cima
ElseIf nKey == K_DOWN
	oBrowse:down() 			  // move o cursor para baixo
ElseIf nKey == K_LEFT
	oBrowse:Left() 			  // move o cursor para esquerda
ElseIf nKey == K_RIGHT
	oBrowse:Right()			  // move o cursor para direita
ElseIf nKey == K_HOME
	oBrowse:home() 			  // move o cursor para primeira coluna
ElseIf nKey == K_END
	oBrowse:end()				  // move o cursor para ultima coluna
ElseIf nKey == K_PGUP
	oBrowse:pageUp()			  // move fonte de dados uma tela acima
ElseIf nKey == K_PGDN
	oBrowse:pageDown()		  // move fonte de dados uma tela abaixo
ElseIf nKey == K_CTRL_PGUP
	oBrowse:gotop()			  // move o cursor para baixo
ElseIf nKey == K_CTRL_PGDN
	oBrowse:goBottom()		  // move o cursor para esquerda
ElseIf nKey == K_CTRL_HOME
	oBrowse:panHome() 		  // move o cursor para direita
ElseIf nKey == K_CTRL_END
	oBrowse:panEnd()			  // move o cursor para primeira coluna
ElseIf nKey == K_CTRL_LEFT
	oBrowse:panLeft() 		  // move o cursor para ultima coluna
ElseIf nKey == K_CTRL_RIGHT
	oBrowse:panRight()		  // move fonte de dados uma tela acima
EndIF
Return VOID

Function Vlr_Icms( porc_icms, vlr_compra, vlr_icms )
****************************************************
Vlr_Icms := ( Vlr_Compra * Porc_Icms ) / 100
Write( 07, 48, Str( Vlr_Icms, 13, 2 ) )
Return( OK )

Function Desconto( nDesc, nTotal, nTot )
****************************************
IF LastKey() = UP
	nTot := nTotal
Else
	nTot := ( nTotal - nDesc )
EndIF
Return(OK)

Function Mostra_Vlr( vlr_titu, vlr_mer )
****************************************
IF Vlr_titu < vlr_mer
	ErrorBeep()
	Alerta( "Erro: Valor da Fatura Menor que a Soma das Mercadorias " )
	Return( FALSO )

EndIF
Return( OK )

Function SomaData( d_Vcto, d_Emis, n_Conta)
*******************************************
d_Vcto := ( d_Emis + n_Conta )
Return( OK )

Function DocFucer( cDocnr, lManutencao )
****************************************
IF Empty( cDocnr )
	 ErrorBeep()
	 Alerta( "Erro: Codigo Documento Invalido...")
	 Return( FALSO )
EndIF
IF lManutencao = NIL
	IF DbSeek( cDocnr )
		ErrorBeep()
		Alerta( "Erro: Documento Ja Registrado ..." )
		Return( FALSO )
	EndIF
EndIF
Return( OK )

Function CheqDoc( var )
***********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( Var ) )
	ErrorBeep()
	M_DisPlay("Erro: Numero Documento Invalido ...", Roloc(Cor()))
	Return( FALSO )
EndIF
Area("CheMov")
Order( CHEMOV_DOCNR )
IF ( DbSeek( Var ) )
	ErrorBeep()
	M_DisPlay("Erro: Numero Documento Ja Registrado...", Roloc(Cor()))
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )


Function VisualEntraFatura( cDocnr, nVlrFatura, cCodi )
*******************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nRegistro := 0

IF LastKey() = UP
	Return( OK )
EndIF

IF ( Entradas->(DbGoTop()), Entradas->(Eof()))
	Nada()
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return(FALSO)
EndIF
Pagar->(Order( PAGAR_CODI))
Area("Entradas")
Entradas->(Order( ENTRADAS_FATURA ))
IF ( Entradas->(Order( ENTRADAS_FATURA )), Entradas->(!DbSeek( cDocnr )))
	ErrorBeep()
	IF Conf("Erro: Documento nao Encontrado. Localizar por Fornecedor ?")
		IF LocalizaEntrada( @cDocnr, @nRegistro )
			EntNota->( DbGoTo( nRegistro ))
			cDocnr := EntNota->Numero
		EndIF
	Else
		Pagar->(Order( PAGAR_CODI))
		Area("EntNota")
		Set Rela To EntNota->Codi Into Pagar
		EntNota->(Order( ENTNOTA_NUMERO ))
		Escolhe( 03, 01, 22, "Numero + '�' + Pagar->Nome", "FATURA  NOME DO FORNECEDOR")
		EntNota->(DbClearRel())
		cDocnr := EntNota->Numero
	EndIF
	Area("Entradas")
	Entradas->(Order( ENTRADAS_FATURA ))
	IF Entradas->(!( DbSeek( cDocnr ) ))
		ErrorBeep()
		Alerta( "Erro: Nenhum Produto Relacionado a este Documento.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
EndIF
IF cCodi != Nil
	IF Entradas->Codi != cCodi
		ErrorBeep()
		Alerta( "Erro: Fatura nao e deste Fornecedor.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
EndIF
IF nVlrFatura != Nil
	nVlrFatura := Entradas->VlrFatura
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function VisualAchaFatura( cDocnr, nVlrFatura, cCodi )
******************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nRegistro := 0

IF LastKey() = UP
	Return( OK )
EndIF

IF ( Saidas->(DbGoTop()), Saidas->(Eof()))
	Nada()
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return(FALSO)
EndIF
Receber->(Order( RECEBER_CODI))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA ))
IF ( Saidas->(Order( SAIDAS_FATURA )), Saidas->(!DbSeek( cDocnr )))
	ErrorBeep()
	IF Conf("Erro: Documento nao Encontrado. Localizar por Nome ?.")
		IF LocalizaFatura( @cDocnr, @nRegistro )
			Nota->( DbGoTo( nRegistro ))
			cDocnr := Nota->Numero
		EndIF
	Else
		Receber->(Order( RECEBER_CODI))
		Area("Nota")
		Set Rela To Nota->Codi Into Receber
		Nota->(Order( NOTA_NUMERO ))
		Escolhe( 03, 01, 22, "Numero + '�' + Receber->Nome+ '�' + Situacao + '�' + Caixa", "FATURA  NOME DO CLIENTE                         SITUACAO USER")
		Nota->(DbClearRel())
		cDocnr := Nota->Numero
	EndIF
	Area("Saidas")
	Saidas->(Order( SAIDAS_FATURA ))
	IF Saidas->(!( DbSeek( cDocnr ) ))
		ErrorBeep()
		Alerta( "Erro: Nenhum Produto Relacionado a este Documento.")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
EndIF
IF cCodi != Nil
	IF Saidas->Codi != cCodi
		ErrorBeep()
		Alerta( "Erro: Fatura nao e deste cliente...")
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
EndIF
IF nVlrFatura != Nil
	nVlrFatura := Saidas->VlrFatura
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function LocalizaFatura( cDocnr, nRegistro )
********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(05)
LOCAL cNumero	 := ""
LOCAL cEmissao  := ""
LOCAL cDevol	 := ''
LOCAL cUser 	 := ''
LOCAL cVlr		 := ""
LOCAL cSituacao := Space(08)
LOCAL nChoice	 := 0
LOCAL nConta	 := 0
LOCAL cTela

oMenu:Limpa()
MaBox( 15, 10, 18, 78 )
Write( 17, 28, AllTrim(ValToStr(nConta)))
@ 16, 11 Say "Codigo Cliente: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
@ 17, 11 Say "Registro Add #: "
Read
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Nota->(Order( NOTA_CODI ))
IF Nota->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Saidas->(Order( SAIDAS_FATURA ))
Nota->(Order( NOTA_CODI ))
WHILE Nota->Codi = cCodi .OR. LastKey() = ESC
	cNumero	 := Nota->Numero
	cDevol	 := Space(12)
	cUser 	 := Space(04)
	cSituacao := Space(08)
	cEmissao  := ""
	cVlr		 := ""
	nConta++
	Write( 17, 28, AllTrim(ValToStr(nConta)))
	IF Saidas->(DbSeek( cNumero ))
		cEmissao  := Dtoc( Saidas->Data )
		cDevol	 := 'em ' + Dtoc( Saidas->Atualizado )
		cVlr		 := Tran( Saidas->VlrFatura, "@E 999,999,999.99")
		cSituacao := Saidas->Situacao
		cUser 	 := Saidas->Caixa
	EndIF
	Aadd( aDocnr, cNumero )
	Aadd( aRegistro, Nota->(Recno()))
	Aadd( aTodos, cNumero + "   " + cEmissao + " " + cVlr + " " + cSituacao + " " + cDevol + " " + cUser)
	Nota->(DbSkip(1))
	IF nConta >= 4096
		ErrorBeep()
		Alerta('Erro: M�ximo 4096 registros por cliente. Use individual.')
		Exit
	EndIF
EndDo
nTam := Len( aTodos )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
MaBox( 00, 10, 14, 70,"FATURA N�  EMISSAO          VALOR SITUACAO ALTER/EXCLU USER")
nChoice := aChoice( 01, 11, 13, 69, aTodos )
ResTela( cScreen )
IF nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function LocalizaEntrada( cDocnr, nRegistro )
**********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTam		 := 0
LOCAL aDocnr	 := {}
LOCAL aRegistro := {}
LOCAL aTodos	 := {}
LOCAL cCodi 	 := Space(04)
LOCAL cNumero	 := ""
LOCAL cEmissao  := ""
LOCAL cVlr		 := ""
LOCAL nChoice	 := 0

oMenu:Limpa()
MaBox( 15, 10, 17, 78 )
@ 16, 11 Say "Id Fornecedor...: " Get cCodi   Pict "9999" Valid Pagarrado( @cCodi, Row(), Col()+1 )
Read
IF LastKey() = ESC
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Area("EntNota")
EntNota->(Order( ENTNOTA_CODI ))
IF EntNota->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
Entradas->(Order( ENTRADAS_FATURA ))
WHILE EntNota->Codi = cCodi
	cNumero		:= EntNota->Numero
	IF Entradas->(DbSeek( cNumero ))
		cEmissao := Dtoc( Entradas->Data )
		cVlr		:= Tran( Entradas->VlrFatura, "@E 999,999,999.99")
	Else
		cEmissao := ""
		cVlr		:= ""
	EndIF
	Aadd( aDocnr, cNumero )
	Aadd( aRegistro, EntNota->(Recno()))
	Aadd( aTodos, cNumero + "   " + cEmissao + " " + cVlr )
	EntNota->(DbSkip(1))
EndDo
nTam := Len( aTodos )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhuma Fatura Deste Fornecedor." )
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
MaBox( 00, 10, 14, 44,"FATURA N�  EMISSAO          VALOR")
nChoice := aChoice( 01, 11, 13, 43, aTodos )
ResTela( cScreen )
IF nChoice = 0
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
cDocnr	 := aDocnr[ nChoice ]
nRegistro := aRegistro[ nChoice ]
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return( OK )

Function RecCerto( cCodi, lAlteracao, cSwap )
*********************************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )
LOCAL nFieldLen  := Len( Receber->Codi )
LOCAL cFilial

IF lModificar
	IF cCodi == cSwap
		Return( OK )
	EndIF
EndIF

IF LastKey() = UP
	Return( OK )
EndIF
IF Empty( cCodi ) .OR. Len(AllTrim(cCodi)) < 5
	ErrorBeep()
	Alerta("Erro: Codigo Cliente Invalido.")
	Return( FALSO )
EndIF
Area("Receber")
Receber->(Order( RECEBER_CODI ))
IF Receber->( DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Codigo de Cliente Ja Registrado.")
	cCodi := ProxCli( @cCodi )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function ProxCli( cCodi )
*************************
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL nFieldLen  := Len( Receber->Codi )

Receber->(Order( RECEBER_CODI ))
While Receber->(DbSeek( cCodi ))
	cCodi := StrZero( Val( Right( cCodi, nFieldLen )) + 1, nFieldLen )
	Receber->(DbSkip(1))
EndDO
AreaAnt( Arq_Ant, Ind_Ant )
Return( cCodi )

Function Complet2( Mcep, Mcida, Mesta )
***************************************
IF LastKey() = UP
	Return(OK)
EndIF
IF Mcep	= XCCEP
	Mcida = XCCIDA
	Mesta = XCESTA
	Keyb Chr( 13 ) + Chr( 13 )
EndIF
Return( OK )


Function RegiaoErrada( cRegiao, nRow, nCol )
********************************************
LOCAL aRotina := {{|| RegiaoInclusao() }}
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

Area("Regiao")
Regiao->(Order( REGIAO_REGIAO ))
IF (Lastrec() = 0 )
	ErrorBeep()
	IF Conf(" Pergunta: Nenhuma Regiao Disponivel... Registrar ?")
		RegiaoInclusao()
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
IF !DbSeek( cRegiao)
	Regiao->(Order( REGIAO_NOME ))
	Escolhe( 03, 01, 22,"Regiao + '�' + Nome", "COD NOME DA REGIAO", aRotina )
	cRegiao := Regiao->Regiao
EndIF
IF nRow != NIL
	Write( nRow, nCol, Regiao->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc RegiaoInclusao()
*********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL cRegiao
LOCAL cNome
LOCAL lSair
LOCAL nOpcao
FIELD Regiao
FIELD Nome

Area("Regiao")
WHILE OK
	oMenu:Limpa()
	cRegiao := Space(02)
	cNome   := Space(40)
	Regiao->(Order( REGIAO_REGIAO ))
	Regiao->(DbGoBottom())
	cRegiao := Regiao->(StrZero( Val( Regiao)+1, 2))
	lSair   := FALSO
	WHILE OK
		MaBox( 06, 02 , 09 , 78, "INCLUSAO DE REGIOES" )
		@ 07		, 03 Say  "Codigo..:" Get cRegiao Pict "99" Valid RegiaoCerta( @cRegiao )
		@ Row()+1, 03 Say  "Nome....:" Get cNome   Pict "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit

		EndIF
		nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		IF nOpcao = 1	// Incluir
			IF Regiao->(Incluiu())
				Regiao->Regiao := cRegiao
				Regiao->Nome	:= cNome
				Regiao->(Libera())
				Exit
			EndIF

		ElseIf nOpcao = 2 // Alterar
			Loop

		ElseIf nOpcao = 3 // Sair
			lSair := OK
			Exit

		EndIF

	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIF
EndDo

Proc CmInclusao( lAlteracao )
******************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL lModificar	:= FALSO
LOCAL nOpcao		:= 0
LOCAL dInicio
LOCAL dFim
LOCAL nIndice
LOCAL cString
LOCAL cObs
LOCAL cSwap
LOCAL lSair

IF lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
EndiF

IF !lModificar
	IF !PodeIncluir()
		ResTela( cSCreen )
		Return
	EndIF
EndIF

Area("CM")
Cm->(Order( CM_INICIO ))
WHILE OK
	oMenu:Limpa()
	IF lModificar
		dInicio	 := Cm->Inicio
		dFim		 := Cm->Fim
		nIndice	 := Cm->Indice
		cObs		 := Cm->Obs
		cString	 := "ALTERACAO DE CORRECAO MONETARIA"
	Else
		Cm->(Order( 0 ))
		Cm->(DbGoBottom())
		dInicio	 := Cm->Fim + 1
		dFim		 := dInicio + 29
		nIndice	 := 0
		cObs		 := Space(40)
		cString	 := "INCLUSAO DE CORRECAO MONETARIA"
	EndIF
	cSwap := dInicio
	lSair := FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, cString )
		@ 07		 , 03 Say  "Data Inicial.:" Get dInicio  Pict PIC_DATA Valid CmCerto( @dInicio, lModificar, cSwap )
		@ Row()+1 , 03 Say  "Data Final...:" Get dFim     Pict PIC_DATA
		@ Row()+1 , 03 Say  "Indice.......:" Get nIndice  Pict "9999.9999"
		@ Row()+1 , 03 Say  "Observacao...:" Get cObs     Pict "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		IF lModificar
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		EndIF
		IF nOpcao = 1
			IF lModificar
				IF Cm->(TravaReg())
					Cm->Inicio	 := dInicio
					Cm->Fim		 := dFim
					Cm->Indice	 := nIndice
					Cm->Obs		 := cObs
					Cm->(Libera())
					lSair := OK
					Exit
				EndIF
			Else
				IF Cm->(Incluiu())
					Cm->Inicio	 := dInicio
					Cm->Fim		 := dFim
					Cm->Indice	 := nIndice
					Cm->Obs		 := cObs
					Cm->(Libera())
					Exit
				EndIF
			EndIF

		ElseIf nOpcao = 2 // Alterar
			Loop

		ElseIf nOpcao = 3 // Sair
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIF
EndDo

Function CmCerto( dInicio, lModificar, cSwap )
**********************************************
FIELD Inicio, Fim

IF LastKey() = UP
	Return( OK )
EndIF

IF lModificar != NIL .AND. lModificar
	IF dInicio == cSwap
		Return( OK )
	EndIF
EndIF

IF Empty( dInicio )
	ErrorBeep()
	Alerta("Erro: Entrada de Data Invalida.")
	Return( FALSO )
EndIF
Cm->(Order( CM_INICIO ))
IF Cm->(DbSeek( dInicio ))
	ErrorBeep()
	Alerta("Erro: Indice de CM Ja Registrado. ")
	Return( FALSO )
EndIF
Return( OK )

Proc CepInclusao( lAlteracao )
******************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL lModificar	:= FALSO
LOCAL nOpcao		:= 0
LOCAL cCep
LOCAL cCida
LOCAL cBair
LOCAL cEsta
LOCAL cString
LOCAL cSwap
LOCAL lSair

IF lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
EndiF

IF !lModificar
	IF !PodeIncluir()
		ResTela( cSCreen )
		Return
	EndIF
EndIF

Area("Cep")
Cep->(Order( CEP_CEP ))
WHILE OK
	oMenu:Limpa()
	IF lModificar
		cCep		 := Cep->Cep
		cCida 	 := Cep->Cida
		cBair 	 := Cep->Bair
		cEsta 	 := Cep->Esta
		cString	 := "ALTERACAO DE CEP"
	Else
		cCep		 := Space(09)
		cCida 	 := Space(25)
		cBair 	 := Space(25 )
		cEsta 	 := Space(02)
		cString := "INCLUSAO DE NOVO CEP"
	EndIF
	cSwap := cCep
	lSair := FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, cString )
		@ 07		 , 03 Say  "Novo Cep....:" Get cCep      Pict "99999-999" Valid CepCerto( @cCep, lModificar, cSwap )
		@ Row()+1 , 03 Say  "Cidade......:" Get cCida     Pict "@!"
		@ Row()+1 , 03 Say  "Bairro......:" Get cBair     Pict "@!"
		@ Row()+1 , 03 Say  "Estado......:" Get cEsta     Pict "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		IF lModificar
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta("Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		EndIF
		IF nOpcao = 1
			IF lModificar
				IF Cep->(TravaReg())
					Cep->Cep 	  := cCep
					Cep->Cida	  := cCida
					Cep->Bair	  := cBair
					Cep->Esta	  := cEsta
					Cep->(Libera())
					lSair := OK
					Exit
				EndIF
			Else
				IF Cep->(Incluiu())
					Cep->Cep 	  := cCep
					Cep->Cida	  := cCida
					Cep->Bair	  := cBair
					Cep->Esta	  := cEsta
					Cep->(Libera())
					Exit
				EndIF
			EndIF

		ElseIf nOpcao = 2 // Alterar
			Loop

		ElseIf nOpcao = 3 // Sair
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIF
EndDo

Function RegiaoCerta( cRegiao )
*******************************
FIELD Nome

IF LastKey() = UP
	Return( OK )
EndIF
IF Empty( cRegiao )
	ErrorBeep()
	Alerta("Erro: Codigo Regiao Invalida ....")
	Return( FALSO )

EndIF
Regiao->(Order( REGIAO_REGIAO ))
IF Regiao->(DbSeek( cRegiao))
	ErrorBeep()
	Alerta("Erro: Regiao Ja Registrada... ;" + Regiao->(AllTrim(Nome)))
	cRegiao := StrZero( Val( cRegiao ) + 1, 2 )
	Return( FALSO )

EndIF
Return( OK )

Function SubErrado( cSubGrupo, nRow, nCol )
*******************************************
LOCAL aRotina := {{||Lista1_2() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
IF SubGrupo->(!DbSeek( cSubGrupo ))
	SubGrupo->(Escolhe( 03, 01, 22, "CodsGrupo + '�' + DessGrupo", "COD DESCRICAO DO SUBGRUPO", aRotina ))
	cSubGrupo := SubGrupo->CodsGrupo
EndIF
IF nRow != NIL
	Write( nRow, nCol, SubGrupo->DesSGrupo )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function GrupoErrado( cGrupo, nRow, nCol )
******************************************
LOCAL aRotina := {{||Lista1_1() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Grupo")
Grupo->(Order( GRUPO_CODGRUPO ))
IF Grupo->( !DbSeek( cGrupo ))
	Grupo->(Order( GRUPO_DESGRUPO ))
	Grupo->(Escolhe( 03, 01, 22, "CodGrupo + '�' + DesGrupo", "COD DESCRICAO DO GRUPO", aRotina ))
	cGrupo := Grupo->CodGrupo
EndIF
IF nRow != NIL
	Write( nRow, nCol, Grupo->DesGrupo )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Lista1_1()
***************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL bSetKey	:= SetKey( F2 )
LOCAL cServico := Space(01)
LOCAL cDescricao
LOCAL cCodigo

SetKey(F2, NIL )
WHILE OK
	Area("Grupo")
	Grupo->(Order( GRUPO_CODGRUPO ))
	oMenu:Limpa()
	cDescricao := Space( Len( Grupo->Desgrupo ))
	cServico   := Space(01)
	Grupo->(DbGoBoTTom())
	cCodigo	  := StrZero( Val( Grupo->Codgrupo )+1,3)
	MaBox( 05, 01, 09, 55, "INCLUSAO DE GRUPOS")
	@ 06, 02 Say "Grupo.....: " Get cCodigo    Pict "999" Valid Grupo( @cCodigo )
	@ 07, 02 Say "Descricao.: " Get cDescricao Pict "@!"
	@ 08, 02 Say "Servicos..: " Get cServico Pict "!" Valid PickServico( @cServico )
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao do Grupo ?")
		IF Grupo( cCodigo )
			IF Grupo->(Incluiu())
				Grupo->Codgrupo	:= cCodigo
				Grupo->Desgrupo	:= cDescricao
				Grupo->Atualizado := Date()
				Grupo->Servico 	:= IF( cServico = "S", OK, FALSO )
				Grupo->(Libera())
			EndIF
		EndIF
	EndIF
EndDo
SetKey( F2, bSetKey )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PickServico( cServico )
********************************
LOCAL aList 	 := { "Grupo de Produtos", "Grupo de Servicos"}
LOCAL aSituacao := { "P", "S" }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
IF cServico $ aSituacao[1] .OR. cServico $ aSituacao[2]
	Return( OK )
Else
	MaBox( 11, 01, 14, 44, NIL, NIL, Roloc( Cor()) )
	IF (nChoice := AChoice( 12, 02, 13, 43, aList )) != 0
		cServico := aSituacao[ nChoice ]
	EndIf
EndIF
ResTela( cScreen )
Return( OK )

Proc Lista1_2()
***************
LOCAL cScreen := SaveScreen()
LOCAL GetList := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL bSetKey := SetKey( F3 )
LOCAL cGrupo  := Space(03)
LOCAL cCodigo
LOCAL cDescricao

SetKey( F3, NIL )
WHILE OK
	Area("SubGrupo")
	SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
	oMenu:Limpa()
	MaBox( 05, 01, 08, 55, "INCLUSAO DE SUB-GRUPOS")
	SubGrupo->(DbGoBoTTom())
	cDescricao := Space( Len( SubGrupo->DessGrupo ) )
	cGrupo	  := Left( SubGrupo->CodsGrupo, 3 )
	cGrupo	  := IF( Empty( cGrupo ), "001", cGrupo )
	cCodigo	  := cGrupo + "." + StrZero( Val( Right( SubGrupo->CodSgrupo,2))+1, 2)
	@ 06, 02 Say "SubGrupo..� " Get cCodigo    Pict "999.99" Valid Sgrupo( cCodigo )
	@ 07, 02 Say "Descricao.� " Get cDescricao Pict "@!"
	Read
	IF LastKey() = ESC
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao do SubGrupo ?")
		IF Sgrupo( cCodigo )
			IF SubGrupo->(Incluiu())
				SubGrupo->CodSgrupo	:= cCodigo
				SubGrupo->DesSgrupo	:= cDescricao
				SubGrupo->Atualizado := Date()
				SubGrupo->(Libera())
			EndIF
		EndIF
	EndIF
EndDo
SetKey( F3, bSetKey )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function Grupo( Var )
*********************
IF Empty( Var ) .OR. Len(AllTrim(Var)) < 3
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Invalido... ")
	Return(FALSO)
EndIF
Grupo->( Order( GRUPO_CODGRUPO ))
Grupo->( DbGoTop() )
IF Grupo->( DbSeek( var ) )
	ErrorBeep()
	Alerta("Erro: Grupo Ja Registrado... ;" + Trim( Grupo->DesGrupo))
	Var := StrZero( Val( Var ) +1, 3 )
	Return( FALSO )
EndIF
Return( OK )

Function SGrupo( cGrupo )
*************************
LOCAL cScreen := SaveScreen()

IF Empty( cGrupo )
	ErrorBeep()
	Alerta( "Erro: Codigo SubGrupo Invalido... ")
	Return( FALSO )
EndIF
Grupo->( Order( GRUPO_CODGRUPO ))
IF !Grupo->( DbSeek( Left( cGrupo, 3 )))
	ErrorBeep()
	IF Conf( "Pergunta: Grupo Nao Registrado... Registrar ? ")
		Lista1_1()
	EndIF
	ResTela( cScreen )
	SubGrupo->( DbGoTop() )
	Return( FALSO )
EndIF
IF SubGrupo->(DbSeek( cGrupo ) )
	ErrorBeep()
	Alerta( "Erro: SubGrupo Ja Registrado...;" + Trim( SubGrupo->DesSgrupo))
	Return( FALSO )
EndIF
Return( OK )

Proc ForInclusao( lAlteracao )
******************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen( )
LOCAL nRegistro := 0
LOCAL cCodi
LOCAL cNome
LOCAL cFanta
LOCAL dData
LOCAL cCpf
LOCAL cFone
LOCAL cFax
LOCAL cRg1
LOCAL cEnde
LOCAL cBair
LOCAL cCgc
LOCAL cCon
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cIns
LOCAL cCaixa
LOCAL cObs
LOCAL cSigla
LOCAL lModificar := FALSO
LOCAL cString
LOCAL cSwap
LOCAL cRg
LOCAL cInsc
LOCAL lSair
LOCAL nOpcao

FIELD Codi
FIELD Nome
FIELD Fanta
FIELD Data
FIELD Cpf
FIELD Fone
FIELD Fax
FIELD Rg1
FIELD Ende
FIELD Bair
FIELD Cgc
FIELD Con
FIELD Cida
FIELD Esta
FIELD Cep
FIELD Ins
FIELD Caixa
FIELD Obs
FIELD Sigla

IF lAlteracao != NIL
	IF lAlteracao = OK
		lModificar := OK
	EndIF
EndIF

Area( "Pagar" )
Pagar->(Order( PAGAR_CODI ))
WHILE OK
	oMenu:Limpa()
	cNome  := IF( lModificar, Pagar->Nome, 	  Space(40))
	cFanta := IF( lModificar, Pagar->Fanta,	  Space(40))
	cSigla := IF( lModificar, Pagar->Sigla,	  Space(10))
	cCpf	 := IF( lModificar, Pagar->Cpf,		  Space(14))
	cFone  := IF( lModificar, Pagar->Fone, 	  Space(14))
	cFax	 := IF( lModificar, Pagar->Fax,		  Space(14))
	cRg	 := IF( lModificar, Pagar->Rg,		  Space(18))
	cCgc	 := IF( lModificar, Pagar->Cgc,		  Space(18))
	cEnde  := IF( lModificar, Pagar->Ende, 	  Space(30))
	cObs	 := IF( lModificar, Pagar->Obs,		  Space(30))
	cBair  := IF( lModificar, Pagar->Bair, 	  Space(20))
	cCon	 := IF( lModificar, Pagar->Con,		  Space(20))
	cCida  := IF( lModificar, Pagar->Cida, 	  Space(25))
	cEsta  := IF( lModificar, Pagar->Esta, 	  Space(02))
	cCep	 := IF( lModificar, Pagar->Cep,		  Space(09))
	cInsc  := IF( lModificar, Pagar->Insc, 	  Space(15))
	cCaixa := IF( lModificar, Pagar->Caixa,	  Space(03))
	dData  := IF( lModificar, Pagar->Data, 	  Date())
				 IF( lModificar,, Pagar->(DbGoBottom()))
	cCodi   := IF( lModificar, Pagar->Codi, Pagar->(StrZero(Val( Codi )+1, 4)))
	cString := IF( lModificar, "ALTERACAO DE FORNECEDORES", "INCLUSAO DE NOVOS FORNECEDORES")
	cSwap 	 := cCodi
	lSair 	 := FALSO
	nRegistro := Pagar->(Recno())
	WHILE OK
		MaBox( 06 , 02 , 21 , 78, cString )
		@ 07		, 03 Say "Codigo......:" Get cCodi  Pict "9999" Valid PagCerto( @cCodi, lModificar, cSwap )
		@ Row()+1, 03 Say "Data........:" Get dData  Pict  "##/##/##"
		@ Row()+1, 03 Say "R. Social...:" Get cNome  Pict  "@!" Valid !Empty(cNome) .OR. LastKey() = UP
		@ Row()+1, 03 Say "Sigla.......:" Get cSigla Pict  "@!" Valid !Empty(cSigla) .OR. LastKey() = UP
		@ Row()+1, 03 Say "Fantasia....:" Get cFanta Pict  "@!"
		@ Row()+1, 03 Say "CGC/MF......:" Get cCgc   Pict  "99.999.999/9999-99"
		@ Row()+1, 03 Say "Inscri�ao...:" Get cInsc  Pict  "@!"
		@ Row()+1, 03 Say "CPF.........:" Get cCpf   Pict  "999.999.999-99" Valid TestaCpf( cCpf )
		@ Row()+1, 03 Say "Rg..........:" Get cRg    Pict  "@!"
		@ Row()+1, 03 Say "Endere�o....:" Get cEnde  Pict  "@!"
		@ Row()+1, 03 Say "CEP.........:" Get cCep   Pict  "99999-999" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ Row()+1, 03 Say "Cidade......:" Get cCida  Pict  "@!"
		@ Row()+1, 03 Say "Bairro......:" Get cBair  Pict  "@!"
		@ Row()+1, 03 Say "Estado......:" Get cEsta  Pict  "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		Scroll( 07, 03, 20, 77, 14 )
		@ 07, 	  03 Say "Telefone....:" Get cFone  Pict  PIC_FONE
		@ Row()+1, 03 Say "Fax.........:" Get cFax   Pict  PIC_FONE
		@ Row()+1, 03 Say "Cx Postal...:" Get cCaixa Pict  "999"
		@ Row()+1, 03 Say "Contato.... :" Get cCon   Pict  "@!"
		@ Row()+1, 03 Say "Obs.........:" Get cObs   Pict  "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		ErrorBeep()
		IF lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		EndIF
		IF nOpcao = 1
			IF lModificar
				Pagar->(DbGoTo( nRegistro ))
				IF !Pagar->(TravaReg()) 			  ; Loop ; EndIF
			Else
				IF !PagCerto( @cCodi, lModificar ) ; Loop ; EndIF
				IF !Pagar->(Incluiu())				  ; Loop ; EndIF
			EndIF
			Pagar->Codi  := cCodi
			Pagar->Data  := dData
			Pagar->Nome  := cNome
			Pagar->Rg	 := cRg
			Pagar->Ende  := cEnde
			Pagar->Bair  := cBair
			Pagar->Cida  := cCida
			Pagar->Con	 := cCon
			Pagar->Obs	 := cObs
			Pagar->Cpf	 := cCpf
			Pagar->Esta  := cEsta
			Pagar->Cep	 := cCep
			Pagar->Fone  := cFone
			Pagar->Cgc	 := cCgc
			Pagar->Insc  := cInsc
			Pagar->Fanta := cFanta
			Pagar->Fax	 := cFax
			Pagar->Caixa := cCaixa
			Pagar->Sigla := cSigla
			Pagar->(Libera())
			IF lModificar
				lSair := OK
			EndIF
			Exit

		ElseIf nOpcao = 2 // Alterar
			Loop
		ElseIf nOpcao = 3 // Sair
			lSair := OK
			Exit
		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit
	EndIF
EndDo

Function CodiCerto( cCodigo, lAlteracao, cSwap )
************************************************
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )

IF lModificar
	IF cCodigo == cSwap
		Return( OK )
	EndIF
EndIF
IF LastKey() = UP
	Return( OK )
EndIF
IF Len(AllTrim(cCodigo )) < 6 .OR. Empty( cCodigo )
	ErrorBeep()
	Alerta("Erro: Codigo Produto Invalido.")
	Return( FALSO )
EndIF
Lista->(Order( LISTA_CODIGO ))
IF Lista->(DbSeek( cCodigo ))
	ErrorBeep()
	Alerta("Erro: Codigo de Produto Existente.")
	Lista->(DbGoBottom())
	cCodigo := ProxCodigo( Lista->Codigo )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function GrupoCerto( cGrupo, nCol, nLinha )
*******************************************
LOCAL oInclusao  := {{|| Lista1_1() }}
LOCAL oAlteracao := {{|| GrupoDbEdit() }}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()

IF LastKey() = UP
	Return( OK )
EndIF

Area("Grupo")
Grupo->(Order( GRUPO_CODGRUPO ))
IF Grupo->(!DbSeek( cGrupo ))
	Grupo->(Order( GRUPO_DESGRUPO ))
	Grupo->(Escolhe( 03, 01, 22, "CodGrupo + '�' + DesGrupo", "GRUPO DESCRICAO DO GRUPO", oInclusao, NIL, oAlteracao, NIL, NIL, NIL ))
	cGrupo := Grupo->CodGrupo
EndIF
Write( nCol, nLinha, Grupo->DesGrupo )
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function SubCerto( cSub, nCol, nLinha, cGrupo )
***********************************************
LOCAL oInclusao  := {{|| Lista1_2() 		}}
LOCAL oAlteracao := {{|| SubGrupoDbEdit() }}
LOCAL cScreen	  := SaveScreen()
LOCAL Arq_Ant	  := Alias()
LOCAL Ind_Ant	  := IndexOrd()

IF LastKey() = UP
	Return( OK )
EndIF
Area("SubGrupo")
SubGrupo->(Order( SUBGRUPO_CODSGRUPO ))
IF SubGrupo->(!DbSeek( cSub ))
	SubGrupo->(DbSeek( cGrupo ))
	SubGrupo->(Escolhe( 03, 01, 22, "CodsGrupo + '�' + DessGrupo", "SUBGRUPO   DESCRICAO DO SUBGRUPO", oInclusao, NIL, oAlteracao, NIL, NIL, OK ))
	cSub := SubGrupo->CodsGrupo
EndIF
IF Left( cSub, 3 ) != cGrupo
	ErrorBeep()
	Alerta('Erro: Subgrupo incompativel com o grupo.')
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
Write( nCol, nLinha, SubGrupo->DessGrupo )
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc RepresInclusao()
*********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL Mcodi
LOCAL Nom
LOCAL Mfanta
LOCAL Dat
LOCAL Mcpf
LOCAL Fon
LOCAL Mfax
LOCAL Rg1
LOCAL End
LOCAL Bai
LOCAL Mcgc
LOCAL Mcon
LOCAL Mcida
LOCAL Mesta
LOCAL Mcep
LOCAL Mins
LOCAL Mcaixa
LOCAL Mobs
LOCAL cNome
LOCAL cFanta
LOCAL cSigla
LOCAL cCpf
LOCAL cFone
LOCAL cFax
LOCAL cRg
LOCAL cCgc
LOCAL cEnde
LOCAL cObs
LOCAL cBair
LOCAL cCon
LOCAL cCida
LOCAL cEsta
LOCAL cCep
LOCAL cCodi
LOCAL cInsc
LOCAL cCaixa
LOCAL dData
FIELD Codi
FIELD Nome
FIELD Repres

oMenu:Limpa()
Area( "Repres" )
Repres->(Order( REPRES_CODI ))
WHILE OK
	MaBox( 05, 02, 20, 78, "INCLUSAO DE REPRESENTANTES" )
	cNome  := Space(40)
	cFanta := Space(40)
	cSigla := Space(10)
	cCpf	 := Space(14)
	cFone  := Space(14)
	cFax	 := Space(14)
	cRg	 := Space(18)
	cCgc	 := Space(18)
	cEnde  := Space(30)
	cObs	 := Space(60)
	cBair  := Space(20)
	cCon	 := Space(20)
	cCida  := Space(25)
	cEsta  := Space(02)
	cCep	 := Space(09)
	cCodi  := Space(04)
	cInsc  := Space(15)
	cCaixa := Space(03)
	dData  := Date()

	Area( "Repres" )
	Repres->(Order( REPRES_CODI ))
	DbGoBottom()
	cCodi := StrZero( Val( Repres ) + 1 , 4)
	Write( 06, 23, "ANTERIOR " + Repres->Repres + " " + Repres->Nome )
	@ Row()	, 03 Say "Codigo......:" Get cCodi  Pict  "9999" Valid RepresCerto( @cCodi )
	@ Row()+1, 03 Say "R. Social...:" Get cNome  Pict  "@!" Valid !Empty(cNome) .OR. LastKey() = UP
	@ Row()+1, 03 Say "CGC/MF......:" Get cCgc   Pict  "99.999.999/9999-99" Valid TestaCgc( cCgc )
	@ Row()+1, 03 Say "Inscri�ao...:" Get cInsc  Pict  "@!"
	@ Row()+1, 03 Say "Endere�o....:" Get cEnde  Pict  "@!"
	@ Row()+1, 03 Say "CEP.........:" Get cCep   Pict  "99999-999" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
	@ Row()+1, 03 Say "Cidade......:" Get cCida  Pict  "@!"
	@ Row()+1, 03 Say "Bairro......:" Get cBair  Pict  "@!"
	@ Row()+1, 03 Say "Estado......:" Get cEsta  Pict  "@!"
	@ Row()+1, 03 Say "Telefone....:" Get cFone  Pict  PIC_FONE
	@ Row()+1, 03 Say "Fax.........:" Get cFax   Pict  PIC_FONE
	@ Row()+1, 03 Say "Cx Postal...:" Get cCaixa Pict  "999"
	@ Row()+1, 03 Say "Contato.....:" Get cCon   Pict  "@!"
	@ Row()+1, 03 Say "Obs.........:" Get cObs   Pict  "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	IF Conf(" Pergunta: Confirma Inclusao do Registro ?")
		IF !RepresCerto( @cCodi)
			Loop
		EndIF
		IF Repres->(Incluiu())
			Repres->Repres := cCodi
			Repres->Nome	:= cNome
			Repres->Ende	:= cEnde
			Repres->Bair	:= cBair
			Repres->Cida	:= cCida
			Repres->Con 	:= cCon
			Repres->Obs 	:= cObs
			Repres->Esta	:= cEsta
			Repres->Cep 	:= cCep
			Repres->Fone	:= cFone
			Repres->Cgc 	:= cCgc
			Repres->Insc	:= cInsc
			Repres->Fax 	:= cFax
			Repres->Caixa	:= cCaixa
			Repres->(Libera())
		EndIF
	EndIF
EndDo

Function Represrrado( Var, nRow, nCol, cSigla )
*********************************************
LOCAL aRotina := {{|| RepresInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
FIELD Codi, Nome

Area( "Repres" )
Repres->(Order( REPRES_CODI ))
IF Repres->(!( DbSeek( Var )))
	Repres->( Order( REPRES_NOME ))
	Repres->( Escolhe( 03, 01, 22, "Repres + '�' + Nome + '�' + Fone", "CODI NOME REPRESENTANTE                       TELEFONE", aRotina ))
	Var := IF( Len( Var ) = 4, Repres->Repres, Repres->Nome )
EndIF
IF nRow != Nil
	Write( nRow, nCol, Repres->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function BarErrado( cCodeBar, lModificar, cSwapBar )
****************************************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()
LOCAL Reg_Ant := Recno()
LOCAL lRet	  := OK

IF lModificar
	IF AllTrim(cCodeBar) == cSwapBar
		Return( lRet )
	EndIF
EndIF
IF LastKey() = UP
	Return( lRet )
EndIF
Lista->(Order( LISTA_CODEBAR ))
IF Lista->(DbSeek( cCodeBar ))
	ErrorBeep()
	Alerta("Erro: Codigo de Barra Existente.")
	lRet := FALSO
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
DbGoTo( Reg_Ant )
Return( lRet )

Function PagCerto( cCodi, lAlteracao, cSwap )
*********************************************
LOCAL lModificar := IF( lAlteracao != NIL .AND. lAlteracao, OK, FALSO )
LOCAL Ind_Ant	  := IndexOrd()
LOCAL Arq_Ant	  := Alias()

IF LastKey() = UP
	Return( OK )
EndIF
IF lModificar
	IF cCodi == cSwap
		Return( OK )
	EndIF
EndIF
IF Empty( cCodi ) .OR. Len(AllTrim( cCodi)) < 4
	ErrorBeep()
	Alerta( "Erro: Codigo de fornecedor Invalido." )
	Return( FALSO )
EndIF
Area( "Pagar" )
Pagar->(Order( PAGAR_CODI ))
IF Pagar->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Fornecedor Ja Registrado ou Incluido por outra Esta�ao.." )
	Pagar->(DbGoBoTTom())
	cCodi := StrZero( Val( Pagar->Codi)+1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(FALSO)
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function RepresCerto( cCodi )
*****************************
LOCAL Arq_Ant, Ind_Ant

IF LastKey() = UP
	Return( OK )
EndIF
IF Empty( cCodi )
	ErrorBeep()
	Alerta( "Erro: Codigo Representante Invalido." )
	Return(FALSO)
EndIF
Ind_Ant := IndexOrd()
Arq_Ant := Alias()
Area( "Repres" )
Repres->(Order( REPRES_CODI ))
IF (DbSeek( cCodi ) )
	ErrorBeep()
	Alerta("Erro: Representante Ja Registrado." )
	Pagar->(DbGoBoTTom())
	cCodi := StrZero( Val( Repres->Repres ) + 1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(FALSO)
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function Complet3( xCep , Mcida, Mesta)
***************************************
IF xCep	 = XCCEP
	Mcida := XCCIDA
	Mesta := XCESTA
	Keyb Chr( 13 ) + Chr( 13 )

EndIF
Return( OK )

Function CodiErrado( cCodiIni, cCodiFim, lUltimo, nRow, nCol )
**************************************************************
LOCAL aRotina := {{|| InclusaoProduto() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

cCodiIni := IF( ValType( cCodiIni ) = "N", StrZero( cCodiIni, 6), cCodiIni )
Area("Lista")
Lista->(Order( LISTA_CODIGO ))
IF Lista->(!DbSeek( cCodiIni ))
	Lista->(Order( LISTA_DESCRICAO ))
	Lista->(Escolhe( 03, 00, 22,"Codigo + '�' + Descricao + '�' + Tran( Quant, '999999.99') + '�' + Tran( Varejo, '@E 99,999,999.99') + '�' + Sigla","CODIG DESCRICAO DO PRODUTO                       ESTOQUE         PRECO MARCA", aRotina ))
	cCodiIni := IF( Len( cCodiIni ) > 6, Lista->Descricao, Lista->Codigo )
EndIF
IF nRow != NIL .AND. nCol != NIL
	Write( nRow, nCol, Lista->Descricao )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function SimOuNao()
*******************
ErrorBeep()
Return( Alert("Esta opcao ira somar as entradas e saidas;" + ;
				  "de produtos e atualizar o estoque;; " + ;
				  "Deseja continuar ?", {" Sim ", " Nao "}) == 1 )

Proc InclusaoDolar( dData )
**************************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL nCotacao := 0

oMenu:Limpa()
IF dData = Nil
	dData := Date() + 7
EndIF
dData 	:= Date()-1
nCotacao := 0
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
WHILE OK
	dData++
	MaBox( 05, 11, 08, 51, "INCLUSAO DA COTA�AO DOLAR - ESC Retorna" )
	@ 06, 	  12 Say "Data                   �" Get dData    Pict "##/##/##" Valid DolarCerto( dData )
	@ Row()+1, 12 Say "Cota�ao Dolar R$       �" Get nCotacao Pict "99999999.99" Valid nCotacao > 0
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao do Registro ?")
		IF !DolarCerto( dData )
			Loop
		EndIF
		IF Taxas->(!Incluiu())
			Loop
		EndIF
		Taxas->DIni 	 := dData
		Taxas->DFim 	 := dData
		Taxas->Cotacao  := nCotacao
		Taxas->(Libera())
	EndIF
EndDo

Proc InclusaoForma()
********************
LOCAL cScreen		 := SaveScreen()
LOCAL GetList		 := {}
LOCAL cForma		 := Space(02)
LOCAL cCondicoes	 := Space(40)
LOCAL cDescricao	 := Space(40)
LOCAL nComissao	 := 0
LOCAL cEspecificar := "S"
LOCAL nMeses		 := 0
LOCAL nIof			 := 0
LOCAL cDesdobrar	 := "N"
LOCAL cVista		 := "N"
LOCAL nParcelas	 := 1
LOCAL nDias 		 := 30

oMenu:Limpa()
MaBox( 05, 05, 13, 72, "INCLUSAO DE FORMA PGTO" )
Area("Forma")
Forma->(Order( FORMA_FORMA ))
WHILE OK
	Forma->(DbGoBoTTom())
	cForma := StrZero( Val( Forma->Forma ) + 1, 2 )
	cDesdobrar	 := "N"
	cVista		 := "N"
	nParcelas	 := 0
	nDias 		 := 0
   @ 06, 06 Say "Codigo..........:"    Get cForma       Pict "99"  Valid FormaCerta( cForma )
   @ 07, 06 Say "Condicoes.......:"    Get cCondicoes   Pict "@!"  Valid IF( Empty( cCondicoes ), ( ErrorBeep(), Alerta("Erro: Entrada Invalida."), FALSO ), OK )
	@ 08, 06 Say "Desdobramento...:"    Get cDesdobrar   Pict "!"   Valid PickSimNao( @cDesdobrar )
	@ 08, 35 Say "N� Parcelas........:" Get nParcelas    Pict "99"  When cDesdobrar == "S"
	@ 09, 06 Say "1� Parcela Vista:"    Get cVista       Pict "!"   Valid PickSimNao( @cVista ) When cDesdobrar = 'S'
   @ 09, 35 Say "Dias Entre Parcelas:" Get nDias        Pict "999" When cDesdobrar == "S"
	@ 10, 06 Say "Descricao.......:"    Get cDescricao   Pict "@!"
	@ 11, 06 Say "Comissao........:"    Get nComissao    Pict "99.99"
	@ 12, 06 Say "Taxa Financeiro.:"    Get nIof         Pict "999.9999"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	IF Conf("Pergunta: Confirma Inclusao do Registro ?")
		IF !FormaCerta( cForma )
			Loop
		EndIF
		IF Forma->(!Incluiu())
			Loop
		EndIF
		Forma->Forma		:= cForma
		Forma->Condicoes	:= cCondicoes
		Forma->Descricao	:= cDescricao
		Forma->Comissao	:= nComissao
		Forma->Iof			:= nIof
		Forma->Desdobrar	:= cDesdobrar == "S"
		Forma->Parcelas	:= nParcelas
		Forma->Dias 		:= nDias
		Forma->Vista		:= cVista == 'S'
		Forma->(Libera())
	EndIF
EndDo

Function DolarCerto( dData )
***************************
IF Taxas->(DbSeek( dData ))
	ErrorBeep()
	IF Taxas->Cotacao = 0
		Alerta("Erro: Cota�ao registrada com valor 0...")
	Else
		Alerta("Erro: Cota�ao desta Data ja registrada...")
	EndIF
	Return( FALSO )
EndIF
Return( OK )

Function FormaCerta( cForma )
*****************************
IF Forma->(DbSeek( cForma ))
	ErrorBeep()
	Alerta("Erro: Codigo de Forma de Pgto ja registrada...")
	Return( FALSO )
EndIF
Return( OK )

Function Cotacao( dData, nCotacao, lExcecao )
*********************************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cString
IF lExcecao = NIL
	#IFNDEF XDOLAR
		nCotacao := 1
		Return( OK )
	#ENDIF
EndIF
Area("Taxas")
Taxas->(Order( TAXAS_DFIM ))
IF Taxas->(!DbSeek( dData ))
	ErrorBeep()
	cString := "Cotacao de " + Dtoc( dData ) + " Nao Encontrada. Registrar ?"
	IF Conf( cString )
		 InclusaoDolar( dData )
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
IF Taxas->Cotacao = 0
	ErrorBeep()
	cString := "Cotacao ja Registrada com valor 0. Alterar ?"
	IF Conf( cString )
		MudaDolar( OK )
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
nCotacao := Taxas->Cotacao
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

PROC NaoTem()
*************
ErrorBeep()
Alerta("Erro: Nenhum Registro Neste Periodo... ")
Return

Proc CliAltera()
****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cCodi 	:= Space(05)

WHILE OK
	MaBox( 10, 10, 12, 75 )
	@ 11, 11 Say "Codigo Cliente..: " Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1 )
	Read
	IF LastKey() = ESC
		Return
	EndIF
	CliInclusao( OK )
EndDo


Function SeekData( dMinor, dMajor, cCampo )
*******************************************
LOCAL xValor := Date()

IF cCampo != NIL
	DbGoTop()
	xValor := FieldGet( FieldPos( cCampo ))
	IF dMinor < xValor
		dMinor := xValor
	EndIF
EndIF
WHILE !DbSeek( dMinor++ )
	 IF dMinor > dMajor
		 Return( FALSO )
	 EndIF
EndDo
Return( OK )

Function AchaTipo( cTipo )
**************************
Recemov->(Order( RECEMOV_TIPO_CODI ))
IF Recemov->(!DbSeek( cTipo ))
	ErrorBeep()
	Alerta("Erro: Tipo nao localizado.")
	Return( FALSO )
EndIF
Return( OK )

Proc RecePago(nChoice, xParam)
******************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL nValorDolar := 0
LOCAL nConta		:= 0
LOCAL cColor		:= SetColor()
LOCAL cCodi
LOCAL cFatu
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aTodos
LOCAL aCabec
LOCAL nValorJuros
LOCAL cTela
LOCAL oBloco
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
LOCAL nT
LOCAL xLen
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
PRIVA aCodi 	 := {}
PRIVA xTodos	 := {}
PRIVA alMulta	 := {}
PRIVA oRecePosi := TReceposi()

oAmbiente:lReceber	 := FALSO
oRecePosi:aAtivo		 := {}
oRecePosi:aAtivoSwap  := {}
oRecePosi:aHistRecibo := {}
oRecePosi:aUserRecibo := {}
oRecePosi:aRecno      := {}
oMenu:Limpa()
Receber->(Order( RECEBER_CODI ))
Recebido->(DbGoTop())
IF Recebido->(Eof())
	ErrorBeep()
	Alerta("Nenhum Debito Baixado.")
	ResTela( cScreen )
	Return
EndIF
WHILE OK
	oRecePosi:Resetar()
	Do Case
	Case nChoice = 1
		IF xParam != NIL
			cCodi := xParam
			dFim	:= Date()
			IF oAmbiente:Ano2000
				dIni	:= Ctod("01/01/80")
			Else
				dIni	:= Ctod("01/01/01")
			EndIF
		Else
			cCodi := Space(05)
			dIni		:= Ctod("01/01/91")
			dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
			MaBox( 14, 48, 18, 75 )
			@ 15, 49 Say "Codigo......:" Get cCodi Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
			@ 16, 49 Say "Pgto Ini....:" Get dIni  Pict "##/##/##"
			@ 17, 49 Say "Pgto Final..:" Get dFim  Pict "##/##/##"
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Exit
			EndIF
		EndIF
		Area("Recebido")
		Recebido->(Order( RECEBIDO_CODI_VCTO ))
		oBloco		:= {|| Recebido->Codi = cCodi }
		IF Recebido->(!DbSeek( cCodi ))
			ErrorBeep()
			Alerta("Nenhum Debito Baixado.")
			IF xParam != NIL
				Exit
			Else
				Loop
			EndIF
		EndIF

	  Case nChoice = 2
		  dIni := Date()-30
		  dFim := Date()
		  MaBox( 14, 52, 17, 76 )
		  @ 15, 53 Say "Pgto Ini...:" Get dIni Pict "##/##/##"
		  @ 16, 53 Say "Pgto Final.:" Get dFim Pict "##/##/##"
		  Read
		  IF LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  EndIF
		  Area("Recebido")
		  Recebido->(Order( RECEBIDO_DATAPAG ))
		  oBloco := {|| Recebido->DataPag >= dIni .AND. Recebido->DataPag <= dFim }
		  Set Soft On
		  Recebido->(DbSeek( dIni ))
		  Set Soft Off

	  Case nChoice = 3
		  cRegiao  := Space(02)
		  dIni	  := Date()-30
		  dFim	  := Date()
		  dCalculo := Date()
		  MaBox( 14, 45, 18, 75 )
		  @ 15, 46 Say "Regiao.......:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
		  @ 16, 46 Say "Pgto Inicial.:" Get dIni     Pict "##/##/##"
		  @ 17, 46 Say "Pgto Final...:" Get dFim     Pict "##/##/##"
		  Read
		  IF LastKey() = ESC
			  ResTela( cScreen )
			  Exit
		  EndIF
		  Area("Recebido")
		  Recebido->(Order( RECEBIDO_REGIAO ))
		  oBloco := {|| Recebido->Regiao = cRegiao }
		  IF Recebido->(!DbSeek( cRegiao ))
			  ErrorBeep()
			  Alerta("Nenhum Debito Baixado dessa Regiao.")
			  Loop
		  EndIF

	  Case nChoice = 4
		  IF xParam != NIL
			  cFatu := xParam
		  Else
			  cFatu := Space(7)
			  MaBox( 14, 45, 16, 67 )
			  @ 15, 46 Say "Fatura N�.:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
			  Read
			  IF LastKey() = ESC
				  ResTela( cScreen )
				  Exit
			  EndIF
		  EndIF
		  Recemov->(Order( RECEMOV_FATURA ))
		  IF Recemov->(DbSeek( cFatu ))
			  Nada("INFO: Consta registros em aberto desta fatura.", OK)
		  EndIF
		  Area("Recebido")
		  Recebido->(Order( RECEBIDO_FATURA ))
		  IF Recebido->(!DbSeek( cFatu ))
				ErrorBeep()
				Alerta("Nenhum Debito Baixado dessa Fatura.")
				IF xParam != NIL
					Restela(cScreen)
					Exit
				Else
					Loop
				EndIF
		  EndIF
		  oBloco := {|| Recebido->Fatura = cFatu }

	  Case nChoice = 5
		  Area("Recebido")
		  Recebido->(Order( RECEBIDO_CODI_VCTO ))
		  Recebido->(DbGoTop())
		  oBloco := {|| Recebido->(!Eof()) }

	  EndCase
	  nValorTotal := 0
	  nValorPago  := 0
	  nTotalGeral := 0
	  Col 		  := 12
	  aTodos 	  := {}
	  xTodos 	  := {}
	  aCodi		  := {}
     oRecePosi:aRecno      := {}
     oRecePosi:aAtivo      := {}
	  oRecePosi:aAtivoSwap	:= {}
	  oRecePosi:aHistRecibo := {}
	  oRecePosi:aUserRecibo := {}
	  nConta 	  := 0
	  nCotacao	  := 0
	  cTela		  := Mensagem("Info: Aguarde, processando.", Cor())

	  WHILE Eval( oBloco )
		  IF nConta >= 4096 // Tamanho Max. Array
			  Alerta("Informa: Impossivel mostrar mais do que 4096 registros.")
			  Exit
		  EndIF
		  IF nChoice = 1	.OR. nChoice = 3
			  IF Recebido->DataPag < dIni .OR. Recebido->DataPag > dFim
				  DbSkip(1)
				  Loop
			  EndIF
		  EndIF
		  //Aadd( aCodi, { Codi, Recebido->Obs })
		  nValorPago  += VlrPag
		  nValorTotal += Vlr
		  Aadd( xTodos, {Docnr,;
							  Dtoc(Emis),;
							  Dtoc(Vcto),;
							  DataPag,;
							  (DataPag-Vcto),;
							  Vlr,;
							  VlrPag,;
							  Codi,;
							  Recebido->Obs,;
							  Dtoc(Datapag),;
							  Recebido->Obs,;
							  DateToStr(Vcto)+Docnr+DateToStr(DataPag),;
                       Fatura,;
                       Recno()})
		  nConta++
		  Recebido->(DbSkip(1))
	  EndDo


	  ResTela( cTela )
	  xLen := Len(xTodos)
	  IF xLen > 0
		  Mensagem("Info: Aguarde, ordenando registros.")
		  //Asort( xTodos,,, {|x,y|x[4] < y[4]}) // Datapag
		  Asort( xTodos,,, {|x,y|x[12] < y[12]}) // Vcto
        oRecePosi:aRecno      := {}
        oRecePosi:aAtivo      := {}
		  oRecePosi:aAtivoSwap	:= {}
		  oRecePosi:aHistRecibo := {}
		  oRecePosi:aUserRecibo := {}
		  alMulta := {}
		  aTodos  := {}
		  aCodi	 := {}
		  For nT := 1 To xLen
			  Aadd( oRecePosi:aAtivo, OK )
			  Aadd( oRecePosi:aAtivoSwap, OK )
			  Aadd( oRecePosi:aHistRecibo,Space(0))
			  Aadd( oRecePosi:aUserRecibo,Space(0))
           Aadd( oReceposi:aRecno,xTodos[nT,14])
           Aadd( alMulta, (xTodos[nT,7] <> 0)) // Multa?
			  Aadd( aCodi,  xTodos[nT,8] )
			  Aadd( aTodos, xTodos[nT,1] + " " + ;
								 xTodos[nT,2] + " " + ;
								 xTodos[nT,3] + " " +  ;
								 xTodos[nT,10] + " " +  ;
								 StrZero( xTodos[nT,5],4) + " " + ;
								 Tran(xTodos[nT,6], "@E 999,999,999.99") + " " + ;
								 Tran(xTodos[nT,7], "@E 999,999,999.99"))
		  Next

		  IF oAmbiente:Mostrar_Recibo
			  SeekLog(xTodos, aTodos)
		  EndIF

		  MaBox( 00, 00, 06, MaxCol() )
		  oRecePosi:PosiReceber := OK
		  oRecePosi:aBottom		:= _SomaPago( nValorTotal, nValorPago)
		  oRecePosi:cTop			:= " DOCTO N�  EMISSAO   VENCTO  DATAPAG ATRA   VALOR TITULO     VALOR PAGO             "
		  oRecePosi:cTop			+= Space( MaxCol() - Len(oRecePosi:cTop))
		  oRecePosi:Redraw()
		  __Funcao( 0, 1, 1 )
		  SetColor(',,,,R+/')
		  oRecePosi:aChoice_(aTodos, oRecePosi:aAtivo, "__Funcao")
		  SetColor(cColor)
		  oRecePosi:PosiReceber := FALSO
	  EndIF
	  DbClearRel()
	  DbClearFilter()
	  DbGoTop()
	  ResTela( cScreen )
	  IF nChoice = 5 .OR. xParam != NIL
		  Exit
	  EndIF
EndDo

Function Cliente( cCodi, cPraca, cCliRecno, cEsta )
***************************************************
LOCAL aRotina := {{|| CliInclusao() }}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Receber")
Receber->(Order( RECEBER_CODI ))
Receber->(DbGoTop())
IF Receber->(Lastrec()) = 0
	ErrorBeep()
	IF Conf( "Nenhum Cliente Registrado... Registrar ? " )
		CliInclusao()
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	ResTela( cScreen )
	Return( FALSO )
EndIF
IF Receber->(!DbSeek( cCodi ))
	Receber->(Order( RECEBER_NOME ))
	Receber->(DbGoTop())
	Receber->(Escolhe( 03, 01, 22, "Codi + '�' + Nome + '�' + Fone","CODI NOME DO CLIENTE                          TELEFONE", aRotina ))
EndIF
cCliRecno := Receber->(Recno())
cCodi 	 := Receber->Codi
cPraca	 := Receber->Cep + "/" + Receber->Cida
cEsta 	 := Receber->Esta
Write( 16, 66 , Receber->Codi )
Write( 16, 15 , Receber->Nome )
Write( 17, 15 , Receber->Ende )
Write( 17, 59 , Receber->Bair )
Write( 18, 15 , Receber->Cep + "/" + Receber->Cida )
Write( 18, 66 , Receber->Esta )
Write( 20, 15 , Receber->Cgc )
Write( 20, 58 , Receber->Insc )
Write( 21, 15 , Receber->Cpf )
Write( 21, 58 , Receber->Rg )
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Avisa()
************
ErrorBeep()
Alerta( "Erro: Nada Consta.")
Return

Proc Cheq11()
*************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen(  )
LOCAL cBanco	 := Space(10)
LOCAL dData 	 := Date()
LOCAL cCgc		 := Space(18)
LOCAL cConta	 := Space(08)
LOCAL cFone 	 := Space(13)
LOCAL cObs		 := Space(40)
LOCAL cTitular  := Space(40)
LOCAL cPoupanca := "N"
LOCAL cAg		 := XCCIDA + Space( 25 - Len( XCCIDA ) )
LOCAL cMens 	 := "N"
LOCAL cExterna  := "S"

WHILE OK
	oMenu:Limpa()
	cBanco	 := Space(10)
	dData 	 := Date()
	cCgc		 := Space(18)
	cConta	 := Space(08)
	cFone 	 := Space(13)
	cObs		 := Space(40)
	cTitular  := Space(40)
	cAg		 := XCCIDA + Space( 25 - Len( XCCIDA ) )
	cMens 	 := "N"
	cExterna  := "S"
	cPoupanca := "N"

	Area("Cheque")
	Cheque->(Order( CHEQUE_CODI ))
	DbGoBottom()
	cCodi := StrZero( Val( Codi ) + 1, 4 )
	MaBox( 06, 02, 18, 78, "INCLUSAO DE CONTAS" )
	WHILE OK
		@ 07,03 Say  "Codigo......:" GET cCodi     Pict "9999" Valid CheCerto( @cCodi )
		@ 08,03 Say  "Titular.....:" GET cTitular  Pict "@!" Valid !Empty( cTitular )
		@ 09,03 Say  "CGC/MF......:" GET cCgc      Pict "99.999.999/9999-99" Valid TestaCgc( cCgc )
		@ 10,03 Say  "Abertura....:" GET dData     Pict "##/##/##"
		@ 11,03 Say  "Banco.......:" GET cBanco    Pict "@!"
		@ 12,03 Say  "Telefone....:" GET cFone     Pict PIC_FONE
		@ 13,03 Say  "Agencia.....:" GET cAg       Pict "@K!"
		@ 14,03 Say  "Conta N�....:" GET cConta    Pict "@!"
		@ 15,03 Say  "Observ......:" GET cObs      Pict "@!"
		@ 16,03 Say  "Cob Externa.:" GET cExterna  Pict "!" Valid cExterna  $ "SN"
		@ 17,03 Say  "Poupanca....:" GET cPoupanca Pict "!" Valid cPoupanca $ "SN"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		ErrorBeep()
		nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
		IF nOpcao = 1
			IF !Checerto( @cCodi )
				Loop
			EndIF
			Area("Cheque")
			IF Cheque->(Incluiu())
				Cheque->Codi	  := cCodi
				Cheque->Titular  := cTitular
				Cheque->Data	  := dData
				Cheque->Banco	  := cBanco
				Cheque->Cgc 	  := cCgc
				Cheque->Ag		  := cAg
				Cheque->Conta	  := cConta
				Cheque->Fone	  := cFone
				Cheque->Obs 	  := cObs
				Cheque->Mens	  := IF( cMens 	 = "S", OK, FALSO )
				Cheque->Externa  := IF( cExterna  = "S", OK, FALSO )
				Cheque->Poupanca := IF( cPoupanca = "S", OK, FALSO )
				Cheque->(Libera())
				cCodi := StrZero( Val( cCodi )+1, 4 )
			EndIF
		ElseIF nOpcao = 2
			Loop
		Else
			Exit
		EndIF
	EndDo
	ResTela( cScreen )
	Exit
EndDo

Function CheCerto( Var)
***********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( Var ) )
	ErrorBeep()
	Alerta( "Erro: C�digo Conta Invalida ..." )
	Return( FALSO )

EndIF
Area( "Cheque" )
Cheque->(Order( CHEQUE_CODI ))
DbGoTop()
IF (DbSeek( Var ) )
	ErrorBeep()
	Alerta("Erro: Conta J� Registrada ou Incluida por outra Estacao..." )
	Var := StrZero( Val( Var )+1,4)
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )

EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function Cancela( lCancelado)
*****************************
IF Rep_OK()
	lCancelado := FALSO
	Return( OK )
Else
	lCancelado := OK
	Return( FALSO )
EndIF

Function BaixaGeral( cCodi, nApagar, nPago )
********************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL nTotal	 := 0

Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
Set Rela To Codigo Into Lista
IF Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
WHILE Saidas->Codi = cCodi
	IF Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		IF nQuant > 0 // Deve ainda ?
			nTotal += nQuant * Lista->Varejo
		EndIF
	EndIF
	Saidas->(DbSkip(1))
EndDo
IF nTotal = 0
	ErrorBeep()
	Alerta( "Erro: Cliente Sem Debito em Conta Corrente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
nApagar := nTotal
nPago   := nTotal
Saidas->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function SomaPagoInd( nApagar, cFatura, nQuant, cCodigo, nRegistro )
*******************************************************************
LOCAL oBloco
LOCAL nSoma 	  := 0
LOCAL cCombinado := ""
IF LastKey() = UP
	Return( OK )
EndIF
nApagar	  := 0
nPago 	  := 0
cCombinado := cFatura + Space(2) + cCodigo
cTela 	  := Mensagem(" Aguarde...", Cor(), 20)

Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA_CODIGO ))
Set Rela To Codigo Into Lista
Saidas->(DbGoto( nRegistro ))
IF Saidas->Fatura = cFatura .AND. Saidas->Codigo = cCodigo
	nSoma := Saidas->SaidaPaga + nQuant
	IF Saidas->Saida >= nSoma .AND. nQuant != 0
		nApagar := nQuant * Lista->Varejo
		Saidas->(DbClearRel())
		ResTela( cTela )
		Return( OK )
	Else
		ResTela( cTela )
		cSoma := StrZero((Saidas->Saida - Saidas->SaidaPaga), 7)
		ErrorBeep()
		Alerta(" Erro: Quantidade a baixar invalida..." + ;
				"; Disponivel : " + cSoma )
		Saidas->(DbClearRel())
		Return( FALSO)
	EndIF
EndIF
ResTela( cTela )
Alerta(" Erro: Registro nao encontrado...")
Saidas->(DbClearRel())
Return( FALSO )

Function SomaPago( nApagar, cFatura, nPago )
*******************************************
LOCAL oBloco
IF LastKey() = UP
	Return( OK )
EndIF
nApagar := 0
nPago   := 0
Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_FATURA ))
Set Rela To Codigo Into Lista
oBloco := {|| Saidas->Fatura = cFatura }
IF Saidas->(Dbseek( cFatura ))
	WHILE Eval( oBloco )
		IF Saidas->C_c
			nApagar += ( Saidas->Saida - Saidas->SaidaPaga ) * Lista->Varejo
			nPago   += Saidas->SaidaPaga * Lista->Varejo
		Else
			nPago   += ( Saidas->SaidaPaga * Lista->Varejo )
		EndIF
		Saidas->(DbSkip(1))
	EndDo
EndIF
Saidas->(DbClearRel())
IF nApagar = 0
	ErrorBeep()
	Alerta(" Erro: Esta fatura ja esta paga !!")
	Return( FALSO )
EndIF
Return( OK )

Function CalcSobra( nApagar, nPerc, nSobra )
*******************************************
nSobra := nApagar - (( nApagar * nPerc ) / 100 )
Return( OK )

Function cDolar( cDolar )
*************************
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := { " Real ", " Dolar " }
LOCAL aMoeda  := { "R", "U" }
LOCAL nChoice := 1

MaBox( 20, 33, 23, 43 )
nChoice := Achoice( 21, 34, 22, 42, aMenu )
cDolar  := aMoeda[ IF( nChoice = 0, 1, nChoice )]
Keyb Chr( ENTER )
ResTela( cScreen )
Return OK

Proc OrcaLista( lVarejo )
*************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
PRIVA aVetor1 := {"Codigo","Descricao", "Quant", IF( lVarejo = 2, "Varejo", "Atacado"), IF( lVarejo = 2, "Atacado", "Varejo"), "Vendida", "Local", "Sigla", "N_Original"}
PRIVA aVetor2 := {"CODIGO","DESCRICAO DO PRODUTO", "ESTOQUE", IF( lVarejo = 2, "VAREJO", "ATACADO"), IF( lVarejo = 2, "ATACADO", "VAREJO"), "VENDIDA","LOCALIZACACAO", "SIGLA","COD FABRICANTE"}

Area("Lista")
Lista->(Order( LISTA_DESCRICAO ))
Lista->(DbGoTop())
MaBox( 00, 00, 15, MaxCol()-1, "F2 PROCURA �  F6 TROCAR ORDEM � A-Z PROCURA")
Seta1(15)
DbEdit( 01, 01, 14, MaxCol()-2, aVetor1, "OrcaFunc", OK,  aVetor2 )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Proc NewFatura( cDeleteFile)
****************************
LOCAL xAlias := "T" + StrTran( Time(),":") + ".TMP"
Mensagem("Aguarde... Criando Arquivo de Trabalho.")
WHILE File((xAlias))
	xAlias := "T" + StrTran( Time(),":") + ".TMP"
EndDo
Dbf1 := {{ "CODIGO",   "C", 06, 0 }, ; // Codigo do Produto
			{ "UN",       "C", 02, 0 }, ;
			{ "CODI",     "C", 04, 0 }, ;
			{ "QUANT",    "N", 08, 2 }, ;
			{ "DESCONTO", "N", 05, 2 }, ;
			{ "DESCRICAO","C", 40, 0 }, ;
			{ "PCUSTO",   "N", 13, 2 }, ;
			{ "VAREJO",   "N", 13, 2 }, ;
			{ "ATACADO",  "N", 13, 2 }, ;
			{ "UNITARIO", "N", 13, 2 }, ;
			{ "TOTAL",    "N", 13, 2 }, ;
			{ "MARVAR",   "N", 06, 2 }, ;
			{ "MARATA",   "N", 06, 2 }, ;
			{ "UFIR",     "N", 07, 2 }, ;
			{ "IPI",      "N", 05, 2 }, ;
			{ "II",       "N", 05, 2 }, ;
			{ "PORC",     "N", 05, 2 }}
DbCreate( xAlias, Dbf1 )
Use (xAlias) Alias xAlias Exclusive New
Return((xAlias))

Function Acha_Reg( cFatu, cCodigo, nQuant, nRegistro )
******************************************************
LOCAL cScreen	:= SaveScreen()
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cProcura := cFatu + Space(2) + StrCodigo( cCodigo )
LOCAL aTodos	:= {}
LOCAL aRecno	:= {}
LOCAL aQuant	:= {}
LOCAL nChoice	:= 0

Area("Saidas")
Saidas->(Order( SAIDAS_FATURA_CODIGO ))
IF !( DbSeek( cProcura ))
	Saidas->(Order( SAIDAS_FATURA ))
	Saidas->(DbSeek( cFatu ))
	WHILE Saidas->Fatura = cFatu
		 nQuant	:= ( Saidas->Saida - Saidas->SaidaPaga )
		 IF nQuant > 0
			 Aadd( aTodos, Saidas->Codigo + " " + Lista->Descricao )
			 Aadd( aRecno, Saidas->(Recno()))
			 Aadd( aQuant, nQuant )
		 EndIF
		 Saidas->(DbSkip(1))
	EndDo
	MaBox( 03, 19, 17, 79,"CODIGO DESCRICAO DO PRODUTO                             ")
	nChoice := aChoice( 04, 20, 16, 78, aTodos )
	ResTela( cScreen )
	Saidas->(Order( SAIDAS_FATURA_CODIGO ))
	IF nChoice = 0
		Alerta( "Erro: Procura Cancelada..." )
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( FALSO )
	EndIF
	cTemp 	 := Left( aTodos[nChoice],5)
	nRegistro := aRecno[nChoice]
	cCodigo	 := cTemp
	IF DbSeek( cFatu + Space(2) + cTemp )
		IF nQuant != Nil
			nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		EndIF
		AreaAnt( Arq_Ant, Ind_Ant )
		Return( OK )
	EndIF
	ErrorBeep()
	Alerta( "Erro: Produto Nao Encontrado na Fatura..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
IF nQuant != Nil
	nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
	cCodigo := Saidas->Codigo
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function BaixaProcura( cCodi, cFatu, cCodigo, nQuant, nApagar, nRegistro )
**************************************************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cProcura  := cFatu + Space(2) + StrCodigo( cCodigo )
LOCAL aTodos	 := {}
LOCAL aFatura	 := {}
LOCAL aApagar	 := {}
LOCAL aQuant	 := {}
LOCAL aRegistro := {}
LOCAL nChoice	 := 0
LOCAL nTam		 := 0
IF LastKey() = UP
	Return( OK )
EndIF
Lista->(Order( LISTA_CODIGO ))
Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
Set Rela To Codigo Into Lista
IF Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
WHILE Saidas->Codi = cCodi
	IF Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		IF nQuant > 0 // Deve ainda ?
			Aadd( aTodos,	  Saidas->Codigo + " " + Lista->Descricao + Str( nQuant, 9, 2 ))
			Aadd( aFatura,   Saidas->(Left( Fatura,7)))
			Aadd( aQuant,	  nQuant )
			Aadd( aApagar,   Saidas->VlrFatura )
			Aadd( aRegistro, Saidas->(Recno()))
		EndIF
	EndIF
	Saidas->(DbSkip(1))
EndDo
nTam := Len( aTodos )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto a Receber Deste Cliente." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
MaBox( 00, 10, 14, 78,"CODIGO DESCRICAO DO PRODUTO                             ")
nChoice := aChoice( 01, 11, 13, 77, aTodos )
ResTela( cScreen )
IF nChoice = 0
	Alerta( "Erro: Procura Cancelada..." )
	Saidas->(DbClearRel())
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
cCodigo	 := Left( aTodos[nChoice], 6)
cFatu 	 := aFatura[nChoice]
nApagar	 := aApagar[nChoice]
nQuant	 := aQuant[ nChoice ]
nRegistro := aRegistro[ nChoice ]
Saidas->(DbClearRel())
AreaAnt( Arq_Ant, Ind_Ant )
Keyb Chr( ENTER )
Return( OK )

Function BaixaLocaliza( cCodi, cFatu )
**************************************
LOCAL cScreen	 := SaveScreen()
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL aFatura	 := {}
LOCAL nQuant	 := 0
LOCAL nChoice	 := 0
LOCAL cFatura	 := ""

Area("Saidas")
Saidas->(Order( SAIDAS_CODI ))
IF Saidas->(!DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto Faturado Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
WHILE Saidas->Codi = cCodi
	IF Saidas->C_C // Conta Corrente ?
		nQuant  := ( Saidas->Saida - Saidas->SaidaPaga )
		IF nQuant > 0 // Deve ainda ?
			cFatura := Saidas->(Left( Fatura, 7 ))
			IF Ascan( aFatura, cFatura ) = 0
				Aadd( aFatura, cFatura )
			EndIf
		EndIF
	EndIF
	Saidas->(DbSkip(1))
EndDo
nTam := Len( aFatura )
IF nTam = 0
	ErrorBeep()
	Alerta( "Erro: Nenhum Produto a Receber Deste Cliente." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
MaBox( 00, 10, 14, 20,"FATURA N�")
nChoice := aChoice( 01, 11, 13, 19, aFatura )
ResTela( cScreen )
IF nChoice = 0
	Alerta( "Erro: Procura Cancelada..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
cFatu 	 := aFatura[nChoice]
AreaAnt( Arq_Ant, Ind_Ant )
Keyb Chr( ENTER )
Return( OK )

/*--------------------------------*/
Function PickSituacao( cSituacao )

LOCAL aList 	 := { "0=Nacional", "1=Estrangeira - Importacao Direta", "2=Estrangeira - Adquirida no Mercado Interno" }
LOCAL aSituacao := { "0", "1", "2" }
LOCAL cScreen := SaveScreen()
LOCAL nChoice
IF cSituacao $ aSituacao[1] .OR. cSituacao $ aSituacao[2] .OR. cSituacao $ aSituacao[3]
	Return( OK )
Else
	MaBox( 19, 34, 23, 79, NIL, NIL, Roloc( Cor()) )
	IF (nChoice := AChoice( 20, 35, 22, 78, aList )) != 0
		cSituacao := aSituacao[ nChoice ]
	EndIf
EndIF
ResTela( cScreen )
Return( OK )

/*--------------------------------*/
Function PickClasse( cClasse )

LOCAL aList 	 := { "00=Tributada Integralmente", "10=Tributado e com cobranca do ICMS por Sub. Tributaria",;
							"20=Com reducao da Base de Calculo", "30=Isenta ou nao tributada e com Cobranca do ICMS por Sub. Tributaria", ;
							"40=Isenta", "41=Nao Tributada","50=Suspensao", ;
							"51=Diferimento", "60=Icms cobrado anteriormente por Sub. Tributaria",;
							"70=Com reducao de base de calculo e cobranca de ICMS por Substituicao Tributaria",;
							"90=Outros"}
LOCAL aClasse := { "00", "10", "20", "30", "40", "41", "50", "51", "60", "70", "90" }
LOCAL cScreen := SaveScreen()
LOCAL nTam	  := Len( aClasse )
LOCAL nChoice, nX
For nX := 1 To nTam
	IF cClasse $ aClasse[nX]
		Return( OK )
	EndIF
Next
MaBox( 11, 34, 23, 79, NIL, NIL, Roloc( Cor()) )
IF (nChoice := AChoice( 12, 35, 22, 78, aList )) != 0
	cClasse := aClasse[ nChoice ]
EndIF
ResTela( cScreen )
Return( OK )
/*--------------------------------*/

Function CalculaVenda( nPcusto, nMarVar, nVar )
************************************************
nVar := (( nPcusto * nMarVar ) / 100 ) + nPcusto
Return( OK )

Function DataExt( dData )
*************************
LOCAL Mes, MesExt

IF( dData = Nil, dData := Date(), dData )
Mes := Month( dData)

MesExt := { "Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
				"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }

Cidade = XCCIDA + ",  "
Return( Cidade + StrZero( Day( dData), 2 ) +" de " + MesExt[ Mes] +" de " + Str(YEAR( dData ),4))

Proc ReciboRegiao()
*******************
LOCAL cScreen	 := SaveScreen()
LOCAL nVlr		 := 0
LOCAL cValor	 := Space(0)
LOCAL Larg		 := 80
LOCAL nValor	 := Space(0)
LOCAL nOpcao	 := 1
LOCAL cDocnr
LOCAL cHist 	 := Space(60)
LOCAL lCalcular := FALSO
LOCAL oBloco

oMenu:Limpa()
cRegiao := Space(02)
dIni	  := Date()-30
dFim	  := Date()
MaBox( 10, 10, 15, 79 )
@ 11, 11 Say "Regiao.... :" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao ) .AND. VerRegiao( cRegiao )
@ 12, 11 Say "Data Ini.. :" Get dIni    Pict "##/##/##"
@ 13, 11 Say "Data Fim.. :" Get dFim    Pict "##/##/##"
@ 14, 11 Say "Referente..:" Get cHist   Pict "@!"
Read
IF LastKey() = ESC
	ResTela( cScreen )
	Return
EndIF
Receber->(Order( RECEBER_CODI ))
Area("Recemov")
Set Rela To Recemov->Codi Into Receber
Recemov->(Order( RECEMOV_REGIAO ))
Recemov->(DbSeek( cRegiao ))
oBloco := {|| Recemov->Regiao = cRegiao }
lCalcular := Conf("Pergunta: Calcular Juros ?")
IF !Instru80() .OR. !LptOk()
	Restela( cScreen )
	Return
EndIF
cTela := Mensagem("Aguarde, Imprimindo Recibo.", Cor())
PrintOn()
FPrInt( Chr(ESC) + "C" + Chr( 33 ))
While Eval( oBloco ) .AND. Recemov->(!Eof()) .AND. Rep_Ok()
	IF Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim
		cDocnr	 := Recemov->Docnr
		nMoeda	 := 1
		nVlr		 := Recemov->Vlr
		nVlrTotal := Recemov->Vlr
		IF lCalcular
			nAtraso	 := Atraso( Date(), Vcto )
			nCarencia := Carencia( Date(), Vcto )
			IF nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := Recemov->Vlr
			Else
				nTotJuros := nCarencia * Recemov->Jurodia
				nVlrTotal := ( nTotJuros + Recemov->Vlr )
			EndIF
		EndIF
		cValor  := AllTrim(Tran( nVlrTotal,'@E 999,999,999,999.99'))
		nValor  := Extenso( nVlrTotal, nMoeda, 3, Larg )
		SetPrc(0,0)
		nRow := 2
		Write( nRow+00, 00, Repl("=",80))
		Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta), 40) + CA )
		Write( nRow+02, 00, Padc( XENDEFIR + " - " + XCCIDA + " - " + XCESTA, 80 ))
		Write( nRow+03, 00, Repl("-",80))
		Write( nRow+04, 00, "N� " + NG + cDocnr + NR )
		Write( nRow+04, 40, GD + "RECIBO" + CA )
		Write( nRow+04, 65, "R$ " + NG + cValor + NR)
		Write( nRow+06, 00, "Recebemos de    : " + NG + Receber->Nome + NR )
		Write( nRow+07, 00, "Estabelecido  a : " + NG + Receber->Ende + NR )
		Write( nRow+08, 00, "na Cidade de    : " + NG + Receber->Cida + NR )
		Write( nRow+10, 00, "A Importancia por extenso abaixo relacionada")
		Write( nRow+11, 00, NG + Left( nValor, Larg ) + NR  )
		Write( nRow+12, 00, NG + SubStr( nValor, Larg + 1, Larg ) + NR  )
		Write( nRow+13, 00, NG + Right( nValor, Larg ) + NR  )
		Write( nRow+15, 00, "Referente a")
		Write( nRow+16, 00, NG + cHist + NR )
		Write( nRow+18, 00, "Para maior clareza firmo(amos) o presente")
		Write( nRow+19, 35, NG + DataExt( Date()) + NR )
		Write( nRow+23, 00, "1� VIA - CLIENTE" )
		Write( nRow+23, 40, Repl("-",40))
		Write( nRow+24, 00, Repl("=",80))
		__Eject()
	EndIF
	Recemov->(DbSkip(1))
Enddo
Recemov->(DbClearRel())
Recemov->(DbClearFilter())
Recemov->(DbGoTop())
PrintOff()
ResTela( cTela )
Return

Function VerRegiao( cRegiao )
*****************************
Recemov->(Order( RECEMOV_REGIAO ))
IF Recemov->(!DbSeek( cRegiao ))
	ErrorBeep()
	Alerta("Erro: Regiao Sem Movimento.")
	Return( FALSO )
EndIF
Return( OK )


/*
Function PutKey(oGet, cKey)
***************************
oGet:exitState := cKey
Return(OK)
*/

Proc LogAgenda( aAgenda )
**********************
IF Agenda->(Incluiu())
	Agenda->Codi	 := aAgenda[1]
	Agenda->Data	 := aAgenda[2]
	Agenda->Hora	 := Time()
	Agenda->Hist	 := aAgenda[3]
	Agenda->Caixa	 := aAgenda[4]
	Agenda->Usuario := aAgenda[5]
	Agenda->Ultimo  := aAgenda[6]
	Agenda->(Libera())
EndIF
Return

Proc LogRecibo( aLog )
**********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cScreen := SaveScreen()
LOCAL xLog	  := 'RECIBO.LOG'
LOCAL cString := Space(0)
LOCAL nLen
LOCAL nHandle
LOCAL x

IF !File( xLog )
	nHandle := Fcreate( xLog, FC_NORMAL )
	FClose( nHandle )
EndIF
nHandle := FOpen( xLog, FO_READWRITE + FO_SHARED )
IF ( Ferror() != 0 ) // Erro
	Return
EndIF
nErro := FLocate( nHandle, aLog[ALOG_DATA]) // Data Sistema
FBot( nHandle )
IF nErro < 0
	FWriteLine( nHandle, Repl("=", 186))
	FWriteLine( nHandle, "TIPO   CODI  NOME CLIENTE                             DOCTO N�  VENCTO   HORA     DATA_OS  USUARIO    CAIX       VALOR RECIBO HISTORICO")
	FWriteLine( nHandle, Repl("-", 186))
EndIF
nLen := Len(aLog)-3 //Ende, Cida

For x := 1 To nLen
	cString += aLog[x] + ' '
Next

FWriteLine( nHandle, cString )
FClose( nHandle )
IF Recibo->(Incluiu())
	Recibo->Tipo	 := aLog[ALOG_TIPO]
	Recibo->Codi	 := aLog[ALOG_CODI]
	Recibo->Nome	 := aLog[ALOG_NOME]
	Recibo->Docnr	 := aLog[ALOG_DOCNR]
	Recibo->Vcto	 := Ctod(aLog[ALOG_VCTO])
	Recibo->Hora	 := aLog[ALOG_HORA]
	Recibo->Data	 := Ctod(aLog[ALOG_DATA])
	Recibo->Usuario := aLog[ALOG_USUARIO]
	Recibo->Caixa	 := aLog[ALOG_CAIXA]
	Recibo->Vlr 	 := StrToVal(aLog[ALOG_VLR])
	Recibo->Hist	 := aLog[ALOG_HIST]
	Recibo->Fatura  := aLog[ALOG_FATURA]
EndIF
Recibo->(Libera())
AreaAnt( Arq_Ant, Ind_Ant )
Return

Function CalcJuros()
********************
LOCAL nAtraso	 := Atraso( Date(), Recemov->Vcto )
LOCAL nCarencia := Carencia( Date(), Recemov->Vcto )
LOCAL nTotJuros := 0

	nVlrTotal := Recemov->Vlr
	IF nAtraso > 0
		nTotJuros := Recemov->Jurodia * nCarencia
		nVlrTotal += nTotJuros
	EndIF
	Return( nVlrTotal )

Function ImprimirEtiqueta( aConfig, oBloco )
********************************************
LOCAL cScreen	  := SaveScreen()
LOCAL nCampos	  := 5
LOCAL nTamanho   := 35
LOCAL nMargem	  := 0
LOCAL nLinhas	  := 1
LOCAL nEspacos   := 1
LOCAL nCarreira  := 1
LOCAL nX 		  := 0
LOCAL aArray	  := {}
LOCAL aGets 	  := {}
LOCAL lComprimir := FALSO

IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
nLen	  := Len( aConfig )
IF nLen > 0
	nCampos	  := aConfig[1]
	nTamanho   := aConfig[2]
	nMargem	  := aConfig[3]
	nLinhas	  := aConfig[4]
	nEspacos   := aConfig[5]
	nCarreira  := aConfig[6]
	lComprimir := aConfig[7] == 1
	For nX := 8 To nLen
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
SetPrc( 0, 0 )
WHILE Eval( oBloco ).AND. !Rep_Ok()
	nCol := nMargem
	For nA := 1 To nCarreira
		For nB := 1 To nCampos
			cVar := aGets[nB]
			nTam := Len( &cVar. )
			aLinha[nB] += &cVar. + Space( ( nTamanho - nTam ) + nEspacos )
		Next
		DbSkip(1)
	Next
	For nC := 1 To nCampos
		Qout( aLinha[nC] )
		aLinha[nC] := ""
	Next
	For nD := 1 To nLinhas
		Qout()
	Next
EndDo
PrintOFF()
ResTela( cScreen )
Return

Proc ConfigurarEtiqueta()
*************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nCampos	  := 5
LOCAL nTamanho   := 35
LOCAL nMargem	  := 0
LOCAL nLinhas	  := 1
LOCAL nEspacos   := 1
LOCAL nCarreira  := 1
LOCAL nComprimir := 0
LOCAL nSpVert	  := 1
LOCAL nX 		  := 0
LOCAL aArray	  := {}
LOCAL aGets 	  := {}
LOCAL cArquivo   := 'ETIQUETA.ETI'
LOCAL oEtiqueta

Set Key F12 To
oMenu:Limpa()
MaBox( 05, 10, 07, 60 )
@ 06, 11 Say "Gravar no Arquivo.......:" Get cArquivo Pict "@!" Valid PickArquivo( @cArquivo, '*.ETI', OK)
Read
IF LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
EndIF
oEtiqueta  := TIniNew( oAmbiente:xBaseDoc + '\' + cArquivo )
nCampos	  := oEtiqueta:ReadInteger('configuracao', 'Campos',    05 )
nTamanho   := oEtiqueta:ReadInteger('configuracao', 'Tamanho',   35 )
nMargem	  := oEtiqueta:ReadInteger('configuracao', 'Margem',    00 )
nLinhas	  := oEtiqueta:ReadInteger('configuracao', 'Linhas',    01 )
nEspacos   := oEtiqueta:ReadInteger('configuracao', 'Espacos',   01 )
nCarreira  := oEtiqueta:ReadInteger('configuracao', 'Carreira',  01 )
nComprimir := oEtiqueta:ReadInteger('configuracao', 'Comprimir', 00 )
nSpVert	  := oEtiqueta:ReadInteger('configuracao', 'Vertical',  01 )

MaBox( 08, 10, 17, 60 )
@ 09, 11 Say "Quantidade de Campos....:" Get nCampos    Pict "99"  Range 1, 16
@ 10, 11 Say "Tamanho da Etiqueta.....:" Get nTamanho   Pict "999" Range 1, 120
@ 11, 11 Say "Margem Esquerda.........:" Get nMargem    Pict "999" Range 0, 250
@ 12, 11 Say "Linhas Entre Etiquetas..:" Get nLinhas    Pict "99"  Range 0, 16
@ 13, 11 Say "Espaco Entre Etiquetas..:" Get nEspacos   Pict "999" Range 0, 120
@ 14, 11 Say "Quantidade de Carreiras.:" Get nCarreira  Pict "999" Range 1, 8
@ 15, 11 Say "Comprimir Impressao.....:" Get nComprimir Pict "9"   Valid PickTam({'Nao','Sim'}, {0,1}, @nComprimir )
@ 16, 11 Say "Espacamento Vertical....:" Get nSpVert    Pict "9"   Valid PickTam({'1/6"','1/8"'}, {0,1}, @nSpVert )
Read
IF LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
EndIF
For nX := 1 To nCampos
	cCampo := oEtiqueta:ReadString('campos', 'campo' + StrZero( nX, 3), Space(60))
	cCampo += Space(60-Len(cCampo))
	Aadd( aGets, cCampo )
Next
oMenu:Limpa()
MaBox( 01, 01, 02+nCampos, 76, "DEFINICAO DOS CAMPOS DA ETIQUETA" )
For nX := 1 To nCampos
	cLinha := "Linha " + StrZero( nX, 2 ) + "...: "
	@ 01+nX, 02 Say cLinha Get aGets[nX] Pict "@!"
Next
Read
IF LastKey() = ESC
	Set Key F12 To ConfigurarEtiqueta()
	ResTela( cScreen )
	Return
EndiF
oEtiqueta:Close()
oEtiqueta  := TIniNew( oAmbiente:xBaseDoc + '\' + cArquivo )
oEtiqueta:WriteString('configuracao', 'Campos',    StrZero( nCampos,    2))
oEtiqueta:WriteString('configuracao', 'Tamanho',   StrZero( nTamanho,   3))
oEtiqueta:WriteString('configuracao', 'Margem',    StrZero( nMargem,    3))
oEtiqueta:WriteString('configuracao', 'Linhas',    StrZero( nLinhas,    2))
oEtiqueta:WriteString('configuracao', 'Espacos',   StrZero( nEspacos,   3))
oEtiqueta:WriteString('configuracao', 'Carreira',  StrZero( nCarreira,  2))
oEtiqueta:WriteString('configuracao', 'Comprimir', StrZero( nComprimir, 1))
oEtiqueta:WriteString('configuracao', 'Vertical',  StrZero( nSpVert,    1))
For nX := 1 To nCampos
	oEtiqueta:WriteString('campos',    'campo' + StrZero( nX, 3), AllTrim( aGets[nX]))
Next
Set Key F12 To ConfigurarEtiqueta()
ResTela( cScreen )
Return

Proc Bordero()
**************
LOCAL Getlist := {}
LOCAL cScreen := SaveScreen()
LOCAL aArray  := {}
LOCAL cDocnr  := Space(09)
LOCAL nTam	  := 0
LOCAL nVlr	  := 0
LOCAL nTitulo := 0

oMenu:Limpa()
WHILE OK
	cDocnr := Space(09)
	MaBox( 10, 05, 16, 79 )
	@ 11, 06 Say "Documento N�.: " Get cDocnr Pict "@!" Valid DocErrado( @cDocnr )
	@ 12, 06 Say "Cliente......: "
	@ 13, 06 Say "Emissao......: "
	@ 14, 06 Say "Vcto.........: "
	@ 15, 06 Say "Valor........: "
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	Recemov->(Order( RECEMOV_DOCNR ))
	Receber->(Order( RECEBER_CODI ))
	IF Recemov->(DbSeek( cDocnr ))
		cCodi := Recemov->Codi
		Receber->(DbSeek( cCodi ))
		Write( 12, 22, Receber->Nome )
		Write( 13, 22, Recemov->Emis )
		Write( 14, 22, Recemov->Vcto )
		Write( 15, 22, Recemov->(Tran( Vlr, "@E 999,999,999.99")))
		IF Conf("Pergunta: Selecionar para impressao ?")
			Aadd( aArray, cDocnr )
			nVlr	 += Recemov->Vlr
			nTitulo++
		EndIF
	EndIF
	IF nTitulo >= 14
		Exit
	EndIF
EndDo
nTam := Len( aArray )
IF nTam > 0
	oMenu:Limpa()
	ErrorBeep()
	IF !Conf("Pergunta: Deseja Imprimir os Registros ?")
		ResTela( cScreen )
		Return
	EndIF
	cPrefixo  := Space(07)
	cCodigo	 := Space(10)
	cCedente  := Space(15)
	cCarteira := Space(03)
	cVar		 := Space(04)
	cBordero  := Space(15)
	cPrefix	 := Space(05)
	cEspecie  := Space(03)
	cInstru	 := Space(05)
	dData 	 := Date()
	cResponsa := Space(10)
	cIof		 := Space(03)
	cConta	 := Space(15)
	cRazao	 := Space(20)
	MaBox( 05, 10, 20, 60, "INFORMACOES COMPLEMENTARES")
	@ 06, 11 Say "Prefixo Usuario...:" Get cPrefixo  Pict "@!"
	@ 07, 11 Say "Codigo Usuario....:" Get cCodigo   Pict "@!"
	@ 08, 11 Say "Codigo Cedente....:" Get cCedente  Pict "@!"
	@ 09, 11 Say "Carteira..........:" Get cCarteira Pict "@!"
	@ 10, 11 Say "Var...............:" Get cVar      Pict "@!"
	@ 11, 11 Say "N� Bordero........:" Get cBordero  Pict "@!"
	@ 12, 11 Say "Prefixo...........:" Get cPrefix   Pict "@!"
	@ 13, 11 Say "Especie...........:" Get cEspecie  Pict "@!"
	@ 14, 11 Say "Instrucoes Codif..:" Get cInstru   Pict "@!"
	@ 15, 11 Say "Data Valorizacao..:" Get dData     Pict "##/##/##"
	@ 16, 11 Say "Codigo Responsab..:" Get cResponsa Pict "@!"
	@ 17, 11 Say "Iof...............:" Get cIof      Pict "@!"
	@ 18, 11 Say "Conta Emitente....:" Get cConta    Pict "@!"
	@ 19, 11 Say "Razao Deposito....:" Get cRazao    Pict "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	IF Instru80() .AND. LptOk()
		PrintOn()
		FPrint( PQ )
		Write( 05, 006, AllTrim(oAmbiente:xNomefir) )
		Write( 05, 110, XCGCFIR )
		Write( 07, 006, XENDEFIR )
		Write( 07, 090, XCCEP )
		Write( 07, 110, XCCIDA )

		Write( 09, 020, cPrefixo )
		Write( 09, 033, cCodigo )
		Write( 09, 049, cCedente )
		Write( 09, 074, cCarteira )
		Write( 09, 082, cVar )
		Write( 09, 091, cBordero )
		Write( 09, 118, cPrefix )
		Write( 09, 130, cEspecie )
		Write( 11, 010, Tran( nVlr, "@E 999,999,999.99"))
		Write( 11, 060, cInstru )
		Write( 11, 070, dData )
		Write( 11, 117, cResponsa )
		Write( 13, 004, cIof )
		Write( 13, 034, cConta )
		Write( 13, 060, cRazao )

		nCol	:= 19
		nSoma := 0
		cDia	:= StrZero( Day( Date()),2)
		cMes	:= Mes( Date())
		cAno	:= StrZero(Year( Date()),4)
		For nX := 1 To nTam
		  IF Recemov->(DbSeek( aArray[ nX ]))
				nSoma++
				IF nSoma = 1
					Write( nCol, 06, Recemov->Docnr )
					Write( nCol, 34, Recemov->Vlr )
					Write( nCol, 57, Recemov->Vcto )
				Else
					Write( nCol, 075, Recemov->Docnr )
					Write( nCol, 103, Recemov->Vlr )
					Write( nCol, 125, Recemov->Vcto )
					nSoma := 0
					nCol++
				EndIF
			EndIF
		Next
		Write( 27, 003, XCCIDA )
		Write( 27, 034, cDia )
		Write( 27, 042, cMes )
		Write( 27, 063, cAno )
		Write( 27, 102, Tran( nVlr, "@E 999,999,999.99"))
		Write( 27, 122, nTam )
		__Eject()
		PrintOff()
	EndIF
EndIF
ResTela( cScreen )
Return

Function CepCerto( cCep, lModificar, cSwap )
********************************************
FIELD Cep, Cida, Bair

IF LastKey() = UP
	Return( OK )
EndIF

IF lModificar != NIL .AND. lModificar
	IF cCep == cSwap
		Return( OK )
	EndIF
EndIF

IF Empty( cCep )
	ErrorBeep()
	Alerta("Erro: Entrada de Cep Invalido.")
	Return( FALSO )
EndIF
Cep->(Order( CEP_CEP ))
IF Cep->(DbSeek( cCep ))
	ErrorBeep()
	Alerta("Erro: Cep Ja Registrado. " + Cep->( AllTrim( Cida)))
	Return( FALSO )
EndIF
Return( OK )

Function CepErrado( cCep, cCida, cEsta, cBair )
***********************************************
LOCAL aRotina			  := {{|| CepInclusao()}}
LOCAL aRotinaAlteracao := {{|| CepInclusao( OK )}}
LOCAL Ind_Ant			  := IndexOrd()
LOCAL Arq_Ant			  := Alias()

Area("Cep")
Cep->(Order( CEP_CEP ))
IF (Lastrec() = 0 )
	ErrorBeep()
	IF Conf(" Pergunta: Nenhum Cep Disponivel. Registrar ?")
		CepInclusao()
	EndIF
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
IF Cep->(!DbSeek( cCep ))
	Cep->(Order( CEP_CIDA ))
	Cep->(Escolhe( 03, 01, 22, "Cep + '�' + Cida + '�' + Esta + '�' + Bair ", "CEP        CIDADE                      UF BAIRRO", aRotina,, aRotinaAlteracao ))
EndIF
cCep	:= Cep->Cep
cCida := Cep->Cida
cEsta := Cep->Esta
IF Empty( cBair )
	cBair := Cep->Bair
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc CepPrint()
***************
LOCAL cScreen	  := SaveScreen()
LOCAL aMenuArray := { " Video ", " Impressora " }
LOCAL nChoice := 0

M_Title("CONSULTA/IMPRESSAO DE CEP")
nChoice := FazMenu( 10,10, aMenuArray, Cor())
Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Return

	Case nChoice = 1
		CepVideo()

	Case nChoice = 2
		CepImpressora()

EndCase

Proc CepVideo()
***************
LOCAL cScreen := SaveScreen()
LOCAL aCep	  := {}
LOCAL cTela

Area("Cep")
Cep->(Order( CEP_CEP ))
Cep->(DbGoTop())
cTela := Mensagem("Aguarde ... ", Cor())

WHILE !Eof() .AND. Rep_Ok()
	 Aadd( aCep,  Cep->Cep + " " + Cep->Cida + " " + Cep->Esta + " " + Cep->Bair )
	 Cep->(DbSkip(1))
EndDo

IF Len( aCep ) != ZERO
	ResTela( cTela )
	cString := " CEP       CIDADE                    UF BAIRRO"
	Print( 00, 00, cString + Space( 80 - Len(  cString )), Roloc(Cor()))
	M_Title( "ESC Retorna ")
	Mx_Choice( 01, 00, 24, 79, aCep, Cor())
EndIF

ResTela( cScreen )
Return

Proc CepImpressora()
********************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0
LOCAL lSair   := FALSO

IF !InsTru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF

Area("Cep")
Cep->(Order( CEP_CEP ))
Cep->(DbGoTop())
Mensagem("Aguarde. Imprimindo.", Cor())
PrintOn()
SetPrc( 0, 0 )
WHILE Cep->(!Eof()) .AND. Rel_Ok()

  IF Col >= 58
	  Write( 00, 00, Linha1( Tam, @Pagina))
	  Write( 01, 00, Linha2())
	  Write( 02, 00, Linha3(Tam))
	  Write( 03, 00, Linha4(Tam, SISTEM_NA2 ))
	  Write( 04, 00, Padc( "LISTAGEM DE CEPS",Tam ) )
	  Write( 05, 00, Linha5(Tam))
	  Write( 06, 00, "CEP       CIDADE                    UF BAIRRO")
	  Write( 07, 00, Linha5(Tam))
	  Col := 8
  EndIF

  Cep->( Qout( Cep, Cida, Esta, Bair ))
  Col++

  IF Col >= 58
	  Write( Col, 0,	Repl( SEP, Tam ))
	  __Eject()
  EndIF

  Cep->(DbSkip(1))
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

#IFDEF SWAP
	Proc Edicao( lEditarArquivoDeConfiguracao, cTipoDeArquivo )
	***********************************************************
	LOCAL cScreen	  := SaveScreen()
	LOCAL aMenuArray := {" Sci ", " Ed ", " Edit (DOS) ", " Notepad (Windows) "}
	LOCAL Files 	  := '*.DOC'
	LOCAL cFiles	  := IF( cTipoDeArquivo != NIL, cTipoDeArquivo, "" )
	LOCAL GetList	  := {}
	LOCAL nChoice	  := 1
	LOCAL cEditor
	PRIVA Arquivo

	FChdir( oAmbiente:xBaseDoc )
	Set Defa To ( oAmbiente:xBaseDoc )
	IF lEditarArquivoDeConfiguracao = NIL
		M_Title("EDITOR DE TEXTO")
		nChoice := FazMenu( 03, 05, aMenuArray, Cor())
		IF nChoice = 0
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
			ResTela( cScreen )
			Return
		EndIF
		ResTela( cScreen )
		Arquivo := "CARTA.DOC" + Space(03)
		MaBox( 16, 10, 18, 61 )
		@ 17, 11 Say "Arquivo a Editar....:" Get Arquivo PICT "@!"
		Read
		IF LastKey() = ESC
			FChdir( oAmbiente:xBaseDados )
			Set Defa To ( oAmbiente:xBaseDados )
			ResTela( cScreen )
			Return
		EndIF
		IF Empty( Arquivo )
			M_Title( "Setas CIMA/BAIXO Move")
			Arquivo := Mx_PopFile( 03, 10, 15, 61, Files, Cor())
			IF Empty( Arquivo )
				FChdir( oAmbiente:xBaseDados )
				Set Defa To ( oAmbiente:xBaseDados )
				ErrorBeep()
				ResTela( cScreen )
				Return
			EndIF
		Else
			IF nChoice != 4
				IF !File( Arquivo )
					ErrorBeep()
					ResTela( cScreen )
					IF !Conf( Rtrim( Arquivo ) + " Nao Encontrado. Posso Cria-lo ? ")
						FChdir( oAmbiente:xBaseDados )
						Set Defa To ( oAmbiente:xBaseDados )
						ResTela( cScreen )
						Return
					EndIF
				EndIF
			EndIF
		EndIF
	Else
		oMenu:Limpa()
		M_Title("ESCOLHA O ARQUIVO DE CONFIGURACAO A ALTERAR" )
		Arquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
	EndIF
	IF nChoice = 1
		Set Key F10 To
		Set Key F2	To
		Set Key F1	To
		SetColor("GR+/N")
		@ 01, 00 TO 24-1, MaxCol()
		SetColor("W/W")
		StatusSup("�F1=HELP�CTRL+P=IMPRIMIR�ESC=SAIR�F2=GRAVA E SAI�F3=LIG ACENTO�F4=DES ACENTO", Cor(2))
		StatusInf( RTrim( Arquivo),"")
		SetColor("B/W")
		SetCursor(1)
		//Liga_Acento()
		MemoWrit( Arquivo, MemoEdit( MemoRead( Arquivo ), 02, 01, 24-2, (MaxCol()-2), .T., "Linha", 132))
		Set Key F10 To Calc()
		oAmbiente:Acento := FALSO
		ResTela( cScreen )
		Desliga_Acento()
		Set Key F1 To Help()
		FChdir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
		Return
	ElseIf nChoice = 2
		cEditor := "Ed"
	ElseIf nChoice = 3
		cEditor := "Edit"
	ElseIf nChoice = 4
		cEditor := "Notepad"
	EndIF
	i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPCURDIR(OK)
	i = SWPVIDMDE(OK)
	i = SWPRUNCMD( ( cEditor + " " + Arquivo ), 0, "", "")
	ResTela( cScreen )
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	Return

	Proc Comandos()
	***************
	LOCAL GetList	:= {}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
	WHILE OK
		oMenu:Limpa()
		cComando := Space(256)
		MaBox( 20, 10, 22, 62 )
		@ 21, 11 Say "Comando :" Get cComando Pict "@S40" Valid !Empty( cComando )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
		EndIF
		SetColor("")
		Cls
		cComando := AllTrim( cComando )
		i = SWPUSEEMS(OK)
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		i = SWPRUNCMD( cComando, 0, "", "")
	EndDo
	ResTela( cScreen )
	VerDataDos()
	Return

	Function Linha( Mode, Line, Col )
	*********************************
	LOCAL nCopias	  := 1
	LOCAL cScreen	  := SaveScreen()
	LOCAL lCancel	  := FALSO
	LOCAL cOldColor  := SetColor()
	LOCAL Tela1

	DO Case
	Case Mode = 0
		StatusInf( Rtrim( Arquivo), StrZero( Line, 4) + ":" + StrZero( Col, 4 ))
		Return( 0 )

	Case LastKey() =	-1 	  // F2	GRAVA E SAI
		Return( 23 )

	Case LastKey() =	F3
		Liga_Acento()
		Return(1)

	Case LastKey() =	F4
		Desliga_Acento()
		Return(1)

	Case LastKey() =	27 	  // ESC ?
		IF Conf(" Deseja Gravar o Texto ? " )
			Return( 23 )

		EndIF

	Case LastKey() =	F1
		MaBox( 10, 10, 17, 50, "COMANDOS DE EDICAO")
		Write( 11, 11, "CTRL+Y = Limpar Linha Corrente")
		Write( 12, 11, "CTRL+T = Eliminar Palavra a Direita")
		Write( 13, 11, "DELETE = Eliminar Caractere")
		Write( 14, 11, "INSERT = Liga/Desliga Insercao")
		Write( 15, 11, "HOME   = Vai para Inicio da Linha")
		Write( 16, 11, "END    = Vai para Final da Linha")
		Inkey(0)
		ResTela( cScreen )
		Return( 1 )

	Case LastKey() =	K_CTRL_P
		nCopias := 1
		MaBox( 13, 10, 15, 31 )
		@ 14,11 SAY "Qtde Copias...:" Get nCopias PICT "999" Valid nCopias > 0
		Read
		IF LastKey() = ESC .OR. !Instru80()
			SetColor( cOldColor )
			ResTela( cScreen )
			Return
		EndIF
		Mensagem("Aguarde, Imprimindo.", Cor())
		PrintOn()
		SetPrc( 0, 0 )
		For X := 1 To nCopias
			 Campo	  := MemoRead( Arquivo )
			 Linhas	  := MlCount( Campo, 80 )
			 For Linha := 1 To Linhas
				 Imprime := MemoLine( Campo, 80, linha )
				 Write( 0 + Linha -1, 0, Imprime )
			 Next
			 __Eject()
		Next
		PrintOff()
		SetColor( cOldColor )
		ResTela( cScreen )
		Return

	OtherWise
		Return(0)

	EndCase

	Proc Dos()
	***********
	LOCAL cScreen	 := SaveScreen()
	LOCAL cOldColor := SetColor()
	LOCAL cOldDir	 := Curdir()
	LOCAL nChoice
	SetColor("")
	Cls
	nChoice := Alerta("Para retornar ao Microbras SCI digite EXIT")
	IF nChoice = 0
		ResTela( cScreen )
		SetColor( cOldColor )
		Return
	EndIF
	?
	?
	?
	i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPCURDIR(OK)
	FChDir( oAmbiente:xBase )
	i = SWPVIDMDE(OK)
	i = SWPRUNCMD( "", 0, "", "")
	FChDir( cOldDir )
	ResTela( cScreen )
	SetColor( cOldColor )
	VerDataDos()
	Return

	Proc MacroRestore()
	******************
	LOCAL GetList	:= {}
	LOCAL aDrive	:= { "A:","B:","C:","D:","E:","F:","G:","H:","I:","J:"}
	LOCAL aArray1	:= { "Todos os Arquivos","Especificar Arquivo" }
	LOCAL aZip		:= { "A:\SCI.ZIP", "B:\SCI.ZIP", "C:\SCIBACKU\","D:\SCIBACKU\","E:\SCIBACKU\","F:\SCIBACKU\"}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
	LOCAL cOldDir	:= Curdir()
	LOCAL nChoice	:= 0
	LOCAL nChoice1 := 0
	LOCAL cFiles	:= "*.ZIP"
	LOCAL cStr1 	:= ""
	LOCAL cStr2 	:= ""

	IF !PodeFazerRestauracao()
		Return
	EndIF

	WHILE OK
		M_Title("COPIA DE SEGURANCA - RESTAURACAO")
		nChoice := FazMenu( 08, 10, aDrive, Cor())
		IF nChoice = 0
			ResTela( cScreen )
			Exit
		EndIF
		oMenu:Limpa()
		i = SWPUSEEMS(OK)
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		ErrorBeep()
		cStr1 := "Atencao Insira o disco de dados no " + aDrive[nChoice]
		IF nChoice = 1
			cStr2 := "Dcomprim -d -o " + aZip[nChoice]
		ElseIF nChoice = 2
			cStr2 := "Dcomprim -d -o " + aZip[nChoice]
		ElseIF nChoice >= 3
			cFiles := aDrive[nChoice] + "\SCIBACKU\*.ZIP"
			IF !File( cFiles )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alert("Erro: Arquivos de Backup nao disponiveis.")
			  ResTela( cScreen )
			  Exit
			EndIF
			oMenu:Limpa()
			M_Title("ESCOLHA O ARQUIVO PARA RESTAURACAO")
			xArquivo := Mx_PopFile( 05, 10, 20, 74, cFiles, Cor() )
			IF Empty( xArquivo )
				ErrorBeep()
				ResTela( cScreen )
				Exit
			EndIF
			cStr2 := "Dcomprim -d -o " + xArquivo
		EndIf
		M_Title("COPIA DE SEGURANCA - OPCOES")
		nChoice1 := FazMenu( 12, 12, aArray1, Cor())
		IF nChoice1 = 0
			ResTela( cScreen )
			Exit
		EndIF
		IF nChoice1 = 1
			IF Alert( cStr1, { " Cancelar ", " Continuar " }) = 2
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
				i := SWPRUNCMD( cStr2, 0, "", "" )
				FChDir( cOldDir )
			EndIF
		Else
			cEspFile := Space( 40 )
			MaBox( 20, 12, 22, 75 )
			@ 21, 13 Say "Arquivos :" Get cEspFile Pict "@!" Valid !Empty( cEspFile )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Return
			EndiF
			IF Alert( cStr1, { " Cancelar ", " Continuar " }) = 2
				 SetColor("")
				 Cls
				 FChDir( oAmbiente:xBase )
				 i := SWPRUNCMD( cStr2 + ' ' + ( cEspFile ), 0, "", "" )
				 FChDir( cOldDir )
			 EndIF
		EndIF
		ResTela( cScreen )
	EndDo
	Return

	Proc MacroBackup()
	******************
	LOCAL GetList	:= {}
	LOCAL aArray	:= { "A:","B:","C:","D:","E:","F:","G:","H:","I:","J:"}
	LOCAL cScreen	:= SaveScreen()
	LOCAL cComando := Space(256)
	LOCAL cOldDir	:= Curdir()
	LOCAL cData 	:= ' -S' + StrTran(Dtoc(Date()),'/') + ' '
	LOCAL cPath
	LOCAL xDiretorio
	LOCAL xString
	LOCAL xDrive

	IF !PodeFazerBackup()
		Return
	EndIF
	WHILE OK
		M_Title("COPIA DE SEGURANCA - BACKUP")
		nChoice := FazMenu( 05, 10, aArray, Cor())
		IF nChoice = 0
			ResTela( cScreen )
			Exit
		EndIF
		oMenu:Limpa()
		i = SWPUSEXMS(OK)
		i = SWPUSEUMB(OK)
		i = SWPCURDIR(OK)
		i = SWPVIDMDE(OK)
		i = SWPDISMSG(OK)
		ErrorBeep()
		xDrive := aArray[nChoice]
		IF nChoice = 1 .OR. nChoice = 2	// A: B:
			IF Alert("Atencao Todos o dados do Drive " + xDrive + " serao apagados.", { " Cancelar ", " Continuar " }) = 2
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
// 			xString := "COMPRIME -EX -RP -&F " + xDrive + cData + "\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.ETI + *.NFF + *.COB + *.DUP *.LIS *.DIV *.LOG"
				xString := 'COMPRIME -EX -RP ' + cData + ' -&F ' + xDrive + "\SCI *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.LOG + *.ETI + *.NFF + *.COB + *.DUP + *.DIV"
				i		  := SWPRUNCMD( xString, 0, "", "" )
				FChDir( cOldDir )
			EndIF
		ElseIF nChoice > 2
			xDiretorio := xDrive + "\SCIBACKU"
			cDiaMes	  := Left( StrTran( Dtoc( Date()), "/"), 4 )
			cDia		  := xDiretorio + "\SCI" + cDiaMes
			MkDir( xDiretorio )
			IF Conf("Proceder com a copia de Seguranca para " + xDrive + " ?")
				SetColor("")
				Cls
				FChDir( oAmbiente:xBase )
				xString := "COMPRIME -EX -RP" + cData + cDia + " *.DBF + *.CFG + *.DOC + *.TXT + *.PRO + *.LIS + *.BAT + *.LOG + *.ETI + *.NFF + *.COB + *.DUP + *.DIV"
				i		  := SWPRUNCMD( xString, 0, "", "" )
				FChDir( cOldDir )
			EndIF
		EndIF
		ResTela( cScreen )
	EndDo
	Return
#ELSE
	Proc Edicao
	Proc Dos
	Proc Comandos
	Proc MacroRestore
	Proc MacroBackup
#ENDIF

Proc CliInclusao( lAlteracao )
******************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL nKey		  := SetKey( F9 )
LOCAL lModificar := FALSO
LOCAL cPraca	  := XCCEP
LOCAL cCep		  := XCCEP
LOCAL aNatu 	  := {}
LOCAL aCfop 	  := {}
LOCAL aTxIcms	  := {}
LOCAL cSwap
LOCAL cCodi
LOCAL cString
LOCAL cNome
LOCAL cFanta
LOCAL cCgc
LOCAL cInsc
LOCAL cEnde
LOCAL cBair
LOCAL cCivil
LOCAL cCida
LOCAL cEsta
LOCAL cNatural
LOCAL cRg
LOCAL cCpf
LOCAL cEsposa
LOCAL cResp
LOCAL cEnde2
LOCAL cEnde3
LOCAL cPai
LOCAL cMae
LOCAL cEnde1
LOCAL cFone
LOCAL cFax
LOCAL cFone1
LOCAL cProf
LOCAL cCargo
LOCAL cTraba
LOCAL cFone2
LOCAL cTempo
LOCAL cRefCom
LOCAL cRefBco
LOCAL cImovel
LOCAL cVeiculo
LOCAL cConhecida
LOCAL cObs
LOCAL cObs1
LOCAL cObs2
LOCAL cObs3
LOCAL cObs4
LOCAL cObs5
LOCAL cObs6
LOCAL cObs7
LOCAL cObs8
LOCAL cObs9
LOCAL cObs10
LOCAL cObs11
LOCAL cObs12
LOCAL cObs13
LOCAL cRegiao
LOCAL dNasc
LOCAL dData
LOCAL nDepe
LOCAL nRenda
LOCAL nLimite
LOCAL nMedia
LOCAL cSpc
LOCAL dDataSpc
LOCAL cBanco
LOCAL cCancelada
LOCAL cSuporte
LOCAL cSci
LOCAL cAutorizaca
LOCAL cAssAutoriz
LOCAL cCidaAval
LOCAL cEstaAval
LOCAL cBairAval
LOCAL cFoneAval
LOCAL cFaxAval
LOCAL cRgAval
LOCAL cCpfAval
LOCAL cCFop
LOCAL nIcms
LOCAL cNatu
STATI lAtivaRegNew := FALSO

SetKey( F4, {|| AtivaRegNew( @lAtivaRegNew )})
IF lAlteracao != NIL .AND. lAlteracao
	lModificar := OK
	IF !PodeAlterar()
		SetKey( F4, NIL )
		ResTela( cScreen )
		Return
	EndIF
EndIF

IF !lModificar
	IF !PodeIncluir()
		SetKey( F4, NIL )
		Restela( cScreen )
		Return
	EndIF
EndIF
Set Key F9 To
Area("Receber")
Order( RECEBER_CODI )
WHILE OK
	oMenu:Limpa()
	cNome 		:= IF( lModificar, Receber->Nome,		  Receber->( Space( Len( Nome 	))))
	cFanta		:= IF( lModificar, Receber->Fanta,		  Receber->( Space( Len( Fanta	))))
	cCgc			:= IF( lModificar, Receber->Cgc, 		  Receber->( Space( Len( Cgc		))))
	cInsc 		:= IF( lModificar, Receber->Insc,		  Receber->( Space( Len( Insc 	))))
	cEnde 		:= IF( lModificar, Receber->Ende,		  Receber->( Space( Len( Ende 	))))
	cBair 		:= IF( lModificar, Receber->Bair,		  Receber->( Space( Len( Bair 	))))
	cCivil		:= IF( lModificar, Receber->Civil,		  Receber->( Space( Len( Civil	))))
	cCida 		:= IF( lModificar, Receber->Cida,		  Receber->( Space( Len( Cida 	))))
	cEsta 		:= IF( lModificar, Receber->Esta,		  Receber->( Space( Len( Esta 	))))
	cNatural 	:= IF( lModificar, Receber->Natural,	  Receber->( Space( Len( Natural ))))
	cRg			:= IF( lModificar, Receber->Rg,			  Receber->( Space( Len( Rg		))))
	cCpf			:= IF( lModificar, Receber->Cpf, 		  Receber->( Space( Len( Cpf		))))
	cEsposa		:= IF( lModificar, Receber->Esposa, 	  Receber->( Space( Len( Esposa	))))
	cEnde3		:= IF( lModificar, Receber->Ende3,		  Receber->( Space( Len( Ende3	))))
	cPai			:= IF( lModificar, Receber->Pai, 		  Receber->( Space( Len( Pai		  ))))
	cMae			:= IF( lModificar, Receber->Mae, 		  Receber->( Space( Len( Mae		  ))))
	cEnde1		:= IF( lModificar, Receber->Ende1,		  Receber->( Space( Len( Ende1	  ))))
	cFone 		:= IF( lModificar, Receber->Fone,		  Receber->( Space( Len( Fone 	  ))))
	cFax			:= IF( lModificar, Receber->Fax, 		  Receber->( Space( Len( Fax		  ))))
	cFone1		:= IF( lModificar, Receber->Fone1,		  Receber->( Space( Len( Fone1	  ))))
	cProf 		:= IF( lModificar, Receber->Profissao,   Receber->( Space( Len( Profissao ))))
	cCargo		:= IF( lModificar, Receber->Cargo,		  Receber->( Space( Len( Cargo	  ))))
	cTraba		:= IF( lModificar, Receber->Trabalho,	  Receber->( Space( Len( Trabalho  ))))
	cFone2		:= IF( lModificar, Receber->Fone,		  Receber->( Space( Len( Fone 	  ))))
	cTempo		:= IF( lModificar, Receber->Tempo,		  Receber->( Space( Len( Tempo	  ))))
	cRefCom		:= IF( lModificar, Receber->RefCom, 	  Receber->( Space( Len( RefCom	  ))))
	cRefBco		:= IF( lModificar, Receber->RefBco, 	  Receber->( Space( Len( RefBco	  ))))
	cImovel		:= IF( lModificar, Receber->Imovel, 	  Receber->( Space( Len( Imovel	  ))))
	cVeiculo 	:= IF( lModificar, Receber->Veiculo,	  Receber->( Space( Len( Veiculo   ))))
	cConhecida	:= IF( lModificar, Receber->Conhecida,   Receber->( Space( Len( Conhecida ))))
	cObs			:= IF( lModificar, Receber->Obs, 		  Receber->( Space( Len( Obs	))))
	cObs1 		:= IF( lModificar, Receber->Obs1,		  Receber->( Space( Len( Obs1 ))))
	cObs2 		:= IF( lModificar, Receber->Obs2,		  Receber->( Space( Len( Obs2 ))))
	cObs3 		:= IF( lModificar, Receber->Obs3,		  Receber->( Space( Len( Obs3 ))))
	cObs4 		:= IF( lModificar, Receber->Obs4,		  Receber->( Space( Len( Obs4 ))))
	cObs5 		:= IF( lModificar, Receber->Obs5,		  Receber->( Space( Len( Obs5 ))))
	cObs6 		:= IF( lModificar, Receber->Obs6,		  Receber->( Space( Len( Obs6 ))))
	cObs7 		:= IF( lModificar, Receber->Obs7,		  Receber->( Space( Len( Obs7 ))))
	cObs8 		:= IF( lModificar, Receber->Obs8,		  Receber->( Space( Len( Obs8 ))))
	cObs9 		:= IF( lModificar, Receber->Obs9,		  Receber->( Space( Len( Obs9 ))))
	cObs10		:= IF( lModificar, Receber->Obs10,		  Receber->( Space( Len( Obs10 ))))
	cObs11		:= IF( lModificar, Receber->Obs11,		  Receber->( Space( Len( Obs11 ))))
	cObs12		:= IF( lModificar, Receber->Obs12,		  Receber->( Space( Len( Obs12 ))))
	cObs13		:= IF( lModificar, Receber->Obs13,		  Receber->( Space( Len( Obs13 ))))
	cRegiao		:= IF( lModificar, Receber->Regiao, 	  Receber->( Space( Len( Regiao ))))
	cBanco		:= IF( lModificar, Receber->Banco,		  Receber->( Space( Len( Banco ))))
	dNasc 		:= IF( lModificar, Receber->Nasc,		  Ctod("//"))
	dData 		:= IF( lModificar, Receber->Data,		  Date())
	nDepe 		:= IF( lModificar, Receber->Depe,		  0 )
	nRenda		:= IF( lModificar, Receber->Media,		  0)
	nLimite		:= IF( lModificar, Receber->Limite, 	  0)
	nMedia		:= IF( lModificar, Receber->Media,		  0)
	cSpc			:= IF( lModificar, IF( Receber->Spc = OK, "S", "N"), "N")
	dDataSpc 	:= IF( lModificar, Receber->DataSpc,  Ctod("//"))
	cCancelada	:= IF( lModificar, IF( Receber->Cancelada = OK, "S", "N"), "N")
	cSuporte 	:= IF( lModificar, IF( Receber->Suporte	= OK, "S", "N"), "S")
	cSci			:= IF( lModificar, IF( Receber->Sci 		= OK, "S", "N"), "N")
	cFabricante := IF( lModificar, Receber->Fabricante,		Receber->( Space( Len( Fabricante ))))
	cProduto 	:= IF( lModificar, Receber->Produto,			Receber->( Space( Len( Produto	 ))))
	cModelo		:= IF( lModificar, Receber->Modelo, 			Receber->( Space( Len( Modelo 	 ))))
	cLocal		:= IF( lModificar, Receber->Local,				Receber->( Space( Len( Local		 ))))
	nValor		:= IF( lModificar, Receber->Valor,				0 )
	nPrazo		:= IF( lModificar, Receber->Prazo,				0 )
	nDataVcto	:= IF( lModificar, Receber->DataVcto,			0 )
	nPrazoExt	:= IF( lModificar, Receber->PrazoExt,			0 )
	cAutorizaca := IF( lModificar, IF( Receber->Autorizaca = OK, "S", "N"), "N")
	cAssAutoriz := IF( lModificar, IF( Receber->AssAutoriz = OK, "S", "N"), "N")
	cCidaAval	:= IF( lModificar, Receber->CidaAval,			Receber->( Space( Len( CidaAval	))))
	cEstaAval	:= IF( lModificar, Receber->EstaAval,			Receber->( Space( Len( EstaAval	))))
	cBairAval	:= IF( lModificar, Receber->BairAval,			Receber->( Space( Len( BairAval	))))
	cFoneAval	:= IF( lModificar, Receber->FoneAval,			Receber->( Space( Len( FoneAval	))))
	cFaxAval 	:= IF( lModificar, Receber->FaxAval,			Receber->( Space( Len( FaxAval	))))
	cRgAval		:= IF( lModificar, Receber->RgAval, 			Receber->( Space( Len( RgAval 	))))
	cCpfAval 	:= IF( lModificar, Receber->CpfAval,			Receber->( Space( Len( CpfAval	))))
	cCfop 		:= IF( lModificar, Receber->Cfop,				Receber->( Space( Len( Cfop		))))
	nIcms 		:= IF( lModificar, Receber->Tx_Icms,			0 )
	cNatu 		:= ''
	cCep			:= IF( lModificar, Receber->Cep, XCCEP)

	IF( !lModificar, Receber->(DbGoBottom()),)
	lSair 	:= FALSO
	IF lAtivaRegNew
		nNewCodi :=  Receber->(Val( Codi )+1)
		cCodi 	:= IF( lModificar, Receber->Codi, IF( nNewCodi > 99999, RetProximo(), StrZero( nNewCodi, 5)))
	Else
		IF( lModificar )
			cCodi := Receber->Codi
		Else
			Receber->(Order(NATURAL))
			Receber->(DbGobottom())
			cCodi := ProxCli( Receber->Codi )
		EndIF
	EndIF
	cString	:= IF( lModificar, "ALTERACAO DE CLIENTE", "INCLUSAO DE NOVOS CLIENTES")
	cSwap 	:= cCodi
	cPraca	:= XCCEP
	aNatu 	:= LerNatu()
	aCFop 	:= LerCfop()
	aTxIcms	:= LerIcms()
	WHILE OK
		MaBox( 00 , 00 , 24 , 79, cString )
		Write( 01,		 01, "Codigo.....:                                 Data........:")
		Write( Row()+1, 01, "Nome.......:                                              ")
		Write( Row()+1, 01, "Fantasia...:                                              ")
		Write( Row()+1, 01, "Cidade.....:                                 Estado......:")
		Write( Row()+1, 01, "Pca Pagto..:           Cfop:      Icms:      Regiao......:")
		Write( Row()+1, 01, "Endereco...:                                 Bairro......:")
		Write( Row()+1, 01, "Rg n�......:                                 Cpf.........:")
		Write( Row()+1, 01, "I. Est.....:                                 Cgc/Mf......:")
		Write( Row()+1, 01, "Telefone...:                                 Fax.........:")
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		Write( Row()+1, 01, "Natural....:                                 Nascimento..:")
		Write( Row()+1, 01, "Estado Civil:                                Dependentes.:")
		Write( Row()+1, 01, "Esposo(a)..:                                              ")
		Write( Row()+1, 01, "Profissao..:                                 Cargo.......:")
		Write( Row()+1, 01, "Trabalho...:                                 Fone........:")
		Write( Row()+1, 01, "Tempo......:                                 Renda Mes...:")
		Write( Row()+1, 01, "Pai........:                                              ")
		Write( Row()+1, 01, "Mae........:                                              ")
		Write( Row()+1, 01, "Endereco...:                                 Fone........:")
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		Write( Row()+1, 01, "Referencia.:                                         Spc.:   em")
		Write( Row()+1, 01, "Referencia.:")
		Write( Row()+1, 01, "Imoveis....:")
		nCol	:= 13
		nCol1 := 59
		nCol2 := 33
		nCol3 := 29
		nCol4 := 40
		@ 01, 	  nCol  Get cCodi 	 Pict PIC_RECEBER_CODI Valid RecCerto( @cCodi, lModificar, cSwap )
		@ Row(),   nCol1 Get dData 	 Pict "##/##/##"
		@ Row()+1, nCol  Get cNome 	 Pict "@!"
		@ Row()+1, nCol  Get cFanta	 Pict "@!"
		@ Row()+1, nCol  Get cCep		 Pict "#####-###" Valid CepErrado( @cCep, @cCida, @cEsta, @cBair )
		@ Row(),   23	  Get cCida 	 Pict "@!S21"
		@ Row(),   nCol1 Get cEsta 	 Pict "@!"
		@ Row()+1, nCol  Get cPraca	 Pict "#####-###" Valid CepErrado( @cPraca )
		@ Row(),   nCol3 Get cCFop 	 Pict "9.999" Valid PickTam2( @aNatu, @aCfop, @aTxIcms, @cCfop, @cNatu, @nIcms )
		@ Row(),   nCol4 Get nIcms 	 Pict "99.99"
		@ Row(),   nCol1 Get cRegiao	 Pict "99"   Valid RegiaoErrada( @cRegiao )
		@ Row()+1, nCol  Get cEnde 	 Pict "@!"
		@ Row()	, nCol1 Get cBair 	 Pict "@!S21"
		@ Row()+1, nCol  Get cRg		 Pict "@!"
		@ Row(),   nCol1 Get cCpf		 Pict "999.999.999-99"     Valid TestaCpf( cCpf )
		@ Row()+1, nCol  Get cInsc 	 Pict "@!"                 When Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cCgc		 Pict "99.999.999/9999-99" When Empty( Left( cCpf, 3 )) Valid TestaCgc( cCgc )
		@ Row()+1, nCol  Get cFone 	 Pict PIC_FONE
		@ Row(),   nCol1 Get cFax		 Pict PIC_FONE

		@ Row()+2, nCol  Get cNatural  Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get dNasc 	 Pict "##/##/##"       When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cCivil	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get nDepe 	 Pict "99"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cEsposa	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cProf 	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cCargo	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cTraba	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get cFone2	 Pict PIC_FONE 		  When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cTempo	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   nCol1 Get nRenda	 Pict "99999999.99"    When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cPai		 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cMae		 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row()+1, nCol  Get cEnde1	 Pict "@!"             When !Empty( Left( cCpf, 3 ))
		@ Row(),   58	  Get cFone1	 Pict PIC_FONE 		  When !Empty( Left( cCpf, 3 ))

		@ Row()+2, nCol  Get cRefCom	 Pict "@!"
		@ Row(),   60	  Get cSpc		 Pict "!" Valid cSpc $ "SN"
		@ Row(),   66	  Get dDataSpc  Pict "##/##/##" Valid IF( cSpc = "S", !Empty( dDataSpc ), OK ) .OR. LastKey() = UP
		@ Row()+1, nCol  Get cRefBco	 Pict "@!"
		@ Row()+1, nCol  Get cImovel	 Pict "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		nCol := 18
		MaBox( 00, 00 , 24 , 79, cString )
		@ 01		, 01 Say "Veiculos...:"     Get cVeiculo    Pict '@!'
		@ Row()+1, 01 Say "Avalista...:"     Get cConhecida  Pict "@!"
		@ Row()+1, 01 Say "Cidade.....:"     Get cCidaAval   Pict "@!S21"
		@ Row(),   45 Say "Estado.....:"     Get cEstaAval   Pict "@!"
		@ Row()+1, 01 Say "Endereco...:"     Get cEnde3      Pict "@!"
		@ Row(),   45 Say "Bairro.....:"     Get cBairAval   Pict "@!"
		@ Row()+1, 01 Say "Telefone...:"     Get cFoneAval   Pict PIC_FONE
		@ Row(),   45 Say "Fax........:"     Get cFaxAval    Pict PIC_FONE
		@ Row()+1, 01 Say "Rg n�......:"     Get cRgAval     Pict "@!"
		@ Row(),   45 Say "Cpf........:"     Get cCpfAval    Pict "999.999.999-99" Valid TestaCpf( cCpfAval )
		@ Row()+1, 01 Say "Limite Credito.:" Get nLimite     Pict "99999999.99"
		@ Row(),   45 Say "Bancos.....:"     Get cBanco      Pict "@!"
		@ Row()+1, 01 Say "Ficha Cancelada:" Get cCancelada  Pict "!" Valid PickSimNao( @cCancelada )
		@ Row(),   45 Say "Suporte....:"     Get cSuporte    Pict "!" Valid PickSimNao( @cSuporte )
		@ Row(),   60 Say "Cliente Sistema.:"Get cSci        Pict "!" Valid PickSimNao( @cSci )
		@ Row()+1, 01 Say "Autoriza Compra:" Get cAutorizaca Pict "!" Valid PickSimNao( @cAutorizaca )
		@ Row(),   45 Say "Assinou....:"     Get cAssAutoriz Pict "!" Valid PickSimNao( @cAssAutoriz )
		Write( Row()+1, 01, "------------------------------------------------------------------------------")
		@ Row()+1, 01 Say "Observacoes....:" Get cObs    Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs1   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs2   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs3   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs4   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs5   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs6   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs7   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs8   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs9   Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs10  Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs11  Pict "@!"
		@ Row()+1, 01 Say "...............:" Get cObs12  Pict "@!"
		#IFDEF MAXMOTORS
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		nCol := 18
		MaBox( 00, 00 , 24 , 79, cString )
		@ 01, 	  01 Say "Fabricante.....:" Get cFabricante Pict "@!"
		@ Row()+1, 01 Say "Produto........:" Get cProduto    Pict "@!"
		@ Row()+1, 01 Say "Modelo.........:" Get cModelo     Pict "@!"
		@ Row(),   50 Say "Valor..........:" Get nValor      Pict "999999999.99"
		@ Row()+1, 01 Say "Local Venda....:" Get cLocal      Pict "@!"
		@ Row(),   50 Say "N� Prestacoes..:" Get nPrazo      Pict "999"
		@ Row()+1, 01 Say "Data Vcto Pres.:" Get nDataVcto   Pict "99"
		@ Row(),   50 Say "Prazo Exten....." Get nPrazoExt   Pict "99"
		#ENDIF
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIF
		ErrorBeep()
		IF lModificar
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Alterar", " Cancelar ", "Sair "})
		Else
			nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir", " Alterar ", "Sair "})
		EndIF
		IF nOpcao = 1	// Incluir
			IF lModificar
				IF !Receber->(TravaReg()) ; Loop ; EndIF
			Else
				IF !RecCerto( @cCodi, lModificar ) ; Loop ; EndIF
				IF !Receber->(Incluiu())			  ; Loop ; EndIF
			EndIF
			Receber->Codi		 := cCodi
			Receber->Data		 := dData
			Receber->Nome		 := cNome
			Receber->Fanta 	 := cFanta
			Receber->Cep		 := cCep
			Receber->Praca 	 := cPraca
			Receber->Ende		 := cEnde
			Receber->Cida		 := cCida
			Receber->Bair		 := cBair
			Receber->Esta		 := cEsta
			Receber->Rg 		 := cRg
			Receber->Cpf		 := cCpf
			Receber->Insc		 := cInsc
			Receber->Cgc		 := cCgc
			Receber->Media 	 := nRenda
			Receber->RefCom	 := cRefCom
			Receber->RefBco	 := cRefBco
			Receber->Imovel	 := cImovel
			Receber->Civil 	 := cCivil
			Receber->Natural	 := cNatural
			Receber->Nasc		 := dNasc
			Receber->Esposa	 := cEsposa
			Receber->Depe		 := nDepe
			Receber->Pai		 := cPai
			Receber->Mae		 := cMae
			Receber->Ende1 	 := cEnde1
			Receber->Fax		 := cFax
			Receber->Fone		 := cFone
			Receber->Fone1 	 := cFone1
			Receber->Profissao := cProf
			Receber->Cargo 	 := cCargo
			Receber->Trabalho  := cTraba
			Receber->Fone2 	 := cFone2
			Receber->Tempo 	 := cTempo
			Receber->Veiculo	 := cVeiculo
			Receber->Conhecida := cConhecida
			Receber->Ende3 	 := cEnde3
			Receber->Spc		 := IF( cSpc		 = "S", OK, FALSO )
			Receber->DataSpc	 := dDataSpc
			Receber->Cancelada := IF( cCancelada = "S", OK, FALSO )
			Receber->Suporte	 := IF( cSuporte	 = "S", OK, FALSO )
			Receber->Sci		 := IF( cSci		 = "S", OK, FALSO )
			Receber->Obs		 := cObs
			Receber->Obs1		 := cObs1
			Receber->Obs2		 := cObs2
			Receber->Obs3		 := cObs3
			Receber->Obs4		 := cObs4
			Receber->Obs5		 := cObs5
			Receber->Obs6		 := cObs6
			Receber->Obs7		 := cObs7
			Receber->Obs8		 := cObs8
			Receber->Obs9		 := cObs9
			Receber->Obs10 	 := cObs10
			Receber->Obs11 	 := cObs11
			Receber->Obs12 	 := cObs12
			Receber->Obs13 	 := cObs13
			Receber->Limite	 := nLimite
			Receber->Regiao	 := cRegiao
			Receber->Banco 	 := cBanco
			Receber->Fabricante := cFabricante
			Receber->Produto	  := cProduto
			Receber->Modelo	  := cModelo
			Receber->Local 	  := cLocal
			Receber->Valor 	  := nValor
			Receber->Prazo 	  := nPrazo
			Receber->DataVcto   := nDataVcto
			Receber->PrazoExt   := nPrazoExt
			Receber->Autorizaca := IF( cAutorizaca = "S", OK, FALSO )
			Receber->AssAutoriz := IF( cAssAutoriz = "S", OK, FALSO )
			Receber->CidaAval   := cCidaAval
			Receber->EstaAval   := cEstaAval
			Receber->BairAval   := cBairAval
			Receber->FoneAval   := cFoneAval
			Receber->FaxAval	  := cFaxAval
			Receber->RgAval	  := cRgAval
			Receber->CpfAval	  := cCpfAval
			Receber->Cfop		  := cCfop
			Receber->Tx_Icms	  := nIcms
			Receber->(Libera())
			IF lModificar
				lSair := OK
			EndIF
			Exit

		ElseIf nOpcao = 2 // Alterar
			Loop
		ElseIf nOpcao = 3 // Sair
			lSair := OK
			Exit
		EndIF
	EndDo
	IF lSair
		SetKey( F4, NIL )
		ResTela( cScreen )
		Exit
	EndIF
EndDo

Function RetProximo()
*********************
LOCAL cScreen := SaveScreen()
LOCAL cTela   := Mensagem("Aguarde, Localizando Proximo Registro Vago.")
LOCAL nX

For nX := 1 To 10000
	 cCodi := StrZero( nX, 4 )
	 IF Receber->(DbSeek( cCodi ))
		 Loop
	 EndIF
	 Return( cCodi )
Next
Return( cCodi )

Proc AtivaRegNew( lAtivaRegNew )
********************************
IF lAtivaRegNew
	lAtivaRegNew := FALSO
	Alert("Busca Proximo Registro DESATIVADA.")
	Return
EndIF
lAtivaRegNew := OK
Alert("Busca Proximo Registro ATIVADA.")
Return

Proc Tbdemo( Dbf, Index )
*************************
LOCAL cScreen	:= SaveScreen()
LOCAL Files 	:= oAmbiente:xBaseDados + '\*.DBF'
LOCAL cArquivo
LOCAL oBrowse

WHILE .T.
	FChdir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	oMenu:Limpa()
	M_Title( "Setas CIMA/BAIXO Move")
	cArquivo := Mx_PopFile( 02, 10, 23, 57, Files, Cor())
	IF Empty( cArquivo )
		Beep(1)
		ResTela( cScreen )
		Exit
	EndIF
	xArquivo := cArquivo
	cArquivo := StrTran( cArquivo, '.DBF', '')
	cArquivo := StrTran( cArquivo, oAmbiente:xBaseDados + '\', '')
	IF !UsaArquivo( cArquivo )
		MensFecha()
		Loop
	EndIF
	oBrowse	:= MsBrowse():New()
	nLen		:= FCount()
	For i := 1 To nLen
		oColuna := TBColumnNew( field( i ), FieldWBlock( field( i ), select() ) )
		oBrowse:InsColumn( oBrowse:ColPos, oColuna )
	Next
	oBrowse:Titulo   := "CONSULTA/ALTERACAO/EXCLUSAO"
	oBrowse:PreDoGet := NIL
	oBrowse:PosDoGet := NIL
	oBrowse:Show()
	oBrowse:Processa()
EndDo
ResTela( cScreen )
Mensagem("Aguarde...", Cor())
FechaTudo()
Return

Func VerDataDos()
*****************
LOCAL cLimite
LOCAL cDataDos

CenturyOn()
cLimite	:= oAmbiente:xDataCodigo
cDataDos := Dtoc( Date())
IF Ctod( cDataDos ) > Ctod( cLimite )
	Hard( 1, ProcName(), ProcLine() )
	SetColor("")
	Cls
	Quit
EndIF
CenturyOff()
Return

Proc Info(nRow, lInkey)
***********************
LOCAL cScreen	  := SaveScreen( )
LOCAL Drive 	  := Curdrive()
LOCAL cDiretorio := FCurdir()
LOCAL nMaxRow	  := MaxRow()
LOCAL nMaxCol	  := MaxCol()-3
LOCAL cSistema   := StrTran( SISTEM_NA1 + SISTEM_VERSAO, "MENU PRINCIPAL-","")
LOCAL nRamLivre  := Memory(0)
LOCAL nColor
LOCAL Handle
LOCAL xMicrobras
LOCAL xEndereco
LOCAL xTelefone
LOCAL xCidade

IfNil(nRow, 2)
FChDir( oAmbiente:xBase )
Handle := Fopen("SCI.CFG")
IF ( Ferror() != 0 )
	FClose( Handle )
	SetColor("")
	Cls
	Alert( "Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
	ResTela( cScreen )
	Return
EndIF
nErro := MsLocate( Handle, "[ENDERECO_STRING]")
IF nErro < 0
	FClose( Handle )
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG alterada. [ENDERECO_STRING]")
	ResTela( cScreen )
	Return
EndIF
MsAdvance( Handle )
xMicrobras := AllTrim( MsReadLine( Handle ))
xEndereco  := AllTrim( MsReadLine( Handle ))
xTelefone  := AllTrim( MsReadLine( Handle ))
xCidade	  := AllTrim( MsReadLine( Handle ))
FClose( Handle )
CenturyOn()

nRow := (nMaxRow-20)/2

IF oAmbiente:Visual
	SetColor("N/W")
	Cls
	DeskBox( nRow-01, 01, 24, MaxCol()-1, 2 )
	DeskBox( nRow, 	02, 23, MaxCol()-2, 1 )
	SetColor("B/W")
	Print( nRow+01, 03, Padc( cSistema, MaxCol()-7 ))
	SetColor("G/W")
	Print( nRow+02, 03, Padc( xMicrobras, MaxCol()-7 ) )
	SetColor("GR+/W")
	Print( nRow+03, 03, Padc( xEndereco + " - " + xTelefone, MaxCol()-7 ))
	SetColor("R/W")
	Print( nRow+04, 03, Padc( xCidade, MaxCol()-7 ))
Else
	MaBox( nRow,	 02, nRow+20, (nMaxCol+1))
	Print( nRow+01, 03, Padc( cSistema, nMaxCol-2))
	Print( nRow+02, 03, Padc( xMicrobras, nMaxCol-2 ) )
	Print( nRow+03, 03, Padc( xEndereco, nMaxCol-2 ) )
	Print( nRow+40, 03, Padc( xTelefone, nMaxCol-2 ) )
EndIF
Print( nRow+06, 03, "S. Operacional : " + AllTrim(Os()))
Print( nRow+07, 03, "  Data Sistema : " + AllTrim(Dtoc(Date())))
Print( nRow+08, 03, "Drive Corrente : " + AllTrim(Drive ))
Print( nRow+09, 03, "  Espa�o Total : " + AllTrim( Tran( DiskSize( Drive ), "9,999,999,999")))
Print( nRow+10, 03, "   Mem�ria RAM : " + AllTrim(Str( DosMem()) + " Kb"))
Print( nRow+11, 03, " Mem�ria V�deo : " + AllTrim(Str( EgaMem()) + " Kb"))
Print( nRow+12, 03, "   Mem�ria Ext : " + AllTrim(Str( ExtMem()) + " Kb"))
Print( nRow+13, 03, "  Arqs Abertos : " + AllTrim(Str(NextHandle()-6,3)))
Print( nRow+14, 03, "      Ano 2000 : " + IF( oAmbiente:Ano2000, "Habilitado", "Desabilitado"))
Print( nRow+15, 03, "    Base Dados : " + IF( oProtege:Protegido,"Protegida","DesProtegida"))
Print( nRow+16, 03, " Print Spooler : " + IF( IsQueue(), "Sim","Nao"))

Print( nRow+06, ((nMaxCol/2)-2), "   Nome Esta��o : " + AllTrim(Left(NetName(),20)))
Print( nRow+07, ((nMaxCol/2)-2), "  Horas Sistema : " + AllTrim(Time()))
Print( nRow+08, ((nMaxCol/2)-2), "      Diret�rio : " + AllTrim(FCurdir()))
Print( nRow+09, ((nMaxCol/2)-2), "   Espa�o Livre : " + AllTrim(Tran( DiskSpace( Drive ), "9,999,999,999")))
Print( nRow+10, ((nMaxCol/2)-2), "  Mem RAM Livre : " + AllTrim(Str(nRamLivre) + " Kb"))
IF nRamLivre < 100 // Pouca memoria
	Print( nRow+10, ((nMaxCol/2)-2), "  Mem RAM Livre : " + AllTrim(Str(nRamLivre) + " Kb"), Roloc(Cor()))
EndIF
Print( nRow+11, ((nMaxCol/2)-2), "    Mem�ria Exp : " + AllTrim(StrTran(Str(ExpMem()),"-","") + " Kb"))
Print( nRow+12, ((nMaxCol/2)-2), "  Path Corrente : " + AllTrim( oAmbiente:xBase ))
Print( nRow+13, ((nMaxCol/2)-2), "  Limite Acesso : " + oAmbiente:xDataCodigo )
Print( nRow+14, ((nMaxCol/2)-2), "   MultiUsuario : " + IF( MULTI, "Habilitado", "Desabilitado"))
Print( nRow+15, ((nMaxCol/2)-2), "     Portas LPT : " + IF( IsLpt(1), "#1 ","") + IF( IsLpt(2), "#2 ","") + IF( IsLpt(3), "#3 ","") + IF( IsLpt(4), "#4",""))
Print( nRow+16, ((nMaxCol/2)-2), "       Data ROM : " + RomDate())


IF oAmbiente:Visual
  Print( nRow+18, 03, Padc( "Software Li�enciado para", nMaxCol-7 ))
  Print( nRow+19, 03, Padc( XNOMEFIR, nMaxCol-7 ))
Else
  Print( nRow+18, 03, Padc( "Software Li�enciado para" , nMaxCol-2 ) )
  Print( nRow+19, 03, Padc( XNOMEFIR, nMaxCol-2 ) )
EndIF
CenturyOff()
IF lInkey = NIL
	WaitKey( 0 )
	ResTela( cScreen )
EndIF
UnClock12()
FChDir( cDiretorio )
Return

Proc ProBranco( cCodi_Cli, aReg )
*********************************
LOCAL GetList		 := {}
LOCAL cScreen		 := SaveScreen()
LOCAL nMoeda		 := 1
LOCAL _QtDup		 := 0
LOCAL nTamForm 	 := oIni:ReadInteger('relatorios','tampromissoria', 33 )
LOCAL cNomeEmpresa := oIni:ReadString('sistema','nomeempresa', AllTrim(oAmbiente:xNomefir) )
LOCAL cFantasia	 := oIni:ReadString('sistema','fantasia', XFANTA )
LOCAL cCgcEmpresa  := oIni:ReadString('sistema','cgcempresa', XCGCFIR )
LOCAL cNomeSocio	 := oIni:ReadString('sistema','nomesocio', XNOMESOCIO )
LOCAL cCpfSocio	 := oIni:ReadString('sistema','cpfsocio', XCPFSOCIO )
LOCAL cStr1
LOCAL cStr2

#IFDEF GRUPO_MICROBRAS
	cStr1 := cNomeSocio
	cStr2 := cCpfSocio
#ELSE
	cStr1 := cNomeEmpresa
	cStr2 := cCgcEmpresa
#ENDIF

WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF !Instru80()
		Return
	EndIF
	Mensagem("Aguarde, Imprimindo Promissorias. ESC Cancela.", WARNING )
	PrintOn()
	Fprint( RESETA )
	FPrInt( Chr(ESC) + "C" + Chr(nTamForm))
	SetPrc( 0, 0 )
	nConta := 0
	Col	 := 0
	Receber->(Order( RECEBER_CODI ))
	Recemov->(Order( RECEMOV_CODI ))
	Area("Recemov")
	Set Rela To Recemov->Codi Into Receber
	Recemov->(Order( RECEMOV_CODI ))
	FOR i :=  1 TO _qtdup
		DbGoto( aReg[i] )
		IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
			Var1 := Receber->Cpf
			Var2 := Receber->Rg
		Else
			Var1 := Receber->Cgc
			Var2 := Receber->Insc
		EndIF
		Larg	  := 125-36
		nLinhas := 2
		cMes	  := Mes( Date())
		cDia	  := Left( Dtoc( Date()),2)
		cAno	  := Right( Dtoc( Date()),1)
		Vlr_Dup := Extenso( Recemov->Vlr, nMoeda, nLinhas, Larg )
		Write( Col,   00, Repl("=",80))
		Write( Col+1, 00, "N� " + PQ + Recemov->Docnr + C18 )
		Write( Col+1, 62, PQ + "Vencimento: " + Dtoc( Recemov->Vcto ) + C18 )
		Write( Col+2, 62, PQ + "Valor R$  : " + AllTrim( Tran( Recemov->Vlr, "@E 9,999,999,999.99")) + C18)
		Write( Col+3, 00, "Ao " + PQ + DataExtenso( Recemov->Vcto ) + "." + C18 )
		Write( Col+4, 00, "pagarei por unica via de " + GD + "NOTA PROMISSORIA")
		Write( Col+6, 00, "a " + PQ + cStr1 + C18)
		Write( Col+6, 70, "Cgc/Cpf " + PQ + cStr2 + C18 )
		Write( Col+8, 00, "ou a sua ordem a quantia de " + PQ + Left( Vlr_Dup, Larg) + C18 )
		Write( Col+9, 00, PQ + Right( Vlr_Dup, Larg-4) + C18 + " em moeda corrente deste pais.")
		Write( Col+11, 00, "Pagavel em: " + PQ + XCCIDA + C18 )
		Write( Col+12, 00, "Emitente  : " + PQ + Receber->Nome + " " + Receber->Codi + Space(14) + XCCIDA + ", " + DataExt1( Date()) + C18 )
		Write( Col+13, 00, "Cpf/Cgc   : " + PQ + Var1 + C18 )
		Write( Col+14, 00, "Endereco  : " + PQ + Receber->Ende + " - " + Receber->(AllTrim( Cida ) + " " + Esta ) + C18 )
		Write( Col+14, 47, PQ + Repl("_",50) + C18 )
		Write( Col+16, 00, "Avalista  : " + PQ + Repl("_",50) + C18 )
		Write( Col+17, 00, PQ + Space( 20 ) + "Cpf/Cgc :" + C18 )
		Write( Col+18, 00, Repl("=",80))
		nConta++
		__Eject()
		nConta := 0
		Col	 := 0
	Next
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	IF PCount() != 0
		ResTela( cScreen )
		Return
	EndIF
EndDo
ResTela( cScreen )
Return

Proc DupPersonalizado( cCodi_Cli, aReg )
****************************************
LOCAL GetList			:= {}
LOCAL cScreen			:= SaveScreen()
LOCAL nMoeda			:= 1
LOCAL aMenu 			:= { "Imprimir, Usando um Arquivo Existente", "Criar Arquivo de Configuracao ", "Alterar Arquivos de Duplicata", "Configurar arquivos padrao"}
LOCAL aNt				:= {}
LOCAL nChoice			:= 0
LOCAL lRetornoBeleza := FALSO
LOCAL nLen				:= 0
LOCAL _QtDup			:= 0
LOCAL nX 				:= 0
LOCAL cVar1 			:= ""
LOCAL cVar2 			:= ""
LOCAL cCepPagto		:= ""
LOCAL cCidaPagto		:= ""
LOCAL cEstaPagto		:= ""
LOCAL nLargura 		:= 0
LOCAL cExtenso 		:= ""
LOCAL aDados			:= {}
LOCAL aMoeda			:= {"R$ ", "U$ ", "URV " }
LOCAL cMoeda			:= aMoeda[1]
LOCAL nPag				:= 0
LOCAL lImprimir		:= FALSO
LOCAL i					:= 0
LOCAL Larg				:= 0
LOCAL Vlr_Dup			:= 0
LOCAL nA 				:= 0
LOCAL cMora 			:= ""
LOCAL xDuplicata		:= oIni:ReadString('impressao', 'dup', NIL )
LOCAL aDuplicata


WHILE OK
	IF PCount() = 0
		cCodi_Cli := Space(05)
		aReg		 := {}
		aReg		 := EscolheTitulo( cCodi_Cli )
	EndIF
	IF ( _QtDup := Len( aReg )) = 0
		ResTela( cScreen )
		Return
	EndIF
	IF xDuplicata = NIL
		ErrorBeep()
		WHILE OK
			lImprimir := FALSO
			oMenu:Limpa()
			M_Title("IMPRESSAO DE DUPLICATAS")
			nChoice := FazMenu( 10, 10, aMenu, Cor())
			Do Case
			Case nChoice = 0
				Exit
			Case nChoice = 1
				ErrorBeep()
				aDuplicata := LerDuplicata(, @lRetornoBeleza )
				IF !lRetornoBeleza
					Loop
				EndIF
				lImprimir := OK
				Exit
			Case nChoice = 2
				GravaDuplicata()
				Loop
			Case nChoice = 3
				Edicao( OK, "*.DUP" )
				Loop
			Case nChoice = 4
				ConfImpressao()
			EndCase
			lImprimir := OK
			Exit
		EndDo
		IF !lImprimir
			aReg := {}
			Loop
		EndIF
	Else
		aDuplicata := LerDuplicata( xDuplicata, @lRetornoBeleza )
		IF !lRetornoBeleza
			xDuplicata := NIL
			Loop
		EndIF
		lImprimir := OK
	EndIF
	IF !InsTru80() .OR. !Rep_Ok()
		ResTela( cScreen )
		Exit
	EndIF
	cMoeda := aMoeda[IF( nMoeda = 0, 1, nMoeda )]
	Mensagem("Aguarde Imprimindo Duplicatas. ESC Cancela.", WARNING )
	PrintOn()
	#IFDEF CENTRALCALCADOS
		PrintOn()
		Fprint( _CPI12 )
		Fprint( _SPACO1_6 )
		FPrint("C$")
		SetPrc( 0, 0 )
	#ELSE
		FPrint( RESETA )
		anT						:= aDuplicata
		XIMPRIMIRCONDENSADO	:= 01
		XIMPRIMIR12CPI 		:= 02
		XIMPRIMIRNEGRITO		:= 03
		XESPACAMENTOVERTICAL := 04
		nPag						:= 05 			 // Tamanho Pagina
		XTAMANHOEXTENSO		:= 31
		IF aNt[XIMPRIMIRCONDENSADO,1]  > 0 ; FPrint( PQ )			; EndIF
		IF aNt[XIMPRIMIR12CPI,1]		 > 0 ; FPrint( _CPI12 ) 	; EndIF
		IF aNt[XIMPRIMIRNEGRITO,1] 	 > 0 ; FPrint( NG )			; EndIF
		IF aNt[XESPACAMENTOVERTICAL,1] = 0 ; FPrint( _SPACO1_6 ) ; EndIF
		IF aNt[XESPACAMENTOVERTICAL,1] = 1 ; FPrint( _SPACO1_8 ) ; EndIF
		FPrInt( Chr( 27 ) + "C" + Chr( anT[nPag,01]))
		SetPrc( 0,0 )
	#ENDIF
	Cep->(Order( CEP_CEP ))
	FOR i :=  1 TO _qtdup
		Recemov->(DbGoto( aReg[i] ))
		IF Receber->Cgc = "  .   .   /    -  " .OR. Receber->Cgc = Space( 18 )
			cVar1 := Receber->Cpf
			cVar2 := Receber->Rg
		Else
			cVar1 := Receber->Cgc
			cVar2 := Receber->Insc
		EndIf
		#IFDEF CENTRALCALCADOS
			SubDuplicata( cVar1, cVar2, nMoeda )
			__Eject()
		#ELSE
			cCepPagto  := Receber->Praca
			cCidaPagto := Receber->Cida
			cEstaPagto := Receber->Esta
			IF Cep->(DbSeek( cCepPagto ))
				cCidaPagto := Cep->Cida
				cEstaPagto := Cep->Esta
			EndIF
			Larg	  := IF( anT[XTAMANHOEXTENSO,01] >= 0, anT[XTAMANHOEXTENSO,01], 56 ) 		 // Largura da Duplicata
			Vlr_Dup := Extenso( Recemov->Vlr, nMoeda, 2, Larg )	  // Valor Por Extenso
			cMora   := cMoeda + AllTrim( Tran( Recemov->Jurodia,"@E 999,999.99"))
			aDados  := {}
			Aadd( aDados, AllTrim(oAmbiente:xNomefir) )
			Aadd( aDados, XENDEFIR )
			Aadd( aDados, XCGCFIR )
			Aadd( aDados, XINSCFIR )
			Aadd( aDados, Recemov->Emis )
			Aadd( aDados, Tran( Recemov->VlrFatu,"@E 999,999,999.99" ))
			Aadd( aDados, Recemov->Fatura )
			Aadd( aDados, Tran( Recemov->Vlr,"@E 999,999,999.99" ))
			Aadd( aDados, Recemov->Docnr )
			Aadd( aDados, Recemov->Vcto )
			Aadd( aDados, cMora )
			Aadd( aDados, Recemov->CodiVen )
			Aadd( aDados, Receber->Nome )
			Aadd( aDados, Receber->Codi )
			Aadd( aDados, Receber->Ende )
			Aadd( aDados, Receber->Bair )
			Aadd( aDados, Receber->Cida )
			Aadd( aDados, Receber->Cep )
			Aadd( aDados, Receber->Esta )
			Aadd( aDados, cCidaPagto )
			Aadd( aDados, Receber->Praca )
			Aadd( aDados, cEstaPagto )
			Aadd( aDados, cVar1 )
			Aadd( aDados, cVar2 )
			Aadd( aDados, Left( Vlr_Dup, Larg ))
			Aadd( aDados, Right( Vlr_Dup, Larg ))
			Aadd( aDados, Receber->Banco )
			nLen := (Len( anT )-2)
			For nA := 6 To nLen
				IF nA = 30 // Valor Por Extenso
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01],   anT[nA, 02], aDados[nA-5] ),)
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01]+1, anT[nA, 02], aDados[nA-4] ),)
				Else
					IF( anT[nA, 01] >= 0, Write( anT[nA, 01], anT[nA, 02], aDados[nA-5] ),)
				EndIF
			Next
			IF( anT[32, 01] >= 0, Write( anT[32, 01], anT[32, 02], aDados[27]),)
			__Eject()
		#ENDIF
	Next
	PrintOff()
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	IF PCount() != 0
		ResTela( cScreen )
		Return
	EndIF
EndDo

Proc SubDuplicata( cVar1, cVar2, nMoeda )
*****************************************
LOCAL nLargura  := 53
LOCAL nVlr_Dup  := Extenso( Recemov->Vlr, nMoeda, 3, nLargura )
LOCAL cDia		 := StrZero( Day( Recemov->Emis ), 2 )
LOCAL cMes		 := Mes( Recemov->Emis )
LOCAL cAno		 := StrZero( Year( Recemov->Emis ),4)

Write( 01, 96 , Recemov->Vcto )
Write( 03, 50 , cDia )
Write( 03, 56 , cMes )
Write( 03, 75 , Right( cAno, 1 ))
Write( 03, 85 , Left( Receber->Nome, 18))
Write( 04, 81 , Right( Receber->Nome, 22))
Write( 06, 85 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 07, 00 , Tran( Recemov->VlrFatu,"@E 999,999,999.99" ))
Write( 07, 19 , Recemov->Fatura )
Write( 07, 32 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 07, 52 , Recemov->Docnr )
Write( 07, 65 , Recemov->Vcto )
Write( 10, 27 , AllTrim( Tran( Recemov->Vcto - Recemov->Emis, "999")) + " DIAS * " + Recemov->Fatura )
Write( 11, 81 , Recemov->Docnr )
Write( 13, 23 , Receber->Nome + Space(07) + Receber->Codi )
Write( 14, 23 , Receber->Ende + Space(12) + Right( Receber->Fone, 8))
Write( 15, 23 , Receber->Cep + "/" + Receber->Cida + Space(11) + Receber->Esta )
Write( 16, 23 , Receber->Cep + "/" + Receber->Cida + Space(11) + Receber->Esta )
Write( 17, 23 , cVar1 )
Write( 17, 57 , cVar2 )
Write( 18, 96 , Recemov->Vcto )
Write( 19, 23 , Left( nVlr_Dup, nLargura ))
Write( 20, 23 , SubStr( nVlr_Dup, nLargura + 1, nLargura ))
Write( 20, 85 , Left( Receber->Nome, 18))
Write( 21, 23 , Right(	nVlr_Dup, nLargura ))
Write( 21, 81 , Right( Receber->Nome, 22))
Write( 23, 85 , Tran( Recemov->Vlr,"@E 9,999,999,999.99" ))
Write( 26, 11 , "TRAB: " + Receber->Trabalho + " CARGO: " + Receber->Cargo )
Write( 28, 81 , Recemov->Docnr )
Return

Function ProxCodigo( cCodigo )
******************************
Return( StrZero( Val( cCodigo ) + 1, 6 ))

Function PedePermissao( nNivel, cAutorizado )
*********************************************
LOCAL GetList	:= {}
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL cNome 	:= Space(10)
LOCAL cRetorno := FALSO
LOCAL cSenha
LOCAL Passe
LOCAL cPara 	:= ""
LOCAL aPara    := {{11,  "EXCLUIR REGISTROS           "},;
                   {12,  "FAZER DEVOLUCAO DE FATURA   "},;
                   {13,  "FAZER PAGAMENTOS            "},;
                   {14,  "FAZER RECEBIMENTOS          "},;
                   {40,  "FAZER RECIBO VLR ZERADO OU A MENOR "},;
                   {20,  "FATURA COM ESTOQUE NEGATIVO OU ZERADO"},;
                   {21,  "VENDER COM LIMITE ESTOURADO "},;
                   {25,  "EXCEDER DESCONTO MAXIMO     "},;
                   {26,  "FAZER DEVOLUCAO DE ENTRADAS "},;
                   {27,  "ALTERAR EMISSAO DA FATURA   "},;
                   {28,  "ALTERAR DATA RECEBIMENTO    "},;
                   {30,  "ALTERAR DATA DO FATURAMENTO "},;
                   {31,  "ALTERAR DATA DE RECEBIMENTO "},;
                   {120, "VERIFICAR PRECO DE CUSTO    "},;
                   {200, "USAR TECLAS CTRL+P          "},;
                   {300, "VISUALIZAR DETALHE DE CAIXA "},;
                   {400, "VENDER COM DEBITO EM ATRASO "},;
                   {500, "IMPRIMIR RELATORIO DE COBRANCA"}}
IF !AbreUsuario()
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
oMenu:Limpa()
Area("Usuario")
Usuario->(Order( USUARIO_NOME ))
cNome := Space(10)
WHILE OK
	nPos := Ascan2( aPara, nNivel, 1 )
	IF nPos != 0
		cPara := aPara[nPos,2 ]
	EndIF
   MaBox( 10, 15, 14, 70, "SOLICITACAO DE PERMISSAO" )
	@ 11, 16 Say "Para....:   " + cPara
	@ 12, 16 Say "Usuario.:  " Get cNome Pict "@!" Valid UsuarioErrado( @cNome )
	@ 13, 16 Say "Senha...: "
	Read
	IF LastKey() = ESC
		Usuario->(DbCloseArea())
		AreaAnt( Arq_Ant, Ind_Ant )
		Restela( cScreen )
		Return( FALSO )
	EndIF
	cSenha := Usuario->( AllTrim( Senha ))
	Passe  := Senha( 13, 28, 11 )
	Passe  := Criptar( AllTrim( Passe ))
	IF LastKey() = ESC
		Usuario->(DbCloseArea())
		AreaAnt( Arq_Ant, Ind_Ant )
		Restela( cScreen )
		Return( FALSO )
	EndIF
	cRetorno := FALSO
	IF !Empty( Passe) .AND. cSenha == Passe
       IF     nNivel = SCI_EXCLUSAO_DE_REGISTROS
          cRetorno := IF( Usuario->(DCriptar( NivelA)) = "S", OK, FALSO )
          IF !cRetorno
             cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','PodeExcluirRegistros', FALSO )
          EndIF
       ElseIF nNivel = SCI_DEVOLUCAO_FATURA  // Devolucao de Fatura
			 cRetorno := IF( Usuario->(DCriptar( NivelB)) = "S", OK, FALSO )
		 ElseIf nNivel = SCI_ALTERAR_DATA_FATURA
			 cRetorno := IF( Usuario->(DCriptar( NivelB)) = "S", OK, FALSO )
		 ElseIf nNivel = SCI_PAGAMENTOS		  // Pagamentos
			 cRetorno := IF( Usuario->(DCriptar( NivelC)) = "S", OK, FALSO )
		 ElseIf nNivel = SCI_RECEBIMENTOS	  // Recebimentos
			 cRetorno := IF( Usuario->(DCriptar( NivelD)) = "S", OK, FALSO )
		 ElseIf nNivel = SCI_VENDER_COM_LIMITE_ESTOURADO  // Pode Faturar para cliente com limite estourado ?
			 cRetorno := IF( Usuario->(DCriptar( NivelK)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_DEVOLUCAO_ENTRADAS // Devolucao de Entrdas
			 cRetorno := IF( Usuario->(DCriptar( NivelP)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_PODE_EXCEDER_DESCONTO_MAXIMO
			 cRetorno := IF( Usuario->(DCriptar( NivelO)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_FATURAR_COM_ESTOQUE_NEGATIVO
			 cRetorno := IF( Usuario->(DCriptar( NivelJ)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_ALTERAR_DATA_FATURA
			 cRetorno := IF( Usuario->(DCriptar( NivelQ)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_ALTERAR_DATA_BAIXA
			 cRetorno := IF( Usuario->(DCriptar( NivelR)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_VERIFICAR_PCUSTO // Verificar Preco Custo
			 cRetorno := IF( Usuario->(DCriptar( NivelB)) = "S", OK, FALSO )
		 ElseIF nNivel = SCI_USARTECLACTRLP
          cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','usarteclactrlp', FALSO )
		 ElseIF nNivel = SCI_VISUALIZAR_DETALHE_CAIXA
          cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','visualizardetalhecaixa', FALSO )
		 ElseIF nNivel = SCI_VENDERCOMDEBITOEMATRASO
          cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','vendercomdebito', FALSO )
		 ElseIF nNivel = SCI_IMPRIMIRROLCOBRANCA
          cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','imprimirrolcobranca', FALSO )
		 ElseIF nNivel = SCI_PODE_RECIBO_ZERADO
          cRetorno := TIniNew( oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','recibozerado', FALSO )
		 EndIF
		 Usuario->(DbCloseArea())

       IF !cRetorno
          cRetorno := TIniNew(oAmbiente:xBaseDados + "\" + cNome + ".INI"):ReadBool('permissao','usuarioadmin',FALSO)
       EndIF

		 IF !cRetorno
			 AreaAnt( Arq_Ant, Ind_Ant )
			 ErrorBeep()
          Alert("ERRO: Solicite autorizacao para a tarefa.")
			 ResTela( cScreen )
			 Return( FALSO )
		 EndIF
		 IF cAutorizado != NIL
			 cAutorizado := cNome
		 EndIF
		 AreaAnt( Arq_Ant, Ind_Ant )
		 ResTela( cScreen )
		 Return( cRetorno )
	 Else
		ErrorBeep()
      Alert("ERRO: Senha nao confere.")
		Loop
	 EndIF
EndDo

Function NetUse( cBcoDados, lModo, nSegundos, cAlias )
******************************************************
LOCAL cScreen := SaveScreen()
LOCAL nArea   := 0
LOCAL Restart := OK
LOCAL lForever
LOCAL cTela
LOCAL lAberto := FALSO
P_DEF( lModo, OK )
P_DEF( nSegundos, 2 )

cBcoDados := StrTran( cBcoDados, '.DBF')
cAlias	 := IIF( cAlias = NIL, cBcoDados, cAlias )
lForever  := ( nSegundos = 0 )
lAberto	 := (cBcoDados)->(Used())
WHILE Restart
	WHILE ( lForever .OR. nSegundos > 0 )
		IF lModo
			Use (cBcoDados) SHARED NEW Alias ( cAlias ) VIA RDDNAME
		Else
			Use (cBcoDados) EXCLUSIVE NEW Alias ( cAlias ) VIA RDDNAME
		EndIF
		IF !NetErr()
			ResTela( cScreen )
			Return( OK )
		EndIF
		cTela := Mensagem("Tentando acesso a " + Upper(Trim(cBcoDados)) + ".DBF...")
		Inkey(.5)
		nSegundos -= .5
		ResTela( cTela )
	EndDo
	nOpcao := Conf("Acesso Negado a " + Upper(Trim( cBcoDados )) + " Novamente ? ")
	IF nOpcao = OK
		ResTart := OK
	Else
		ResTart := FALSO
		DbCloseAll()
		FChDir( oAmbiente:xBase )
		SetColor("")
		Cls
		MaBox( 10, 05, 18, 73 )
		Write( 11, 06,"#1 Se outra esta��o estiver indexando, aguarde o t�rmino.  ")
		Write( 13, 06,"#2 Se SHARE estiver instalado, aumente os par�metros de    ")
		Write( 14, 06,"   travamento de arquivos. Ex.: SHARE /F:18810 /L:510.     ")
		Write( 16, 06,"#3 Em ambiente de rede NOVELL, verifique o arquivo NET.CFG ")
		Write( 17, 06,"   e acrescente a linha FILE HANDLES=127.                  ")
		Inkey(0)
		Break
		//Quit
	EndIF
EndDo
Return( FALSO )

Function PickTam2( aNatu, aCfop, aTxIcms, cCfop, cNatu, nTxIcms )
****************************************************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nLen		 := Len( aCfop )
LOCAL aJunto	 := {}
LOCAL nPos
LOCAL nChoice

IF LastKey() = UP
	Return( OK )
EndIF

IF cCfop == '0.000'
	IncluiCfop()
	aNatu   := LerNatu()
	aCfop   := LerCFop()
	aTxIcms := LerIcms()
	ResTela( cScreen )
	Return( FALSO )
EndIF

IF cCfop != Space(05)
	nPos := Ascan( aCfop, cCfop )
	IF nPos != 0
		cNatu := aNatu[nPos]
		IF aTxIcms[nPos] != 0 .OR. cCfop != Space(05) .OR. cCfop != ' .   ' .OR. !Empty( cNatu )
			nTxIcms := aTxIcms[nPos]
			Return( OK )
		EndIF
	EndIF
EndIF
nLen := Len( aCfop )
For i := 1 To nLen
	Aadd( aJunto, Tran(aCfop[i],'9.999') + '|' + Tran( aTxIcms[i], '99.99') + '|' + aNatu[i] )
Next
MaBox( 10, 01, 12+nLen, 45, NIL, NIL, Roloc( Cor()) )
IF (nChoice := AChoice( 11, 03, 10+nLen, 44, aJunto )) != 0
	cCfop   := aCfop[ nChoice ]
	cNatu   := aNatu[ nChoice ]
	nTxIcms := aTxIcms[ nChoice ]
	IF cCfop == '0.000'
		IncluiCfop()
		aNatu   := LerNatu()
		aCfop   := LerCFop()
		aTxIcms := LerIcms()
		ResTela( cScreen )
		Return( FALSO )
	EndIF
EndIf
ResTela( cScreen )
Return( OK )

Function VerCfop( xcFop)
***********************
LOCAL GetList := {}
LOCAL aCfop   := LerCfop()

IF xcFop == Space(05) .OR. xcFop = ' .   '
	ErrorBeep()
	Alerta('Erro: Cfop invalido.')
	Return( FALSO )
EndIF
IF Ascan( aCfop, xcFop ) <> 0
	ErrorBeep()
	Alerta('Erro: Cfop ja registrado.')
	Return( FALSO )
EndIF
Return( OK )

Function LerCfop()
******************
LOCAL GetList := {}
LOCAL cFile   := 'CFOP.INI'
LOCAL aCfop   := {'0.000','5.102','6.102','5.915', '6.915'}
LOCAL nCampos := 0
LOCAL n		  := 0
LOCAL cCfop   := ''
LOCAL oCfop

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  cCfop := oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 1)
  Aadd( acfop, cCFop )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( acFop )

Function LerIcms()
******************
LOCAL GetList := {}
LOCAL cFile   := 'CFOP.INI'
LOCAL nCampos := 0
LOCAL aIcms   := {00.00, 17.00, 12.00, 17.00, 12.00 }
LOCAL oCfop

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  nTx_Icms := Val( oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 2))
  Aadd( aIcms, nTx_Icms )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( aIcms )

Function LerNatu()
******************
LOCAL GetList := {}
LOCAL cFile   := 'CFOP.INI'
LOCAL nCampos := 0
LOCAL oCfop
LOCAL aNatu := {'[INCLUIR NOVO]           ','VENDA DENTRO ESTADO      ','VENDA FORA ESTADO        ','REMESSA CONSERTO DENTRO  ','REMESSA CONSERTO FORA    '}

FChDir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
oCfop   := TIniNew( cFile )
nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
For n := 1 To nCampos
  cNatu	:= oCfop:ReadString("campos", "campo" + StrZero(n, 3), NIL, 3)
  Aadd( aNatu, cNatu )
Next
oCfop:Close()
FChDir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return( aNatu )

Function AscancNatu( aCfop, cCfop, aNatu )
******************************************
LOCAL nPos	:= Ascan( aCfop, cCfop )
LOCAL cNatu := ''

IF nPos <> 0
	cNatu := aNatu[nPos]
EndIF
Return( cNatu )

Procedure IncluiCFop()
**********************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL cFile 	:= 'CFOP.INI'
LOCAL cFop		:= Space(05)
LOCAL cNatu 	:= Space(20)
LOCAL nTx_Icms := 0
LOCAL nCampos	:= 0
LOCAL cBuffer
LOCAL oCfop

oMenu:Limpa()
WHILE OK
	MaBox( 10, 10, 14, 52 )
	@ 11, 11 Say "Cfop..............:" Get cFop     Pict '9.999' Valid VerCfop( cFop )
	@ 12, 11 Say "Natureza Operacao.:" Get cNatu    Pict '@!'    Valid EntradaInvalida({|| Empty( cNatu )}, NIL )
	@ 13, 11 Say "Taxa Icms.........:" Get nTx_Icms Pict '99.99'
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIF
	ErrorBeep()
	IF Conf('Pergunta: Incluir registro ?')
		FChDir( oAmbiente:xBaseDoc )
		Set Defa To ( oAmbiente:xBaseDoc )
		oCfop := TIniNew( cFile )
		nCampos := oCfop:ReadInteger("configuracao", "campos", 0 )
		nCampos++
		cTx_Icms := Tran( nTx_Icms, '99.99')
		cBuffer := cFop
		cBuffer += ';'
		cBuffer += cTx_Icms
		cBuffer += ';'
		cBuffer += cNatu
		oCfop:WriteInteger("configuracao", "campos", nCampos )
		oCfop:WriteString("campos","campo" + StrZero( nCampos, 3 ), cBuffer )
		oCFop:Close()
		FChDir( oAmbiente:xBaseDados )
		Set Defa To ( oAmbiente:xBaseDados )
	EndIF
EndDO

Function EntradaInvalida( oBloco, cMensagem )
*********************************************
IfNil( cMensagem, 'Erro: Entrada Invalida.')
Return( IF( Eval( oBloco ), ( ErrorBeep(), Alerta( cMensagem ), FALSO ), OK ))

Proc BaixasRece( cCaixa, cVendedor )
************************************
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL GetList := {}
LOCAL aLog	  := {}
LOCAL aMenu   := Array(3)
LOCAL cCodiCx
LOCAL lEmitir
LOCAL nAtraso
LOCAL nDebito
LOCAL lComissao
LOCAL nRecno
LOCAL cCodi
LOCAL nRecoCli
LOCAL dEmis
LOCAL dData
LOCAL dVcto
LOCAL cVcto
LOCAL nVpag
LOCAL nVlr
LOCAL cPort
LOCAL cFatu
LOCAL cTipo
LOCAL cTipoParcial
LOCAL cCodiVen
LOCAL nJuro
LOCAL Comis_Lib
LOCAL cNossoNr
LOCAL nOpcao
LOCAL cBordero
LOCAL nPorc
LOCAL nTotJuros
LOCAL nVlrTotal
LOCAL nVlrPago
LOCAL nChSaldo
LOCAL nRecno1
LOCAL cDocnr
LOCAL nLocaliza
LOCAL nCotacao
LOCAL cDc
LOCAL nSobra	 := 0
LOCAL cCodiCob  := Space(04)
LOCAL cCobSN	 := "N"
LOCAL cObs		 := Space(40)
LOCAL nDesconto := 0
LOCAL nMulta	 := 0
LOCAL nEscolha  := 0
LOCAL cNome
LOCAL cEnde
LOCAL cCida
LOCAL cCodiCx1
LOCAL cDc1
LOCAL cDc2
LOCAL cHist
LOCAL cLcJur
LOCAL cDcJur
LOCAL cCodiJur
LOCAL nCol
LOCAL nRow
LOCAL nCarencia
LOCAL nJuroDia
LOCAL nVlrSemJuro
LOCAL cCodiCx2
LOCAL cHist2
LOCAL xAtraso
LOCAL nVlrLcto
LOCAL nDiferenca
LOCAL nRecRecebido
LOCAL cRegiao
LOCAL cParcial 	:= "Q"
LOCAL cString		:= 'BX ' + AllTrim(cVendedor) + '.'
LOCAL nPercentual := 0
LOCAL lExcluir 	:= OK
LOCAL xAgenda
LOCAL nComissao1	:= 0
LOCAL nComissao2	:= 0
LOCAL nComissao3	:= 0
LOCAL nDiaIni1 	:= 0
LOCAL nDiaIni2 	:= 0
LOCAL nDiaIni3 	:= 0
LOCAL nDiaFim1 	:= 0
LOCAL nDiaFim2 	:= 0
LOCAL nDiaFim3 	:= 0
LOCAL nRecibo		:= 1
LOCAL nAutenticar := 2
LOCAL nNenhum		:= 3
LOCAL lDesconto	:= FALSO
FIELD Vlr
FIELD Port
FIELD Tipo
FIELD Juro
FIELD NossoNr
FIELD Bordero
FIELD Porc
FIELD Emis
FIELD Vcto
FIELD Codi
FIELD Fatura
FIELD ComDisp
FIELD Comissao
FIELD CodiVen
FIELD ComBloq
FIELD Docnr

IF !PodeReceber()
	 ResTela( cScreen )
	 Return
EndIF

lDesconto			 := oIni:ReadBool('baixasrece','campodesconto', FALSO )
nRecibo				 := oIni:ReadInteger('baixasrece','recibo', 1 )
nAutenticar 		 := oIni:ReadInteger('baixasrece','autenticar', 2 )
nNenhum				 := oIni:ReadInteger('baixasrece','nenhum', 3 )
aMenu[nRecibo] 	 := 'Recibo'
aMenu[nAutenticar] := 'Autenticar'
aMenu[nNenhum] 	 := 'Nenhum'
WHILE OK
	cDocnr := Space(09)
	MaBox( 10, 10, 12, 40 )
	@ 11, 11 Say "Documento N�....: " Get cDocnr Pict "@!" Valid DocErrado( @cDocnr )
	Read
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Exit
	EndIF
	oMenu:Limpa()
	Receber->(Order( RECEBER_CODI ))
	Area("ReceMov")
	Recemov->(Order( RECEMOV_DOCNR ))
	Set Rela To Codi Into Receber
	cNome 	:= Receber->Nome
	cEnde 	:= Receber->Ende
	cCida 	:= Receber->Cida
	nRecno	:= Recno()
	nRecoCli := Receber->(Recno())
	dData 	:= Date()
	nVpag 	:= Vlr
	cPort 	:= Port
	cTipo 	:= Recemov->Tipo
	cTipoParcial := Recemov->Tipo
	nJuro 	:= Juro
	cNossoNr := NossoNr
	cBordero := Bordero
	nPorc 	:= Porc
	cCodiCx	:= "0000"
	cCodiCx1 := Space(04)
	cCodiCx2 := Space(04)
	cDc		:= "C"
	cDc1		:= "C"
	cDc2		:= "C"
	cHist 	:= "REC " + cNome
	cCodiCob := IF( Recemov->RelCob, Recemov->Cobrador, Space(04))
	cCobSN	:= IF( Recemov->RelCob, "S", "N")
	cLcJur	:= "N"
	cObs		:= cString + Space(40-Len(cString))
	cDcJur	:= "C"
	cCodiJur := cCodiCx
	WHILE OK
		nCol := 05
		nRow := 05
		MaBox( 04, 04 , nRow+18 , 78, "RECEBIMENTOS" )
		@ nRow+00, nCol	 SAY "Cliente.....: " + Receber->Codi + " " + Receber->Nome
		@ nRow+01, nCol	 SAY "Tipo........: " + cTipo
		@ nRow+01, nCol+35 SAY "Docto N�....: " + cDocnr
		@ nRow+02, nCol	 SAY "Nosso N�....: " + cNossoNr
		@ nRow+02, nCol+35 SAY "Bordero.....: " + cBordero
		@ nRow+03, nCol	 SAY "Emissao.....: " + Dtoc( Emis )
		@ nRow+03, nCol+35 SAY "Vencto......: " + Dtoc( Vcto )
		@ nRow+04, nCol	 SAY "Juros Mes...: " + Tran( nJuro , "@E 9,999,999,999.99" )
		@ nRow+04, nCol+35 SAY "Dias Atraso.: "
		@ nRow+05, nCol	 SAY "Valor.......: " + Tran( Vlr ,   "@E 9,999,999,999.99" )
		@ nRow+06, nCol	 SAY "Jrs Devidos.: "
		@ nRow+07, nCol	 SAY "Vlr c/Juros.: "
		@ nRow+08, nCol	 SAY "Data Pgto...: " Get dData Pict "##/##/##" Valid PodeRecDataDif( dData )
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		nAtraso		:= Atraso( dData, Vcto )
		nCarencia	:= Carencia( dData, Vcto )
		nJuroDia 	:= JuroDia( Vlr, Juro )
		nDesconto	:= VlrDesconto( dData, Vcto, Vlr )
		nPercentual := PercDesconto( dData, Vcto, Vlr )
		//nMulta 	  := VlrMulta( dData, Vcto, Vlr )
		nMulta		:= 0
		nVlrSemJuro := Recemov->Vlr

		IF lDesconto = FALSO
			IF nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := ( Vlr + nMulta ) - nDesconto
			Else
				nTotJuros := nJurodia * nCarencia
				nVlrTotal := (( Vlr + nTotJuros ) + nMulta )- nDesconto
			EndIF
		ElseIF lDesconto = OK
			IF nAtraso <= 0
				nTotJuros := 0
				nVlrTotal := ( Vlr + nMulta )
			Else
				nTotJuros := nJurodia * nCarencia
				nVlrTotal := (( Vlr + nTotJuros ) + nMulta )
			EndIF
		EndIF
		nMulta		:= VlrMulta( dData, Vcto, nVlrTotal )
		nVlrTotal	+= nMulta

		Write( nRow+04, nCol+35, "Dias Atraso.: " + Tran( nAtraso,   "99999") + " Dias" )
		Write( nRow+05, nCol+35, "Desconto....: " + Tran( nDesconto, "@E 9,999,999,999.99"))
		Write( nRow+06, nCol,	 "Jrs Devidos.: " + Tran( nTotJuros, "@E 9,999,999,999.99"))
		Write( nRow+06, nCol+35, "Multa.......: " + Tran( nMulta,    "@E 9,999,999,999.99"))
		Write( nRow+07, nCol,	 "Vlr c/juros.: " + Tran( nVlrTotal, "@E 9,999,999,999.99"))

		nVlrPago := nVlrTotal
		IF lDesconto = OK
			@ nRow+08, nCol+35 Say "Desconto....: " GET nPercentual Pict '999.99' Valid (nVlrPago := ( nVlrTotal - ((nVlrTotal * nPercentual) / 100 ))) >= 0 .OR. (nVlrPago := ( nVlrTotal - ((nVlrTotal * nPercentual) / 100 ))) <= 0
		EndIF
		@ nRow+09, nCol	 Say "Valor Pago..: " GET nVlrPago Pict "@E 9,999,999,999.99"
		@ nRow+09, nCol+35 Say "Bordero.....: " GET cBordero Pict "@!"
		@ nRow+10, nCol	 Say "Tipo........: " GET cTipo    Pict "@!" Valid  PickTam({"DinHeiro","Nota Promissoria","Duplicata Mercantil","CHeque a Vista","ReQuisicao","BoNus","Cheque Pre-Datado","DiFerenca Rec/Pag","Direta Livre","CarTao", "OUtros"}, {"DH    ","NP    ","DM    ","CH    ","RQ    ","BN    ","CP    ","DF    ","DL    ","CT    ","OU    "}, @cTipo )
		@ nRow+10, nCol+35 Say "Portador....: " GET cPort    Pict "@!"
		@ nRow+11, nCol	 Say "Conta Caixa.: " GET cCodiCx  Pict "9999" Valid CheErrado( @cCodiCx,, Row(), nCol+28 )
		@ nRow+11, nCol+20 Say "D/C.:"          GET cDc      Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc )

		@ nRow+12, nCol	 Say "C. Partida..: " GET cCodiCx1 Pict "9999" Valid CheErrado( @cCodiCx1,, Row(), nCol+28, OK )
		@ nRow+12, nCol+20 Say "D/C.:"          GET cDc1     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc1 )

		@ nRow+13, nCol	 Say "C. Partida..: " GET cCodiCx2 Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28, OK )
		@ nRow+13, nCol+20 Say "D/C.:"          GET cDc2     Pict "!"    Valid PickTam({'Credito em conta','Debito em conta'}, {'C','D'}, @cDc2 )

		@ nRow+14, nCol	 Say "Historico...: " GET cHist    Pict "@!"   Valid !Empty( cHist )
		@ nRow+15, nCol	 Say "Observacoes.: " GET cObs     Pict "@!"
		@ nRow+16, nCol	 Say "Com. Cobr...: " GET cCobSN   Pict "!"    Valid PickSimNao( @cCobSN )
		@ nRow+16, nCol+20 Say "Cob...:"        GET cCodiCob Pict "9999" WHEN cCobSN = "S" Valid FunErrado( @cCodiCob,, Row(), Col() + 1 )
		@ nRow+17, nCol	 Say "Separar Jrs.: " GET cLcJur   Pict "!"    Valid PickSimNao( @cLcJur )
		@ nRow+17, nCol+20 Say "Conta.:"        GET cCodiJur Pict "9999" WHEN cLcJur = "S" Valid CheErrado( @cCodiJur,, Row(), Col() + 1 )
		Read
		IF LastKey() = ESC
			Exit
		EndIF
		cCodiVen 	 := Recemov->CodiVen
		cCodi 		 := Recemov->Codi
		cRegiao		 := Recemov->Regiao
		dEmis 		 := Recemov->Emis
		dVcto 		 := Recemov->Vcto
		nVlr			 := Recemov->Vlr
		cTipoParcial := Recemov->Tipo
		cFatu 		 := Recemov->Fatura
		lComissao	 := Recemov->Comissao
		nOpcao		 := Conf( "Pergunta: Confirma a baixa deste Titulo ?", { " Sim ", " Alterar ", " Cancelar "})
		lEmitir		 := 1
		IF nOpcao = 1 // Baixar
			IF nVlrPago <> nVlrTotal
				ErrorBeep()
				lEmitir := Conf("Valor pago diferente que o devido.;;Pergunta: Fazer Baixa como:",;
										{"Quitando", "Parcial", "Diferenca C/C", "Cancelar"})
				IF lEmitir = 0 .OR. lEmitir = 4
					Loop
				EndIF
				Do Case
				Case lEmitir = 1
					cParcial := "Q"
				Case lEmitir = 2
					cParcial := "P"
				Case lEmitir = 3
					cParcial := "D"
				EndCase
				IF lEmitir = 3
					cCodiCx2 := Space(04)
					cDc2		:= " "
					cHist2	:= cHist
					MaBox( nRow+15, 05 , nRow+18 , 74, "LANCAMENTOS DIFERENCA C/C")
					@ nRow+16, nCol	 Say "Conta Caixa.: " GET cCodiCx2  Pict "9999" Valid CheErrado( @cCodiCx2,, Row(), nCol+28 )
					@ nRow+16, nCol+20 Say "D/C.:"          GET cDc2      Pict "!" Valid cDc2 $ "DC"
					@ nRow+17, nCol	 Say "Historico...: " GET cHist2    Pict "@!" Valid !Empty( cHist2 )
					Read
					IF LastKey() = ESC
						Loop
					EndIF
					ErrorBeep()
					IF !Conf("Pergunta: Confirma Lancamento ?")
						Loop
					EndIF
				EndIF
			EndIF
			Receber->(DbGoTo( nRecoCli )) 		  // Localiza Cliente
			IF Cheque->(!TravaArq())	; DbUnLockAll() ; Loop ; EndIF
			IF Chemov->(!TravaArq())	; DbUnLockAll() ; Loop ; EndIF
			*:-------------------------------------------------------
			nLocaliza := Recemov->(Recno())
			xAtraso	 := Receber->Matraso
			IF nAtraso > 999
				nAtraso := 999
			EndIF
			IF xAtraso < nAtraso 					  // Se o Atraso Anterior for menor que o atual
				IF Receber->(TravaReg())
					Receber->Matraso := IF( nAtraso > 999, 999, nAtraso )
					Receber->(Libera())
				EndIF
			EndIF
			*:-------------------------------------------------------
			Cheque->(Order( CHEQUE_CODI ))
			IF cLcJur == "S" // Lancar Juros em conta Separada
				nVlrLcto := ( nVlrPago - nVlrSemJuro )
				IF Cheque->(DbSeek( cCodiJur )) .OR. !Empty( cCodiJur )
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
							Chemov->Codi	:= cCodiJur
							Chemov->Docnr	:= cDocnr
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= "REC JUROS TITULO N� " + cDocnr
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= cTipo
							Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->Fatura := cFatu
						EndIF
						Chemov->(Libera())
					EndIF
					Cheque->(Libera())
				EndIF
			EndIF
			*:-------------------------------------------------------
			IF Cheque->(DbSeek( cCodiCx )) .OR. !Empty( cCodiCx )
				IF Cheque->(TravaReg())
					nVlrLcto := nVlrPago
					IF cLcJur == "S" // Lancar Juros em conta Separada
						nVlrLcto := nVlrSemJuro
					EndIF
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
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
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
							nChSaldo 	  += nVlrPago
							Cheque->Saldo += nVlrPago
							Chemov->Cre   := nVlrPago
						Else
							nChSaldo 	  -= nVlrPago
							Cheque->Saldo -= nVlrPago
							Chemov->Deb   := nVlrPago
						EndIF
						Chemov->Codi	:= cCodiCx1
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
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
							nChSaldo 	  += nVlrPago
							Cheque->Saldo += nVlrPago
							Chemov->Cre   := nVlrPago
						Else
							nChSaldo 	  -= nVlrPago
							Cheque->Saldo -= nVlrPago
							Chemov->Deb   := nVlrPago
						EndIF
						Chemov->Codi	:= cCodiCx2
						Chemov->Docnr	:= cDocnr
						Chemov->Emis	:= dData
						Chemov->Data	:= dData
						Chemov->Baixa	:= Date()
						Chemov->Hist	:= cHist
						Chemov->Saldo	:= nChSaldo
						Chemov->Tipo	:= cTipo
						Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
						Chemov->Fatura := cFatu
					EndIF
					Chemov->(Libera())
				EndIF
				Cheque->(Libera())
			EndIF
			*:-------------------------------------------------------
			IF lEmitir = 3
				IF Cheque->(DbSeek( cCodiCx2 )) .OR. !Empty( cCodiCx2 )
					IF Cheque->(TravaReg())
						nChSaldo   := Cheque->Saldo
						IF nVlrTotal < nVlrPago
							nDiferenca := ( nVlrPago - nVlrTotal )
						Else
							nDiferenca := ( nVlrTotal - nVlrPago )
						EndIF
						IF Chemov->(Incluiu())
							IF cDc2 = "C"
								nChSaldo 	  += nDiferenca
								Cheque->Saldo += nDiferenca
								Chemov->Cre   := nDiferenca
							Else
								nChSaldo 	  -= nDiferenca
								Cheque->Saldo -= nDiferenca
								Chemov->Deb   := nDiferenca
							EndIF
							Chemov->Codi	:= cCodiCx2
							Chemov->Docnr	:= cDocnr
							Chemov->Emis	:= dData
							Chemov->Data	:= dData
							Chemov->Baixa	:= Date()
							Chemov->Hist	:= cHist2
							Chemov->Saldo	:= nChSaldo
							Chemov->Tipo	:= "DF"       // Tipo Diferenca de Caixa
							Chemov->Caixa	:= IF( cCaixa = Nil, Space(4), cCaixa )
							Chemov->Fatura := cFatu
						EndIF
						Chemov->(Libera())
					EndIF
					Cheque->(Libera())
				EndIF
			EndIF
			*:-------------------------------------------------------
			IF Recebido->(Incluiu())
				Recebido->Codi 	 := cCodi
				Recebido->Caixa	 := IF( cCaixa = Nil, Space(4), cCaixa )
				Recebido->Regiao	 := cRegiao
				Recebido->CodiVen  := cCodiVen
				Recebido->Docnr	 := cDocnr
				Recebido->Emis 	 := dEmis
				Recebido->Vcto 	 := dVcto
				Recebido->Baixa	 := Date()
				Recebido->Vlr		 := nVlr
				Recebido->DataPag  := dData
				Recebido->VlrPag	 := nVlrPago
				Recebido->Port 	 := cPort
				Recebido->Tipo 	 := cTipo
				Recebido->Juro 	 := nJuro
				Recebido->NossoNr  := cNossoNr
				Recebido->Bordero  := cBordero
				Recebido->Fatura	 := cFatu
				Recebido->Obs		 := cObs
				Recebido->Parcial  := cParcial
				Recebido->Docnr	 := cParcial + Right(cDocnr, 8)
				nRecRecebido		 := Recebido->(Recno())
				Recebido->(Libera())
			EndIF
			*:-------------------------------------------------------
			nRecno1	:= Recno()
			Recemov->(DbGoTo( nLocaliza))
			IF Recemov->(TravaReg())
				IF nVlrPago < nVlrTotal .AND. lEmitir = 2 // Parcial
					nSobra				:= ( nVlrTotal - nVlrPago )
					nCotacao 			:= 0
					Recemov->Vcto		:= IF( nAtraso <= 0, Recemov->Vcto, dData )
					Recemov->Vlr		:= nSobra
					Recemov->VlrDolar := nSobra
					Recemov->Jurodia	:= JuroDia( nSobra, nJuro )
					Recemov->Docnr 	:= 'R' + Recemov->(Right(Docnr, 8))
					Recemov->Obs		:= 'RESTANTE PARCELA: ' + Docnr
				Else
					Recemov->(DbDelete())
				EndIF
			EndIF
			Recemov->(Libera())
			/*-------------------------------------------------------
			  Inicio da Liberacao de comissoes bloqueadas
			  -------------------------------------------------------*/
			IF nPorc <> 0															// Vair Pagar Comissao ?
				IF !Empty( cFatu )												// Eh Venda ?
					Vendemov->(Order( VENDEMOV_DOCNR ))
					IF Vendemov->(DbSeek( cFatu ))							// Localiza Fatura.
						IF Vendemov->Comdisp < Vendemov->Comissao 		// Disponivel menor que o total ?
							IF lComissao											// Pagar Comissao deste titulo ?
								IF Vendemov->(TravaReg())
									cCodiVen  := Vendemov->CodiVen
									IF nVlrPago >= nVlr
										Comis_Lib := ( nVlr * nPorc) / 100
									Else
										Comis_Lib := ( nVlrPago * nPorc) / 100
									EndIF
									Vendemov->ComBloq := ( Vendemov->ComBloq - Comis_Lib )
									Vendemov->ComDisp := ( Vendemov->ComDisp + Comis_Lib )
									IF Vendemov->ComBloq < 0
										Vendemov->ComBloq := 0
										Vendemov->ComDisp := Vendemov->Comissao
									EndIF
								EndIF
								Vendemov->(Libera())
								Vendedor->(Order( VENDEDOR_CODIVEN ))
								IF Vendedor->(DbSeek( cCodiVen ))
									IF Vendedor->(TravaReg())
										Vendedor->ComBloq 	:= ( Vendedor->ComBloq - Comis_Lib )
										Vendedor->ComDisp 	:= ( Vendedor->ComDisp + Comis_Lib )
										IF Vendedor->ComBloq < 0
											Vendedor->ComBloq := 0
											Vendedor->ComDisp := Vendedor->Comissao
										EndIF
									EndIF
									Vendedor->(Libera())
								EndIF
							EndIF
						EndIF
					EndIF
				EndIF
			EndIF
			/*-------------------------------------------------------
			  Inicio de Pagamento de Comissao a Cobradores
			  -------------------------------------------------------*/
			IF cCobSn = "S"  // Lancar Comissao a Cobrador
				lProcessarComissao := OK
				nComissao1 := oIni:ReadInteger('comissaoperiodo1', 'comissao', 0 )
				nComissao2 := oIni:ReadInteger('comissaoperiodo2', 'comissao', 0 )
				nComissao3 := oIni:ReadInteger('comissaoperiodo3', 'comissao', 0 )
				nDiaIni1   := oIni:ReadInteger('comissaoperiodo1', 'diaini', 0 )
				nDiaIni2   := oIni:ReadInteger('comissaoperiodo2', 'diaini', 0 )
				nDiaIni3   := oIni:ReadInteger('comissaoperiodo3', 'diaini', 0 )
				nDiaFim1   := oIni:ReadInteger('comissaoperiodo1', 'diafim', 0 )
				nDiaFim2   := oIni:ReadInteger('comissaoperiodo2', 'diafim', 0 )
				nDiaFim3   := oIni:ReadInteger('comissaoperiodo3', 'diafim', 0 )
				nPorcCob   := 0
				Do Case
				Case nAtraso >= nDiaIni1 .AND. nAtraso <= nDiaFim1
					IF nComissao1 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					EndIF
					nPorcCob := nComissao1
				Case nAtraso >= nDiaIni2 .AND. nAtraso <= nDiaFim2
					IF nComissao2 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					EndIF
					nPorcCob := nComissao2
				Case nAtraso >= nDiaIni3
					IF nComissao3 <= 0
						ErrorBeep()
						Alerta('Erro: Informe ao Supervisor que nao foi definido;comissao para cobrador em Arquivos/Configuracao ;da Base de Dados/Financeiro.;;Nao sera lancado comissao do cobrador!')
						lProcessarComissao := FALSO
					EndIF
					nPorcCob := nComissao3
				EndCase
				IF lProcessarComissao
					Vendedor->(Order( VENDEDOR_CODIVEN ))
					IF Vendedor->(DbSeek( cCodiCob ))
						IF Vendedor->(TravaReg())
							Comis_Lib := ( nVlrPago * nPorcCob ) / 100
							Area("Vendemov")
							IF Vendemov->(Incluiu())
								Vendemov->Docnr	  := cDocnr
								Vendemov->Dc		  := 'C'
								Vendemov->Descricao := cHist
								Vendemov->Regiao	  := cRegiao
								Vendemov->Pedido	  := cDocnr
								Vendemov->DataPed   := dData
								Vendemov->CodiVen   := cCodiCob
								Vendemov->Vlr		  := nVlrPago
								Vendemov->Data 	  := dData
								Vendemov->Porc 	  := nPorcCob
								Vendemov->Fatura	  := cFatu
								Vendemov->Codi 	  := cCodi
								Vendemov->Combloq   := 0
								Vendemov->Comissao  := Comis_Lib
								Vendedor->Comissao  += Comis_Lib
								Vendemov->Comdisp   := Comis_Lib
								Vendedor->ComDisp   += Comis_Lib
							EndIF
							Vendemov->(Libera())
						EndIF
						Vendedor->(Libera())
					EndIF
				EndIF
			EndIF
			Recemov->(Order( RECEMOV_CODI ))
			/* Funcao desativada em 19.02.2015
			// Limpeza do Agendamento
			lExcluir := OK
			IF Recemov->(DbSeek( cCodi ))
				While Recemov->Codi = cCodi
					IF Recemov->Vcto <= Date() // Continua Devendo ?
						lExcluir := FALSO
						Exit							// Vaza
					EndIF
					Recemov->(DbSkip(1))
				EndDo
			EndIF
			Receber->(Order( RECEBER_CODI ))
			IF lExcluir
				xAgenda	:= oAmbiente:xBaseDados + '\AGE' + cCodi + '.INI'
				Ferase( xAgenda )
				IF Receber->(DbSeek( cCodi ))
					IF Receber->(TravaReg())
						Receber->ProxCob := Ctod('')
						Receber->(Libera())
					EndIF
			  EndIF
			EndIF
			*/
			oMenu:Limpa()
			IF Receber->(DbSeek( cCodi ))
				IF Receber->Spc
					Recemov->(Order( RECEMOV_CODI ))
					IF Recemov->(!DbSeek( cCodi ))
						Alerta('Informa: Cliente sem debito e negativado SPC.')
					EndIF
				EndIF
			EndIF
			aLog	:= {}
			cVcto := Dtoc( dVcto )
			Aadd( aLog, "BAIXAS" )
			Aadd( aLog, cCodi )
			Aadd( aLog, cNome)
			Aadd( aLog, cDocnr )
			Aadd( aLog, cVcto )
			Aadd( aLog, Time())
			Aadd( aLog, Dtoc(Date()))
			Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
			Aadd( aLog, cCaixa	)
			Aadd( aLog, Tran( nVlrPago,'@E 999,999,999,999.99'))
			Aadd( aLog, cObs )
			Aadd( aLog, cEnde )
			Aadd( aLog, cCida )
			Aadd( aLog, cFatu )
			LogRecibo( aLog )
			M_Title("Pergunta: DESEJA IMPRIMIR ?")
			nEscolha := FazMenu( 10, 10, aMenu )
			IF nEscolha = nRecibo // 1
				//ReciboReceber( nRecRecebido, nSobra, aLog )
				aLog[ALOG_TIPO] := oAmbiente:cTipoRecibo
				aLog[ALOG_HIST] := "PAG PARCIAL PARCELA CONTRATO SERVICOS DE INTERNET."
				ReciboIndividual( cCaixa, cVendedor, aLog, nRecRecebido )
			ElseIF nEscolha = nAutenticar // 2
				Autenticar( nRecRecebido, nSobra )
			EndIF
		ElseIF nOpcao = 2 // Alterar
			Loop
		EndIF
		  Exit
	EndDo
	Recemov->(DbClearRel())
	Recemov->(DbGoTop())
	ResTela( cScreen )
EndDo

Function SplitCor( cColor, nForeGround, nBackGround )
*****************************************************
LOCAL aCores := {{'N',  0, 'Black',  'Preto'},;
					  {'B',  1, 'Blue',   'Azul'},;
					  {'G',  2, 'Green',  'Verde'},;
					  {'BG', 3, 'Cyan',   'Ciano'},;
					  {'R',  4, 'Red',    'Vermelho'},;
					  {'RB', 5, 'Magenta','Magenta'},;
					  {'GR', 6, 'Brown',  'Marrom'},;
					  {'W',  7, 'White',  'Branco'},;
					  {'N+', 8, 'Gray',   'Cinza'},;
					  {'B+', 9, 'Bright Blue','Azul Intenso'},;
					  {'G+', 10, 'Bright Green','Verde Intenso'},;
					  {'BG+', 11, 'Bright Cyan','Ciano Intenso'},;
					  {'R+',  12, 'Bright Red', 'Vermelho Intenso'},;
					  {'RB+', 13, 'Bright Magenta', 'Magenta Intenso'},;
					  {'GR+', 14, 'Yellow', 'Amarelo'},;
					  {'W+',  15, 'Bright White', 'Branco Intenso'}}
LOCAL aSplit		:= Array(5,2)
LOCAL cStandard
LOCAL cEnhanced
LOCAL cBorder
LOCAL cBackGround
LOCAL cUnseleted

IfNil( cColor, SetColor())
IfNil( nForeGround, 1 )
IfNil( nBackGround, 1 )

cStandard	:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cStandard, 1, At('/',cStandard)-1)
aSplit[1,1] := cTemp
aSplit[1,2] := DelAntesdaVirgula(cStandard, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cEnhanced	:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cEnhanced, 1, At('/',cEnhanced)-1)
aSplit[2,1] := cTemp
aSplit[2,2] := DelAntesdaVirgula(cEnhanced, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cBorder		:= SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cBorder, 1, At('/',cBorder)-1)
aSplit[3,1] := cTemp
aSplit[3,2] := DelAntesdaVirgula(cBorder, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cBackGround := SubStr(cColor, 1, At(',',cColor)-1)
cTemp 		:= SubStr(cBackGround, 1, At('/',cBackGround)-1)
aSplit[4,1] := cTemp
aSplit[4,2] := DelAntesdaVirgula(cBackGround, '/')
cColor		:= DelAntesdaVirgula(cColor, ',')

cUnseleted	:= cColor
cTemp 		:= SubStr(cUnseleted, 1, At('/',cUnseleted)-1)
aSplit[5,1] := cTemp
aSplit[5,2] := DelAntesdaVirgula(cUnseleted, '/')

/*

? cStandard
? cEnhanced
? cBorder
? cBackGround
? cUnseleted
? cColor
? acores[1,1]
? acores[2,1]
? acores[3,1]
? acores[4,1]

For i := 1 to 5
  ? aSplit[i, nForeGround]
  ? aSplit[i, nBackGround]
Next
? Ascan2(aSplit, nForeGround, 2)
? Ascan2(aSplit, nBackGround, 2)
*/

Return( aSplit )

Function DelAntesdaVirgula(cString, cStrLocate)
***********************************************
LOCAL cDeletar := SubStr(cString, 1, At(cStrLocate,cString))
Return(cString := Stuff(cString, 1, Len(cDeletar), ""))


Proc ReciboIndividual( cCaixa, cVendedor, aLog, nVlrRecibo, cDocnr )
********************************************************************
LOCAL Arq_Ant      := Alias()
LOCAL Ind_Ant      := IndexOrd()
LOCAL cScreen      := SaveScreen()
LOCAL GetList      := {}
LOCAL nVlr         := 0
LOCAL aRecibo      := {}
LOCAL Larg         := 80
LOCAL nOpcao       := 1
LOCAL cVlr         := Space(0)
LOCAL cValor       := Space(0)
LOCAL cHist        := Space(60)
LOCAL cObs         := Space(60)
LOCAL cString      := Space(60)
LOCAL lCalcular    := FALSO
LOCAL lParcial     := FALSO
LOCAL dDeposito    := Date()
LOCAL nVlrComJuros := 0
LOCAL nRecno
LOCAL nRow
LOCAL nCol
LOCAL lSair
LOCAL dVcto
LOCAL cCodi
LOCAL cNome
LOCAL cEnde
LOCAL cCida
LOCAL cFatu

WHILE OK
	oMenu:Limpa()
	IF aLog = NIL
      lSair        := IF( cDocnr = NIL, FALSO, OK )
      cDocnr       := IF( cDocnr = NIL, Space(09), cDocnr)
      nRow         := 11
      nCol         := 27
      nVlr         := Round(nVlr,2)
      nVlrRecibo   := Round(nVlrRecibo,2)
      nVlrComJuros := nVlrRecibo

		IF 	 oAmbiente:cTipoRecibo == "RECCAR"
			cTitulo := "RECIBO PAGTO EM CARTEIRA"
			MaBox( 10, 00, 15, 80, "IMPRESSAO DE " + cTitulo )
         @ 11, 01 Say "Documento N�....:" Get cDocnr     Pict "@!"           Valid DocErrado( @cDocnr, @nVlr, @nVlrRecibo, NIL, @cHist, Row(), Col()+1)
         @ 12, 01 Say "Valor...........:" Get nVlr       Pict "999999999.99" Valid lPodeReciboZerado(nVlr,nVlrRecibo) .AND. lPrtExtenso( nVlr, Row(), Col()+1, 45)
         @ 13, 01 Say "Valor Recibo....:" Get nVlrRecibo Pict "999999999.99" Valid lPrtExtenso(nVlrRecibo, Row(), Col()+1, 45)
         @ 14, 01 Say "Referente.......:" Get cHist      Pict "@!"
		ElseIF oAmbiente:cTipoRecibo == "RECBCO"
			cTitulo := "RECIBO VIA DEP BANCARIO"
			MaBox( 10, 00, 17, 80, "IMPRESSAO DE " + cTitulo )
         @ 11, 01 Say "Documento N�....:" Get cDocnr     Pict "@!"           Valid DocErrado( @cDocnr, @nVlr, @nVlrRecibo, NIL, @cHist, Row(), Col()+1)
         @ 12, 01 Say "Valor...........:" Get nVlr       Pict "999999999.99" Valid lPodeReciboZerado( nVlr ) .AND. lPrtExtenso( nVlr, Row(), Col()+1, 45)
         @ 13, 01 Say "Valor Recibo....:" Get nVlrRecibo Pict "999999999.99" Valid lPrtExtenso( nVlrRecibo, Row(), Col()+1, 45)
         @ 14, 01 Say "Referente.......:" Get cHist      Pict "@!"
         @ 15, 01 Say "Data Deposito...:" Get dDeposito  Pict "##/##/##"     Valid lValidDep1( dDeposito, @cObs )
         @ 16, 01 Say "Observacoes.....:" Get cObs       Pict "@!"
		ElseIF oAmbiente:cTipoRecibo == "RECOUT"
			cTitulo := "RECIBO PAGTO VIA OUTROS"
			MaBox( 10, 00, 17, 80, "IMPRESSAO DE " + cTitulo )
         @ 11, 01 Say "Documento N�....:" Get cDocnr     Pict "@!"           Valid DocErrado( @cDocnr, @nVlr, @nVlrRecibo, NIL, @cHist, Row(), Col()+1)
         @ 12, 01 Say "Valor...........:" Get nVlr       Pict "999999999.99" Valid lPodeReciboZerado( nVlr ) .AND. lPrtExtenso( nVlr, Row(), Col()+1, 45)
         @ 13, 01 Say "Valor Recibo....:" Get nVlrRecibo Pict "999999999.99" Valid lPrtExtenso( nVlrRecibo, Row(), Col()+1, 45)
         @ 14, 01 Say "Referente.......:" Get cHist      Pict "@!"
         @ 15, 01 Say "Data Pagamento..:" Get dDeposito  Pict "##/##/##"     Valid lValidDep2( dDeposito, @cObs )
         @ 16, 01 Say "Observacoes.....:" Get cObs       Pict "@!"
		EndIF

		Read
		IF LastKey() = ESC
			AreaAnt( Arq_Ant, Ind_Ant )
			ResTela( cScreen )
			Return
		EndIF
		IF !Instru80() .OR. !LptOk()
			Recemov->(DbClearRel())
			AreaAnt( Arq_Ant, Ind_Ant )
			Restela( cScreen )
			Return
		EndIF
		Receber->(Order( RECEBER_CODI ))
		Area("Recemov")
		Set Rela To Codi Into Receber
      cDocnr       := Recemov->Docnr
      nRecno       := Recemov->(Recno())
      nVlr         := Round( nVlr,2)
      nVlrRecibo   := Round( nVlrRecibo,2)
      nVlrComJuros := nVlr

      IF nVlrRecibo < nVlr  // Parcial?
			Mensagem("Aguarde, Ajustando registro parcial.", Cor())
         IF DuplicaReg( Chr(Asc(Left( cDocnr,1))+1), nVlr, nVlrRecibo, nVlrComJuros)
				Recemov->(DbGoto( nRecno))
				IF Recemov->(TravaReg())
               Recemov->Vlr := nVlrRecibo
					Recemov->(Libera())
				EndIF
			EndIF
		EndIF

      IF nVlrRecibo == 0 .AND. nVlr == 0 // Zerar?
			Recemov->(DbGoto( nRecno))
			IF Recemov->(TravaReg())
				Recemov->Vlr := 0
				Recemov->(Libera())
			EndIF
		EndIF

		cCodi   := Recemov->Codi
		cFatu   := Recemov->Fatura
		cNome   := Receber->Nome
		cEnde   := Receber->Ende
		cCida   := Receber->Cida
		cVcto   := Dtoc(Recemov->Vcto)
		nMoeda  := 1
      cVlr    := AllTrim( Tran( nVlrRecibo,'@E 999,999,999,999.99'))
      cValor  := Extenso( nVlrRecibo, nMoeda, 3, Larg )
		aLog	  := {}
		Aadd( aLog, oAmbiente:cTipoRecibo )
		Aadd( aLog, cCodi )
		Aadd( aLog, cNome)
		Aadd( aLog, cDocnr )
		Aadd( aLog, cVcto )
		Aadd( aLog, Time())
		IF oAmbiente:cTipoRecibo == "RECBCO" .OR. oAmbiente:cTipoRecibo == "RECOUT"
			Aadd( aLog, Dtoc(dDeposito))
		Else
			Aadd( aLog, Dtoc(Date()))
		EndIF
		Aadd( aLog, oAmbiente:xUsuario + Space( 10 - Len( oAmbiente:xUsuario )))
		Aadd( aLog, cCaixa	)
      Aadd( aLog, Tran( nVlrRecibo,'@E 999,999,999,999.99'))
		Aadd( aLog, (AllTrim(cHist) + Space(1)+ AllTrim(cObs)))
		Aadd( aLog, cEnde )
		Aadd( aLog, cCida )
		Aadd( aLog, cFatu )
	Else
		IF !Instru80() .OR. !LptOk()
			Recemov->(DbClearRel())
			AreaAnt( Arq_Ant, Ind_Ant )
			Restela( cScreen )
			Return
		EndIF
		lSair   := OK
		cCodi   := aLog[ALOG_CODI]
		cNome   := aLog[ALOG_NOME]
		cDocnr  := aLog[ALOG_DOCNR]
		cVcto   := aLog[ALOG_VCTO]
		cHist   := aLog[ALOG_HIST]
		cEnde   := aLog[ALOG_ENDE]
		cCida   := aLog[ALOG_CIDA]
		cFatu   := aLog[ALOG_FATURA]
		nMoeda  := 1
		cVlr	  := AllTrim( aLog[ALOG_VLR])
      cValor  := Extenso( nVlrRecibo, nMoeda, 2, Larg )
	EndIF
	aAgenda := { cCodi, Date(), "PAG PARCIAL {DOC:" + cDocnr + " - VCTO:" + cVcto + " - PAGO:" + cVlr + "}", cCaixa, oAmbiente:xUsuario, OK }
	LogRecibo( aLog )
	LogAgenda( aAgenda )
	cTela := Mensagem("Aguarde, Imprimindo Recibo.", Cor())
	PrintOn()
	FPrInt( Chr(ESC) + "C" + Chr( 33 ))
	SetPrc(0,0)
	nRow := 1
	Write( nRow+00, 00, Repl("=",80))
	Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta),40) + CA )
	Write( nRow+02, 00, XENDEFIR + " - " + XCCIDA + " - " + XCESTA)
	Write( nRow+03, 00, Repl("-",80))
	Write( nRow+04, 00, GD + Padc(cTitulo,40) + CA )
	Write( nRow+05, 00, Padr("N� " + NG + cDocnr + NR,80))
	Write( nRow+05, 00, Padl("R$ " + NG + cVlr + NR,80))
	nRow++
	Write( nRow+06, 00, "Recebemos de    : " + NG + cNome + NR )
	Write( nRow+07, 00, "Estabelecido  a : " + NG + cEnde + NR )
	Write( nRow+08, 00, "na Cidade de    : " + NG + cCida + NR )
	Write( nRow+10, 00, "A Importancia por extenso abaixo relacionada")
	Write( nRow+11, 00, NG + Left( cValor, Larg ) + NR  )
	Write( nRow+12, 00, NG + Right( cValor, Larg ) + NR  )
	Write( nRow+14, 00, "Referente a")
	Write( nRow+15, 00, NG + cHist + NR )
	IF oAmbiente:cTipoRecibo == "RECBCO"
		Write( nRow+16, 00, NG + AllTrim(cObs) + NR )
	ElseIF oAmbiente:cTipoRecibo == "RECOUT"
		Write( nRow+16, 00, NG + AllTrim(cObs) + NR )
	EndIF
	Write( nRow+18, 00, "Para maior clareza firmo(amos) o presente")
	IF oAmbiente:cTipoRecibo == "RECBCO" .OR. oAmbiente:cTipoRecibo == "RECOUT"
		Write( nRow+19, 35, NG + DataExt( dDeposito ) + NR )
	Else
		Write( nRow+19, 35, NG + DataExt( Date()) + NR )
	EndIF
	Write( nRow+22, 40, Repl("-",40))
	Write( nRow+23, 00, "1� VIA - CLIENTE" )
	Write( nRow+23, 40, oAmbiente:xUsuario )
	Write( nRow+24, 00, Repl("=",80))
	Write( nRow+25, 00, Padc("ESTE RECIBO NAO QUITA EVENTUAIS DEBITOS/MENSALIDADES ANTERIORES",80))
	__Eject()
	PrintOff()
	Recemov->(DbSkip(1))
	Recemov->(DbClearRel())
	Recemov->(DbClearFilter())
	Recemov->(DbGoTop())
	ResTela( cTela )
	aLog := NIL
	IF lSair
		Exit
	EndIF
EndDo
ResTela( cScreen )
AreaAnt( Arq_Ant, Ind_Ant )
Return

*------------------------------------------------------------------------------

Function lPodeReciboZerado(nVlr,nVlrComJuros)
*********************************************
LOCAL nNivel  := SCI_PODE_RECIBO_ZERADO
LOCAL oVenlan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL lAdmin  := oVenlan:ReadBool('permissao','usuarioadmin', FALSO )
LOCAL lRetVal := OK

IF !lAdmin
   IF nVlr < nVlrComJuros
      nVlr := IF((lRetVal := PedePermissao(nNivel)), nVlr, nVlrComJuros)
   EndIF
EndIF
Return(lRetVal)

*------------------------------------------------------------------------------

Function lValidDep1( dDeposito, cObs )
**************************************
cObs := "EFETUADO DEP BANCO CREDIP EM DATA DE "
cObs += Dtoc( dDeposito ) + '.'
cObs += Space(60-Len(cObs))
Return(OK)

*------------------------------------------------------------------------------

Function lValidDep2( dDeposito, cObs )
**************************************
cObs := "PAGO EM MAOS A TIAGO TIMOTEO DE OLIVEIRA EM DATA DE "
cObs += Dtoc( dDeposito ) + '.'
cObs += Space(60-Len(cObs))
Return(OK)

*------------------------------------------------------------------------------

Function DuplicaReg( cLetraParcial, nVlr, nVlrRecibo, nVlrComJuros)
*******************************************************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := Recemov->(DbStruct())
LOCAL nConta  := Recemov->(FCount())
LOCAL lRet	  := FALSO
LOCAL xRegistro

xRegistro := Recemov->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
	xAlias->(FieldPut( nField, Recemov->(FieldGet( nField ))))
Next
IF Recemov->(Incluiu())
	For nField := 1 To nConta
		Recemov->(FieldPut( nField, xAlias->(FieldGet( nField ))))
	Next
	Recemov->Docnr := cLetraParcial + Right( Recemov->Docnr, 8)
   Recemov->Vlr   := (nVlr - nVlrRecibo)
   Recemov->Vcto  := IF( nVlr == nVlrComJuros, Date(),Recemov->Vcto)
	Recemov->(Libera())
	lRet := OK
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
Recemov->(DbGoto( xRegistro ))
Return( lRet )

*------------------------------------------------------------------------------

Function lPrtExtenso( nVlr, nRow, nCol, nLarg)
**********************************************
LOCAL nMoeda  := 1
LOCAL nLinhas := 1

IfNil(nLarg, 45)
Write( nRow, nCol, Extenso( nVlr, nMoeda, nLinhas, nLarg))
Return( OK )

*------------------------------------------------------------------------------

Function _SomaPago( nValorTotal, nValorPago )
*********************************************
LOCAL aStr := {}
LOCAL cStr1

	 cStr1 := " TOTAL GERAL �� "
	 cStr1 += Space(27)
	 cStr1 += Tran(nValorTotal, "@E 999,999,999.99")
	 cStr1 += Space(01)
	 cStr1 += Tran(nValorPago,  "@E 999,999,999.99")
	 Aadd( aStr, cStr1 )
	 Aadd( aStr, cStr1 )
Return(aStr)

*------------------------------------------------------------------------------

Proc FoneTroca()
****************
LOCAL nConta := 0

ErrorBeep()
IF !Conf("Pergunta: Tem absoluta certeza?")
	Return
EndIF
oMenu:Limpa()
Area("RECEBER")
Receber->(DbgoTop())
While !Eof()
	cFone 	 := TrocaFone( Receber->Fone )
	cFax		 := TrocaFone( Receber->Fax )
	cFone1	 := TrocaFone( Receber->Fone1 )
	cFone2	 := TrocaFone( Receber->Fone2 )
	cFoneAval := TrocaFone( Receber->FoneAval )
	IF Receber->(TravaReg())
		Receber->Fone		:= cFone
		Receber->Fax		:= cFax
		Receber->Fone1 	:= cFone1
		Receber->Fone2 	:= cFone2
		Receber->FoneAval := cFoneAval
		Receber->(Libera())
		Receber->(DbSkip(1))
	EndIF
EnddO

Function TrocaFone( cFone )
***************************
//(0069)451-2286
IF Left(cFone, 6) == "(0069)" .AND. ;
	SubStr( cFone, 10,1) == "-"  .AND. ;
	SubStr( cFone, 07,1) != "9" .AND. ;
	SubStr( cFone, 07,1) != "8"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEIF Left(cFone, 6) == "(0069)" .AND. ;
	SubStr( cFone, 10,1) = "-" .AND. ;
	SubStr( cFone, 07,1) = "9" .OR. ;
	SubStr( cFone, 07,1) = "8"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca

ElseIF Left(cFone, 6) == "(069 )" .AND. ;
	SubStr( cFone, 10,1) == "-"  .AND. ;
	SubStr( cFone, 07,1) != "9" .AND. ;
	SubStr( cFone, 07,1) != "8"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEIF Left(cFone, 6) == "(069 )" .AND. ;
	SubStr( cFone, 10,1) = "-" .AND. ;
	SubStr( cFone, 07,1) = "9" .OR. ;
	SubStr( cFone, 07,1) = "8"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca

ElsEIF Left(cFone, 6) == "(0693)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)93" + Substr(cFone,7,8)
	? cFone, cTroca
ElsEIF Left(cFone, 6) == "(0699)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)99" + Substr(cFone,7,8)
	? cFone, cTroca
ElsEIF Left(cFone, 6) == "(0698)" .AND. ;
	SubStr( cFone, 10,1) = "-"
	cTroca := "(69)98" + Substr(cFone,7,8)
	? cFone, cTroca
Else
	 cTroca := cFone
	 Qout(cFone, "Sem troca")
EndIF
Return( cTroca )


Proc SeekLog(xTodos, aTodos)
****************************
LOCAL xLog		 := 'RECIBO.LOG'
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cTpBaixas := "BAIXAS"
LOCAL cTpRecibo := "RECIBO"
LOCAL cStr1
LOCAL cStr2
LOCAL cStr3
LOCAL cStr4
LOCAL cStr5
LOCAL cFull
LOCAL nLen
LOCAL nHandle
LOCAL nOffSet
LOCAL cDocnr
LOCAL lSucesso
LOCAL nVlrDevido
LOCAL nPrincipal
LOCAL nJurosPago
LOCAL nSaldo
LOCAL x

IF !File( xLog )
	nHandle := Fcreate( xLog, FC_NORMAL )
	FClose( nHandle )
EndIF
nHandle	  := FOpen( xLog, FO_READWRITE + FO_SHARED )
nLen		  := Len( oRecePosi:aAtivo )
nPrincipal := 0
For x := 1 To nLen
	cDocnr := xTodos[x,XTODOS_DOCNR]
	IF oAmbiente:lReceber // consulta titulos a receber
		IF !xTodos[x,XTODOS_ATIVO] // Registros do RECEBIDO.DBF
			nPrincipal	:= xTodos[x,XTODOS_VLR]
			nSaldo		:= 0
			nJurosPago	:= (xTodos[x,XTODOS_SOMA] - nPrincipal)
			nAtraso		:= xTodos[x,XTODOS_ATRASO]
			cStr1 		:= Left( aTodos[x],24) + Space(1)
			cStr2 		:= StrZero( nAtraso, 4 )
			cStr3 		:= SubStr( aTodos[x],30,10) + Space(1)
			cStr4 		:= Dtoc(xTodos[x,XTODOS_DATAPAG]) + Space(1)
			cStr5 		:= Tran(nJurosPago, "@E 9,999.99") + Space(1)
			cStr6 		:= Tran(xTodos[x,XTODOS_SOMA], "@E 9,999.99")  + Space(1)
			cStr7 		:= Tran(nSaldo, "@E 999,999.99")
			cFull 		:= cStr1 + cStr2 + cStr3 + cStr4 + cStr5 + cStr6 + cStr7

			oReceposi:aHistRecibo[x] := xTodos[x,XTODOS_OBS]
			oReceposi:aUserRecibo[x] := xTodos[x,XTODOS_OBS]
			oRecePosi:aAtivoSwap[x]  := FALSO
			oRecePosi:aAtivo[x]		 := FALSO
			oRecePosi:nAberto 		 += nSaldo
			oRecePosi:nPrincipal 	 += nPrincipal
			oRecePosi:nRecebido		 += xTodos[x,XTODOS_SOMA]
			oRecePosi:nJurosPago 	 += nJurosPago
			oRecePosi:nQtdDoc++
			aTodos[x]					 := cFull
			alMulta[x]					 := FALSO
			xTodos[x,XTODOS_MULTA]	 := xTodos[x,XTODOS_SOMA]
			xTodos[x,XTODOS_JUROS]	 := nJurosPago
			xTodos[x,XTODOS_SOMA]	 := nSaldo
			Loop
		EndIF
		Area("RECIBO")
		Recibo->(Order( RECIBO_DOCNR))
		IF Recibo->(DbSeek( cDocnr ))
			While Recibo->Docnr = cDocnr
				nPrincipal := xTodos[x,XTODOS_VLR]
				nVlrDevido := (nPrincipal - Recibo->Vlr)
				nJurosPago := 0
				nSaldo	  := 0
				IF nVlrDevido <= 0
					nJurosPago := ( Recibo->Vlr - nPrincipal)
					oRecePosi:aAtivoSwap[x] := FALSO
					oRecePosi:aAtivo[x]		:= FALSO
					oRecePosi:nQtdDoc++
					oRecePosi:nRecebido		+= Recibo->Vlr
					oRecePosi:nJurosPago 	+= nJurosPago
				Else
					nSaldo						:= nVlrDevido
					oRecePosi:nAberto 		+= nSaldo
				EndIF

				nAtraso		:= Atraso( Recibo->Data, Recibo->Vcto )
				cStr1 		:= Left( aTodos[x],24) + Space(1)
				cStr2 		:= StrZero( nAtraso, 4 )
				cStr3 		:= SubStr( aTodos[x],30,10) + Space(1)
				cStr4 		:= Dtoc( Recibo->Data ) + Space(1)
				cStr5 		:= Tran(nJurosPago, "@E 9,999.99") + Space(1)
				cStr6 		:= Tran(Recibo->Vlr, "@E 9,999.99")  + Space(1)
				cStr7 		:= Tran(nSaldo, "@E 999,999.99")
				cFull 		:= cStr1 + cStr2 + cStr3 + cStr4 + cStr5 + cStr6 + cStr7

				aTodos[x]					 := cFull
				alMulta[x]					 := FALSO
				xTodos[x,XTODOS_MULTA]	 := Recibo->Vlr
				xTodos[x,XTODOS_JUROS]	 := nJurosPago
				xTodos[x,XTODOS_SOMA]	 := nSaldo
				oReceposi:aHistRecibo[x] := Recibo->Hist
				oReceposi:aUserRecibo[x] := AllTrim(Recibo->Tipo) + '/' + AllTrim(Recibo->Usuario) + '/' + Recibo->Hora
				oRecePosi:nPrincipal 	 += nPrincipal
				Recibo->(DbSkip(1))
			EndDo
		Else
			IF ( lSucesso := FLocate( nHandle, cDocnr) > 0)
				xTodos[x,XTODOS_JUROS]	:= 0
				oRecePosi:nPrincipal 	+= xTodos[x,XTODOS_VLR]
				oRecePosi:aAtivoSwap[x] := FALSO
				oRecePosi:aAtivo[x]		:= FALSO
				oRecePosi:nQtdDoc++
			EndIF
		EndIF
	Else				  // consulta titulos recebidos
		Area("RECIBO")
		Recibo->(Order( RECIBO_DOCNR))
		oRecePosi:aAtivo[x]		:= FALSO
		oRecePosi:aAtivoSwap[x] := FALSO
		IF Recibo->(DbSeek( cDocnr ))
			oRecePosi:aAtivoSwap[x]  := OK
			oRecePosi:aAtivo[x]		 := OK
			oRecePosi:aHistRecibo[x] := Recibo->Hist
			oRecePosi:aUserRecibo[x] := AllTrim(Recibo->Usuario) + '/' + Recibo->Hora
		Else
			IF ( lSucesso := FLocate( nHandle, cDocnr) > 0)
				oRecePosi:aAtivo[x]		:= OK
				oRecePosi:aAtivoSwap[x] := OK
			EndIF
		EndIF
	EndIF
Next
FClose( nHandle )
AreaAnt( Arq_Ant, Ind_Ant )
Return

*------------------------------------------------------------------------------

Function _SomaRecebido(xTodos, nConta, nValorTotal, nTotalGeral)
****************************************************************
LOCAL xLen		  := Len(xTodos)
LOCAL nPrincipal := 0
LOCAL nAberto	  := 0
LOCAL nRecibo	  := 0
LOCAL nJuros	  := 0
LOCAL nMulta	  := 0
LOCAL aStr		  := {}
LOCAL cStr1
LOCAL cStr2
LOCAL nT

	For nT := 1 To xLen
		IF !alMulta[nT]
			nRecibo += xTodos[nT,XTODOS_MULTA]
		EndIF
		nPrincipal += xTodos[nT,XTODOS_VLR]
		nMulta	  += xTodos[nT,XTODOS_MULTA]
		nJuros	  += xTodos[nT,XTODOS_JUROS]
		nAberto	  += xTodos[nT,XTODOS_SOMA]
	Next
	nMulta -= nRecibo
	cStr1 := " RECIBO �� {"
	cStr1 += StrZero(oRecePosi:nQtdDoc,5)
	cStr1 += "}" + Space(12)
	cStr1 += Tran(oRecePosi:nPrincipal, "@E 999,999.99") + Space(8)
	cStr1 += Tran(oRecePosi:nJurosPago, "@E 999,999.99") + Space(1)
	cStr1 += Tran(nRecibo,					"@E 9,999.99")   + Space(1)
	cStr1 += Tran(oRecePosi:nAberto, 	"@E 999,999.99")

	cStr2 := " ABERTO �� {"
	cStr2 += StrZero(nConta - oRecePosi:nQtdDoc,5)
	cStr2 += "}" + Space(12)
	cStr2 += Tran(nPrincipal-oRecePosi:nPrincipal, "@E 999,999.99") + Space(8)
	cStr2 += Tran(nJuros-oRecePosi:nJurosPago,	  "@E 999,999.99") + Space(1)
	cStr2 += Tran(nMulta,								  "@E 9,999.99")   + Space(1)
	cStr2 += Tran(nAberto,								  "@E 999,999.99")

	Aadd( aStr, cStr1)
	Aadd( aStr, cStr2)
RETURN(aStr)

Proc FichaAtendimento(cCaixa, cVendedor, xTodos, nCurElemento)
**************************************************************
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cScreen	 := SaveScreen()
LOCAL GetList	 := {}
LOCAL cVisita	 := Space(60)
LOCAL cObs		 := Space(60)
LOCAL cTitulo	 := "FICHA DE ATENDIMENTO/ATIVACAO"
		cCodi 	 := Space(05)

Area("Receber")
Receber->(Order( RECEBER_CODI))
WHILE OK
	oMenu:Limpa()

	IF xTodos = NIL
		dData   := Date()
		cHora   := Time()
		cVisita := AllTrim(cVisita) + Space(60-Len(AllTrim(cVisita)))
		cObs	  := AllTrim(cObs)	 + Space(60-Len(AllTrim(cObs)))
	Else
		cCodi   := xTodos[nCurElemento,1]
		dData   := xTodos[nCurElemento,2]
		cHora   := xTodos[nCurElemento,3]
		cVisita := Left(xTodos[nCurElemento,4],60)
	EndIF
	MaBox( 10, 00, 14, 80, 'IMPRESSAO ' +cTitulo )
	@ 11, 01 Say "Codigo Cliente..:" Get cCodi   Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi,, Row(), Col()+1)
	@ 12, 01 Say "Motivo Visita...:" Get cVisita Pict "@!" Valid !Empty(cVisita)
	@ 13, 01 Say "Observacoes.....:" Get cObs    Pict "@!"
	Read
	IF LastKey() = ESC
	  AreaAnt( Arq_Ant, Ind_Ant )
	  ResTela( cScreen )
	  Return
	EndIF
	IF Conf("Pergunta: Confirma Impressao ?")
		IF !Instru80() .OR. !LptOk()
			Loop
		EndIF
		cTela := Mensagem("Aguarde, Imprimindo Ficha.", Cor())
		PrintOn()
		FPrInt( Chr(ESC) + "C" + Chr( 33 ))
		SetPrc(0,0)
		nRow := 1
		cVisita := AllTrim(cVisita)
		cVisita += IF(Right(cVisita,1) = '.', ' ','. ')
		cObs	  := AllTrim(cObs)
		cObs	  += IF(Right(cObs,1) = '.', '','.')
		Write( nRow+00, 00, Repl("=",80))
		Write( nRow+01, 00, GD + Padc(AllTrim(oAmbiente:xFanta), 40) + CA )
		Write( nRow+02, 00, Padc( XENDEFIR + " - " + XCCIDA + " - " + XCESTA, 80 ))
		Write( nRow+03, 00, Repl("-",80))
		Write( nRow+04, 00, GD + Padc( cTitulo, 40) + CA )
		Write( nRow+06, 00, "DATA     : " + NG + Dtoc(dData) + NR)
		Write( nRow+06, 58, "HORA   : " + NG + cHora + NR)
		Write( nRow+07, 00, "NOME     : " + NG + Receber->Nome + NR )
		Write( nRow+07, 58, "FONE   : " + NG + Receber->Fone + NR )
		Write( nRow+08, 00, "ENDERECO : " + NG + Receber->Ende + NR )
		Write( nRow+08, 58, "BAIRRO : " + NG + Left(AllTrim(Receber->Bair),17) + NR )
		Write( nRow+09, 00, "CIDADE   : " + NG + Receber->Cida + NR )
		Write( nRow+09, 58, "FONE   : " + NG + Receber->Fax + NR )
		Write( nRow+11, 00, "MOTIVO VISITA : " + NG + cVisita + NR )
		Write( nRow+12, 00, "OBSERVACOES   : " + NG + cObs + NR )
		Write( nRow+14, 00, "FOI ATENDIDA RECLAMACAO ?: " + NG + "___________" + NR )
		Write( nRow+14, 48, "INTERNET FUNCIONANDO ?: " + NG + "___________" + NR )
		Write( nRow+16, 00, "NOME/ASSINATURA  : " + NG + Repl("_",60) + NR )
		Write( nRow+18, 00, "RELATORIO TECNICO: " + NG + Repl("_",60) + NR )
		Write( nRow+20, 00, "DATA ATIVACAO    : " + NG + Dtoc(Receber->Data) + NR)
		Write( nRow+20, 48, "ATENDIDO POR: " + NG + "_____________________" + NR )
		Write( nRow+21, 00, Repl("-",80))
		Write( nRow+22, 00, "O CLIENTE declara expressamente e garante, para todos os fins de direito, que as")
		Write( nRow+23, 00, "informacoes  aqui  prestadas sao  verdadeiras, e possui  capacidade  plena  pela")
		Write( nRow+24, 00, "utilizacao dos servicos prestados pela CONTRATADA.")
		Write( nRow+25, 00, Repl("=",80))
		Write( nRow+26, 00, "Impresso por: " + cCaixa + ' ' + cVendedor)
		__Eject()
		PrintOff()
		IF xTodos = NIL
			IF Agenda->(Incluiu())
				Agenda->Codi	 := cCodi
				Agenda->Data	 := dData
				Agenda->Hora	 := cHora
				Agenda->Hist	 := cVisita + cObs
				Agenda->Caixa	 := cCaixa
				Agenda->Usuario := cVendedor
				Agenda->(Libera())
			EndIF
		EndIF
	EndIF
EndDo
ResTela( cScreen )
AreaAnt( Arq_Ant, Ind_Ant )
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc PosiAgeInd( cCodi )
************************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL dCalculo := Date()
LOCAL cString	:= ""
LOCAL lPilha
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
LOCAL cFilter
FIELD Regiao
FIELD Vcto
FIELD Juro
FIELD Codi
FIELD Docnr
FIELD Emis
FIELD Vlr
PRIVA aCodi 	 := {}
PRIVA aTodos	 := {}
PRIVA xTodos	 := {}
PRIVA oRecePosi := TReceposi()

oAmbiente:lReceber   := FALSO
oRecePosi:aAtivo     := {}
oReceposi:aAtivoSwap := {}
oReceposi:aRecno     := {}
lPilha               := cCodi != NIL
WHILE OK
	oRecePosi:Resetar()
	dIni		:= Date()-30
	dFim		:= Date()
	dCalculo := Date()
	IF !lPilha
		oMenu:Limpa()
		cCodi 	:= Space(05)
		MaBox( 14, 45, 16, 75 )
		@ 15, 46 Say "Cliente......:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado( @cCodi )
		Read
		IF LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		EndIF
	EndIF
	Area("Agenda")
	Agenda->(Order( AGENDA_CODI_DATA ))
	IF Agenda->(!DbSeek( cCodi ))
		Nada()
		IF lPilha
			DbClearRel()
			ResTela( cScreen )
			Exit
		Else
			Loop
		EndIF
	EndIF
	oBloco  := {|| Field->Codi == cCodi }
	cFilter := 'Field->Codi == cCodi.'
	/*
	m6_SetFilter( oBloco, cFilter )
	Agenda->(DbGoTop())
	*/
   Col                  := 12
   aTodos               := {}
   xTodos               := {}
   aCodi                := {}
   oReceposi:aAtivo     := {}
   oReceposi:aAtivoSwap := {}
   oReceposi:aRecno     := {}
   nConta               := 0
   cTela                := Mensagem("Aguarde... ", Cor())
   Try Eval( oBloco ) .AND. !Eof() .AND. !Tecla_ESC()
		IF nConta > 4096
			Alerta("Erro: Impossivel mostrar mais do que 4096 registros.")
			Exit
		EndIF
		nConta++
		cSep		:= '|'
		cAgenda1 := Dtoc(Agenda->Data)
		cAgenda2 := Agenda->Usuario
		cAgenda3 := Agenda->Hist
		cString1 := StrZero( nConta, 3)
		cString1 += cSep
		cString1 += cAgenda1
		cString1 += cSep
		cString1 += Left(cAgenda2,6)
		cString1 += cSep
		cString1 += cAgenda3
		Aadd( oRecePosi:aAtivo, OK )
      Aadd( oRecePosi:aAtivoSwap, OK )
      Aadd( oRecePosi:aRecno, Agenda->(Recno()))
		Aadd( aCodi, cCodi )
		Aadd( aTodos, cString1 )
		Aadd( xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist})
		Agenda->(DbSkip(1))
	EndTry
	m6_SetFilter()
	ResTela( cTela )
	IF Len( aTodos ) > 0
		oReceposi:PosiAgeInd := OK
		oMenu:StatInf()
		MaBox( 00, 00, 06, 79 )
      oRecePosi:cTop := " # |DATA    |USER  |OBSERVACOES AGENDADA"
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))
		oReceposi:MaBox_()
		__Funcao( 0, 1, 1 )
		oRecePosi:aChoice_(aTodos, OK, "__Funcao" )
		oRecePosi:PosiAgeInd := FALSO
	EndIF
	ResTela( cScreen )
	IF lPilha
		//Return(AC_CONT)
		Return
	EndIF
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc PosiAgeAll()
*****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL cString	:= ""
LOCAL cAgenda1 := ""
LOCAL cAgenda2 := ""
LOCAL cAgenda3 := ""
LOCAL cCodi    := Space(05)
LOCAL dIni     := Date()-30
LOCAL dFim     := Date()
LOCAL cTela
LOCAL oBloco
FIELD Data
FIELD Codi
FIELD Hist
PRIVA aCodi 		 := {}
PRIVA aTodos		 := {}
PRIVA xTodos		 := {}
PRIVA oRecePosi	 := TReceposi()

oAmbiente:lReceber   := FALSO
oRecePosi:aAtivo     := {}
oRecePosi:aRecno     := {}
oReceposi:aAtivoSwap := {}

oMenu:Limpa()
WHILE OK
	oRecePosi:Resetar()
	MaBox( 15, 45, 18, 75 )
	@ 16, 46 Say "Data Inicial.:" Get dIni Pict "##/##/##"
	@ 17, 46 Say "Data Final...:" Get dFim Pict "##/##/##"
	Read
	IF LastKey() = ESC
		DbClearRel()
		ResTela( cScreen )
		Exit
	EndIF
	Receber->(Order( RECEBER_CODI ))
	Area("Agenda")
   nConta               := 0
   aTodos               := {}
   xTodos               := {}
   aCodi                := {}
   oRecePosi:aAtivo     := {}
   oRecePosi:aAtivoSwap := {}
   oRecePosi:aRecno     := {}
   oBloco               := {|| Agenda->Data >= dIni .AND. Agenda->Data <= dFim }
   cLast                := NIL
	Agenda->(Order( AGENDA_DATA_CODI ))
	Sx_SetScope( S_TOP, DateToStr(dIni))
	Sx_SetScope( S_BOTTOM, DateToStr(dFim))
	cTela  := Mensagem("Aguarde... Filtrando registros. ESC cancela.")
	Agenda->(DbGoTop())
	IF Sx_KeyCount() == 0
		Sx_ClrScope( S_TOP )
		Sx_ClrScope( S_BOTTOM )
		Nada()
		ResTela( cScreen )
		Loop
	EndIF
   While Eval( oBloco ) .AND. !Tecla_ESC()
		IF nConta > 4096
			Alerta("Erro: Impossivel mostrar mais do que 4096 registros.")
			Exit
		EndIF
		cCodi 	:= Agenda->Codi
		cSep		:= '|'
		cAgenda1 := Dtoc(Agenda->Data)
		cAgenda2 := Agenda->Usuario
		cAgenda3 := Agenda->Hist
		cString1 := StrZero( nConta, 3)
		cString1 += cSep
		cString1 += cAgenda1
		cString1 += cSep
		cString1 += Left(cAgenda2,6)
		cString1 += cSep
		cString1 += cAgenda3
		IF Agenda->Ultimo
			nConta++
			Aadd( aCodi, cCodi )
			Aadd( oRecePosi:aAtivo, OK )
         Aadd( oRecePosi:aAtivoSwap, OK )
         Aadd( oRecePosi:aRecno, Agenda->(Recno()))
			Aadd( aTodos, cString1 )
			Aadd( xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist})
      EndIF
      Agenda->(DbSkip(1))
	EndDo
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	ResTela( cTela )
	IF nConta = 0
		Nada()
		Loop
	EndIF
	IF Len(aTodos) > 0
		oReceposi:PosiAgeAll := OK
		oMenu:StatInf()
		MaBox( 00, 00, 06, 79 )
      oRecePosi:cTop := " # |DATA    |USER  |OBSERVACOES AGENDADA"
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))
		oReceposi:MaBox_()
		__Funcao( 0, 1, 1 )
		oRecePosi:aChoice_(aTodos, OK, "__Funcao" )
		oRecePosi:PosiAgeAll := FALSO
	EndIF
	ResTela( cScreen )
EndDo

*:---------------------------------------------------------------------------------------------------------------------------------

Proc PosiAgeReg()
*****************
LOCAL GetList	:= {}
LOCAL cScreen	:= SaveScreen()
LOCAL nConta	:= 0
LOCAL cString	:= ""
LOCAL cAgenda1 := ""
LOCAL cAgenda2 := ""
LOCAL cAgenda3 := ""
LOCAL cRegiao  := Space(2)
LOCAL dIni     := Date()-30
LOCAL dFim     := Date()
LOCAL cCodi
LOCAL cTela
LOCAL oBloco
LOCAL oBloco2
LOCAL oBloco3
FIELD Data
FIELD Codi
FIELD Hist
PRIVA aCodi 		 := {}
PRIVA aTodos		 := {}
PRIVA xTodos		 := {}
PRIVA oRecePosi	 := TReceposi()

oAmbiente:lReceber   := FALSO
oRecePosi:aAtivo     := {}
oReceposi:aAtivoSwap := {}
oReceposi:aRecno     := {}
lPilha               := cCodi != NIL

oMenu:Limpa()
WHILE OK
	oRecePosi:Resetar()
	MaBox( 15, 45, 19, 75 )
	@ 16, 46 Say "Regiao.......:" Get cRegiao Pict "99" Valid RegiaoErrada( @cRegiao )
	@ 17, 46 Say "Data Inicial.:" Get dIni    Pict "##/##/##"
	@ 18, 46 Say "Data Final...:" Get dFim    Pict "##/##/##"
	Read
	IF LastKey() = ESC
		DbClearRel()
		ResTela( cScreen )
		Exit
	EndIF
	Receber->(Order(RECEBER_REGIAO))
   IF Receber->(!DbSeek(cRegiao))
		Nada()
		ResTela( cScreen )
		Loop
	EndIF
   nConta               := 0
   aTodos               := {}
   xTodos               := {}
   aCodi                := {}
   oRecePosi:aAtivo     := {}
   oRecePosi:aAtivoSwap := {}
   oRecePosi:aRecno     := {}
   oBloco               := {|| Receber->Regiao = cRegiao }
   cLast                := NIL
   cTela                := Mensagem("Aguarde... Filtrando registros. ESC cancela.")
   While Eval(oBloco) .AND. !Tecla_ESC()
      cCodi := Receber->Codi
		Agenda->(Order(AGENDA_CODI_DATA))
      IF Agenda->(!DbSeek(cCodi))
			Receber->(DbSkip(1))
			Loop
		EndIF
      oBloco2 := {|| Agenda->Codi = cCodi }
      While Eval( oBloco2 ) .AND. !Tecla_ESC()
			IF nConta > 4096
				Alerta("Erro: Impossivel mostrar mais do que 4096 registros.")
				Exit
			EndIF
         oBloco3 := {|| Agenda->Data >= dIni .AND. Agenda->Data <= dFim}
         IF !(Eval(oBloco3))
            Agenda->(DbSkip(1))
            Loop
         EndIF
			cSep		:= '|'
			cAgenda1 := Dtoc(Agenda->Data)
			cAgenda2 := Agenda->Usuario
			cAgenda3 := Agenda->Hist
			cString1 := StrZero( nConta, 3)
			cString1 += cSep
			cString1 += cAgenda1
			cString1 += cSep
			cString1 += Left(cAgenda2,6)
			cString1 += cSep
			cString1 += cAgenda3
            nConta++
            Aadd( aCodi, cCodi )
            Aadd( oRecePosi:aAtivo, OK )
            Aadd( oRecePosi:aAtivoSwap, OK )
            Aadd( oRecePosi:aRecno, Agenda->(Recno()))
            Aadd( aTodos, cString1 )
            Aadd( xTodos, {cCodi, Agenda->Data, Agenda->Hora, Agenda->Hist})
            Agenda->(DbSkip(1))
		EndDo
		Receber->(DbSkip(1))
	EndDo
	Sx_ClrScope( S_TOP )
	Sx_ClrScope( S_BOTTOM )
	ResTela( cTela )
	IF nConta = 0
		Nada()
		Loop
	EndIF
	IF Len(aTodos) > 0
		oReceposi:PosiAgeAll := OK
		oMenu:StatInf()
		MaBox( 00, 00, 06, 79 )
      oRecePosi:cTop := " # |DATA    |USER  |OBSERVACOES AGENDADA"
		oRecePosi:cTop += Space( MaxCol() - Len( cString ))
		oReceposi:MaBox_()
		__Funcao( 0, 1, 1 )
		oRecePosi:aChoice_(aTodos, OK, "__Funcao" )
		oRecePosi:PosiAgeAll := FALSO
	EndIF
	ResTela( cScreen )
EndDo

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
LOCAL Ind_Recemov
LOCAL Ind_Recebido
LOCAL xSeek
LOCAL lCalcular
LOCAL cFatu
LOCAL cCodi
LOCAL nValorTotal
LOCAL nTotalGeral
LOCAL aCabec
LOCAL nJuros
LOCAL cTela
LOCAL oBloco
LOCAL oBloco2
LOCAL cRegiao
LOCAL dIni
LOCAL dFim
LOCAL Col
LOCAL xObs
LOCAL cStr
LOCAL xDataPag
LOCAL lMsg
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
oReceposi:aRecno      := {}
oReceposi:nQtdDoc 	 := 0

oMenu:Limpa()
Receber->(Order( RECEBER_CODI ))
Recemov->(DbGoTop())
IF Recemov->(Eof())
	Nada()
	ResTela( cScreen )
	Return
EndIF

IFNIL(cCodi,Space(05))
WHILE OK
	oRecePosi:Resetar()
   Do Case
	Case nChoice = 1
		IF xParam != NIL
			cCodi := xParam
         dFim := Ctod("31/12/" + Right(Dtoc(Date()),2))
			IF oAmbiente:Ano2000
            dIni := Ctod("01/01/80")
			Else
            dIni := Ctod("01/01/01")
			EndIF
		Else
         dIni     := Ctod("01/01/91")
         dFim     := Ctod("31/12/" + Right(Dtoc(Date()),2))
         dCalculo := Date()
			IF lRescisao
				cStr		:= "Data Rescisao:"
			Else
				cStr		:= "Calcular ate.:"
			EndIF
			MaBox( 14, 45, 19, 75 )
         @ 15, 46 Say "Cliente......:" Get cCodi    Pict PIC_RECEBER_CODI Valid RecErrado(@cCodi)
         @ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
         @ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
         @ 18, 46 Say cStr             Get dCalculo Pict "##/##/##"
			Read
			IF LastKey() = ESC
				DbClearRel()
				ResTela( cScreen )
				Exit
			EndIF
		EndIF
		Recebido->(Order(RECEBIDO_CODI))
		Recemov->(Order(RECEMOV_CODI))
		xSeek := cCodi
		IF Recemov->(!DbSeek(xSeek))
			IF Recebido->(!DbSeek(xSeek))
				Nada()
				IF xParam != NIL
					Exit
				Else
					Loop
				EndIF
			EndIF
		EndIF
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->Codi  = xSeek }
		oBloco2		 := {|| Recebido->Codi = xSeek }
		oReceposi:PosiReceber := OK

	Case nChoice = 2
		cRegiao	:= Space(02)
		dIni		:= Ctod("01/01/91")
		dFim		:= Ctod("31/12/" + Right(Dtoc(Date()),2))
		dCalculo := Date()
		MaBox( 14, 45, 19, 75 )
      @ 15, 46 Say "Regiao.......:" Get cRegiao  Pict "99" Valid RegiaoErrada( @cRegiao )
		@ 16, 46 Say "Data Inicial.:" Get dIni     Pict "##/##/##"
		@ 17, 46 Say "Data Final...:" Get dFim     Pict "##/##/##"
		@ 18, 46 Say "Calcular ate.:" Get dCalculo Pict "##/##/##"
		Read
		IF LastKey() = ESC
			DbClearRel()
			ResTela( cScreen )
			Exit
		EndIF
		Recebido->(Order(RECEBIDO_REGIAO))
		Recemov->(Order(RECEMOV_REGIAO))
		xSeek := cRegiao
		IF Recemov->(!DbSeek(xSeek))
			IF Recebido->(!DbSeek(xSeek))
				Nada()
				Loop
			EndIF
		EndIF
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco  := {|| Recemov->Regiao  = xSeek }
		oBloco2 := {|| Recebido->Regiao = xSeek }
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
		Recebido->(Order(RECEBIDO_VCTO))
		Recemov->(Order(RECEMOV_VCTO))
		xSeek := cRegiao
		IF Recemov->(!SeekData( dIni, dFim, "Vcto"))
			IF Recebido->(!SeekData( dIni, dFim, "Vcto"))
				Nada()
				Loop
			EndIF
		EndIF
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->Vcto >= dIni .AND. Recemov->Vcto <= dFim }
		oBloco2		 := {|| Recebido->Vcto >= dIni .AND. Recebido->Vcto <= dFim }
		Recemov->(Sx_SetScope(S_TOP, dIni))
		Recemov->(Sx_SetScope(S_BOTTOM, dFim))
		cTela  := Mensagem("Aguarde... Filtrando registros. ESC cancela.")
		Recemov->(DbGoTop())
		Recebido->(Sx_SetScope(S_TOP, dIni))
		Recebido->(Sx_SetScope(S_BOTTOM, dFim))
		Recebido->(DbGoTop())
		oReceposi:PosiReceber := OK

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
		Recebido->(Order(RECEBIDO_TIPO))
		Recemov->(Order(RECEMOV_TIPO))
		xSeek := cTipo
		IF Recemov->(!DbSeek(xSeek))
			IF Recebido->(!DbSeek(xSeek))
				Nada()
				Loop
			EndIF
		EndIF
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco  := {|| Recemov->Tipo = xSeek }
		oBloco2 := {|| Recebido->Tipo = xSeek }
		oReceposi:PosiReceber := FALSO

	Case nChoice = 5
		IF xParam != NIL
			cFatu := xParam
		Else
			cFatu := Space(7)
			MaBox( 14, 45, 16, 67 )
			@ 15, 46 Say "Fatura N�.:" Get cFatu Pict "@!" Valid VisualAchaFatura( @cFatu )
			Read
			IF LastKey() = ESC
				Recemov->(DbClearRel())
				Recemov->(DbGoTop())
				ResTela( cScreen )
				Exit
			EndIF
		EndIF
		Area("Recebido")
		Recebido->(Order( RECEBIDO_FATURA ))
		Ind_Recebido := Recebido->(IndexOrd())
		Area("Recemov")
		Recemov->(Order( RECEMOV_FATURA ))
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->Fatura = cFatu }
		oBloco2		 := {|| Recebido->Fatura = cFatu }
		xSeek 		 := cFatu
		IF Recemov->(!DbSeek(cFatu))
			IF Recebido->(!DbSeek(cFatu))
				Nada()
				IF xParam != NIL
					ResTela( cScreen )
					Exit
				Else
					Loop
				EndIF
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

		Recebido->(Order(RECEBIDO_CODI))
		Recebido->(DbGotop())
		Recemov->(Order(RECEMOV_CODI))
		IF Recemov->(Eof())
			IF Recebido->(Eof())
				Nada()
				Loop
			EndIF
		EndIF
		Ind_Recebido := Recebido->(IndexOrd())
		Ind_Recemov  := Recemov->(IndexOrd())
		oBloco		 := {|| Recemov->(!Eof()) }
		oBloco2		 := {|| Recebido->(!Eof()) }
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
   oReceposi:aRecno      := {}
   oReceposi:aAtivo      := {}
	oReceposi:aAtivoSwap  := {}
	oReceposi:aHistRecibo := {}
	oReceposi:aUserRecibo := {}
	oReceposi:nQtdDoc 	 := 0
	aCodi 		:= {}
	nConta		:= 0
	nRegPago 	:= 0
	xObs			:= Space(0)
	cTela 		:= Mensagem("Aguarde, Localizando registros em aberto", Cor())
	lCalcular	:= (dCalculo != Ctod("00/00/00")) // Nao calcular juros ou descontos
	dCalculo 	:= IF(!lCalcular, Date(), dCalculo)

	*-----RECEMOV.DBF------------------------------------------------------------
	IF nChoice != 3 .AND. nChoice != 6
		Area("Recemov")
		Recemov->(Order( Ind_Recemov ))
		Recemov->(DbSeek( xSeek ))
	EndIF
	WHILE Recemov->(Eval(oBloco))
		IF nConta >= 4094
			Alerta("Erro: Impossivel mostrar mais do que 4096 registros.")
			Exit
		EndIF
		xObs := Recemov->Obs
		Recibo->(Order(RECIBO_DOCNR))
		IF Recibo->(DbSeek( Recemov->Docnr ))
			xDataPag := Recibo->Data
			nRegPago++
		Else
			xDataPag := Ctod("31/12/2099") // Para fins de indexacao
			IF nChoice != 5 .AND. nChoice != 6
				IF Recemov->Vcto < dIni .OR. Recemov->Vcto > dFim
					Recemov->(DbSkip(1))
					Loop
				EndIF
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
		nAtraso := Atraso( dCalculo, Recemov->Vcto )
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
			nCarencia	:= Carencia( dCalculo, Recemov->Vcto )
		 //nMulta		:= VlrMulta( dCalculo, Recemov->Vcto, nVlr )
			nMulta		:= 0
			nDesconto	:= VlrDesconto( dCalculo, Recemov->Vcto, nVlr )
		 //nJurodia 	:= Jurodia( nVlr, Juro, XJURODIARIO )
			nJurodia 	:= Recemov->Jurodia
			nJuros		:= IF( nAtraso <= 0, 0, ( nCarencia * nJurodia ))
		EndIF

		nValorTotal += nVlr
		nTotalGeral += nVlr
		nTotalGeral += nJuros
		nTotalGeral += nMulta
		nTotalGeral -= nDesconto
		nSoma 		:= ((nVlr + nMulta ) + nJuros ) - nDesconto
		nMulta		:= VlrMulta( dCalculo, Recemov->Vcto, nSoma )
		nSoma 		+= nMulta
		nTotalGeral += nMulta
		nConta++
		lAtivo		:= OK

		Recemov->(Aadd( xTodos, { Docnr,;
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
							 Fatura,;
							 xDataPag,;
                      lAtivo,;
                      Recno()}))
		Recemov->(DbSkip(1))
	EndDo

	*-----RECEBIDO.DBF------------------------------------------------------------

	cTela := Mensagem("Aguarde, Localizando registros Recebidos")
	IF nChoice != 3 .AND. nChoice != 6
		Area("Recebido")
		Recebido->(Order( Ind_Recebido ))
		Recebido->(DbSeek( xSeek ))
	EndIF

	WHILE Recebido->(Eval(oBloco2))
		IF nConta >= 4095 // Tamanho Max. Array
			Alerta("Informa: Impossivel mostrar mais do que 4096 registros.")
			Exit
		EndIF
		/*
		IF nChoice != 5 .AND. nChoice != 6
			IF Recebido->Vcto < dIni .OR. Recebido->Vcto > dFim
				Recebido->(DbSkip(1))
				Loop
			EndIF
		EndIF
		*/
		cCodi 		:= Recebido->Codi
		nValorTotal += Recebido->Vlr
		nTotalGeral += Recebido->VlrPag
		lAtivo		:= FALSO

		Recebido->(Aadd( xTodos, { Docnr,;
							 Emis,;
							 Vcto,;
							 (DataPag-Vcto),;
							 Vlr,;
							 0,;
							 0,;
							 0,;
							 VlrPag,;
							 Codi,;
							 Obs,;
							 DateToStr(DataPag)+DateToStr(Vcto)+Docnr,;
							 DateToStr(Vcto)+Docnr,;
							 DateToStr(DataPag)+DateToStr(Vcto),;
							 Fatura,;
							 Datapag,;
                      lAtivo,;
                      Recno()}))
		nConta++
		Recebido->(DbSkip(1))
	EndDo

	*-----REGISTRO BRANCO--------------------------------------------------------

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
						Space(9),;
						cTod(""),;
                  OK,;
                  0}) // Incluir Registro vazio para cursor poder ir topo

	*-----END REGISTRO-----------------------------------------------------------

	ResTela( cTela )

	Recemov->(Sx_ClrScope(S_TOP))  ; Recemov->(Sx_ClrScope(S_BOTTOM))
	Recebido->(Sx_ClrScope(S_TOP)) ; Recebido->(Sx_ClrScope(S_BOTTOM))

	IF Len( xTodos ) > 0
		Mensagem('Informa: Aguarde, ordenando.')
		IF nChoice = 5
			Asort( xTodos,,, {|x,y|y[XTODOS_VCTO_DOCNR]			 > x[XTODOS_VCTO_DOCNR]})
		Else
			Asort( xTodos,,, {|x,y|y[XTODOS_DATAPAG_VCTO_DOCNR] > x[XTODOS_DATAPAG_VCTO_DOCNR]})
		EndIF
		alMulta					 := {}
      oReceposi:aRecno      := {}
      oReceposi:aAtivo      := {}
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
			Aadd( oReceposi:aAtivoSwap, xTodos[nT,XTODOS_ATIVO])
			Aadd( oReceposi:aAtivo, 	 xTodos[nT,XTODOS_ATIVO])
         Aadd( oReceposi:aRecno,     xTodos[nT,XTODOS_RECNO])
			Aadd( alMulta, (xTodos[nT,XTODOS_MULTA] <> 0)) // Multa?
         Aadd( aCodi,  xTodos[nT,XTODOS_CODI] )
			Aadd( aTodos, xTodos[nT,XTODOS_DOCNR] + " " + ;
							  Left( Dtoc( xTodos[nT,XTODOS_EMIS]),5 ) + " " + ;
							  Dtoc(xTodos[nT,XTODOS_VCTO]) + " " + ;
							  StrZero( xTodos[nT,XTODOS_ATRASO], 4) + " " + ;
							  Tran(xTodos[nT,XTODOS_VLR], "@E 99,999.99") + " " + ;
							  Tran(xTodos[nT,XTODOS_DESCONTO], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,XTODOS_JUROS], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,XTODOS_MULTA], "@E 9,999.99")  + " " + ;
							  Tran(xTodos[nT,XTODOS_SOMA], "@E 999,999.99"))

		Next
		IF oAmbiente:Mostrar_Recibo
			SeekLog(xTodos, aTodos)
		EndIF
		MaBox( 00, 00, 06, 79 )
		oMenu:StatInf()
      oReceposi:dIni        := dIni
      oReceposi:dFim        := dFim
      oReceposi:dCalculo    := dCalculo
      oReceposi:PosiReceber := OK
		oRecePosi:aBottom 	 := _SomaRecebido(xTodos, nConta, nValorTotal, nTotalGeral)
		oRecePosi:cTop 		 := " DOCTO N�  EMIS   VENCTO ATRA  ORIGINAL DESC/PAG    JUROS PG/MULTA     ABERTO     "
		oRecePosi:cTop 		 += Space( MaxCol() - Len(oRecePosi:cTop))
      //AltJrInd(1,NIL,aCodi[1],(lMsg := FALSO))
      oRecePosi:Redraw()
		__Funcao( 0, 1, 1 )
		SetColor(",,,,R+/")
		oRecePosi:aChoice_(aTodos, oRecePosi:aAtivo, "__Funcao" )
		SetColor(cColor)
		oReceposi:PosiReceber := FALSO
		xTodos					 := {}
	EndIF
	ResTela( cScreen )
	IF nChoice = 6 .OR. xParam != NIL
		Exit
	EndIF
EndDo

*===============================================================================

CLASSE TTReceposi
	VAR Who
	VAR cNome
	VAR aHistRecibo
	VAR aUserRecibo
	VAR aAtivo
	VAR aAtivoSwap
   VAR aRecno
	VAR cTop
	VAR aBottom
	VAR nBoxRow
	VAR nBoxCol
	VAR nBoxRow1
	VAR nBoxCol1
	VAR nPrtRow
	VAR nPrtCol
	VAR cPrtStr
	VAR nQtdDoc
	VAR nRecebido
	VAR nPrincipal
	VAR nJurosPago
	VAR nAberto
	VAR PosiAgeInd
	VAR PosiAgeAll
	VAR PosiReceber
   VAR dIni
   VAR dFim
   VAR dCalculo

	METHOD AddVar
	METHOD Resetar
	METHOD Achoice_
	METHOD MaBox_
	METHOD Print_
	METHOD Redraw
	METHOD Create = New
	METHOD Init   = New
	METHOD Hello
ENDCLASSE

METODO New(cWho)
	::Who 		  := cWho
	Self:cNome	  := "TTReceposi"
	::aHistRecibo := {}
	::aUserRecibo := {}
	::aAtivo 	  := {}
	::aAtivoSwap  := {}
   ::aRecno      := {}
	::cTop		  := ""
	::aBottom	  := {"",""}
	::nBoxRow	  := 7
	::nBoxCol	  := 0
	::nBoxRow1	  := MaxRow()-1
	::nBoxCol1	  := MaxCol()
	::nPrtRow	  := MaxRow()
	::nPrtCol	  := 0
	::nQtdDoc	  := 0
	::nRecebido   := 0
	::nPrincipal  := 0
	::nJurosPago  := 0
	::nAberto	  := 0
	::PosiAgeInd  := FALSO
	::PosiAgeAll  := FALSO
	::PosiReceber := FALSO
   ::dIni        := Ctod("01/01/91")
   ::dFim        := Ctod("31/12/" + Right(Dtoc(Date()),2))
   ::dCalculo    := Date()
RETURN Self

METODO Resetar()
	Self:Init()
RETURN Self

METODO aChoice_(aTodos, aAtivo, cFuncao)
	Achoice(::nBoxRow+1, ::nBoxCol+1, ::nBoxRow1-1, ::nBoxCol1-1, aTodos, aAtivo, cFuncao )
RETURN Self

METODO MaBox_()
	MaBox(::nBoxRow, ::nBoxCol, ::nBoxRow1, ::nBoxCol1, ::cTop)
RETURN Self

METODO Print_( nRow, nCol, aStr )
	::nPrtRow := nRow
	::nPrtCol := nCol
	::aBottom := aStr
	aPrint(::nPrtRow-1, ::nPrtCol, ::aBottom[1], Cor(), MaxCol())
	aPrint(::nPrtRow,   ::nPrtCol, ::aBottom[2], Cor(), MaxCol())
RETURN Self

METODO Redraw()
	::nBoxRow1--
	::MaBox_()
	::Print_(::nPrtRow, ::nPrtCol, ::aBottom)
RETURN Self

METODO Hello
  ? "Hello",Self:Who
  ? "Hello",::cNome
RETURN Self

METODO TReceposi(cWho)
Return(TTReceposi():Create(cWho))

*------------------------------------------------------------------------------

Function __Funcao( nMode, nCurElemento, nRowPos )
*************************************************
LOCAL cString		 := Space(0)
LOCAL cObs			 := Space(0)
LOCAL cObs1 		 := Space(0)
LOCAL nTamAtivo	 := Len(oRecePosi:aAtivo)
LOCAL lPilhaAgenda
LOCAL nPosFatura
FIELD UltCompra
FIELD Matraso
FIELD VlrCompra
STATIC lStack
#Define POS_OBS 11

/*
Achoice() Modes
0 AC_IDLE		 Idle
1 AC_HITTOP 	 Tentativa do cursor passar topo da lista
2 AC_HITBOTTOM  Tentativa do cursor passar fim da lista
3 AC_EXCEPT 	 Keystroke exceptions
4 AC_NOITEM 	 No selectable item

ACHOICE() User Function Return Values
---------------------------------------------------------------------
Value   Achoice.ch	  Action
---------------------------------------------------------------------
0		  AC_ABORT		  Abort selection
1		  AC_SELECT 	  Make selection
2		  AC_CONT		  Continue ACHOICE()
3		  AC_GOTO		  Go to the next item whose first character matches the key pressed
4		  AC_REDRAW
---------------------------------------------------------------------
*/

Do Case
Case nMode = AC_IDLE // 0
	cString := Space(0)
	IF lStack != NIL
      cString += 'MOSTRA INDIVIDUAL|'
	EndIF
	IF !oAmbiente:Mostrar_Desativados
      cString += 'FILTRO ATIVADO|'
	EndIF
	IF oAmbiente:Mostrar_Recibo
		IF oAmbiente:lReceber
         cString += 'RECIBO ATIVO[vm=encontrado]|'
		Else
         cString += 'RECIBO ATIVO[vm=NAO encontrado]|'
		EndIF
	EndIF
   cString += 'ESC RETORNA|'
   cString := 'SPC=FATURA|F2=TXJUR|' + cString
	StatusSup( cString, Cor(2))
	Receber->(Order( RECEBER_CODI ))
	IF Receber->(DbSeek( aCodi[ nCurElemento ]))
		nMaxCol := MaxCol()
		Write( 01, 01, aCodi[ nCurElemento] + " " + Receber->Nome )
		Write( 02, 01, Receber->Ende + " " + Receber->Bair )
		Write( 03, 01, Receber->Cep  + "/" + Receber->Cida + " " + Receber->Esta )
		Write( 04, 01, Receber->Obs  )
		Write( 05, 01, Receber->Obs1 )
		Write( 01, nMaxCol-28, "Inicio      : " + Dtoc( Receber->Data ))
		Write( 02, nMaxCol-28, "Telefone #1 : " + Receber->Fone )
		Write( 03, nMaxCol-28, "Telefone #2 : " + Receber->Fax )
		#IFDEF MICROBRAS
			IF !oRecePosi:PosiAgeInd
				IF !oReceposi:PosiAgeAll
					IF oRecePosi:aAtivo[nCurElemento] // Item ativado
						cColor := SetColor()
						SetColor("R+")
						Write( 04, 01, Space(nMaxCol-2))
						Write( 05, 01, Space(nMaxCol-2))
						cObs	  := Alltrim(xTodos[nCurElemento,POS_OBS])
						cObs1   := AllTrim(oReceposi:aUserRecibo[nCurElemento]) + '/'
						cObs1   += AllTrim(Left(oReceposi:aHistRecibo[nCurElemento],(nMaxCol-4)))
						Write( 04, 01, "{" + Left(cObs1,(nMaxCol-4)) + "}")
						IF Len( cObs ) != 0
							Write( 05, 01, "{" + Left(cObs,(nMaxCol-4)) + "}")
						Else
							cObs := Right(xTodos[nCurElemento,1],02)
							Write( 05, 01, "{" + cObs + "� PARCELA DE SERVICOS DE INTERNET.}")
						EndIF
						SetColor(cColor)
					EndIF
				EndIF
			EndIF
		#ENDIF
	Else
		Write( 01, 01, "***** CLIENTE NAO LOCALIZADO *****")
		Write( 01, nMaxCol-28, "Inicio      : " )
		Write( 02, nMaxCol-28, "Telefone #1 : " )
		Write( 03, nMaxCol-28, "Telefone #2 : " )
		Write( 04, nMaxCol-28, "Spc         : " )
	EndIF
	Return(AC_REDRAW)

Case nMode = AC_HITTOP
	Return(AC_CONT)

Case nMode = AC_HITBOTTOM
	Return(AC_CONT)

Case LastKey() = ESC
	Return(AC_ABORT)

Case LastKey() = K_CTRL_UP
	IF nCurElemento <= 1
		nCurElemento := 1
		Return(AC_CONT)
	EndIF
	IF !oRecePosi:aAtivo[--nCurElemento] // Item Desativado
		oRecePosi:aAtivo[nCurElemento] := OK
		KeyBoard(K_UP)
		Return(AC_REDRAW)
	EndIF
	Return(AC_CONT)

Case LastKey() = K_CTRL_DOWN
	IF nCurElemento >= nTamAtivo
		nCurElemento := nTamAtivo
		Return(AC_CONT)
	EndIF
	IF !oRecePosi:aAtivo[++nCurElemento] // Item Desativado
		oRecePosi:aAtivo[nCurElemento] := OK
		KeyBoard(K_DOWN)
		Return(AC_REDRAW)
	EndIF
	Return(AC_CONT)

Case LastKey() = K_CTRL_ENTER .AND. oReceposi:PosiAgeAll
	oReceposi:PosiAgeAll := FALSO
	PosiAgeInd( aCodi[ nCurElemento ])
	oReceposi:PosiAgeAll := OK
	Return(AC_CONT)

Case LastKey() = K_CTRL_ENTER .AND. oReceposi:PosiAgeInd
	/*
	IF lStack = NIL
		lStack := OK
		IF oReceposi:PosiAgeInd
			lPilhaAgenda := oReceposi:PosiAgeInd
			oReceposi:PosiAgeInd := !lPilhaAgenda
		EndiF
		FichaAtendimento( cCaixa, cVendedor, xTodos, nCurElemento)
		oReceposi:PosiAgeInd := lPilhaAgenda
		lStack := NIL
	Else
		Alerta("ERRO: Use ESC para retornar, apos escolha outro cliente.")
	EndIF
	Return(AC_CONT)
	*/

	FichaAtendimento( cCaixa, cVendedor, xTodos, nCurElemento)
	Return(AC_CONT)


Case LastKey() = K_CTRL_ENTER
		ReciboIndividual( cCaixa, NIL, NIL, xTodos[nCurElemento,9], xTodos[nCurElemento,1])
		Return(AC_CONT)

Case LastKey() = K_INS
		AgeCobranca( aCodi[ nCurElemento])
		Return(AC_CONT)

Case LastKey() = K_INS .AND. oReceposi:PosiAgeInd
		AgeCobranca( aCodi[ nCurElemento])
		Return(AC_CONT)

Case LastKey() = K_INS .AND. oReceposi:PosiAgeAll
		AgeCobranca( aCodi[ nCurElemento])
		Return(AC_CONT)

Case LastKey() = K_CTRL_INS
	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		AgeCobranca( aCodi[ nCurElemento])
		Return(AC_CONT)
	Else
		For x := 1 To nTamAtivo
			oRecePosi:aAtivo[x]		:= OK
		Next
		Return(AC_REDRAW)
	EndIF
	Return(AC_CONT)

Case LastKey() = K_CTRL_DEL
		For x := 1 To nTamAtivo
			oRecePosi:aAtivo[x] := oRecePosi:aAtivoSwap[x]
		Next
		Return(AC_REDRAW)
		Return(AC_CONT)

Case LastKey() = ENTER .AND. oReceposi:PosiAgeAll
	/*
	IF lStack = NIL
		lStack := OK
		IF oReceposi:PosiAgeAll
			lPilhaAgenda := oReceposi:PosiAgeAll
			oReceposi:PosiAgeAll := !lPilhaAgenda
		EndiF
		Receposi(1, aCodi[nCurElemento])
		oReceposi:PosiAgeAll := lPilhaAgenda
		lStack := NIL
	Else
		Alerta("ERRO: Use ESC para retornar, apos escolha outro cliente.")
	EndIF
	Return(AC_CONT)
	*/

	IF oReceposi:PosiReceber .AND. oReceposi:PosiAgeInd
		Return(AC_CONT)
	EndIF

	Receposi(1, aCodi[nCurElemento])
	Return(AC_CONT)

Case LastKey() = ENTER .AND. oReceposi:PosiAgeInd
	/*
	IF lStack = NIL
		lStack := OK
		IF oReceposi:PosiAgeInd
			lPilhaAgenda := oReceposi:PosiAgeInd
			oReceposi:PosiAgeInd := !lPilhaAgenda
		EndiF
		Receposi(1, aCodi[nCurElemento])
		oReceposi:PosiAgeInd := lPilhaAgenda
		lStack := NIL
	Else
		Alerta("ERRO: Use ESC para retornar, apos escolha outro cliente.")
	EndIF
	Return(AC_CONT)
	*/

	IF oReceposi:PosiReceber
		Return(AC_CONT)
	EndIF

	Receposi(1, aCodi[nCurElemento])
	Return(AC_CONT)

Case LastKey() = ENTER .AND. oReceposi:PosiReceber
	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		Return(AC_CONT)
	EndIF
	PosiAgeInd( aCodi[ nCurElemento ])
	Return(AC_CONT)

Case LastKey() = ENTER
	IF lStack = NIL
		lStack := OK
		Receposi(1, aCodi[nCurElemento])
		lStack := NIL
		oRecePosi:Redraw()
		Return(AC_REDRAW)
	Else
		Alerta("ERRO: ESC retornar, apos escolha outro cliente ou CTRL+ENTER imprimir.")
	EndIF
	Return(AC_CONT)

Case LastKey() = K_SPACE
	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		Return(AC_CONT)
	EndIF

	IF oReceposi:PosiReceber
		IF !oAmbiente:lK_Insert
			oAmbiente:lK_Insert := OK
			IF oAmbiente:lReceber  //Contas a Receber
				Receposi(5, xTodos[nCurElemento,nPosFatura := 15])
			Else						  // Contas recebidas
				Recepago(4, xTodos[nCurElemento,nPosFatura := 13])
			EndIF
			oAmbiente:lK_Insert := FALSO
		Else
			Alerta("INFO: Novamente? rsrs - Use ESC para retornar.")
		EndIF
	EndIF
	Return(AC_REDRAW)

Case LastKey() = F6
	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		Return(AC_CONT)
	EndIF

	IF oReceposi:PosiReceber
		aMenu := {"Ordem DATAPAG_VCTO_DOCNR",;
					 "Ordem VCTO_DOCNR",;
					 "Ordem DATAPAG_VCTO"}
		M_Title("ESCOLHA A ORDEM DE MOSTRA")
		nOp := FazMenu( 10,10, aMenu, Cor())
		Do Case
		Case nOp = 0
			Return(AC_CONT)
		Case nOp = 1
			Asort( xTodos,,, {|x,y|x[13] < y[12]}) // VCTO_DOCNR
		Case nOp = 2
			Asort( xTodos,,, {|x,y|x[13] < y[13]}) // VCTO_DOCNR
		Case nOp = 3
			Asort( xTodos,,, {|x,y|x[13] < y[14]}) // VCTO_DOCNR
		EndCase
	EndIF
		Return(AC_REDRAW)

Case LastKey() = F2
	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
		Return(AC_CONT)
	EndIF

	IF oReceposi:PosiReceber
      IF AltJrInd(1,NIL, aCodi[nCurElemento])
         Receposi(1, aCodi[nCurElemento])
         oRecePosi:Redraw()
         Return(AC_REDRAW)
      EndIF
   EndIF
	Return(AC_CONT)

Case LastKey() = K_DEL
	IF oReceposi:PosiReceber
		Return(AC_CONT)
	EndIF

	IF oReceposi:PosiAgeInd .OR. oReceposi:PosiAgeAll
      IF !PodeExcluir()
         nNivel = SCI_EXCLUSAO_DE_REGISTROS
         IF !PedePermissao(nNivel)
            Return(AC_CONT)
         EndIF
      EndIF
      IF Conf("Pergunta: Deletar registro?")
         Agenda->(DbGoto(oReceposi:aRecno[nCurElemento]))
         IF Agenda->(TravaReg())
            Agenda->(DbDelete())
         EndIF

         Agenda->(Libera())
         Adel(aTodos, nCurElemento)
         Adel(xTodos, nCurElemento)
         Adel(aCodi,  nCurElemento)
         Adel(oReceposi:aAtivo, nCurElemento)
         Adel(oReceposi:aAtivoSwap, nCurElemento)
         Adel(oReceposi:aRecno, nCurElemento)
         Return(AC_REDRAW)
      Else
         Alerta("EVILI nao quer deletar!")
      EndIF
   EndIF
	Return(AC_CONT)

OtherWise
	Return(AC_CONT)

EndCase

//******************************************************************************

Function aStrPos(string, delims)
********************************
LOCAL nConta  := StrCount(delims, string)	
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl("%",nLen)
LOCAL aNum    := {}
LOCAL x

IF cChar == delims
   cChar := Repl("*",delims)
EndIF	

IF nConta = 0
   Return(aNum)
EndIF

FOR x := 1 To nConta 
   nPos   := At( Delims, string )
	string := Stuff(string, nPos, 1, cChar)
	Aadd( aNum, nPos)
Next
Aadd( aNum, Len(string)+1)
Return(aNum)

//******************************************************************************

Function StrExtract( string, delims, ocurrence )
************************************************
LOCAL nInicio := 1
LOCAL nConta  := StrCount(delims, string)
LOCAL aArray  := {}
LOCAL aNum    := {}
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl('%',nLen)
LOCAL cNewStr := String
LOCAL nPosIni := 1
LOCAL aPos
LOCAL nFim
LOCAL x
LOCAL nPos

IF cChar == delims
   cChar := Repl("*",nLen)
EndIF	

IF nConta = 0
   Return NIL
EndIF

/*
For x := 1 to nConta
   nInicio   := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nInicio, 1, cChar)
	nFim      := At( Delims, cNewStr)
	cString   := SubStr(cNewStr, nInicio+1, nFim-nInicio-1)
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

/*
For x := 1 to nConta
   nPos      := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nPos, 1, cChar)
	nLen      := nPos-nPosini
	cString   := SubStr(cNewStr, nPosIni, nLen)
	nFim      := At( Delims, cNewStr)
	nPosIni   := nPos+1
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

aPos   := aStrPos(string, Delims)
nConta := Len(aPos)
For x := 1 to nConta 
   nInicio  := aPos[x]
	IF x = 1
	   cString   := Left(String, nInicio-1)
	Else
		nFim     := aPos[x-1]
	   cString  := SubStr(String, nFim+1, nInicio-nFim-1)
	EndIF	
	Aadd( aArray, cString)
Next

nConta := Len(aArray)
IF ocurrence > nConta .OR. oCurrence = 0
   Return NIL
EndIF

Return(aArray[ocurrence])

Function ColorStandard(nStd)
****************************
STATI nStandard
LOCAL nSwap := nStandard
	
	if (ISNIL(nStd))
      return nStandard
   else
      nStandard := nStd
   endif
   return nSwap

//******************************************************************************

Function ColorEnhanced(nEnh)
****************************
STATI nEnhanced
LOCAL nSwap := nEnhanced
	
	if (ISNIL(nEnh))
      return nEnhanced
   else
      nEnhanced := nEnh
   endif
   return nSwap

//******************************************************************************
		
Function ColorUnselected(nUns)
****************************
STATI nUnselected
LOCAL nSwap := nUnselected
	
	if (ISNIL(nUns))
      return nUnselected
   else
      nUnselected := nUns
   endif
   return nSwap

//******************************************************************************

Function StrSwap( string, cChar, nPos, cSwap)
*********************************************
	LOCAL nConta := StrCount( cChar, string ),;
	      aPos,;
	      nX,;
			nLen
	
	IF nConta > 0
      aPos := aStrPos(string, cChar)
		nLen := Len(aPos)
		IF nLen >= 0
		   IF nPos <= nLen
		      string := Stuff(string, aPos[nPos], Len(cChar), cSwap)
		   EndIF
		EndIF	
	EndIF
return( string)