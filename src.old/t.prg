#include "picture.ch"
Function main()

cls
cCodigo := Space(10)

@ 10, 10 say "codigo " get cCodigo pict PIC_SENHA valid codiret( @ccodigo)
read
? valtype( cCodigo )
? ccodigo

cCond   := "00"
nConta  := ChrCount("/", cCond ) + 1
nCond   := Val( StrExtract( cCond,"/", nConta ))


Function codiret( ccodigo)
//ccodigo := Strzero(cCodigo, Len(GetList[1]:picture))
return .t.

Function Protela

function shuffle

