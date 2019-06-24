#Include "FILEIO.CH"

Function Main( cFile )
**********************
Cls
Qout("þþþ Lendo ", cFile)
IF DbfProtege( cFile )
  Qout("þþþ Arquivo DesProtegido.")
  Qout("þþþ Protegendo Arquivo.")
  Qout()
  Quit
EndIF
IF DbfDesProtege( cFile )
  Qout("þþþ Arquivo Protegido.")
  Qout("þþþ DesProtegendo Arquivo.")
  Qout()
  Quit
EndIF

Function DbfProtege( cFile )
****************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

IF ValType( cFile ) != "C"
   Return( .F. )
EndIF

Handle := FOpen( cFile, FO_READWRITE )
Qout("þþþ Abrindo Arquivo.")
IF Ferror() != 0
  FClose( Handle )
  Alert("Erro Abertura: " + Str( Ferror()))
  Return( .F. )
EndIF

Qout("þþþ Lendo Arquivo.")
Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
IF Read_Bytes != 1
  FClose( Handle )
  Alert("Erro Leitura: " + Str( Ferror()))
  Return( .F. )
EndIF

IF Asc(Buffer) == 3
  Buffer := Chr(4)
Else
  FClose( Handle )
  Return( .F. )
EndIF
Qout("þþþ Escrevendo no Arquivo.")
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
IF Write_Bytes != 1
  FClose( Handle )
  Alert("Erro Gravacao: " + Str( Ferror()))
  Return( .F. )
EndIF
FClose( Handle )
Return( .T. )

Function DbfDesProtege( cFile )
*******************************
LOCAL Read_Bytes
LOCAL Write_Bytes
LOCAL Handle
LOCAL Buffers

IF ValType( cFile ) != "C"
   Return( .F. )
EndIF

Qout("þþþ Abrindo Arquivo.")
Handle := FOpen( cFile, FO_READWRITE )
IF Ferror() != 0
  FClose( Handle )
  Alert("Erro Abertura: " + Str( Ferror()))
  Return( .F. )
EndIF

Qout("þþþ Lendo Arquivo.")
Buffer := Space(01)
Read_Bytes := FRead( Handle, @Buffer, 1 )
IF Read_Bytes != 1
  FClose( Handle )
  Alert("Erro Leitura: " + Str( Ferror()))
  Return( .F. )
EndIF

IF Asc(Buffer) == 4
  Buffer := Chr(3)
Else
  FClose( Handle )
  Return( .F. )
EndIF
Qout("þþþ Escrevendo no Arquivo.")
FSeek( Handle, 0, 0 )
Write_Bytes := FWrite( Handle, Buffer, 1 )
IF Write_Bytes != 1
  FClose( Handle )
  Alert("Erro Gravacao: " + Str( Ferror()))
  Return( .F. )
EndIF
FClose( Handle )
Return( .T. )
