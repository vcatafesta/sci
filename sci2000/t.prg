#include "oclip.ch"

LOCAL o1 := TObjeto("OK")
LOCAL o2 := TObjeto():Create("OK")
LOCAL o3 := TObject("OK")
        o1:Hello()
        o2:Hello()
        o3:Hello()
        RETURN

CLASSE TObject
   VAR Who
   VAR cNome

   METHOD AddVar
   METHOD Create = New
   METHOD Hello
ENDCLASSE

METODO New(cWho)
   ::Who      := cWho
   Self:cNome := "Vilmar"
RETURN Self

METODO Hello
  ? "Hello",Self:Who
  ? "Hello",::cNome
RETURN Self

METODO TObjeto(cWho)
Return(TObject():Create(cWho))
