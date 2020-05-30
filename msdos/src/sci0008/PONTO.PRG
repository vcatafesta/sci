/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
 İ³																								 ³
 İ³	Programa.....: PONTOLAN.PRG														 ³
 İ³	Aplicacaoo...: SISTEMA DE CONTROLE DE PONTO									 ³
 İ³	Versao.......: 19.50 																 ³
 İ³	Programador..: Vilmar Catafesta													 ³
 İ³	Empresa......: MicroBras Com de Prod de Informatica Ltda 				 ³
 İ³	Inicio.......: 12 de Novembro de 1991. 										 ³
 İ³	Ult.Atual....: 06 de Dezembro de 1998. 										 ³
 İ³	Compilacao...: Clipper 5.02														 ³
 İ³	Linker.......: Blinker 3.20														 ³
 İ³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ³
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#Include "InKey.Ch"
#Include "SetCurs.Ch"
#Include "Lista.Ch"
#Include "Indice.Ch"
*:==================================================================================================================================

Proc PontoLan()
***************
LOCAL Op        := 1
LOCAL lOk		 := OK
PUBLI cVendedor   := Space(40)
PUBLI cCaixa		:= Space(04)

*:==================================================================================================================================
AbreArea()
oMenu:Limpa()
IF !VerSenha( @cCaixa, @cVendedor )
	Mensagem("Aguarde, Fechando Arquivos." )
	DbCloseAll()
	Set KEY F2 TO
	Set KEY F3 TO
	Return
EndIF
*:==================================================================================================================================
oMenu:Limpa()
*:==================================================================================================================================
SetaClasse()
WHILE lOk
	BEGIN Sequence
		SetKey( F5, NIL )
		Op 		  := oMenu:Show()
		Do Case
		Case Op = 0.0 .OR. Op = 1.01
			ErrorBeep()
			IF Conf("Pergunta: Encerrar este modulo ?")
				lOk := FALSO
				Break
			EndIf
		Case op = 2.01 ; Servidor()
		Case op = 2.02 ; MoviPonto()
		Case op = 2.03 ; PontoAuto()
		Case op = 3.01 ; AlteraServidor()
		Case op = 3.02 ; MoviDbedit()
		Case op = 3.03 ; AjustaCarga()
		Case op = 4.01 ; AlteraServidor()
		Case op = 4.02 ; MoviDbedit()
		Case op = 5.01 ; AlteraServidor()
		Case op = 5.02 ; MoviDbedit()
		Case op = 6.01 ; ListaServidor()
		Case op = 6.02 ; ListaPonto()
		EndCase
	End Sequence
EndDo
Mensagem("Aguarde, Fechando Arquivos.")
FechaTudo()
Return

*:==================================================================================================================================

STATIC Proc SetaClasse()
************************
LOCAL oP 		 := 1
oMenu:Menu		 := oMenuPontolan()
oMenu:Disp		 := aDispPontoLan()
oMenu:Ativo 	 := IF( Int( Op ) <= 0, 1, Int( Op ))
oMenu:StatusSup := SISTEM_NA8 + " " + SISTEM_VERSAO
oMenu:StatusInf := "F1-HELP³F8-SPOOL³F10-CALC³"
Return

*:==================================================================================================================================

