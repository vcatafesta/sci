/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 Ý³																								 ³
 Ý³	Programa.....: SCPLAN.PRG															 ³
 Ý³	Aplicacaoo...: SISTEMA DE CONTROLE DE PRODUCAO								 ³
 Ý³   Versao.......: 3.3.00                                                 ³
 Ý³	Programador..: Vilmar Catafesta													 ³
 Ý³	Empresa......: Macrosoft Sistemas de Informatica Ltda 					 ³
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ³
 Ý³	Ult.Atual....: 06 de Dezembro de 1998. 										 ³
 Ý³	Compilacao...: Clipper 5.02														 ³
 Ý³	Linker.......: Blinker 3.20														 ³
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "Lista.Ch"
#Include "Directry.Ch"
#Include "Inkey.Ch"
#Include "Indice.Ch"
#Include "Permissao.Ch"
#Include "Rddname.Ch"
*:----------------------------------------------------------------------------
#Define	SIMNAO  {" Sim ", " Nao "}
#Define	_TOPO   10
#Define	_ESQ	  10
*:----------------------------------------------------------------------------
LOCAL lOk	  := OK
LOCAL Op 	  := 1
*:==================================================================================================================================
SetKey( F1, 		  {|| Calc()})
SetKey( F8, 		  {|| AcionaSpooler()})
SetKey( TECLA_ALTC, {|| Altc() })

AbreArea()
oMenu:Limpa()
*:==================================================================================================================================
Op := 1
SetaClasse()
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
			FuncInc()
		Case Op = 2.02
			BrowseFuncionario()
		Case Op = 2.03
			BrowseFuncionario()
		Case Op = 2.04
			BrowseFuncionario()
		Case Op = 2.05
			RolFuncionario()
		Case Op = 3.01
			GrpSerInc()
		Case Op = 3.02
			GrpSerAlt()
		Case Op = 3.03
			GrpSerAlt()
		Case Op = 3.04
			GrpSerAlt()
		Case Op = 3.05
			GrpSerPri()
		Case Op = 4.01
			IncServico()
		Case Op = 4.02
			BrowseServico()
		Case Op = 4.03
			BrowseServico()
		Case Op = 4.04
			BrowseServico()
		Case Op = 4.05
			ProduRel2()
		Case Op = 5.01
			Produ31()
		Case Op = 5.02
			Produ32("ALTERACAO DA PRODUCAO")
		Case Op = 5.03
			Produ32("EXCLUSAO DA PRODUCAO")
		Case Op = 5.04
			Produ64()
		Case Op = 5.05
			PrintProducao()
		Case Op = 6.01
			Produ51()
		Case Op = 6.02
			Produ52("ALTERACAO DE MOVIMENTO")
		Case Op = 6.03
			Produ52("EXCLUSAO DE MOVIMENTO")
		Case Op = 6.04
			Produ65()
		Case Op = 6.05
			ProduRel4()
		Case Op = 7.01
			RolFuncionario()
		Case Op = 7.02
			ProduRel2()
		Case Op = 7.03
			PrintProducao()
		Case Op = 7.04
			ProduRel4()
		Case Op = 7.05
			Adiantamentos()
		Case Op = 7.06
			TotalMovi()
		Case Op = 7.07
			SaldoFunc()
		Case Op = 7.08
			Recibofuncionario()
		Case Op = 7.09
			GrpSerPri()
		Case Op = 8.01
			BrowseFuncionario()
		Case Op = 8.02
			BrowseServico()
		Case Op = 8.03
			Produ64()
		Case Op = 8.04
			Produ65()
		Case Op = 8.05
			ScpSaldo()
		Case Op = 8.06
			AdianConsu()
		Case Op = 8.07
			GrpSerAlt()
		Case Op = 9.01
			AdianAdian()
		Case Op = 9.02
			FechaMes()
		Case Op = 9.03
			FechaDebito()
		Case Op = 9.04
			AjusTabInd()
		Case Op = 9.05
			AjusTabGer()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde... Fechando Arquivos.", WARNING, _LIN_MSG )
FechaTudo()
Return

STATIC Proc SetaClasse()
************************
oMenu:Menu		 := oMenuScpLan()
oMenu:Disp      := aDispScpLan()
oMenu:StatusSup := SISTEM_NA7 + " " + SISTEM_VERSAO
oMenu:StatusInf := "F1-HELPºF10-CALCºF8-SPOOLºESC-RETORNAº"
Return

Proc ProduRel2()
****************
LOCAL GetList  := {}
LOCAL cScreen  := SaveScreen()
LOCAL nChoice  := 1
LOCAL aMenu    := {"Individual", "Geral"}
LOCAL cCodi
LOCAL oBloco
FIELD CodiSer

WHILE OK
   oMenu:Limpa()
	M_Title("RELATORIO DE SERVICOS" )
   nChoice := FazMenu( 07, 16, aMenu )
	Do Case
   Case nChoice = 0
		ResTela( cScreen )
		Exit

   Case nChoice = 1
		Area("Servico")
      Servico->(Order( SERVICO_CODISER ))
		MaBox( 15, 10, 17, 26 )
		cCodi := Space( 02 )
		@ 16, 11 Say "Codigo..:" Get cCodi Pict "9999" Valid SerErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Exit
      EndIF
      Servico->(Order( SERVICO_CODISER ))
      oBloco := {|| Codiser = cCodi }
      IF Servico->(!DbSeek( cCodi ))
         Nada()
         Loop
      EndIF
      RelProdu2( oBloco )

   Case nChoice = 2
		Area("Servico")
      Servico->(Order( SERVICO_NOME ))
		Servico->(DbGoTop())
      oBloco := {|| !Eof() }
      RelProdu2( oBloco )

	EndCase
EndDo

Proc ProduRel4()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL aMenu   := {"Individual", "Geral "}
LOCAL nChoice := 1
LOCAL oBloco1
LOCAL oBloco2
LOCAL cNome
LOCAL cCodi
LOCAL dIni
LOCAL dFim
FIELD CodiFun
FIELD Data

WHILE OK
   oMenu:Limpa()
	M_Title("RELATORIO DE MOVIMENTO")
   nChoice := FazMenu( 07, 16, aMenu )
	Do Case
   Case nChoice = 0
		ResTela( cScreen )
      Return

   Case nChoice = 1
		cCodi := Space( 04 )
      dIni  := Date() - 30
      dFim  := Date()
      MaBox( 14, 16, 18, 43 )
      @ 15, 17 Say "Codigo.........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
      @ 16, 17 Say "Data Inicial...:" Get dIni  Pict "##/##/##"
      @ 17, 17 Say "Data Final.....:" Get dFim  Pict "##/##/##"
		Read
      IF LastKey() = ESC
			Loop
		EndIF
      Funciona->(Order( FUNCIONA_CODIFUN ))
      Servico->(Order( SERVICO_CODISER ))
      Area( "Movi")
      Set Rela To Movi->CodiFun Into Funciona, Movi->CodiSer Into Servico
      Movi->(Order( MOVI_CODIFUN ))
      oBloco1 := {|| Movi->CodiFun = cCodi }
      oBloco2 := {|| Movi->Data >= dIni .AND. Movi->Data <= dFim }
      IF Movi->(!DbSeek( cCodi ))
         Nada()
         Loop
      EndIF
      RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
      Movi->(DbClearRel())
      Movi->(DbGoTop())

   Case nChoice = 2
      dIni  := Date() - 30
      dFim  := Date()
      MaBox( 14, 16, 17, 43 )
      @ 15, 17 Say "Data Inicial...:" Get dIni  Pict "##/##/##"
      @ 16, 17 Say "Data Final.....:" Get dFim  Pict "##/##/##"
		Read
      IF LastKey() = ESC
			Loop
		EndIF
      Funciona->(Order( FUNCIONA_CODIFUN ))
      Servico->(Order( SERVICO_CODISER ))
      Area( "Movi")
      Set Rela To Movi->CodiFun Into Funciona, Movi->CodiSer Into Servico
      Movi->(Order( MOVI_CODIFUN ))
      oBloco1 := {|| !Eof() }
      oBloco2 := {|| Movi->Data >= dIni .AND. Movi->Data <= dFim }
      Movi->(DbGoTop())
      RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
      Movi->(DbClearRel())
      Movi->(DbGoTop())

	EndCase
EndDo

Proc RelaProdu1( dIni, dFim, oBloco1, oBloco2 )
***********************************************
LOCAL cScreen    := SaveScreen()
LOCAL nCop       := 1
LOCAL Tam        := 80
LOCAL Col        := 58
LOCAL Pagina     := 0
LOCAL NovoCodi   := OK
LOCAL UltCodi    := CodiFun
LOCAL UltTabela  := Left( Tabela, 4 )
LOCAL NovaTabela := OK
LOCAL i          := 0
LOCAL nQtdPecas  := 0
LOCAL nTotalVlr  := 0
LOCAL nTotalPcs  := 0
LOCAL nDecisao   := 0
LOCAL nTotalTab  := 0
LOCAL lSair      := FALSO
FIELD CodiFun
FIELD CodiSer
FIELD Tabela

IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco1 ) .AND. Rel_Ok()
   IF !Eval( oBloco2 )
      Movi->(DbSkip(1))
      Loop
   EndIF
	IF Col >=  58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
      Write( 04, 00, Padc( 'RELATORIO DE MOVIMENTO REF. ' + Dtoc( dIni ) + ' A  ' + dToc( dFim ), Tam ))
		Write( 05, 00, Repl( SEP, Tam ) )
		Col := 6
   EndIF
	IF Col = 6 .OR. NovoCodi
		Write(	Col, 00, Chr( 27 ) + "E" + "FUNCIONARIO..: " + CodiFun + " " + Funciona->Nome + Chr( 27 ) + "F" )
		Write( ++Col, 00, Repl( SEP, Tam ) )
		Write( ++Col, 00,"DATA     TAB SER             QUANT          UNITARIO             TOTAL")
		Write( ++Col, 00, Repl( SEP, Tam ) )
		Col++
   EndIF
	IF NovoCodi
		NovoCodi := FALSO
	EndIf
	Qout( Dtoc( Data), Left( Tabela, 4 ), Right( Tabela, 2), Space(08), Qtd, ;
					Servico->( TransForm( Valor, "@E 9,999,999,999.999")), ;
					Servico->( TransForm( Valor * Movi->Qtd, "@E 9,999,999,999.999")))
	Col++
	UltCodi	 := CodiFun
	UltTabela := Left(Tabela, 4 )
	nQtdPecas += Qtd
	nTotalpcs += Qtd
	nTotalVlr += Servico->Valor * Qtd
	nTotalTab += Servico->Valor * Qtd
   Movi->(DbSkip(1))
   IF Col = 56 .OR. UltCodi != CodiFun
		IF UltCodi	 != CodiFun
			NovoCodi  := OK
			nQtdPecas := 0
			nTotalVlr := 0
         Write( ++Col, 00,"** Total Funcionario ** " + Str( nTotalPcs, 7 ) + Space(22) + TransForm( nTotalTab, "@E 9,999,999,999.999" ) )
			Write( ++Col, 00, Repl("-", Tam ))
			nTotalTab := 0
			nTotalpcs := 0
			Col += 2
         __Eject()
		EndIf
	EndIF
EndDo
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc Produ64()
**************
LOCAL GetList	 := {}
LOCAL aMenuArray := {" Consultar Por Tabela ", " Consultar Geral " }
LOCAL cScreen	  := SaveScreen()
LOCAL MouseList  := {}
LOCAL nChoice	  := 1
LOCAL cTabela, nItens
FIELD Tabela

WHILE OK
	 M_Title("PRODUCAO")
	 nChoice := FazMenu( 07, 16, aMenuArray, Cor())
	 Do Case
	 Case nChoice = 0
		 ResTela( cScreen )
		 Exit

	 Case nChoice = 1
		  Area("Cortes")
        Cortes->(Order( CORTES_TABELA ))
        Cortes->(DbGotop())
		  cTabela := Space( 04 )
		  MaBox( 14, 16, 16, 38 )
		  @ 15, 17 Say "Tabela........:" Get cTabela Pict "9999"
		  Read
		  IF ( LastKey() = 27 )
			  ResTela( cScreen )
			  Loop

		  EndIF
		  Mensagem( "Aguarde... Filtrando.", Cor(), 15 )
		  IF !(DbSeek( cTabela ) )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alerta( "Erro: Tabela Nao Encontrada...")
			  ResTela( cScreen )
			  Loop
		  EndIF
		  nReg := Recno()
		  bBloco := {|| Left( Tabela, 4 ) = cTabela }
		  nCampos := FCount()
		  cTemp	 := StrTran( Time(), ":")
		  Copy Stru To ( cTemp )
		  Use ( cTemp ) Alias cTemp Exclusive New
        Area('Cortes')
        Cortes->(Order( CORTES_TABELA ))
		  DbGoTo( nReg )
		  WHILE Eval( bBloco )
			  cTemp->( DbAppend())
			  For nX := 1 To nCampos
				  cCampo := Field( nX )
				  cMacro := &( Field( nX ) )
				  cTemp->&cCampo := cMacro
			  Next nX
			  DbSkip( 1 )
		  Enddo
		  Sele cTemp
		  Count To nItens
		  IF ( nItens = 0 )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alerta( "Erro: Nenhum Registro Disponivel...")
		  Else
			  DbGoTop()
			  Produ64DbEdit()
		  EndIF
		  cTemp->( DbCloseArea())
		  Ferase( ( cTemp ) + ".DBF" )
		  ResTela( cScreen )

	 Case nChoice = 2
		 Area("Cortes")
		 DbGoTop()
		 IF Cortes->(Eof())
			 oMenu:Limpa()
			 ErrorBeep()
			 Alerta( "Erro: Nenhum Registro Disponivel...")
		 Else
			 Produ64DbEdit()
		 EndIF
	 Endcase
