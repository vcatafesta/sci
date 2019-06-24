#include "classic.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"
#Include "FileIO.Ch"
#Include "rddname.Ch"
#Define  OK      .T.
#Define  FALSO   .F.

BEGIN CLASS TProtege
Export:
	 VAR Protegido
	 VAR Erro
	 VAR Ferror
	 VAR MsgErro
	 VAR Rotina
    VAR Proteger
    VAR Arquivos
    VAR File
Export:
	 METHOD Init
    METHOD Protege
    METHOD Encryptar
    METHOD Decryptar
    METHOD DesProtege
Hidden:
    MESSAGE Add METHOD TAddProtege
End Class

METHOD PROCEDURE Init()
***********************
::Protegido := FALSO
::Erro		:= FALSO
::Ferror 	:= 0
::MsgErro   := ""
::Rotina 	:= ""
::Proteger  := OK
::File      := ""
::Arquivos := {}
Return( Self )

METHOD TAddProtege()
********************
IF Ascan( ::Arquivos, ::File ) = 0
   Aadd( ::Arquivos, ::File )
EndIF
Return( Self )

METHOD Encryptar( cFile )
*************************
    Use ( cFile ) New
    //Sx_DBFencrypt( '63771588')
    ::Protegido := OK
    Return(Self)

METHOD Decryptar( cFile )
*************************
    Use ( cFile ) New
    //Use ( cFile ) PASSWORD '63771588' New
    //Sx_DBFdecrypt()
    ::Protegido := FALSO
    Return(Self)

METHOD Protege( cFile )
**********************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers
LOCAL nPos

IF ::Proteger == FALSO
   Return( Self )
EndIF

::File := cFile
IF ( nPos := Ascan( ::Arquivos, ::File )) <> 0
   Adel( ::Arquivos, nPos )
EndIf

::Rotina := "TProtege.Protege"
IF ValType( cFile ) != "C"
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO NAO LOCALIZADO"
	Return( Self )
EndIF

Handle := FOpen( cFile, FO_READWRITE )
IF Ferror() != 0
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= Ferror()
	::MsgErro	:= "ERRO DE ABERTURA DE :" + cFile
	Return( Self )
EndIF

Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
IF Read_Bytes != 1
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE LEITURA DE :" + cFile
	Return( Self )
EndIF

IF Asc(Buffer) == 3
  Buffer := Chr(4)
Else
	FClose( Handle )
	::Protegido := OK
	::Erro		:= FALSO
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO JA PROTEGIDO :" + cFile
	Return( Self )
EndIF
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
IF Write_Bytes != 1
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE GRAVACAO :" + cFile
	Return( Self )
EndIF
FClose( Handle )
::Protegido := OK
::Erro		:= FALSO
::Ferror 	:= 0
::MsgErro	:= "SUCESSO NA PROTECAO DO ARQUIVO :" + cFile
Return( Self )

METHOD DesProtege( cFile )
**************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

::File := cFile
IF Ascan( ::Arquivos, ::File ) <> 0
   Return( Self )
EndIF
::Rotina := "TProtege.DesProtege"
IF ValType( cFile ) != "C"
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO NAO LOCALIZADO"
	Return( Self )
EndIF

Handle := FOpen( cFile, FO_READWRITE )
IF Ferror() != 0
	FClose( Handle )
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= Ferror()
	::MsgErro	:= "ERRO DE ABERTURA DE :" + cFile
	Return( Self )
EndIF

Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
IF Read_Bytes != 1
	FClose( Handle )
	::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ERRO DE LEITURA DE :" + cFile
	Return( Self )
EndIF

IF Asc(Buffer) == 4
  Buffer := Chr(3)
Else
	FClose( Handle )
	::Protegido := FALSO
	::Erro		:= OK
	::Ferror 	:= 0
	::MsgErro	:= "ARQUIVO JA DESPROTEGIDO :" + cFile
	Return( Self )
EndIF
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
IF Write_Bytes != 1
	FClose( Handle )
   ::Protegido := OK
	::Erro		:= OK
	::Ferror 	:= 0
   ::MsgErro   := "ERRO DE GRAVACAO DE :" + cFile
	Return( Self )
EndIF
FClose( Handle )
::Protegido := FALSO
::Erro      := FALSO
::Ferror    := 0
::MsgErro   := "SUCESSO NA DESPROTECAO DO ARQUIVO :" + cFile
Aadd( ::Arquivos, ::File )
Return( Self )

Function TProtegeNew()
**********************
Return( TProtege():New())
