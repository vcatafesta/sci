#Include "Lista.Ch"
#Include "Inkey.Ch"
#Include "Directry.Ch"
#include "box.ch"
#include "achoice.ch"
#include "ctnnet.ch"

Function Main()
***************
LOCAL aMenu   := {" 1- Retorno ate versao 14.99 ", " 2- Retorno a partir da versao 15.00 ", " 3- Com verificacao de Debito"}
LOCAL nVersao := 0

Set Epoch To 1950
Set Date Brit
IF !File('RETORNO.DBF')
   CriaArquivo()
EndIF
Use Retorno New
WHILE .T.
	SetColor("")
	Cls
	SetColor("W+/B")
	DispBox( 04, 09, 07, 76 )
	nChoice := Achoice( 05, 10, 06, 75, aMenu, 31 )
	Do Case
	Case nChoice = 0
		Cls
		Return
  Case nChoice = 1
		Velho()
  Case nChoice = 2
		Novo()
  EndCase
EndDo

Function Novo()
***************
LOCAL cCodigo
LOCAL Data_Limite
LOCAL cExecucoes
LOCAL nNumero
LOCAL nTemp
LOCAL cSenha
LOCAL nCrc
LOCAL cEmpresa
LOCAL nVersao := 2
LOCAL nId	  := 0
LOCAL cCodi   := ''
LOCAL aDia    := {31,28,31,30,31,30,31,31,30,31,30,31}

SetColor("W+/G")
@ 10, 01 Clear To 14, MaxCol()-1
DispBox( 10, 01, 14, MaxCol()-1 )
WHILE OK
	cEmpresa 	:= Space(40)
	cCodigo		:= Space(10)
   cDia        := StrZero(aDia[Month(Date())],2)
   cData       := cDia + '/' +  StrZero(Month(Date())+3,2) +  "/" + StrZero(Year(Date()),4)
	Data_Limite := Ctod( cData )
	cExecucoes	:= Right( StrTran( Time(), ":"),2)
	cExecucoes	+= Right( StrTran( Time(), ":"),2)
	@ 11, 02 Say "Empresa........................:" Get cEmpresa    Pict "@!" Valid CampoVazio( cEmpresa, 2 )
	@ 12, 02 Say "Codigo Interno Fornecido.......:" Get cCodigo     Pict "@R 999.999.9999"
	@ 13, 02 Say "Data Limite de Execucoes.......:" Get Data_Limite Pict "##/##/##"
	Read
	IF LastKey() = ESC
		Return
	EndIF

	// Monte a Senha Para calculo

	cData_Limite := StrTran( Dtoc( Data_Limite ), "/" )
	cSenha		 := cData_Limite + cExecucoes

	// Calcula o Crc

	nCrc := 0
	nX   := 0
	/*
	For Contador := 1 To 10
		nCrc += Val( SubStr( cCodigo, Contador, 1 )) * ;
				  Val( SubStr( cSenha, Contador, 1 )) + ;
				  Val( SubStr( cSenha, Contador, 1 ))
	Next
	*/
	For nX := 1 To 10
		nCrc += Val( SubStr( cSenha,	nX, 1 )) * ;
				  Val( SubStr( cSenha,	nX, 1 )) + ;
				  Val( SubStr( cCodigo, nX, 1 ))
	Next
	cCrc := Right( StrZero( nCrc, 10),3)
	cSenha += cCrc
	Alert( "Codigo de Retorno " + Transform( cSenha, "@R 999.999.999.999.9"))
	Retorno->(DbGoBottom())
	nId := Retorno->Id
	nId++
	IF Retorno->(Incluiu())
		Retorno->Id 	  := nId
		Retorno->Codi	  := cCodi
		Retorno->Empresa := cEmpresa
		Retorno->Interno := cCodigo
		Retorno->Codigo  := cSenha
		Retorno->Limite  := Data_Limite
		Retorno->Data	  := Date()
		Retorno->Versao  := nVersao
		Retorno->Hora	  := Time()
		Retorno->Nome	  := ''
		Retorno->(Libera())
		Return( OK )
	EndIF
EndDo