EndDo

Proc Produ64Dbedit()
*********************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL Vetor3
LOCAL Vetor4
LOCAL nQuant
LOCAL nSobra
FIELD Qtd
FIELD Sobra
FIELD Data
FIELD Tabela

oMenu:Limpa()
nRegistros := LasTrec()
nQuant	  := 0
nSobra	  := 0
Lista->(Order( LISTA_CODIGO ))
Servico->(Order( SERVICO_CODISER ))
Set Rela To CodiSer Into Servico, Codigo Into Lista
DbGoTop()
Mensagem( "Aguarde... Somando !", Cor())
While !Eof()
	nQuant += Qtd
	nSobra += Sobra
	DbSkip(1)
EndDo
Order(1)
DbGoTop()
Vetor3 := { "Data" , "Tabela" , "qtd", "Sobra" }
Vetor4 := { "DATA" , "CODIGO.SER" , "QUANT", "SOBRA" }
MaBox( 20, 00, MaxRow(), MaxCol(), "CONSULTA DE PRODUCAO" )
Write( 21, 10, "Totais....: " )
Write( 21, 42, TransForm( nQuant, "999999999" ) + TransForm( nSobra, "999999999" ))
DbGoTop()
MaBox( 01, 00, 19, MaxCol(), "CONSULTA DE PRODUCAO" )
Seta1(19)
DbEdit( 02, 01, 18, MaxCol()-1, Vetor3, "Func64", OK, Vetor4 )
DbClearRel()
DbClearFilter()
DbGoTop()
ResTela( cScreen )
Return

Func Func64( Mode )
*******************
FIELD CodiSer
FIELD CodiFun

Do Case
Case Mode = 0
	Write( 22, 10, "Produto...: " + Codigo  + " " + Lista->Descricao )
	Write( 23, 10, "Servico...: " + CodiSer + "     " + Servico->Nome )
	Return( 1 )

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	Return( 1 )

Case LastKey() = 27
	Return( 0 )

OtherWise
	Return( 1 )

EndCase


Proc Produ65()
**************
LOCAL GetList	 := {}
LOCAL aMenuArray := {" Consultar Por Codigo ", " Consultar Por Tabela ", " Consultar Geral " }
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL nChoice	 := 1
LOCAL cCodi, nItens, cTabela
FIELD CodiFun, Tabela

WHILE OK
	M_Title("MOVIMENTO")
	nChoice := FazMenu( 07, 16, aMenuArray, Cor())
	Do Case
	Case nChoice = 0
	  ResTela( cScreen )
	  Exit

	 Case nChoice = 1
		  Area("Funciona")
        Funciona->(Order( FUNCIONA_CODIFUN ))
		  cCodi := Space( 04 )
		  MaBox( 14, 16, 16, 38 )
		  @ 15, 17 Say "Codigo........:" Get cCodi Pict "9999" Valid FunciErrado( @cCodi )
		  Read
		  IF LastKey() = ESC
			  ResTela( cScreen )
			  Loop
		  EndIF
		  Area("Movi")
        Movi->(Order( MOVI_CODIFUN ))
		  DbGoTop()
		  Mensagem("Aguarde... Filtrando.", Cor(), 15 )
		  IF !(DbSeek( cCodi ) )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alerta( "Erro: Nenhum Movimento Deste Funcionario...")
			  ResTela( cScreen )
			  Loop
		  EndIF
		  nReg := Recno()
		  bBloco := {|| CodiFun = cCodi }
		  nCampos := FCount()
		  Copy Stru To Temp
		  Use Temp New
        Area('Movi')
        Movi->(Order( MOVI_CODIFUN ))
		  DbGoTo( nReg )
		  WHILE Eval( bBloco )
			  Temp->( DbAppend())
			  For nX := 1 To nCampos
				  cCampo := Field( nX )
				  cMacro := &( Field( nX ) )
				  Temp->&cCampo := cMacro
			  Next nX
			  DbSkip( 1 )
		  Enddo
		  Sele Temp
		  DbGoTop()
		  Produ65DbEdit()
		  Temp->( DbCloseArea())
		  Ferase("Temp.Dbf")
		  ResTela( cScreen )

	 Case nChoice = 2
		  cTabela := Space( 04 )
		  MaBox( 14, 16, 16, 38 )
		  @ 15, 17 Say "Tabela........:" Get cTabela Pict "9999"
		  Read
		  IF LastKey() = ESC
			  ResTela( cScreen )
			  Loop
		  EndIF
		  Area("Movi")
        Movi->(Order( MOVI_TABELA ))
		  DbGoTop()
		  Mensagem("Aguarde... Filtrando.", Cor(), 15 )
		  IF !(DbSeek( cTabela ) )
			  oMenu:Limpa()
			  ErrorBeep()
			  Alerta( "Erro: Nenhum Movimento Desta Tabela...")
			  ResTela( cScreen )
			  Loop
		  EndIF
		  nReg := Recno()
		  bBloco := {|| Left( Tabela, 4 ) = cTabela }
		  nCampos := FCount()
		  Copy Stru To Temp
		  Use Temp New
        Area("Movi")
        Movi->(Order( MOVI_TABELA ))
		  DbGoTo( nReg )
		  WHILE Eval( bBloco )
			  Temp->( DbAppend())
			  For nX := 1 To nCampos
				  cCampo := Field( nX )
				  cMacro := &( Field( nX ) )
				  Temp->&cCampo := cMacro
			  Next nX
			  DbSkip( 1 )
		  Enddo
		  Sele Temp
		  DbGoTop()
		  Produ65DbEdit()
		  Temp->( DbCloseArea())
		  Ferase("Temp.Dbf")
		  ResTela( cScreen )

	 Case nChoice = 3
		 Area("Movi")
		 Movi->(DbGoTop())
		 IF Movi->(Eof())
			 oMenu:Limpa()
			 ErrorBeep()
			 Alerta( "Erro: Nenhum Movimento Desta Tabela...")
		 Else
			 Produ65DbEdit()
		 EndIF
	 Endcase
EndDo

Proc Produ65Dbedit( cTabela )
*****************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Vetor3
LOCAL Vetor4
FIELD CodiSer
FIELD CodiFun
FIELD Data
FIELD Tabela
FIELD Qtd

IF cTabela != NIL
	Area("Movi")
   Movi->(Order( MOVI_TABELA ))
   Set Filter To Tabela = cTabela
	DbGoTop()
EndIF
oMenu:Limpa()
Lista->(Order( LISTA_CODIGO ))
Funciona->(Order( FUNCIONA_CODIFUN ))
Servico->(Order( SERVICO_CODISER ))
Set Rela To CodiSer Into Servico, CodiFun Into Funciona, Codigo Into Lista
Movi->(Order( MOVI_TABELA ))
Movi->(DbGoTop())
Vetor3 := { "Data" , "Tabela" , "qtd", "CodiFun","CodiSer", "Tran( Qtd * Servico->Valor, '@E 999,999.999')" }
Vetor4 := { "DATA" , "TABELA.SER" , "QUANT", "FUNC","SERVICO","TOTAL"}
MaBox( 19, 00, 23, MaxCol(), "FUNCIONARIOS/PRODUTOS/SERVICOS" )
MaBox( 02, 00, 18, MaxCol(), "CONSULTA DO MOVIMENTO" )
Seta1(18)
DbEdit( 03, 01, 17, MaxCol()-1, Vetor3, "Func65", OK, Vetor4 )
DbClearRel()
DbClearFilter()
DbGoTop()
ResTela( cScreen )
Return

Func Func65( Mode )
*******************
FIELD CodiSer, CodiFun

Do Case
Case Mode = 0
	Write( 20, 03, Codigo + " " + Lista->Descricao )
	Write( 21, 03, CodiFun + "   " + Funciona->Nome )
	Write( 22, 03, CodiSer + "     " + Servico->Nome )
	Return( 1 )

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	Return( 1 )

Case LastKey() = 27
	Return( 0 )

OtherWise
	Return( 1 )

EndCase

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
FIELD CodiFun
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

Function Verifica_Sobra( nQtd, nRegCortes, nQuantAnt )
******************************************************
LOCAL nSobrando

Cortes->(DbGoTo( nRegCortes ) )
nSobrando := ( nQuantAnt + Cortes->Sobra )
IF ( nQtd > nSobrando )
	ErrorBeep()
	nSobrando := AllTrim( Str( nSobrando ) )
	Alerta( "Erro: Quantidade disponivel e " + nSobrando )
	Return( FALSO )

EndIF
Return(OK)

Proc MoviProx( cCabecalho )
**************************
LOCAL GetList	 := {}
FIELD Tabela, CodiFun, CodiSer
FIELD Qtd, Data

MaBox( 09, 10, 15, 65, cCabecalho )
Write( 10, 11 , "Tabela......:" )
Write( 11, 11 , "Funcionario.:" )
Write( 12, 11 , "Servico.....:" )
Write( 13, 11 , "Quant.......:" )
Write( 14, 11 , "Data........:" )

Write( 10, 24 , Tabela	)
Write( 11, 24 , CodiFun )
Write( 12, 24 , CodiSer )
Write( 13, 24 , Qtd )
Write( 14, 24 , Data  )
Return

Proc Produ51()
**************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL nQtd
LOCAL nTotal
LOCAL cCodigo
LOCAL cTabela
LOCAL nValorSer
LOCAL nRecno
LOCAL dData
LOCAL lSair
LOCAL nEscolha
FIELD Comissao
FIELD Tabela
FIELD CodiFun
FIELD CodiSer
FIELD Qtd
FIELD Data
FIELD Sobra
FIELD Codigo

WHILE OK
	oMenu:Limpa()
	nQtd			:= 0
	nTotal		:= 0
	cCodiFun 	:= Space(04)
	cTabela		:= Space(07)
	nValorSer	:= 0
	nRecno		:= 0
	dData 		:= Date()
	lSair 		:= FALSO
	WHILE OK
		MaBox( 06, 02, 11, 78, "INCLUSAO DE MOVIMENTO" )
		@ 07, 03 Say "Tabela....:" Get cTabela Pict "9999.99" Valid CortesErr( @cTabela, @nValorSer, 07, 23 )
		@ 08, 03 Say "Func......:" Get cCodiFun Pict "9999" Valid FunciErrado( @cCodiFun, 08, 23  )
		@ 09, 03 Say "Quant.....:" Get nQtd     Pict "9999" Valid VerQtdSobra( nQtd, cTabela )
		@ 10, 03 Say "Data......:" Get dData    Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			lSair := OK
			Exit
		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ?", {"Incluir","Alterar","Sair"})
		IF nEscolha = 1
			IF !VerQtdSobra( nQtd, cTabela )
				Loop
			EndIF
         Cortes->( Order( CORTES_TABELA ))
			Cortes->(DbSeek( cTabela ))
			IF Cortes->(!TravaReg())
				Loop
			EndIF
			IF Movi->(!Incluiu())
				Cortes->(Libera())
				Loop
			EndIF
			cCodigo		  := Cortes->Codigo
			Cortes->Sobra := Cortes->Sobra - nQtd
			Cortes->(Libera())
			Movi->Tabela  := cTabela
			Movi->CodiFun := cCodiFun
			Movi->CodiSer := Right( cTabela, 2 )
			Movi->Qtd	  := nQtd
			Movi->Data	  := dData
			Movi->Codigo  := cCodigo
			Movi->(Libera())

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
EndDo

Function VerQtdSobra( nQtd, cTabela )
*************************************
LOCAL Arq_Ant, Ind_Ant, RetVal

IF LastKey() = UP
	Return( OK )
EndIF
IF nQtd = 0
	ErrorBeep()
	Alerta("Erro: Quantidade Invalida...")
	Return( FALSO )
EndIf
Arq_Ant := Alias()
Ind_Ant := IndexOrd()
Area( "Cortes")
Cortes->(Order( CORTES_TABELA ))
DbGoTop()
DbSeek( cTabela )
IF nQtd <= Sobra
	RetVal := OK