Proc AlteraServidor()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Servidor")
Servidor->( Order( SERVIDOR_NOME ))
Servidor->(DbGoTop())
oBrowse:Add( "CODIGO",       "Codi",    "9999")
oBrowse:Add( "NOME",         "Nome",    "@!")
oBrowse:Add( "CARGO",        "Cargo",   "@!")
oBrowse:Add( "CARGA HORARIA","Carga",   "999999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE SERVIDORES"
oBrowse:PreDoGet := {|| PreServidor( oBrowse ) }
oBrowse:PosDoGet := {|| PosServidor( oBrowse ) }
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function PreServidor( oBrowse )
*******************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

IF !PodeAlterar()
	Return( FALSO)
EndIF
Return( OK )

Function PosServidor( oBrowse )
*******************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL Retorno	 := NIL

Do Case
Case oCol:Heading = "SENHA"
	Retorno := AlterarSenha( Servidor->Codi )
	IF Retorno != NIL
		IF Servidor->(TravaReg())
			Servidor->Senha := Retorno
			Servidor->Atualizado := Date()
		EndIF
	EndIF
EndCase
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:==================================================================================================================================

Proc Servidor()
***************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL nOpcao
LOCAL cCodi
LOCAL cNome
LOCAL cCargo
LOCAL nCarga
LOCAL cSenha
FIELD Codi

WHILE OK
	oMenu:Limpa()
	Area("Servidor")
	Servidor->(Order( SERVIDOR_CODI ))
	DbGoBottom()
	cCodi  := StrZero(Val( Codi ) + 1, 4 )
	cNome  := Space(40)
	cCargo := Space(30)
	nCarga := 0
	MaBox( 05, 02, 11, 78, "INCLUSAO DE SERVIDORES" )
	@ 06, 03 Say "Codigo......:" Get cCodi  Pict "9999" Valid SerCerto( @cCodi )
	@ 07, 03 Say "Servidor....:" Get cNome  Pict "@!"
	@ 08, 03 Say "Cargo.......:" Get cCargo Pict "@!"
	@ 09, 03 Say "Carga Mensal:" Get nCarga Pict "999999.99"
	@ 10, 03 Say "Senha.......:"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	cSenha := Senha( 10, 17, 14 )
	ErrorBeep()
	nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
	IF nOpcao = 1 // Incluir
		IF SerCerto( @cCodi )
			IF Servidor->(Incluiu())
				 Servidor->Codi  := cCodi
				 Servidor->Nome  := cNome
				 Servidor->Cargo := cCargo
				 Servidor->Carga := nCarga
				 Servidor->Senha := MsEncrypt( cSenha )
				 Servidor->(Libera())
			Endif
		Endif
	ElseIF nOpcao = 2  // Alterar
		Loop
	ElseIF nOpcao = 3  // Sair
		Exit
	EndIF
EndDo
ResTela( cScreen )
Return

*:==================================================================================================================================

Function SenhaServidor( cCodi )
*******************************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cSenha
LOCAL Passe

Servidor->(Order( SERVIDOR_CODI ))
DbSeek( Servidor->( cCodi ))
WHILE OK
	oMenu:Limpa()
	cSenha := MsDecrypt( Servidor->Senha )
	MaBox( 10, 11, 12, 47 )
	Write( 11, 12, "Senha de acesso..: " )
	Passe  := Senha( 11, 32, 14 )
	IF LastKey() = ESC
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
	EndIF
	IF !Empty( Passe) .AND. ( AllTrim( cSenha ) == AllTrim( Passe ))
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( OK )
	Else
		ErrorBeep()
		IF Conf("Pergunta: Senha Nao Confere. Novamente ?")
			Loop
		EndIF
		AreaAnt( Arq_Ant, Ind_Ant )
		ResTela( cScreen )
		Return( FALSO )
  EndIF
EndDo

*:==================================================================================================================================

Function AlterarSenha( cCodi )
******************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL cSenha1
LOCAL cSenha2

oMenu:Limpa()
Servidor->(Order( SERVIDOR_CODI ))
IF cCodi = NIL
	MaBox( 00, 10, 04, 50 )
	@ 01, 11 Say "Servidor....: " Get cCodi Pict "@!" Valid UsuarioErrado( @cCodi )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Return NIL
	EndIF
EndIF
IF SenhaServidor( cCodi )
	WHILE OK
		MaBox( 00, 10, 04, 50 )
		@	 01, 11 Say "Servidor.............: " + cCodi
		Write( 02, 11, "Nova Senha...........: " )
		Write( 03, 11, "Verificacao de Senha.: " )
		cSenha1 := Senha( 02, 34, 14 )
		cSenha2 := Senha( 03, 34, 14 )
		IF LastKey() = ESC
			ResTela( cScreen )
			Return NIL
		EndIF
		IF Empty( cSenha1 )
			Loop
		EndIF
		IF cSenha1 == cSenha2
			ResTela( cScreen )
			Return( MsEncrypt( cSenha1 ))
		EndIF
		ErrorBeep()
		IF Conf("Erro: Senha nao Confere. Novamente ?")
			Loop
		EndIF
		ResTela( cScreen )
		Return NIL
	EndDo
EndIF
ResTela( cScreen )
Return NIL

*:==================================================================================================================================

Function SerCerto( cCodi )
**************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

IF Empty( cCodi )
	ErrorBeep()
	Alerta( "Erro: Codigo Servidor Invalido...")
	Return( FALSO )
EndIf
Area("Servidor")
Servidor->(Order( SERVIDOR_CODI ))
IF Servidor->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta( "Erro: Codigo Servidor Registrado.")
	cCodi := StrZero( Val( cCodi ) + 1, 4 )
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( FALSO )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:==================================================================================================================================

Function ServErrado( cCodi, nRow, nCol )
****************************************
LOCAL aRotina := {{|| Servidor() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Servidor")
Servidor->(Order( SERVIDOR_CODI ))
IF Servidor->(!DbSeek( cCodi ))
	Servidor->( Order( SERVIDOR_NOME ))
	Servidor->(Escolhe( 00, 00, 24, "Codi + ' ' + Nome", "CODI NOME DO SERVIDOR", aRotina ))
EndIF
cCodi := Servidor->Codi
IF nRow != Nil
	Write( nRow, nCol, Servidor->Nome )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( OK )

*:==================================================================================================================================

Proc ListaServidor()
********************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aParcial   := { " Geral   ", " Parcial   " }
LOCAL nChoice	  := 0
LOCAL nParcial   := 0
LOCAL cCodiIni   := Space(04)
LOCAL cCodiFim   := Space(04)
LOCAL oBloco

WHILE OK
	oMenu:Limpa()
	M_Title("ESC Retorna")
	nParcial := FazMenu( 04, 10, aParcial, Cor())
	Do Case
	Case nParcial = 0
		ResTela( cScreen )
		Return

	Case nParcial = 1
		Area("Servidor")
		Servidor->(Order( SERVIDOR_NOME ))
		Servidor->(DbGoTop())
		oBloco := { || Servidor->(!Eof()) }
		PrintServidor( oBloco )

	Case nParcial = 2
		cCodiIni   := Space(4)
		cCodiFim   := Space(4)
		MaBox( 10, 10, 13, 79 )
		@ 11, 11 Say 'Codigo Inicial.:' Get cCodiIni Pict '9999' Valid ServErrado( @cCodiIni, Row(), Col()+1 )
		@ 12, 11 Say 'Codigo Final...:' Get cCodiFim Pict '9999' Valid ServErrado( @cCodiFim, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Area("Servidor")
		Servidor->(Order( SERVIDOR_CODI ))
		oBloco := { || Servidor->Codi >= cCodiIni .AND. Servidor->Codi <= cCodiFim }
		Servidor->(DbSeek( cCodiIni ))
		PrintServidor( oBloco )
	EndCase
EndDo

*:==================================================================================================================================

Proc PrintServidor( oBloco )
****************************
LOCAL cScreen := SaveScreen()
LOCAL Col	  := 9
LOCAL Tam	  := CPI1280
LOCAL cTitulo := "LISTAGEM DE SERVIDORES"
LOCAL Pagina  := 0
FIELD Codi
FIELD Nome
FIELD Cargo
FIELD Carga

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem("Aguarde, Imprimindo.")
PrintOn()
FPrint( _CPI12 )
SetPrc( 0, 0 )
Col := 58
WHILE Eval( oBloco ) .AND. Rel_Ok()
	IF Col >=  58
		Write( 00, 00, Linha1( Tam, @Pagina))
		Write( 01, 00, Linha2())
		Write( 02, 00, Linha3(Tam))
		Write( 03, 00, Linha4(Tam, SISTEM_NA8 ))
		Write( 04, 00, Padc( cTitulo, Tam ) )
		Write( 05, 00, Linha5(Tam))
		Write( 06, 00, "CODI NOME DO SERVIDOR                         CARGO                         CARGA HORARIA")
		Write( 07, 00, Linha5(Tam))
		Col := 8
	EndIf
	Qout( Codi, Nome, Cargo, Carga )
	Col++
	DbSkip()
	IF Col >= 58 .OR. Eof()
		Write( Col, 0, Repl( SEP, Tam ))
		__Eject()
	EndIf
EndDo
PrintOff()
ResTela( cScreen )
Return

*:==================================================================================================================================

Proc PontoAuto()
****************
LOCAL GetList := {}
LOCAL aMenu   := { "Entrada Manha", "Saida Manha", "Entrada Tarde", "Saida Tarde"}
LOCAL cScreen := SaveScreen( )
LOCAL cString := ""
LOCAL cMovi   := ""
LOCAL nOpcao  := 0
LOCAL nChoice := 0
LOCAL cCodi   := Space(04)
LOCAL dData   := Date()

WHILE OK
	oMenu:Limpa()
	M_Title("ESCOLHA O PERIODO")
	nChoice := FazMenu( 05, 05, aMenu )
	IF nChoice = 0
		ResTela( cScreen )
		Return
	EndIF
	cString := "INCLUSAO DE PONTO: " + Upper( aMenu[nChoice] )
	WHILE OK
		cCodi := Space(04)
		MaBox( 13, 05, 15, 78, cString )
		@ 14, 06 Say "Codigo......:" Get cCodi   Pict "9999"     Valid CodiErrado( @cCodi,, Row(), Col()+1 )
		Read
		IF LastKey() = ESC
			Exit
		EndIf
		IF !SenhaServidor( cCodi )
			Loop
		EndIF
		ErrorBeep()
		nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
		IF nOpcao = 1 // Incluir
			cMovi := cCodi + DateToStr( dData )
			Area("Ponto")
			Ponto->(Order( PONTO_CODI_DATA ))
			IF Ponto->(!DbSeek( cMovi ))
				Ponto->(Incluiu())
				Ponto->Codi := cCodi
				Ponto->Data := dData
			Else
				Ponto->(TravaReg())
			EndIF
			IF nChoice = 1
				Ponto->Manha1	 := Time()
			ElseIF nChoice = 2
				Ponto->Manha2	 := Time()
			ElseIF nChoice = 3
				Ponto->Tarde1	 := Time()
			ElseIF nChoice = 4
				Ponto->Tarde2	 := Time()
			EndIF
			CalculaPonto(Ponto->( RecNo() ))
			Ponto->(Libera())
		ElseIF nOpcao = 2  // Alterar
			Loop
		ElseIF nOpcao = 3  // Sair
			Exit
		EndIF
	EndDo
EndDo
ResTela( cScreen )
Return

*:==================================================================================================================================

Proc MoviPonto()
****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen( )
LOCAL nSoma1  := 0
LOCAL nSoma2  := 0
LOCAL nSobra  := 0
LOCAL nCarga  := 0
LOCAL cCodi   := Space(04)
LOCAL cManha1 := Space(05)
LOCAL cManha2 := Space(05)
LOCAL cTarde1 := Space(05)
LOCAL cTarde2 := Space(05)
LOCAL dData   := Date()
LOCAL nOpcao

oMenu:Limpa()
Area("Ponto")
Ponto->(Order( PONTO_CODI ))
WHILE OK
	MaBox( 05, 02, 10, 78, "INCLUSAO DE PONTO" )
	@ 06, 03 Say "Codigo......:" Get cCodi   Pict "9999"     Valid CodiErrado( @cCodi,,06, 22 )
	@ 07, 03 Say "Data........:" Get dData   Pict "##/##/##" Valid LastKey() = UP .OR. AchaMov( cCodi, dData )
	@ 08, 03 Say "Manha.......:" Get cManha1 Pict "99:99" Valid VerHora( cManha1 )
	@ 08, 24 						  Get cManha2 Pict "99:99" Valid VerHora( cManha2 )
	@ 09, 03 Say "Tarde.......:" Get cTarde1 Pict "99:99" Valid VerHora( cTarde1 )
	@ 09, 24 						  Get cTarde2 Pict "99:99" Valid VerHora( cTarde2 )
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIf
	ErrorBeep()
	nOpcao := Alerta( "Pergunta: Voce Deseja ?", {" Incluir ", " Alterar ", " Sair "})
	IF nOpcao = 1 // Incluir
		IF AchaMov( cCodi, dData )
			IF Ponto->(Incluiu())
				Ponto->Codi 	 := cCodi
				Ponto->Data 	 := dData
				Ponto->Manha1	 := cManha1
				Ponto->Manha2	 := cManha2
				Ponto->Tarde1	 := cTarde1
				Ponto->Tarde2	 := cTarde2
				CalculaPonto(Ponto->( RecNo() ))
				Ponto->(Libera())
			EndiF
		EndiF
	ElseIF nOpcao = 2  // Alterar
		Loop
	ElseIF nOpcao = 3  // Sair
		Exit
	EndIF
EndDo
ResTela( cScreen )
Return

*:==================================================================================================================================

Function VerHora( cHora )
*************************
LOCAL nHora   := Val( Left( cHora, 2 ))
LOCAL nMinuto := Val( Right( cHora, 2 ))
LOCAL nTam	  := Len( AllTrim( cHora ))

IF nTam < 5  // 00:00
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	Return( FALSO )
EndIF
IF nHora > 24
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	Return( FALSO )
EndIF
IF nMinuto > 59
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	Return( FALSO )
EndIF
IF nHora = 24 .AND. nMinuto > 0
	ErrorBeep()
	Alerta("Erro: Hora Invalida.")
	Return( FALSO )
EndiF
Return( OK )

*:==================================================================================================================================

STATIC Function CodiErrado( cCodi, cNome, nRow, nCol)
*****************************************************
LOCAL aRotina := {{|| Servidor() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Servidor")
Servidor->(Order( IF( cCodi = Space(40), SERVIDOR_NOME, SERVIDOR_CODI )))
IF Servidor->(!DbSeek( cCodi ))
	Servidor->(Order( SERVIDOR_NOME ))
	Servidor->(DbGoTop())
	Escolhe( 00, 00, 24, "Codi + ' ' + Nome", 'CODIGO     NOME DO SERVIDOR', aRotina )
EndIF
cCodi := Servidor->Codi
cNome := Servidor->Nome
IF nRow != Nil
	Write( nRow  , nCol, cNome )
EndiF
AreaAnt( Arq_Ant, Ind_Ant )
Return(OK)

*:==================================================================================================================================

Function AchaMov( cCodi, dData )
********************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cString := cCodi + Dtoc( dData )

Area("Ponto")
Ponto->(Order( PONTO_CODI_DATA ))
IF Ponto->(!DbSeek( cString ))
	AreaAnt( Arq_Ant, Ind_Ant )
	Return( OK )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
ErrorBeep()
Alerta("Erro: Use Pesquisa/Altera Ponto.")
Return(FALSO)

*:==================================================================================================================================

Proc MoviDbedit()
*****************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Servidor->(Order( SERVIDOR_CODI ))
Area("Ponto")
Set Rela To Ponto->Codi Into Servidor
Ponto->( Order( PONTO_CODI_DATA ))
Ponto->(DbGoTop())
oBrowse:Add( "CODIGO",       "Codi",           "9999")
oBrowse:Add( "DATA",         "Data",           "##/##/##")
oBrowse:Add( "ENT MANHA",    "Manha1",         "99:99")
oBrowse:Add( "SAI MANHA",    "Manha2",         "99:99")
oBrowse:Add( "ENT TARDE",    "Tarde1",         "99:99")
oBrowse:Add( "SAI TARDE",    "Tarde2",         "99:99")
oBrowse:Add( "CARGA HORARIA","Quant",          "999999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE MOVIMENTO"
oBrowse:PreDoGet := {|| PreMovi( oBrowse ) } // Rotina do Usuario Antes de Atualizar
oBrowse:PosDoGet := {|| PosMovi( oBrowse ) } // Rotina do Usuario apos Atualizar
oBrowse:PreDoDel := NIL
oBrowse:PosDoDel := NIL
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

*:==================================================================================================================================

Function PreMovi( oBrowse )
***************************
LOCAL oCol	  := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar := 0

Do Case
Case oCol:Heading = "NOME"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida.")
	Return( FALSO )
Case oCol:Heading = "CARGA HORARIA"
	ErrorBeep()
	Alerta("Erro: Alteracao nao permitida.")
	Return( FALSO )
EndCase
IF oBrowse:ColPos >= 3 .AND. oBrowse:ColPos <= 6
	IF Ponto->(TravaReg())
		CalculaPonto()
		Ponto->(Libera())
		Return( OK )
	EndIF
EndIF
Return( OK )

*:==================================================================================================================================

Function PosMovi( oBrowse )
***************************
LOCAL oCol		 := oBrowse:getColumn( oBrowse:colPos )
LOCAL nMarVar	 := 0
LOCAL cCodi 	 := Space(04)
LOCAL Arq_Ant	 := Alias()
LOCAL Ind_Ant	 := IndexOrd()
LOCAL cManha1	 := Ponto->Manha1

Do Case
Case oCol:Heading = "CODI"
	cCodi := Ponto->Codi
	CodiErrado( @cCodi )
	Ponto->Codi := cCodi
	AreaAnt( Arq_Ant, Ind_Ant )
Case oCol:Heading = "ENT MANHA"
	VerHora( Ponto->Manha1 )
Case oCol:Heading = "SAI MANHA"
	VerHora( Ponto->Manha2 )
Case oCol:Heading = "ENT TARDE"
	VerHora( Ponto->Tarde1 )
Case oCol:Heading = "SAI TARDE"
	VerHora( Ponto->Tarde2 )
EndCase
Return( OK )

STATIC Proc AbreArea()
**********************
LOCAL cScreen := SaveScreen()
ErrorBeep()
Mensagem("Aguarde, Abrindo base de dados.", WARNING, _LIN_MSG )
FechaTudo()

IF !UsaArquivo("PONTO")
	MensFecha()
	Return
EndiF

IF !UsaArquivo("SERVIDOR")
	MensFecha()
	Return
EndIF

IF !UsaArquivo("VENDEDOR")
	MensFecha()
	Return
EndIF
Return



*:==================================================================================================================================

Function oMenuPontoLan()
***********************
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
AADD( AtPrompt, {"Sair",               {"Encerrar Sessao"}})
AADD( AtPrompt, {"Inclusao",           {"Servidores", "Ponto Manual", "Ponto Automatico"}})
AADD( AtPrompt, {"Alteracao",          {"Servidores", "Ponto", "Ajustar Carga Horaria"}})
AADD( AtPrompt, {"Consulta",           {"Servidores", "Ponto"}})
AADD( AtPrompt, {"Exclusao",           {"Servidores", "Ponto"}})
AADD( AtPrompt, {"Relatorios",         {"Servidores", "Folha Ponto"}})
AADD( AtPrompt, {"Help",               {"Help"}})
Return( AtPrompt )

*:==================================================================================================================================

Function aDispPontoLan()
************************
LOCAL oPontolan := TIniNew( oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI")
LOCAL AtPrompt := oMenuPontoLan()
LOCAL nMenuH   := Len(AtPrompt)
LOCAL aDisp 	:= Array( nMenuH, 22 )
LOCAL aMenuV   := {}

Mensagem("Aguarde, Verificando Diretivas do CONTROLE DE PONTO.")
Return( aDisp := ReadIni("pontolan", nMenuH, aMenuV, AtPrompt, aDisp, oPontoLan))

*:==================================================================================================================================

Proc ListaPonto()
*****************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen( )
LOCAL aParcial   := { " Individual ", " Geral " }
LOCAL dIni		  := Date()-30
LOCAL dFim		  := Date()
LOCAL cCodi 	  := Space(04)
LOCAL nParcial   := 0
LOCAL oBloco1
LOCAL oBloco2

WHILE OK
	oMenu:Limpa()
	M_Title("LISTAGEM DE PONTO")
	nParcial := FazMenu( 04, 10, aParcial, Cor())
	Do Case
	Case nParcial = 0
		ResTela( cScreen )
		Return

	Case nParcial = 1
		cCodi := Space(04)
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 10, 10, 14, 79 )
		@ 11, 11 Say 'Codigo.......:' Get cCodi Pict '9999' Valid ServErrado( @cCodi, Row(), Col()+1 )
		@ 12, 11 Say 'Data Inicial.:' Get dIni  Pict '##/##/##'
		@ 13, 11 Say 'Data Final...:' Get dFim  Pict '##/##/##'
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Servidor->(Order( SERVIDOR_CODI ))
		Servidor->(DbSeek( cCodi ))
		Ponto->(Order( PONTO_CODI_DATA ))
		oBloco1 := {|| Servidor->Codi = cCodi }
		oBloco2 := {|| Ponto->Data >= dIni .AND. Ponto->Data <= dFim }
		FolhaPonto( oBloco1, oBloco2, dIni, dFim )

	Case nParcial = 2
		dIni	:= Date()-30
		dFim	:= Date()
		MaBox( 10, 10, 13, 40 )
		@ 11, 11 Say 'Data Inicial.:' Get dIni Pict '##/##/##'
		@ 12, 11 Say 'Data Final...:' Get dFim Pict '##/##/##' Valid dFim >= dIni
		Read
		IF LastKey() = ESC
			Loop
		EndIF
		Servidor->(Order( SERVIDOR_CODI ))
		Servidor->(DbGoTop())
		Ponto->(Order( PONTO_CODI_DATA ))
		oBloco1 := {|| Servidor->(!Eof()) }
		oBloco2 := {|| Ponto->Data >= dIni .AND. Ponto->Data <= dFim }
		FolhaPonto( oBloco1, oBloco2, dIni, dFim )
	EndCase
EndDo


Proc AjustaCarga()
******************
LOCAL cScreen := SaveScreen()

Area("Ponto")
IF Ponto->(TravaArq())
	Ponto->(DbGoTop())
	Mensagem("Aguarde, Ajustando Carga Horaria.")
	WHILE Ponto->(!Eof())
		CalculaPonto()
		Ponto->( dbSkip(1) )
	EndDo
	Ponto->(Libera())
EndIF
Restela( cScreen )
Return

Proc FolhaPonto( oBloco1, oBloco2, dIni, dFim )
***********************************************
LOCAL cScreen	  := SaveScreen( )
LOCAL Col		  := 58
LOCAL Tam		  := 132
LOCAL nLargura   := 120
LOCAL cTitulo    := 'RELATORIO DO CARTAO DE PONTO DO SERVIDOR : '
LOCAL cCodi 	  := Space(04)
LOCAL cPeriodo   := ''
LOCAL cNome 	  := ''
LOCAL nCarga	  := 0
LOCAL nGeral	  := 0
LOCAL Pagina	  := 0
LOCAL nSobra1	  := 0
LOCAL nSobra	  := 0
LOCAL nQuant	  := 0
LOCAL nSoma1	  := 0
LOCAL nSoma2	  := 0
LOCAL nNormal	  := 0
LOCAL nSabado	  := 0
LOCAL nDomingo   := 0
LOCAL nExtra	  := 0
LOCAL nExtraSab  := 0
LOCAL nExtraNor  := 0

IF !Instru80()
	ResTela( cScreen )
	Return
EndIF
Mensagem( "Aguarde, Imprimindo.")
PrintOn()
FPrint( PQ )
WHILE Eval( oBloco1 ) .AND. Rel_Ok()
	SetPrc( 0, 0 )
	Pagina	:= 0
	Col		:= 58
	nCarga	:= 0
	nGeral	:= 0
	nSabado	:= 0
	nNormal	:= 0
	nDomingo := 0
	nExtra	:= 0
	nSobra1	:= 0
	nSobra	:= 0
	cCodi 	:= Servidor->Codi
	cNome 	:= Alltrim( Servidor->Nome )
	cPeriodo := ' REF O PERIODO DE ' + Dtoc( dIni ) + ' A ' + Dtoc( dFim )
	IF Ponto->(DbSeek( cCodi ))
		WHILE Ponto->Codi = cCodi .AND. REL_OK()
			IF Eval( oBloco2 )
				IF Col >=  58
					Write( 00, 00, Linha1( Tam, @Pagina))
					Write( 01, 00, Linha2())
					Write( 02, 00, Linha3(Tam))
					Write( 03, 00, Linha4(Tam, SISTEM_NA8 ))
					Write( 04, 00, Padc( cTitulo + cNome + cPeriodo, Tam ) )
					Write( 05, 00, Linha5(Tam))
					Write( 06, 00, 'DATA        DIA SEMANA     ENT MANHA   SAI MANHA   ENT TARDE   SAI TARDE   HORAS TRAB  HRS EXTRA  HRS EX SAB')
					Write( 07, 00, Linha5(Tam))
					Col := 8
				EndIF
				cDia		:= Upper(cDowPort( Ponto->Data))
				nTamanho := Len( cDia )
				nExtraSab := Ponto->Quant - 4
				nExtraNor := Ponto->Quant - 8
				IF nExtraSab < 0
					nExtraSab := 0
				EndIF
				IF nExtraNor < 0
					nExtraNor := 0
				EndIF
				Qout( Ponto->Data,	'  |  ', ;
						cDia + Space(8-nTamanho), '  |  ',;
						Ponto->Manha1, '  |  ',;
						Ponto->Manha2, '  |  ',;
						Ponto->Tarde1, '  |  ',;
						Ponto->Tarde2, '  |  ',;
						Tran( Ponto->Quant, '99.99'), '  |  ' )
						IF cDia = 'SABADO'
							QQout( Space(05), '  |  ' )
							QQout( Tran( nExtraSab, '99.99'), '  |  ')
						Else
							QQout( Tran( nExtraNor, '99.99'), '  |  ')
						EndIF
				nCarga  += Ponto->Quant
				nGeral  += Ponto->Quant
				nSobra1 := nGeral - Int( nGeral )
				nSobra  := nCarga - Int( nCarga )
				IF cDia = 'SABADO'
					nSabado	+= nExtraSab
				ElseIF cDia = 'DOMINGO'
					nDomingo += ( Ponto->Quant )
				Else
					nNormal += nExtraNor
				EndIF
				IF ( nSobra > 0.59 )
					nCarga -= nSobra
					nSobra -= 0.6
					nCarga ++
					nCarga += nSobra
				EndIF
				IF ( nSobra1 > 0.59 )
					nGeral  -= nSobra1
					nSobra1 -= 0.6
					nGeral  ++
					nGeral  += nSobra1
				EndIF
				nRestNormal := nNormal - Int( nNormal )
				IF ( nRestNormal > 0.59 )
					nNormal		-= nRestNormal
					nRestNormal -= 0.6
					nNormal		++
					nNormal		+= nRestNormal
				EndIF
				nRestSabado := nSabado - Int( nSabado )
				IF ( nRestSabado > 0.59 )
					nSabado		-= nRestSabado
					nRestSabado -= 0.6
					nSabado		++
					nSabado		+= nRestSabado
				EndIF
				nRestDomingo := nDomingo - Int( nDomingo )
				IF ( nRestDomingo > 0.59 )
					nDomingo 	 -= nRestDomingo
					nRestDomingo -= 0.6
					nDomingo 	 ++
					nDomingo 	 += nRestDomingo
				EndIF
				Col++
				IF Col >= 57
					nQuant := 0
					Write( ++Col, 0, "** Sub-Total **" + Space(64) + Tran( nCarga, "999999.99"))
					__Eject()
				EndIF
			EndIF
			Ponto->(DbSkip(1))
		EndDo
		nExtra	:= (( nNormal + nSabado ) + nDomingo )
		cExtenso := Extenso( nGeral, 3, 2, nLargura )
		Write(	Col, 00, Linha5(Tam))
		Write( ++Col, 01, 'TOTAL DE HORAS TRABALHADAS NO PERIODO..: ' + Tran( nGeral, '999999.99'))
		Write( ++Col, 06, Left( cExtenso, nLargura ))
		Write( ++Col, 06, Right( cExtenso, nLargura ))
		Write( ++Col, 00, Linha5(Tam))
		Write( ++Col, 00, 'HRS EXTRAS SEGUNDA/SEXTA  |   HRS EXTRAS SABADOS  |  HRS EXTRAS DOMINGOS  |   TOTAL HRS EXTRAS   |')
		Write( ++Col, 08, Tran( nNormal,  "999999.99"))
		Write(	Col, 26, '|')
		Write(	Col, 35, Tran( nSabado,  "999999.99"))
		Write(	Col, 50, '|')
		Write(	Col, 58, Tran( nDomingo, "999999.99"))
		Write(	Col, 74, '|')
		Write(	Col, 82, Tran( nExtra,	 "999999.99"))
		Write(	Col, 97, '|')
		Write( ++Col, 00, Linha5(Tam))
		Write( ++Col, 01, 'TOTAL DE HORAS EXTRAS NO PERIODO.......: ' + Tran( nExtra, '999999.99'))
		Col++
		Col++
		Col++
		Col++
      Write( ++Col, 01, 'DECLARO CONCORDAR PLENAMENTE COM O PRESENTE DEMOSTRATIVO DE HORAS, QUE TEVE COMO BASE O MEU CARTAO PONTO, COM HORARIOS AUTENTICADOS')
      Write( ++Col, 01, 'MECANICA/ELETRONICAMENTE, NOS DIAS QUE TRABALHEI DURANTE ESTE PERIODO, QUE FICARA ARQUIVADO EM PODER DA EMPRESA,  DO QUAL DOU MINHA')
      Write( ++Col, 01, 'PLENA,GERAL E IRREVOGAVEL QUITACAO.')
		Col++
		Col++
		Col++
		Write( ++Col, 01, Space(44) + Repl('-',40))
		Write( ++Col, 01, '____/____/____' + Space(30) + cNome )
		__Eject()
		IF !Rel_Ok()
			Exit
		EndiF
	EndiF
	Servidor->(DbSkip(1))
EndDo
PrintOff()
ResTela( cScreen )
Return

Proc CalculaPonto()
*******************
FIELD Manha1
FIELD Manha2
FIELD Tarde1
FIELD Tarde2
LOCAL nSoma1 := TimeDiff( Manha1, Manha2)
LOCAL nSoma2 := TimeDiff( Tarde1, Tarde2)
LOCAL nSobra := 0
LOCAL nCarga := 0

IF ( Ponto->Manha1 = "00:00" .AND. Ponto->Manha2 = "24:00" .AND. Ponto->Tarde1 = "00:00" .AND. Ponto->Tarde2 = "00:00" )
	 Nsoma1 := "24:00:00"
ENDIF
IF ( Ponto->Manha1 = "00:00" .AND. Ponto->Tarde2 = "24:00" .AND. Ponto->Manha2 = "00:00" .AND. Ponto->Tarde1 = "00:00" )
	 Nsoma1 := "24:00:00"
ENDIF
nSoma1  := Val(Stuff(Left(Nsoma1, 5), 3, 1, "."))
nSoma2  := Val(Stuff(Left(Nsoma2, 5), 3, 1, "."))
***************************************************
nSobra1 := nSoma1 - Int( nSoma1 )
nSobra2 := nSoma2 - Int( nSoma2 )
nCarga  := Int( nSoma1) + Int( nSoma2 )
nDiff   := ( nSobra1 + nSobra2 )
IF nDiff > 0.59
	 nDiff -= 0.6
	 nCarga ++
ENDIF
Ponto->Quant := ( nCarga + nDiff )
Return
