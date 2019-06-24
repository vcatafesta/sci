#Include "Lista.Ch"

? CopyCria()

Function CopyCria()
*******************
LOCAL lOk     := FALSO
LOCAL c1      := RomCkSum()
LOCAL String
LOCAL Temp
LOCAL fHandle
LOCAL xArquivo := "SC" + AllTrim( Str( c1 )) + ".PPP"

fHandle := FCreate( xArquivo, 4 )
IF fHandle <> -1
   //lOk := IF( FWrite( fHandle, Str( c1, 8, 0 ), 8 ) = 8, OK, FALSO )
   lOk := IF( FWrite( fHandle, MsCriptar( Str( c1, 8, 0 )), 8 ) = 8, OK, FALSO )
   FClose( fHandle )
EndIF
Return( lOk )

Function MsDCriptar( Pal )
**************************
LOCAL cChave   := ""
LOCAL nX       := 0

For nX := 0 To 10
   cChave += Chr( Asc( Chr( nX )))
Next
Return( Decrypt( Pal, cChave ))

Function MsCriptar( Pal )
*************************
LOCAL cChave   := ""
LOCAL nX       := 0

For nX := 0 To 10
   cChave += Chr( Asc( Chr( nX )))
Next
Return( Encrypt( Pal, cChave ))

