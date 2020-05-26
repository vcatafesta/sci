/*
  ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
 Ý³																								 ?
 Ý³	Programa.....: FUNCOES.PRG 														 ?
 Ý³	Aplicacaoo...: MODULO DE FUNCOES DE APOIO AO SCI							 ?
 Ý³	Versao.......: 19.50 																 ?
 Ý³	Programador..: Vilmar Catafesta													 ?
 Ý³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ?
 Ý³	Inicio.......: 12 de Novembro de 1991. 										 ?
 Ý³	Ult.Atual....: 06 de Dezembro de 1998. 										 ?
 Ý³	Compilacao...: Clipper 5.2d														 ?
 Ý³	Linker.......: Blinker 3.20														 ?
 Ý³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ?
 ÝÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

#Include "Achoice.Ch"
#include "ctnnet.ch"
#Include "Funcoes.Ch"
#Include "Inkey.Ch"
#Include "Set.Ch"
#include "Fileman.ch"
#include "Box.Ch"
#include "Common.Ch"
#include "Fileio.Ch"
#include "Directry.Ch"
#include "getexit.Ch"
#include "permissao.ch"
#include "indice.ch"

#Define VAR_AGUDO   39								 && Indicador de agudo
#Define VAR_CIRCUN  94								 && Indicador de circunflexo
#Define VAR_TREMA   34								 && Indicador de trema
#Define VAR_CEDMIN  91								 && Cedilha min?culo opcional [
#Define VAR_CEDMAI  123 							 && Cedilha mai?culo opcional {
#Define VAR_GRAVE   96								 && Indicador de grave
#Define VAR_TIL	  126 							 && Indicador de til
#Define VAR_HIFEN   95								 && Indicador de ??sublinhado+a/o
#Define S_TOP		  0
#Define S_BOTTOM	  1
#translate P_Def( <var>, <val> ) => IF( <var> = NIL, <var> := <val>, <var> )
#translate IfNil( <var>, <val> ) => IF( <var> = NIL, <var> := <val>, <var> )

#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 IF <v1> == NIL ; <v1> := <x1> ; END									;
			 [; IF <vn> == NIL ; <vn> := <xn> ; END ]
#XCOMMAND DEFAU <v1> TO <x1> [, <vn> TO <xn> ]								;
			 =>																				;
			 IF <v1> == NIL ; <v1> := <x1> ; END									;
			 [; IF <vn> == NIL ; <vn> := <xn> ; END ]

	
static Static13
static Static14
static Static1 := "ÕÍ¸³¾ÍÔ³"
static Static2 := ""
static Static3 := {1, 1, 0, 0, 0, 0, 0, 0, 0, 24, 79, 1, 0, 0, 0, 1, 8, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, -999, 0, 0, Nil}

Function VerDebitosEmAtraso()
*****************************
LOCAL nNivel := SCI_VERIFICAR_DEBITOS_EM_ATRASO
IF !Empty( aPermissao )
	IF aPermissao[ nNivel ]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeExcederDescMax()
*****************************
LOCAL nNivel := SCI_PODE_EXCEDER_DESCONTO_MAXIMO
IF !Empty( aPermissao )
	IF aPermissao[ nNivel ]
		Return( OK )
	EndIF
	IF !PedePermissao( nNivel )
		Return( FALSO )
	EndIF
	Return( OK )
EndIF
Return( FALSO )


Function PodeMudarData( dEmis )
*******************************
LOCAL nNivel := SCI_ALTERAR_DATA_FATURA
IF dEmis == Date()
	Return( OK )
EndIF
IF !Empty( aPermissao )
	IF aPermissao[ nNivel ]
		Return( OK )
	EndIF
	IF !PedePermissao( nNivel )
		Return( FALSO )
	EndIF
	Return( OK )
EndIF
Return( FALSO )

Function PodeRecDataDif( dEmis )
********************************
LOCAL nNivel := SCI_ALTERAR_DATA_BAIXA
IF dEmis == Date()
	Return( OK )
EndIF
IF !Empty( aPermissao )
	IF aPermissao[ nNivel ]
		Return( OK )
	EndIF
	IF !PedePermissao( nNivel )
		Return( FALSO )
	EndIF
	Return( OK )
EndIF
Return( FALSO )

Function PodeReceber()
**********************
IF !Empty( aPermissao )
	IF aPermissao[ SCI_RECEBIMENTOS ]
		Return( OK )
	EndIF
	nNivel := SCI_RECEBIMENTOS
	IF !PedePermissao( nNivel )
		Return( FALSO )
	EndIF
	Return( OK )
EndIF
Return( FALSO )

Function PodePagar()
********************
IF !Empty( aPermissao )
	IF aPermissao[ SCI_PAGAMENTOS ]
		Return( OK )
	EndIF
	nNivel := SCI_PAGAMENTOS
	IF !PedePermissao( nNivel )
		Return( FALSO )
	EndIF
	Return( OK )
EndIF
Return( FALSO )

Function PodeVenderComLimiteEstourado()
**************************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_VENDER_COM_LIMITE_ESTOURADO]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function VerificarLimiteCredito()
*********************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_VERIFICAR_LIMITE_DE_CREDITO]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function TipoCadastro()
***********************
IF !Empty( aPermissao )
	IF aPermissao[SCI_TIPO_DE_CADASTRO_DE_CLIENTE]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeBaixarTituloAVista()
*********************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_BAIXAR_TITULO_QDO_VENDA_A_VISTA]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeFaturarComEstoqueNegativo()
****************************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_FATURAR_COM_ESTOQUE_NEGATIVO]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeFazerBackup()
*************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_COPIA_DE_SEGURANCA]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeFazerRestauracao()
*******************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_RESTAURAR_COPIA_SEGURANCA]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeAlterar()
*********************
IF !Empty( aPermissao )
	IF aPermissao[SCI_ALTERACAO_DE_REGISTROS]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeTrocarEmpresa()
****************************
IF !Empty( aPermissao )
	IF aPermissao[SCI_TROCAR_DE_EMPRESA]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeIncluir()
*********************
IF !Empty( aPermissao )
	IF aPermissao[SCI_INCLUSAO_DE_REGISTROS]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function PodeExcluir()
*********************
IF !Empty( aPermissao )
	IF aPermissao[SCI_EXCLUSAO_DE_REGISTROS]
		Return( OK )
	EndIF
EndIF
Return( FALSO )

Function Configuracao( lMicrobras, lNaoMostrarConfig)
*****************************************************
LOCAL nX 		:= 1
LOCAL nChoice	:= 1
LOCAL cString	:= ""
LOCAL cUnidade := ""
LOCAL cCurDir  := FCurdir()
LOCAL cPath    := FCurdir()
LOCAL cTemp 	:= StrTran( Time(),":")
LOCAL cDbf
LOCAL cCfg
LOCAL cBase
LOCAL cDia
LOCAL cMes
LOCAL cAno
LOCAL lPiracy
LOCAL i
LOCAL dDate
LOCAL nHandle
LOCAL nErro
LOCAL Handle
LOCAL xMicrobras
LOCAL xEndereco
LOCAL xTelefone
LOCAL xCidade
LOCAL aEnde_String := {}
LOCAL aEnde_Codigo := {}
LOCAL aMensagem	 := Array(2,5)
		aMensagem[1,1] := "[Limite de Codigo de Acesso Vencido]"
		aMensagem[1,2] := "1 - A data do Sistema Operacional esta correta ?"
		aMensagem[1,3] := "2 - O arquivo SCI.EXE esta com data diferente do DOS ?"
		aMensagem[1,4] := "3 - Caso Negativo, solicite novo Codigo de Acesso."
		aMensagem[1,5] := ""

		aMensagem[2,1] := "[Verificacao de Copia Original]"
		aMensagem[2,2] := "1 - O SCI esta sendo instalado pela 1?vez ?"
		aMensagem[2,3] := "2 - Esta atualizando a versao do SCI ?"
		aMensagem[2,4] := "3 - Esta instalando um novo terminal ?"
		aMensagem[2,5] := "4 - Caso Afirmativo, solicite Codigo de Acesso."

IfNil( lMicrobras, FALSO )
IfNil( lNaoMostrarConfig, FALSO )
PUBLIC XNOMEFIR
PUBLIC SISTEM_NA1
PUBLIC SISTEM_NA2
PUBLIC SISTEM_NA3
PUBLIC SISTEM_NA4
PUBLIC SISTEM_NA5
PUBLIC SISTEM_NA6
PUBLIC SISTEM_NA7
PUBLIC SISTEM_NA8
PUBLIC SISTEM_VERSAO
PUBLIC XNOME_EXE

cBase := oAmbiente:xBase
CenturyOn()
IF !FChdir( oAmbiente:xBase )
   oAmbiente:xBase += "\"
EndIF
FChdir( oAmbiente:xBase )
oAmbiente:xBase := cBase
//Set Defa To (oAmbiente:xBase)
IF !lNaoMostrarConfig
   Qout("þ Localizando Arquivo SCI.DBF.")
EndIF

cPath := cCurDir
cDbf  := cPath + 'SCI.DBF'

IF !File( cDbf )
   cPath := oAmbiente:xBase + "\"
   cDbf  := cPath + 'SCI.DBF'
   IF !File( cDbf )
      SetColor("")
      Cls
      Alert( "Erro #1: Arquivo SCI.DBF" + ;
             ";Nao localizado em: " + cCurdir + Space(Len(cCurdir+cPath)-Len(cCurdir)) + ;
             ";Nao localizado em: " + cPath   + Space(Len(cCurdir+cPath)-Len(cPath)))
      Quit
   EndIF
   cPath := oAmbiente:xBase
EndIF
QQout(" þOK")
Set Defa To (cPath)
Qout("þ Abrindo Arquivo SCI.DBF em " + cPath)
IF !NetUse( 'SCI.DBF', OK )
	Quit
EndIF
QQout(" þOK")
Qout("þ Lendo Arquivo SCI.DBF em " + cPath)
For x := 1 To Sci->(FCount())
	IF Sci->(FieldName( x )) != "TIME"
		IF Sci->(Empty( FieldGet( x )))
			EncerraDbf( FieldName( x ), Procname(), ProcLine())
		End
	End
Next
IF ( XNOMEFIR				 := Sci->( AllTrim( Nome	  ))) != Sci->( MsDcriptar( AllTrim( Empresa  ))) .OR. Empty( XNOMEFIR	 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA1			 := Sci->( AllTrim( Nome_Sci ))) != Sci->( MsDcriptar( AllTrim( Codi_Sci ))) .OR. Empty( SISTEM_NA1 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA2			 := Sci->( AllTrim( Nome_Est ))) != Sci->( MsDcriptar( AllTrim( Codi_Est ))) .OR. Empty( SISTEM_NA2 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA3			 := Sci->( AllTrim( Nome_Rec ))) != Sci->( MsDcriptar( AllTrim( Codi_Rec ))) .OR. Empty( SISTEM_NA3 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA4			 := Sci->( AllTrim( Nome_Pag ))) != Sci->( MsDcriptar( AllTrim( Codi_Pag ))) .OR. Empty( SISTEM_NA4 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA5			 := Sci->( AllTrim( Nome_Che ))) != Sci->( MsDcriptar( AllTrim( Codi_Che ))) .OR. Empty( SISTEM_NA5 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA6			 := Sci->( AllTrim( Nome_Ven ))) != Sci->( MsDcriptar( AllTrim( Codi_Ven ))) .OR. Empty( SISTEM_NA6 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA7			 := Sci->( AllTrim( Nome_Pro ))) != Sci->( MsDcriptar( AllTrim( Codi_Pro ))) .OR. Empty( SISTEM_NA7 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_NA8			 := Sci->( AllTrim( Nome_Pon ))) != Sci->( MsDcriptar( AllTrim( Codi_Pon ))) .OR. Empty( SISTEM_NA8 ) 	; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF ( SISTEM_VERSAO		 := Sci->( AllTrim( Nome_Ver ))) != Sci->( MsDcriptar( AllTrim( Codi_Ver ))) .OR. Empty( SISTEM_VERSAO ) ; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
IF Empty(( XNOME_EXE 	 := Sci->(MsDcriptar( AllTrim( NomeExe ))))) ; EncerraDbf(, ProcName(), ProcLine()) ; EndIF
   oAmbiente:XLIMITE     := Sci->Limite
lPiracy := AllTrim( XCFGPIRACY ) != Sci->( AllTrim( Empresa  ))
Sci->(DbCloseArea())
IF lPiracy
	SetColor("")
	Cls
	ErrorBeep()
	Alert( "Erro #0: Favor instalar arquivo SCI.DBF original.")
	Quit
EndIF
QQout(" þOK")

IF !lNaoMostrarConfig
   Qout("þ Localizando Arquivo SCI.CFG.")
EndIF

cPath := cCurDir
cCfg  := cPath + 'SCI.CFG'

IF !File(cCfg)
   cPath := oAmbiente:xBase + "\"
   cCfg  := cPath + 'SCI.CFG'
   IF !File( cCfg )
      SetColor("")
      Cls
      Alert( "Erro #1: Arquivo SCI.CFG" + ;
             ";Nao localizado em: " + cCurdir + Space(Len(cCurdir+cPath)-Len(cCurdir)) + ;
             ";Nao localizado em: " + cPath   + Space(Len(cCurdir+cPath)-Len(cPath)))
      Quit
   EndIF
EndIF
QQout(" þOK")
Qout("þ Abrindo Arquivo SCI.CFG em " + cPath)
Handle := FOpen(cCfg)
IF ( Ferror() != 0 )
	FClose( Handle )
	SetColor("")
	Cls
	Alert( "Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
	Quit
EndIF
Qout("þ Lendo Arquivo SCI.CFG em " + cPath)
QQout(" þOK")
nErro := MsLocate( Handle, "[ENDERECO_STRING]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG alterada. [ENDERECO_STRING]")
	Quit
EndIF
MsAdvance( Handle )
For nX := 1 To 4
	Aadd( aEnde_String, AllTrim( MsReadLine( Handle )))
Next
nErro := MsLocate( Handle, "[ENDERECO_CODIGO]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #5: Configuracao de SCI.CFG alterada. [ENDERECO_CODIGO]")
	Quit
EndIF
MsAdvance( Handle )
For nX := 1 To 4
	Aadd( aEnde_Codigo, MsDcriptar( AllTrim( MsReadLine( Handle ))))
Next
For nX := 1 To 4
	IF aEnde_Codigo[nX] != aEnde_String[nX]
		SetColor("")
		Cls
		Alert( "Erro #6: Configuracao de SCI.CFG alterada. [ENDERECO_CODIGO]")
		Quit
	EndiF
Next
FClose( Handle )
VerExe()
IF !lNaoMostrarConfig
	Qout("þ Verificando Aplicativo.")
EndIF
*:*******************************************************************************
oAmbiente:xDataCodigo := MsDcriptar( oAmbiente:XLIMITE )
cDia						 := SubStr( oAmbiente:xDataCodigo, 4, 2 )
cMes						 := Left(  oAmbiente:xDataCodigo, 2 )
cAno						 := Right( oAmbiente:xDataCodigo, 4 )
oAmbiente:xDataCodigo := cDia + "/" + cMes + "/" + cAno
IF !lMicrobras
	*:*******************************************************************************
	Set Date To USA
   cLimite     := MsDcriptar( oAmbiente:XLIMITE )
	cDataDos 	:= Dtoc( Date())
	cTela 		:= SaveScreen()
	IF Ctod( cDataDos ) > Ctod( cLimite )
		Hard( 1, ProcName(), ProcLine() )
	EndIF
	Set Date Brit
	ResTela( cTela )
	IF !lNaoMostrarConfig
		Qout("þ Verificando Sistema Instalado.")
	EndIf
	cUnidade := Left( Getenv("COMSPEC"), 2 )
	IF !CopyOk()
		Hard( 2, ProcName(), ProcLine() )
		CopyCria()
	EndIF
EndIF
IF !lNaoMostrarConfig
	LogoTipo( aEnde_String )
EndIF
CenturyOff()
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
Return

Conf( nRow, nCol, nRow1, nCol1 )
********************************************
LOCAL PBack
LOCAL Exceto	 := .F.
LOCAL Ativo 	 :=  1
LOCAL cCor		 := 112
LOCAL nComp 	 := ( nCol1 - nCol )-1
Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", 112, 1, 8 )
Print( nRow, nCol, '?, 127, 1 )
Print( nRow, nCol+1, Repl('?,nComp), 127 )
For x := nRow+1 To nRow1
	Print( x, nCol, '?, 127, 1 )
Next
Print( nRow1, nCol, '?,  127,1 )
SetColor("N/W,W+/R")
Return

Proc AcionaSpooler()
********************
Set Key F8 To
Spooler()
Set Key F8 To AcionaSpooler()
Return

Proc SaidaParaEmail()
*********************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL xArquivo := ""
LOCAL xTemp    := FTempName('T*.TXT')
LOCAL cTo		:= Space(40)
LOCAL cFrom 	:= oIni:ReadString('sistema', 'email', Space(40))
LOCAL cSubject := 'Enviando Email : ' + xTemp + Space(10)
LOCAL xServer	:= oIni:ReadString('sistema','smtp', 'SMTP.MICROBRAS.COM.BR' + Space(19))
LOCAL xString
LOCAL i

oMenu:Limpa()
xArquivo := oAmbiente:xBaseDados + "\" + xTemp + Space(10)
MaBox( 15, 00, 21, 79 )
@ 16, 01 Say "Para    : " Get cTo      Pict "@!" Valid IF(Empty(cTo),      ( ErrorBeep(), Alerta("Ooops!: Vai enviar para quem ?"), FALSO ), OK )
@ 17, 01 Say "De      : " Get cFrom    Pict "@!" Valid IF(Empty(cFrom),    ( ErrorBeep(), Alerta("Ooops!: Nao vai dizer o email de quem enviou ?"), FALSO ), OK )
@ 18, 01 Say "Anexo   : " Get xArquivo Pict "@!" Valid IF(Empty(xArquivo), ( ErrorBeep(), Alerta("Ooops!: Entre com o Anexo!"), FALSO ), OK )
@ 19, 01 Say "Assunto : " Get cSubject Pict "@!" Valid IF(Empty(cSubject), ( ErrorBeep(), Alerta("Ooops!: Entre com o Assunto!"), FALSO ), OK )
@ 20, 01 Say "Servidor: " Get xServer  Pict "@!" Valid IF(Empty(xServer),  ( ErrorBeep(), Alerta("Ooops!: Entre com o servidor!"), FALSO ), OK )

Read
IF LastKey() = 27
	oAmbiente:cArquivo := ""
	ResTela( cScreen )
	Return
EndiF
cFrom 	:= AllTrim( cFrom )
cTo		:= AllTrim( cTo )
cSubject := AllTrim( cSubject )
xServer	:= AllTrim( xServer )
oAmbiente:Spooler  := OK
oAmbiente:cArquivo := xArquivo
xArquivo           := AllTrim( xArquivo )
Set Print To ( xArquivo )
Mensagem('Aguarde, Enviando Email.')
/*
xString := 'mail.bat'
xString += ' -a ' + xArquivo
xString += '  ' + xServer
xString += '  ' + cFrom
xString += '  ' + cTo
*/
xstring := 'mail.bat'
FChdir( oAmbiente:xBaseDoc )
Set Defa To ( oAmbiente:xBaseDoc )
i = SWPVIDMDE(OK)
i = SWPDISMSG(OK)
i = SWPFREEMS(640)
i = SWPFREXMS(640)
i = SWPSETENV(32000)
i = SWPADDENV(2048)
i := SWPRUNCMD( xString , 100, "", "")
FChdir( oAmbiente:xBaseDados )
Set Defa To ( oAmbiente:xBaseDados )
ResTela( cScreen )
Return

Proc SaidaParaArquivo()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL xArquivo := ""

oMenu:Limpa()
xArquivo := oAmbiente:xBase + "\TXT\" + FTempName("#*.TXT") + Space(10)
MaBox( 15, 00, 17, 79 )
@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
Read
IF LastKey() = ESC
	oAmbiente:cArquivo := ""
	ResTela( cScreen )
	Return
EndiF
xArquivo := AllTrim( xArquivo )
oAmbiente:Spooler  := OK
oAmbiente:cArquivo := xArquivo
Set Print To ( xArquivo )
ResTela( cScreen )
Return

Proc SaidaParaSpooler()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL xArquivo := ""

oMenu:Limpa()
xArquivo := oAmbiente:xBase + "\SPOOLER\" + FTempName("#*.PRN") + Space(10)
MaBox( 15, 00, 17, 79 )
@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
Read
IF LastKey() = 27
	oAmbiente:cArquivo := ""
	ResTela( cScreen )
	Return
EndiF
oAmbiente:Spooler  := OK
oAmbiente:cArquivo := xArquivo
xArquivo := AllTrim( xArquivo )
Set Print To ( xArquivo )
ResTela( cScreen )
Return

Proc SaidaParaHtml()
********************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL xArquivo := ""

oMenu:Limpa()
xArquivo := oAmbiente:xBase + "\HTM\" + FTempName("T*.TXT") + Space(10)
MaBox( 15, 00, 17, 79 )
@ 16, 01 Say "Visualizar no Arquivo: " Get xArquivo Pict "@!"
Read
IF LastKey() = 27
	oAmbiente:cArquivo := ""
	ResTela( cScreen )
	Return
EndiF
oAmbiente:Spooler  := OK
oAmbiente:cArquivo := xArquivo
oAmbiente:externo  := OK
Set Print To ( xArquivo )
ResTela( cScreen )
Return

Proc SaidaParaUsb()
*******************
LOCAL cScreen	:= SaveScreen()
LOCAL GetList	:= {}
LOCAL xArquivo := ""
LOCAL i

oMenu:Limpa()
xArquivo := oAmbiente:xBaseDados + "\" + FTempName("T*.TMP") + Space(10)
oAmbiente:Spooler  := FALSO
oAmbiente:cArquivo := xArquivo
xArquivo := AllTrim( xArquivo )
Set Print To ( xArquivo )
i = SWPUSEEMS(OK)
i = SWPUSEXMS(OK)
i = SWPUSEUMB(OK)
i = SWPVIDMDE(OK)
i = SWPCURDIR(OK)
i = SWPDISMSG(FALSO) // Mostrar Mensagem
i = SWPGETKEY(FALSO) // Aguardar Tecla
xString := "COPY /B " + xArquivo + " PRN"
i		  := SWPRUNCMD( xString, 0, "", "" )
ResTela( cScreen )
Return

Function Alerta( cString, aArray )
**********************************
IF oAmbiente:Visual
	aArray := IIF( aArray = NIL, {"&OK"}, aArray )
	nTam := Len( aArray )
	IF 	 nTam = 1
		nButton := MsgBox1( cString, SISTEM_NA1 )
		Return( nButton )
	ElseIF nTam = 2
		aArray[1] := "&" + AllTrim( aArray[1] )
		aArray[2] := "&" + AllTrim( aArray[2] )
		nButton := MsgBox2( cString, SISTEM_NA1, NIL, aArray[1], aArray[2] )
		Return( nButton )
	ElseIF nTam = 3
		aArray[1] := "&" + AllTrim( aArray[1] )
		aArray[2] := "&" + AllTrim( aArray[2] )
		aArray[3] := "&" + AllTrim( aArray[3] )
		nButton := MsgBox3( cString, SISTEM_NA1, NIL, aArray[1], aArray[2], aArray[3] )
		Return( nButton )
	ElseIF nTam > 3
		nButton := Alert( cString, aArray, oAmbiente:CorAlerta )
		Return( nButton )
	EndIF
ELSE
	aArray := IIF( aArray = NIL, { " Okay " }, aArray )
	Return( Alert( cString, aArray, oAmbiente:CorAlerta ))
ENDIF

Proc Nada(cString, lLimpaTela)
******************************
LOCAL cScreen := SaveScreen()

IfNil( cString, "INFO: Nada consta nos parametros informados.")
IF lLimpaTela = NIL
   oMenu:Limpa()
EndIF
ErrorBeep()
Alerta( cString )
ResTela( cScreen )
Return

Proc AreaAnt( Arq_Ant, Ind_Ant )
************************************
IF !Empty( Arq_Ant )
	Select( Arq_Ant )
	Order( Ind_Ant )
EndIF
Return

Function Rep_Ok()
*****************
LOCAL cScreen := SaveScreen()
LOCAL cCor	  := SetColor()

IF Inkey() = 27
	Set Devi To Screen
	IF Conf("Pergunta: Deseja Interromper a Tarefa ?")
		Return( FALSO )
	EndIF
	SetColor( cCor )
	ResTela( cScreen )
EndIF
Return( OK )

Function Rel_Ok()
*****************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 2
LOCAL nRow	  := Prow()
LOCAL nCol	  := PCol()

IF Inkey() == 27
	Set Print Off
	Set Devi To Scre
	ErrorBeep()
	IF Conf("Pergunta: Deseja cancelar a impressao ?")
		Set Prin Off
		Set Print to
		Set Devi To Screen
		Set Cons On
		ResTela( cScreen )
		Break
	EndIF
	IF !LptOk()
		Set Devi To Screen
		Set Prin Off
		Set Cons On
		Set Print to
		Break
	EndIF
	ResTela( cScreen )
	Set Print On
	Set Devi To Print
	SetPrc( nRow, nCol )
EndIF
Return( OK )

Function LptOk()
****************
LOCAL cScreen
LOCAL lRetorno := OK
LOCAL nComPort := 1
LOCAL aAction	:= { "Erro: Impressora Fora de Linha. ",;
						  "Erro: Impressora Desligada.     ",;
						  "Erro: Impressora Sem Papel.     ",;
						  "Erro: Impressora Nao Conectada. ",;
						  "Erro: Impressora Nao Pronta.    "}
LOCAL nStatus
IF oAmbiente:Isprinter <= 3
	nStatus := PrnStatus( oAmbiente:Isprinter )
	IF !oAmbiente:Spooler
		cScreen := SaveScreen()
		oMenu:Limpa()
		WHILE !FIsPrinter( oAmbiente:Isprinter )
			nStatus := PrnStatus( oAmbiente:IsPrinter )
			IF nStatus = -1
				nStatus := 5
			EndIF
			ErrorBeep()
			nDecisao := Alerta( aAction[ nStatus], {" Tentar ", " Retornar "} )
			IF nDecisao = 2
				lRetorno := FALSO
				Exit
			EndIF
		EndDo
		ResTela( cScreen )
	EndIF
ELSE
	nComPort := ( oAmbiente:IsPrinter - 4 )
	lRetorno := ( nStatus := IsCom( nComPort ))
EndIF
Return( lRetorno )

Function AbreSpooler()
**********************
IIF( oAmbiente:Spooler, Set( _SET_PRINTFILE, oAmbiente:cArquivo, FALSO ), Set( _SET_PRINTFILE, "" ))
Return Nil

Function CloseSpooler()
***********************
LOCAL cScreen	:= SaveScreen()
LOCAL lTemp 	:= oAmbiente:Spooler
LOCAL cTemp 	:= oAmbiente:cArquivo
LOCAL lexterno := oAmbiente:externo
LOCAL cComando
LOCAL i

Set(_SET_PRINTFILE, "" )
Set Print To

IF lexterno
	//cComando := 'c:\arquiv~1\intern~1\iexplore.exe ' + oAmbiente:cArquivo
   //cComando := 'iexplore.exe ' + oAmbiente:cArquivo
   cComando := 'firefox.exe ' + oAmbiente:cArquivo
   i = SWPUSEEMS(OK)
	i = SWPUSEXMS(OK)
	i = SWPUSEUMB(OK)
	i = SWPCURDIR(OK)
	i = SWPVIDMDE(OK)
	//i = SWPDISMSG(OK)
	i = SWPRUNCMD( cComando, 0, "", "")
	oAmbiente:externo := FALSO
Else
	IF lTemp
		oMenu:Limpa()
		M_Title( "ESC - Retorna ?etas CIMA/BAIXO Move")
      M_View( 00, 00, MaxRow(), MaxCol(), cTemp, Cor())
		ResTela( cScreen )
	EndIF
EndIF
//oAmbiente:cArquivo := ""
oAmbiente:Spooler  := FALSO
Return Nil

Function Toggle_Acento()
************************
IF oAmbiente:Acento
	Desliga_Acento()
Else
	Liga_Acento()
endif

Function Liga_Acento()
**********************
Set Key VAR_AGUDO  To Act_Geral()
Set Key VAR_CIRCUN To Act_Geral()
Set Key VAR_TREMA  To Act_Geral()
Set Key VAR_CEDMIN To Act_Geral()
Set Key VAR_CEDMAI To Act_Geral()
Set Key VAR_GRAVE  To Act_Geral()
Set Key VAR_TIL	 To Act_Geral()
Set Key VAR_HIFEN  To Act_Geral()
oAmbiente:Acento := OK

Function Desliga_Acento()
*************************
set key VAR_AGUDO  to
set key VAR_CIRCUN to
set key VAR_TREMA  to
set key VAR_CEDMIN to
set key VAR_CEDMAI to
set key VAR_GRAVE  to
set key VAR_TIL	 to
set key VAR_HIFEN  to
oAmbiente:Acento := FALSO

