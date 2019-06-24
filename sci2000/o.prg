#include "classic.ch"

Function Main()

TForm1 := TClasse()
? TForm1:cNome
? TForm1:cEnde
Return

BEGIN CLASS TClass
    Export:
        VAR cNome
        VAR cEnde
	 Export:
		  METHOD Init
End Class

Method procedure Init()
   Self:cNome := "Vilmar"
   Self:cEnde := "Rua"
	Return( Self )

Function TClasse()
   Return( TClass():New())
