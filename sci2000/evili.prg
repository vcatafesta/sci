Function Main()
***************
Local GetList  := {}
Local cNome    := "EVILI"
Local cEnde    := "PIMENTA BUENO"
Local aPessoa  := {cNome, cEnde, "RO" }
Local aPessoas := {{cNome, cEnde, "RO"}, {"VILMAR", "ROLIM", "SP"}}
Local n

Cls
? "Hello, " + SubStr(cNome,2,3) + "MAR"
? "Mora em, " + cEnde

? aPessoa[1]
? aPessoa[2]
? aPessoa[3]

For n := 1 To Len( aPessoas )
   ? n,1, aPessoas[n,1]
   ? n,2, aPessoas[n,2]
   ? n,3, aPessoas[n,3]
Next

For n := 1 To Len( aPessoas )
   @ 20, 10 Say "Nome: " Get aPessoas[n,1]
   @ 21, 10 Say "Cida: " Get aPessoas[n,2]
   @ 22, 10 Say "Esta: " Get aPessoas[n,3]
   Read
Next


For n := 1 To Len( aPessoas )
   MostraNome( aPessoas[n,1])
   MostraNome( aPessoas[n,2])
   MostraNome( aPessoas[n,3])
Next

Return( aPessoas)

Function MostraNome( cParametro )
*********************************
Qout( cParametro )
Return( NIL )