Else
	ErrorBeep()
	nQtdPc := Tran( Sobra, "99999")
   IF Conf("Pergunta: Disponivel e de &nQtdPc. Pecas. Consultar ?")
		Produ65Dbedit( cTabela )
	EndIF
	RetVal := FALSO
EndIf
AreaAnt( Arq_Ant, Ind_Ant )
Return( RetVal )

Function CortesErr( cTabela, nVlrServico, nCol, nRow )
*****************************************************
LOCAL Arq_Ant
LOCAL Ind_Ant
FIELD Tabela
FIELD Valor

Arq_Ant := Alias()
Ind_Ant := IndexOrd()
Area( "Cortes")
IF (Lastrec() = 0 )
	 ErrorBeep()
	 Alerta( "Erro: Nenhum Registro Disponivel ..." )
	 Return( FALSO )
EndIf
Lista->(Order( LISTA_CODIGO ))
Servico->(Order( SERVICO_CODISER ))
Cortes->(Order( CORTES_TABELA ))
Set Rela To CodiSer Into Servico, Codigo Into Lista
IF !( DbSeek( cTabela ) )
	Cortes->(Escolhe( 00, 00, 24, "Tabela + 'Ý' + Tran( Sobra, '99999') + 'Ý' +Left( Lista->Descricao, 30) + 'Ý' + Left( Servico->Nome,30)", "TABELA  SOBRA  PRODUTO                       SERVICO" ))
	cTabela := Cortes->Tabela