Function Act_Geral()
********************
LOCAL COD_ACENTO := Chr( LastKey())
LOCAL VAR_CNF_AC := ['a 'e‚'i?o?u?A†'E'I‹'OŸ'U–'c‡'C€] + ; && Agudo
						  [`a…`eŠ`i`o•`u—`A‘`E’`I˜`O?U`c‡`C€] + ; && Grave
						  [^aƒ^eˆ^o“^A^E‰^OŒ^c‡^C€]				  + ; && Circunflexo
						  [~a„~n?o”~AŽ~N?O™~c‡~C€]				  + ; && Til
						  ["u"Uš]                               + ; && Trema
						  [_a?A?o?O?								  + ; && H?en
						  [" ‡{ €]                                   && Cedilha

IF COD_ACENTO $ "[{"
	COD_ACENTO += " "
Else
	COD_ACENTO += chr( abs( inkey( 0 ) ) )
EndIF
COD_ACENTO = at( COD_ACENTO, VAR_CNF_AC )
if COD_ACENTO != 0
	keyboard substr( VAR_CNF_AC, COD_ACENTO + 2, 1 )
else
	ErrorBeep()
	KeyBoard lastkey()
EndIF
oAmbiente:Acento := OK

Proc GravaDisco()
*****************
LOCAL cScreen := SaveScreen()

oMenu:Limpa()
Mensagem("Aguarde, Gravando em Disco." )
DbCommitAll()
ResTela( cScreen )
Return

Function Area( cArea)
*********************
DbSelectArea( cArea )
Return NIl

Proc Altc( cTexto )
*******************
LOCAL cScreen := SaveScreen()
LOCAL cCor	  := SetColor()
SetColor("")
Cls
ErrorBeep()
IF Conf("Encerrar a Execucao do Aplicativo ?")
	DbCommitAll()
	DbCloseAll()
	UnClock12()
	FChDir( oAmbiente:xBase )
	Cls
	F_Fim( cTexto )
	lOk := FALSO
	Quit
EndiF
SetColor( cCor )
ResTela( cScreen )
Return

Proc VerRelato()
****************
LOCAL cScreen := SaveScreen()
LOCAL Files := "*.*"
LOCAL Arquivo

M_Title( "Setas CIMA/BAIXO Move")
WHILE .T.
	Arquivo := M_PopFile( 06, 10, 22, 57, Files, Cor())
	IF Empty( Arquivo )
		Beep( 1 )
		ResTela( cScreen )
		Exit

	Else
		cScreen1 := SaveScreen()
      M_View( 00, 00, MaxRow(), MaxCol, Arquivo, Cor())
		ResTela( cScreen1 )
  EndIF
EndDO
Return

Proc Spooler()
**************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

LOCAL aMenuChoice := { " Imprimir Para Impressora ",;
							  " Imprimir Para Arquivo    ",;
							  " Visualizar Arquivo       ",;
							  " Escolher Impressora      "}
WHILE OK
	M_Title("SPOOLER")
	nChoice := FazMenu( 05, 50, aMenuChoice, Cor())
	Do Case
	Case nChoice = 0
		IF !Empty( Arq_Ant)
			Select( Arq_Ant )
			Order( Ind_Ant )
		EndiF
		ResTela( cScreen )
		Exit

	Case nChoice = 1
		oAmbiente:cArquivo := ""
		oAmbiente:Spooler  := FALSO
		ResTela( cScreen )
		Exit

	Case nChoice = 2
		oAmbiente:cArquivo := IIF( Empty( oAmbiente:cArquivo ), oAmbiente:xBaseDados + "\" +  FTempName("T*.TMP") + Space(10), oAmbiente:cArquivo )
		MaBox( 15, 10, 17 , 79 )
		@ 16, 11 Say "Arquivo de Impressao... ¯ " Get oAmbiente:cArquivo Pict "@!"
		Read
		IF LastKey() = 27
			oAmbiente:cArquivo := ""
			ResTela( cScreen )
			Exit

		EndiF
		oAmbiente:Spooler := OK
      cArq              := AllTrim( oAmbiente:cArquivo )
		ResTela( cScreen )
		Exit

	Case nChoice = 3
		MaBox( 15, 10, 17 , 79 )
		@ 16, 11 Say "Arquivo a Visualizar... ¯ " Get oAmbiente:cArquivo Pict "@!"
		Read
		IF LastKey() = 27
			ResTela( cScreen )
			Exit

		EndiF
		IF !IsFile( oAmbiente:cArquivo )
			ErrorBeep()
			Alerta(" O Arquivo Nao Existe... ")
			ResTela( cScreen )
			Exit
		Else
         oAmbiente:Externo := FALSO
         oAmbiente:Spooler := OK
         //M_View( 00, 00, MaxRow(), MaxCol(), oAmbiente:cArquivo, Cor())
         CloseSpooler()
         oAmbiente:Spooler := FALSO
		EndIF
		ResTela( cScreen )
		Exit

	Case nChoice = 4
		Impressora()
	EndCase
EndDo
Return

Proc SetaFonte()
****************
LOCAL nChoice		 := 1
STATIC aVmodes 	 := { 3, 43, 50 }
STATIC aModeMenu	 :={"Resetar Fonte Para Normal",;
						  "80x25 Linhas - CGA EGA VGA Somente", ;
						  "80x43 Linhas - EGA & VGA Somente",;
						  "80x50 Linhas - VGA Somente",;
						  "Fonte Digital" ,;
						  "Avante Garde",;
						  "Fonte 3270",;
						  "Fonte Broadway",;
						  "Fonte Cyrillic",;
						  "Fonte Percy",;
						  "Fonte Legenda",;
						  "Fonte Caligrafia",;
						  "Fonte Script1",;
						  "Fonte Script2",;
						  "Fonte Italica1",;
						  "Fonte Italica2",;
						  "Fonte Romana",;
						  "Fonte Ingles Velho",;
						  "Fonte Bauhaus",;
						  "Fonte Bodoni",;
						  "Fonte Garamond",;
						  "Fonte Avenida",;
						  "Fonte Computador",;
						  "Fonte Grego",;
						  "Fonte Hebreu"}
	M_Title("SELECIONE FONTE/MODO DE VIDEO")
	nChoice := AmaxChoice( 03, 10, 20, 45, aModeMenu, Cor())
	Do Case
	Case nChoice = 0
		Return
	Case VidType() == 0
		ErrorBeep()
		Alerta("Erro: Placa de Video Monocromatica." )
		Return
	EndCase
	oAmbiente:Fonte := nChoice
	Eval( oAmbiente:TabelaFonte[ nChoice] )
	Palette( oAmbiente:CorAntiga, oAmbiente:PanoFundo )
   M_Data( 10, MaxRow()- 2 )
   M_Data( 26, MaxRow()- 2 )
	Return

Function Refresh()
******************
DbSkip(0)
Return Nil

Function TravaReg( nTentativa, aRegistros )
******************************************
LOCAL cScreen := SaveScreen()
LOCAL lContinua, Restart := OK
nTentativa := IIF( nTentativa = Nil, 2, nTentativa )
lContinua  := ( nTentativa == 0 )

WHILE Restart
	WHILE ( !RLock() .AND. ( nTentativa > 0 .OR. lContinua ))
		  Mensagem(" Travando Registro " + AllTrim(Str( Recno())) + " no Arquivo " + Alias(), CorBox())
		  IF InKey(1) = ESC
			  Exit
		  EndIF
		  nTentativa--
	EndDo
	IF !RLock()
		IF !Conf("Registro em uso. Tentar Novamente ? " )
			 ResTela( cScreen )
			 Return( FALSO )
		EndIF
		ResTart := OK
		nTentativa := 4

	Else
		ResTela( cScreen )
		Return( OK )
	EndIF
EndDo

Function TravaArq()
*******************
IF Flock()
	Return( OK )
EndIF
WHILE !FLock()
	ErrorBeep()
	IF !Conf("Arquivo em uso em outra Esta‡ao. Tentar Novamente ?" )
		Return( FALSO )
	EndIF
	IF FLock()
		Return( OK )
	EndIF
EndDo
Return( OK )

Function Incluiu()
******************
DbAppend()
IF !NetErr()
	Return( OK )
EndIF
DbAppend()
WHILE NetErr()
	ErrorBeep()
	IF !Conf("Registro em uso em outra Esta‡ao. Tentar Novamente ? " )
		Return( FALSO )
	EndIF
	DbAppend()
	IF !NetErr()
		Return( OK )
	EndIF
EndDo
Return( OK )

Function Libera()
*****************
//DbCommit()			  // Atualiza Buffers
DbSkip(0)				// Refresh
DbGoto( Recno())		// Refresh
DbUnLock()				// Libera Registros / Arquivos
Return Nil

Function Cor( nTipo )
*********************
IfNil( nTipo, 1 )
IF nTipo = 1
	Return( oAmbiente:CorMenu	)
EndIF
Return( oAmbiente:CorCabec )

Function CorBox( nTipo )
************************
IfNil( nTipo, 1 )
Return( oAmbiente:CorAlerta )

Function CorBoxCima( nTipo )
***************************
IfNil( nTipo, 1 )
Return( oAmbiente:CorCima )

Function SetaCor( nCor, nTipo )
*******************************
LOCAL ikey
LOCAL cScreen
LOCAL CorAnt
STATIC XColor
IfNil( nTipo, 1 )
XColor := Cor( nTipo )
CorAnt := Cor( nTipo )
M_CsrOff()
//cScreen := SaveVideo( 01, 00, MaxRow()-1, MaxCol())
cScreen := SaveVideo( 01, 00, MaxRow()-1, MaxCol())
M_CsrOn()
WHILE .T.
	M_Message("Cor Atual ¯¯ "+ Str( XColor ) + " - Enter Para Setar ou ESCape", Cor(nTipo))
	Ikey := WaitKey( ZERO )
	IF ( Ikey == 24)
		 XColor	:= IIF( XColor  == 0, 255, --XColor  )

	 ELSEIF ( Ikey == 5)
		 XColor	:= IIF( XColor  == 255, 0, ++XColor  )

	 ELSEIF ( Ikey == 27)
		 nCor := CorAnt
		 Exit

	 ELSEIF ( Ikey == 13)
		  Exit

	 EndIF
	 nCor := XColor

ENDDO
SetAttrib("y", nCor - 1 )
M_CsrOff()
RestVideo( 01, 00, MaxRow()-1, MaxCol(), cScreen )
M_CsrOn()
Return VOID

Function Calc( cProc, nLine, cVar )
***********************************
LOCAL cScreen := SaveScreen()
LOCAL cColor  := Setcolor()
LOCAL GetList := {}
LOCAL cCalc   := Chr(77)+Chr(97)+Chr(99)+Chr(114)+Chr(111)+Chr(115)+Chr(111)+Chr(102)+Chr(116)+Chr(32)+Chr(67)+Chr(65)+Chr(76)+Chr(67)
LOCAL entry
LOCAL fcode
LOCAL mcode
LOCAL calcdec
LOCAL dec
LOCAL accum
LOCAL enter
LOCAL deccnt
LOCAL calcscr
LOCAL pcount
LOCAL inkey
LOCAL code
LOCAL calcclr
LOCAL rowsave
LOCAL colsave
LOCAL procname

@ 04,45 Clea To 19,70
SetColor('BG+')
StatusInf("x = *³ö = /?, "ESC-RETORNA")
MaBox( 04, 45, 06, 70 )
MaBox( 19, 45, 21, 70 )
Write( 20, 46, "Mem.")
Row := 7
WHILE Row < 17
  @ Row, 45 TO Row+2, 48
  @ Row, 50 TO Row+2, 53
  @ Row, 54 TO Row+2, 57
  @ Row, 58 TO Row+2, 61
  @ Row, 63 TO Row+2, 66
  @ Row, 67 TO Row+2, 70
  Row += 3

EndDo
SetColor("GR+")
@ 8,46 SAY "AC"
@ 8,51 SAY " 7"
@ 8,55 SAY " 8"
@ 8,59 SAY " 9"
@ 8,64 SAY " /"
@ 8,68 SAY " R"
@ 11,46 SAY "MR"
@ 11,51 SAY " 4"
@ 11,55 SAY " 5"
@ 11,59 SAY " 6"
@ 11,64 SAY " *"
@ 11,68 SAY " %"
@ 14,46 SAY "M-"
@ 14,51 SAY " 1"
@ 14,55 SAY " 2"
@ 14,59 SAY " 3"
@ 14,64 SAY " -"
@ 14,68 SAY "CE"
@ 17,46 SAY "M+"
@ 17,51 SAY " 0"
@ 17,55 SAY " ."
@ 17,59 SAY " ="
@ 17,64 SAY " +"
@ 17,68 SAY "C "
entry=0
calcdec=0
calcacc=0
calcmem=0
dec=.F.
fcode="+"
code=" "
accum=.T.
enter=.T.
inkey=13
mcode=" "
Set Deci To 4
WHILE .T.
  SetColor("GR+/RB,gr+/rb")
  @ 20,40+11 SAY calcmem PICT "99999999999999.9999"
  SetColor("GR+/R,N/W+")
  IF accum
	 @ 5,40+7 SAY "T"
	 @ 5,40+11 SAY calcacc PICT "99999999999999.9999"
  Else
	 @ 5,40+7 SAY fcode
	 @ 5,40+11 SAY entry+calcdec PICT "99999999999999.9999"
  EndIF
  inkey=InKey(0)
  code=Chr(inkey)
  Do Case
	 Case code>="0" .AND. code<="9"
		IF enter .OR. fcode=" "
		  calcacc=0
		  entry=0
		  calcdec=0
		  fcode="+"
		EndIF
		accum=.F.
		IF ! dec
		  entry=entry*10+VAL(code)
		Else
		  IF deccnt<1000
			 calcdec=calcdec+VAL(code)/deccnt
			 deccnt=deccnt*10
		  EndIF
		EndIF
	 Case code="."
		accum=.F.
		dec=.T.
		deccnt=10
	 Case (code="+" .OR. code="-" .OR. code="/" .OR. code="*";
		.OR. code="R" .OR. code="%" .OR. inkey=13) .AND. mcode=" "
		accum=.T.
		IF inkey#13 .AND. enter
		Else
		  Do Case
			 Case fcode="+"
				IF code="%"
				  calcacc=calcacc+calcacc*.01*(entry+calcdec)
				Else
				  calcacc=calcacc+(entry+calcdec)
				EndIF
			 Case fcode="-"
				IF code="%"
				  calcacc=calcacc-calcacc*.01*(entry+calcdec)
				Else
				  calcacc=calcacc-(entry+calcdec)
				EndIF
			 Case fcode="*"
				calcacc=calcacc*(entry+calcdec)
			 Case fcode="/"
					IF (entry+calcdec) = 0
						Accum := .F.
						CalcAcc := CalcDec := Entry := 0
						CalcMem := 0.00
						Mcode=" "
						Fcode=" "

					Else
						Calcacc=calcacc/(entry+calcdec)

					EndIF
			 Case Upper( fcode ) = "R"
				calcacc = SQRT( calcacc )

		 EndCase
		EndIF
		dec=.F.
		IF code="%"
		  fcode=" "
		EndIF
		IF inkey#13
		  fcode=code
		  entry=0
		  calcdec=0
		EndIF
	 Case Upper( code ) ="A"
		mcode="A"
	 Case Upper( code ) ="M"
		mcode="M"
	 Case Upper( code ) ="C" .AND. mcode = " "
		mcode="C"
	 Case Upper( code ) ="C" .AND. mcode="A"
		accum=.T.
		calcacc=0
		calcdec=0
		entry=0
		calcmem=0.00
		mcode=" "
		fcode=" "
	 Case Upper ( code ) ="C" .AND. Upper( mcode ) ="M"
		calcmem=0.00
		mcode=" "
	 Case Upper( code ) = "E" .AND. Upper( mcode ) ="C"
		entry=0
		calcdec=0
		dec=.F.
		mcode=" "
		accum=.F.
		fcode=" "
	 Case Upper( mcode ) ="C" .AND. inkey=13
		entry=0
		calcdec=0
		calcacc=0
		dec=.F.
		mcode=" "
		fcode=" "
		accum=.T.
	 Case Upper( code ) ="R" .AND. Upper( mcode ) ="M"
		entry=calcmem
		accum=.F.
		dec=.F.
		mcode=" "
	 Case code="-" .AND. Upper( mcode ) = "M"
		calcmem=calcmem-calcacc
		mcode=" "
		calcdec=0
		entry=0
		fcode=" "
		accum=.T.
	 Case code="+" .AND. Upper( mcode ) ="M"
		calcmem=calcmem+calcacc
		mcode=" "
		calcdec=0
		entry=0
		fcode=" "
		accum=.T.
	 Case Upper( code ) = "X"
		 Set Deci To 2
		 SetColor( cColor )
		 ResTela( cScreen )
		 Keyb Chr( K_CTRL_Y ) + AllTrim(Str( CalcAcc )) + Chr( K_UP ) + Chr( K_DOWN )
		 Return
	 Case inkey = 27
		 Set Deci To 2
		 SetColor( cColor )
		 ResTela( cScreen )
		 Return
	 OtherWise
		ErrorBeep()
  EndCase
  enter=.f.
  IF inkey=13
	  enter=.T.
  EndIF
EndDo
Set Deci To 2
SetColor( cColor )
ResTela( cScreen )
Return Nil

Function Abre( nRow1, nCol1, nRow2, nCol2 )
********************************************
LOCAL nMeio1 := Round(( nCol2 - nCol1 )  / 2,0)
LOCAL nMeio2 := Round(( nCol2 - nCol1 )  / 2,0)
SetColor("W+/B")
For _X := nMeio2 To nCol2
	Scroll( nRow1+1, nMeio1+1, nRow2-1, nMeio2, 0 )
	@ nRow1, nMeio1 To nRow2, nMeio2
	nMeio1 := IIF( nMeio1 = nCol1, nMeio1, --nMeio1 )
	nMeio2 := IIF( nMeio2 = nCol2, nMeio1, ++nMeio2 )

Next
Return Nil

Function CabecRel( cNomefir, nTam, nPagina, cSistema, cRelatorio, cCabecalho )
********************************************************************
Write(01 , 00, Padr( "Pagina N?" + StrZero( nPagina, 3 ), ( nTam/2 ) ) + Padl( Time(), ( nTam/2 ) ) )
Write(02 , 00, Date() )
Write(03 , 00, Padc( cNomefir, nTam ) )
Write(04 , 00, Padc( cSistema, nTam ) )
Write(05 , 00, Padc( cRelatorio, nTam ) )
Write(06 , 00, Repl( SEP, nTam ) )
Write(07 , 00, cCabecalho )
Write(08 , 00, Repl( SEP, nTam ) )
Return Nil

Function Ascii()
*****************
LOCAL cScreen := SaveScreen()
Scroll(  01, 64, MaxRow()-4, 79 ) ; SetPos( 01, 64 )
DispBox( 01, 64, MaxRow()-4, 79, 2 )
DevPos(	01, 73 ) ; DevOut( CHR(209) )
DevPos(	02, 66 ) ; DevOut( "Numero "+CHR(179)+" Chr" )
DevPos(	03, 64 ) ; DevOut( CHR(204)+Repl(CHR(205),8)+CHR(216)+Repl(CHR(205),5)+CHR(185) )
DispBox( 04, 73, MaxRow()-5, 73, CHR(179) )
DevPos(	20, 73 ) ; DevOut( CHR(207) )
StatusInf("USE AS SETAS PARA MUDAR A TABELA ASCII", "ESC-RETORNA")
SetColor( "W,G+" )
H_T := " "
H_L := 4
H_C := 0
while H_T <> CHR(27)
	SetColor( "G+" )
	H_TEMP := H_C
	FOR H_L=4 TO 19
		DevPos( H_L, 68 ) ; DevOutPict( H_TEMP, "###" )
		DevPos( H_L, 76 ) ; DevOut( CHR(H_TEMP) )
		H_TEMP := H_TEMP+1

	NEXT
	H_L := 4
	SetColor( "W,G+" )
	H_T := " "
	WHILE AT(H_T,CHR(5)+CHR(24)+CHR(27))=0
		H_T := CHR(INKEY())

	EndDO
	Do Case
		Case H_T=CHR(05)
			  H_C := H_C-16
			  IF H_C<0
				  H_C := 240
			  EndIF
		Case H_T=CHR(24)
			  H_C := H_C+16
			  IF H_C>240
				  H_C := 0
			  EndIF
	ENDCase
ENDDO
RestScreen( cScreen )

Function Calendario()
*********************
LOCAL cScreen := SaveScreen()
LOCAL Meses := {"JANEIRO","FEVEREIRO","MAR€O","ABRIL","MAIO","JUNHO",;
					 "JULHO","AGOSTO","SETEMBRO","OUTUBRO","NOVEMBRO","DEZEMBRO"}
Set Date Brit
Scroll( 01, 51, 17, 79 ) ; SetPos( 01, 51 )
MaBox( 01, 51, 17, 79 )
Write( 03, 51, Chr( 195 ) + Repl( Chr( 196 ), 27 ) + Chr( 180 ) )
Write( 04, 52, "Dom Seg Ter Qua Qui Sex Sab" )
Write( 05, 51, Chr( 195 ) + Repl( Chr( 196 ), 27 ) + Chr( 180 ) )
StatusInf("USE AS SETAS PARA MUDAR O MES E ANO", "ESC-RETORNA")
SetColor( "W,G+" )
H_D := H_W := Date()
H_F := Chr( InKey())
WHILE H_F <> Chr( 27 )
	  H_DIA := "1"
	  H_NME := Month(H_D)
	  H_ANO := Year(H_D)
	  H_MESEX := MESES[H_NME]
	  H_MESEX := H_MESEX+Space(9-Len( H_MESEX))
	  DevPos( 02, 54 ) ; DevOutPict( H_DIA, "##" )
	  DevPos( 02, 61 ) ; DevOut( H_MESEX )
	  DevPos( 02, 74 ) ; DevOutPict( H_ANO, "####" )
	  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
	  H_D := CTOD(H_D)
	  H_NSE := DOW(H_D)
	  H_D := H_D-(H_NSE-1)
	  H_L := 6
	  H_C := 52
	  FOR H_X=1 TO 42
		  IF Month(H_D)<>H_NME
			  SetColor( "G+" )

			ELSE
				SetColor( "W" )

			EndIF
			IF H_D=H_W
				SetColor( "W+*" )

			EndIF
			DevPos( H_L, H_C ) ; DevOutPict( DAY(H_D), "###" )
			H_D := H_D+1
			H_C := H_C+4
			IF H_C>78
				H_C := 52
				H_L := H_L+2

			EndIF
	  NEXT
	  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
	  H_D := CTOD(H_D)
	  SetColor( "W,G+" )
	  H_F := " "
	  while AT(H_F,Chr(5)+Chr(24)+Chr(19)+Chr(4)+Chr(27))=0
		  H_F := Chr(INKEY())

	  ENDDO
	  IF H_F=Chr(27)
		  LOOP

	  EndIF
	  DO CASE
	  CASE H_F=Chr(5)
		  H_NME := H_NME+1
		  IF H_NME>12
			  H_NME := 1
			  H_ANO := H_ANO+1

		  EndIF
		  CASE H_F=Chr(24)
			  H_NME := H_NME-1
			  IF H_NME<=0
				  H_NME := 12
				  H_ANO := H_ANO-1

			  EndIF

		  CASE H_F=Chr(19)
			  H_ANO := H_ANO+1

		  CASE H_F=Chr(4)
			  H_ANO := H_ANO-1

		  ENDCASE
		  H_D := "01/"+LTRIM(STR(H_NME,2))+"/"+LTRIM(STR(H_ANO,4))
		  H_D := CTOD(H_D)

	  ENDDO
	  RestScreen( cScreen )
	  Return Nil

Function Ascan2( aArray, Variavel, PosElem )
********************************************
/* aArray := { { "01.00.0001", "FECHADURA METAL COM CHAVE", 125.00 } }
	cCodigo := "01.00.0001"
	nPos := Ascan2( aArray, cCodigo, 1 )
	IF nPos = 0
		Alerta(' Produto Nao Encontrado ' )

	EndIF
*/

_Tam := Len( aArray )
IfNil( PosElem, 1 )
For i := 1 To _Tam
	IF aArray[ i, PosElem ] == Variavel
		Return( i )
	EndIF
Next
Return( 0 )

Function Confirma( cString )
****************************
Return( Alerta( cString , { " Sim ", " Nao " } ) )

Function ErrorBeep()
********************
TONE(87.3,1)
TONE(40,3.5)
Return Nil

Function Escolhe
Param Col1, Lin1, Col2, Nome_Campo, Cabecalho, aRotina, lExcecao, aRotinaAlteracao, aRotinaExclusao, lLimpaTela, lDbSeek
************************************************************************************************************************
LOCAL _Atela  := SaveScreen()
LOCAL _corant := SetColor()
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL _Tam
LOCAL Lin2
LOCAL nRecno
		cCampo  := Nome_Campo
      Col2    := IF( Col2 == 22, (MaxRow()-2), Col2)
      nCol    := Col2
		nLin	  := Lin1+1
PRIVA aScroll
IF ValType( Nome_Campo ) != "A"
	Cabecalho := IIF( Cabecalho = Nil, "", Cabecalho )
	IF ValType( &Nome_Campo ) = "D"
		Lin2 := Lin1 + 9
	Else
		nTam := Len( &Nome_Campo. )
		nCab := Len( Cabecalho )
		Lin2 := IIF( nTam >= nCab, nTam + ( Lin1 + 1 ), nCab + ( Lin1 + 1 ) )
	EndIF
	_Vetor1 := { Nome_Campo }
	_Vetor2 := { IF ( Cabecalho = Nil, Cabecalho := .T. , Cabecalho := Upper( Cabecalho ) ) }
   IF Lin2 >= 78
      Lin2 := 78
	EndIF
Else
	_Vetor1 := Nome_Campo
	_Vetor2 := Cabecalho
	Lin2	  := 70
EndIF
IF lLimpaTela = NIL .OR. lLimpatela = OK
	oMenu:Limpa()
EndIF
MaBox( Col1, Lin1,	Col2, Lin2+2, /*Cabecalho*/ )
MaBox( Col1, Lin1+2, Col2, Lin2+2, /*Cabecalho*/ )
Print( Col1, Lin1+2, SubStr( oAmbiente:Frame, 1, 1 ), Cor())
Print( Col2, Lin1+2, SubStr( oAmbiente:Frame, 5, 1 ), Cor())

IF aRotina != NIL
	IF Alias() = "LISTA"
		IF aRotinaAlteracao != NIL
			Print( Col2, Lin1+3, "INSERT _Incluir?ELETE _Excluir?2 _Cod Fabr?TRL+ENTER _Alterar", Roloc( Cor()), Lin2 - (Lin1+1))
		Else
			Print( Col2, Lin1+3, "INSERT _Incluir?ELETE _Excluir?2 _Cod Fabr", Roloc( Cor()), Lin2 - (Lin1+1))
		EndIF
	Else
		IF aRotinaAlteracao != NIL
			Print( Col2, Lin1+3, "INSERT _Incluir?ELETE _Excluir?2 _Filtro?TRL+ENTER _Alterar", Roloc( Cor()), Lin2 - (Lin1+1))
		Else
			Print( Col2, Lin1+3, "INSERT _Incluir?ELETE _Excluir?2 _Filtro?, Roloc( Cor()), Lin2 - (Lin1+1))
		EndIF
	EndIF
EndIF
IF lDbSeek != NIL
	nRecno := Recno()
EndIF
DbGoTop()
IF Eof()
	IF aRotina != NIL
		IF Conf("Arquivo Vazio... Deseja Incluir Registros ?")
			Eval( aRotina[1])
			AreaAnt( Arq_Ant, Ind_Ant )
		EndIF
	EndIF
EndIF
IF lDbSeek != NIL
	DbGoto( nRecno )
EndIF
ScrollBarDisplay( aScroll := ScrollBarNew( Col1+1, Lin1+1, Col2-1, Roloc(Cor()),1))
DbEdit((Col1+1), (Lin1+3), (Col2-1), (Lin2+1), _Vetor1, "_Funcao", OK, _Vetor2 )
ResTela( _Atela )
SetColor(_corant )
Return( OK )

Function _Funcao( Modo, Ponteiro , Var)
***************************************
LOCAL GetList		:= {}
LOCAL cScreen		:= SaveScreen()
LOCAL Key			:= LastKey()
LOCAL Arq_Ant		:= Alias()
LOCAL Ind_Ant		:= IndexOrd()
LOCAL cN_Original := Space(15)
STATI nPosicao 	:= 1
LOCAL nLastrec 	:= Lastrec()
LOCAL Registro
LOCAL Salva_tela
LOCAL lInativos	:= oIni:ReadBool('sistema', 'MostrarClientesInativos', FALSO )

ScrollBarUpdate( aScroll, Recno(), Lastrec(), OK )
Do Case
	Case Key = F2
		IF Alias() = "LISTA"
			oMenu:Limpa()
			MaBox( 10, 10, 12, 48 )
			@ 11, 11 Say "Codigo Fabricante..." Get cN_Original Pict "@!" Valid CodiOriginal( @cN_Original )
			Read
			IF LastKey() = ESC
				ResTela( cScreen )
				Return(1)
			EndIF
			ResTela( cScreen )
		Else
			IF Alias() = "RECEBER"
				oMenu:Limpa()
				ClientesFiltro()
				ResTela( cScreen )
			EndIF
		EndiF
		AreaAnt( Arq_Ant, Ind_Ant )
		Return(1)

	Case Key = K_INS
		IF aRotina != Nil
			IF PodeIncluir()
				Eval( aRotina[1])
			Else
				IF lExcecao != Nil
					Eval( aRotina[1])
				EndiF
			EndIF
		EndIF
		AreaAnt( Arq_Ant, Ind_Ant )
		Return(1)

	Case Key = K_CTRL_RET		 // Ctrl-Enter
		IF aRotinaAlteracao != Nil
			IF PodeAlterar()
				Eval( aRotinaAlteracao[1])
			Else
				IF lExcecao != Nil
					Eval( aRotinaAlteracao[1])
				EndiF
			EndIF
		EndIF
		AreaAnt( Arq_Ant, Ind_Ant )
		Return(1)

	Case Key = K_DEL
		IF aRotina != Nil
			IF PodeExcluir()
				IF aRotinaExclusao != NIL
					IF !Eval( aRotinaExclusao[1] )
						Return(1)
					EndIF
				EndIF
				ErrorBeep()
				IF Conf("Pergunta: Excluir Registro sob o Cursor ?")
					IF TravaReg()
						DbDelete()
						Libera()
					  Keyb Chr( K_CTRL_PGUP )
					EndIF
				EndIF
			EndIF
		EndIF
		Return(1)

	Case Modo < 4
		Return(1)

	CASE LastKey() = 27
		nPosicao := 1
		Return(0)

	CASE LastKey() = 13
      Return(0)

	CASE LastKey() >= 48 .AND. LastKey() <= 122	&&  1 a Z
		IF   ValType( cCampo ) = "C"
			xVar := Upper(Chr(Key))
			xVar := xVar + Space( nTam - Len( xVar))
			Keyb(Chr(K_RIGHT))
			@ nCol-1, nLin+2 Get xVar Pict "@!"
			Read

		ElseIf ValType( cCampo ) = "N"
			IF nKey < Chr(48) .OR. nKey > Chr(57) // 0 a 9
				Return(1)
			EndIF
			xVar := Chr(nKey)
			Keyb(Chr(K_RIGHT))
			@ nCol-1, nLin+2 Get xVar
			Read

		ElseIf ValType( cCampo ) = "D"
			xVar := Date()
			@ nCol-1, nLin+2 Get xVar Pict "##/##/##"
			Read
		EndIF
		IF LasTKey() = ESC
			ResTela( cScreen )
			Return(1)
		EndIF
		xVar := IIF( ValType( cCampo ) = "C", AllTrim( xVar ), xVar)
		ResTela( cScreen )
		DbSeek( xVar )
		Return(1)

	OTHERWISE
		IF Alias() = "RECEBER"
			IF lInativos
				IF Receber->Cancelada
					Receber->(DbSkip(1))
				EndIF
			EndIF
		EndIF
		Return(1)

ENDCASE

Function Order( Ordem )
***********************
IIF( Ordem = Nil , Ordem := 0,  Ordem )
DbSetOrder( Ordem )
DbGoTo( Recno())			 // Fixar Bug
Return( IndexOrd())

Function FPrint( cString )
**************************
Return( DevOut( cString ) )

Proc WriteBox( Linha, Col, xString, nCor )
******************************************
IIF( Linha	 = Nil, Linha	 := Row(), Linha )
IIF( Col 	 = Nil, Col 	 := Col(), Col )
IIF( xString = Nil, xString := "",    xString )
IIF( nCor	 = Nil, nCor	 := CorBoxCima(), nCor )
Print( Linha, Col, xString, nCor )
Return

Proc Write( Linha, Col, xString )
*********************************
Linha   := IIF( Linha	= NIL, Row(),	Linha   )
Col	  := IIF( Col		= NIL, Col(),	Col	  )
xString := IIF( xString = NIL, "",     xString )
DevPos( Linha, Col ) ; Qqout( xString )
Return

Function TestaCgc( Var )
************************
LOCAL Matriz[12]
LOCAL i
LOCAL Df1
LOCAL Df2
LOCAL Df3
LOCAL nTam := 0

IF ValType( Var ) = "N"
	Var := CpfCgcIntToStr( Var )
	nTam := Len( Var )
	IF nTam <= 14
		Return( TestaCpf( Var ) )
	EndIF
EndIF

/*
	cTira := StrTran( Var,	".")
	cTira := StrTran( cTira, "/")
	cTira := StrTran( cTira, "-")
	nComp := Len( AllTrim( cTira ))
	IF nComp >= 14 // Cgc
		Var := Tran( Var, "99.999.999/9999-99")
	Else
		Var := Tran( Var, "999.999.999-99" )
		Return( TestaCpf( Var ) )
	EndIF
*/

IF !Empty( Var ) .AND. Len( Var ) < 18
	 ErrorBeep()
	 Alerta("CGC Incorreto... Verifique." )
	 Return(.F.)
EndIF
Var1 := StrTran( Var,  ".")
Var1 := StrTran( Var1, "/")
Var1 := StrTran( Var1, "-")
For I = 1 To 12
	Matriz[i] := Val( SubStr( Var1, I, 1))
Next

** Teste do Primeiro digito (unidade)
Df1 := 5 * Matriz[1] + 4 * Matriz[2] + 3 * Matriz[3] + 2 * Matriz[4] + 9 * Matriz[5] + ;
		 8 * Matriz[6] + 7 * Matriz[7] + 6 * Matriz[8] + 5 * Matriz[9] + 4 * Matriz[10] + ;
		 3 * Matriz[11] + 2 * Matriz[12]
Df2 := Df1 / 11
Df3 = Int( Df2 ) * 11
Resto1 := ( Df1- df3 )
IF Resto1 = 0 .OR. Resto1 = 1
  Pridig := 0
ELSE
  Pridig := ( 11 - Resto1 )
EndIF

** Teste do segundo digito (dezena)
DF1 := 6 * Matriz[1] + 5 * Matriz[2] + 4 * Matriz[3] + 3 * Matriz[4] + 2 * Matriz[5] + ;
		 9 * Matriz[6] + 8 * Matriz[7] + 7 * Matriz[8] + 6 * Matriz[9] + 5 * Matriz[10] + ;
		 4 * Matriz[11] + 3 * Matriz[12] + 2 * Pridig
Df2 := ( Df1/11 )
Df3 := Int( Df2 ) * 11
Resto2 := ( Df1 - Df3)
IF Resto2 = 0 .OR. Resto2 = 1
  SegDig := 0
ELSE
  SegDig := (11 - Resto2)
EndIF
IF Pridig <> Val( SubStr( Var1,13,1)) .OR. SegDig <> Val( SubStr( Var1,14,1))
	 ErrorBeep()
	 Alerta("CGC Incorreto... Verifique." )
	 Return(.F.)
ELSE
	Return(.T.)
EndIF

Function DataExtenso( dData )
*****************************
LOCAL cString := ""
LOCAL nMes
LOCAL aMes
LOCAL aDia
LOCAL nDia
LOCAL aDecada
LOCAL nDecada
LOCAL aAno
LOCAL nAno
LOCAL aSeculo
LOCAL nSeculo
LOCAL nMenor
LOCAL nMaior
LOCAL aDecimal
LOCAL cAno
LOCAL cDia
LOCAL cMes
LOCAL cDecada
LOCAL cSeculo

aMes		:= {"janeiro","fevereiro","marco","abril","maio","junho",;
				 "julho","agosto","setembro","outubro","novembro","dezembro" }
aDia		:= {"primeiro", "segundo", "terceiro", "quarto", "quinto", "sexto", "setimo",;
				 "oitavo", "nono", "decimo"}
aDecimal := {"decimo", "vigesimo", "trigesimo" }
aSeculo	:= {"um mil novecentos ", "dois mil " }
aDecada	:= {"dez ","vinte ","trinta ","quarenta ","cinquenta ","sescenta ","setenta ","oitenta ","noventa "}
aAno		:= {"um","dois","tres","quatro","cinco","seis","sete","oito","nove" }

nSeculo	:= Val( Left( StrZero( Year( dData ), 4),1))
nDecada	:= Val( SubStr( StrZero( Year( dData ), 4), 3,1))
nAno		:= Val( Right( StrZero( Year( dData ), 4),1))
nDia		:= Day( dData )
nMes		:= Month( dData)
cAno		:= StrZero( nAno, 4)
cDia		:= StrZero( nDia, 2 )
nMenor	:= Val( Left( cDia, 1 ))
nMaior	:= Val( Right( cDia, 1 ))
cMes		:= aMes[ nMes ]

IF nMenor > 0
	cString := aDecimal[nMenor] + " "
EndIF
IF nDecada = 0
	cDecada := ""
Else
	cDecada := "e " + aDecada[nDecada]
EndIF
IF nAno = 0
	cAno := ""
Else
	cAno := "e " + aAno[nAno]
EndIF
cSeculo := aSeculo[nSeculo]
cString += IIF( nMaior = 0, "", aDia[nMaior] + " " )
cString += "dia do mes de "
cString += cMes
cString += " do ano "
cString += cSeculo
cString += cDecada
cString += cAno
Return( cString )


Function DataExt1( dData )
*************************
LOCAL Mes
LOCAL MesExt

IF dData = NIL .OR. ValType( dData ) != "D"
	dData := Date()
EndIF
Mes	 := Month( dData)
MesExt := {"Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
			  "Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }
Return( StrZero( Day( dData ), 2 ) + " de "+ MesExt[ Mes ] +" de "+ Str(Year( dData ),4 ))

Function Mes( dData )
*********************
LOCAL Mes
LOCAL MesExt

IF dData = NIL
	dData := Date()
	Mes	:= Month( dData)
ElseIF ValType( dData ) = "D"
	Mes := Month( dData)
ElseIF ValType( dData ) = 'N'
	Mes := dData
Else
	dData := Date()
	Mes	:= Month( dData)
EndIF
MesExt := { "Janeiro","Fevereiro","Marco","Abril","Maio","Junho",;
				"Julho","Agosto","Setembro","Outubro","Novembro","Dezembro" }
Return( MesExt[ Mes ] )

Function DataExt2( dData )
**************************
LOCAL Mes, MesExt, Dia

IF dData = NIL .OR. ValType( dData ) != "D"
	dData := Date()
EndIF
Mes	 := Month( dData)
MesExt := { { "Janeiro"  , 07 },;
				{ "Fevereiro", 05 },;
				{ "Mar‡o"    , 09 },;
				{ "Abril"    , 09 },;
				{ "Maio"     , 10 },;
				{ "Junho"    , 09 },;
				{ "Julho"    , 09 },;
				{ "Agosto"   , 08 },;
				{ "Setembro" , 06 },;
				{ "Outubro"  , 07 },;
				{ "Novembro" , 06 },;
				{ "Dezembro" , 06 }}

Dia	 := { "Primeiro ",;
			  "Dois "    ,;
			  "Trˆs "    ,;
			  "Quatro "  ,;
			  "Cinco "   ,;
			  "Seis "    ,;
			  "Sete "    ,;
			  "Oito "    ,;
			  "Nove "    ,;
			  "Dez "     ,;
			  "Onze "    ,;
			  "Doze "    ,;
			  "Trez "    ,;
			  "Quatorze "    ,;
			  "Quinze "    ,;
			  "Dezesseis "    ,;
			  "Dezessete "    ,;
			  "Dezoito "    ,;
			  "Dezenove "    ,;
			  "Vinte "    ,;
			  "Vinte e um "    ,;
			  "Vinte e dois "    ,;
			  "Vinte e trˆs "    ,;
			  "Vinte e quatro "    ,;
			  "Vinte e cinco "    ,;
			  "Vinte e seis "    ,;
			  "Vinte e sete "    ,;
			  "Vinte e oito "    ,;
			  "Vinte e nove "    ,;
			  "Trinta "    ,;
			  "Trinta e um "}

Return( Dia[ Day( dData ) ] + "de " + MesExt[ Mes,1 ] + " de " + Str( Year( dData ),4))

Proc Clock( nCol, nLin )
************************
IIF( nCol = Nil, nCol := Row(), nCol )
IIF( nLin = Nil, nLin := Col(), nLin )
Clock12( nCol, nLin )

Proc F_Fim( Texto )
*******************
LOCAL cMicrobras := "Microbras Com de Prod de Informatica Ltda"
			  Texto := IIF( Texto = NIL, "MICROBRAS", Texto )

SetColor("")
Cls
Alert( Texto + ";;Copyright (C)1992," + Str(Year(Date()),4) + ";" + cMicrobras + ";;Todos Direitos;Reservados", "W+/G")
Return

Function StaTusInf( XNOMEFIR, Msg, Color )
******************************************
LOCAL nCol  := MaxRow()
LOCAL Tam	:= MaxCol()
		Msg	:= IIF( Msg = NIL, "", Msg )
		Color := IIF( Color = Nil, Cor(2), Color )
aPrint( nCol, 00, Msg, Color, MaxCol() )
Pos := ( Tam - Len( XNOMEFIR ) )
aPrint( nCol, Pos, XNOMEFIR, Color )
Return Nil

Function StaTusSup( Msg, Color )
********************************
LOCAL Tam	:= MaxCol()
		Msg	:= IIF( Msg = Nil, "", Msg )
		Color := IIF( Color = Nil, Cor(2), Color )
aPrint( 00, 00, Padc( Msg, Tam ) , Color, Tam )
aPrint( 00, (Tam-8), Clock12( 00, (Tam-8), Color ), Color )
Return Nil


PROC Seta1( Row, Col )
***********************
LOCAL cString := "Use as Setas " + Chr( 27 ) + Chr( 24 ) + Chr( 25 ) + Chr( 26 )
LOCAL nLen	  := Len( cString )
Row := IIF( Row = NIL, 19, Row )
Col := IIF( Col = NIL, ((MaxCol()-nLen)/2), Col )
Write( Row, Col,	cString )
Return

Function Ponto( cCampo, nTamanho )
*********************************
//  cDescricao := Space(40)
//  @ 10, 10 Say "Descricao..." GET cDescricao Pict "@!"
//  Read
//  cVarPonto := Ponto( cDescricao, 40 ) // 40 eh o tamanho to CAMPO
//  DbAppend()
//  _Field->Descricao := cVarPonto

cString := cCampo
cVar1   := Rtrim( cString )
cVar2   := Repl(".", nTamanho - Len( cVar1 ) )
cVar	  := cVar1 + cVar2
Return( cVar )

FUNCTION Mensagem( String, Color, nLine )
*****************************************
LOCAL cScreen := SaveScreen()
LOCAL pstrlen := len(string) + 6
LOCAL cFundo  := 112
LOCAL pBack
LOCAL Row
LOCAL Col
LOCAL Col2

IF oAmbiente:Visual
	MsgBox3D( String )
	Return( cScreen )
ENDIF
IF nLine = Nil
   Row    := ((  MaxRow() + 1 ) / 2 ) - 2
   Col    := ((( MaxCol() + 1 ) - PstrLen ) ) / 2
   Col2   := ((( MaxCol() + 1 ) / 2 ) - 10 )
Else
	Row	 := nLine
   Col    := ((( MaxCol() + 1 ) - PstrLen ) ) / 2
   Col2   := ((( MaxCol() + 1 ) / 2 ) - 10 )
EndIF

Color := CorBox()
/*
MsBox( Row, Col, Row+4, Col+ PstrLen, Color, FALSO )
WriteBox( Row + 2, Col + 4, String )
*/

ColorSet( @cFundo, @PBack )
Box( Row, Col, Row+4, Col+PstrLen, M_Frame() + " ", CorBox() )
Print( Row + 2, Col + 4, String, CorBox() )

Return( cScreen )

FUNCTION Mens( String, Color, nLine )
*************************************
LOCAL cScreen := SaveScreen()
LOCAL pstrlen := len(string) + 6
LOCAL Row
LOCAL Col
LOCAL Col2
IF nLine = Nil
   Row    := ((  MaxRow() + 1 ) / 2 ) - 2
   Col    := ((( MaxCol() + 1 ) - PstrLen ) ) / 2
   Col2   := ((( MaxCol() + 1 ) / 2 ) - 10 )
Else
	Row	 := nLine
   Col    := ((( MaxCol() + 1 ) - PstrLen ) ) / 2
   Col2   := ((( MaxCol() + 1 ) / 2 ) - 10 )
EndIF
MsBox( Row, Col, Row+4, Col+ PstrLen, Color, FALSO )
WriteBox( Row + 2, Col + 4, String )
Return cScreen

Function Senha( _Col, _Linha, _Tpalavra )
*****************************************
LOCAL GetList := {}
LOCAL Letras  := Array( _Tpalavra )
LOCAL Pass
LOCAL nTecla
LOCAL T
LOCAL P

Afill( Letras, Space( 1 ) )
DevPos( _col, _linha ) ; DevOut( Space(_Tpalavra ) )
P := 1
WHILE .T.
	DevPos( _Col, ( (_Linha -1 ) + P ) ) ; DevOut( "" )
	nTecla := Inkey(0)
	IF nTecla = 0						  // Nenhuma Tecla Pressionada
		Loop

	ElseIf nTecla = 8 .AND. P > 1   //	Tecla Backspace
		P--
		Letras[ P ] := Space( 1 )
		DevPos( _Col, ( ( _Linha - 1 ) + P ) ) ; DevOut( " " )
		Loop

	ElseIf nTecla = 13				 // Enter
		Exit

	ElseIf nTecla = 27				 // Esc ?
		Exit

	Else
		Letras[ P ] := Upper( Chr( nTecla ) )
		DevPos( _Col,( ( _Linha -1 ) + P ) ) ; DevOut( "þ" )
		P++
		If P = _Tpalavra					// Todos os caracteres digitados ?
			Exit

		EndIF

	EndIF
EndDo
Pass := ""
For T := 1 To _Tpalavra
  Pass := Pass + Letras[ T ]
Next
Return pass

Function Dc_Explode( _Srow, _Scol, _Erow, _Ecol, _Title, _Rodape, lInverterCor, _Slider, _Tone )
************************************************************************************************
LOCAL _TsRow, _TsCol, _TeRow,  _TeCol, _xscrn, _a, _row, _step,;
		_ccol,  _crow,  _buffer, _col
IIF( _Tone	 = NIL, _Tone	 := .F., _Tone )
IIF( _Slider = NIL, _Slider := IIF( Empty( GeteNv("EXPLODE")), 0, 5 ), _Slider )
IIF( _Title  = NIL, _Title  := "" , _Title )

_TsRow := _Srow + (_Erow-_Srow ) / 2
_TsCol := _Scol + (_Ecol-_Scol ) / 2
_TeRow := _TsRow
_TeCol := _TsCol

// Inicio sliding box
// ******************
IF _Slider > 0
  _Crow := Row()
  _Ccol := Col()
  _Step := IIF(_Crow > _TsRow, -1, 1 )
  For _Row := _Crow To _TsRow Step _Step
	 _xScrn := SaveScreen()
	 MaBox( _Row, _Ccol, _Row + 1, _Ccol + 3,,,lInverterCor )
	 For _a := 1 To _Slider
	 Next
	 RestScreen(,,,, _xScrn)

  Next
  _Step := IIF( _Ccol > _TsCol, -5, 5 )
  For _Col := _Ccol To _TsCol STEP _Step
	  _xScrn := SaveScreen()
	  MaBox( _Row, _Col, _Row+1, _Col+3,,, lInverterCor )
	 For _a := 1 TO _Slider * 2
	 Next
	 RestScreen(,,,, _xScrn )

  Next
EndIF
				/*** FIM sliding box **/
				************************

IF _Erow < 24 .AND. _Scol > 1
  _xScrn := SaveScreen( _Srow, _Scol-2, _Erow+1, _Ecol )

Else
  _xScrn := SaveScreen( _sRow,_sCol, _eRow, _eCol )

EndIF
IF _Tone
  ErrorBeep()

EndIF
WHILE _TsCol > _Scol
  MaBox( _TsRow,_TsCol, _TeRow, _TeCol,,, lInverterCor )
  _TsCol -= 4
  _TeCol += 4
  _TsRow--
  _TeRow++
  IF _TsRow < _Srow
	 _TsRow := _Srow
	 _TeRow := _Erow

  EndIF
  IF _TsCol < _Scol
	 _TsCol := _Scol
	 _TeCol := _Ecol

  EndIF
EndDo
IF _Tone
  ErrorBeep()

EndIF
IF !Empty(_Title )
	MaBox( _Srow, _Scol, _Erow, _Ecol, _Title, _Rodape, lInverterCor )
Else
  MaBox( _Srow, _Scol, _Erow, _Ecol,,, lInverterCor )
EndIF
Return NIl

Function TestaCpf( cCpf )
*************************
LOCAL cDig
LOCAL nNumero
LOCAL nMult
LOCAL nSoma
LOCAL nProd
LOCAL nNum
LOCAL nDig
LOCAL Digito
LOCAL Var1
LOCAL Var2
LOCAL Numero
LOCAL d1
LOCAL Dig
LOCAL Soma
LOCAL Num
LOCAL Mult
LOCAL Prod
LOCAL Conta

IF !Empty( cCpf ) .AND. Len( cCpf ) < 14
	 ErrorBeep()
	 Alerta("Erro: CPF incorreto." )
	 Return(.F.)
EndIF
cCpf	  := AllTrim( cCpf )
Digito  := Right( cCpf, 2 )
Var1	  := StrTran( cCpf, "." )
Var2	  := StrTran( Var1, "-" )
Numero  := Left( Var2, 9 )

Mult	 := 1
Soma	 := 0
Prod	 := 0
Num	 := 0
Dig	 := 0
cDig	 := ""
For Conta := Len( Numero ) To 1 Step -1
	Num := Val( SubStr( Numero, Conta, 1 ) )
	Mult++
	Soma += ( Num * Mult )
Next Conta
Dig := Mod( ( Soma * 10), 11 )
IF Dig >= 10
	Dig := 0
EndIF
d1 := Dig
Numero = Left( Var2, 10 )
Mult	 := 1
Soma	 := 0
Dig	 := 0
Prod	 := 0
Num	 := 0
For Conta := Len( Numero ) To 1 Step -1
	Num := Val( SubStr( Numero, Conta, 1 ) )
	Mult++
	Soma += ( Num * Mult )
Next Conta
Dig := Mod( ( Soma * 10), 11 )
IF Dig >= 10
	Dig := 0
EndIF
// cDig := Left(Str( d1 ), 1 ) + Left( Str( Dig ), 1 )
IF Val( Left( Digito, 1 ) ) != d1 .OR. Val( Right( Digito, 1 ) ) != Dig
	ErrorBeep()
	Alerta( "Erro: CPF invalido.")
	Return(.F.)
EndIF
Return(.T.)

Proc ErrorSys()
***************
Private ErrorSys := 9876543210
ErrorBlock( {|Erro| MacroErro(Erro)} )
Return

Function MacroErro(e)
*********************
LOCAL cScreen	 := SaveScreen()
LOCAL cPrograma := StrTran( Program(), ".EXE", ".ERR")
LOCAL cmens
LOCAL i
LOCAL cmessage
LOCAL aoptions
LOCAL nchoice
LOCAL errodos
LOCAL ab
LOCAL abdes
LOCAL abexp
LOCAL abacao
LOCAL abacao1
LOCAL adbf
LOCAL adbfdes
LOCAL adbfexp
LOCAL adbfacao
LOCAL adbfacao1

cmens 	 := ""
errodos	 := {}
ab 		 := {}
abdes 	 := {}
abexp 	 := {}
abacao	 := {}
abacao1	 := {}
adbf		 := {}
adbfdes	 := {}
adbfexp	 := {}
adbfacao  := {}
adbfacao1 := {}
If (e:gencode() == 5)
	Return 0
EndIf
If (e:gencode() == 21 .AND. e:oscode() == 32 .AND. e:candefault())
	neterr(.T.)
	Return .F.
EndIf
If (e:gencode() == 40 .AND. e:candefault())
	neterr(.T.)
	Return .F.
EndIf
AAdd(ab, 1002)
AAdd(abdes, "ALIAS NAO EXISTE.")
AAdd(abexp, "O ALIAS ESPECIFICADO NAO ASSOCIADO COM A AREA DE TRABALHO ATUAL.")
AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(abacao1, "")
AAdd(ab, 1003)
AAdd(abdes, "VARIAVEL NAO EXISTE.")
AAdd(abexp, "A VARIAVEL ESPECIFICADA NAO EXISTE OU NAO E VISIVEL.")
AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(abacao1, "")
AAdd(ab, 1004)
AAdd(abdes, "VARIAVEL NAO EXISTE.")
AAdd(abexp, "A VARIAVEL ESPECIFICADA NAO EXISTE OU NAO E VISIVEL.")
AAdd(abacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(abacao1, "")
AAdd(ab, 2006)
AAdd(abdes,   "ERRO DE GRAVACAO/CRIACAO DE ARQUIVO.")
AAdd(abexp,   "O ARQUIVO ESPECIFICADO NAO PODE SER GRAVADO/CRIADO.")
AAdd(abacao,  "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(abacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(ab, 5300)
AAdd(abdes, "MEMORIA BAIXA.")
AAdd(abexp, "MEMORIA DISPONIVEL INSUFICIENTE PARA RODAR O APLICATIVO.")
AAdd(abacao, "LIBERE MAIS MEMORIA CONVENCIONAL VERIFICANDO OS ARQUIVOS")
AAdd(abacao1, "CONFIG.SYS E AUTOEXEC.BAT.")

AAdd(adbf, 1001)
AAdd(adbfdes, "ERRO DE ABERTURA DO ARQUIVO ESPECIFICADO.")
AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER ABERTO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(adbf, 1003)
AAdd(adbfdes, "ERRO DE ABERTURA DO ARQUIVO ESPECIFICADO.")
AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER ABERTO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(adbf, 1004)
AAdd(adbfdes, "ERRO DE CRIACAO DE ARQUIVO.")
AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER CRIADO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(adbf, 1006)
AAdd(adbfdes, "ERRO DE CRIACAO DE ARQUIVO.")
AAdd(adbfexp, "O ARQUIVO ESPECIFICADO NAO PODE SER CRIADO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(adbfacao1,"EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(adbf, 1010)
AAdd(adbfdes, "ERRO DE LEITURA DE ARQUIVO.")
AAdd(adbfexp, "UM ERRO DE LEITURA OCORREU NO ARQUIVO ESPECIFICADO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE, OU SE")
AAdd(adbfacao1, "O ARQUIVO NAO ESTA TRUNCADO.")
AAdd(adbf, 1011)
AAdd(adbfdes, "ERRO DE GRAVACAO DE ARQUIVO.")
AAdd(adbfexp, "UM ERRO DE GRAVACAO OCORREU NO ARQUIVO ESPECIFICADO.")
AAdd(adbfacao, "VERIFIQUE SEUS DIREITOS EM AMBIENTE DE REDE. ESPACO")
AAdd(adbfacao1, "EM DISCO, OU SE O ARQUIVO ESTA ATRIBUIDO PARA SOMENTE LEITURA.")
AAdd(adbf, 1012)
AAdd(adbfdes, "CORRUPCAO DE ARQUIVOS DETECTADA.")
AAdd(adbfexp, "OS ARQUIVOS DE DADOS .DBF E/OU INDICES .NTX ESTAO CORROMPIDOS.")
AAdd(adbfacao, "APAGUE OS ARQUIVOS COM EXTENSAO .NTX E TENTE NOVAMENTE.")
AAdd(adbfacao1, "")
AAdd(adbf, 1020)
AAdd(adbfdes, "ERRO DE TIPO DE DADO.")
AAdd(adbfexp, "OS TIPOS DE DADOS SAO IMCOMPATIVEIS.")
AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(adbfacao1, "")
AAdd(adbf, 1021)
AAdd(adbfdes, "ERRO DE TAMANHO DE DADO.")
AAdd(adbfexp, "O TAMANHO DE DADO EH MAIOR QUE O CAMPO.")
AAdd(adbfacao, "VERIFIQUE DATAS DE VCTO, EMISSAO E OU CALCULOS MUITO ")
AAdd(adbfacao1, "GRANDES.")
AAdd(adbf, 1022)
AAdd(adbfdes, "TRAVAMENTO DE ARQUIVO REQUERIDO.")
AAdd(adbfexp, "TENTATIVA DE ALTERAR UM REGISTRO SEM PRIMEIRO OBTER TRAVAMENTO.")
AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(adbfacao1, "")
AAdd(adbf, 1023)
AAdd(adbfdes, "O ARQUIVO REQUER ABERTURA EXCLUSIVA")
AAdd(adbfexp, "O INICIO DA OPERACAO REQUER ABERTURA DE ARQUIVO EXCLUSIVA.")
AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(adbfacao1, "")
AAdd(adbf, 1027)
AAdd(adbfdes, "LIMITE EXCEDIDO.")
AAdd(adbfexp, "MUITOS ARQUIVOS DE INDICES ESTAO ABERTOS NA AREA CORRENTE.")
AAdd(adbfacao, "ENTRE EM CONTATO COM O SUPORTE TECNICO.")
AAdd(adbfacao1, "")
nsubcode   := e:subcode()
csystem	  := e:subsystem()
cexplanaca := ""
cacao 	  := ""
cacao1	  := ""
nPos		  := 0
If (csystem = "BASE")
	npos:= ascan(ab, nsubcode)
	If (npos != 0)
		e:description := abdes[npos]
		cExplanacao   := abexp[npos]
		cAcao 		  := abacao[npos]
		cAcao1		  := abacao1[npos]
	EndIf
ElseIf (csystem = "DBFNTX")
	npos:= ascan(adbf, nsubcode)
	If (npos != 0)
		e:description := adbfdes[npos]
		cExplanacao   := adbfexp[npos]
		cAcao 		  := adbfacao[npos]
		cAcao1		  := adbfacao1[npos]
	EndIf
ElseIf (csystem = "SIXNSX")
	npos:= ascan(adbf, nsubcode)
	If (npos != 0)
		e:description := adbfdes[npos]
		cExplanacao   := adbfexp[npos]
		cAcao 		  := adbfacao[npos]
		cAcao1		  := adbfacao1[npos]
	EndIf
ElseIf ( csystem = "TERM")
	IF LptOk()
		Return( OK )
	EndIF
	Set Devi To Screen
	Set Prin Off
	Set Cons On
	Set Print to
	Break
EndIf
If (e:oscode() = 4)
	e:description := "IMPOSSIVEL ABRIR MAIS ARQUIVOS."
	cExplanacao   := "O LIMITE DE ABERTURA DE ARQUIVOS FOI EXCEDIDO."
	cAcao 		  := "INCREMENTE FILES NO CONFIG.SYS OU FILE HANDLES"
	cAcao1		  := "NO ARQUIVO SHELL.CFG SE EM AMBIENTE DE REDE."
EndIf
IF nPos = 0
	cExplanaca := "ERRO NAO DOCUMENTADO."
	cAcao 	  := "IMPRIMA ESTA TELA. E ENTRE EM CONTATO COM O"
	cAcao1	  := "SUPORTE TECNICO ATRAVES DO TEL (69)451.2286 ou SUPORTE@MICROBRAS.COM.BR"
EndIF

/*
IF nSubCode = 1003
	FChDir( oAmbiente:xBase )
	Set Date British
	Set Console Off
	FClose( cPrograma )
	IF !File( cPrograma )
		cHandle := Fcreate( cPrograma, FC_NORMAL )
		FClose( cHandle )
	EndIF
	cHandle := FOpen( cPrograma, FO_READWRITE + FO_SHARED )
	IF ( Ferror() != 0 )
		FClose( Handle )
		SetColor("")
		Cls
		Alert( "Erro #3: Erro de Abertura " + cPrograma + ". Erro DOS " + Str( Ferror(),3))
		Break(e)
		FlReset()
		Quit
	EndIF
	FBot( cHandle )
	FWriteLine( cHandle, Replicate("=", 80))
	FWriteLine( cHandle, "Usuario   : " + oAmbiente:xUsuario )
	FWriteLine( cHandle, "Data      : " + DToC(Date()))
	FWriteLine( cHandle, "Horas     : " + Time())
	FWriteLine( cHandle, "SubSystem : " + csystem )
	FWriteLine( cHandle, "SubCode   : " + Str(nsubcode, 4))
	FWriteLine( cHandle, "Variavel  : " + e:operation )
	FWriteLine( cHandle, "Arquivo   : " + e:filename )
	FWriteLine( cHandle, "Area      : " + Alias())
	FWriteLine( cHandle, "Indice    : " + IndexKey( IndexOrd()))
	FWriteLine( cHandle, "Descricao : " + e:description )
	FWriteLine( cHandle, "Explanacao: " + cexplanacao )
	FWriteLine( cHandle, "Acao      : " + cAcao )
	FWriteLine( cHandle, "Acao      : " + cAcao1 )
	FWriteLine( cHandle, Replicate("-", 80))
	FWriteLine( cHandle, "PILHA DE CARGA" )
	nCol := 0
	i	  := 2
	nX   := 0
	Do While (!Empty(ProcName(i)))
		nCol++
		nX++
		FWriteLine( cHandle, Space(16) + "Linha : " + strzero(procline(i), 6) + "    Proc : " + ProcName(i))
		i++
	EndDo
	FWriteLine( cHandle, Replicate("=", 80))
	Fclose( cHandle )
	Set Console On
	FChDir( oAmbiente:xBase )
	Break(e)
EndIF
*/
SetColor("")
Cls
IF nSubCode = 1012
	IF !Empty( e:FileName() )
		ErrorBeep()
		IF Conf("O arquivo " + AllTrim( e:FileName()) + " corrompeu. Criar um novo ?")
			cTemp := StrTran( e:FileName(), ".DBF") + ".OLD"
			Ferase( cTemp )
			IF MsRename( e:FileName(), cTemp )
				IF CriaArquivo( e:FileName() )
					Aeval( Directory( "*.NTX"), { | aFile | Ferase( aFile[ F_NAME ] )})
					Cls
					ErrorBeep()
					Alerta("Informa: Arquivo " + e:FileName() + " criado. Carregue novamente o Sistema.")
					FChDir( oAmbiente:xBase )
					Break( e )
					Quit
				EndIF
			Else
				Alerta("Erro: Impossivel consertar o arquivo.")
			EndIF
		EndIF
	EndIF
EndIF
Set Devi To Screen
Set Prin Off
Set Cons On
Set Print to
Set Color To Gr+/b
@	0,  0 Clear To  8, MaxCol()
@		  0,	0 To	8, MaxCol() Color "Gr+/b"
@		  1,	1 Say "SubSystem : "
@	2,  1 Say "Variavel  : "
@		  3,	1 Say "Area      : "
@	4,  1 Say "Descri‡ao : "
@	5,  1 Say "Explana‡ao: "
@	6,  1 Say "A‡ao      : "

@		  1, 35 Say "SubCode : "
@		  2, 35 Say "Arquivo : "
@		  3, 35 Say "Indice  : "
@		  1, 14 Say csystem Color "W+/B"
@		  1, 45 Say Str(nsubcode, 4) Color "W+/B"
@		  2, 14 Say e:operation() Color "W+/B"
@		  2, 45 Say Upper(e:filename()) Color "W+/B"
@		  3, 14 Say Alias() Color "W+/B"
@		  3, 45 Say Upper(IndexKey(IndexOrd())) Color "W+/B"
@		  4, 14 Say e:description Color "W+/B"
@	5, 14 Say cexplanaca Color "W+/B"
@	6, 14 Say cacao Color "R/B"
@	7, 14 Say cacao1 Color "R/B"
ncol := 16
Set Color To Gr+/b
@ ncol,	0 Clear To 23, MaxCol()
@ ncol,	0		  To 23, MaxCol() Color "Gr+/b"
@ ncol, 12 Say "PILHA DE CARGA" Color "W+/B"
i	:= 2
nx := 0
ncol ++
nRow := 00
Do While (!Empty( ProcName(i)))
	nx++
	@ ncol, nRow+01 Say "[" + StrZero( i, 2 )   + "]:"        Color "W+/B"
	@ ncol, nRow+06 Say "[" + strzero(procline(i), 6) + "]:"  Color "GR+/B"
	@ ncol, nRow+16 Say ProcName(i)								  Color "W+/B"
	i++
	nCol++
	IF nCol >= 23
		nCol := 17
		nRow += 40
	EndIF
EndDo
cmessage := "Escolha uma opcao abaixo."
aoptions := {"Encerrar"}
If (e:canretry())
	AAdd(aoptions, "Tentar")
EndIf
If (e:candefault())
	AAdd(aoptions, "Default")
EndIf
nchoice:= 0
Do While (nchoice == 0)
	nchoice:= alert(cmessage, aoptions)
	If (!Empty(nchoice))
		If (aoptions[nchoice] == "Encerrar")
			nopcao:= alert("Pergunta: Imprimir resultado para ?", {"Nenhum", "Impressora"})
			If (nopcao == 2)
				If (instru80() .AND. lptok())
					printon()
					setprc(0, 0)
					Qout(Replicate("=", 80))
					@	02,  01 Say "SubSystem : " + csystem
					@	03,  01 Say "SubCode   : " + Str(nsubcode, 4)
					@	04,  01 Say "Variavel  : " + e:operation()
					@	05,  01 Say "Arquivo   : " + e:filename()
					@	06,  01 Say "Area      : " + Alias()
					@	07,  01 Say "Descricao : " + e:description
					@	08,  01 Say "Explanacao: " + cexplanaca
					@	09,  01 Say "Acao      : " + cacao
					@	10,  13 Say cacao1
					Qout( Replicate("-", 80))
					ncol := 12
					@ ncol,	6 Say "[Pilha de Carga]"
					i := 2
					nx := 0
					Do While (!Empty(ProcName(i)))
						nCol++
						nX++
						@ nCol, 01 Say StrZero(nX, 2) +")Proc:"
						@ nCol, 09 Say ProcName(i) Color "W+/B"
						@ nCol, 20 Say "Linha:"
						@ nCol, 26 Say strzero(procline(i), 6) Color "W+/B"
						i++
					EndDo
					Qout(Replicate("=", 80))
					Eject
					PrintOff()
				EndIf
			EndIF
			FChDir( oAmbiente:xBase )
			Set Date British
			Set Console Off
			FClose( cPrograma )
			IF !File( cPrograma )
				cHandle := Fcreate( cPrograma, FC_NORMAL )
				FClose( cHandle )
			EndIF
			cHandle := FOpen( cPrograma, FO_READWRITE + FO_SHARED )
			IF ( Ferror() != 0 )
				FClose( Handle )
				SetColor("")
				Cls
				Alert( "Erro #3: Erro de Abertura " + cPrograma + ". Erro DOS " + Str( Ferror(),3))
				Break(e)
				FlReset()
				Quit
			EndIF
			FBot( cHandle )
			FWriteLine( cHandle, Replicate("=", 80))
			FWriteLine( cHandle, "Usuario   : " + oAmbiente:xUsuario )
			FWriteLine( cHandle, "Data      : " + DToC(Date()))
			FWriteLine( cHandle, "Horas     : " + Time())
			FWriteLine( cHandle, "SubSystem : " + csystem )
			FWriteLine( cHandle, "SubCode   : " + Str(nsubcode, 4))
			FWriteLine( cHandle, "Variavel  : " + e:operation )
			FWriteLine( cHandle, "Arquivo   : " + e:filename )
			FWriteLine( cHandle, "Area      : " + Alias())
			FWriteLine( cHandle, "Indice    : " + IndexKey( IndexOrd()))
			FWriteLine( cHandle, "Descricao : " + e:description )
			FWriteLine( cHandle, "Explanacao: " + cexplanacao )
			FWriteLine( cHandle, "Acao      : " + cAcao )
			FWriteLine( cHandle, "Acao      : " + cAcao1 )
			FWriteLine( cHandle, Replicate("-", 80))
			FWriteLine( cHandle, "PILHA DE CARGA" )
			i	:= 2
			nX := 0
			Do While (!Empty(ProcName(i)))
				nCol++
				nX++
				FWriteLine( cHandle, Space(16) + "Linha : " + strzero(procline(i), 6) + "    Proc : " + ProcName(i))
				i++
			EndDo
			FWriteLine( cHandle, Replicate("=", 80))
			Fclose( cHandle )
			Set Console On
			SetColor("")
			Cls
			FChDir( oAmbiente:xBase )
			Break(e)
			FlReset()
			Quit
		ElseIf (aoptions[nchoice] == "Tentar")
			ResTela( cScreen )
			Return .T.
		ElseIf (aoptions[nchoice] == "Default")
			ResTela( cScreen )
			Return .F.
		EndIf
	EndIf
EndDo
Set Device To Screen
Set Printer Off
Break
Return .T.

Function TamPagina( nTamanho )
******************************
IF XIMPRESSORA = 9 .OR. XIMPRESSORA = 10 .OR. XIMPRESSORA = 11
	Return( Chr(ESC) + "&l" + StrZero( nTamanho, 3) + "P" )
Else
	Return( Chr( ESC ) + "C" + Chr( nTamanho ) )
EndIF

Proc EncerraDbf( cCampo, cName, nLine )
***************************************
SetColor("")
Cls
ErrorBeep()
IF cCampo = NIL
	Alert( "Erro #11: Configuracao de SCI.DBF alterada.;" + cName + ":" + StrZero( nLine, 6 ))
Else
	Alert( "Erro #11: Configuracao de SCI.DBF alterada.; Campo : " + cCampo )
EndIF
Quit

Proc VerExe()
*************
IF !( XNOME_EXE $ Program())
	SetColor("")
	Cls
	ErrorBeep()
	Alert( "Erro #9: Favor renomear este aplicativo para " + XNOME_EXE )
	Quit
EndIF
Return

Function Hard( nPos, ProcName, ProcLine )
*****************************************
LOCAL cScreen := SaveScreen()
LOCAL cCodigo
LOCAL cSenha
LOCAL nCrc
LOCAL cCrc
LOCAL cData
LOCAL dData
LOCAL nSpaco
LOCAL nTemp
LOCAL cMens 			:= "Foi detectado um problema, Verifique as opcoes:"
LOCAL aMensagem		:= Array(3,5)
		aMensagem[1,1] := "[Limite de Codigo de Acesso Vencido]"
		aMensagem[1,2] := "1 - A data do Sistema Operacional esta correta ?"
		aMensagem[1,3] := "2 - Caso Positivo, solicite novo Codigo de Acesso."
		aMensagem[1,4] := ""
		aMensagem[1,5] := ""

		aMensagem[2,1] := "[Verificacao de Copia Original]"
		aMensagem[2,2] := "1 - O SCI esta sendo instalado pela 1?vez ?"
		aMensagem[2,3] := "2 - Esta atualizando a versao do SCI ?"
		aMensagem[2,4] := "3 - Esta instalando um novo terminal ?"
		aMensagem[2,5] := "4 - Caso Positivo, solicite Codigo de Acesso."

		aMensagem[3,1] := "[Renovacao de Codigo de Acesso]"
		aMensagem[3,2] := "1 - Informe ao nosso suporte tecnico que est  sendo"
		aMensagem[3,3] := "    um pedido antecipado de codigo de acesso, e que"
		aMensagem[3,4] := "    o mesmo ‚ de seu conhecimento.                 "
		aMensagem[3,5] := ""

IF ProcName != NIL
	cMens := ProcName + "(" + StrZero( ProcLine, 5 ) + "): " + cMens
EndIF
Set Conf On
oMenu:Limpa()
BoxConf( 00, 05, 24, 75 )
CenturyOn()
WHILE OK
	nTemp := Val( StrTran( Time(), ":"))
	Seed( nTemp )
	cCodigo := ""
	For nX := 1 To 5
		nNumero := Random()
		nNumero := Alltrim( Str( nNumero ))
		cCodigo += Left( nNumero, 2)
	Next
	ErrorBeep()
	SetColor("R/W")
	Write( 01, 06, cMens )
	SetColor("B/W")
	Write( 03, 06, aMensagem[nPos,1])
	SetColor("GR+/W")
	Write( 04, 06, aMensagem[nPos,2])
	Write( 05, 06, aMensagem[nPos,3])
	Write( 06, 06, aMensagem[nPos,4])
	Write( 07, 06, aMensagem[nPos,5])
	SetColor("N/W")
	Write( 09, 06, "Sr. Usuario, ligue para o Depto. de Suporte ao Usuario atraves do" )
	Write( 10, 06, "Tel (069)451-2286 e informe os dados apresentados abaixo:")
	cInterno := Left( cCodigo,3 ) + "." + SubStr( cCodigo, 4, 3 ) + "." + Right( cCodigo, 4 )
	Write( 12, 06, "Nome do Registro....: " + XNOMEFIR )
	Write( 13, 06, "Nome do Aplicativo..: " + SISTEM_NA1 )
	Write( 14, 06, "Versao..............: " + SISTEM_VERSAO )
	Write( 15, 06, "Codigo Interno......: " )
	@		 15, 28 Say cInterno Color "R/W"

	Write( 17, 06, "O Depto. de Suporte ira lhe informar um codigo de acesso para libe-")
	Write( 18, 06, "racao imediata do sistema, o qual devera ser digitado abaixo:")

	//SetKey( 309, {||Cod_Acesso( cCodigo, GetList ) } )
	@ 22, 06 Say "IMPORTANTE: Nao tecle ENTER ou saia antes de ter o codigo de acesso," Color "R/W"
	@ 23, 06 Say "pois o codigo interno se modificara novamente." Color "R/W"

	Set Date Brit
	dDatados := Date()
	cSenha	:= Space(13)
	@ 20, 06 Say "Codigo de Acesso...:" Get cSenha   Pict "@R 999.999.999.999.9" Valid Right( cSenha, 3) != "000"
	@ 20, 45 Say "Data Atual..:"        Get dDatados Pict "##/##/##"
	Read
	//SetKey( 309, NIL )
	IF LastKey() = ESC
		IF nPos <> 3
			Cls
			Quit
		Else
			CenturyOff()
			Return
		EndIF
	EndIF
	nCrc := 0
	For nX := 1 To 10
		nCrc += Val( SubStr( cSenha, nX,1)) * Val( SubStr( cSenha, nX, 1)) + Val( SubStr( cCodigo, nX,1))
	Next
	cCrc := Right(StrZero( nCrc, 10),3)
	IF cCrc != Right( cSenha, 3 )
		ErrorBeep()
		Alert("Erro : O Codigo de Acesso inv lido. Solicite Novamente.")
		Loop
	EndIF
	Set Date To USA // mm/dd/yy
	cDataDos := Dtoc( dDataDos )
	cData 	:= SubStr( cSenha, 3, 2 ) + "/" + Left( cSenha, 2) + "/" + SubStr( cSenha, 5, 2 )
	dData 	:= Dtoc( Ctod( cData ))
	SET DEFA TO ( oAmbiente:xBase )
	IF !File( 'SCI.DBF' )
		SetColor("")
		Cls
		ErrorBeep()
		Alert( oAmbiente:xBase )
		Alert( "Erro: Arquivo SCI.DBF nao localizado.")
		Quit
	EndIF
	IF !NetUse( 'SCI.DBF', OK )
		SetColor("")
		Cls
		ErrorBeep()
		Alert("Erro: Impossivel abrir SCI.DBF.")
		Quit
	EndIF
	oAmbiente:xDataCodigo := dData
	cDia := SubStr( oAmbiente:xDataCodigo, 4, 2 )
	cMes := Left(	oAmbiente:xDataCodigo, 2 )
	cAno := Right( oAmbiente:xDataCodigo, 4 )
	oAmbiente:xDataCodigo := cDia + "/" + cMes + "/" + cAno
	CopyCria()
	IF Sci->(TravaArq())
		Sci->Limite   := MsCriptar( dData )
		Sci->(Libera())
		Sci->(DbCloseArea())
	Else
		IF nPos <> 3
			Cls
			Quit
		EndIF
	EndIF
	Set Defa To ( oAmbiente:xBaseDados )
	ResTela( cScreen )
	Exit
EndDo
CenturyOff()
Set Conf Off
Return

Function Cod_Acesso( cCodigo, GetList )
**************************************
LOCAL Data_Limite
LOCAL cExecucoes

	CenturyOff()
	// Monte a Senha Para calculo
	cExecucoes	 := Right( StrTran( Time(), ":"),2)
	cExecucoes	 += Right( StrTran( Time(), ":"),2)
	cData_Limite := StrTran( Dtoc( Date()+15), "/" )
	cSenha		 := cData_Limite + cExecucoes

	// Calcula o Crc
	nCrc := 0
	nX   := 0
	For nX := 1 To 10
		nCrc += Val( SubStr( cSenha,	nX, 1 )) * ;
				  Val( SubStr( cSenha,	nX, 1 )) + ;
				  Val( SubStr( cCodigo, nX, 1 ))
	Next
	cCrc	 := Right( StrZero( nCrc, 10),3)
	cSenha += cCrc
	cSenha := Tran( cSenha, "@R 999.999.999.999.9")
	Getlist[1]:buffer  := cSenha
	Getlist[1]:Changed := OK
	Getlist[1]:Assign()
	Getlist[1]:Reset()
	Getlist[1]:Display()
	Getlist[1]:ExitState := GE_ENTER
	CenturyOn()
	Return

Function HoraSaida( HR_ENTRADA, HR_SAIDA )
******************************************
LOCAL cStartTime := HR_ENTRADA
LOCAL cTempo	  := StrTran( TimeDiff( cStartTime, Time()), ":")

IF !NetUse("SCI", OK )
	EncerraDbf(, ProcName(), ProcLine())
EndIF
IF Sci->(TravaReg())
	Sci->Time += Val( cTempo )
	Sci->(Libera())
	Sci->(DbCloseArea())
Else
	Cls
	Quit
EndIF

FUNCTION TimeDiff( cStartTime, cEndTime )
*****************************************
RETURN TimeAsString(IIF(cEndTime < cStartTime, 86400 , 0) +;
		 TimeAsSeconds(cEndTime) - TimeAsSeconds(cStartTime))

FUNCTION TimeAsSeconds( cTime )
*******************************
RETURN VAL(cTime) * 3600 + VAL(SUBSTR(cTime, 4)) * 60 +;
		 VAL(SUBSTR(cTime, 7))

FUNCTION TimeAsString( nSeconds )
*********************************
RETURN StrZero(INT(Mod(nSeconds / 3600, 24)), 2, 0) + ":" +;
					StrZero(INT(Mod(nSeconds / 60, 60)), 2, 0) + ":" +;
					StrZero(INT(Mod(nSeconds, 60)), 2, 0)


FUNCTION ScrollBarNew( nTopRow, nTopColumn, nBottomRow, cColorString, nInitPosition )
*************************************************************************************
	LOCAL aScrollBar := ARRAY( TB_ELEMENTS )

	aScrollBar[ TB_ROWTOP ] 	:= nTopRow
	aScrollBar[ TB_COLTOP ] 	:= nTopColumn
	aScrollBar[ TB_ROWBOTTOM ] := nBottomRow
	aScrollBar[ TB_COLBOTTOM ] := nTopColumn

	IF cColorString == NIL
		cColorString := "W/N"
	ENDIF
	aScrollBar[ TB_COLOR ] := cColorString

	IF nInitPosition == NIL
		nInitPosition := 1
	ENDIF
	aScrollBar[ TB_POSITION ] := nInitPosition

	RETURN ( aScrollBar )

FUNCTION ScrollBarDisplay( aScrollBar )
***************************************
LOCAL cOldColor
LOCAL nRow

cOldColor := SETCOLOR( aScrollBar[ TB_COLOR ] )
@ aScrollBar[ TB_ROWTOP ], aScrollBar[ TB_COLTOP ] SAY TB_UPARROW
@ aScrollBar[ TB_ROWBOTTOM ], aScrollBar[ TB_COLBOTTOM ] SAY TB_DNARROW

FOR nRow := (aScrollBar[ TB_ROWTOP ] + 1) TO (aScrollBar[ TB_ROWBOTTOM ] - 1)
	@ nRow, aScrollBar[ TB_COLTOP ] SAY TB_BACKGROUND
NEXT
SETCOLOR( cOldColor )
RETURN ( aScrollBar )

FUNCTION ScrollBarUpdate( aScrollBar, nCurrent, nTotal, lForceUpdate )
*******************************************************************
LOCAL cOldColor
LOCAL nNewPosition
LOCAL nScrollHeight := ( aScrollBar[TB_ROWBOTTOM] - 1 ) - ( aScrollBar[TB_ROWTOP] )

IF nTotal < 1
	nTotal := 1
ENDIF

IF nCurrent < 1
	nCurrent := 1
ENDIF

IF nCurrent > nTotal
	nCurrent := nTotal
ENDIF

IF lForceUpdate == NIL
	lForceUpdate := .F.
ENDIF

cOldColor := SETCOLOR( aScrollBar[ TB_COLOR ] )

nNewPosition := ROUND( (nCurrent / nTotal) * nScrollHeight, 0 )

nNewPosition := IIF( nNewPosition < 1, 1, nNewPosition )
nNewPosition := IIF( nCurrent == 1, 1, nNewPosition )
nNewPosition := IIF( nCurrent >= nTotal, nScrollHeight, nNewPosition )

IF nNewPosition <> aScrollBar[ TB_POSITION ] .OR. lForceUpdate
	@ (aScrollBar[ TB_POSITION ] + aScrollBar[ TB_ROWTOP ]), aScrollBar[ TB_COLTOP ] SAY TB_BACKGROUND
	@ (nNewPosition + aScrollBar[ TB_ROWTOP ]), aScrollBar[ TB_COLTOP ] SAY TB_HIGHLIGHT
	aScrollBar[ TB_POSITION ] := nNewPosition
ENDIF
SETCOLOR( cOldColor )
RETURN ( aScrollBar )

Function Criptar( Pal )
***********************
LOCAL Fra, X, L
Fra := ""
Tam := Len( Pal )
FOR X := 1 TO Tam
	 L := SubStr(Pal, X, 1)
	 Fra += Chr(Asc(L) + 61 - 2 * X + 3 * x )
NEXT
RETURN Fra

Function DCriptar( Pal )
************************
LOCAL Fra, X, L, Tam
Fra := ""
Tam := Len( Pal )
FOR X := 1 TO Tam
	 L := SubStr(Pal, X, 1)
	 Fra += Chr(Asc(L) - 61 + 2 * X - 3 * x )
NEXT
RETURN Fra

Function M_Menu( Arg1, Arg2, Arg3, Arg4, aMensagem )
****************************************************
LOCAL Local1[Len(Arg2)]
LOCAL Local2[Len(Arg2)]
LOCAL Local3[Len(Arg2)]
LOCAL Local4  := {}
LOCAL Local5  := {}
LOCAL Local6  := {}
LOCAL Local7  := 1
LOCAL Local8  := 1
LOCAL Local9  := 2
LOCAL Local10 := .F.
LOCAL Local11 := M_Frame()
LOCAL Local12
LOCAL Local13
LOCAL Local14
LOCAL Local15
LOCAL Local16
LOCAL Local17
LOCAL Local18

Arg4	  := IIF( Arg4 = Nil, 0, Arg4 )
Local17 := Int(Arg1)
Local18 := IIF( Arg3 == Nil, Standard(), Arg3 )
Local13 := Len(Arg2)
Afill(Local2, Arg4)
Local3[ 1 ] := 1
M_Csron()
M_Csroff()
Aprint(Arg4, 0, "", Local18, MaxCol() + 1)
Local1[ 1 ] := Strextract(Arg2[ 1 ], ":", 1)
Aprint(Arg4, 1, Local1[ 1 ], Local18)
FOR Local12 := 2 TO Local13
	 Local1[ Local12 ] := Strextract(Arg2[ Local12 ], ":", 1)
	 Local3[ Local12 ] := Local3[ Local12 - 1 ] + ( Aprintlen(Local1[ Local12 - 1 ]) + 1 )
	 Aprint(Arg4, Local3[ Local12 ], Local1[ Local12 ], Local18)
NEXT
Local9 := Aprintlen(Local1[ Local12 - 1 ])
M_Csron()
WHILE ( .T. )
	 Local7 := M_Aprompt(.F., Local17, Local2, Local3, Local1, Local18, aMensagem)
	 IF ( Local7 = 0 )
		  RETURN 0.0
	 ENDIF
	 M_Wait(1)
	 Local14 := Chrcount(":", Arg2[ Local7 ])
	 Local17 := Local7
	 IF ( Local14 < 1 )
		  IF ( !Local10 )
				RETURN Local7 + 0.0
		  ELSE
				Local10 := .F.
				LOOP
		  ENDIF
	 ENDIF
    IF ( Local14 > MaxRow() - 1 )
        Local14 := MaxRow() - 1
	 ENDIF
	 Asize(Local4, Local14)
	 Asize(Local5, Local14)
	 Asize(Local6, Local14)
	 FOR Local12 := 1 TO Local14
		  Local4[ Local12 ] := "  " + Strextract(Arg2[ Local7 ], ":", Local12 + 1)
		  Local5[ Local12 ] := Local12 + 1 + Arg4
	 NEXT
	 Local9 := Amaxstrlen(Local4) + 2
    IF ( Local3[ Local7 ] + Local9 + 3 > MaxCol() + 1 )
        Local15 := MaxCol() + 1 - ( Local9 + 3 )
	 ELSE
		  Local15 := Local3[ Local7 ] + 1
	 ENDIF
	 Afill(Local6, Local15)
	 FOR Local12 := 1 TO Local14
		  Local4[ Local12 ] := Untrim(Local4[ Local12 ], Local9)
	 NEXT
	 M_Csroff()
	 Local16 := Savevideo(Arg4 + 1, Local15 - 3, Local14 + 3 + Arg4, Local15 + Local9 + 2)
	 Box(Arg4 + 1, Local15 - 1, Local14 + 2 + Arg4, Local15 + Local9, Local11 + " ", Local18)
	 M_Csron()
	 IF ( Local8 <= 0 )
		  Local8 := 1
	 ENDIF
	 Local8 := M_Aprompt(.T., Local8, Local5, Local6, Local4, Local18, aMensagem )
	 M_Wait(1)
	 M_Csroff()
	 Restvideo(Arg4 + 1, Local15 - 3, Local14 + 3 + Arg4, Local15 + Local9 + 2, Local16)
	 M_Csron()
	 IF ( Local8 < -1 )
		  IF ( Local8 = -3 )
				Local17 := IIF( Local17 = Local13, 1, Local17 + 1 )
				Nstuff(13)
		  ENDIF
		  IF ( Local8 = -2 )
				Local17 := IIF( Local17 = 1, Local13, Local17 - 1 )
				Nstuff(13)
		  ENDIF
		  Local10 := .T.
		  LOOP
	 ELSEIF ( Local8 > 0 )
		  RETURN Local7 + Local8 / 100
	 ENDIF
	 Local10 := .F.
END

Function M_Aprompt( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, aMensagem )
*******************************************************************************
LOCAL Local1 := .F.
LOCAL Local2 := 0
LOCAL Local3 := 0
LOCAL Local4 := {}
LOCAL Local5 := .F.
LOCAL Local6 := MaxCol() + 1
LOCAL Local7
LOCAL Local8 := Len( Arg5 )
LOCAL Local9
LOCAL Local10
LOCAL Local11 := Arg6
LOCAL Local12
LOCAL Local13

Colorset(@Local11, @Local7)
IF ( Arg2 < 0 )
	 Local10 := 1
ELSEIF ( Arg2 > Local8 )
	 Local10 := Local8
ELSE
	 Local10 := Arg2
ENDIF
Local9 := Local10
Local7 := Local7 + 256
Local4 := Array(Local8)
M_Csroff()
FOR Local12 := 1 TO Local8
	 Aprint(Arg3[ Local12 ], Arg4[ Local12 ], Arg5[ Local12 ], Local11)
	 Local4[ Local12 ] := Aprintlen(Arg5[ Local12 ]) + Arg4[ Local12 ] - 1
NEXT
Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
IF ( Arg7 != Nil )
	 Aprint(Arg8, 0, "", Local11, Local6)
	 Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
ENDIF
M_Csron()
WHILE ( .T. )
	 WHILE ( .T. )
		  WHILE ( .T. )
				Local2 := InKey()
				IF ( Local5 := _Isbutton(1) )
					 EXIT
				ENDIF
				IF ( Local2 != 0 )
					 Local13 := SetKey(Local2)
					 IF ( Local13 != Nil )
						  Eval(Local13, Procname(2), Procline(2))
						  LOOP
					 ELSE
						  EXIT
					 ENDIF
				ENDIF
		  END
		  Local9 := Local10
		  IF ( Local5 )
				Local3 := M_Aregion(Arg3, Arg4, Arg3, Local4)
				IF ( Local3 > 0 )
					 WHILE ( _Isbutton(1) )
						  IF ( Local3 > 0 )
								Local10 := Local3
						  ENDIF
						  IF ( Local9 != Local10 )
								M_Csroff()
								Aprint(Arg3[ Local9 ], Arg4[ Local9 ], Arg5[ Local9 ], Local11)
								Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
								IF ( Arg7 != Nil )
									 Aprint(Arg8, 0, "", Local11, Local6)
									 Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
								ENDIF
								M_Csron()
								Local9 := Local10
						  ENDIF
						  Local3 := M_Aregion(Arg3, Arg4, Arg3, Local4)
					 END
					 IF ( Local3 == M_Aregion(Arg3, Arg4, Arg3, Local4) .AND. Local3 > 0 )
						  Local10 := Local3
						  Local1 := .T.
						  EXIT
					 ENDIF
				ELSEIF ( Arg1 .AND. !Local1 .AND. Local5 )
					 RETURN -1
				ELSE
					 LOOP
				ENDIF
		  ENDIF
		  DO CASE
		  CASE ( Local2 == 27 )
				RETURN 0
		  CASE ( Local2 == 5 .OR. Local2 == 19 )
				Local10 := IIF( Local10 == 1, Local8, Local10 - 1 )
				EXIT
		  CASE ( Local2 == 4 .OR. Local2 == 24 )
				Local10 := IIF( Local10 == Local8, 1, Local10 + 1 )
				EXIT
		  CASE ( Local2 == 1 )
				Local10 := 1
				EXIT
		  CASE ( Local2 == 6 )
				Local10 := Local8
				EXIT
		  CASE ( Local2 < 128 .AND. Local2 > 32 )
				Local3 := Achartest(Chr(Local2), "", Arg5)
				IF ( Local3 > 0 )
					 Local10 := Local3
					 Local1 := .T.
					 EXIT
				ENDIF
		  CASE ( Local2 == 13 .OR. Local2 == 18 .OR. Local2 == 3  .OR. Local2 == 32)
				RETURN Local10
		  OTHERWISE
				LOOP
		  ENDCASE
	 END
	 IF ( Local9 != Local10 )
		  M_Csroff()
		  Aprint(Arg3[ Local9 ], Arg4[ Local9 ], Arg5[ Local9 ], Local11)
		  Aprint(Arg3[ Local10 ], Arg4[ Local10 ], Arg5[ Local10 ], Local7)
		  IF ( Arg7 != Nil )
				Aprint(Arg8, 0, "", Local11, Local6)
				Aprint(Arg8, Shr(Local6 - Aprintlen(Arg7[ Local10 ]), 1), Arg7[ Local10 ], Local11)
		  ENDIF
		  M_Csron()
	 ENDIF
	 IF ( Arg1 .AND. Local2 == 19 )
		  RETURN -2
	 ENDIF
	 IF ( Arg1 .AND. Local2 == 4 )
		  RETURN -3
	 ENDIF
	 IF ( Local1 )
		  RETURN Local10
	 ENDIF
END

STATIC Function ColorSet( Arg1, Arg2 )
**************************************
IF ( Arg1 == Nil )
	 Arg1 := Standard()
	 Arg2 := Enhanced()
ELSEIF ( Arg1 < 0 )
	 Arg1 := Standard()
	 Arg2 := Enhanced()
ELSE
	 Arg2 := Roloc(Arg1)
ENDIF
Return NIL

Function CTBA( Lin, Col )
*************************
DevPos( Lin,	 Col ) ; Devout(" ÚÄÄÄÄÄ?   ÚÄÄÄÄÄ? ÚÄ?)
DevPos( Lin+01, Col ) ; Devout(" ßßßßßßÀ¿   ßßßßßßÀ¿ ßß?)
DevPos( Lin+02, Col ) ; Devout("ßßßßßßßß? ßßßßßßßß?ßß?)
DevPos( Lin+03, Col ) ; Devout("ßß?  ßß? ßß?  ßß?ßß?)
DevPos( Lin+04, Col ) ; Devout("ßßÀÄÄÄÄ¿   ßß?      ßß?)
DevPos( Lin+05, Col ) ; Devout("ßßßßßßßÀ? ßß?      ßß?)
DevPos( Lin+06, Col ) ; Devout(" ßßßßßßß³  ßß?      ßß?)
DevPos( Lin+07, Col ) ; Devout("      ßß? ßß?      ßß?)
DevPos( Lin+08, Col ) ; Devout("ßßÄÄÄÄßß? ßßÀÄÄÄßß?ßß?)
DevPos( Lin+09, Col ) ; Devout("ßßßßßßßß? ßßßßßßßß?ßß?)
DevPos( Lin+10, Col ) ; Devout(" ßßßßßß?   ßßßßßß? ßß?)
If ( InKey(0.05) != 0 )
	Return .T.
EndIf
Return .F.

Proc Protela()
**************
LOCAL LOCAL1
LOCAL LOCAL2
LOCAL LOCAL5 := Setcursor()
LOCAL LOCAL6 := Row()
LOCAL LOCAL7 := Col()
LOCAL LOCAL3 := SaveScreen(0, 0, 24, 79)
LOCAL cColor := SetColor("W+/B")


VisualCLock()
Return


Scroll()
SetPos(0, 0)
Setcursor(0)
While ( .T. )
	 For LOCAL2 := 0 To 46
		  Limpacol(0, LOCAL2, 1)
		  If ( Ctba(0, LOCAL2) )
				RestScreen(0, 0, 24, 79, LOCAL3)
				SetColor( cColor )
				Setcursor(LOCAL5)
				DevPos(LOCAL6, LOCAL7)
				DevOut("")
				Return
		  EndIf
	 Next
	 For LOCAL1 := 0 To 20
		  If ( LOCAL1 > 0 )
				DevPos(LOCAL1 - 1, 46)
				DevOut(Space(34))
		  EndIf
		  If ( Ctba(LOCAL1, 46) )
				RestScreen(0, 0, 24, 79, LOCAL3)
				SetColor( cColor )
				Setcursor(LOCAL5)
				DevPos(LOCAL6, LOCAL7)
				DevOut("")
				Return
		  EndIf
	 Next
	 For LOCAL2 := 46 To 0 Step -1
		  Limpacol(20, LOCAL2, -1)
		  If ( Ctba(20, LOCAL2) )
				RestScreen(0, 0, 24, 79, LOCAL3)
				SetColor( cColor)
				Setcursor(LOCAL5)
				DevPos(LOCAL6, LOCAL7)
				DevOut("")
				Return
		  EndIf
	 Next
	 For LOCAL1 := 20 To 0 Step -1
		  If ( LOCAL1 < 20 )
				DevPos(LOCAL1 + 5, 0)
				DevOut(Space(34))
		  EndIf
		  If ( Ctba(LOCAL1, 0) )
				RestScreen(0, 0, 24, 79, LOCAL3)
				SetColor( cColor )
				Setcursor(LOCAL5)
				DevPos(LOCAL6, LOCAL7)
				DevOut("")
				Return
		  EndIf
	 Next
End

Function LIMPACOL
*****************
Local LOCAL1
Parameters lIn, cOl, dIr
If ( dIr = 1 .AND. cOl > 0 )
	 For LOCAL1 := 0 To 4
		  DevPos(lIn + LOCAL1, cOl - 1)
		  DevOut(" ")
	 Next
EndIf
If ( dIr = -1 .AND. cOl < 46 )
	 For LOCAL1 := 0 To 4
		  DevPos(lIn + LOCAL1, cOl + 34)
		  DevOut(" ")
	 Next
EndIf
Return .T.

Function MsBox( nCol, nRow, nCol1, nRow1, nCor, lRelevo, cTexto )
*****************************************************************
LOCAL cFrame  := oAmbiente:Frame
LOCAL nRetVal
LOCAL PBack
LOCAL aCor
LOCAL aFundo
LOCAL aCima
LOCAL cCor
IF lRelevo // Alto Relevo
  aCor	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
  aFundo   := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
  aCima	  := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
Else
  aCor	  := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
  aFundo   := { 25,47,53,76,64,86,101,117,143,149,165,181,207,213,239 }
  aCima	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
EndIF
IF nCor = NIL
	nCor	 := CorBox()
EndIF
cCor					:= aCor[nCor]
oAmbiente:CorCima := aCima[ nCor ]
nComp 				:= ( nRow1 - nRow )-1
ColorSet( @cCor, @PBack )
M_Frame( cFrame )
Box( nCol, nRow, nCol1, nRow1, M_Frame() + " ", aFundo[ nCor], 1, 8 )
cFrame1 := Left( cFrame, 1 )
cFrame2 := SubStr( cFrame, 2, 1 )
cFrame8 := SubStr( cFrame, 8, 1 )
cFrame7 := SubStr( cFrame, 7, 1 )
Print( nCol, nRow, cFrame1, aCima[nCor], 1 )
Print( nCol, nRow+1, Repl( cFrame2, nComp), aCima[nCor] )
For x := nCol+1 To nCol1-1
	Print( x, nRow, cFrame8, aCima[nCor], 1 )
Next
Print( nCol1, nRow, cFrame7,	aCima[nCor],1 )
IF cTexto != NIL
	Print( nCol+1, nRow+1, Padc( cTexto, nRow1-nRow-1), aCima[nCor] )
EndIF
cSetColor( SetColor())
nSetColor( cCor, Roloc( cCor ))
Return NIL

Function MsAlerta( Texto, aArray, PosVertical, lRelevo )
********************************************************
LOCAL nRetVal
LOCAL PBack
LOCAL Telavelha	 := SaveScreen()
LOCAL nCor			 := CorBox()
LOCAL Exceto		 := .F.
LOCAL Ativo 		 :=  1
LOCAL cFrame		 := "ÚÄ¿³ÙÄÀ³"
LOCAL TamanhoTexto := Len( Texto ) + 2
LOCAL aCor
LOCAL aFundo
LOCAL cCor
LOCAL aCima
LOCAL nTam			 := 0
LOCAL aCol			 := {}
LOCAL aRow			 := {}
LOCAL nLenArray

IF oAmbiente:Visual
	Return( Alerta( Texto, aArray ))
ELSE
	lRelevo		 := IIF( lRelevo = NIL, FALSO, lRelevo )
	IF lRelevo // Alto Relevo
	  aCor	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	  aFundo   := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	  aCima	  := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
	Else
	  aCor	  := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
	  aFundo   := { 25,47,53,76,69,91,101,117,133,149,165,181,207,213,239 }
	  aCima	  := { 16,32,48,64,64,80,096,112,128,144,160,176,192,208,224 }
	EndIF
	aArray	  := IIF( aArray = NIL, { " ÄÙ Okay " }, aArray )
	nLenArray  := Len( aArray )
	For nX  := 1 To nLenArray
		nTam += Len( aArray[nX] ) + 1
	Next
	cCor			 := aCor[nCor]
	TamanhoTexto := IIF( TamanhoTexto < nTam, nTam, TamanhoTexto )
	TamanhoTexto := IIF( TamanhoTexto < 16, 16, TamanhoTexto )
	PosVertical  := IIF( PosVertical = Nil .OR. PosVertical = 0, 11, PosVertical )
	nEsquerda	 := (80-TamanhoTexto)/2
	nComprimento := nEsquerda + TamanhoTexto
	nTexto		 := Len( Texto )
	nPosTexto	 := nEsquerda + ((TamanhoTexto - nTexto) / 2) + 1
	nCima 		 := PosVertical - 2
	nBaixo		 := PosVertical + 2
	nDireita 	 := nComprimento
	nLen			 := 1
	nSobra		 := ( TamanhoTexto - nTam ) / nLenArray
	For nX  := 1 To nLenArray
		Aadd( aRow, nBaixo-1 )
		Aadd( aCol, (nEsquerda+nSobra+nLen))
		nLen += Len(aArray[nX])+1
	Next
	Coluna		 := (TamanhoTexto - 9 ) / 2
	nRow			 := PosVertical + 2
	nCol			 := nEsquerda + Coluna
	nBot			 := PosVertical + 3
	nComp 		 := ( nComprimento - nEsquerda )-1

	ColorSet( @cCor, @PBack )
	M_Frame( cFrame )
	Box( nCima, nEsquerda, nBaixo, nDireita, M_Frame() + " ", aFundo[ nCor], 1, 8 )
	Print( nCima, nEsquerda, '?, aCima[ nCor ], 1 )
	Print( nCima, nEsquerda+1, Repl('?,nComp), aCima[nCor] )
	For x := nCima+1 To nBaixo
		Print( x, nEsquerda, '?, aCima[nCor], 1 )
	Next
	Print( nBaixo, nEsquerda, '?,  aCima[nCor],1 )
	aPrint( nCima + 1, nPosTexto, Texto, aCima[nCor])
	nRetVal := M_Prompt( Exceto, Ativo, aRow, aCol, aArray, aFundo[nCor] )
	ResTela( TelaVelha )
	Return( nRetVal )
EndIF

******************************************************
Function EXPLODE( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6 )
******************************************************
Local Local1, Local2, Local3, Local4, Local5
Local2 := Arg4 - Arg2 + 1
Local2 := Int((Local2 - 2) / 2)
Arg2	 := Arg2 + Local2
Arg4	 := Arg4 - Local2
//box( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6 )
For Local3 := 1 To Local2
	Local5  := 0
	For Local4 := 1 To 100
		Local5++
	Next
	Box( Arg1, Arg2 - Local3, Arg3, Arg4 + Local3, Arg5, Arg6 )
Next
Return Nil

Function MS_Box( nRow, nCol, nRow1, nCol1, cFrame, nCor)
********************************************************
LOCAL nComp 	 := ( nCol1 - nCol )-1

DEFAU cFrame TO M_Frame()
DEFAU nCor	 TO Cor()

return(Box( nRow, nCol, nRow1, nCol1, cFrame + " ", nCor))

//Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )      // Funcky
//DispBox( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )  // Harbour

For x := nRow To nRow1
   Print( x, nCol, Space(1), nCor, nComp+1, " ")
Next

Print( nRow, nCol, Left(cFrame,1), nCor, 1 )
Print( nRow, nCol+1, Repl(SubStr(cFrame,2,1),nComp), nCor )
Print( nRow, nCol1, SubStr(cFrame,3,1), nCor, 1 )
For x := nRow+1 To nRow1
	Print( x, nCol,  SubStr(cFrame,4,1), nCor, 1 )
	Print( x, nCol1, SubStr(cFrame,8,1), nCor, 1 )
Next
Print( nRow1, nCol, SubStr(cFrame,7,1),  nCor, 1 )
Print( nRow1, nCol+1, Repl(SubStr(cFrame,6,1),nComp), nCor )
Print( nRow1, nCol1, SubStr(cFrame,5,1), nCor, 1 )
return NIL

Function MaBox( nTopo, nEsq, nFundo, nDireita, Cabecalho, Rodape, lInverterCor )
*********************************************************************************
LOCAL cPattern := " "
LOCAL pfore 	:= IIF( lInverterCor = NIL, Cor(),	lInverterCor )
LOCAL pback

IF nDireita = 79
	nDireita = MaxCol()
EndIf
ColorSet( @pfore, @pback )
Box( nTopo, nEsq, nFundo, nDireita, oAmbiente:Frame + cPattern, Pfore )
IF Cabecalho != Nil
	aPrint( nTopo, nEsq+1, "?, Roloc( pFore ), (nDireita-nEsq)-1)
	aPrint( nTopo, nEsq+1, Padc( Cabecalho, ( nDireita-nEsq)-1), Roloc( pFore ))
EndIF
IF Rodape != Nil
	aPrint( nFundo, nEsq+1, "?, Roloc( pFore ), (nDireita-nEsq)-1)
	aPrint( nFundo, nEsq+1, Padc( Rodape, ( nDireita-nEsq)-1), Roloc( pFore ))
EndIF
cSetColor( SetColor())
nSetColor( pFore, Roloc( pFore ))
Return

Function ADDBUTTON(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
************************************************************************
Local Local1
Arg5	 := IIF(At("&", Arg5) == 0, "&" + Arg5, Arg5)
Arg7	 := IIF(ISNIL(Arg7), .F., Arg7)
Arg8	 := IIF(ISNIL(Arg8), { || nret() }, Arg8)
Arg9	 := IIF(ISNIL(Arg9), .T., Arg9)
Local1 := SubStr(Arg5, At("&", Arg5) + 1, 1)
AAdd(Arg1, {Arg5, Arg6, Arg8, Arg9, Arg7, Arg2, Arg3, Local1, Arg4})
Return Nil

********************************
Function NINKEY(Arg1)

	Local Local1, Local2, Local3
	Do While (.T.)
		Local1:= .F.
		If (Arg1 = Nil)
			Local2:= InKey()
		Else
			Local2:= InKey(Arg1)
		EndIf
		If (Local2 != 0 .AND. (Local3:= SetKey(Local2)) != Nil)
			eval(Local3, procname(2), procline(2), "")
			Local1:= .T.
		EndIf
		If (!Local1)
			Exit
		EndIf
	EndDo
	Return Local2

**************
Function NRET
**************
Return Nil

********************************
Function VISUALCLOCK

	Local Local1, Local2
	Local2:= 0
	setcursor(0)
	Local1:= win(10, 28, 13, 51, "Rel?io - " + DToC(Date()), ;
		"W+*/B", "B+*/W")
	Do While (Local2 == 0)
		@ 12, 36 Say Time() Color "N*/W"
		Local2:= InKey(1)
	EndDo
	rstenv(Local1)
	Return Nil

Function CHKPRN
****************
Local Local1
Local1:= .T.
Do While (!Fisprinter())
	If (msgbox2("Impressora n„o preparada. Continuar ?") == 2)
		Local1:= .F.
		Exit
	EndIf
EndDo
Return Local1

********************************
Procedure NSCREEN


********************************
Function THE_END

	Local Local1, Local2
	Local1:= {padc("Analyze Tecnologia em Sistemas Ltda", 54), ;
		Replicate(" ", 54), ;
		padc("Rua Sophie Delamain, 114 - Belvedere", 54), ;
		padc("CEP: 13.600-000  Araras (SP)", 54), Replicate(" ", 54), ;
		padc("Fone: (0195) 41-6760 - Fax: (0195) 41-7606", 54), ;
		Replicate(" ", 54), padc("Todos os direitos reservados", 54), ;
		Replicate(" ", 54), Replicate(" ", 54), Replicate(" ", 54), ;
		Replicate(" ", 54), Replicate(" ", 54), Replicate(" ", 54)}
	Local2:= t:= x:= 0
	Set Color To N/W
	Clear Screen
	deskbox(0, 2, 24, 77, 2)
	deskbox(2, 7, 22, 72, 1)
	frame(4, 10, 6, 69, Nil, Nil, 2)
	frame(7, 10, 15, 69, Nil, Nil, 2)
	frame(16, 10, 20, 69, Nil, Nil, 2)
	@	5, 13 Say ;
		padc("Visual Lib - Biblioteca para design de interface", 54) ;
		Color "B/W"
	linbutton1(.F., 1, 18)
	Do While (.T.)
		If (Local2 == 14)

		Else
			++Local2
		EndIf
		Local2:= Nil
		Scroll(8, 12, 14, 68, 1)
		@ 14, 13 Say Local1[Local2] Color IIF(Local2 == 1 .OR. Local2 ;
			== 8, "R/W", "N/W")
		InKey(0.5)
		t:= LastKey()
		If (t == 13 .OR. t == 27 .OR. Upper(Chr(t)) == "O")
			Exit
		EndIf
	EndDo
	Keyboard Chr(13)
	linbutton1(.T., 1, 18)
	setblink(.T.)
	Set Color To
	setmode(25, 80)
	Clear Screen
	Close Databases
	Quit
	Return Nil

********************************
Procedure NBUTTON


Function NewButton()
********************
Return {}

Function SHOWBUTTON(Arg1, Arg2)
*******************************
	aeval(Arg1, { |_1| drawbutton(_1, Arg2) })
	Return Nil

********************************
Procedure NMISC2

Function DRAWBUTTON(Arg1, Arg2, Arg3, Arg4, Arg5)
*************************************************
Local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
		Local8, Local9, Local10, Local11, Local12, Local13, Local14, ;
		Local15, Local16, Local17, Local18, Local19, Local20, Local21
Arg3:= IIF(ISNIL(Arg3), 1, Arg3)
Arg4:= IIF(ISNIL(Arg4), .T., Arg4)
Arg5:= IIF(ISNIL(Arg5), .T., Arg5)
Local10:= textbutton(Arg1[1])
If (Arg2 == 1)
	Local1:= "N/W"
	Local2:= IIF(Arg5, "W*/N", "N*/N")
	Local3:= "W+*/N"
	Local4:= "W*/N"
	Local6:= "W+*/N"
	Local7:= "N+*/N"
	Local9:= IIF(Arg1[4], "GR+*/N", "W*/N")
ElseIf (Arg2 == 2)
	Local1:= "N*/W"
	Local2:= IIF(Arg5, "W+/W", "N+/W")
	Local3:= "N/W"
	Local4:= "N+/W"
	Local6:= "N/W"
	Local7:= "W/W"
	Local9:= IIF(Arg1[4], "W+/W", "N+/W")
EndIf
If (Arg3 == 1)
	Local10:= padc(Local10, Arg1[9] - 3)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= IIF(Arg1[4], Local3, Local4)
	Local8:= Local7
ElseIf (Arg3 == 2)
	Local10:= padc(Local10, Arg1[9] - 3)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= IIF(Arg1[4], Local3, Local4)
	Local8:= Local6
ElseIf (Arg3 == 3)
	Local10:= " " + Left(padc(Local10, Arg1[9] - 3), Arg1[9] - 4)
	Local11:= At(Upper(Arg1[8]), Upper(Local10)) - 1
	Local5:= IIF(Arg1[4], Local3, Local4)
	Local8:= Local6
EndIf
Local20:= At(alltrim(Local10), Local10) - 1
Local21:= Local20 + Len(Arg1[1]) + 2
If (Arg4)
	Local12:= "?
	Local13:= IIF(Arg5, "?, "?)
	Local14:= "?
	Local15:= "?
	Local16:= "?
	Local17:= "?
	Local18:= "?
	Local19:= "?
Else
	Local12:= "?
	Local13:= IIF(Arg5, "?, "?)
	Local14:= "?
	Local15:= "?
	Local16:= "?
	Local17:= "?
	Local18:= "?
	Local19:= "?
EndIf
@ Arg1[6] - 1, Arg1[7] Say Local12 + Replicate(Local13, Arg1[9] - 2) + Local14 Color Local1
@ Arg1[6], Arg1[7] Say Local19 Color Local1
@ Arg1[6], Arg1[7] + 1 Say "? Color Local2
@ Arg1[6], Arg1[7] + 2 Say Local10 Color Local5
@ Arg1[6], Arg1[7] + 2 + Local11 Say Arg1[8] Color Local9
@ Arg1[6], Arg1[7] + Arg1[9] - 1 Say Local15 Color Local1
@ Arg1[6] + 1, Arg1[7] Say Local18 + Replicate(Local17, Arg1[9] - 2) + Local16 Color Local1
@ Arg1[6], Arg1[7] + Local20 Say "? Color Local8
@ Arg1[6], Arg1[7] + Local21 Say "? Color Local8
Return Nil

********************************
Function SAVENV(Arg1, Arg2, Arg3, Arg4)

	Local Local1
	Local1:= {}
	AAdd(Local1, Arg1)
	AAdd(Local1, Arg2)
	AAdd(Local1, Arg3)
	AAdd(Local1, Arg4)
	AAdd(Local1, SaveScreen(Arg1, Arg2, Arg3, Arg4))
	AAdd(Local1, SetColor())
	AAdd(Local1, setcursor())
	Return Local1

********************************
Function RSTENV(Arg1)

	RestScreen(Arg1[1], Arg1[2], Arg1[3], Arg1[4], Arg1[5])
	Set Color To (Arg1[6])
	setcursor(Arg1[7])
	Return Nil

********************************
Function DWNMSG(Arg1)

	@ 23,  1 Say padc(Arg1, 78) Color "R*/W"
	Return .T.

********************************
Function QEXIT(Arg1, Arg2, Arg3, Arg4)

	Local Local1
	Local1:= savenv(33, 0, 33, 79)
	Arg4:= IIF(ISNIL(Arg4), .T., Arg4)
	If (!Arg4)
		Close Databases
		setblink(.T.)
		setmode(25, 80)
		Set Color To
		Clear Screen
		Quit
	ElseIf (msgbox2("Confirma o encerramento ?", "Sa?a", Nil, Nil, ;
			Nil, Nil, 2) == 1)
		Close Databases
		setblink(.T.)
		setmode(25, 80)
		Set Color To
		Clear Screen
		Quit
	EndIf
	rstenv(Local1)
	Return Nil

********************************
Function GINS

	readinsert(.T.)
	setcursor(2)
	SetKey(K_INS, { || (IIF(readinsert(), setcursor(1), ;
		setcursor(2)), readinsert(!readinsert())) })
	Return Nil

Function DRAWFN( nTipo, cString, nRow, nCol, cColor )
*****************************************************
LOCAL aFuncao := { 1, 9, 17, 25, 33, 41, 49, 57, 65, 73 }
cColor := IIF(ISNIL( cColor ), Cor(2), cColor )
nRow	 := IIF(ISNIL( nRow	 ), 24,	  nRow )
nCol	 := IIF(ISNIL( nCol	 ), aFuncao[nTipo]-1, nCol )
@ nRow, nCol+1 Say Left( cString, 7 ) Color AttrToa( cColor )
@ nRow, nCol	Say Chr(223 + nTipo )  Color AttrToa( cColor )
Return Nil

*************************************
Function PROCBUTTON( Arg1, Arg2, Arg3)
**************************************
Local Local1:= 0, Local2:= setcursor(0), Local3:= 0
Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
Arg3:= IIF(ISNIL(Arg3), 1, Arg3)
showbutton(Arg1, Arg2)
Do While (!Arg1[Arg3][4])
	Arg3:= IIF(++Arg3 > Len(Arg1), 1, Arg3)
EndDo
Do While (.T.)
	drawbutton(Arg1[Arg3], Arg2, 2, .F.)
	If (Arg1[Arg3][2] != Nil .OR. Arg1[Arg3][2] != "")
		dwnmsg(Arg1[Arg3][2])
	EndIf
	If (Local1 == 13 .OR. Local1 = 32)
		InKey(0.1)
		drawbutton(Arg1[Arg3], Arg2, 1, .T.)
		Exit
	Else
		Local1:= ninkey(0)
	EndIf
	If (Local1 == 27 )
		Return( 0 )
	ElseIf ((Local3 := Ascan(Arg1, { |_1| Upper(Chr(Local1)) == Upper(_1[8]) })) != 0 .AND. Arg1[Local3][4])
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3 := Local3
		Keyboard Chr(13)
	ElseIf (Local1 == 27 .AND. ( Local3 := ascan(Arg1, { |_1| _1[5] == .T. })) != 0 .AND. Arg1[Local3][4])
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3 := Local3
		Keyboard Chr(13)
	EndIf
	If (Local1 == 5 .OR. Local1 == 19 .OR. Local1 == 271)
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3:= IIF(--Arg3 == 0, Len(Arg1), Arg3)
		Do While (!Arg1[Arg3][4])
			Arg3:= IIF(--Arg3 == 0, Len(Arg1), Arg3)
		EndDo
	ElseIf (Local1 == 24 .OR. Local1 == 4 .OR. Local1 == 9)
		drawbutton(Arg1[Arg3], Arg2, 1)
		Arg3:= IIF(++Arg3 > Len(Arg1), 1, Arg3)
		Do While (!Arg1[Arg3][4])
			Arg3:= IIF(++Arg3 > Len(Arg1), 1, Arg3)
		EndDo
	ElseIf (Local1 == 13 .OR. Local1 = 32 )
		drawbutton(Arg1[Arg3], Arg2, 3, .F., .F.)
		InKey(0.1)
		drawbutton(Arg1[Arg3], Arg2, 2, .F.)
		eval(Arg1[Arg3][3])
	EndIf
EndDo
setcursor(Local2)
Return Arg3

********************************
Function TEXTBUTTON(Arg1)

	Local Local1, Local2, Local3, Local4
	Local1:= ""
	Local2:= At("&", Arg1)
	Local3:= SubStr(Arg1, 1, Local2 - 1)
	Local4:= SubStr(Arg1, Local2 + 1)
	Return IIF(Local2 != 0, Local3 + Local4, Arg1)

********************************
Function SETBUTTON(Arg1, Arg2, Arg3)

	Local Local1
	Local1:= Arg1[Arg2][4]
	If (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	EndIf
	Return Local1

********************************
Function DESKTOP(Arg1, Arg2)

	Arg1:= IIF(ISNIL(Arg1), ;
		"Analyze Tecnologia em Sistemas - Visual Lib", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "W+/BG", Arg2)
	setblink(.F.)
	Set Color To W+/W
	//visual()
	Clear Screen
	@	0,  0 Say padc(Arg1, 80) Color Arg2
	@ 24,  0 Say padc(" ", 80) Color Arg2
	@	1,  0 Say padc(" ", 80) Color "N*/W"
	@ 23,  0 Say padc(" ", 80) Color "N*/W"
	Return Nil

*************************************************
Function NBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*************************************************
Local Local1
Local1 := savenv(Arg1, Arg2, Arg3 + 1, Arg4 + 2)
Arg5	 := IIF(ISNIL(Arg5), "N*/W", Arg5)
Arg6	 := IIF(ISNIL(Arg6), .T., Arg6)
@ Arg1, Arg2, Arg3, Arg4 Box " ÐËÇÊÌÈ?" Color Arg5
If (Arg6)
	Sombra( Arg1, Arg2, Arg3, Arg4)
EndIf
Return Local1

******************************************************
Function WIN(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
******************************************************
Local Local1
Arg5	 := IIF(ISNIL(Arg5), "", Arg5)
Arg6	 := IIF(ISNIL(Arg6), "W+/B", Arg6)
Arg7	 := IIF(ISNIL(Arg7), "B*/W", Arg7)
Local1 := nBox( Arg1, Arg2, Arg3, Arg4, Arg7)
@ Arg1, Arg2 Say Padc(Arg5, Arg4 - Arg2 + 1) Color Arg6
Return Local1

********************************
Function SOMBRA(Arg1, Arg2, Arg3, Arg4)

	Local Local1, Local2, Local3, Local4
	Local3:= SaveScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2)
	Local4:= SaveScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2)
	For Local1:= 2 To Len(Local3) Step 2
		Local2:= shadow(Asc(SubStr(Local3, Local1, 1)))
		Local3:= stuff(Local3, Local1, 1, Local2)
	Next
	For Local1:= 2 To Len(Local4) Step 2
		Local2:= shadow(Asc(SubStr(Local4, Local1, 1)))
		Local4:= stuff(Local4, Local1, 1, Local2)
	Next
	RestScreen(Arg1 + 1, Arg4 + 1, Arg3 + 1, Arg4 + 2, Local3)
	RestScreen(Arg3 + 1, Arg2 + 2, Arg3 + 1, Arg4 + 2, Local4)
	Return Nil

********************************
Function SHADOW(Arg1)

	Local Local1, Local2, Local3
	Local1:= Arg1 % 16
	Local2:= (Arg1 - Local1) / 16
	Local3:= {0, 0, 8, 8, 0, 8, 0, 8, 0, 1, 2, 3, 4, 5, 6, 7}
	Local1:= Local3[Local1 + 1]
	Local2:= Local3[Local2 + 1]
	Return Chr(16 * Local2 + Local1)

********************************
Function MSGBOX3D1(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

	Local Local1, Local2, Local3, Local4
	Arg4:= IIF(ISNIL(Arg4), "&OK", Arg4)
	Arg1:= IIF(ISNIL(Arg1), "", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
	Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg5:= IIF(ISNIL(Arg5), "W+/N", Arg5)
	Arg6:= IIF(ISNIL(Arg6), "N/W", Arg6)
	Arg7:= IIF(ISNIL(Arg7), "N/W", Arg7)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 31, 18, Arg4, Nil, .T.)
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg5, Arg6)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "ÇÇÇÇÇÇÇÇ? Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "¶¶¶¶¶¶¶¶? Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("?, 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("?, 56) Color "N+/W"
	If (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color Arg7
		Next
	Else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg7
	EndIf
	setcursor(0)
	procbutton(Local3, 1, 1)
	rstenv(Local2)
	Return Nil

********************************
Function MSGBOX3D2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10)

	Local Local1, Local2, Local3, Local4
	Arg4:= IIF(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= IIF(ISNIL(Arg5), "&N„o", Arg5)
	Arg6:= IIF(ISNIL(Arg6), 1, Arg6)
	Arg7:= IIF(ISNIL(Arg7), 2, Arg7)
	Arg1:= IIF(ISNIL(Arg1), "", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
	Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg8:= IIF(ISNIL(Arg8), "W+/N", Arg8)
	Arg9:= IIF(ISNIL(Arg9), "N/W", Arg9)
	Arg10:= IIF(ISNIL(Arg10), "N/W", Arg10)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 21, 18, Arg4, Nil, IIF(Arg7 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 41, 18, Arg5, Nil, IIF(Arg7 ;
		== 2, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg8, Arg9)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "ÇÇÇÇÇÇÇÇ? Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "¶¶¶¶¶¶¶¶? Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("?, 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("?, 56) Color "N+/W"
	If (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color ;
				Arg10
		Next
	Else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg10
	EndIf
	setcursor(0)
	Local4:= procbutton(Local3, 1, IIF(Arg6 < 3, Arg6, 2))
	rstenv(Local2)
	Return Local4

Function LinButton1( lProcessaOuExibe, nCor, nRow, cString, cMensagem )
***********************************************************************
LOCAL xButton	  := NewButton()
lProcessaOuExibe := IIF(ISNIL( lProcessaOuExibe1), OK, lProcessaOuExibe )
nCor				  := IIF(ISNIL( nCor ), 1, nCor )
nRow				  := IIF(ISNIL( nRow ), 21, nRow )
cString			  := IIF(ISNIL( cString ), "&OK", cString )
AddButton( xButton, nRow, 31, (MaxCol()-61), cString,  cMensagem, OK )
If ( lProcessaOuExibe )
	nRow := ProcButton( xButton, nCor )
Else
	ShowButton( xButton, nCor )
EndIf
Return(	nRow )

********************************
Function MSGBOX3D3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11)

	Local Local1, Local2, Local3, Local4
	Arg4:= IIF(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= IIF(ISNIL(Arg5), "&N„o", Arg5)
	Arg6:= IIF(ISNIL(Arg6), "&Cancelar", Arg6)
	Arg7:= IIF(ISNIL(Arg7), 1, Arg7)
	Arg8:= IIF(ISNIL(Arg8), 3, Arg8)
	Arg1:= IIF(ISNIL(Arg1), "", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
	Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 8) / 2, Arg3)
	Arg9:= IIF(ISNIL(Arg9), "W+/N", Arg9)
	Arg10:= IIF(ISNIL(Arg10), "N/W", Arg10)
	Arg11:= IIF(ISNIL(Arg11), "N/W", Arg11)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 5 + Local1, 13, 18, Arg4, Nil, IIF(Arg8 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 31, 18, Arg5, Nil, IIF(Arg8 ;
		== 2, .T., .F.))
	addbutton(Local3, Arg3 + 5 + Local1, 49, 18, Arg6, Nil, IIF(Arg8 ;
		== 3, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 8 + Local1, 69, Arg2, Arg9, Arg10)
	@ Arg3 + 2, 11, Arg3 + 7 + Local1, 11 Box "ÇÇÇÇÇÇÇÇ? Color "W+/W"
	@ Arg3 + 2, 68, Arg3 + 7 + Local1, 68 Box "¶¶¶¶¶¶¶¶? Color "N+/W"
	@ Arg3 + 2, 12 Say Replicate("?, 56) Color "W+/W"
	@ Arg3 + 7 + Local1, 12 Say Replicate("?, 56) Color "N+/W"
	If (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 2 + Local4, 13 Say padc(Arg1[Local4], 54) Color ;
				Arg11
		Next
	Else
		@ Arg3 + 3, 13 Say padc(Arg1, 54) Color Arg11
	EndIf
	setcursor(0)
	Local4:= procbutton(Local3, 1, IIF(Arg7 < 4, Arg7, 3))
	rstenv(Local2)
	Return Local4

********************************
Function CLRTED(Arg1, Arg2)

	Local Local1
	Local1:= SetColor()
	Set Color To N/W
	Arg1:= IIF(ISNIL(Arg1), 2, Arg1)
	Arg2:= IIF(ISNIL(Arg2), 22, Arg2)
	Scroll(Arg1, 0, Arg2, 79)
	Set Color To (Local1)
	Return Nil

Function MSGBOX1(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)
**********************************************************
Local Local1, Local2, Local3, Local4
LOCAL nTamanhoButton := MaxCol()-61
Arg4	 := IIF(ISNIL(Arg4), "&OK", Arg4)
Arg1	 := IIF(ISNIL(Arg1), "", Arg1)
Arg2	 := IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
Local1 := IIF(ISARRAY(Arg1), Len(Arg1), 1)
Arg3	 := IIF(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
Arg5	 := IIF(ISNIL(Arg5), "W+*/R", Arg5)
Arg6	 := IIF(ISNIL(Arg6), "R+*/W", Arg6)
Arg7	 := IIF(ISNIL(Arg7), "N*/W", Arg7)
Local3 := NewButton()
addbutton( Local3, Arg3+ 3 + Local1, 31, nTamanhoButton, Arg4, Nil, .T.)
Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, (MaxCol()-10), Arg2, Arg5, Arg6)
If (ISARRAY(Arg1))
	For Local4 := 1 To Local1
		@ Arg3 + 1 + Local4, 12 Say padc( Arg1[ Local4 ], (MaxCol()-23) ) Color Arg7
	Next
Else
	@ Arg3 + 2, 12 Say padc(Arg1, (MaxCol()-23) ) Color Arg7
EndIf
setcursor(0)
nButton := ProcButton( Local3, 2, 1)
RsTenv( Local2 )
Return( nButton )

********************************
Function LINBUTTON3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11)

	Local Local1
	Local1:= newbutton()
	Arg1:= IIF(ISNIL(Arg1), .T., Arg1)
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Arg3:= IIF(ISNIL(Arg3), 21, Arg3)
	Arg4:= IIF(ISNIL(Arg4), 1, Arg4)
	Arg5:= IIF(ISNIL(Arg5), 3, Arg5)
	Arg6:= IIF(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= IIF(ISNIL(Arg8), "&Alterar", Arg8)
	Arg10:= IIF(ISNIL(Arg10), "&Cancelar", Arg10)
	addbutton(Local1, Arg3, 11, 18, Arg6, Arg7, IIF(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 31, 18, Arg8, Arg9, IIF(Arg5 == 2, .T., ;
		.F.))
	addbutton(Local1, Arg3, 51, 18, Arg10, Arg11, IIF(Arg5 == 3, .T., ;
		.F.))
	If (Arg1)
		Arg3:= procbutton(Local1, Arg2, IIF(Arg4 < 4, Arg4, 3))
	Else
		showbutton(Local1, Arg2)
	EndIf
	Return Arg3

*****************************************************************************
Function MSGBOX2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10)
*****************************************************************************
	Local Local1, Local2, Local3, Local4
	Arg4	 := IIF(ISNIL(Arg4), "&Sim", Arg4)
	Arg5	 := IIF(ISNIL(Arg5), "&N„o", Arg5)
	Arg6	 := IIF(ISNIL(Arg6), 1, Arg6)
	Arg7	 := IIF(ISNIL(Arg7), 2, Arg7)
	Arg1	 := IIF(ISNIL(Arg1), "", Arg1)
	Arg2	 := IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
	Local1 := IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3	 := IIF(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg8	 := IIF(ISNIL(Arg8), "W+*/R", Arg8)
	Arg9	 := IIF(ISNIL(Arg9), "R+*/W", Arg9)
	Arg10  := IIF(ISNIL(Arg10), "N*/W", Arg10)
	Local3 := newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 21, 18, Arg4, Nil, IIF(Arg7 == 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 41, 18, Arg5, Nil, IIF(Arg7 == 2, .T., .F.))
	Local2 := Win( Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg8, Arg9)
	If (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color Arg10
		Next
	Else
		@ Arg3 + 2, 13 Say padc(Arg1, MaxCol()-25) Color Arg10
	EndIf
	setcursor(0)
	nButton := procbutton(Local3, 2, IIF(Arg6 < 3, Arg6, 2))
	rstenv(Local2)
	Return( nButton )

Function LINBUTTON2(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
*************************************************************************
	Local Local1
	Local1:= newbutton()
	Arg1:= IIF(ISNIL(Arg1), .T., Arg1)
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Arg3:= IIF(ISNIL(Arg3), 21, Arg3)
	Arg4:= IIF(ISNIL(Arg4), 1, Arg4)
	Arg5:= IIF(ISNIL(Arg5), 2, Arg5)
	Arg6:= IIF(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= IIF(ISNIL(Arg8), "&Cancelar", Arg8)
	addbutton(Local1, Arg3, 21, 18, Arg6, Arg7, IIF(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 41, 18, Arg8, Arg9, IIF(Arg5 == 2, .T., ;
		.F.))
	If (Arg1)
		Arg3:= procbutton(Local1, Arg2, IIF(Arg4 < 3, Arg4, 2))
	Else
		showbutton(Local1, Arg2)
	EndIf
	Return Arg3

************************************************************************************
Function MSGBOX3(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11)
************************************************************************************
	Local Local1, Local2, Local3, Local4
	Arg4:= IIF(ISNIL(Arg4), "&Sim", Arg4)
	Arg5:= IIF(ISNIL(Arg5), "&N„o", Arg5)
	Arg6:= IIF(ISNIL(Arg6), "&Cancelar", Arg6)
	Arg7:= IIF(ISNIL(Arg7), 1, Arg7)
	Arg8:= IIF(ISNIL(Arg8), 3, Arg8)
	Arg1:= IIF(ISNIL(Arg1), "", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "Aten‡„o!", Arg2)
	Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 7) / 2, Arg3)
	Arg9:= IIF(ISNIL(Arg9), "W+*/R", Arg9)
	Arg10:= IIF(ISNIL(Arg10), "R+*/W", Arg10)
	Arg11:= IIF(ISNIL(Arg11), "N*/W", Arg11)
	Local3:= newbutton()
	addbutton(Local3, Arg3 + 3 + Local1, 13, 18, Arg4, Nil, IIF(Arg8 ;
		== 1, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 31, 18, Arg5, Nil, IIF(Arg8 ;
		== 2, .T., .F.))
	addbutton(Local3, Arg3 + 3 + Local1, 49, 18, Arg6, Nil, IIF(Arg8 ;
		== 3, .T., .F.))
	Local2:= win(Arg3, 10, Arg3 + 5 + Local1, MaxCol()-10, Arg2, Arg9, Arg10)
	If (ISARRAY(Arg1))
		For Local4:= 1 To Local1
			@ Arg3 + 1 + Local4, 13 Say padc(Arg1[Local4], MaxCol()-25) Color ;
				Arg11
		Next
	Else
		@ Arg3 + 2, 13 Say padc(Arg1, 54) Color Arg11
	EndIf
	setcursor(0)
	nButton := procbutton(Local3, 2, IIF(Arg7 < 3, Arg7, 2))
	rstenv(Local2)
	Return( nButton )

***********************************************
Function DESKBOX( Arg1, Arg2, Arg3, Arg4, Arg5)
***********************************************
LOCAL Local1 := "N+/W", Local2 := "W+/W"
Arg5		:= IIF(ISNIL(Arg5), 1, Arg5)
If (Arg5 == 2)
	Local1 := "W+/W"
	Local2 := "N+/W"
EndIf
@ Arg1, Arg2, Arg3, Arg2 Box "¶¶¶¶¶¶¶¶? Color Local1
@ Arg1, Arg4, Arg3, Arg4 Box "ÇÇÇÇÇÇÇÇ? Color Local2
@ Arg1, Arg2 Say Replicate("?, Arg4 - Arg2 + 1) Color Local1
@ Arg3, Arg2 Say Replicate("?, Arg4 - Arg2 + 1) Color Local2
Return Nil

*****************************************************
Function MSGBOX3D(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)
*****************************************************
LOCAL Local1, Local2, Local3
LOCAL nTam	 := MaxCol()
Arg1:= IIF(ISNIL(Arg1), "", Arg1)
Arg2:= IIF(ISNIL(Arg2), "Aguarde", Arg2)
Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 6) / 2, Arg3)
Arg4:= IIF(ISNIL(Arg4), "W+/N", Arg4)
Arg5:= IIF(ISNIL(Arg5), "N/W", Arg5)
Arg6:= IIF(ISNIL(Arg6), "N/W", Arg6)
Local2 := win(Arg3, 16, Arg3 + 6 + Local1, (nTam-16), Arg2, Arg4, Arg5)
@ Arg3 + 2, 17, Arg3 + 5 + Local1, 17 Box "ÇÇÇÇÇÇÇÇ? Color "W+/W"
@ Arg3 + 2, (nTam-17), Arg3 + 5 + Local1, (nTam-17) Box "¶¶¶¶¶¶¶¶? Color "N+/W"
@ Arg3 + 2, 18 Say Replicate("?, (nTam-35)) Color "W+/W"
@ Arg3 + 5 + Local1, 18 Say Replicate("?, (nTam-35)) Color "N+/W"
If (ISARRAY(Arg1))
	For Local3:= 1 To Local1
		@ Arg3 + 3 + Local3, 19 Say padc(Arg1[Local3], (nTam-37)) Color Arg6
	Next
Else
	@ Arg3 + 4, 19 Say padc(Arg1, (nTam-37)) Color Arg6
EndIf
setcursor(0)
Return Local2

********************************
Function MSGBOX(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6)

	Local Local1, Local2, Local3
	Arg1:= IIF(ISNIL(Arg1), "", Arg1)
	Arg2:= IIF(ISNIL(Arg2), "Aguarde", Arg2)
	Local1:= IIF(ISARRAY(Arg1), Len(Arg1), 1)
	Arg3:= IIF(ISNIL(Arg3), 12 - (Local1 + 5) / 2, Arg3)
	Arg4:= IIF(ISNIL(Arg4), "W+*/B", Arg4)
	Arg5:= IIF(ISNIL(Arg5), "B+*/W", Arg5)
	Arg6:= IIF(ISNIL(Arg6), "N*/W", Arg6)
	Local2:= win(Arg3, 18, Arg3 + 5 + Local1, 61, Arg2, Arg4, Arg5)
	If (ISARRAY(Arg1))
		For Local3:= 1 To Local1
			@ Arg3 + 2 + Local3, 20 Say padc(Arg1[Local3], 40) Color Arg6
		Next
	Else
		@ Arg3 + 3, 20 Say padc(Arg1, 40) Color Arg6
	EndIf
	setcursor(0)
	Return Local2

********************************************************************
Function FRAME(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9)
********************************************************************
Local Local1 := SetColor(), Local2 := dn := "", Local3:= Arg4 - Arg2 - 1, Local4:= y:= z:= 0
Arg6:= IIF(ISNIL(Arg6), 1, Arg6)
Arg7:= IIF(ISNIL(Arg7), 1, Arg7)
Arg8:= IIF(ISNIL(Arg8), "N/W", Arg8)
Arg9:= IIF(ISNIL(Arg9), "N/W", Arg9)
If (Arg7 == 1)
	Local2 := "N+/W"
	dn:= "W+/W"
ElseIf (Arg7 == 2)
	Local2 := "W+/W"
	dn:= "N+/W"
ElseIf (Arg7 == 3)
	Local2 := dn:= Arg8
EndIf
@ Arg1 + 1, Arg2, Arg3 - 1, Arg2 Box Replicate("?, 9) Color Local2
@ Arg1, Arg2 Say "? + Replicate("?, Local3) Color Local2
@ Arg3, Arg2 Say "? Color Local2
@ Arg1 + 1, Arg4, Arg3 - 1, Arg4 Box Replicate("?, 9) Color dn
@ Arg3, Arg2 + 1 Say Replicate("?, Local3) + "? Color dn
@ Arg1, Arg4 Say "? Color dn
If (Arg5 != Nil)
	z:= Len(Arg5)
	If (Arg6 == 1)
		@ Arg1, Arg2 + 2 Say " " + Arg5 + " " Color Arg9
	ElseIf (Arg6 == 2)
		@ Arg1, Arg4 - Local3 / 2 - z / 2 - 1 Say " " + Arg5 + " " Color Arg9
	ElseIf (Arg6 == 3)
		@ Arg1, Arg4 - z - 3 Say " " + Arg5 + " " Color Arg9
	EndIf
EndIf
Set Color To (Local1)
Return Nil

********************************
Function LINBUTTON4(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, ;
	Arg9, Arg10, Arg11, Arg12, Arg13)

	Local Local1
	Local1:= newbutton()
	Arg1:= IIF(ISNIL(Arg1), .T., Arg1)
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Arg3:= IIF(ISNIL(Arg3), 21, Arg3)
	Arg4:= IIF(ISNIL(Arg4), 1, Arg4)
	Arg5:= IIF(ISNIL(Arg5), 4, Arg5)
	Arg6:= IIF(ISNIL(Arg6), "&OK", Arg6)
	Arg8:= IIF(ISNIL(Arg8), "&Alterar", Arg8)
	Arg10:= IIF(ISNIL(Arg10), "&Excluir", Arg10)
	Arg12:= IIF(ISNIL(Arg12), "&Cancelar", Arg12)
	addbutton(Local1, Arg3, 1, 18, Arg6, Arg7, IIF(Arg5 == 1, .T., ;
		.F.))
	addbutton(Local1, Arg3, 21, 18, Arg8, Arg9, IIF(Arg5 == 2, .T., ;
		.F.))
	addbutton(Local1, Arg3, 41, 18, Arg10, Arg11, IIF(Arg5 == 3, .T., ;
		.F.))
	addbutton(Local1, Arg3, 61, 18, Arg12, Arg13, IIF(Arg5 == 4, .T., ;
		.F.))
	If (Arg1)
		Arg3:= procbutton(Local1, Arg2, IIF(Arg4 < 5, Arg4, 4))
	Else
		showbutton(Local1, Arg2)
	EndIf
	Return Arg3

******************************************************************************************
STATIC Function DBEDIT( Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)
******************************************************************************************
Local Local1, Local2, Local3, Local4, Local5, Local6, Local7
IF Arg4 = 78
   Arg4 := MaxCol()-1
EndIF
If (EOF())
   Goto Bottom
EndIf
Local1:= dbedsetup(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)
Local1:skipblock({ |_1| skipped(_1) })
Local1:autolite(.F.)
Local2:= setcursor(0)
Local7:= {Static13, Static14}
Static13:= .F.
Static14:= .T.
Local5:= .T.
Local3:= .T.
Do While (Local3)
   Do While (!Local1:stabilize())
      If (nextkey() != 0)
         Exit
      EndIf
   EndDo
   If ((Local4 := InKey()) == 0)
      If (Local5)
         Local3:= calluser(Local1, Arg6, 0)
         Do While (!Local1:stabilize())
         EndDo
      EndIf
      If (Local3 .AND. Static14)
         Local1:hilite()
         Local4:= InKey(0)
         Local1:dehilite()
         If ((Local6:= SetKey(Local4)) != Nil)
            eval(Local6, procname(1), procline(1), "")
            Loop
         EndIf
      Else
         Static14:= .T.
      EndIf
   EndIf
   Local5:= .T.
   Do Case
   Case Local4 == 0
   Case Local4 == 24
      If (Static13)
         Local1:hitbottom(.T.)
      Else
         Local1:down()
      EndIf
   Case Local4 == 5
      If (Static13)
         Local1:hittop(.T.)
      Else
         Local1:up()
      EndIf
   Case Local4 == 3
      If (Static13)
         Local1:hitbottom(.T.)
      Else
         Local1:pagedown()
      EndIf
   Case Local4 == 18
      If (Static13)
         Local1:hittop(.T.)
      Else
         Local1:pageup()
      EndIf
   Case Local4 == 31
      If (Static13)
         Local1:hittop(.T.)
      Else
         Local1:gotop()
      EndIf
   Case Local4 == 30
      If (Static13)
         Local1:hitbottom(.T.)
      Else
         Local1:gobottom()
      EndIf
   Case Local4 == 4
      Local1:right()
   Case Local4 == 19
      Local1:left()
   Case Local4 == 1
      Local1:home()
   Case Local4 == 6
      Local1:end()
   Case Local4 == 26
      Local1:panleft()
   Case Local4 == 2
      Local1:panright()
   Case Local4 == 29
      Local1:panhome()
   Case Local4 == 23
      Local1:panend()
   Otherwise
      Local3:= calluser(Local1, Arg6, Local4)
      Local5:= .F.
   EndCase
EndDo
setcursor(Local2)
Static13:= Local7[1]
Static14:= Local7[2]
Return .T.

****************************************************************************************************
STATIC Function DBEDSETUP(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8, Arg9, Arg10, Arg11, Arg12)
****************************************************************************************************
LOCAL Local1, Local2, Local3, Local4, Local5, Local6, Local7, Local8
LOCAL cFrame2     := SubStr( oAmbiente:Frame, 2, 1 )
LOCAL cFrame3     := SubStr( oAmbiente:Frame, 3, 1 )
LOCAL cFrame4     := SubStr( oAmbiente:Frame, 4, 1 )
LOCAL cFrame6     := SubStr( oAmbiente:Frame, 6, 1 )

If (ValType(Arg1) != "N" .OR. Arg1 < 0)
   Arg1:= 0
EndIf
If (ValType(Arg2) != "N" .OR. Arg2 < 0)
   Arg2:= 0
EndIf
If (ValType(Arg3) != "N" .OR. Arg3 > MaxRow() .OR. Arg3 < Arg1)
   Arg3:= MaxRow()
EndIf
If (ValType(Arg4) != "N" .OR. Arg4 > MaxCol() .OR. Arg4 < Arg2)
   Arg4:= MaxCol()
EndIf
If ((Arg4 - Arg2) * (Arg3 - Arg1) > MaxRow() * MaxCol())
   Arg1:= Arg2:= 0
   Arg3:= MaxRow()
   Arg4:= MaxCol()
EndIf
Local1:= tbrowsedb(Arg1, Arg2, Arg3, Arg4)
If (ISARRAY(Arg5))
   Local3:= Len(Arg5)
   Local2:= 1
   Do While (Local2 <= Local3)
      If (ValType(Arg5[Local2]) != "C" .OR. Empty(Arg5[Local2]))
         Exit
      EndIf
      Local2++
   EndDo
   Local3:= Local2 - 1
Else
   Local3:= FCount()
EndIf
If (Local3 == 0)
   Return .F.
EndIF
Local1:HeadSep   := cFrame2 + cFrame3 + cFrame2
Local1:ColSep    := Chr(032) + cFrame4 + Chr(032)
Local1:FootSep   := cFrame2  + cFrame2 + cFrame2
Local4:= array(Local3, 6)
If (ISARRAY(Arg5))
   For Local2:= 1 To Local3
      If ("->" $ Arg5[Local2])
         Local6:= At("->", Arg5[Local2])
         Local4[Local2][3]:= SubStr(Arg5[Local2], 1, Local6 - 1)
         Local4[Local2][4]:= SubStr(Arg5[Local2], Local6 + 2)
         Local4[Local2][1]:= Local4[Local2][3] + "->;" + ;
            Local4[Local2][4]
      Else
         Local4[Local2][3]:= Nil
         Local4[Local2][4]:= Nil
         Local4[Local2][1]:= Arg5[Local2]
      EndIf
      Local4[Local2][2]:= Arg5[Local2]
   Next
ElseIf (FCount() > 0)
   For Local2:= 1 To Local3
      Local4[Local2][3]:= Nil
      Local4[Local2][4]:= Nil
      Local4[Local2][1]:= FieldName(Local2)
      Local4[Local2][2]:= FieldName(Local2)
   Next
Else
   Return .F.
EndIf
For Local2:= 1 To Local3
   Local5:= ""
   If (ISARRAY(Arg7))
      If (Len(Arg7) >= Local2 .AND. ISCHARACTER(Arg7[Local2]) ;
            .AND. !Empty(Arg7[Local2]))
         Local5:= Arg7[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg7) .AND. !Empty(Arg7))
      Local5:= Arg7
   EndIf
   Local7:= Nil
   If (ISMEMO(&(Local4[Local2][2])))
      Local7:= "{|| '  <Memo>  '}"
   ElseIf (Empty(Local5))
      If ("->" $ Local4[Local2][2])
         If (Upper(Local4[Local2][3]) == "M")
            Local7:= memvarbloc(Local4[Local2][2])
         ElseIf (Upper(Local4[Local2][3]) == "FIELD")
            Local7:= fieldwbloc(Local4[Local2][4], Select())
         Else
            Local7:= fieldwbloc(Local4[Local2][4], ;
               Select(Local4[Local2][3]))
         EndIf
      ElseIf (!Empty(fieldpos(Local4[Local2][2])))
         Local7:= fieldwbloc(Local4[Local2][2], Select())
      EndIf
   EndIf
   If (ISNIL(Local7))
      If (Empty(Local5))
         Local7:= "{||" + Local4[Local2][2] + "}"
      Else
         Local7:= "{|| Transform(" + Local4[Local2][2] + ",'" + ;
            Local5 + "')}"
      EndIf
   EndIf
   If (ISCHARACTER(Local7))
      Local4[Local2][2]:= &Local7
   ElseIf (ISBLOCK(Local7))
      Local4[Local2][2]:= Local7
   EndIf
   If (ISARRAY(Arg8))
      If (Len(Arg8) >= Local2 .AND. ISCHARACTER(Arg8[Local2]))
         Local4[Local2][1]:= Arg8[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg8))
      Local4[Local2][1]:= Arg8
   EndIf
   Local4[Local2][3]:= Nil
   If (ISARRAY(Arg9))
      If (Len(Arg9) >= Local2 .AND. ISCHARACTER(Arg9[Local2]))
         Local4[Local2][3]:= Arg9[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg9))
      Local4[Local2][3]:= Arg9
   EndIf
   Local4[Local2][4]:= Nil
   If (ISARRAY(Arg10))
      If (Len(Arg10) >= Local2 .AND. ISCHARACTER(Arg10[Local2]))
         Local4[Local2][4]:= Arg10[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg10))
      Local4[Local2][4]:= Arg10
   EndIf
   Local4[Local2][5]:= Nil
   If (ISARRAY(Arg11))
      If (Len(Arg11) >= Local2 .AND. ISCHARACTER(Arg11[Local2]))
         Local4[Local2][5]:= Arg11[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg11))
      Local4[Local2][5]:= Arg11
   EndIf
   Local4[Local2][6]:= Nil
   If (ISARRAY(Arg12))
      If (Len(Arg12) >= Local2 .AND. ISCHARACTER(Arg12[Local2]))
         Local4[Local2][6]:= Arg12[Local2]
      EndIf
   ElseIf (ISCHARACTER(Arg12))
      Local4[Local2][6]:= Arg12
   EndIf
Next
For Local2:= 1 To Local3
   Local8:= tbcolumnne(Local4[Local2][1], Local4[Local2][2])
   If (Local4[Local2][3] != Nil)
      Local8:headsep(Local4[Local2][3])
   EndIf
   If (Local4[Local2][4] != Nil)
      Local8:colsep(Local4[Local2][4])
   EndIf
   If (Local4[Local2][5] != Nil)
      Local8:footsep(Local4[Local2][5])
   EndIf
   If (Local4[Local2][6] != Nil)
      Local8:footing(Local4[Local2][6])
   EndIf
   Local1:addcolumn(Local8)
Next
Return Local1

Static Function SKIPPED(Arg1)

   Local Local1
   Local1:= 0
   If (LastRec() != 0)
      If (Arg1 == 0)
         Skip 0
      ElseIf (Arg1 > 0 .AND. RecNo() != LastRec() + 1)
         Do While (Local1 < Arg1)
            Skip 
            If (EOF())
               Skip -1
               Exit
            EndIf
            Local1++
         EndDo
      ElseIf (Arg1 < 0)
         Do While (Local1 > Arg1)
            Skip -1
            If (BOF())
               Exit
            EndIf
            Local1--
         EndDo
      EndIf
   EndIf
   Return Local1


Static Function CALLUSER(Arg1, Arg2, Arg3)
******************************************
	Local Local1, Local2, Local3, Local4
	Do Case
	Case Arg3 != 0
		Local1:= 4
	Case !Static13 .AND. emptyfile()
		Local1:= 3
	Case Arg1:hitbottom()
		Local1:= 2
	Case Arg1:hittop()
		Local1:= 1
	Otherwise
		Local1:= 0
	EndCase
	Do While (!Arg1:stabilize())
	EndDo
	Local3:= RecNo()
	If (ValType(Arg2) != "C" .OR. Empty(Arg2))
		If (Arg3 == 13 .OR. Arg3 == 27)
			Local2:= 0
		Else
			Local2:= 1
		EndIf
	Else
		Local2 := &Arg2(Local1, Arg1:colpos())
	EndIf
	Local4:= Local2 != 0
	If (!Static13 .AND. EOF() .AND. !emptyfile())
		Skip -1
	EndIf
	If (Local2 == 3)
		Static13:= !(Static13 .AND. EOF())
		If (Static13)
			Goto Bottom
			Arg1:down()
		Else
			Arg1:refreshcur()
		EndIf
		Static14:= .F.
	ElseIf (Local2 == 2 .OR. Local3 != RecNo())
		If (Local4)
			Static13:= .F.
			If (Set(_SET_DELETED) .AND. Deleted() .OR. ;
					!Empty(dbfilter()) .AND. !&(dbfilter()))
				Skip
			EndIf
			If (EOF())
				Goto Bottom
			EndIf
			Local3:= RecNo()
			Arg1:refreshall()
			Do While (!Arg1:stabilize())
			EndDo
			Do While (Local3 != RecNo())
				Arg1:up()
				Do While (!Arg1:stabilize())
				EndDo
			EndDo
			Static14:= .F.
		EndIf
	Else
		Arg1:refreshcur()
	EndIf
	Return Local4

Static Function EMPTYFILE
*************************
	If (LastRec() == 0)
		Return .T.
	EndIf
	If ((EOF() .OR. RecNo() == LastRec() + 1) .AND. BOF())
		Return .T.
	EndIf
	Return .F.

Proc LogoTipo( aEnde_String )
*****************************
LOCAL aNormal	:= Array(11)
LOCAL aEncrypt := Array(11)
LOCAL Handle
LOCAL nX

Handle := Fopen("SCI.CFG")
IF ( Ferror() != 0 )
	FClose( Handle )
	SetColor("")
	Cls
	Alert( "Erro #3: Erro de Abertura do Arquivo SCI.CFG.")
	Quit
EndIF
nErro := MsLocate( Handle, "[SCI_STRING]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG alterada. [SCI_STRING]")
	Quit
EndIF
MsAdvance( Handle )
For nX := 1 To 11
	aNormal[nX] := MsReadLine( Handle )
Next
nErro 	  := MsLocate( Handle, "[SCI_CODIGO]")
IF nErro < 0
	SetColor("")
	Cls
	Alert( "Erro #4: Configuracao de SCI.CFG alterada. [SCI_CODIGO]")
	Quit
EndIF
MsAdvance( Handle )
For nX := 1 To 11
	aEncrypt[nX] := MsDCriptar( MsReadLine( Handle ))
Next
For nX := 1 To 11
	IF aNormal[nX] != aEncrypt[nX]
		SetColor("")
		Cls
		Alert( "Erro #5: Configuracao de SCI.CFG alterada. [SCI_CODIGO]")
		Quit
	EndIF
Next
FClose( Handle )
IF !oAmbiente:Visual
	SetColor("")
	Cls
	MsBox( 00, 00, 05, MaxCol()-2, 9, OK )
	For nX := 1 To 4
		WriteBox( nX, 10, aEnde_String[nX] )
	Next
	SetColor("")
	For nX := 1 To 11
		Write( 05+nX, 00, aNormal[nX] )
	Next
	SetColor("")
	For nY := 06 To 16
		SetColor( AttrToa( nY ))
		Write( nY, 25, XNOMEFIR, nY )
	Next
	MsBox( 17, 00, 22, MaxCol()-2, 9, FALSO )
	WriteBox( 18, 10, "Esta ‚ uma licen‡a de uso individual e  intransfer?el" )
	WriteBox( 19, 10, "para o usuario acima. C?ia ilegais e n„o  autorizadas" )
	WriteBox( 20, 10, "‚ crime de PIRATARIA o qual ser„o processadas a m xima" )
	WriteBox( 21, 10, "extˆns„o da LEI.")
	SetColor("R")
	Write( 23,00, "TECLE ALGO PARA INICIARÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ")
	For nY := 1 To 1000
		Inkey(.1)
		IF Lastkey() <> 0
			Exit
		EndIF
	Next
	ScrollEsq()
ELSE
	SetColor("")
	Cls
	SetColor("N/W")
	@ 01, 02 Clea To 23, MaxCol()-2
	DeskBox( 00, 01, 24, MaxCol()-2, 2 )
	DeskBox( 01, 06, 23, MaxCol()-6, 1 )
	Frame( 02, 10, 06, MaxCol()-10, Nil, Nil, 2 )
	Frame( 07, 10, 19, MaxCol()-10, Nil, Nil, 2 )
	SetColor("R/W")
	Write( 03, 12, Padc( aEnde_String[1], MaxCol()-22 ))
	Write( 04, 12, Padc( aEnde_String[2], MaxCol()-22 ))
	Write( 05, 12, Padc( aEnde_String[3], MaxCol()-22 ))

	SetColor("B/W")
	For nX := 1 To 11
		Write( 07+nX, 12, aNormal[nX] )
	Next
	cString := Left( XNOMEFIR, 30 )
	SetColor("G/W")
	Write( 08, 38, cString )
	SetColor("R/W")
	Write( 09, 38, cString )
	SetColor("N/W")
	Write( 10, 38, cString )
	SetColor("B/W")
	Write( 11, 38, cString )
	SetColor("BG/W")
	Write( 12, 38, cString )
	SetColor("RB/W")
	Write( 13, 38, cString )
	SetColor("GR+/W")
	Write( 14, 38, cString )
	SetColor("G+/W")
	Write( 15, 38, cString )
	SetColor("R+/W")
	Write( 16, 38, cString )
	SetColor("N+/W")
	Write( 17, 38, cString )
	SetColor("GR/W")
	Write( 18, 38, cString )
	LinButton1( OK, 01, 21, "&Iniciar", NIL )
EndIF
Return

********************************
Function DOWNMENU(Arg1, Arg2, Arg3, Arg4, Arg5)

	Local Local1, Local2, Local3, Local4, Local5, Local6, Local7, ;
		Local8
	Local1:= htk:= 0
	Local2:= setcursor(0)
	Local3:= Len(Arg1)
	Local4:= Arg1[1][10]
	For Local6:= 1 To Local3
		Local4:= Max(Arg1[Local6][10], Local4)
	Next
	For Local6:= 1 To Local3
		Arg1[Local6][10]:= Local4
	Next
	Local7:= Arg3 + Local3 + 1
	Local8:= Arg4 + Arg1[1][10] + 1
	If (procname(1) == "DOWNMENU" .AND. (Arg4 > 45 .OR. Arg4 + Arg5 > ;
			65))
		Arg4:= Arg4 + Arg5
		Local8:= Local8 + Arg5
		Arg4:= Arg4 - IIF(Local8 + 3 > 80, Arg5 + Arg1[1][10] + 2, 0)
		Local8:= Local8 - IIF(Local8 + 3 > 80, Arg5 + Arg1[1][10] + 2, ;
			0)
		Arg3:= Arg3 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		If (Arg4 < 0)
			Arg4:= 77 - (Local8 - Arg4)
			Local8:= Arg4 + Arg1[1][10] + 1
		EndIf
	ElseIf (procname(1) == "DOWNMENU")
		Arg4:= Arg4 + Arg5
		Local8:= Local8 + Arg5
		Arg4:= Arg4 - IIF(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Local8:= Local8 - IIF(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Arg3:= Arg3 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
	Else
		Arg4:= Arg4 - IIF(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Local8:= Local8 - IIF(Local8 + 3 > 80, Local8 + 3 - 80, 0)
		Arg3:= Arg3 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
		Local7:= Local7 - IIF(Local7 + 1 > 22, Local7 + 1 - 22, 0)
	EndIf
	Local5:= nbox(Arg3, Arg4, Local7, Local8)
	For Local6:= 1 To Local3
		Arg1[Local6][6]:= Arg3 + Local6
		Arg1[Local6][7]:= Arg4 + 1
		drawdownit(Arg1[Local6], 1)
	Next
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Do While (Arg1[Arg2][9])
		Arg2:= IIF(++Arg2 > Len(Arg1), 1, Arg2)
	EndDo
	Do While (.T.)
		drawdownit(Arg1[Arg2], 2)
		If (Arg1[Arg2][2] != Nil .OR. Arg1[Arg2][2] != "")
			dwnmsg(Arg1[Arg2][2])
		EndIf
		Local1:= ninkey(0)
		If ((htk:= ascan(Arg1, { |_1| Upper(Chr(Local1)) == ;
				Upper(_1[5]) })) != 0)
			drawdownit(Arg1[Arg2], 1)
			Arg2:= htk
			Keyboard Chr(13)
		EndIf
		Do Case
		Case Local1 == 5
			drawdownit(Arg1[Arg2], 1)
			Arg2:= IIF(--Arg2 == 0, Len(Arg1), Arg2)
			Do While (Arg1[Arg2][9])
				Arg2:= IIF(--Arg2 == 0, Len(Arg1), Arg2)
			EndDo
		Case Local1 == 24
			drawdownit(Arg1[Arg2], 1)
			Arg2:= IIF(++Arg2 > Len(Arg1), 1, Arg2)
			Do While (Arg1[Arg2][9])
				Arg2:= IIF(++Arg2 > Len(Arg1), 1, Arg2)
			EndDo
		Case Local1 == 27 .OR. Local1 == 19 .OR. Local1 == 4
			Arg2:= 0
			Exit
		Case Local1 == 13 .AND. Arg1[Arg2][4]
			If (ISARRAY(Arg1[Arg2][3]))
				flg:= .T.
				downmenu(Arg1[Arg2][3], 1, Arg1[Arg2][6] - 1, ;
					Arg1[Arg2][7], Arg1[Arg2][10])
				If (LastKey() == K_LEFT .OR. LastKey() == K_RIGHT)
					Arg2:= 0
					Exit
				EndIf
			Else
				eval(Arg1[Arg2][3])
			EndIf
			aeval(Arg1, { |_1| drawdownit(_1, 1) })
		EndCase
	EndDo
	rstenv(Local5)
	setcursor(Local2)
	Return Arg2

********************************
Procedure NBARMENU


********************************
Function NEWBARMENU

	Return {}

********************************
Function ADDBARITEM(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7)

	Local Local1, Local2, Local3
	Local3:= Len(Arg1)
	Arg2:= IIF(At("&", Arg2) == 0, "&" + Arg2, Arg2)
	Arg4:= IIF(ISNIL(Arg4), { || nret() }, Arg4)
	Arg5:= IIF(ISNIL(Arg5), .T., Arg5)
	Arg6:= IIF(ISNIL(Arg6), 1, Arg6)
	Local1:= SubStr(Arg2, At("&", Arg2) + 1, 1)
	Local2:= Len(Arg2) + 1
	If (Local3 == 0)
		Arg7:= IIF(ISNIL(Arg7), 1, Arg7)
	Else
		Arg7:= IIF(ISNIL(Arg7), Arg1[Local3][7] + Arg1[Local3][8], Arg7)
	EndIf
	AAdd(Arg1, {Arg2, Arg3, Arg4, Arg5, Local1, Arg6, Arg7, Local2})
	Return Nil

********************************
Function BARMENU(Arg1, Arg2, Arg3)

	Local Local1:= htk:= 0, Local2:= setcursor(0), Local3:= ink:= ;
		.T., Local4:= .F.
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Arg3:= IIF(ISNIL(Arg3), 1, Arg3)
	aeval(Arg1, { |_1| (_1[6]:= Arg2, drawbarite(_1, 1)) })
	Do While (.T.)
		drawbarite(Arg1[Arg3], 2)
		If (Local3 .AND. (Arg1[Arg3][2] != Nil .OR. Arg1[Arg3][2] != ;
				""))
			dwnmsg(Arg1[Arg3][2])
		EndIf
		If (ink)
			Local1:= ninkey(0)
		EndIf
		If ((htk:= ascan(Arg1, { |_1| Upper(Chr(Local1)) == ;
				Upper(_1[5]) })) != 0)
			drawbarite(Arg1[Arg3], 1)
			Arg3:= htk
			Keyboard Chr(13)
		EndIf
		Do Case
		Case Local1 == 19
			drawbarite(Arg1[Arg3], 1)
			Arg3:= IIF(--Arg3 == 0, Len(Arg1), Arg3)
		Case Local1 == 4
			drawbarite(Arg1[Arg3], 1)
			Arg3:= IIF(++Arg3 > Len(Arg1), 1, Arg3)
		Case Local1 == 27
			Arg3:= 0
			Exit
		Case Local1 == 13 .AND. Arg1[Arg3][4]
			If (ISARRAY(Arg1[Arg3][3]))
				downmenu(Arg1[Arg3][3], 1, Arg1[Arg3][6] + 1, ;
					Arg1[Arg3][7])
				If (LastKey() == K_LEFT .OR. LastKey() == K_RIGHT)
					Local1:= LastKey()
					Local3:= .F.
					ink:= .F.
					Local4:= .T.
					aeval(Arg1, { |_1| drawbarite(_1, 1) })
					Loop
				Else
					Local3:= .T.
					ink:= .T.
					Local4:= .F.
				EndIf
			ElseIf (LastKey() == K_ENTER)
				eval(Arg1[Arg3][3])
				Local4:= .F.
			Else
				Local3:= .T.
				ink:= .T.
				aeval(Arg1, { |_1| drawbarite(_1, 1) })
				Loop
			EndIf
			aeval(Arg1, { |_1| drawbarite(_1, 1) })
		EndCase
		If (Local4 .AND. Arg1[Arg3][4])
			Local1:= 13
			Local3:= .F.
			ink:= .F.
		ElseIf (!Arg1[Arg3][4])
			Local3:= .T.
			ink:= .T.
		EndIf
	EndDo
	setcursor(Local2)
	Return Arg3

********************************
Function DRAWBARITE(Arg1, Arg2)

	Local Local1, Local2, Local3, Local4
	Local3:= padr(" " + textmenu(Arg1[1]), Arg1[8])
	Local4:= At("&", Arg1[1])
	If (Arg2 == 1)
		Local1:= IIF(Arg1[4], "N*/W", "W*/W")
		Local2:= IIF(Arg1[4], "R+*/W", "N*/W")
	ElseIf (Arg2 == 2)
		Local1:= IIF(Arg1[4], "W+/N", "W/N")
		Local2:= IIF(Arg1[4], "R+/N", "W+/N")
	EndIf
	@ Arg1[6], Arg1[7] Say Local3 Color Local1
	@ Arg1[6], Arg1[7] + Local4 Say Arg1[5] Color Local2
	Return Nil

********************************
Function TEXTMENU(Arg1)

	Local Local1, Local2, Local3
	Local1:= At("&", Arg1)
	Local2:= SubStr(Arg1, 1, Local1 - 1)
	Local3:= SubStr(Arg1, Local1 + 1)
	Return IIF(Local1 != 0, Local2 + Local3, Arg1)

********************************
Function SETBARITEM(Arg1, Arg2, Arg3)

	Local Local1
	Local1:= Arg1[Arg2][4]
	If (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	EndIf
	Return Local1

* EOF


********************************
Procedure NDWNMENU


********************************
Function NEWDOWNMEN

	Return {}

********************************
Function ADDDOWNITE(Arg1, Arg2, Arg3, Arg4, Arg5, Arg6, Arg7, Arg8)

	Local Local1, Local2
	Local2:= Len(Arg1)
	Arg2:= IIF(At("&", Arg2) == 0, "&" + Arg2, Arg2)
	Arg4:= IIF(ISNIL(Arg4), { || nret() }, Arg4)
	Arg6:= IIF(ISNIL(Arg6), .T., Arg6)
	Arg8:= IIF(ISNIL(Arg8), 3, Arg8)
	Local1:= SubStr(Arg2, At("&", Arg2) + 1, 1)
	If (Local2 == 0)
		Arg7:= IIF(ISNIL(Arg7), 3, Arg7)
		Arg5:= IIF(ISNIL(Arg5), Len(Arg2) + 4, Arg5)
	Else
		Arg7:= IIF(ISNIL(Arg7), Arg1[Local2][6] + 1, Arg7)
		Arg5:= IIF(ISNIL(Arg5), Max(Arg1[Local2][10], Len(Arg2) + 4), ;
			Arg5)
	EndIf
	AAdd(Arg1, {Arg2, Arg3, Arg4, Arg6, Local1, Arg7, Arg8, .F., .F., ;
		Arg5})
	Return Nil

********************************
Function ADDDOWNSEP(Arg1, Arg2)

	Local Local1, Local2, Local3
	Local3:= Len(Arg1)
	Arg2:= IIF(ISNIL(Arg2), 1, Arg2)
	Local2:= IIF(ISNIL(Local2), 3, Local2)
	If (Local3 == 0)
		Local1:= IIF(ISNIL(Local1), 3, Local1)
	Else
		Local1:= IIF(ISNIL(Local1), Arg1[Local3][6] + 1, Local1)
	EndIf
	AAdd(Arg1, {Nil, Nil, Nil, .T., "", Local1, Local2, .F., .T., ;
		Arg2})
	Return Nil

********************************
Function DRAWDOWNIT(Arg1, Arg2)

	Local Local1, Local2, Local3, Local4, Local5, Local6
	Local5:= IIF(Arg1[8], "?", "  ")
	Local6:= IIF(ISARRAY(Arg1[3]), Chr(16), " ")
	Local3:= IIF(Arg1[9], Replicate("?, Arg1[10]), padr(Local5 + ;
		textmenu(Arg1[1]), Arg1[10] - 1) + Local6)
	Local4:= IIF(Arg1[9], 0, At("&", Arg1[1]) + 1)
	If (Arg2 == 1)
		Local1:= IIF(Arg1[4], "N*/W", "W*/W")
		Local2:= IIF(Arg1[4], "R+*/W", "N*/W")
	ElseIf (Arg2 == 2)
		Local1:= IIF(Arg1[4], "W+/N", "W/N")
		Local2:= IIF(Arg1[4], "R+/N", "W+/N")
	EndIf
	If (Arg1[9])
		@ Arg1[6], Arg1[7] Say Local3 Color Local1
	Else
		@ Arg1[6], Arg1[7] Say Local3 Color Local1
		@ Arg1[6], Arg1[7] + Local4 Say Arg1[5] Color Local2
	EndIf
	Return Nil

********************************
Function CHKDOWNITE(Arg1, Arg2, Arg3)

	Local Local1
	Local1:= Arg1[Arg2][8]
	If (Arg3 != Nil)
		Arg1[Arg2][8]:= Arg3
	EndIf
	Return Local1

********************************
Function SETDOWNITE(Arg1, Arg2, Arg3)

	Local Local1
	Local1:= Arg1[Arg2][4]
	If (Arg3 != Nil)
		Arg1[Arg2][4]:= Arg3
	EndIf
	Return Local1

Proc Help( cProg, nLine, xVar )
********************************
LOCAL cScreen		:= SaveScreen()
LOCAL aArray		:= {}
LOCAL Help_Codigo := 1
LOCAL cTexto

Set Key 28 To
nHandle := Fopen( oAmbiente:xBase + "\HELP.HLP")
IF MsLocate( nHandle, "/" + StrZero( Help_Codigo, 4) ) = 0
	cTitulo := MsReadLine( nHandle )
	WHILE !Feof( nHandle )
		cTexto := MsReadLine( nHandle )
		IF Left( cTexto, 1 ) = "/"
			Exit
		Else
			Aadd( aArray, cTexto )
		EndIF
	EndDo
	M_Title( cTitulo )
	Mx_Choice( 05,10,19,69, aArray, Cor())
Else
	Alerta("Help nao Disponivel...")
EndIf
FClose( nHandle )
Set Key 28 To Help
ResTela( cScreen )

Function Extenso( Numero, Dinheiro, Linhas, Largura )
*****************************************************
/*
								 ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ Valor a Imprimir por extenso
                         ? ÚÄÄÄÄÄÄÄÄÄÄÄ?Tipo de Moeda (1-Real, 2 - Dolar)
								 ? ?ÚÄÄÄÄÄÄÄÄÄ?Qtde de Linhas para impressao
		 LARG = 50	 &&	 ? ?? ÄÄÄÄÄÄ?Comprimento da Linha de impressao
		 VALOR = EXTENSO( Vlr,2,3,LARG)
		 @ 14,05 Say LEFT(VALOR,LARG)
		 @ 15,05 Say SubStr(VALOR,LARG+1,LARG)
		 @ 16,05 Say RIGHT(VALOR,LARG)
*/

LOCAL Numero1	 := StrZero( Numero, 13, 2 )
PUBLI TipoMoeda := Dinheiro
PRIVA cTexto	 := ""
PRIVA aUnidade  := {"UM ","DOIS ","TRES ","QUATRO ","CINCO ","SEIS ","SETE ","OITO ","NOVE " }
PRIVA aDezena	 := {"DEZ ","VINTE ","TRINTA ","QUARENTA ", "CINQUENTA ","SESSENTA ","SETENTA ","OITENTA ","NOVENTA " }
PRIVA Ndb		 := {"DEZ ","ONZE ","DOZE ","TREZE ","QUATORZE ","QUINZE ","DEZESSEIS ", "DEZESSETE ","DEZOITO ","DEZENOVE " }
PRIVA aCentena  := {"CENTO ","DUZENTOS ","TREZENTOS ","QUATROCENTOS ","QUINHENTOS ","SEISCENTOS ","SETECENTOS ","OITOCENTOS ", "NOVECENTOS " }
PRIVA aMilhar	 := {"MILHAO ","MILHOES " }
PRIVA aCentavo  := {"CENTAVO","CENTAVOS"}
PRIVA cMil		 :=  "MIL "
PRIVA aMoeda	 := {{ "REAL ", "REAIS "}, {"DOLAR ", "DOLARES "}, {"HORA ", "HORAS "}}

IF TipoMoeda = 3 // Horas
	aCentavo  := {"MINUTO","MINUTOS"}
EndIF
P1 := SubStr( Numero1, 2, 3 )
P2 := SubStr( Numero1, 5, 3 )
P3 := SubStr( Numero1, 8, 3 )
P4 := StrZero(( Numero - Int( Numero ) ) * 100, 3 )

Converte( P1, 1 )
Converte( P2, 2 )

IF Val( P2) <> 0 .AND. Val( P3 ) < 100 .AND. Val( P4) = 0  // Ex. linha 50
   cTexto += cTexto  // + "E "
EndIF

Converte( P3, 3 )

IF P3 = "000" .AND. VAL( P1 + P2 ) <> 0
	cTexto := cTexto + aMoeda[ TipoMoeda, 2 ]
EndIF

Converte( P4, 4 )
cTexto := Formata( cTexto, Linhas, Largura)
Return cTexto

Function Converte( x, Grandeza  )
********************************

IF x = "000"
  Return cTexto
EndIF

x1 := Left( x, 1 )
x2 := SubStr( x, 2, 1 )
x3 := Right( x, 1 )
X4 := Right( x, 2 )

IF Grandeza = 4
  cTexto += IIF( Val( P1 + P2 + P3 ) <> 0, "E ", "" )
EndIF

IF x1 <> "0"         // Centena
	IF x4 = "00" .AND. x1 = "1"
		cTexto += "CEM "
	Else
		cTexto +=  aCentena[ Val( x1 ) ]
	EndIF
EndIF

IF x4 >= "10" .AND. x4 <= "19"    // Dezena ate dezenove
   cTexto +=  IIF( x1 <> "0", "E " + Ndb[ Val( x4 ) -9 ] , Ndb[ Val( x4 ) -9 ] )
EndIF

IF x2 >= "2"
  IF x1 <> "0"
    cTexto += "E " + aDezena[ Val( x2 ) ]
  Else
	  cTexto += aDezena[ Val( x2 ) ]
  EndIF
EndIF

IF x3 <> "0" .AND. (x4 < "10" .OR. x4 > "19")
	IF x1<> "0" .OR. x2 <> "0"
      cTexto += "E " + aUnidade[VAL(x3)]
	ELSE
		cTexto += aUnidade[VAL(x3)]
	EndIF
EndIF

DO CASE
CASE grandeza = 1
  cTexto += IIF(VAL(x)=1, aMilhar[1], aMilhar[2])
CASE grandeza = 2
  cTexto += IIF(VAL(x) > 0, cMil, "" )
CASE grandeza = 3
  cTexto += IIF(VAL(p1+p2+p3)=1, aMoeda[ TipoMoeda, 1], aMoeda[ TipoMoeda, 2 ])
CASE grandeza = 4
  cTexto += IIF(VAL(x)=1, aCentavo[1], aCentavo[2])
CASE grandeza = nil
  cTexto += ""
ENDCASE
Return( cTexto )

Function Formata( _Txt, _Lin, _Tam )
***********************************
qtd_lin = MLCOUNT( _txt, _tam )
qtd_lin = IIF(qtd_lin > _lin,_lin,qtd_lin)
_txtaux=""
FOR _i = 1 TO qtd_lin
	linha = TRIM(MEMOLINE(_txt,_tam,_i))
	IF _i <> qtd_lin
		DO WHILE .T.
			falta = _tam-Len(linha)
			IF falta > 20 .OR. RIGHT(linha,1)="."
				EXIT
			EndIF
			IF Len(linha) < _tam
				linha = STRTRAN(linha," ",Chr(177))
				FOR _j = 1 TO falta
					acha = Rat(Chr(177),linha)
					IF acha = 0
						EXIT
					EndIF
					linha = Stuff(linha,acha,1,"  ")
				NEXT
				linha = STRTRAN(linha,Chr(177)," ")
			EndIF
			IF Len(TRIM(linha))= _tam
				EXIT
			EndIF
		ENDDO
	EndIF
		_txtaux = _txtaux + linha
NEXT
_txtaux = LEFT(TRIM(_txtaux)+Repl("*",_tam * _lin),_tam * _lin)
Return (_txtaux)

Function CodiOriginal( cNr_Original )
*************************************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL lRetVal	:= OK


cNr_Original := AllTrim( cNr_Original )
Lista->(Order( LISTA_N_ORIGINAL ))
IF Lista->(!DbSeek( cNr_Original ))
	ErrorBeep()
	Alerta("Erro: Nao Encontrado.")
	lRetVal := FALSO
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( lRetVal )

Proc TentaCriarArquivo( cArquivo )
**********************************
LOCAL cScreen := SaveScreen()
LOCAL Dbf1, cTela
LOCAL aArquivos := {}
Aadd( aArquivos, { "EMPRESA.DBF", {{ "CODI", "C", 04, 0 }, { "NOME",    "C", 40, 0 }}})
IF cArquivo != NIL
	IF Ascan( aArquivos[1], cArquivo ) = 0
		Return( FALSO )
	EndIF
EndIF
nTam := Len( aArquivos )
For nX := 1 To nTam
	cArquivo := aArquivos[nX,1]
	IF !File( cArquivo )
		Mensagem( "Aguarde... Gerando o Arquivo " + cArquivo, Cor())
		DbCreate( cArquivo, aArquivos[nX,2] )
	Else
		IF NetUse( cTemp, MULTI )
			Integridade( aArquivos[nX, 2], Cor())
		Else
			Cls
			Quit
		EndIF
	EndIF
Next
Return( OK )


Function Amax( aArray )
***********************
LOCAL nLen	 := Len( aArray )
LOCAL nY 	 := 1
LOCAL nMaior := 0
LOCAL cMaior := ""
LOCAL nPos	 := 0

FOR nY := 1 To nLen
	xVar := ValType( aArray[nY])
	IF xVar = "N"
		IF aArray[nY] > nMaior
			nMaior := aArray[nY]
		EndIF
	EndIF
Next
Return( nMaior )

Proc DelTemp()
**************
Aeval( Directory( "T0*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
Aeval( Directory( "T1*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
Aeval( Directory( "T2*.*"),   { | aFile | Ferase( aFile[ F_NAME ] )})
Aeval( Directory( "T0*.TMP"), { | aFile | Ferase( aFile[ F_NAME ] )})
Return

Function CopyOk( cUnidade )
***************************
LOCAL c1 := RomCkSum()
LOCAL lOk
LOCAL String
LOCAL Temp
LOCAL fHandle
LOCAL xArquivo := "SC" + AllTrim( Str( c1 )) + ".PPP"

fHandle := Fopen( xArquivo, 2 )
IF fHandle = -1
	lOk = .F.
ELSE
	sTring := Space(8)
	Fread( fHandle, @sTring, 8 )
	lOk = IIF( string == MsDCriptar( STR(c1,8,0)), OK, FALSO )
ENDIF
FClose( fHandle)
Return( lOk )

Function CopyCria()
*******************
LOCAL lOk	  := FALSO
LOCAL c1 	  := RomCkSum()
LOCAL String
LOCAL Temp
LOCAL fHandle
LOCAL xArquivo := "SC" + AllTrim( Str( c1 )) + ".PPP"

fHandle := FCreate( xArquivo, 4 )
IF fHandle <> -1
	lOk := IIF( FWrite( fHandle, MsCriptar( Str( c1, 8, 0 )), 8 ) = 8, OK, FALSO )
	FClose( fHandle )
EndIF
Return( lOk )

Function MsDecToChr( cString )
****************************
LOCAL cNewString := ""
LOCAL nTam
LOCAL nX
LOCAL cNumero

nTam := StrCount( "#", cString )
For nX := 1 To nTam
	cNumero := StrExtract( cString, "#", nX+1 )
	cNewString += Chr( Val( cNumero ))
Next
Return ( cNewString )

 Procedure Opcoes( Par1, Par2, Par3 )
**********************************
LOCAL cScreen := SaveScreen()
LOCAL nChoice
LOCAL aMenuArray := { " Calculadora "," Calendario "," Tabela Ascii " }
Set Key -9 To
			 WHILE OK
				 oMenu:Limpa()
				 StatusInf("ESCOLHA COM SETAS E TECLE ÄÄÄÄ?,"ESC-RETORNA")
		  M_Title( "OPCOES" )
				 nChoice := FazMenu( 03, 60, aMenuArray, Cor())
				 IF nChoice = 0
					 Set Key -9 To Opcoes() // F10
					 ResTela( cScreen )
					 Exit
				 EndIF
				 oMenu:Limpa()
				 Do Case
				 Case nChoice = 1
					 Calc()
				 Case nChoice = 2
					 Calendario()
				 Case nChoice = 3
					 Ascii()
				 EndCase
			 EndDo

Function ResTela( cScreen )
***************************
Return( RestScreen( 0, 0, MaxRow(), MaxCol(),  cScreen ))

/*
Function SaveScreen()
*********************
cScreen := FTempName("T*.BMP")
ScrToDisk( cScreen, 00, 00, MaxRow(), MaxCol())
Return( cScreen )

Function ResTela( cScreen )
***************************
Return( DiskToScr( cScreen, 0, 0, MaxCol(), MaxCol() ))
*/

Function PrintOn( lFechaSpooler )
*********************************
LOCAL nQualPorta := 1
LOCAL cSaida	  := ""

IF lFechaSpooler = NIL
	AbreSpooler()
EndIF
Instru80( @nQualPorta )
IF 	 nQualPorta = 1
	cSaida := "LPT1"
ElseIF nQualPorta = 2
	cSaida := "LPT2"
ElseIF nQualPorta = 3
	cSaida := "LPT3"
ElseIF nQualPorta = 4
	cSaida := "COM1"
ElseIF nQualPorta = 5
	cSaida := "COM2"
ElseIF nQualPorta = 6
	cSaida := "COM3"
EndIF
Set Cons Off
Set Devi To Print
IF !oAmbiente:Spooler
	IF nQualPorta != 1
		Set Print To ( cSaida )
	EndIF
EndIF
Set Print On
FPrint( RESETA )
SetPrc(0,0)
Return Nil

Function PrintOff()
*******************
PrintOn( OK )
FPrint( RESETA )
Set Devi To Screen
Set Prin Off
Set Cons On
Set Print to
CloseSpooler()
Return Nil

Function Instru80( nQualPorta )
*******************************
STATI nPortaDeImpressao := 1
LOCAL cScreen				:= SaveScreen()
LOCAL Arq_Ant				:= Alias()
LOCAL Ind_Ant				:= IndexOrd()
LOCAL nChoice
LOCAL aNewLpt
LOCAL i						:= 0
LOCAL nStatus				:= 0
PUBLI lCancelou			:= FALSO
PRIVA aStatus				:= {}
PRIVA aAction				:= {}
PRIVA aComPort 			:= {}
PRIVA aMenu

IF nQualPorta != NIL
	nQualPorta := nPortaDeImpressao
	Return( OK )
EndIF
ErrorBeep()
WHILE OK
	oMenu:Limpa()
	aAction	:= { "PRONTA         ","FORA DE LINHA  ","DESLIGADA      ","SEM PAPEL      ", "NAO CONECTADA  "}
	aComPort := { "DISPONIVEL     ","INDISPONIVEL   " }
	aStatus := {}
   alDisp  := { OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK }
	For i := 1 To 3
      nStatus := PrnStatus(i)
		IF nStatus = -1
			nStatus = 4
		Else
			nStatus++
		EndIF
		Aadd( aStatus, nStatus )
	Next
	aMenu   := {" LPT1 þ " + aAction[ aStatus[1]] + " þ " + aLpt1[1,2],;
					" LPT2 þ " + aAction[ aStatus[2]] + " þ " + aLpt2[1,2],;
					" LPT3 þ " + aAction[ aStatus[3]] + " þ " + aLpt3[1,2],;
					" COM1 þ " + IIF( IsCom(1), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 1",;
					" COM2 þ " + IIF( IsCom(2), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 2",;
					" COM3 þ " + IIF( IsCom(3), aComPort[1], aComPort[2]) + " þ " + "PORTA SERIAL 3",;
					" USB  þ " + aAction[ aStatus[1]] + " þ IMPRESSORA USB",;
					" VISUALIZAR   þ ",;
					" EMAIL        þ ",;
					" WEB BROWSER  þ ",;
               " SPOOLER      þ ",;
					" CANCELAR     þ "}
   MaBox( 05, 10, 18, 62,,"ENTER=IMPRIMIR?TRL+ENTER=ESCOLHER?TRL+PGDN=ONLINE")
   nChoice := aChoice( 06, 11, 17, 61, aMenu, alDisp, "_Instru80" )
	aNewLpt := aLpt1
	Do Case
		Case nChoice = 1
			aNewLpt := aLpt1
		Case nChoice = 2
			aNewLpt := aLpt2
		Case nChoice = 3
			aNewLpt := aLpt3
		Case nChoice = 7
			aNewLpt := aLpt1
		Case nChoice = 8
			aNewLpt := aLpt1
		Case nChoice = 9
			aNewLpt := aLpt1
      Case nChoice = 11
			aNewLpt := aLpt1
	EndCase
	AreaAnt( Arq_Ant, Ind_Ant )
	SetarVariavel( aNewLpt )
	Do Case
   Case nChoice = 0 .OR. nChoice = 12
		IF lCancelou
			lCancelou := FALSO
			Loop
		EndIF
		IF Conf("Pergunta: Cancelar Impressao ?")
			Return( FALSO )
		EndIF
	Case nChoice = 7
		nPortaDeImpressao := 1
		SaidaParaUsb()
		Return( OK )
	Case nChoice = 8
		nPortaDeImpressao := 1
      SaidaParaArquivo()
		Return( OK )
	Case nChoice = 9
		nPortaDeImpressao := 1
		SaidaParaEmail()
		Return( OK )
	Case nChoice = 10
		nPortaDeImpressao := 1
		SaidaParaHtml()
		Return( OK )
   Case nChoice = 11
		nPortaDeImpressao := 1
      SaidaParaSpooler()
		Return( OK )
	OTherWise
		nPortaDeImpressao   := IIF( nChoice = 0, 1, nChoice )
		oAmbiente:cArquivo  := ""
		oAmbiente:Spooler   := FALSO
		oAmbiente:IsPrinter := nChoice
		nQualPorta			  := nChoice
		IF LptOk()
			ResTela( cScreen )
			Return( OK )
		EndIF
	EndCase
EndDo
ResTela( cScreen )

Function _Instru80( Mode, nCorrente, nRowPos )
**********************************************
LOCAL cCodi := Space(02)
LOCAL cPath := FChdir()

Do Case
Case LastKey() = K_CTRL_PGDN
  lCancelou := OK
  Return( 0 )

Case Mode = 0
	Return(2)

Case Mode = 1 .OR. Mode = 2
	ErrorBeep()
	Return(2)

Case LastKey() = ESC
	Return(0)

Case LastKey() = K_RETURN	// ENTER
	Return(1)


Case LastKey() = K_CTRL_RET  // CTRL+ENTER
	FChDir( oAmbiente:xBaseDados )
	Set Defa To ( oAmbiente:xBaseDados )
	IF UsaArquivo("PRINTER")
		PrinterErrada( @cCodi )
		IF nCorrente = 1
			aLpt1 := {}
			Aadd( aLpt1, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
								Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
								Printer->_Spaco1_6, Printer->Reseta })
			aMenu[1] := " LPT1 þ " + aAction[ aStatus[1]] + " þ " + aLpt1[1,2]
		ElseIF nCorrente = 2
			aLpt2 := {}
			Aadd( aLpt2, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
								Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
								Printer->_Spaco1_6, Printer->Reseta })

			aMenu[2] := " LPT2 þ " + aAction[ aStatus[2]] + " þ " + aLpt2[1,2]
		ElseIF nCorrente = 3
			aLpt3 := {}
			Aadd( aLpt3, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
								Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
								Printer->_Spaco1_6, Printer->Reseta })
			aMenu[3] := " LPT3 þ " + aAction[ aStatus[3]] + " þ " + aLpt3[1,2]
		EndIf
		Printer->(DbCloseArea())
		IF UsaArquivo("USUARIO")
			IF Usuario->(DbSeek( oAmbiente:xUsuario ))
				IF Usuario->(TravaReg())
					Usuario->Lpt1 := IIF( aLpt1[1,1] = NIL, "", aLpt1[1,1])
					Usuario->Lpt2 := IIF( aLpt2[1,1] = NIL, "", aLpt2[1,1])
					Usuario->Lpt3 := IIF( aLpt3[1,1] = NIL, "", aLpt3[1,1])
					Usuario->(Libera())
				EndIF
			EndIF
			Usuario->(DbCloseArea())
		EndIF
	EndIF
	FChDir( cPath )
	Set Defa To ( cPath )
	Return(2)

OtherWise
	Return(2)

EndCase

Proc SetarVariavel( aNewLpt )
*****************************
LOCAL nPos := 2
PUBLIC _CPI10	  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC _CPI12	  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC GD		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC PQ		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC NG		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC NR		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC CA		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC C18		  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC LIGSUB	  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC DESSUB	  := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC _SALTOOFF := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC _SPACO1_8 := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC _SPACO1_6 := MsDecToChr( aNewLpt[1,++nPos] )
PUBLIC RESETA	  := MsDecToChr( aNewLpt[1,++nPos] )
Return

Function Impressora()
*********************
LOCAL cScreen := SaveScreen()
LOCAL nChoice := 0
LOCAL aMenu   := {}

oMenu:Limpa()
WHILE OK
	aMenu := { " LPT1 þ " + IIF( aLpt1[1,2] != NIL, aLpt1[1,2],""),;
				  " LPT2 þ " + IIF( aLpt2[1,2] != NIL, aLpt2[1,2],""),;
				  " LPT3 þ " + IIF( aLpt3[1,2] != NIL, aLpt3[1,2],"")}
	M_Title(" TECLE ENTER PARA ESCOLHER, ESC CANCELAR")
	nChoice := FazMenu( 09, 14, aMenu, Cor())
	IF  nChoice = 0
		ResTela( cScreen )
		Return
	Else
		MudaImpressora( nChoice )
	EndIF
EndDo

Proc MudaImpressora( nCorrente )
********************************
LOCAL cCodi := Space(02)

IF UsaArquivo("PRINTER")
	PrinterErrada( @cCodi )
	IF nCorrente = 1
		aLpt1 := {}
		Aadd( aLpt1, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
							Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
							Printer->_Spaco1_6, Printer->Reseta })
	ElseIF nCorrente = 2
		aLpt2 := {}
		Aadd( aLpt2, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
							Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
							Printer->_Spaco1_6, Printer->Reseta })

	ElseIF nCorrente = 3
		aLpt3 := {}
		Aadd( aLpt3, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
							Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
							Printer->_Spaco1_6, Printer->Reseta })
	EndIf
	Printer->(DbCloseArea())
	IF UsaArquivo("USUARIO")
		IF Usuario->(DbSeek( oAmbiente:xUsuario ))
			IF Usuario->(TravaReg())
				Usuario->Lpt1 := IIF( aLpt1[1,1] = NIL, "", aLpt1[1,1])
				Usuario->Lpt2 := IIF( aLpt2[1,1] = NIL, "", aLpt2[1,1])
				Usuario->Lpt3 := IIF( aLpt3[1,1] = NIL, "", aLpt3[1,1])
				Usuario->(Libera())
			EndIF
		EndIF
		Usuario->(DbCloseArea())
	EndIF
EndIF

Function Instruim()
*******************
Return( Instru80() )

Function InstruEt()
*******************
LOCAL cScreen := SaveScreen()
LOCAL nChoice
oMenu:Limpa()
ErrorBeep()
nChoice := Alert(" INSTRU€ŽO PARA EMISSŽO DE ETIQUETAS      " + ;
						";; ?Coloque Formulario Etiqueta.        " + ;
						"; ?Acerte a Altura do Picote           " + ;
						"; ?Resete ou Ligue a Impressora        ", { "Imprimir", "Visualizar", "Cancelar"})
ResTela( cScreen )
IF nChoice = 1
	oAmbiente:cArquivo := ""
	oAmbiente:Spooler  := FALSO
	Return( OK )
ElseIF nChoice = 2
	SaidaParaArquivo()
	Return( OK )
Else
	Return( FALSO )
EndIF

Function PrinterErrada( cCodi )
*******************************
LOCAL aRotina := {{|| CadastroImpressoras() }}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL lRetVal := OK

Area("Printer")
Printer->(Order( PRINTER_CODI ))
IF Printer->(!DbSeek( cCodi ))
	Printer->(Order( PRINTER_NOME ))
	Printer->(Escolhe( 00, 00, 24, "Codi + ' ' + Nome", "ID NOME DA IMPRESSORA", aRotina ))
	cCodi := Printer->Codi
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( lRetVal )


Proc PrinterDbedit()
********************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cScreen := SaveScreen()
PRIVA aVetor1 := { "CODI",     ;
						 "NOME",     ;
						 "_CPI10",   ;
						 "_CPI12",   ;
						 "GD",       ;
						 "PQ",       ;
						 "NG",       ;
						 "NR",       ;
						 "CA",       ;
						 "C18",      ;
						 "LIGSUB",   ;
						 "DESSUB",   ;
						 "_SALTOOFF",;
						 "_SPACO1_8",;
						 "_SPACO1_6",;
						 "RESETA",   }
PRIVA aVetor2 := Array(15)
aVetor2[1] := "99"
For nX := 2  To 15
	aVetor2[nX] := "@!"
Next
IF !UsaArquivo("Printer")
	Return
EndIF
oMenu:Limpa()
Area("Printer")
Printer->(Order( PRINTER_CODI ))
Printer->(DbGoTop())

MaBox( 22, 00, 24, MaxCol(),"OPCOES")
Write( 23, 01			, "-+Edita" )
Write( 23, Col()+2 , "[DELETE]Excluir" )
Write( 23, Col()+2 , "[ESC]Fim" )

MaBox( 00, 00, 21, MaxCol(),"PESQUISA/ALTERA IMPRESSORAS")
Seta1(21)
SetCursor(0)
DbEdit( 01, 01, 20, MaxCol()-1, aVetor1, "_Impressora", aVetor2 )
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function _Impressora( Modo, Ponteiro )
**************************************
LOCAL Pos_Cursor, Registro, Salva_Tela, nReg, xCodigo
LOCAL nKey		 := LastKey()
Pos_Cursor		 := aVetor1[ Ponteiro ]

Do Case
Case Modo = 1 .OR. Modo = 2 // Topo/Fim de Arquivo
	ErrorBeep()
	Return( 1 )

Case Modo < 4
	Return( 1 )

Case LastKey() = ESC
	Return( 0 )

Case LastKey() = TECLA_DELETE
	ErrorBeep()
	IF Conf("Confirma a Exclusao da Regiao Sob o Cursor ?")
		IF Printer->(TravaReg())
			Printer->(DbDelete())
			Printer->(Libera())
			Keyb Chr( K_CTRL_PGUP )
		EndIF
	EndIF
	Return(1)

Case LastKey() = TECLA_INSERT
		IF Printer->(Incluiu())
			Printer->(Libera())
		EndIF
		Return(1)

Case LastKey() = ENTER
	IF Printer->(TravaReg())
		SetCursor(1)
		@ Row(), Col() Get &pos_cursor.
		Read
		SetCursor(0)
		Printer->(Libera())
	EndIF
	Return(1)

CASE LastKey() >= 48 .AND. LastKey() <= 122	//  1 a Z
	DbSeek( Upper( Chr( nKey )))
	Return( 1 )

OtherWise
	Return(1)
EndCase

Proc CadastroImpressoras()
**************************
LOCAL GetList	  := {}
LOCAL cScreen	  := SaveScreen()
LOCAL cCodi 	  := Space(02)
LOCAL cNome 	  := Space(30)
LOCAL c_Cpi10	  := Space(30)
LOCAL c_Cpi12	  := Space(30)
LOCAL cGd		  := Space(30)
LOCAL cPq		  := Space(30)
LOCAL cNg		  := Space(30)
LOCAL cNr		  := Space(30)
LOCAL cCa		  := Space(30)
LOCAL cC18		  := Space(30)
LOCAL cLigSub	  := Space(30)
LOCAL cDesSub	  := Space(30)
LOCAL c_SaltoOff := Space(30)
LOCAL c_Spaco1_6 := Space(30)
LOCAL c_Spaco1_8 := Space(30)
LOCAL cReseta	  := Space(30)
LOCAL nOpcao
LOCAL nTam
LOCAL nCol
LOCAL nRow

FIELD Codi
FIELD Nome
FIELD Gd
FIELD Pq
FIELD Ng
FIELD Nr
FIELD Ca
FIELD C18
FIELD LigSub
FIELD DesSub
FIELD _SaltoOff
FIELD _Spaco1_6
FIELD _Spaco1_8
FIELD Reseta

IF !UsaArquivo("PRINTER")
	Return
EndIF
Area("Printer")
Printer->(DbGoBottom())
nTam	:= Printer->(Len( Codi ))
cCodi := Printer->(StrZero( Val( Codi ) +1, nTam ))
oMenu:Limpa()
MaBox( 05, 10, 22, 60, "INCLUSAO DE IMPRESSORAS" )
nCol := 11
nRow := 06
WHILE OK
	@ nRow,	  nCol Say "Codigo...........:" Get cCodi Pict "99" Valid PrinterCerto( @cCodi )
	@ Row()+1, nCol Say "Modelo...........:" Get cNome Pict "@!"
	@ Row()+1, nCol Say "Ligar 05 CPI.....:" Get cGd        Pict "@!"
	@ Row()+1, nCol Say "Desl  05 CPI.....:" Get cCA        Pict "@!"
	@ Row()+1, nCol Say "Ligar 10 CPI.....:" Get c_Cpi10    Pict "@!"
	@ Row()+1, nCol Say "Ligar 12 CPI.....:" Get c_Cpi12    Pict "@!"
	@ Row()+1, nCol Say "Ligar 15 CPI.....:" Get cPQ        Pict "@!"
	@ Row()+1, nCol Say "Desl  15 CPI.....:" Get cC18       Pict "@!"
	@ Row()+1, nCol Say "Ligar NEGRITO....:" Get cNG        Pict "@!"
	@ Row()+1, nCol Say "Desl  NEGRITO....:" Get cNR        Pict "@!"
	@ Row()+1, nCol Say "Ligar SUBLINHADO.:" Get cLigSub    Pict "@!"
	@ Row()+1, nCol Say "Desl  SUBLINHADO.:" Get cDesSub    Pict "@!"
	@ Row()+1, nCol Say "Desl SALTO PAG...:" Get c_SaltoOff Pict "@!"
	@ Row()+1, nCol Say "Espacamento 1/8..:" Get c_Spaco1_8 Pict "@!"
	@ Row()+1, nCol Say "Espacamento 1/6..:" Get c_Spaco1_6 Pict "@!"
	@ Row()+1, nCol Say "RESETAR..........:" Get cReseta    Pict "@!"
	Read
	IF LastKey() = ESC
		ResTela( cScreen )
		Exit
	EndIF
	ErrorBeep()
	nOpcao := Alerta(" Pergunta: Voce Deseja ? ", {" Incluir ", " Alterar ", " Sair " })
	IF nOpcao = 1 // Incluir
		IF PrinterCerto( @cCodi )
			IF Printer->(Incluiu())
				Printer->Codi		 := cCodi
				Printer->Nome		 := cNome
				Printer->_Cpi10	 := c_Cpi10
				Printer->_Cpi12	 := c_Cpi12
				Printer->Gd 		 := cGd
				Printer->Pq 		 := cPq
				Printer->Ng 		 := cNg
				Printer->Nr 		 := cNr
				Printer->Ca 		 := cCa
				Printer->C18		 := cC18
				Printer->LigSub	 := cLigSub
				Printer->DesSub	 := cDesSub
				Printer->_SaltoOff := c_SaltoOff
				Printer->_Spaco1_6 := c_Spaco1_6
				Printer->_Spaco1_8 := c_Spaco1_8
				Printer->Reseta	 := cReseta
				cCodi 				 := Printer->(StrZero( Val( Codi ) +1, nTam ))
				Printer->(Libera())
			EndIF
		EndIF
	ElseIF nOpcao = 2 // Alterar
		Loop
	ElseIF nOpcao = 3 // Sair
		ResTela( cScreen )
		Exit
	EndIF
END

Function PrinterCerto( cCodi )
******************************
LOCAL nTam	  := Printer->(Len( Codi ))
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL lRetVal := OK

Area("Printer")
Printer->(Order( PRINTER_CODI ))
IF Printer->(DbSeek( cCodi ))
	ErrorBeep()
	Alerta("Erro: Codigo ja Registrado.")
	cCodi := StrZero( Val( cCodi ) + 1, nTam )
	lRetVal := FALSO
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
Return( lRetVal )

Function CpfCgcIntToStr( nCpfCgc )
**********************************
LOCAL cCgc	:= AllTrim( Str( nCpfCgc ))
LOCAL nTam	:= Len( cCgc )

IF nTam <= 11
	cCpf1 := Left( cCgc, 3 )
	cCpf2 := SubStr( cCgc, 4, 3 )
	cCpf3 := SubStr( cCgc, 7, 3 )
	cCpf4 := SubStr( cCgc, 10, 2 )
	cCgc	:= cCpf1 + "." + cCpf2 + "." + cCpf3 + "-" + cCpf4
Else
	cCgc1 := Left( cCgc, 2 )
	cCgc2 := SubStr( cCgc, 3, 3 )
	cCgc3 := SubStr( cCgc, 6, 3 )
	cCgc4 := SubStr( cCgc, 9, 4 )
	cCgc5 := SubStr( cCgc, 13, 2 )
	cCgc	:= cCgc1 + "." + cCgc2 + "." + cCgc3 + "/" + cCgc4 + "-" + cCgc5
EndIF
Return( cCgc )

Function DbfEmUso( cBcoDados )
******************************
LOCAL nArea := Select( cBcoDados )
IF nArea = 0
	Return( FALSO )
EndIF
Return( OK )

Function EanDig( cString )
**************************
LOCAL nNumero1
LOCAL nNumero2
LOCAL nX
LOCAL nSoma
LOCAL nResto
LOCAL nTotal
LOCAL nDig

nNumero1 := 0
nNumero2 := 0
For nX := 2 To 12 Step 2
	nNumero1 += Val(SubStr( cString, nX, 1 ))
Next
For nX := 1 To 12 Step 2
	nNumero2 += Val(SubStr( cString, nX, 1 ))
Next
nNumero1 *= 3
nNumero2 *= 1
nSoma := nNumero1 + nNumero2

nResto := Mod( nSoma, 10 )
nTotal := nSoma
IF nResto <> 0
	nTotal -= nResto
	nTotal += 10
EndIF
nDig := nTotal - nSoma
Return( StrZero( nDig, 1 ))

Function R_NTX( ARG1, ARG2, ARG3, ARG4, ARG5, ARG6, ARG7, ARG8 )
****************************************************************
LOCAL LOCAL1
LOCAL LOCAL2
LOCAL LOCAL3
LOCAL1 := &( "{ || " + Trim(ARG1) + " }" )
LOCAL2 := LastRec()
LOCAL3 := R_Opnbar(IIF( ARG3 = Nil, "INDEXING: " + Trim(Alias()), ARG3 ), LTrim(Str(LOCAL2)) + " Registro(s)", ARG5, ARG6, ARG7, ARG8)
If ( LOCAL2 == 0 )
	LOCAL2 := 1
EndIf
Index On ( R_Updbar(LOCAL3, 100 * RecNo() / LOCAL2), Eval(LOCAL1) ) To (ARG2)
R_Clsbar(LOCAL3)
Return Nil

*:--------------------------------------------------------
Function R_CLSBAR( ARG1 )
*************************
Local LOCAL1
LOCAL1 := Set(_SET_DEVICE, "SCREEN")
If ( ValType(ARG1) = "A" )
	RestScreen(ARG1[ 2 ], ARG1[ 3 ], ARG1[ 2 ] + 5, ARG1[ 3 ] + 54, ARG1[ 1 ])
EndIf
Set(_SET_DEVICE, LOCAL1)
Return Nil

*:-----------------------------------------------------
Function R_OPNBAR( ARG1, ARG2, ARG3, ARG4, ARG5, ARG6 )
*******************************************************
Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7, LOCAL8, LOCAL9, LOCAL10, LOCAL11
LOCAL1 := {}
LOCAL3 := Set(_SET_DEVICE, "SCREEN")
LOCAL9 := "?š˜–Œ‹šš›?šŒ–‘?™ß­ ??×ÖßÒ?ž–‹ßÇ?šœ‘›Œ?
LOCAL10 := ""
For LOCAL11 := 1 To Len(LOCAL9)
	LOCAL10 := LOCAL10 + Chr(255 - Asc(SubStr(LOCAL9, LOCAL11, 1)))
Next
ARG2 := IIF( ARG2 = Nil, "", ARG2 )
ARG3 := IIF( ARG3 = Nil, 10, ARG3 )
ARG4 := IIF( ARG4 = Nil, 13, ARG4 )
ARG5 := IIF( ARG5 = Nil, "W+/B", ARG5 )
ARG6 := IIF( ARG6 = Nil, "GR+/B", ARG6 )
If ( ARG3 > 19 )
	ARG3 := 19
EndIf
If ( ARG4 > 25 )
	ARG4 := 25
EndIf
LOCAL5 := ARG3 + 4
LOCAL6 := ARG4 + 53
AAdd(LOCAL1, SaveScreen(ARG3, ARG4, LOCAL5 + 1, LOCAL6 + 1))
LOCAL2 := SetColor(ARG5)
Bar_Shbox(ARG3, ARG4, LOCAL5, LOCAL6)
If ( !Empty(ARG1) )
	If ( Len(ARG1) > LOCAL6 - ARG4 - 3 )
		ARG1 := Left(ARG1, LOCAL6 - ARG4 - 3)
	EndIf
	@ ARG3, ARG4 + ( LOCAL6 - ARG4 - Len(ARG1) - 1 ) / 2 Say "þ " + ARG1 + " þ"
EndIf
If ( !Empty(ARG2) )
	If ( Len(ARG2) > LOCAL6 - ARG4 - 3 )
		ARG2 := Left(ARG2, LOCAL6 - ARG4 - 3)
	EndIf
	@ LOCAL5, ARG4 + ( LOCAL6 - ARG4 - Len(ARG2) - 1 ) / 2 Say "þ " + ARG2 + " þ"
EndIf
@ ARG3 + 1, ARG4 + 25 Say Transform(0, "999%")
@ ARG3 + 3, ARG4 + 2 Say ""
For LOCAL4 := 1 To 9
	@ ARG3 + 3, ARG4 + 1 + LOCAL4 * 5 Say ""
Next
@ ARG3 + 3, LOCAL6 - 2 Say ""
@ ARG3 + 2, ARG4 + 2 Say Replicate(".", 50)
Set Color To (LOCAL2)
AAdd(LOCAL1, ARG3)
AAdd(LOCAL1, ARG4)
AAdd(LOCAL1, IIF( Procname(1) = "R_NTX", -1, 0 ))
AAdd(LOCAL1, ARG5)
AAdd(LOCAL1, ARG6)
Setcursor(0)
Set(_SET_DEVICE, LOCAL3)
Return LOCAL1

*:--------------------------------------------------------
Function R_PACK( ARG1, ARG2, ARG3, ARG4, ARG5 )
***********************************************
Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6
LOCAL1 := Alias()
LOCAL2 := IIF( LastRec() < 1, 1, LastRec() )
LOCAL3 := 0
LOCAL4 := Set(_SET_DELETED, .T.)
LOCAL5 := {}
LOCAL6 := R_Opnbar(IIF( ARG1 = Nil, "PACKING: " + Trim(Alias()), ARG1 ), LTrim(Str(LOCAL2)) + " record(s)", ARG2, ARG3, ARG4, ARG5)
Copy Structure To RvGTmp
Use RvGTmp New
Select (LOCAL1)
Goto Top
DBEval({ || ( LOCAL5 := Bar_Getrec(), Rvgtmp->( dbAppend() ), Rvgtmp->( Bar_Putrec(LOCAL5) ) ) }, { || !Deleted() }, { || R_Updbar(LOCAL6, 100 * ( LOCAL3 := LOCAL3 + 0.5 ) / LOCAL2) }, Nil, Nil, ;
	.F.)
Zap
Select RVGTmp
Goto Top
DBEval({ || ( LOCAL5 := Bar_Getrec(), dbSelectArea(LOCAL1), dbAppend(), Bar_Putrec(LOCAL5), dbSelectArea("RVGTmp") ) }, Nil, { || R_Updbar(LOCAL6, 100 * ( LOCAL3 := LOCAL3 + 0.5 ) / LOCAL2) }, ;
	Nil, Nil, .F.)
dbCloseArea("RVGTmp")
Select (LOCAL1)
Erase RvGTmp.DBF
Erase RvGTmp.DBT
Set Deleted (LOCAL4)
Return R_Clsbar(LOCAL6)

*:--------------------------------------------------------
Function R_UPDBAR( ARG1, ARG2 )
*******************************
Local LOCAL1, LOCAL2, LOCAL3
If ( ARG2 > 100 )
	ARG2 := 100
EndIf
LOCAL3 := Int(ARG2 / 2)
If ( ValType(ARG1) = "A" )
	If ( ARG1[ 4 ] < 0 )
		ARG1[ 4 ] := 0
	ElseIf ( LOCAL3 > ARG1[ 4 ] )
		LOCAL2 := Set(_SET_DEVICE, "SCREEN")
		LOCAL1 := SetColor(ARG1[ 5 ])
		@ ARG1[ 2 ] + 1, ARG1[ 3 ] + 25 Say Transform(ARG2, "999%")
		Set Color To (ARG1[ 6 ])
		@ ARG1[ 2 ] + 2, ARG1[ 3 ] + 2 Say Replicate("?, LOCAL3)
		ARG1[ 4 ] := LOCAL3
		Set Color To (LOCAL1)
		Set(_SET_DEVICE, LOCAL2)
	EndIf
EndIf
Return .T.

*:--------------------------------------------------------
Static Function BAR_GETREC
**************************
Local LOCAL1
LOCAL1 := {}
Aeval(Dbstruct(), { | _1, _2 | AAdd(LOCAL1, Fieldget(_2)) })
Return LOCAL1

*:--------------------------------------------------------
Static Function BAR_PUTREC( ARG1 )
**********************************
Aeval(Dbstruct(), { | _1, _2 | Fieldput(_2, ARG1[ _2 ]) })
Return Nil

*:--------------------------------------------------------
Static Function BAR_SHBOX( ARG1, ARG2, ARG3, ARG4 )
***************************************************
Local LOCAL1, LOCAL2
Scroll(ARG1, ARG2, ARG3, ARG4)
DispBox(ARG1, ARG2, ARG3, ARG4)
LOCAL1 := SaveScreen(ARG3 + 1, ARG2 + 1, ARG3 + 1, ARG4 + 1)
For LOCAL2 := 2 To Len(LOCAL1) Step 2
	LOCAL1 := Stuff(LOCAL1, LOCAL2, 1, "")
Next
RestScreen(ARG3 + 1, ARG2 + 1, ARG3 + 1, ARG4 + 1, LOCAL1)
LOCAL1 := SaveScreen(ARG1 + 1, ARG4 + 1, ARG3 + 1, ARG4)
For LOCAL2 := 2 To Len(LOCAL1) Step 2
	LOCAL1 := Stuff(LOCAL1, LOCAL2, 1, "")
Next
RestScreen(ARG1 + 1, ARG4 + 1, ARG3 + 1, ARG4, LOCAL1)
Return Nil


Function NtxProgress
********************
LOCAL nReg		 := Recno()
LOCAL nUltimo	 := LastRec()
LOCAL nPorcento := ( nReg / nUltimo ) * 100
LOCAL cComplete := LTrim( Str( Int( nPorcento )))

IF cComplete = "99"
	cComplete := "100"
EndIF
@ 08, 11 Say "þ " + LTrim(Str(nReg)) + " de " + LTrim(Str(nUltimo )) + " Registros"
@ 09, 11 Say "þ " + cComplete + "%"
@ 10, 11 Say Replicate("?, nPorcento/2 ) Color "W+/r"
Return .T.

Function LookUp( cString, aArray )
**********************************
// aDados := Chemov->(LookUp( '0000', {'Hist','Data', 'Docnr', 'Deb', 'Cre'})) //
LOCAL aDados := {}
LOCAL nY 	 := Len( aArray )
LOCAL nX 	 := 0

IF DbSeek( cString )
	For nX := 1 To nY
		Aadd( aDados, FieldGet( FieldPos( aArray[ nX ] )))
	Next
EndIF
Return( aDados )

Function MsDCriptar( Pal )
**************************
LOCAL cChave	:= ""
LOCAL nX 		:= 0

For nX := 0 To 10
	cChave += Chr( Asc( Chr( nX )))
Next
Return( MsDecrypt( Pal, cChave ))

Function MsCriptar( Pal )
*************************
LOCAL cChave	:= ""
LOCAL nX 		:= 0

For nX := 0 To 10
	cChave += Chr( Asc( Chr( nX )))
Next
Return( MsEncrypt( Pal, cChave ))

Function CriaNtx( Col_1, Lin_1, Nome_Field, Nome_Ntx, cTag )
************************************************************
Ferase( (Nome_Ntx) + ".NTX")
Ferase( (Nome_Ntx) + ".CDX")
SetColor("W*+/N")
Write( Col_1, Lin_1, Chr(10))
MacroNtx( Nome_Field, Nome_Ntx, cTag )
SetColor("W+/R")
Write( Col_1, Lin_1, Chr(251)) // ?
Return Nil

Function MacroNtx( Nome_Field, Nome_Ntx, cTag )
***********************************************
LOCAL cScreen := SaveScreen()
IF RddSetDefa() = "DBFNTX"
  MaBox( 07, 10, 11, 61 )
  Index On &Nome_Field. To &Nome_Ntx. Eval NtxProgress() Every LastRec()/1000
Else
  Index On &Nome_Field. Tag &Nome_Ntx. TO ( cTag ) EVAL Odometer() Every 10
EndIF
ResTela( cScreen )
Return Nil

Function FazMenu( nTopo, nEsquerda, aArray, Cor )
*************************************************
LOCAL cFrame2	  := SubStr( oAmbiente:Frame, 2, 1 )
LOCAL nFundo	  := ( nTopo + Len( aArray ) + 3 )
LOCAL nTamTitle  := ( Len( M_Title() ) + 12 )
LOCAL nDireita   := ( nEsquerda + AmaxStrLen( aArray ) + 1 )

IF ( nDireita - nEsquerda ) <  nTamTitle
	nDireita := ( nEsquerda + nTamTitle )
EndIF
Cor := IIF( Cor = NIL, Cor(), Cor )
//MaBox( nTopo, nEsquerda, nFundo, nDireita )
MS_Box( nTopo, nEsquerda, nFundo, nDireita )
nSetColor(Cor)
nChoice := Mx_Choice( @nTopo, @nEsquerda, @nFundo, @nDireita, aArray, Cor )
nSetColor(Cor)
Return( nChoice )

Function Conf( Texto, aDados )
******************************
LOCAL Les		 := 19
LOCAL Exceto	 := .F.
LOCAL Ativo 	 :=  1
LOCAL aArray	 := { " Sim ", " Nao " }
LOCAL cFundo	 := 207
LOCAL cFrente	 := 192
LOCAL Largjan	 := Len( Texto ) + 2
LOCAL Telavelha := SaveScreen()
LOCAL nRetVal
LOCAL PBack
LOCAL nLen

IF aDados = NIL
	IF oAmbiente:Visual
		Return(( nButton := MsgBox2( Texto ) == 1 ))
		ResTela( TelaVelha )
	EndIF
EndIF

LargJan := IIF( LargJan < 16, 16, LargJan )
Les	  := IIF( Les = Nil .OR. Les = 0, 19, Les )
Ces	  := (MaxCol()-LargJan)/2
Com	  := Ces + LargJan
Coluna  := (LargJan - 9 ) / 2
nRow	  := Les + 2
nCol	  := Ces + Coluna
nBot	  := Les + 3
nComp   := ( Com - Ces )-1
cFrame  := oAmbiente:Frame

M_Title( Texto )
IF aDados != NIL
	nLen := Len( aDados )
	ColorSet( @cFundo, @PBack )
	MsFrame( Les-nLen, Ces, Les+3, Com, oAmbiente:CorMsg )
	nChoice := aChoice( (Les-nLen)+3, Ces+4, Les+5, Com-3, aDados )
	ResTela( TelaVelha )
	Return( nChoice )
EndIF
ColorSet( @cFundo, @PBack )
MsFrame( Les-2, Ces, Les+3, Com, oAmbiente:CorMsg )
nRetVal := aChoice( Les+1, Ces+4, Les+5, Com-3, aArray )
ResTela( TelaVelha )
Return( nRetVal == 1 )

Function MsFrame( nTopo, nEsquerda, nFundo, nDireita, Cor )
***********************************************************
LOCAL cFrame2	:= SubStr( oAmbiente:Frame, 2, 1 )
LOCAL pFore 	:= IIF( Cor = NIL, Cor(), Cor )
LOCAL cPattern := " "
LOCAL pBack

ColorSet( @pfore, @pback )
Box( nTopo, nEsquerda, nFundo, nDireita, oAmbiente:Frame + cPattern, pFore  )
cSetColor( SetColor())
nSetColor( pFore, Roloc( pFore ))
@ nTopo+2, nEsquerda+1 Say Repl( cFrame2, (nDireita - nEsquerda )-1 )
@ nTopo+3, nEsquerda+2 TO nFundo-1,nEsquerda+2
@ nTopo+1, nEsquerda+1 SAY Padc( M_Title(), nDireita-nEsquerda-1)
@ nTopo+3, nDireita-2 TO nFundo-1, nDireita-2
Return( NIL )

Function IntToStrRepl( nValor, nTam )
************************************
LOCAL cStr := StrTran( StrTran( Tran( nValor, "9999999999999.99" ), ".")," ", "0")
Return( Right( cStr, nTam ))

Proc LigaTela()
***************
Set Cons On
Set Devi To Screen
Return

Proc DesLigaTela()
******************
Set Cons Off
Set Devi To Print
Return

Function AchaSegunda( dDate )
*****************************
IF cDow( dDate ) = 'Monday'
	Return( dDate + 7 )
EndIF
For i = 1 To 7
	 IF cDow( dDate + i ) = 'Monday'
		 Return( dDate + i )
	 EndIF
Next
Return dDate

Function TempNew( cDeleteFile)
******************************
LOCAL xTemp := FTempName("T*.$$$")
LOCAL cTela := Mensagem("Aguarde, Criando Arquivo Temporario.")

Ferase("*.TMP")
WHILE File((xTemp))
	xTemp := FTempName("T*.$$$")
EndDo
ResTela( cTela )
Return((xTemp))

Function RetPerc( nDivisor, nDividendo )
****************************************
LOCAL nDivi  := nDivisor / nDividendo
LOCAL nMult  := nDivi * 100
LOCAL Result := ( nMult - 100 )

IF Result == -100
	Result := 100
EndIF
Return( Result )

*:--------------------------------------------------------
Function RD( ARG1 )

	Local LOCAL1, LOCAL2
	static1 := 1
	LOCAL1 := Seconds()
	Do While ( ARG1 > LOCAL1 )
		LOCAL1 := LOCAL1 * 100 + Seconds()
	EndDo
	STATIC1 := ( STATIC1 + LOCAL1 ) / ( LOCAL2 := STATIC1 * LOCAL1 % ARG1 + 1 )
	Return Int(LOCAL2)

* EOF

*:-------------------------------------------------------
Procedure SHUFFLE

	Local LOCAL1, LOCAL2, LOCAL3, LOCAL4, LOCAL5, LOCAL6, LOCAL7, LOCAL8, LOCAL9, LOCAL10, LOCAL11, LOCAL12, LOCAL13, LOCAL14, LOCAL15
	LOCAL1 := 5 * Rd(5) - 1
	LOCAL2 := 10 * Rd(8) - 1
	LOCAL3 := LOCAL1 - 4
	LOCAL4 := LOCAL2 - 9
	LOCAL5 := 0
	LOCAL9 := Setcursor(0)
	LOCAL10 := Row()
	LOCAL11 := Col()
	LOCAL12 := SaveScreen()
	LOCAL15 := SetColor("W/N")
	Scroll(LOCAL3, LOCAL4, LOCAL1, LOCAL2)
	Do While ( InKey(0.05) == 0 )
		LOCAL13 := {}
		LOCAL14 := 0
		If ( LOCAL1 < 24 .AND. LOCAL5  !=  3 )
			AAdd(LOCAL13, 1)
			LOCAL14++
		EndIf
		If ( LOCAL4 > 0 .AND. LOCAL5	!=  4 )
			AAdd(LOCAL13, 2)
			LOCAL14++
		EndIf
		If ( LOCAL3 > 0 .AND. LOCAL5	!=  1 )
			AAdd(LOCAL13, 3)
			LOCAL14++
		EndIf
		If ( LOCAL2 < 79 .AND. LOCAL5  !=  2 )
			AAdd(LOCAL13, 4)
			LOCAL14++
		EndIf
		LOCAL5 := LOCAL13[ Rd(LOCAL14) ]
		LOCAL7 := LOCAL8 := 0
		Do Case
		Case LOCAL5 == 1
			LOCAL1 := LOCAL1 + 5
			LOCAL7 := 1
		Case LOCAL5 == 2
			LOCAL4 := LOCAL4 - 10
			LOCAL8 := -2
		Case LOCAL5 == 3
			LOCAL3 := LOCAL3 - 5
			LOCAL7 := -1
		Case LOCAL5 == 4
			LOCAL2 := LOCAL2 + 10
			LOCAL8 := 2
		EndCase
		For LOCAL6 := 1 To 5
			Scroll(LOCAL3, LOCAL4, LOCAL1, LOCAL2, LOCAL7, LOCAL8)
			If ( InKey(0.05)	!=  0 )
				Exit
			EndIf
		Next
		If ( LOCAL6 <= 5 )
			Exit
		EndIf
		Do Case
		Case LOCAL5 == 1
			LOCAL3 := LOCAL3 + 5
		Case LOCAL5 == 2
			LOCAL2 := LOCAL2 - 10
		Case LOCAL5 == 3
			LOCAL1 := LOCAL1 - 5
		Case LOCAL5 == 4
			LOCAL4 := LOCAL4 + 10
		EndCase
	EndDo
	Set Color To (LOCAL15)
	RestScreen(Nil, Nil, Nil, Nil, LOCAL12)
	SetPos(LOCAL10, LOCAL11)
	Setcursor(LOCAL9)
	Return
*:-------------------------------------------------------

Proc ScrollEsq()
****************
LOCAL i

For i := 1 To 13
	Shift( 0, 0, 24, MaxCol(), -i )
	//   Inkey(.01)
Next
Return

*:-------------------------------------------------------

Proc ScrollDir()
****************
LOCAL i

For i := 1 To 13
	Shift( 0, 0, 24, MaxCol(), i )
	//Inkey(.01)
Next
Return

*:-------------------------------------------------------

Proc CenturyOn()
*****************
Set Cent On
Return

Proc CenturyOff()
****************
Set Cent Off
Return

Function FTempName( xCoringa )
******************************
LOCAL cFile  := ""
LOCAL nConta := 0
LOCAL cTela  := Mensagem("Aguarde, Criando Arquivo Temporario.")

xCoringa := IF( xCoringa = NIL, 'T*.$$$', xCoringa )
cFile 	:= MsTempName( xCoringa )
While File( cFile ) .AND. nConta <= 100
	cFile   := MsTempName( xCoringa )
	nConta++
EndDo
ResTela( cTela )
Return( cFile )

Proc Sx_Filter( xStrTop, xStrBottom )
*************************************
Sx_ClrScope( 0 )
Sx_ClrScope( 1 )
Sx_SetScope( 0, xStrTop )
Sx_SetScope( 1, xStrBottom )
Return

Proc Sx_DbSetFilter( xStrTop, xStrBottom )
******************************************
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
Sx_SetScope( S_TOP, xStrTop )
Sx_SetScope( S_BOTTOM, xStrBottom )
Return

Proc Sx_DbClearFilter()
***********************
Sx_ClrScope( S_TOP )
Sx_ClrScope( S_BOTTOM )
DbGoTop()
Return

Function Sx_Count()
*******************
IF !Eof()
	Return( 1 )
EndIF
Return( 0)

Proc ArrPrinter()
*****************
LOCAL aPrinter := {}
LOCAL nTam
LOCAL nX

Aadd( aPrinter, {'12','FUJITSU DL-700','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'13','SAMSUNG EE-809','#27#18','#27#58','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'14','PROLOGICA P720 XT','#27#18','#27#58','#14','#15','#27#120#49','#27#120#48','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'27','DATAMAX','#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'28','ARGOX','#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'01','EPSON FX-1170','#27#18','#27#58','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'02','EPSON FX-1050','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'03','EPSON LQ-1070','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'04','EPSON LQ-570','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'05','EPSON LX-810','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'06','EPSON LX-300','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'34','EPSON LX-300+','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'20','EPSON FX-2170','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'21','EPSON LQ-2170','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'07','RIMA XT-180','#30#49','#30#50','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'08','CITYZEN GSX-190','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'09','SEIKOSHA','#27#80','#27#77','#14','#15','#27#69','#27#70','#20','#18','#27#45#49','#27#45#48','#27#79','#27#48','#27#50','#27#64#27#70', Date()})
Aadd( aPrinter, {'10','HP DESKJET 500',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'11','HP DESKJET 520',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'15','HP DESKJET 600',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'40','HP DESKJET 656C', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'16','HP DESKJET 660',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'17','HP DESKJET 680',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'18','HP DESKJET 692',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'19','HP DESKJET 693',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'24','HP DESKJET 670',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'25','HP DESKJET 695',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'26','HP DESKJET 610',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'29','HP DESKJET 640',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'30','HP DESKJET 710',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'31','HP DESKJET 740',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'32','HP DESKJET 950',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'33','HP DESKJET 970',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'35','HP DESKJET 840',  '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'38','HP DESKJET 3420', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'39','HP DESKJET 3820', '#27#40#115#49#48#72','#27#40#115#49#50#72','#27#40#115#51#66#27#40#115#54#72','#27#40#115#49#55#72','#27#40#115#51#66','#27#40#115#48#66','#27#40#115#49#48#72','#27#40#115#49#48#72','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'36','HP LASERJET 1100','#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'22','HP LASERJET 5L',  '#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'23','HP LASERJET 6L',  '#27#38#107#48#83',   '#27#40#115#112#72',  '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'37','HP LASERJET 4L',  '#27#38#107#48#83',   '#27#38#107#52#83',   '#27#40#115#51#66#27#40#115#54#72','#27#38#107#50#83','#27#40#115#51#66','#27#40#115#48#66','#27#38#107#48#83','#27#38#107#48#83','#27#38#100#49#68','#27#38#100#64','#27#38#108#48#76','#27#38#108#54#67','#27#38#108#56#67','#27#69', Date()})
Aadd( aPrinter, {'38',' ARQUIVO',        '#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255','#255',Date()})
nTam := Len( aPrinter )
IF Printer->(TravaArq())
  For nX := 1 To nTam
	  Printer->(DbAppend())
	  For nField := 1 To Printer->(FCount())
		  Printer->(FieldPut( nField, aPrinter[nX,nField]))
	  Next
  Next
  Printer->(Libera())
EndIF
Return

Function lAnoBissexto( dData )
******************************
LOCAL nAno := Year( dData )
Return( nAno % 4 == 0 .AND. nAno % 100 != 0)

Function Grafico( aArray, MostraVal, Titulo1, Titulo2, Titulo3, nBase )
***********************************************************************
LOCAL Porc     := 0
LOCAL aNumero  := {}
LOCAL CorBarra := { "W/N",  "G/W",  "BG/W", "R/W", "GR/W", "B/W", "RB/W", "W/N",;
						  "BG+/W", "G/W", "GR+/W", "B+/W",;
						  "W/N",  "G/W",  "BG/W", "R/W", "GR/W", "B/W", "RB/W", "W/N",;
						  "BG+/W", "G/W", "GR+/W", "B+/W" }
LOCAL CorLetra := { "N/W",  "N/G",  "N/BG", "N/R", "N/GR", "N/B", "N/RB", "N/W",;
						  "N/BG+", "N/G+", "N/GR+", "N/B+",;
						  "N/W",  "N/G",  "N/BG", "N/R", "N/GR", "N/B", "N/RB", "N/W",;
						  "N/BG+", "N/G+", "N/GR+", "N/B+" }

LOCAL Tam      := Len(aArray)
LOCAL aChr     := Array(Tam)
LOCAL nMaxRow  := MaxRow()
LOCAL nMaxCol  := MaxCol()
LOCAL Larg     := Round((nMaxCol*.75)/Tam,0)
LOCAL T        := 0
LOCAL Escala   := 0
LOCAL Porc1    := 0
LOCAL Num      := 0
LOCAL Num1     := 0
LOCAL Num2     := 0
LOCAL xY

nBase 	  := IIF( nBase = Nil, 1, nBase )
MostraVal  := IIF( MostraVal = NIL, .F., .T. )
Afill(aChr, Chr(219))
Porc       := aMax( aArray[1])

For xY     := 1 To Tam
	Aadd( aNumero, aArray[ xY, 1 ])
Next xY

Porc   := aMax( aNumero )
Escala := Porc / 10
Porc1  := Porc
Num    := 0
Num1   := 0
Num2   := 0

MaBox(01, 00, nMaxRow-1, nMaxCol, Titulo1 + " - " + Titulo2)
oMenu:StatSup()
oMenu:StatInf()

For nX := 2 To (nMaxRow-4)
   Write( nX, 6, Chr(179))
Next nX

For nY := 2 To (nMaxRow-3) Step 4
   Write( nY, 01, Tran(Int(Porc/nBase), "999999") + Repl(Chr(196),nMaxCol-10))
	Porc -= Escala
Next nY

Write( nX, 6, Chr(192) + Repl(Chr(196),nMaxCol-8))
t := (6-Larg)
For nN := 1 To Tam
   Write(nMaxRow-2, T + Larg + 1, Left( aArray[ nN, 2 ], Larg ) )
   Pos := Int( aArray[nN,1] * (nMaxRow-5) / Porc1 )
   Bar := ( nMaxRow-4 - Pos ) + 1
   For j := nMaxRow-4 To Bar Step -1
      @ j, t + Larg+1 Say Repl(aChr[nN],Larg) Color CorBarra[nN]
	Next J
	IF MostraVal
      @ Bar, t + Larg + ( Larg / 2 )-1 Say Tran(Int( aArray[ nN, 1 ]/nBase), "99999") Color CorLetra[nN]
	EndIF
   t += ( Larg + 1 )
Next nN

/*
IF Titulo1 != NIL
   Write( MaxRow()-1, 00, Padc(Titulo1 + " - " + Titulo2, nMaxCol))
EndIF
IF Titulo3 != NIL
   Write( 00, 00, Padc(Titulo3, nMaxCol))
EndIF
Return Nil
*/

Function Tecla_ESC()
********************
LOCAL cScreen := SaveScreen()

IF Inkey() == ESC
	ErrorBeep()
   Return(Conf("Pergunta: Deseja cancelar?"))
EndIF
Return(FALSO)

FUNCTION nSetColor(std, enh, uns)
*********************************
LOCAL cStd, ;
	   cEnh, ;
		cUns, ;
		cColor

cStd	 := attrtoa(std)
cEnh	 := attrtoa(enh)
cUns	 := attrtoa(uns)
//cColor := setcolor()

Standard(std)
Enhanced(enh)
Unselected(uns)
cColor := cStd + ',' + cEnh + ',,,' + cUns

//cColor := strswap(cColor, "," , 1, cStd)
//cColor := strswap(cColor, "," , 2, cEnh)
//cColor := strswap(cColor, "," , 4, cUns)
Setcolor( cColor )
Return Nil

//******************************************************************************

FUNCTION cSetColor(ColorStr)
****************************
LOCAL nStd, ;
		nEnh, ;
		nUns
		
nStd := atoattr( strextract( ColorStr, ",", 1))
nEnh := atoattr( strextract( ColorStr, ",", 2))
nUns := atoattr( strextract( ColorStr, ",", 4))

/*
* Set FUNCky Colors
*/
Standard(nStd)
Enhanced(nEnh)
Unselected(nUns)

/* Set Clipper Colors */
SetColor( ColorStr )
return Nil

Function NetUse( cBcoDados, lModo, nSegundos, cAlias )
******************************************************
LOCAL cScreen := SaveScreen()
LOCAL nArea   := 0
LOCAL Restart := OK
LOCAL cStr1
LOCAL cStr2
LOCAL cStr3
LOCAL cStr4
LOCAL cStr5
LOCAL cStr6
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
		cStr1 := "#1 Se outra esta??o estiver usando o sistema, finalize-a. ;;"
		cStr2 := "#2 Se outra esta??o estiver indexando, aguarde o t?rmino. ;;"
		cStr3 := "#3 Se SHARE estiver instalado, aumente os par?metros de   ;"
		cStr4 := "   travamento de arquivos. Ex.: SHARE /F:18810 /L:510.    ;;"
		cStr5 := "#4 Em ambiente de rede NOVELL, verifique o arquivo NET.CFG;"
		cStr6 := "   e se necess rio, acrescente a linha FILE HANDLES=127.  ;"
		Alert( cStr1 + cStr2 + cStr3 + cStr4 + cStr5 + cStr6, "W+/B")
		Break
		//Quit
	EndIF
EndDo
Return( FALSO )