Function Velho()
****************
LOCAL cCodigo
LOCAL Data_Limite
LOCAL cExecucoes
LOCAL nNumero
LOCAL nTemp
LOCAL cSenha
LOCAL nCrc
LOCAL cEmpresa
LOCAL nVersao := 1
LOCAL nId	  := 0
LOCAL cCodi   := ''
LOCAL aDia    := {31,28,31,30,31,30,31,31,30,31,30,31}

SetColor("W+/R")
@ 10, 01 Clear To 14, MaxCol()-1
DispBox( 10, 01, 14, MaxCol() -1 )
WHILE OK
	cEmpresa 	:= Space(40)
	Ntemp := Val(Strtran(Time(), ":"))
	Seed(Ntemp)
	Ccodigo := ""
	For Nx := 1 To 5
		Nnumero := Random()
		Nnumero := Alltrim(Str(Nnumero))
		Ccodigo := Ccodigo + Left(Nnumero, 2)
	Next
	cCodigo		:= Space(10)
   cDia        := StrZero(aDia[Month(Date())+2],2)
   cData       := cDia + '/' +  StrZero(Month(Date())+2,2) +  "/" + StrZero(Year(Date()),4)
	Data_Limite := Ctod( cData )
	cExecucoes	:= Right( StrTran( Time(), ":"),2)
	cExecucoes	+= Right( StrTran( Time(), ":"),2)
	@ 11, 02 Say "Empresa........................:" Get cEmpresa    Pict "@!" Valid CampoVazio( cEmpresa, 1 )
	@ 12, 02 Say "Codigo Interno Fornecido.......:" Get cCodigo     Pict "@R 999.999.9999"
	@ 13, 02 Say "Data Limite de Execucoes.......:" Get Data_Limite Pict "##/##/##"
	Read
	IF LastKey() = ESC
		Return
	EndIF

	// Monte a Senha Para calculo

	cData_Limite := StrTran( Dtoc( Data_Limite ), "/" )
	cSenha		 := cData_Limite + cExecucoes

	// Calcula o Crc

	nCrc := 0
	For Contador := 1 To 10
		nCrc += Val( SubStr( cCodigo, Contador, 1 )) * ;
				  Val( SubStr( cSenha, Contador, 1 )) + ;
				  Val( SubStr( cSenha, Contador, 1 ))
	Next
	cCrc := Right( StrZero( nCrc, 10),3)
	cSenha += cCrc
	Alert( "Codigo de Retorno " + Transform( cSenha, "@R 999.999.999.999.9"))
	Retorno->(DbGoBottom())
	nId := Retorno->Id
	nId++
	IF Retorno->(Incluiu())
		Retorno->Id 	  := nId
		Retorno->Codi	  := cCodi
		Retorno->Empresa := cEmpresa
		Retorno->Interno := cCodigo
		Retorno->Codigo  := cSenha
		Retorno->Limite  := Data_Limite
		Retorno->Data	  := Date()
		Retorno->Versao  := nVersao
		Retorno->Hora	  := Time()
		Retorno->Nome	  := ''
		Retorno->(Libera())
		Return( OK )
	EndIF
EndDo

Function ErrorBeep()
********************
Tone( 100, 2 )
Return Nil

Function CampoVazio( cEmpresa, nVersao )
****************************************
IF Empty( cEmpresa )
	ErrorBeep()
	Alert("Erro: Favor entrar com o nome do cliente.",, IF( nVersao = 1, "W+/G", "W+/R"))
	Return( FALSO )
EndIF
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

Function Conf( cString )
************************
Return( Alert( cString , { " Sim ", " Nao " } ) )

Proc CriaArquivo()
******************
DbCreate("RETORNO.DBF", {{"ID",         "N", 07, 0 },;
                        {"CODI",       "C", 05, 0 },;
                        {"EMPRESA",    "C", 40, 0 },;
                        {"INTERNO",    "C", 12, 0 },;
                        {"CODIGO",     "C", 13, 0 },;
                        {"HORA",       "C", 08, 0 },;
                        {"VERSAO",     "N", 01, 0 },;
                        {"LIMITE",     "D", 08, 0 },;
                        {"DATA",       "D", 08, 0 },;
                        {"NOME",       "C", 10, 0 },;
                        {"ATUALIZADO", "D", 08, 0 }})
Return

PROC PedePermissao
PROC UsaArquivo
PROC ClientesFiltro
PROC Integridade