EndIf
Area("Servico")
Servico->(Order( SERVICO_CODISER ))
DbSeek( Right( cTabela, 2 ) )
nVlrServico := Valor
IF nCol != Nil
	Write( nCol, nRow, Servico->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Function FunciErrado( cCodi, nCol, nRow )
***************************************
LOCAL aRotina := {{|| FuncInc() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD CodiFun
FIELD Nome

Funciona->(Order( FUNCIONA_CODIFUN ))
IF Funciona->(!DbSeek( cCodi ))
	Funciona->(Order( FUNCIONA_NOME ))
	Funciona->(Escolhe( 00, 00, 24, "Nome", "NOME FUNCIONARIO ", aRotina ))
	cCodi := Funciona->CodiFun
EndIf
IF nCol != Nil
	Write( nCol, nRow, Funciona->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc Produ31()
*************
LOCAL GetList		  := {}
LOCAL cScreen		  := SaveScreen()
LOCAL MouseList	  := {}
LOCAL lAutoProducao := oIni:ReadBool('sistema', 'autoproducao', FALSO )
LOCAL nQtd
LOCAL dData
LOCAL lSair
LOCAL cTabela
LOCAL cCor
LOCAL cCodigo
LOCAL cCodiSer
LOCAL cGrupo
LOCAL nItens
LOCAL nTotal
FIELD Tabela
FIELD Qtd
FIELD Sobra
FIELD Data
FIELD CodiSer
FIELD Grupo

nQtd	:= nTotal := 0
dData := Date()
oMenu:Limpa()
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
DbGoBottom()
cTabela := StrZero( Val( Left( Tabela, 4 ) ) + 1, 4 )
cCodigo := cTabela
cCodi   := 0
cGrupo  := Space(2)
MaBox( 06, 02, 12, 78, "INCLUSAO DE PRODUCAO" )
WHILE OK
	lSair := FALSO
	@ 07, 03 Say "Grupo Ser.:" Get cGrupo  Pict "99"     Valid GrpSerErrado( @cGrupo, Row(), Col()+1 )
	@ 08, 03 Say "Tabela....:" Get cCodigo Pict "9999"   Valid CortesCer( @cCodigo )
	@ 09, 03 Say "Quant.....:" Get nQtd    Pict "99999"  Valid nQtd != 0
	@ 10, 03 Say "Codigo....:" Get cCodi   Pict "999999" Valid CodiErrado( @cCodi, 10, 23 )
	@ 11, 03 Say "Data......:" Get dData   Pict "##/##/##"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	ErrorBeep()
	IF Alerta("Confirma Inclusao do Registro ?", SIMNAO ) = SIM
		IF CortesCer( @cCodigo )
			IF Cortes->(TravaArq())
            Lista->(Order( LISTA_CODIGO ))
				Lista->(DbSeek( cCodi ))
				IF Lista->(!TravaReg())
					Cortes->(Libera())
					Loop
				EndIF
				IF Entradas->(!Incluiu())
					Cortes->(Libera())
					Lista->(Libera())
					Loop
				EndIF
            Servico->( Order( SERVICO_CODISER ))
				Servico->( DbGoTop())
				WHILE Servico->(!Eof())
					IF Servico->Grupo = cGrupo
						cCodiSer :=  "." + Servico->CodiSer
						Cortes->(DbAppend())
						Cortes->Tabela  := cCodigo + cCodiser
						Cortes->Qtd 	 := nQtd
						Cortes->Sobra	 := nQtd
						Cortes->Data	 := dData
						Cortes->Codigo  := cCodi
						Cortes->Codiser := Servico->CodiSer
					EndIF
					Servico->(DbSkip(1))
				EndDo
				Cortes->(Libera())
				IF lAutoProducao
					Lista->Quant += nQtd
					Lista->(Libera())
					Entradas->Codigo	  := cCodi
					Entradas->Entrada   := nQtd
					Entradas->Data 	  := dData
					Entradas->Fatura	  := cCodigo
					Entradas->Pcusto	  := Lista->Pcusto
					Entradas->Codi 	  := Lista->Codi
					Entradas->(Libera())
				EndIF
				cTabela := StrZero( Val( Left( cTabela, 4 ) ) + 1, 4 )
				cCodigo := cTabela
			EndIF
		EndIF
	EndIF
EndDo

Proc Produ32( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL cCodi
LOCAL cFatura
LOCAL Opcao
LOCAL cTabela1
LOCAL cTabela2
LOCAL nQtdAnt
LOCAL nQtd
LOCAL dData
LOCAL nRegAnt
FIELD Tabela
FIELD Qtd
FIELD Data
FIELD Sobra

WHILE OK
	Area("Cortes")
   Cortes->(Order( CORTES_TABELA ))
	MaBox( 15, 10, 17, 28 )
	cCodi := Space(04)
	@ 16, 11 Say "Tabela..:" Get cCodi Pict "9999" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	oMenu:Limpa()
	MaBox( 09, 10, 13, 65, cCabecalho )
	CortesProx( cCabecalho )
	WHILE OK
		MaBox( 20, 07, 22, 73 )
		AtPrompt( 21, 08, " Editar " )
		AtPrompt( 21, 17, " Deletar " )
		AtPrompt( 21, 27, " Proximo " )
		AtPrompt( 21, 37, " Anterior " )
		AtPrompt( 21, 49, " Localizar " )
		AtPrompt( 21, 61, " Retornar " )
		Menu To opcao
		Do Case
		Case opcao = 0 .OR. opcao = 6 .OR. opcao = 5
			ResTela( cScreen )
			Exit

		Case opcao = 1
			ErrorBeep()
			cTabela1 := cTabela2 := Tabela
			nQtdAnt	:= Qtd
			nQtd		:= Qtd
			dData 	:= Data
			@ 10, 24 Get cTabela2 Pict "9999" Valid CortesTab( cTabela2, @cTabela1 )
			@ 11, 24 Get nQtd 	 Pict "99999"
			@ 12, 24 Get dData	 Pict "##/##/##"
			Read
			IF LastKey() = ESC
				CortesProx( cCabecalho )
				Loop
			EndIF
			IF nQtdAnt != nQtd .OR. cTabela2 != cTabela1 .OR. dData != Data
				Area("Cortes")
            Cortes->(Order( CORTES_TABELA ))
				IF Conf("Pergunta: Confirma Alteracao da Tabela ?" )
					IF Cortes->(TravaArq())
						cTela := Mensagem("Aguarde, Alterando Tabela.", Cor())
						nRegAnt := Cortes->(Recno())
						oBloco  := {|| Cortes->(Left(Tabela,4)) = Left( cTabela1, 4) }
						IF Cortes->( DbSeek( Left( cTabela1, 4)))
							WHILE Eval( oBloco )
								 cExtensao		 := Cortes->(Right( Tabela, 3))
								 Cortes->Tabela := Left( cTabela2,4 ) + cExtensao
								 Cortes->Data	 := dData
								 Cortes->Qtd	 := nQtd
								 Cortes->Sobra  := Cortes->Sobra - nQtdAnt
								 Cortes->Sobra  := Cortes->Sobra + nQtd
								 Cortes->(DbSkip(1))
							 EndDo
						EndIF
						Cortes->(Libera())
						Cortes->(DbGoto( nRegAnt ))
						ResTela( cTela )
						CortesProx( cCabecalho )
					EndIF
				EndIF
			EndIF
			CortesProx( cCabecalho )

		Case opcao = 2
			cFatura	:= Left( cCodi, 4 )
			cTabela1 := Cortes->Tabela
			IF Conf( "Pergunta: Confirma Exclusao da Tabela ?" )
				IF Cortes->(TravaArq())
					cTela   := Mensagem("Aguarde, Excluindo Tabela.", Cor())
					nRegAnt := Cortes->(Recno())
					oBloco  := {|| Cortes->(Left(Tabela,4)) = Left( cTabela1, 4) }
					IF Cortes->( DbSeek( Left( cTabela1, 4)))
						WHILE Eval( oBloco )
							 Cortes->(DbDelete())
							 Cortes->(DbSkip(1))
						 EndDo
					EndIF
					Cortes->(Libera())
					Entradas->(Order( ENTRADAS_FATURA ))
					IF Entradas->(DbSeek( cFatura ))
						cProduto := Entradas->Codigo
						nQuant	:= Entradas->Entrada
						IF Entradas->(TravaReg())
							Entradas->(DbDelete())
							Entradas->(Libera())
						EndIF
						Lista->(Order( LISTA_CODIGO ))
						IF Lista->(DbSeek( cProduto ))
							IF Lista->(TravaReg())
								Lista->Quant -= nQuant
								Lista->(Libera())
							EndIF
						EndIF
					EndIF
					ResTela( cTela )
					CortesProx( cCabecalho )
				EndIF
			EndIF

		Case opcao = 3
			IF Eof()
				ErrorBeep()
				Loop
			EndIf
			Cortes->(DbSkip(1))
			CortesProx( cCabecalho )

		Case opcao = 4
			IF Bof()
				ErrorBeep()
				Loop
			EndIf
			Cortes->(DbSkip(-1))
			CortesProx( cCabecalho )

		EndCase
	EndDo
EndDo

Proc CortesProx( cCabecalho )
*****************************
LOCAL GetList	 := {}
FIELD Tabela, Qtd, Data

MaBox( 09, 10, 13, 65, cCabecalho )
Write( 10, 11 , "Tabela......:" )
Write( 11, 11 , "Quant.......:" )
Write( 12, 11 , "Data........:" )
Write( 10, 24 , Left( Tabela, 4 ) )
Write( 11, 24 , Qtd )
Write( 12, 24 , Data  )
Return

Function CortesCer( cTabela )
*****************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( cTabela ) )
	ErrorBeep()
	Alerta("Erro: Codigo Tabela Invalida..." )
	Return( FALSO )
EndIF
Area( "Cortes" )
Cortes->(Order( CORTES_TABELA ))
IF !( DbSeek( Left( cTabela, 4 )))
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(OK)
EndIF
ErrorBeep()
Alerta("Erro: Codigo da Tabela Ja Registrada...")
cTabela := StrZero( Val( cTabela )+1, 4)
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Proc IncServico()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL cNomeSer
LOCAL nValorSer
LOCAL lSair
LOCAL cCodiSer
LOCAL nEscolha
LOCAL cGrupo
FIELD CodiSer
FIELD Nome
FIELD Valor
FIELD Grupo

cScreen := SaveScreen()
WHILE OK
	oMenu:Limpa()
	cNomeSer  := Space( 40 )
	cGrupo	 := Space(2)
	nValorSer := 0
	lSair 	 := FALSO
	Area("Servico")
	Servico->(Order( SERVICO_CODISER ))
	Servico->(DbGoBottom())
	cCodiSer = Servico->(StrZero( Val( CodiSer ) + 1, 2 ))
	WHILE OK
		MaBox( 06, 02, 11, 78, "INCLUSAO DE NOVOS SERVICOS" )
		@ 07, 03 Say "Grupo.....:" Get cGrupo     Pict "99" Valid GrpSerErrado( @cGrupo, Row(), Col()+1 )
		@ 08, 03 Say "Codigo....:" Get cCodiSer   Pict "99" Valid CodiSer( @cCodiSer )
		@ 09, 03 Say "Servi‡o...:" Get cNomeSer   Pict "@K!" Valid NomeSer( cNomeSer )
		@ 10, 03 Say "Valor.....:" Get nValorSer  Pict "9999999999.999" Valid IF( nValorSer <= 0, ( ErrorBeep(), Alerta("Erro: Campo nao Pode ser Zero ou Negativo"), FALSO ), OK )
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit

		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ? ", {" Incluir "," Alterar "," Sair " })
		IF nEscolha = 1
			Area("Servico")
			IF CodiSer( @cCodiSer )
				IF Servico->(Incluiu())
					Servico->CodiSer := cCodiser
					Servico->Nome	  := cNomeSer
					Servico->Valor   := nValorSer
					Servico->Grupo   := cGrupo
					Servico->(Libera())
					cCodiSer := Strzero( Val( cCodiSer ) + 1, 2 )
				EndIf
		  EndIf

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
Enddo

Proc Produ22( cCabecalho )
**************************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL cCodi, MouseList := {}
LOCAL Opcao, cCodi1, cCodi2
FIELD Nome, Valor, CodiSer

WHILE OK
	Area("Servico")
   Servico->(Order( SERVICO_CODISER ))
	MaBox( 15, 10, 17, 26 )
	cCodi := Space(02)
	@ 16, 11 Say "Codigo..:" Get cCodi Pict "99" Valid SerErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	oMenu:Limpa()
	MaBox( 09, 10, 14, 65, cCabecalho )
	SerProx( cCabecalho )
	WHILE OK
		MaBox( 20, 07, 22, 73 )
		__AtPrompt( 21, 08, " Editar " )
		__AtPrompt( 21, 17, " Deletar " )
		__AtPrompt( 21, 27, " Proximo " )
		__AtPrompt( 21, 37, " Anterior " )
		__AtPrompt( 21, 49, " Localizar " )
		__AtPrompt( 21, 61, " Retornar " )
		Menu To opcao
		Do Case
		Case opcao = 0 .OR. opcao = 6 .OR. opcao = 5
			ResTela( cScreen )
			Exit

		Case opcao = 1
			ErrorBeep()
			IF Servico->(TravaReg())
				cCodi2 := cCodi1 := CodiSer
				@ 10, 24 Get Grupo	Pict "99"
				@ 11, 24 Get cCodi2	Pict "@!" Valid SerVal( cCodi2, @cCodi1 )
				@ 12, 24 Get Nome 	Pict "@!"
				@ 13, 24 Get Valor	Pict "9999999999.999"
				Read
				IF LastKey() = ESC
					Servico->(Libera())
					SerProx( cCabecalho )
					Loop
				EndiF
				Servico->CodiSer := cCodi2
				Servico->(Libera())
				SerProx( cCabecalho )
			EndIF

		Case opcao = 2
			ErrorBeep()
			IF Conf( "Pergunta: Confirma Exclusao do Registro ?")
				IF Servico->(TravaReg())
					Servico->(DbDelete())
					Servico->(Libera())
					Alerta( "Tarefa: Registro Excluido...")
					Servico->(DbSkip())
					SerProx( cCabecalho )
				EndIf
			EndIf

		Case opcao = 3
			IF Eof()
				ErrorBeep()
				Loop
			EndIf
			DbSkip()
			SerProx( cCabecalho )

		Case opcao = 4
			IF Bof()
				ErrorBeep()
				Loop

			EndIf
			DbSkip( -1 )
			SerProx( cCabecalho )

		EndCase
	EndDo
EndDo

Function SerVal( cCodi1, cCodi2 )
*********************************
LOCAL Reg_Ant := Recno()

IF Empty( cCodi1 )
	ErrorBeep()
	Alerta( "Erro: Codigo Servi‡o Invalido...")
	Return( FALSO )
EndIf
IF cCodi1 == cCodi2
	DbGoto( Reg_Ant )
	Return( OK )
EndIf
Area("Servico")
Servico->(Order( SERVICO_CODISER ))
DbGoTop()
IF ( DbSeek( cCodi1 ) )
	ErrorBeep()
	Alerta( "Erro: Codigo Servi‡o Ja Registrado...")
	Return( FALSO )
EndIf
DbGoTo( Reg_Ant )
Return(OK)

Function CortesVal( cTabela1, cTabela2 )
***************************************
LOCAL cServico := Right( cTabela1, 2)
LOCAL Reg_Ant := Recno()

IF Empty( cTabela1 )
	ErrorBeep()
	Alerta( "Erro: Entrada de Tabela Invalida...")
	Return( FALSO )
EndIf
IF cTabela1 == cTabela2
	Return( OK )
EndIf
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
IF ( DbSeek( cTabela1 ) )
	ErrorBeep()
	Alerta( "Erro: Codigo Tabela Ja Registrado...")
	Return( FALSO )
EndIf
IF Sererrado( @cServico )
	cTabela1 := Left( cTabela1, 5 ) + cServico
EndIF
DbGoTo( Reg_Ant )
Return(OK)

Function CortesTab( cTabela1, cTabela2 )
****************************************
LOCAL cTabela := Cortes->Tabela

IF Empty( cTabela1 )
	ErrorBeep()
	Alerta( "Erro: Entrada de Tabela Invalida.")
	Return( FALSO )
EndIf
IF cTabela1 == cTabela2
	Return( OK )
EndIf
Cortes->(Order( CORTES_TABELA ))
IF Cortes->(DbSeek( Left( cTabela1, 7 )))
	ErrorBeep()
	Alerta( "Erro: Codigo Tabela Ja Registrada.")
	Return( FALSO )
EndIf
Cortes->(DbSeek( cTabela ))
Return(OK)

Function SerErrado( cServico, cCodi )
************************************
LOCAL aRotina := {{|| IncServico() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Nome
FIELD CodiSer

Area( "Servico")
Servico->(Order( SERVICO_CODISER ))
IF Servico->(!DbSeek( cServico ))
   Servico->(Escolhe( 00, 00, 24, "Nome", "         SERVI€O", aRotina ))
	cServico := IF( Len( cServico ) > 2, Servico->Nome, Servico->CodiSer )
EndIF
cCodi := Servico->CodiSer
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc SerProx( cCabecalho )
**************************
LOCAL GetList	 := {}
FIELD CodiSer, Nome, Valor

MaBox( 09, 10, 14, 65, cCabecalho )
Write( 10, 11 , "Grupo.......:" )
Write( 11, 11 , "Codigo......:" )
Write( 12, 11 , "Nome........:" )
Write( 13, 11 , "Valor.......:" )

Write( 10, 24 , Grupo )
Write( 11, 24 , CodiSer )
Write( 12, 24 , Nome )
Write( 13, 24 , Valor )
Return

Function CodiSer( cCodi )
*************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

IF Empty( cCodi )
	ErrorBeep()
	Alerta("Erro: Codigo Servi‡o Invalido..." )
	Return( FALSO )
EndIF
Area( "Servico" )
Servico->(Order( SERVICO_CODISER ))
IF !( DbSeek( cCodi ) )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return(OK)
EndIF
ErrorBeep()
Alerta("Erro: Codigo de Servico Ja Registrado...")
cCodi := StrZero( Val( cCodi ) + 1, 2 )
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Function NomeSer( cNome )
*************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
IF ( Empty( cNome ) )
	ErrorBeep()
	Alerta("Erro: Nome Servi‡o Invalido..." )
	Return( FALSO )
EndIF
Area( "Servico" )
Servico->(Order( SERVICO_NOME ))
IF ( DbSeek( cNome ) )
	ErrorBeep()
	Alerta("Erro: Nome Servi‡o Ja Registrado..." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIf
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

Function ProduPleta( cCep, cCida, cEsta)
****************************************
IF cCep	= XCCEP
	cCida := XCCIDA
	cEsta := XCESTA
	Keyb Chr( 13 ) + Chr( 13 )
EndIF
Return( OK )

Function ProduCerto( Var )
**************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

IF Empty( Var )
	ErrorBeep()
	Alerta( "Erro: Codigo Funcionario Invalido ..." )
	Return( FALSO )
EndIf
Area("Funciona")
Funciona->(Order( FUNCIONA_CODIFUN ))
IF !( DbSeek( Var ) )
	Areaant( Arq_Ant, Ind_Ant )
	Return(OK)
EndIf
ErrorBeep()
Alerta( "Erro: Funcionario Ja Registrado..." )
Var := StrZero( Val( Var ) + 1, 4 )
AreaAnt( Arq_Ant, Ind_Ant )
Return( FALSO )

Function ProduVal( Var, Var1 )
******************************
LOCAL Reg_Ant := Recno()

IF Empty( Var )
	ErrorBeep()
	Alerta( "Erro: Codigo Funcionario Invalido..." )
	DbGoto( reg_ant )
	Return( FALSO )
EndIf
IF Var == Var1
	DbGoto( Reg_Ant )
	Return( OK )
EndIf
Area("Funciona")
Funciona->(Order( FUNCIONA_CODIFUN ))
DbGoTop()
IF ( DbSeek( Var ) )
	ErrorBeep()
	Alerta( "Erro: Existe Funcionario Registrado Com Este Codigo ..." )
	Return( FALSO )
EndIf
DbGoTo( Reg_Ant )
Return( OK )

Function ProduErrado( Var, cCodi, nCol, nRow )
**********************************************
LOCAL aRotina := {{|| FuncInc() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Nome, CodiFun

IF ( Lastrec() = 0 )
	ErrorBeep()
	Alerta( "Erro: Nenhum Registro Disponivel ...")
	Return( FALSO )
EndIf
Area( "Funciona")
Funciona->(Order( FUNCIONA_CODIFUN ))
IF !( DbSeek( Var ) )
   Funciona->(Order( FUNCIONA_NOME ))
	DbGoTop()
	Escolhe( 00, 00, 24, "Nome", "NOME DO FUNCIONARIO", aRotina )
	IF( Len( var ) > 4, Var := Nome, Var := CodiFun )
EndIf
cCodi := CodiFun
IF nCol != Nil
	Write( nCol  ,  nRow, Funciona->Nome )
	Write( nCol+1,  nRow, Funciona->(Tran( Comissao, "999,999,999.999")))
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )


Proc RelProdu2( oBloco )
************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Relato  := "RELATORIO DE SERVICOS"
LOCAL Tam     := 80
LOCAL Col     := 58
LOCAL Pagina  := 0

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. REL_OK()
	IF Col >= 58
      Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
      Write( 01, 00, Date() )
      Write( 02, 00, Padc( XNOMEFIR, Tam ) )
      Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
      Write( 04, 00, Padc( Relato, Tam ) )
      Write( 05, 00, Repl( SEP, Tam ) )
      Write( 06, 00, "CODIGO GRUPO DESCRICAO DO SERVICO                                          VALOR")
      Write( 07, 00, Repl( SEP, Tam ) )
      Col := 8
	Endif
	Qout( CodiSer, Space(3), Grupo, Space(2), Nome + Space(12) + TransForm( Valor, "999,999,999.999"))
	Col++
   IF Col >= 58
		Write( Col, 0,  Repl( SEP, Tam ) )
      __Eject()
	EndIf
	DbSkip()
EndDo
__Eject()
PrintOff()
Return

Proc AdianConsu()
*****************
LOCAL GetList	 := {}
LOCAL Func_Consu := SaveScreen()
LOCAL MouseList  := {}

WHILE OK
	 aTela := SaveScreen()
	 op1 := 1
	 MaBox( 08, 20, 15, 48, "CONSULTAS")
	 AtPrompt( 10, 21, " Retorno                 " )
	 AtPrompt( 11, 21, " Deb/Credito Por Docto   " )
	 AtPrompt( 12, 21, " Deb/Credito Por Codigo  " )
	 AtPrompt( 13, 21, " Deb/Credito Por Data    " )
	 AtPrompt( 14, 21, " Todos os Deb/Creditos   " )
	 Menu To op1
	 Do Case
	 Case op1 = 0 .OR. op1 = 1
		 DbClearRel()
		 DbClearFilter()
		 DbGoTop()
		 ResTela( func_consu )
		 Exit

	 Case op1 = 2
		 Area("Funcimov")
       Funcimov->(Order( FUNCIMOV_DATA ))
		 DbGoTop()
		 MaBox( 18, 20, 20, 41 )
		 Mdocnr = Space( Len( docnr )-2 )
		 @ 19, 21 Say "Docto N§...:" Get Mdocnr Pict "@!" Valid DocFuErrado( @Mdocnr )
		 Read
		 IF LastKey() = ESC
			 ResTela( aTela )
			 Loop

		 EndIf
       Set Filter To Docnr = Mdocnr .AND. !Empty( Descricao )
		 DbGoTop()
		 AdianMostra()

	Case op1 = 3
		Area("Funcimov")
      Funcimov->(Order( FUNCIMOV_CODIFUN ))
		DbGoTop()
		MaBox( 18, 20, 20, 36 )
		Mcodi := Space( Len( CodiFun ) )
		@ 19,21 Say "Codigo..:" Get Mcodi Pict "9999" Valid ProduErrado( @Mcodi )
		Read
		IF LastKey() = ESC
			ResTela( aTela )
			Loop

		EndIf
      Set Filter To CodiFun = Mcodi .AND. !Empty( descricao )
		DbGoTop()
		AdianMostra()

	Case op1 = 4
		 Area("Funcimov")
       Funcimov->(Order( FUNCIMOV_DOCNR ))
		 DbGoTop()
		 MaBox( 18, 20, 20, 39 )
		 Mdata = Date()
		 @ 19,21 Say "Data....:" Get Mdata Pict "##/##/##"
		 Read
		 IF LastKey() = ESC
			 ResTela( aTela )
			 Loop

		 EndIf
       Set Filter To data = Mdata .AND. !Empty( descricao )
       DbGoTop()
		 AdianMostra()

	 Case op1 = 5
		 Area("Funcimov")
       Funcimov->(Order( FUNCIMOV_CODIFUN ))
       Set Filter To descricao <> Space( Len( descricao ))
		 DbGoTop()
		 AdianMostra()

	 EndCase
EndDo

Proc AdianMostra()
******************
LOCAL GetList	 := {}
LOCAL Mostra1, Mostra2

oMenu:Limpa()
Funciona->( Order( FUNCIONA_CODIFUN ))
Area( "Funcimov")
Set Rela To CoDiFun Into Funciona
Mostra2 := {"CodiFun", "Funciona->nome", "TransForm( Deb, '@E 999,999,999.999' )",;
				"TransForm( Cre, '@E 999,999,999.999' )","data", "docnr", "descricao" }
Mostra1 := {"CODI", "NOME", "DEBITO", "CREDITO" ,"DATA" ,"DOCTO N§" ,"DESCRICAO"}
MaBox( 00, 00, MaxRow(), MaxCol(), "CONSULTA DE DEBITOS/CREDITOS" )
Seta1(24)
DbEdit( 01, 01, MaxRow()-1, MaxCol()-1, Mostra2, OK, OK, Mostra1 )
FunciMov->( DbClearRel() )
FunciMov->( DbClearFilter())
ResTela( aTela )
Return

Proc AdianAdian()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}

oMenu:Limpa()
WHILE OK
	Area("Funciona")
   Funciona->(Order( FUNCIONA_CODIFUN ))
	dDataEmis  := Date()
	dDataVcto  := Date()
	cDocnr	  := Space(07)
	cDesc 	  := Space(40)
	nVlr		  := 0
	cCodi 	  := Space(04)
	cOpcao	  := "D"
	MaBox( 07, 10, 17, 63, "CREDITOS/DEBITOS FUNCIONARIOS" )
	@ 08, 11 Say "Codigo....:" Get cCodi Pict "9999" Valid ProduErrado( @cCodi,, 09, 23 )
	@ 09, 11 Say "Nome......:"
	@ 10, 11 Say "Saldo.....:"
	@ 11, 11 Say "Emissao...:" Get dDataEmis Pict "##/##/##"
	@ 12, 11 Say "Vencto....:" Get dDataVcto Pict "##/##/##"
	@ 13, 11 Say "Docto N§..:" Get cDocnr    Pict "@!"
	@ 14, 11 Say "Valor.....:" Get nVlr      Pict "99999999.999" Valid nVlr <> 0
	@ 15, 11 Say "Cred/Deb..:" Get cOpcao    Pict "!" Valid cOpcao $ "CD"
	@ 16, 11 Say "Descricao.:" Get cDesc     Pict "@!" Valid !Empty( cDesc )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	ErrorBeep()
	IF cOpcao = "D"
		IF Conf( "Pergunta: Confirma Inclusao do Debito ?" )
			IF Funciona->(TravaReg())
				IF Funcimov->(!Incluiu())
					Funciona->(Libera())
					Loop
				EndIF
				Funciona->Comissao := Funciona->Comissao - nVlr
				Funciona->(Libera())
				Funcimov->Deb		  := nVlr
				Funcimov->CodiFun   := cCodi
				Funcimov->Data 	  := dDataEmis
				Funcimov->Docnr	  := cDocNr
				Funcimov->Descricao := cDesc
				Funcimov->Comissao  := Funcimov->Comissao - nVlr
				Funcimov->(Libera())
			EndIf
			IF Conf("Imprimir Recibo Agora ?")
				ReciboFuncionario( cDocnr )
			EndIF
		EndIf
	Else
		IF Conf( "Pergunta: Confirma Inclusao do Credito ?" )
			IF Funciona->(TravaReg())
				IF Funcimov->(!Incluiu())
					Funciona->(Libera())
					Loop
				EndIF
				Funciona->Comissao := Funciona->Comissao + nVlr
				Funciona->(Libera())
				Funcimov->Cre		  := nVlr
				Funcimov->CodiFun   := cCodi
				Funcimov->Data 	  := dDataEmis
				Funcimov->Docnr	  := cDocNr
				Funcimov->Descricao := cDesc
				Funcimov->Comissao  := Funcimov->Comissao + nVlr
				Funcimov->(Libera())
			EndIf
		EndIf
	EndIf
EndDo

Function DocFuErrado( cDocnr )
***************************
IF !( DbSeek( cDocnr ))
	Escolhe( 00, 00, 24, "Docnr", "  DOCTO N§  " )
	cDocnr := Docnr
EndIf
Return( OK )

Proc ScpSaldo()
***************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL nChoice	 := 1

Area("Funciona")
WHILE OK
	DbClearRel()
	DbClearFilter()
	DbGoTop()
	MaBox( 07, 10, 11, 34, "SALDOS ")
	AtPrompt( 09, 11, " Por Codigo  " )
	AtPrompt( 10, 11, " Geral       " )
	Menu To nChoice
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
      Funciona->(Order( FUNCIONA_CODIFUN ))
		DbGoTop()
		MaBox( 14, 10, 16, 26 )
		Doc := Space(4)
		@ 15,11 Say "Codigo..:" Get doc Pict "9999" VALID ProduErrado( @doc )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop

		EndIf
      Set Filter To CodiFun = Doc
		DbGoTop()
		Funcao45()

	Case nChoice = 2
      Funciona->(Order( FUNCIONA_NOME ))
		DbClearFilter()
		DbGoTop()
		Funcao45()
		ResTela( cScreen )

	EndCase
EndDo

Proc Funcao45()
*************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL Vetor3  := { "CodiFun" , "nome" , "TransForm( comissao, '@E 999,999,999.999' )" }
LOCAL Vetor4  := { "CODIGO" , "FUNCIONARIO" , "TOTAL" }

oMenu:Limpa()
MaBox( 00, 00, MaxRow(), MaxCol(), "SALDO FUNCIONARIOS" )
Seta1(24)
DbEdit( 01, 01, MaxRow()-1, MaxCol()-1, Vetor3, OK, OK, Vetor4 )
ResTela( cScreen )
Return

Proc Adiantamentos()
********************
LOCAL GetList	 := {}
LOCAL MouseList := {}
LOCAL FunAdian  := SaveScreen()
LOCAL aMenu 	 := {"Individual", "Geral"}
LOCAL Choice, dIni ,dFim

WHILE OK
	M_Title("POSICAO FINANCEIRA")
	Choice := FazMenu( 07, 20, aMenu, Cor())
	Do Case
	Case Choice = 0
		DbClearRel()
		DbClearFilter()
		DbGoTop()
		ResTela( FunAdian )
		Exit

	Case Choice = 1
		Area("Funciona")
      Funciona->(Order( FUNCIONA_CODIFUN ))
		DbGoTop()
		MaBox( 15, 20, 17, 36 )
		cCodi := Space( 4 )
		@ 16, 21 Say "Codigo..:" Get cCodi Pict "9999" Valid ProduErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( FunAdian )
			Loop

		EndIf
		Area( "Funcimov" )
      Funcimov->(Order( FUNCIMOV_DATA ))
		dIni := Date() - Day( Date() ) + 1
		dFim := Date()
		MaBox( 11, 50, 14, 78)
		@ 12, 51 Say "Data Inicial...:" Get dIni Pict "##/##/##"
		@ 13, 51 Say "Data Final.....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( FunAdian )
			Loop
      EndIf
      Set Filter To CodiFun = cCodi .AND. Data >= dIni .AND. Data <= dFim .AND. !Empty( Descricao )
		DbGoTop()
		Count To nItens
		IF ( nItens = 0 )
			ErrorBeep()
			Alerta( "Erro: Nenhum Registro Disponivel...")

		Else
			AdiantImpressao( dIni, dFim )

		EndIf
		ResTela( FunAdian )
		Loop

	Case Choice = 2
		Area("Funcimov")
      Funcimov->(Order( FUNCIMOV_CODIFUN ))
		dIni := Date() - Day( Date() ) + 1
		dFim := Date()
		MaBox( 11, 50, 14, 78)
		@ 12, 51 Say "Data Inicial...:" Get dIni Pict "##/##/##"
		@ 13, 51 Say "Data Final.....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( FunAdian )
			Loop

		EndIf
      Set Filter To Data >= dIni .AND. Data <= dFim .AND. !Empty( Descricao )
		DbGoTop()
		Count To nItens
		IF ( nItens = 0 )
			ErrorBeep()
			Alerta( "Erro: Nenhum Registro Disponivel...")

		Else
			AdiantImpressao( dIni, dFim )

		EndIf
		ResTela( FunAdian )
		Loop

	EndCase
EndDo

Proc AdiantImpressao( dIni, dFim )
******************************
LOCAL GetList	 := {}
LOCAL FunReVenImp := SaveScreen()
LOCAL MouseList	:= {}

Funciona->( Order( FUNCIONA_CODIFUN ))
Area( "Funcimov")
Set Rela To CodiFun Into Funciona
DbGoTop()
MaBox( 07, 61, 09, 79 )
nCop := 1
@ 08, 62 Say "Qtde Copias " Get nCop Pict "999"
Read
IF LastKey()  =  ESC .OR. nCop = 0
	Funcimov->( DbClearFilter())
	Funcimov->( DbClearRel())
	ResTela( FunReVenImp )
	Return

EndIf
IF !InstruIm() .OR. !LptOk()
	ResTela( FunReVenImp )
	Funcimov->( DbClearFilter())
	Funcimov->( DbClearRel())
	Return

EndIf
For I := 1 To nCop
	DbGoTop()
	Mensagem("Aguarde... Imprimindo.", Cor(), 21 )
	cIni			  := Dtoc( dIni )
	cFim			  := Dtoc( dFim )
	Tam			  := 132
	Col			  := 9
	Pagina		  := 0
	NovoCodiFun   := OK
	UltCodiFun	  := CodiFun
	nTotalVend	  := 0
	nSubTotal	  := 0
	nTotalGeral   := 0
	lSair 		  := FALSO
	PrintOn()
	FPrint( PQ )
	SetPrc( 0, 0 )
	Pagina++
	Write( 01, 00, Padr( "Pagina N§ " + StrZero( Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	Write( 02, 00, Date() )
	Write( 03, 00, Padc( XNOMEFIR, Tam ) )
	Write( 04, 00, Padc( SISTEM_NA7, Tam ) )
	Write( 05, 00, Padc( "POSICAO FINANCEIRA REF. &cIni. A &cFim.", Tam ) )
	Write( 06, 00, Repl( SEP, Tam ) )
	Write( 07, 00,"DATA     DOCTO N§  DESCRICAO                                        DEBITO        CREDITO")
	Write( 08, 00, Repl( SEP, Tam ) )
	Col := 9
	While !Eof() .AND. REL_OK()
		IF Col >=  58
			__Eject()
			Pagina++
			Write( 01, 00, Padr( "Pagina N§ " + StrZero( Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
			Write( 02, 00, Date() )
			Write( 03, 00, Padc( XNOMEFIR, Tam ) )
			Write( 04, 00, Padc( SISTEM_NA7, Tam ) )
			Write( 05, 00, Padc( "POSICAO FINANCEIRA REF. &cIni. A &cFim.", Tam ) )
			Write( 06, 00, Repl( SEP, Tam ) )
			Write( 07, 00,"DATA     DOCTO N§  DESCRICAO                                        DEBITO        CREDITO")
			Write( 08, 00, Repl( SEP, Tam ) )
			Col := 9
		EndIf
		IF Col = 9
			Write( Col, 00, NG + "FUNCIONARIO: " + CodiFun + " " + Funciona->Nome + NR )
			FPrint( PQ )
			Col++
			Col++
		EndIf
		IF NovoCodiFun
			NovoCodiFun   := FALSO
			nSubTotal	  := 0
			nTotalVend	  := 0
		EndIf
		Qout( Data, Docnr, Descricao, TransForm( Deb, "@E 999,999,999.99" ),;
												TransForm( Cre, "@E 999,999,999.99" ))
		Col++
		UltCodiFun	  := CodiFun
		nTotalVend	  += Cre
		nSubTotal	  += Cre
		nTotalGeral   += Cre
		nTotalVend	  -= Deb
		nSubTotal	  -= Deb
		nTotalGeral   -= Deb

		DbSkip()
		IF Col = 55 .OR. UltCodiFun != CodiFun
			Write( (Col + 1), 00, "*** SubTotal Funcionario *")
			Write( (Col + 1), ( MaxCol() - 4), TransForm( nSubTotal, "@E 999,999,999.99" ) )
			nSubTotal := 0
			IF UltCodiFun != CodiFun
				NovoCodiFun := OK
				Write( (Col + 2), 00, "*** Total Funcionario *")
				Write( (Col + 2), ( MaxCol() - 4), TransForm( nTotalVend, "@E 999,999,999.99" ) )
			EndIF
			IF Eof()
				Write( (Col + 3), 00, "*** Total Geral *** ")
				Write( (Col + 3), ( MaxCol() - 4), TransForm( nTotalGeral, "@E 999,999,999.99" ) )
			EndIF
			Col := 58
		EndIF
	EndDo
	__Eject()
	PrintOff()
Next
Funcimov->( DbClearFilter())
Funcimov->( DbClearRel())
ResTela( FunReVenImp )
Return


Proc SaldoFunc()
****************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL MouseList := {}
LOCAL cNome, cCodi, Escol, nItens
FIELD CodiFun, Data
WHILE OK
	Funciona->(DbClearRel())
	Funciona->(DbClearFilter())
	Funciona->(DbGoTop())
	Escol := 1
	MaBox( 07, 16, 11, 37, "REL. MOVIM." )
	AtPrompt( 09, 17, "  Por Codigo    " )
	AtPrompt( 10, 17, "  Geral         " )
	Menu To Escol
	Do Case
	Case Escol = 0
		ResTela( cScreen )
		Exit

	Case Escol = 1
		Area("Funciona")
      Funciona->(Order( FUNCIONA_CODIFUN ))
		DbGoTop()
		cCodi := Space( 04 )
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 16, 42 )
		@ 15, 17 Say "Codigo........:" Get cCodi Valid FunciErrado( @cCodi )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
      Set Filter To CodiFun = cCodi
		DbGoTop()
		Count To nItens
		IF ( nItens = 0 )
			oMenu:Limpa()
			ErrorBeep()
			Alerta( "Erro: Nenhum Registro Disponivel...")
			ResTela( cScreen )
			Loop
		Else
         Funciona->(Order( FUNCIONA_NOME ))
         SaldoRel()
		EndIF
		ResTela( cScreen )
		Loop
	Case Escol = 2
		Area("Funciona")
		DbGoTop()
		Count To nItens
		IF ( nItens = 0 )
			oMenu:Limpa()
			ErrorBeep()
			Alerta( "Erro: Nenhum Registro Disponivel...")
			ResTela( cScreen )
			Loop
		Else
         Funciona->(Order( FUNCIONA_NOME ))
			SaldoRel()
		EndIF
		ResTela( cScreen )
		Loop
	EndCase
EndDo

Proc SaldoRel()
****************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL nCop, MouseList := {}, I
LOCAL Tecla, Tam, Col, Pagina, nTotalFolha, nTotalGeral
LOCAL lSair, nDecisao

DbGoTop()
MaBox( 07, 61, 09, 79 )
nCop := 1
@ 08, 62 Say "Qtde Copias " Get nCop Pict "999"
Read
IF LastKey() =  ESC .OR. nCop = 0
	ResTela( cScreen )
	Return
EndIf
IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIf
For I := 1 To nCop
	DbGoTop()
	Mensagem( "Aguarde ... Imprimindo Copia N§ " + StrZero(I, 3), Cor())
	Tam			:= 80
	Col			:= 7
	Pagina		:= 0
	nTotalFolha := 0
	nTotalGeral := 0
	lSair 		:= FALSO
	PrintOn()
	SetPrc( 0, 0 )
	Write( 01, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
	Write( 02, 00, Date() )
	Write( 03, 00, Padc( XNOMEFIR, Tam ) )
	Write( 04, 00, Padc( SISTEM_NA7, Tam ) )
	Write( 05, 00, Padc( "RELATORIO SALDO DE FUNCIONARIO", Tam ) )
	Write( 06, 00, Repl( SEP, Tam ) )
	Col := 7

	WHILE !Eof() .AND. Rel_Ok()
		IF Col >=  58
			__Eject()
			Write( 01, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
			Write( 02, 00, Date() )
			Write( 03, 00, Padc( XNOMEFIR, Tam ) )
			Write( 04, 00, Padc( SISTEM_NA7, Tam ) )
			Write( 05, 00, Padc( "RELATORIO SALDO DE FUNCIONARIO", Tam ) )
			Write( 06, 00, Repl( SEP, Tam ) )
			Col := 7

		EndIf
		IF Col = 7
			Write( Col, 00,"CODIGO  NOME FUNCIONARIO                                                   SALDO" )
			Col++
			Write( Col, 00, Repl( SEP, Tam ) )
			Col++

		EndIf
		Write( Col, 0, CodiFun + "    " + Nome +  Space(15) + Tran( Comissao, "9,999,999,999.999"))
		nTotalFolha += Comissao
		nTotalGeral += Comissao
		Col++
		DbSkip( 1 )
		IF Col = 57
			Col++
			Write( Col, 47," ** SubTotal ** " + Tran( nTotalFolha, "9,999,999,999.999"))
			nTotalFolha := 0

		 EndIf

	EndDo
	Col++
	Write( Col, 47," ** SubTotal ** " + Tran( nTotalFolha, "9,999,999,999.999"))
	Col++
	Write( Col, 44," ** Total Geral ** " + Tran( nTotalGeral, "9,999,999,999.999"))

	__Eject()
	PrintOff()
Next
DbClearRel()	// Limpa Relacao de Arquivos
ResTela( cScreen )
Return

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Please, Aguarde Configura‡ao do Sistema...", WARNING, _LIN_MSG )
DbCloseAll()

IF !UsaArquivo("FUNCIONA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("SERVICO")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("CORTES")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("MOVI")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("FUNCIMOV")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("GRPSER")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("LISTA")
	MensFecha()
	Return
EndiF
IF !UsaArquivo("ENTRADAS")
	MensFecha()
	Return
EndiF
Return

Proc PrintProducao()
********************
LOCAL GetList	 := {}
LOCAL cScreen		:= SaveScreen()
LOCAL nQtd			:= 0
LOCAL nSobra		:= 0
LOCAL Tam			:= 80
LOCAL Col			:= 58
LOCAL nProduzido	:= 0
LOCAL Pagina		:= 0
LOCAL cTabela		:= ""

IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIf
Area("Cortes")
Cortes->(Order( CORTES_TABELA ))
Cortes->(DbGoTop())
Mensagem(" Aguarde... Imprimindo. ESC Cancela.")
PrintOn()
FPrint( _CPI10 )
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Col >= 58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
		Write( 04, 00, Padc( "RELATORIO DE PRODUCAO",Tam ) )
		Write( 05, 00, Repl( SEP, Tam ))
		Write( 06, 00, "DATA       TABELA              QTD       SOBRA         PRODUZIDO")
		Write( 07, 00, Repl( SEP, Tam ))
		Col := 8
	EndIf
	IF cTabela != Left( Tabela, 4 )
		Qout( Data, Space(1), Left( Tabela,4), Space(9), Qtd, Space(3), Sobra, Space(3), ( Qtd - Sobra ) )
		Col++
		nQtd		  += Qtd
		nSobra	  += Sobra
		nProduzido += ( Qtd - Sobra )
	EndIF
	cTabela := Left( Tabela, 4 )
	DbSkip(1)
	IF Col >= 58
		Write( Col + 1, 0, Repl( SEP, Tam ))
		__Eject()
	EndIf
EndDo
Col++
Write( Col, 000," ** Total Geral **" )
Write( Col, 025, Tran( nQtd,		  "@E 99,999.99" ))
Write( Col, 037, Tran( nSobra,	  "@E 99,999.99" ))
Write( Col, 055, Tran( nProduzido, "@E 99,999.99" ))
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc FechaMes()
***************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL MouseList := {}
LOCAL nValor  := 0
LOCAL lGeral  := FALSO
LOCAL cNome
LOCAL cCodi
LOCAL dIni
LOCAL dFim
LOCAL Escol
LOCAL nItens
FIELD CodiFun, Data

Area("Movi")
Movi->(Order( MOVI_CODIFUN ))
WHILE OK
	Movi->(DbClearRel())
	Movi->(DbClearFilter())
	Movi->(DbGoTop())
	Escol := 1
	MaBox( 07, 16, 11, 37, "FECH. MES." )
	AtPrompt( 09, 17, "  Por Codigo    " )
	AtPrompt( 10, 17, "  Geral         " )
	Menu To Escol
	IF Escol = 0
		ResTela( cScreen )
		Exit

	EndIF
	lGeral := IF( Escol = 1, FALSO, OK )
	IF !lGeral
		cCodi := Space( 04 )
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 18, 42 )
		@ 15, 17 Say "Codigo........:" Get cCodi Valid FunciErrado( @cCodi )
		@ 16, 17 Say "Data Inicial..:" Get dIni Pict "##/##/##"
		@ 17, 17 Say "Data Final....:" Get dFim Pict "##/##/##" Valid dFim > dIni
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Fechamento Individual ?")
			oMenu:Limpa()
			IF Movi->(!TravaArq()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Funciona->(!TravaArq()) ; Movi->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Funcimov->(!TravaArq()) ; Movi->(Libera()) ; Funciona->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			Mensagem(" Aguarde... Lancando Movimento.", Cor())
         Funciona->( Order( FUNCIONA_CODIFUN ))
         Servico->( Order( SERVICO_CODISER ))
			Area( "Movi")
			Set Rela To CodiFun Into Funciona, CodiSer Into Servico
         Movi->(Order( MOVI_CODIFUN ))
         Set Filter To CodiFun = cCodi .AND. Data >= dIni .AND. Data <= dFim .AND. Baixado = FALSO
			DbGoTop()
			nValor := 0
			WHILE Movi->(!Eof())
				nValor += ( Servico->Valor * Movi->Qtd )
				Movi->Baixado := OK
				Movi->(DbSkip(1))
			EndDo
			IF nValor != 0
            Funciona->(Order( FUNCIONA_CODIFUN ))
				Funciona->(DbSeek( cCodi ))
				Funciona->Comissao := Funciona->Comissao + nValor
				Funcimov->(DbAppend())
				Funcimov->CodiFun   := cCodi
				Funcimov->Cre		  := nValor
				Funcimov->Comissao  := Funcimov->Comissao + nValor
				Funcimov->Descricao := "COM SOB PRODUCAO REF " + Dtoc( dIni ) + " A " + Dtoc( dFim )
				Funcimov->Data 	  := dFim
				Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
			EndIf
			Movi->(Libera())
			Funciona->(Libera())
			Funcimov->(Libera())
		EndIf
	Else
		dIni	:= Date()
		dFim	:= Date() + 30
		MaBox( 14, 16, 17, 42 )
		@ 15, 17 Say "Data Inicial..:" Get dIni Pict "##/##/##"
		@ 16, 17 Say "Data Final....:" Get dFim Pict "##/##/##" Valid dFim > dIni
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Fechamento Geral ?")
			IF Movi->(!TravaArq())								 ; ResTela( cScreen ) ; Loop ;EndIF
			IF Funciona->(!TravaArq()) ; Movi->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
			IF Funcimov->(!TravaArq()) ; Movi->(Libera()) ; Funciona->(Libera()) ; ResTela( cScreen ) ; Loop ; EndIF
         Funciona->( Order( FUNCIONA_CODIFUN ))
         Servico->( Order( SERVICO_CODISER ))
			Area( "Movi")
         Movi->(Order( MOVI_CODIFUN ))
			Set Rela To CodiFun Into Funciona, CodiSer Into Servico
			Movi->(DbGoTop())
			oMenu:Limpa()
			Mensagem(" Aguarde... Lancando Movimento.", Cor())
			Funciona->(DbGoTop())
			While Funciona->(!Eof())
				nValor := 0
				cCodi := Funciona->CodiFun
				Movi->(DbSeek( cCodi ) )
				WHILE Movi->(!Eof()) .AND. Movi->CodiFun = cCodi
					IF !Movi->Baixado
						IF Movi->Data >= dIni .AND. Movi->Data <= dFim
							nValor += ( Servico->Valor * Movi->Qtd )
							Movi->Baixado := OK
						EndIF
					EndIF
					Movi->(DbSkip(1))
				EndDo
				IF nValor != 0
               Funciona->(Order( FUNCIONA_CODIFUN ))
					Funciona->(DbSeek( cCodi ))
					Funciona->Comissao := Funciona->Comissao + nValor
					Funcimov->(DbAppend())
					Funcimov->CodiFun   := cCodi
					Funcimov->Cre		  := nValor
					Funcimov->Comissao  := Funcimov->Comissao + nValor
					Funcimov->Descricao := "COM SOB PRODUCAO REF " + Dtoc( dIni ) + " A " + Dtoc( dFim )
					Funcimov->Data 	  := dFim
					Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
				EndIF
				Movi->(Libera())
				Funciona->(DbSeek( cCodi ) )
				Funciona->(DbSkip(1))
			Enddo
			Movi->(Libera())
			Funciona->(Libera())
			Funcimov->(Libera())
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

Proc ReciboFuncionario( cDocnr )
********************************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL MouseList := {}
LOCAL Larg	  := 80
LOCAL Vlr_Dup := 0
LOCAL nUrv	  := 1
LOCAL nLinhas := 3

Funciona->(Order( FUNCIONA_CODIFUN ))
Area("Funcimov")
Funcimov->(Order( FUNCIMOV_DATA ))
Set Rela To CodiFun Into Funciona
DbGoTop()
IF cDocnr = NIL
	MaBox( 18, 20, 20, 43 )
	cDocnr := Space( Len( Docnr )-2 )
	@ 19, 21 Say "Docto N§...:" Get cDocnr Pict "@!" Valid DocFuErrado( @cDocnr )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return
	EndIf
Else
	Funcimov->(DbSeek( cDocNr ))
EndIF
IF !InsTru80() .OR. !LptOK()
	ResTela( cScreen )
	Return
EndIF
PrintOn()
SetPrc(0,0)
Vlr_Dup := Extenso( Deb, nUrv, nLinhas, Larg )
Write( 00, 00, GD + Padc( "RECIBO",40))
Write( 02, 00, NG + "N§ " + NR + Docnr )
Write( 02, 50, NG + "R$: " + NR + Trim(Tran( Deb, "@E 99,999,999.999")))
Write( 04, 00, NG + "Recebi(emos) de: " + NR + XNOMEFIR )
Write( 06, 00, NG + "A importancia por extenso abaixo relacionada:" + NR )
Write( 07, 00, Left( Vlr_Dup, Larg ) )
Write( 08, 00, SubStr( Vlr_Dup, Larg + 1, Larg ) )
Write( 09, 00, Right( Vlr_Dup, Larg ) )
Write( 11, 00, NG + "Referente a: " + NR + Descricao )
Write( 13, 00, DataExt( Date()))
Write( 15, 00, "Assinatura:_________________________________________")
Write( 16, 11, Funciona->Nome )
__Eject()
PrintOff()
Funcimov->(DbClearRel())
Funcimov->(DbGoTop())
ResTela( cScreen )
Return

Proc FechaDebito()
******************
LOCAL GetList	 := {}
LOCAL cScreen := SaveScreen()
LOCAL MouseList := {}
LOCAL nValor  := 0
LOCAL lGeral  := FALSO
LOCAL nEscol  := 1
LOCAL cCodi, dFim, nItens
FIELD CodiFun, Data

WHILE OK
	Escol := 1
	MaBox( 07, 16, 11, 40, "FECH. DEBITO" )
	AtPrompt( 09, 17, "  Por Codigo    " )
	AtPrompt( 10, 17, "  Geral         " )
	Menu To Escol
	IF Escol = 0
		ResTela( cScreen )
		Exit

	EndIF
	lGeral := IF( Escol = 1, FALSO, OK )
	IF !lGeral
		cCodi := Space( 04 )
		dFim	:= Date()
		MaBox( 14, 16, 17, 42 )
		@ 15, 17 Say "Codigo........:" Get cCodi Valid FunciErrado( @cCodi )
		@ 16, 17 Say "Data..........:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Lancamento Debito Individual ?")
			oMenu:Limpa()
			IF Funciona->(TravaArq())
				IF Funcimov->(!TravaArq())
					Funciona->(Libera())
					ResTela( cScreen )
					Loop
				EndIF
			EndIF
	 Mensagem(" Aguarde...", Cor())
         Funciona->( Order( FUNCIONA_CODIFUN ))
	 Funciona->(DbSeek( cCodi ))
	 nValor := Funciona->Comissao
	 IF nValor > 0
		 Funciona->Comissao := 0
				Area("Funcimov")
				Funcimov->(DbAppend())
				Funcimov->CodiFun   := cCodi
		 Funcimov->Deb := nValor
		 Funcimov->Comissao	:= Funcimov->Comissao - nValor
		 Funcimov->Descricao := "PAGAMENTO DE SALARIO"
				Funcimov->Data 	  := dFim
				Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
	 Else
		 ErrorBeep()
				Alerta("Saldo Esta Negativo ou Zerado...")
			EndIF
			Funciona->(Libera())
			Funcimov->(Libera())
		EndIf
	Else
		dFim	:= Date()
		MaBox( 14, 16, 16, 42 )
		@ 15, 17 Say "Data..........:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		IF Conf("Pergunta: Confirma Lancamento Debito Geral ?")
			IF Funciona->(TravaArq())
				IF Funcimov->(!TravaArq())
					Funciona->(Libera())
					ResTela( cScreen )
					Loop
				EndIF
			EndIF
	 Mensagem(" Aguarde...", Cor())
         Funciona->( Order( FUNCIONA_CODIFUN ))
			Funciona->(DbGoTop())
			While Funciona->(!Eof())
		 nValor := Funciona->Comissao
		 cCodi  := Funciona->CodiFun
		 IF nValor > 0
			 Funciona->Comissao := 0
					Area("Funcimov")
					Funcimov->(DbAppend())
					Funcimov->CodiFun   := cCodi
			 Funcimov->Deb 	:= nValor
			 Funcimov->Comissao	:= Funcimov->Comissao - nValor
			 Funcimov->Descricao := "PAGAMENTO DE SALARIO"
					Funcimov->Data 	  := dFim
					Funcimov->Docnr	  := Left(StrTran(Time(),":"),5 ) + cCodi
				EndIF
				Funciona->(DbSeek( cCodi ) )
				Funciona->(DbSkip(1))
			Enddo
			Funciona->(Libera())
			Funcimov->(Libera())
		EndIF
	EndIF
	ResTela( cScreen )
EndDo

Proc AjusTabInd()
******************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0

WHILE OK
	oMenu:Limpa()
	Area("Cortes")
   Cortes->(Order( CORTES_TABELA ))
	MaBox( 15, 10, 17, 31 )
	cCodi := Space(07)
	@ 16, 11 Say "Tabela..:" Get cCodi Pict "9999.99" Valid CortesErr( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
   EndIF
	Mensagem("Aguarde, Processando.", Cor())
	Area("Movi")
   Movi->(Order( MOVI_TABELA ))
	IF Movi->(!DbSeek( cCodi ))
      Cortes->(Order( CORTES_TABELA ))
		IF Cortes->(DbSeek( cCodi ))
			IF Cortes->(TravaReg())
				Cortes->Sobra := Cortes->Qtd
				Cortes->(Libera())
				Loop
			EndIF
		EndIF
	EndIF
	nConta := 0
	WHILE Movi->Tabela = cCodi
		nConta += Movi->Qtd
		Movi->(DbSkip(1))
	EndDo
   Cortes->(Order( CORTES_TABELA ))
	IF Cortes->(DbSeek( cCodi ))
		IF Cortes->(TravaReg())
			Cortes->Sobra := IF( nConta = 0, Cortes->Qtd, Cortes->Qtd - nConta )
			Cortes->(Libera())
			Loop
		EndIF
	EndIF
EndDo

Proc AjusTabGer()
*****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL nConta	 := 0

oMenu:Limpa()
IF Conf("O Ajuste podera demorar. Continua ?")
	Mensagem("Aguarde, Processando.", Cor())
	Area("Cortes")
   Cortes->(Order( CORTES_TABELA ))
	Cortes->(DbGoTop())
	WHILE Cortes->(!Eof())
		cTabela := Cortes->Tabela
		nTotal  := Cortes->Qtd
		nConta  := 0
		Movi->(DbSeek( cTabela ))
		WHILE Movi->Tabela = cTabela
			nConta += Movi->Qtd
			Movi->(DbSkip(1))
		EndDo
		IF Cortes->(TravaReg())
			Cortes->Sobra := ( nTotal - nConta )
			Cortes->(Libera())
		EndIF
		Cortes->(DbSkip(1))
	EndDo
	Alerta("Informa: Ajuste Completado.")
EndIF
ResTela( cScreen )
Return

Proc FuncInc()
*************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL nEscolha
LOCAL cCida
LOCAL cNome
LOCAL cBair
LOCAL dData
LOCAL cCpf
LOCAL cRg
LOCAL cEsta
LOCAL cCep
LOCAL cFone
LOCAL cObs
LOCAL cCt
LOCAL lSair
LOCAL cCodi
LOCAL cEnde
LOCAL cCon
FIELD CodiFun
FIELD Data
FIELD Nome
FIELD Rg
FIELD Ende
FIELD Bair
FIELD Cida
FIELD Con
FIELD Obs
FIELD Cpf
FIELD Esta
FIELD Cep
FIELD Fone
FIELD Ct

cScreen := SaveScreen()
WHILE OK
	oMenu:Limpa()
	cCida := Space( 25 )
	cEnde := Space( 25 )
	cNome := Space( 40 )
	cBair := Space( 20 )
	cCon	:= Space( 20 )
	dData := Date()
	cCpf	:= Space( 14 )
	cRg	:= Space( 18 )
	cEsta := Space( 02 )
	cCep	:= Space( 09 )
	cFone := Space( 13 )
	cObs	:= Space( 30 )
	cCt	:= Space( 10 )
	lSair := FALSO

	Area("Funciona")
	Funciona->(Order( FUNCIONA_CODIFUN ))
	Funciona->(DbGoBottom())
	cCodi := Funciona->(StrZero( Val( CodiFun ) + 1, 4))
	MaBox( 07, 02, 22, 78, "INCLUSAO DE NOVOS FUNCIONARIOS" )
	WHILE OK
		@ 08, 03 Say "Codigo....:" Get cCodi Pict "9999" Valid ProduCerto( @cCodi )
		@ 09, 03 Say "Nome......:" Get cNome Pict "@!"
		@ 10, 03 Say "Data......:" Get dData Pict "##/##/##"
		@ 11, 03 Say "CPF.......:" Get cCpf  Pict "999.999.999-99" Valid TestaCpf( cCpf )
		@ 12, 03 Say "Rg........:" Get cRg   Pict "@!"
		@ 13, 03 Say "Cart.Trab.:" Get cCt   Pict "@!"
		@ 14, 03 Say "Endereco..:" Get cEnde Pict "@!"
		@ 15, 03 Say "Bairro....:" Get cBair Pict "@!"
		@ 16, 03 Say "Cep.......:" Get cCep  Pict "99999-999" Valid ProduPleta( cCep, @cCida, @cEsta)
		@ 17, 03 Say "Cidade....:" Get cCida Pict "@!"
		@ 18, 03 Say "Estado....:" Get cEsta Pict "@!"
		@ 19, 03 Say "Fone......:" Get cFone Pict "(999)999-9999"
		@ 20, 03 Say "Contato...:" Get cCon  Pict "@!"
		@ 21, 03 Say "Obs.......:" Get cObs  Pict "@!"
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ?", {"Incluir","Alterar","Sair"})
		IF nEscolha = 1
			Area("Funciona")
			IF ProduCerto( @cCodi )
				IF Incluiu()
					Funciona->CodiFun := cCodi
					Funciona->Data 	:= dData
					Funciona->Nome 	:= cNome
					Funciona->Rg		:= cRg
					Funciona->Ende 	:= cEnde
					Funciona->Bair 	:= cBair
					Funciona->Cida 	:= cCida
					Funciona->Con		:= cCon
					Funciona->Obs		:= cObs
					Funciona->Cpf		:= cCpf
					Funciona->Esta 	:= cEsta
					Funciona->Cep		:= cCep
					Funciona->Fone 	:= cfone
					Funciona->Ct		:= cCt
					Funciona->(Libera())
					cCodi := StrZero( Val( cCodi ) + 1, 4 )
				EndIF
			EndIF

		ElseIF nEscolha = 2
			Loop

		ElseIf nEscolha = 3
			lSair := OK
			Exit

		EndIF

	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIF
EndDo

Proc BrowseFuncionario()
************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Funciona")
Funciona->(Order( FUNCIONA_NOME ))
Funciona->(DbGoTop())
oBrowse:Add( "CODIGO",   "Codifun")
oBrowse:Add( "NOME",     "Nome")
oBrowse:Titulo := "CONSULTA/ALTERACAO/EXCLUSAO DE FUNCIONARIOS"
oBrowse:PreDoGet := {|| PreGetFuncionario( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreGetFuncionario( oBrowse )
*************************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida")
	Return( FALSO )
Otherwise
EndCase
Return( OK )

Proc BrowseServico()
********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Servico")
Servico->(Order( SERVICO_NOME ))
Servico->(DbGoTop())
oBrowse:Add( "CODIGO",   "CodiSer")
oBrowse:Add( "NOME",     "Nome")
oBrowse:Add( "VALOR",    "Valor", "999999999.999")
oBrowse:Titulo := "CONSULTA/ALTERACAO/EXCLUSAO DE SERVICOS"
oBrowse:PreDoGet := {|| PreGetServico( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreGetServico( oBrowse )
*********************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )

Do Case
Case oCol:Heading = "CODIGO"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida")
	Return( FALSO )
Otherwise
EndCase
Return( OK )

Proc TotalMovi()
****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL aMenu 	 := {"Por Periodo", "Geral"}
LOCAL nChoice	 := 0
LOCAL nItens
LOCAL dIni
LOCAL dFim
FIELD Data

WHILE OK
	M_Title("REL QUANTITATIVO")
	nChoice := FazMenu( 07, 16, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		dIni := Date() - 30
		dFim := Date()
		MaBox( 17, 16, 20, 43 )
		@ 18, 17 Say "Data Inicial...:" Get dIni Pict "##/##/##"
		@ 19, 17 Say "Data Final.....:" Get dFim Pict "##/##/##"
		Read
		IF LastKey() = 27
			ResTela( cScreen )
			Loop
		EndIF
		Area("Movi")
      Set Filter To Data >= dIni .AND. Data <= dFim
		DbGoTop()
		Count To nItens
		IF nItens = 0
			oMenu:Limpa()
			ErrorBeep()
			Alerta( "Erro: Nenhum Registro Disponivel...")
		Else
			TotalRel( dIni, dFim )
		EndIF
		Movi->(DbClearFilter())
		Movi->(DbGoTop())
		ResTela( cScreen )
		Loop

	 Case nChoice = 3
		 Area("Movi")
		 Movi->(DbGoTop())
		 Count To nItens
		 IF nItens = 0
			 oMenu:Limpa()
			 ErrorBeep()
			 Alerta( "Erro: Nenhum Registro Disponivel...")
			 ResTela( cScreen )
			 Loop
		 Else
			 TotalRel()
		 EndIF
		 ResTela( cScreen )
		 Loop
	EndCase
EndDo

Proc TotalRel( dIni, dFim )
***************************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL MouseList := {}
LOCAL Tam		 := 80
LOCAL Row		 := 58
LOCAL Pagina	 := 0
LOCAL Tecla
LOCAL NovoCodi
LOCAL Relato
LOCAL nTotalFolha
LOCAL nQtdPecas
LOCAL nTotalVlr
LOCAL nTotalPcs
LOCAL lSair
LOCAL nDecisao
LOCAL dData
LOCAL UltTabela
LOCAL nTotPecas

Area( "Movi")
Movi->(Order( MOVI_TABELA ))
Movi->(DbGoTop())
IF dIni != Nil
  cIni	:= Dtoc( dIni )
  cFim	:= Dtoc( dFim )
  Relato := "RELATORIO QUANTITATIVO DO MOVIMENTO REF. &cIni. A &cFim."
Else
  Relato := "RELATORIO QUANTITATIVO GERAL DO MOVIMENTO"
EndIF
IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.", Cor())
dData 		:= Data
UltTabela	:= Left( Tabela, 4 )
nQtdPecas	:= 0
nTotalFolha := 0
nTotPecas	:= 0
lSair 		:= FALSO
PrintOn()
SetPrc( 0, 0 )
WHILE !Eof() .AND. Rel_Ok()
	IF Row >=  58
		Write( 00, 00, Padr( "Pagina N§ " + StrZero( ++Pagina,3 ), ( Tam/2 ) ) + Padl( Time(), ( Tam/2 ) ) )
		Write( 01, 00, Date() )
		Write( 02, 00, Padc( XNOMEFIR, Tam ) )
		Write( 03, 00, Padc( SISTEM_NA7, Tam ) )
		Write( 04, 00, Padc( Relato, Tam ) )
		Write( 05, 00, Repl( SEP, Tam ) )
		Row := 6
	EndIF
	IF Row = 6
		Write( Row++, 00,"DATA     TABELA                                                            QUANT " )
		Write( Row++, 00, Repl( SEP, Tam ) )
	EndIF
	WHILE Eval( {|| Left( Tabela, 4 ) = UltTabela } )
		nQtdPecas	+= Qtd
		nTotPecas	+= Qtd
		nTotalFolha += Qtd
		dData 		:= Data
		Movi->(DbSkip(1))
	EndDo
	Write( Row++, 0, Dtoc( dData )  + "   " + UltTabela + Space( 60 ) + Tran( nQtdPecas, "99999" ) )
	UltTabela := Left( Tabela, 4 )
	nQtdPecas := 0
	IF Row >= 57
		Write( Row++, 57," ** SubTotal *** " + Tran( nTotalFolha, "999999" ) )
		nTotalFolha := 0
		Row			:= 58
		__Eject()
	 EndIf
EndDo
Write( ++Row, 57," ** SubTotal *** " + Tran( nTotalFolha, "999999" ) )
Write( ++Row, 54," ** Total Geral *** " + Tran( nTotPecas, "999999" ) )
__Eject()
PrintOff()
ResTela( cScreen )
Return

Proc RolFuncionario()
*********************
LOCAL GetList	 := {}
LOCAL MouseList := {}
LOCAL cScreen	 := SaveScreen()
LOCAL aMenu 	 := {"Individual", "Geral"}
LOCAL oBloco
LOCAL nChoice
LOCAL cCodi

WHILE OK
	M_Title("RELATORIO DE FUNCIONARIOS")
	nChoice := FazMenu( 07, 16, aMenu, Cor())
	Do Case
	Case nChoice = 0
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		Area("Funciona")
		cCodi := Space( 04 )
		MaBox( 13, 16, 15, 79 )
		@ 14, 17 Say "Codigo.:" Get cCodi Valid FunciErrado( @cCodi, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			ResTela( cScreen )
			Loop
		EndIF
		Area("Funciona")
		oBloco := {|| Funciona->CodiFun = cCodi }
		Funcionarios( oBloco )
		ResTela( cScreen )
		Loop

	Case nChoice = 2
		Area("Funciona")
		Funciona->(DbGoTop())
		oBloco := {|| Funciona->(!Eof()) }
		Funcionarios( oBloco )
		ResTela( cScreen )
		Loop

	EndCase
EndDo

Proc Funcionarios( oBloco )
***************************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0

IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIf
PrintOn()
SetPrc( 0, 0 )
WHILE Eval( oBloco ) .AND. REL_OK()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA7 ))
		Write( 04, 00, Padc( "RELATORIO DE FUNCIONARIOS", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"CODI         NOME FUNCIONARIO")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	Endif
	Write(	Col, 00, Chr( 27 ) + "E" + Codifun + " " + Nome + Chr( 27 ) + "F" )
	Write( ++Col, 05, Cpf  + Space( 10 ) + Rg)
	Write( ++Col, 05, Ende + " " + Bair )
	Write( ++Col, 05, Cep  + "/" + AllTrim( Cida ) + "-" + Esta )
	Col += 2
	IF Col >= 57
		Write( Col, 0,  Repl( SEP, Tam ) )
		Col := 58
		__Eject()
	EndIf
	DbSkip(1)
EndDo
__Eject()
PrintOff()
Return

*:---------------------------------------------------------------------------------------------------------------------------------

Proc GrpSerInc()
****************
LOCAL GetList	 := {}
LOCAL cScreen	 := SaveScreen()
LOCAL cGrupo	 := Space(02)
LOCAL cDesGrupo := Space(40)
FIELD Grupo
FIELD DesGrupo

cScreen := SaveScreen()
WHILE OK
	oMenu:Limpa()
	cGrupo	 := Space(02)
	cDesGrupo := Space(40)
	lSair 	 := FALSO
	Area("GrpSer")
	GrpSer->(Order( GRPSER_GRUPO ))
	GrpSer->(DbGoBottom())
	cGrupo = GrpSer->(StrZero( Val( Grupo ) + 1, 2 ))
	WHILE OK
		MaBox( 06, 02, 09, 78, "INCLUSAO DE NOVOS GRUPOS" )
		@ 07, 03 Say "Grupo.....:" Get cGrupo     Pict "99"  Valid GrpSerCerto( @cGrupo )
		@ 08, 03 Say "Descricao.:" Get cDesGrupo  Pict "@!"  Valid !Empty( cDesGrupo )
		Read
		IF LastKey() = ESC
			lSair := OK
			Exit
		EndIf
		ErrorBeep()
		nEscolha := Alerta("Pergunta: Voce Deseja ? ", {" Incluir "," Alterar "," Sair " })
		IF nEscolha = 1
			Area("GrpSer")
			IF GrpSerCerto( @cGrupo )
				IF GrpSer->(Incluiu())
					GrpSer->Grupo	  := cGrupo
					GrpSer->DesGrupo := cDesGrupo
					Servico->(Libera())
					cGrupo := Strzero( Val( cGrupo ) + 1, 2 )
				EndIf
		  EndIf

		ElseIF nEscolha = 2
			Loop

		ElseIF nEscolha = 3
			lSair := OK
			Exit

		EndIF
	EndDo
	IF lSair
		ResTela( cScreen )
		Exit

	EndIf
Enddo

Function GrpSerCerto( cGrupo )
******************************
LOCAL Ind_Ant := IndexOrd()
LOCAL Arq_Ant := Alias()

IF Empty( cGrupo)
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Invalido." )
	Return( FALSO )
EndIF
Area( "GrpSer" )
IF ( GrpSer->( Order( GRPSER_GRUPO )), GrpSer->(DbSeek( cGrupo )))
	ErrorBeep()
	Alerta("Erro: Codigo Grupo Registrado." )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

Proc GrpSerAlt()
****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("GrpSer")
GrpSer->(Order( GRPSER_DESGRUPO ))
GrpSer->(DbGoTop())
oBrowse:Add( "GRUPO",     "Grupo")
oBrowse:Add( "DESCRICAO", "DesGrupo")
oBrowse:Titulo := "CONSULTA/ALTERACAO/EXCLUSAO DE GRUPOS"
oBrowse:PreDoGet := NIL
oBrowse:PosDoGet := NIL
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function GrpSerErrado( cGrupo, nCol, nRow )
*******************************************
LOCAL aRotina := {{|| GrpSerInc() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
FIELD Grupo
FIELD DesGrupo

IF ( GrpSer->(Order( GRPSER_GRUPO )), GrpSer->(!DbSeek( cGrupo )))
	GrpSer->(Order( GRPSER_DESGRUPO ))
	GrpSer->(Escolhe( 00, 00, 24, "Grupo + '³' + DesGrupo", "GRUPO DESCRICAO ", aRotina ))
EndIF
cGrupo := GrpSer->Grupo
IF nCol != Nil
	Write( nCol, nRow, GrpSer->Desgrupo )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:==================================================================================================================================

Proc GrpSerPri()
****************
LOCAL cScreen := SaveScreen()
LOCAL Tam	  := 80
LOCAL Col	  := 58
LOCAL Pagina  := 0

IF !Instru80() .OR. !LptOk()
	ResTela( cScreen )
	Return
EndIf
PrintOn()
SetPrc( 0, 0 )
Area("GrpSer")
GrpSer->(Order( GRPSER_DESGRUPO ))
WHILE GrpSer->(!Eof()) .AND. REL_OK()
	IF Col >= 58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA7 ))
		Write( 04, 00, Padc( "RELATORIO DE GRUPOS", Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00,"CODI DESCRICAO DO GRUPO")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	Endif
	GrpSer->(Qout( Grupo, ' ', DesGrupo ))
	Col++
	IF Col >= 57
		Write( Col, 0,  Repl( SEP, Tam ) )
		Col := 58
		__Eject()
	EndIf
	GrpSer->(DbSkip(1))
EndDo
__Eject()
PrintOff()
Return

*:==================================================================================================================================

Function oMenuScpLan()
**********************
LOCAL AtPrompt := {}
LOCAL cStr_Get
LOCAL cStr_Sombra

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
AADD( AtPrompt, {"Sair",        {"Encerrar Sessao"}})
AADD( AtPrompt, {"Funcionario", {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Grupo",       {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Servico",     {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Producao",    {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Movimento",   {"Inclusao","Alteracao","Exclusao","Consulta","Relatorio"}})
AADD( AtPrompt, {"Relatorio",   {"Funcionarios","Servicos","Producao","Movimento","Posicao Financeira","Quant.Movimento","Saldos","Recibo", "Grupos"}})
Aadd( AtPrompt, {"Consulta",    {"Funcionarios","Servicos","Movimento", "Producao", "Saldos", "Debitos/Creditos", "Grupos"}})
Aadd( AtPrompt, {"Lancamento",  {"Debitos/Creditos", "Fechamento Mes", "Debitos Mes", "Ajuste Tabela Individual", "Ajuste Tabela Geral"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispScpLan()
**********************
LOCAL aDisp 	:= Array( 9, 22 )
LOCAL oRecelan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL cMaior	:= ''
LOCAL cMenor	:= ''
LOCAL cRegra	:= ''
LOCAL i			:= 1
LOCAL x			:= 1

Mensagem("Aguarde, Verificando Diretivas do Sistema.")
For i := 1 To 9
	For x := 1 To 22
		cMaior	  := Tran( i, '9')
		cMenor	  := Strzero( x, 2 )
		cRegra	  := '#' + cMaior + '.' + cMenor
		aDisp[i,x] := oRecelan:ReadBool( 'scplan', cRegra, OK )
	Next
Next
Return( aDisp )
