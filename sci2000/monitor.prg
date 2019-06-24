#Include "Lista.Ch"
#Include "Inkey.Ch"
#Include "RddName.Ch"
#Define   DADOS_ID  1
#Define   BINGO_REG 1


Function Main( cDrive, Visual )
*******************************
LOCAL AtPrompt := {}
LOCAL lOk      := OK
LOCAL oPc      := 1
LOCAL cScreen
LOCAL cTela
PUBLI nChoice
PUBLI oAmbiente := TAmbienteNew()
PUBLI oIni      := TIniNew('MONITOR.INI')
PUBLI oMenu     := TMenuNew()
PUBL XVISUAL    := FALSO
PUBL XFRAME     := "ÚÄ¿³ÙÄÀ³"
PUBL aPermissao := { OK, OK, OK, OK, OK, OK, OK, OK, OK, OK, OK }
PUBL aLpt1      := {}
PUBL aLpt2      := {}
PUBL aLpt3      := {}

Set Scor Off
Set Dele On
Set Key F10 To
Set Cent On
oMenu:PanoFundo   := oIni:ReadString('sistema', 'panofundo', '°±²')
oMenu:Frame       := oIni:ReadString('sistema', 'xframe', XFRAME )
oMenu:CorMenu     := oIni:ReadInteger('sistema', 'cormenu', 31 )
oMenu:CorFundo    := oIni:ReadInteger('sistema', 'corfundo', 32 )
oMenu:CorCabec    := oIni:ReadInteger('sistema', 'corcabec', 75 )
CriaTemp()
AbreArea()
CriaNewPrinter()
AssignPrinter()
WHILE lOk
	SetaClasse()
   Begin Sequence
      Opc  := oMenu:Show()
      Do Case
      Case opc = 0.0 .OR. opc = 1.01
         ErrorBeep()
         IF Conf( "Pergunta: Confirma Saida para o DOS ?")
            Save To MONITOR.CFG
            lOk := FALSO
            Break
         EndIF
      Case opc = 2.01
         nChoice := 1
         Conferencia()
      Case opc = 2.02
         nChoice := 2
         Conferencia()
      Case opc = 2.03
         nChoice := 3
         Conferencia()
      Case opc = 3.01
         DadosInclusao()
      Case opc = 3.02
         DadosAlteracao()
      Case opc = 3.03
         DadosAlteracao()
      Case opc = 3.04
         DadosAlteracao()
      Case opc = 4.03
         Prn_Tres_1()
      Case opc = 4.04
         Prn_Tres_2()
      Case opc = 4.05
         Prn_Tres_3()
      Case opc = 4.06
         Prn_4_1()
      Case opc = 4.08
         Prn_4_3()
      Case oPc = 5.01
         oMenu:SetaCor( 1 )
         oIni:WriteInteger('sistema', 'cormenu', oMenu:CorMenu )
      Case oPc = 5.02
         oMenu:SetaCor( 2 )
         oIni:WriteInteger('sistema', 'corcabec', oMenu:CorCabec )
      Case oPc = 5.03
         oMenu:SetaPano()
         oIni:WriteString('sistema', 'panofundo', oMenu:PanoFundo )
      Case oPc = 5.04
         oMenu:SetaCor( 3 )
         oIni:WriteInteger('sistema', 'corfundo', oMenu:CorFundo )
      EndCase
   End Sequence
EndDo
DbCloseAll()
SetColor("")
Cls
Quit

Proc SetaClasse()
*****************
oMenu:StatusSup := "MicroBras BINGO 2000 Versao 2.2.15 - 26/02/2002"
oMenu:StatusInf := "F2³F3³F10³TAB³DEL³INS³ESC³PGUP³PGDN³*³"
oMenu:NomeFirma := 'MICROBRAS COM DE PROD DE INFORMATICA LTDA'
oMenu:Menu      := oMenuMonitor()
oMenu:Disp      := aDispMonitor()
Return

Proc Conferencia()
******************
LOCAL GetList := {}

Sele Bingo
nMaximo  := Bingo->(LasTrec())
nQuantas := 0
MaBox( 10, 10, 12, 50 )
@ 11, 11 Say "Quantas Cartelas a Conferir ? " Get nQuantas Pict "99999" Valid nQuantas > 0 .AND. nQuantas <= nMaximo
Read
IF LastKey() = 27
   Return
EndIF
oMenu:Limpa()
Mensagem("Aguarde. Carregando Arrays.", Cor())
PUBLI aUm          := {}
PUBLI aDois        := {}
PUBLI aTres        := {}
aQuatro      := {}
nPosRegistro := 0
Bingo->(DbGoTop())
While Bingo->(!Eof()) .AND. nPosRegistro <= nQuantas
   nPosRegistro++
   IF nPosRegistro <= 4096
      Aadd( aUm, Bingo->Numero )
   ElseIF nPosRegistro >= 4096 .AND. nPosRegistro <= 8192
      Aadd( aDois, Bingo->Numero )
   ElseIF nPosRegistro >= 8192 .AND. nPosRegistro <= 12288
      Aadd( aTres, Bingo->Numero )
   ElseIF nPosRegistro >= 12288 .AND. nPosRegistro <= 16384
      Aadd( aQuatro, Bingo->Numero )
   EndIF
   Bingo->(DbSkip(1))
EndDo
oMenu:Limpa()
Status()
Sele Bingo  // Inde On Numero To Bingo
Pack
Sele Numero
Inde On Numero To Numero
aColuna1 := {"NUMERO"}
aColuna2 := {"N§"}
SetColor("")
DbEdit( 06, 01, 22, 06, aColuna1, "TabFunc", OK, aColuna2 )
Cls
Return

Function TabFunc( Modo, ponteiro )
**********************************
LOCAL nConta     := 0
LOCAL Pos_Cursor := aColuna1[ Ponteiro ]
LOCAL Arq_Ant    := Alias()
LOCAL Ind_Ant    := IndexOrd()
LOCAL cTela

Do Case
Case Modo = 1 .OR. Modo = 2 // Topo/Fim de Arquivo
   Return(1)

Case Modo < 4
   Return(1)

Case LastKey() = ESC
   Return(0)

Case LastKey() = TECLA_DELETE
   ErrorBeep()
   IF Conf("Pergunta: Confirma Exclusao ?")
      Numero->(DbDelete())
   EndIF
   Keyb Chr( K_CTRL_PGUP )
   Return(1)

Case LastKey() = K_CTRL_Q
   ErrorBeep()
   IF Conf("Pergunta: Confirma Exclusao Geral ?")
      Numero->(__DbZap())
   EndIF
   Keyb Chr( K_CTRL_PGUP )
   Return(1)

Case LastKey() = ASTERISTICO
   Numero->(DbGoTop())
   WHILE Numero->(!Eof())
      nConta++
      Numero->(DbSkip(1))
   EndDo
   Alert( "Numeros Cantados : " + StrZero( nConta,2))
   Numero->(DbGoTop())
   Return(1)

Case LastKey() = K_TAB
   Outro()
   Return(1)

Case LastKey() = TECLA_INSERT
   Numero->(DbAppend())
   nRegistro := Numero->(Recno())
   cNumero := Space(02)
   @ Row(), Col() Get cNumero Pict "99" COLOR "W+/G" Valid JahTem( cNumero )
   Read
   Numero->(DbGoTo( nRegistro ))
   IF LastKey() = ESC
      Numero->(DbDelete())
       Keyb Chr( K_CTRL_PGDN )
      Return(1)
   EndIF
   Numero->Numero := cNumero
   Keyb Chr( K_CTRL_PGDN )
   Return( 1 )

Case LastKey() = F2 // Reindexar Temp
   cTela := Mensagem("Aguarde, Reindexando Cartelas Ganhadoras.")
   Sele Temp
   Reindex
   AreaAnt( Arq_Ant, Ind_Ant )
   ResTela( cTela )
   Return(1)

Case LastKey() = F3 // Teste de Conferencia
   TesteConferencia()
   Return(1)

Case LastKey() = F10
   IF nChoice = 1
      Cheia()
   ElseIF nChoice = 2
      Quina()
   ElseIF nChoice = 3
      PrimeiraQuina()
   EndIF
   Return(1)

Otherwise
   Return(1)
EndCase

Function JahTem( cNumero )
*************************
IF Numero->(DbSeek( cNumero ))
   Alert("Jah Tem.")
   Return( FALSO )
EndIF
Return( OK )

Proc Outro()
************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cColor  := SetColor()

Sele Bingo
aColuna1 := {"NUMERO"}
aColuna2 := {"CARTELAS"}
SetColor("W+/G")
DbEdit( 06, 08, 22, 79, aColuna1, OK, OK, aColuna2 )
SetColor( cColor )
Sele ( Arq_Ant )
DbSetOrder( Ind_Ant )

Proc CriaTemp()
***************
DbCreate("Temp.Dbf", {{"NUMERO", "C", 78, 0 }})
IF !File("NUMERO.DBF")
   DbCreate("NUMERO.DBF", {{"NUMERO", "C", 02, 0 }})
EndIF
IF !File("DADOS.DBF")
   DbCreate('DADOS.DBF', {{"ID",       "N", 02, 0 },;
                          {"NOME",     "C", 60, 0 },;
                          {"NOME1",    "C", 60, 0 },;
                          {"PROMOCAO", "C", 40, 0 },;
                          {"LOCAL",    "C", 30, 0 },;
                          {"DATA",     "D", 08, 0 },;
                          {"HORA",     "C", 05, 0 },;
                          {"VALOR",    "N", 08, 2 },;
                          {"PREMIO1",  "C", 20, 0 },;
                          {"PREMIO2",  "C", 20, 0 },;
                          {"PREMIO3",  "C", 20, 0 },;
                          {"PATROC1",  "C", 80, 0 },;
                          {"PATROC2",  "C", 80, 0 },;
                          {"PATROC3",  "C", 80, 0 },;
                          {"PATROC4",  "C", 80, 0 },;
                          {"PATROC5",  "C", 80, 0 },;
                          {"ATUALIZADO","D", 08, 0 }})
EndIf
IF !File("PRINTER.DBF")
   DbCreate('PRINTER.DBF',{{ "CODI",      "C", 02, 0 },;
                           { "NOME",      "C", 30, 0 },;
                           { "_CPI10",    "C", 30, 0 },;
                           { "_CPI12",    "C", 30, 0 },;
                           { "GD",        "C", 30, 0 },;
                           { "PQ",        "C", 30, 0 },;
                           { "NG",        "C", 30, 0 },;
                           { "NR",        "C", 30, 0 },;
                           { "CA",        "C", 30, 0 },;
                           { "C18",       "C", 30, 0 },;
                           { "LIGSUB",    "C", 30, 0 },;
                           { "DESSUB",    "C", 30, 0 },;
                           { "_SALTOOFF", "C", 30, 0 },;
                           { "_SPACO1_8", "C", 30, 0 },;
                           { "_SPACO1_6", "C", 30, 0 },;
                           { "RESETA",    "C", 30, 0 },;
                           { "ATUALIZADO", "D", 08, 0 }})
EndIF
Return

Function CodiOrigin()
*********************
Return NIL

Proc Enviroment( cDrive )
*************************
Qout("þ Carregando Configuracao.")
IF cDrive = NIL
   cDrive := FCurdir()
Else
   IF At(":\", cDrive ) = 0 .OR. !IsDir( cDrive ) .OR. Len( Alltrim( cDrive )) <= 3
      ErrorBeep()
      IF Conf("Pergunta: Drive " + cDrive + " invalido. Usar o corrente ?")
         cDrive := FCurdir()
      Else
         Quit
      EndIF
   EndIF
EndIF
#Include "Ambiente.Prg"

Function Quina() // Localiza Combinacao em Vertical e Horizontal
****************
LOCAL cScreen := SaveScreen()
LOCAL cString := ""
LOCAL aString := {}
LOCAL nConta  := 0
LOCAL nCol    := 12
LOCAL nRow    := 08

Sele Temp
Mensagem("Please, Aguarde. Procurando Combinacoes. Sequencia N§       ", 31, 06 )
MaBox( 11, 07, 22, 79)
Numero->(DbGoTop())
WHILE Numero->(!Eof())
   Aadd( aString, Numero->Numero )
   Numero->(DbSkip(1))
   nConta++
EndDo

IF nConta < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Os Numeros Jogados Sao Insuficientes...")
   Return
EndIF
// Primeira Sequencia
nVerifica := 0
For nX := 1 To 15
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 01 a 15.")
   Return
EndIF

// Segunda Sequencia
nVerifica := 0
For nX := 16 To 30
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 16 a 30.")
   Return
EndIF

// Terceira Sequencia
nVerifica := 0
For nX := 31 To 45
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 31 a 45.")
   Return
EndIF

// Quarta Sequencia
nVerifica := 0
For nX := 46 To 60
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 46 a 60.")
   Return
EndIF

// Quinta Sequencia
nVerifica := 0
For nX := 61 To 75
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 61 a 75.")
   Return
EndIF
nPelaBoa := 0
nUm      := Len( aUm )
For a := 1 To nUm
   cTemp := aUm[a]
   cNovo := aUm[a]
   nSoma := 0
   Write( 08, 66, StrZero( a,5))
   For nY := 1 To 5 // Quina
      nSoma := 0
      /*
      // Procura Vertical
      IF nY = 1
         cTemp := Left( cTemp, 14 ) +
      ElseIF nY = 2
         cTemp := SubStr( cTemp, 16, 14 )
      ElseIF nY = 3
         cTemp := SubStr( cTemp, 31, 14 )
      ElseIF nY = 4
         cTemp := SubStr( cTemp, 46, 14 )
      ElseIF nY = 5
         cTemp := SubStr( cTemp, 61, 14 )
      EndIF
      */

      // Procura Horizontal
      cTemp1 := cNovo
      IF nY = 1
         cTemp := SubStr( cTemp1, 01, 03 ) + ;
                  SubStr( cTemp1, 16, 03 ) + ;
                  SubStr( cTemp1, 31, 03 ) + ;
                  SubStr( cTemp1, 46, 03 ) + ;
                  SubStr( cTemp1, 61, 03 )
      ElseIF nY = 2
         cTemp := SubStr( cTemp1, 04, 03 ) + ;
                  SubStr( cTemp1, 19, 03 ) + ;
                  SubStr( cTemp1, 34, 03 ) + ;
                  SubStr( cTemp1, 49, 03 ) + ;
                  SubStr( cTemp1, 64, 03 )
      ElseIF nY = 3
         cTemp := SubStr( cTemp1, 07, 03 ) + ;
                  SubStr( cTemp1, 22, 03 ) + ;
                  SubStr( cTemp1, 37, 03 ) + ;
                  SubStr( cTemp1, 52, 03 ) + ;
                  SubStr( cTemp1, 67, 03 )
      ElseIF nY = 4
         cTemp := SubStr( cTemp1, 10, 03 ) + ;
                  SubStr( cTemp1, 25, 03 ) + ;
                  SubStr( cTemp1, 40, 03 ) + ;
                  SubStr( cTemp1, 55, 03 ) + ;
                  SubStr( cTemp1, 70, 03 )
      ElseIF nY = 5
         cTemp := SubStr( cTemp1, 13, 03 ) + ;
                  SubStr( cTemp1, 28, 03 ) + ;
                  SubStr( cTemp1, 43, 03 ) + ;
                  SubStr( cTemp1, 58, 03 ) + ;
                  SubStr( cTemp1, 73, 03 )
      EndIF
      For x := 1 To nConta
         cString := aString[x]
         IF cString $ cTemp
            nSoma++
         EndIF
         IF nSoma >= 5
            Write( nCol, nRow, StrZero( a, 5 ))
            Bingo->(DbGoto( a ))
            Sele Temp
            DbAppend()
            Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
            nSoma := 0
            nRow += 6
         EndIF
      Next
   Next
   IF nSoma = 4
      nPelaBoa++
   EndiF
Next

nDois := Len( aDois )
For a := 1 To nDois
   cTemp := aDois[a]
   cNovo := aDois[a]
   nSoma := 0
   Write( 08, 66, StrZero( a+nUm, 5))
   For nY := 1 To 5 // Quina
      nSoma := 0
      /*
      // Procura Vertical
      IF nY = 1
         cTemp := Left( cTemp, 14 ) +
      ElseIF nY = 2
         cTemp := SubStr( cTemp, 16, 14 )
      ElseIF nY = 3
         cTemp := SubStr( cTemp, 31, 14 )
      ElseIF nY = 4
         cTemp := SubStr( cTemp, 46, 14 )
      ElseIF nY = 5
         cTemp := SubStr( cTemp, 61, 14 )
      EndIF
      */

      // Procura Horizontal
      cTemp1 := cNovo
      IF nY = 1
         cTemp := SubStr( cTemp1, 01, 03 ) + ;
                  SubStr( cTemp1, 16, 03 ) + ;
                  SubStr( cTemp1, 31, 03 ) + ;
                  SubStr( cTemp1, 46, 03 ) + ;
                  SubStr( cTemp1, 61, 03 )
      ElseIF nY = 2
         cTemp := SubStr( cTemp1, 04, 03 ) + ;
                  SubStr( cTemp1, 19, 03 ) + ;
                  SubStr( cTemp1, 34, 03 ) + ;
                  SubStr( cTemp1, 49, 03 ) + ;
                  SubStr( cTemp1, 64, 03 )
      ElseIF nY = 3
         cTemp := SubStr( cTemp1, 07, 03 ) + ;
                  SubStr( cTemp1, 22, 03 ) + ;
                  SubStr( cTemp1, 37, 03 ) + ;
                  SubStr( cTemp1, 52, 03 ) + ;
                  SubStr( cTemp1, 67, 03 )
      ElseIF nY = 4
         cTemp := SubStr( cTemp1, 10, 03 ) + ;
                  SubStr( cTemp1, 25, 03 ) + ;
                  SubStr( cTemp1, 40, 03 ) + ;
                  SubStr( cTemp1, 55, 03 ) + ;
                  SubStr( cTemp1, 70, 03 )
      ElseIF nY = 5
         cTemp := SubStr( cTemp1, 13, 03 ) + ;
                  SubStr( cTemp1, 28, 03 ) + ;
                  SubStr( cTemp1, 43, 03 ) + ;
                  SubStr( cTemp1, 58, 03 ) + ;
                  SubStr( cTemp1, 73, 03 )
      EndIF
      For x := 1 To nConta
         cString := aString[x]
         IF cString $ cTemp
            nSoma++
         EndIF
         IF nSoma >= 5
            Write( nCol, nRow, StrZero( a+nUm, 5 ))
            Bingo->(DbGoto( a ))
            Sele Temp
            DbAppend()
            Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
            nSoma := 0
            nRow += 6
         EndIF
      Next
   Next
   IF nSoma = 4
      nPelaBoa++
   EndiF
Next

Sele Temp
DbGoTop()
MaBox( 01, 00, 03, 79 )
Write( 02, 01, "Cartelas que estao pela boa : " + StrZero( nPelaBoa, 5 ))
Browse( 04, 00, 23, 79)
Sele Numero
ResTela( cScreen )
Return NIL

Function PrimeiraQuina() // Localiza Combinacao da Primeira Carreira Horizontal
************************
LOCAL cScreen := SaveScreen()
LOCAL cString := ""
LOCAL aString := {}
LOCAL nConta  := 0
LOCAL nCol    := 12
LOCAL nRow    := 08

Sele Temp
Mensagem("Please, Aguarde. Procurando Combinacoes. Sequencia N§       ", 31, 06 )
MaBox( 11, 07, 22, 79)
Numero->(DbGoTop())
WHILE Numero->(!Eof())
   Aadd( aString, Numero->Numero )
   Numero->(DbSkip(1))
   nConta++
EndDo

IF nConta < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Os Numeros Jogados Sao Insuficientes...")
   Return
EndIF
// Primeira Sequencia
nVerifica := 0
For nX := 1 To 15
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 01 a 15.")
   Return
EndIF

// Segunda Sequencia
nVerifica := 0
For nX := 16 To 30
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 16 a 30.")
   Return
EndIF

// Terceira Sequencia
nVerifica := 0
For nX := 31 To 45
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 31 a 45.")
   Return
EndIF

// Quarta Sequencia
nVerifica := 0
For nX := 46 To 60
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 46 a 60.")
   Return
EndIF

// Quinta Sequencia
nVerifica := 0
For nX := 61 To 75
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 1
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 61 a 75.")
   Return
EndIF
nPelaBoa := 0
nUm      := Len( aUm )
For a := 1 To nUm
   cTemp := aUm[a]
   cNovo := aUm[a]
   nSoma := 0
   Write( 08, 66, StrZero( a,5))
   cTemp1 := cNovo
   cTemp := SubStr( cTemp1, 01, 03 ) + ;
            SubStr( cTemp1, 16, 03 ) + ;
            SubStr( cTemp1, 31, 03 ) + ;
            SubStr( cTemp1, 46, 03 ) + ;
            SubStr( cTemp1, 61, 03 )
   For x := 1 To nConta
      cString := aString[x]
      IF cString $ cTemp
         nSoma++
      EndIF
      IF nSoma >= 5
         Write( nCol, nRow, StrZero( a, 5 ))
         Bingo->(DbGoto( a ))
         Sele Temp
         DbAppend()
         Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
         nSoma := 0
         nRow += 6
      EndIF
   Next
   IF nSoma = 4
      nPelaBoa++
   EndiF
Next

nDois := Len( aDois )
For a := 1 To nDois
   cTemp := aDois[a]
   cNovo := aDois[a]
   nSoma := 0
   Write( 08, 66, StrZero( a+nUm, 5))
   nSoma := 0
   cTemp1 := cNovo
   cTemp := SubStr( cTemp1, 01, 03 ) + ;
            SubStr( cTemp1, 16, 03 ) + ;
            SubStr( cTemp1, 31, 03 ) + ;
            SubStr( cTemp1, 46, 03 ) + ;
            SubStr( cTemp1, 61, 03 )
   For x := 1 To nConta
      cString := aString[x]
      IF cString $ cTemp
         nSoma++
      EndIF
      IF nSoma >= 5
         Write( nCol, nRow, StrZero( a+nUm, 5 ))
         Bingo->(DbGoto( a ))
         Sele Temp
         DbAppend()
         Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
         nSoma := 0
         nRow += 6
      EndIF
   Next
   IF nSoma = 4
      nPelaBoa++
   EndiF
Next

Sele Temp
DbGoTop()
MaBox( 01, 00, 03, 79 )
Write( 02, 01, "Cartelas que estao pela boa : " + StrZero( nPelaBoa, 5 ))
Browse( 04, 00, 23, 79)
Sele Numero
ResTela( cScreen )
Return NIL

Function Dos()
Function Comandos()
Function SalvaMem()
Function CriaaRquivo()
Function UsaArquivo()
Function PrintErerr()

Proc PedePermissao()

Proc Status()
*************
oMenu:StatSup()
oMenu:StatInf()
Return


Function TesteConferencia()
***************************
LOCAL GetList := {}
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL cScreen := SaveScreen()
LOCAL nReg    := 0
LOCAL nX      := 0

oMenu:Limpa()
MaBox( 10, 10, 12, 40 )
@ 11, 11 Say "Numero da Cartela..:" Get nReg Pict "9999" Valid AchaReg( nReg )
Read
IF LastKey() = ESC
   AreaAnt( Arq_Ant, Ind_Ant )
   ResTela( cScreen )
   Return
EndIF
Area("Numero")
Bingo->(DbGoTo( nReg ))
For nX := 1 To 75 Step 3
   cNumero := SubStr( Bingo->Numero, nX, 2 )
   IF Numero->(!DbSeek( cNumero ))
      Numero->(DbAppend())
      Numero->Numero := cNumero
   EndIF
Next
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )
Return

Function AchaReg( nReg )
************************
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()

Area("Bingo")
Bingo->(DbGoTo( nReg ))
IF Bingo->(Recno()) == nReg
   AreaAnt( Arq_Ant, Ind_Ant )
   Return( OK )
EndIF
AreaAnt( Arq_Ant, Ind_Ant )
ErrorBeep()
Alerta("Erro: Numero nao Localizado.")
Return( FALSO )

Proc Integridade()
Proc ClientesFi()

Function oMenuMonitor()
***********************
LOCAL AtPrompt := {}
AADD( AtPrompt, {"Encerrar",    {"Encerrar Sessao "}})
AADD( AtPrompt, {"Conferencia", {"Cartela Cheia","Quina","Quina 1¦"}})
AADD( AtPrompt, {"Dados",       {"Inclusao", "Alteracao", "Consulta", "Exclusao"}})
AADD( AtPrompt, {"Impressao",   {"1 Premio","2 Premio","3 Premio Versao 1", "3 Premio Versao 2","3 Premio Versao 3",'1 Premio Versao 4','2 Premios Versao 4','3 Premios Versao 4','4 Premios Versao 4'}})
AADD( AtPrompt, {"Config",      {"Cor Menu","Cor Cabecalho","Pano de Fundo","Cor Pano Fundo"}})
Return( AtPrompt )

Function aDispMonitor()
**********************
LOCAL aDisp 	 := {}
LOCAL lRet		 := FALSO

Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG, DES, LIG,	LIG,	LIG,	LIG,	LIG,	LIG,	LIG, LIG, DES, LIG,	LIG,	LIG	})
Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG, LIG, LIG,	LIG,	LIG,	LIG,	LIG,	LIG,	LIG, LIG, DES, LIG,	LIG,	LIG	})
Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,	LIG,	LIG,	LIG,	LIG,	LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, DES, LIG,  LIG,  LIG, LIG	})
Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,  LIG,  LIG,  LIG,  LIG,  LIG, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, DES, LIG,  LIG,  LIG, LIG  })
Aadd( aDisp,{ LIG,  LIG,  LIG,  LIG,  LIG ,  LIG,  LIG,  LIG,  LIG,  LIG, LIG,  DES, LIG,  LIG,  LIG,  LIG,  LIG,  LIG,  LIG, LIG, DES, LIG,  LIG,  LIG, LIG  })
Return( aDisp )

Proc DadosInclusao()
********************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nRow    := 05
LOCAL nCol    := 02
LOCAL cNome
LOCAL cNome1
LOCAL cPromocao
LOCAL cLocal
LOCAL dData
LOCAL nValor
LOCAL cPremio1
LOCAL cPremio2
LOCAL cPremio3
LOCAL cPatroc1
LOCAL cPatroc2
LOCAL cPatroc3
LOCAL cPatroc4
LOCAL cPatroc5
LOCAL nId

oMenu:Limpa()
Area("Numero")
WHILE OK
   Dados->(DbGoBottom())
   nId       := Dados->Id + 1
   cNome     := Space(60)
   cNome1    := Space(60)
   cPromocao := Space(40)
   cLocal    := Space(30)
   dData     := Ctod("")
   cHora     := Space(05)
   nValor    := 0
   cPremio1  := Space(20)
   cPremio2  := Space(20)
   cPremio3  := Space(20)
   cPatroc1  := Space(80)
   cPatroc2  := Space(80)
   cPatroc3  := Space(80)
   cPatroc4  := Space(80)
   cPatroc5  := Space(80)
   MaBox( 04, 01, 20, 78 )
   @ nRow,    nCol Say "Id..........:" Get nId       Pict "##" Valid JaExiste( @nId )
   @ Row()+1, nCol Say "Nome Bingo..:" Get cNome     Pict "@!"
   @ Row()+1, nCol Say "Nome Bingo1.:" Get cNome1    Pict "@!"
   @ Row()+1, nCol Say "Promocao....:" Get cPromocao Pict "@!"
   @ Row()+1, nCol Say "Local.......:" Get cLocal    Pict "@!"
   @ Row()+1, nCol Say "Data........:" Get dData     Pict "##/##/####"
   @ Row(),   40   Say "Horas.......:" Get cHora     Pict "##:##"
   @ Row()+1, nCol Say "Valor.......:" Get nValor    Pict "99999.99"
   @ Row()+1, nCol Say "Premio1.....:" Get cPremio1  Pict "@!"
   @ Row()+1, nCol Say "Premio2.....:" Get cPremio2  Pict "@!"
   @ Row()+1, nCol Say "Premio3.....:" Get cPremio3  Pict "@!"
   @ Row()+1, nCol Say "Linha Patr1.:" Get cPatroc1  Pict "@S60"
   @ Row()+1, nCol Say "Linha Patr2.:" Get cPatroc2  Pict "@S60"
   @ Row()+1, nCol Say "Linha Patr3.:" Get cPatroc3  Pict "@S60"
   @ Row()+1, nCol Say "Linha Patr4.:" Get cPatroc4  Pict "@S60"
   @ Row()+1, nCol Say "Linha Patr5.:" Get cPatroc5  Pict "@S60"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   If Conf("Pergunta: Deseja Incluir ?")
      Dados->(DbAppend())
      Dados->Id       := nId
      Dados->Nome     := cNome
      Dados->Nome1    := cNome1
      Dados->Promocao := cPromocao
      Dados->Local    := cLocal
      Dados->Data     := dData
      Dados->Hora     := cHora
      Dados->Valor    := nValor
      Dados->Premio1  := cPremio1
      Dados->Premio2  := cPremio2
      Dados->Premio3  := cPremio3
      Dados->Patroc1  := cPatroc1
      Dados->Patroc2  := cPatroc2
      Dados->Patroc3  := cPatroc3
      Dados->Patroc4  := cPatroc4
      Dados->Patroc5  := cPatroc5
   EndIF
EndDo
Return

Proc DadosAlteracao()
*********************
LOCAL Arq_Ant	:= Alias()
LOCAL Ind_Ant	:= IndexOrd()
LOCAL cScreen	:= SaveScreen()
LOCAL oBrowse	:= MsBrowse():New()

oMenu:Limpa()
Area("Dados")
Dados->(DbGoTop())
oBrowse:Add( "ID",        "Id",        "##")
oBrowse:Add( "NOME",      "Nome",      "@!")
oBrowse:Add( "PROMOCAO",  "Promocao",  "@!")
oBrowse:Add( "LOCAL",     "Local",     "@!")
oBrowse:Add( "DATA",      "Data",      "##/##/####")
oBrowse:Add( "HORA",      "Hora",      "##:##")
oBrowse:Add( "VALOR",     "Valor",     "99999.99")
oBrowse:Titulo := "CONSULTA/ALTERACAO DE DADOS"
oBrowse:PreDoGet := {|| OK }
oBrowse:PosDoGet := {|| OK }
oBrowse:PreDoDel := {|| OK }
oBrowse:PosDoDel := {|| OK }
oBrowse:Show()
oBrowse:Processa()
AreaAnt( Arq_Ant, Ind_Ant )
ResTela( cScreen )

Function JaExiste( nId )
************************
IF Dados->(DbSeek( nId ))
   Dados->(DbGoBottom())
   nId := Dados->Id + 1
   ErrorBeep()
   Alerta("Erro: Id Invalido.")
   Return( FALSO )
EndIF
Return( OK )

Function IdErrado( nId )
************************
LOCAL aRotina          := {{||DadosInclusao()}}
LOCAL aRotinaAlteracao := {{||DadosAlteracao()}}

IF Dados->(!DbSeek( nId ))
   Dados->(Escolhe( 03, 00, 22,"Str(Id) + 'Ý' + Nome", "ID NOME", aRotina,, aRotinaAlteracao ))
   nId := Dados->Id
   Return( OK )
EndIF
Return( OK )

Function AchaCartela( cCartela )
********************************
IF Bingo->(!DbSeek( cCartela ))
   Bingo->(Escolhe( 03, 00, 22,"Reg", "REGISTRO",NIL,NIL,NIL))
   cCartela := Bingo->Reg
EndIF
Return( OK )

Proc CriaNewPrinter()
*********************
LOCAL cTela   := Mensagem("Aguarde, Verificando Arquivos.", WARNING, _LIN_MSG )
cTela := Mensagem("Verificando: PRINTER.DBF")
Area("Printer")
Printer->(__DbZap())
ArrPrinter()
ResTela( cTela )
Return

Proc FechaTudo()
****************
DbCloseAll()


Proc AssignPrinter()
********************
Printer->(Order( 1 ))
Printer->(DbSeek('02'))
Aadd( aLpt1, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
               Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
               Printer->_Spaco1_6, Printer->Reseta })
Aadd( aLpt2, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
               Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
               Printer->_Spaco1_6, Printer->Reseta })
Aadd( aLpt3, { Printer->Codi, Printer->Nome, Printer->_Cpi10, Printer->_Cpi12, Printer->Gd, Printer->Pq, Printer->Ng, Printer->Nr, ;
               Printer->Ca, Printer->c18, Printer->LigSub, Printer->DesSub, Printer->_SaltoOff, Printer->_Spaco1_8, ;
               Printer->_Spaco1_6, Printer->Reseta })

Return

Proc Prn_Tres_1()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId  := 0
   cIni := Space(04)
   cFim := Space(04)
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "99"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "9999" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "9999" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   FPrInt( Chr(ESC) + "C" + Chr( 36 ))
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Write( 00, 00, "")
      Write( 00, 03, "NOME:" + Repl("_",40))
      Write( 00, 62, "CARTELA N§ : " + Bingo->Reg )
      Write( 01, 03, "ENDE:" + Repl("_",40))
      Write( 01, 62, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))

      Write( 05, 00, Chr(14) + Padc(AllTrim( Dados->Nome), 40 ))
      Write( 08, 15, Dados->Promocao )
      Write( 10, 15, Dados->Local )
      Write( 10, 65, Bingo->Reg )
      Write( 11, 15, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 11, 65, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      nPos   := 01
      nCol   := 15
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 3
            Write( nCol, nRow01, SubStr(Bingo->Numero, nPos+01, 02 ))
            Write( nCol, nRow02, SubStr(Bingo->Numero, nPos+16, 02 ))
            Write( nCol, nRow03, SubStr(Bingo->Numero, nPos+31, 02 ))
            Write( nCol, nRow04, SubStr(Bingo->Numero, nPos+46, 02 ))
            Write( nCol, nRow05, SubStr(Bingo->Numero, nPos+61, 02 ))
            nRow01 += 30
            nRow02 += 30
            nRow03 += 30
            nRow04 += 30
            nRow05 += 30
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      Write( nCol, 32, Dados->Premio2 )
      Write( nCol, 61, Dados->Premio3 )
      nCol++
      Write( ++nCol, 01, AllTrim(Dados->Patroc1) + ' ' + Bingo->Numero )
      Write( ++nCol, 01, AllTrim(Dados->Patroc2))
      Write( ++nCol, 01, AllTrim(Dados->Patroc3))
      Write( ++nCol, 01, AllTrim(Dados->Patroc4))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo

Proc Prn_Tres_2()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId := 0
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "##"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "####" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "####" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   FPrInt( Chr(ESC) + "C" + Chr( 36 ))
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Fprint("")
      Write( 00, 00, "")
      Write( 00, 03, "NOME:" + Repl("_",40))
      Write( 00, 56, "CARTELA N§ : " + Bingo->Reg )
      Write( 01, 03, "ENDE:" + Repl("_",40))
      Write( 01, 56, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))

      Write( 05, 00, Chr(14) + Padc(AllTrim( Dados->Nome), 40 ))
      Write( 08, 15, Dados->Promocao )
      Write( 10, 15, Dados->Local )
      Write( 10, 59, Bingo->Reg )
      Write( 11, 15, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 11, 59, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      nPos   := 01
      nCol   := 15
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 3
            Write( nCol, nRow01, SubStr(Bingo->Numero, nPos+01, 02 ))
            Write( nCol, nRow02, SubStr(Bingo->Numero, nPos+16, 02 ))
            Write( nCol, nRow03, SubStr(Bingo->Numero, nPos+31, 02 ))
            Write( nCol, nRow04, SubStr(Bingo->Numero, nPos+46, 02 ))
            Write( nCol, nRow05, SubStr(Bingo->Numero, nPos+61, 02 ))
            nRow01 += 27
            nRow02 += 27
            nRow03 += 27
            nRow04 += 27
            nRow05 += 27
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      Write( nCol, 29, Dados->Premio2 )
      Write( nCol, 55, Dados->Premio3 )
      nCol++
      FPrint("")
      Write( ++nCol, 01, AllTrim(Dados->Patroc1) + ' ' + Bingo->Numero )
//    Write( ++nCol, 01, AllTrim(Dados->Patroc1))
      Write( ++nCol, 01, AllTrim(Dados->Patroc2))
      Write( ++nCol, 01, AllTrim(Dados->Patroc3))
      Write( ++nCol, 01, AllTrim(Dados->Patroc4))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo

Function Cheia()
****************
LOCAL cScreen := SaveScreen()
LOCAL cString := ""
LOCAL aString := {}
LOCAL nConta  := 0
LOCAL nCol    := 12
LOCAL nRow    := 08

Sele Temp
Temp->(__DbZap())
Mensagem("Please, Aguarde. Procurando Combinacoes. Sequencia N§       ", 31, 06 )
MaBox( 11, 07, 22, 79)
Numero->(DbGoTop())
WHILE Numero->(!Eof())
   Aadd( aString, Numero->Numero )
   Numero->(DbSkip(1))
   nConta++
EndDo
IF nConta <= 24
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Os Numeros Jogados Sao Insuficientes...")
   Return
EndIF

// Primeira Sequencia
nVerifica := 0
For nX := 1 To 15
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 01 a 15.")
   Return
EndIF

// Segunda Sequencia
nVerifica := 0
For nX := 16 To 30
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 16 a 30.")
   Return
EndIF

// Terceira Sequencia
nVerifica := 0
For nX := 31 To 45
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 31 a 45.")
   Return
EndIF

// Quarta Sequencia
nVerifica := 0
For nX := 46 To 60
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 46 a 60.")
   Return
EndIF

// Quinta Sequencia
nVerifica := 0
For nX := 61 To 75
   IF Ascan( aString, StrZero( nX, 02 )) != 0
      nVerifica++
   EndIF
Next
IF nVerifica < 5
   ResTela( cScreen )
   Sele Numero
   ErrorBeep()
   Alert("Faltam Sequencia de 61 a 75.")
   Return
EndIF
nPelaBoa := 0
nUm := Len( aUm )
For a := 1 To nUm
   cTemp := aUm[a]
   nSoma := 0
   Write( 08, 66, StrZero( a,5))
   For x := 1 To nConta
      cString := aString[x]
      IF cString $ cTemp
         nSoma++
      EndIF
      IF nSoma = 24
         nPelaBoa++
      EndIF
      IF nSoma >= 25
         Write( nCol, nRow, StrZero( a, 5 ))
         Bingo->(DbGoto( a ))
         Sele Temp
         Temp->(DbAppend())
         Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
         nSoma := 0
         nRow += 6
      EndIF
   Next
Next
nDois := Len( aDois )
For b := 1 To nDois
   cTemp := aDois[b]
   nSoma := 0
   Write( 08, 66, StrZero( b+nUm,5))
   For x := 1 To nConta
      cString := aString[x]
      IF cString $ cTemp
         nSoma++
      EndIF
      IF nSoma = 24
         nPelaBoa++
      EndIF
      IF nSoma >= 25
         Write( nCol, nRow, StrZero( b+nUm, 5 ))
         Bingo->(DbGoto( b+nUm ))
         Sele Temp
         Temp->(DbAppend())
         Temp->Numero := Bingo->(StrZero( Recno(),5)) + " " + Bingo->Numero
         nSoma := 0
         nRow += 6
      EndIF
   Next
Next
Sele Temp
Temp->(DbGoTop())
MaBox( 01, 00, 03, 79 )
Write( 02, 01, "Cartelas que estao pela boa : " + StrZero( nPelaBoa, 5 ))
Browse( 04, 00, 23, 79)
Sele Numero
ResTela( cScreen )
Return NIL

Proc AbreArea()
***************
oMenu:Limpa()
Mensagem("Aguarde, Indexando Arquivos.")
Use Dados New
Inde On Dados->Id To Dados1
Use Printer New
Inde On Printer->Codi To Printer1
Inde On Printer->Nome To Printer2
Use Temp New
Inde On Temp->Numero To Temp1
Use Numero New
Use Bingo New
//Inde On Bingo->Reg To Bingo1

Proc Prn_Tres_3()
*****************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId := 0
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "##"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "####" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "####" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   FPrInt( Chr(ESC) + "C" + Chr( 36 ))
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Fprint("")
      Write( 00, 00, "")
      Write( 00, 03, "NOME:" + Repl("_",40))
      Write( 00, 56, "CARTELA N§ : " + Bingo->Reg )
      Write( 01, 03, "ENDE:" + Repl("_",25) + "FONE:" + Repl("_",10))
      Write( 01, 56, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))

      Write( 04, 00, CHR(ESC) + CHR(69) + Padc(AllTrim( Dados->Nome  ), 80 ) + CHR(27) + CHR(70))
      Write( 05, 00, CHR(ESC) + CHR(69) + Padc(AllTrim( Dados->Nome1 ), 80 ) + CHR(27) + CHR(70))
      Write( 08, 15, Dados->Promocao )
      Write( 10, 15, Dados->Local )
      Write( 10, 59, Bingo->Reg )
      Write( 11, 15, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 11, 59, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      nPos   := 01
      nCol   := 15
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 3
            Write( nCol, nRow01, SubStr(Bingo->Numero, nPos+01, 02 ))
            Write( nCol, nRow02, SubStr(Bingo->Numero, nPos+16, 02 ))
            Write( nCol, nRow03, SubStr(Bingo->Numero, nPos+31, 02 ))
            Write( nCol, nRow04, SubStr(Bingo->Numero, nPos+46, 02 ))
            Write( nCol, nRow05, SubStr(Bingo->Numero, nPos+61, 02 ))
            nRow01 += 27
            nRow02 += 27
            nRow03 += 27
            nRow04 += 27
            nRow05 += 27
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      Write( nCol, 29, Dados->Premio2 )
      Write( nCol, 55, Dados->Premio3 )
      nCol++
      FPrint("")
      cString2 := Dados->Patroc2
      cString3 := Dados->Patroc3
      cString4 := Dados->Patroc4
      cString5 := Dados->Patroc5
      cNumero  := Bingo->Numero
      cChar    := Repl('*',(124-Len(cNumero))/2)
      cBingo   := cChar + cNumero + cChar
      Write( ++nCol, 03, Padc( cBingo,  124))
      Write( ++nCol, 03, Padc( AllTrim( cString2 ),124))
      Write( ++nCol, 03, Padc( AllTrim( cString3 ),124))
      Write( ++nCol, 03, Padc( AllTrim( cString4 ),124))
      Write( ++nCol, 03, Padc( AllTrim( cString5 ),124))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo

Proc Prn_4_2()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId := 0
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "##"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "####" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "####" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela  := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   //FPrInt( Chr(ESC) + "C" + Chr( 36 ))
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Fprint( Chr(18))
      Write( 00, 00, "")
      Write( 01, 03, "NOME:" + Repl("_",40))
      Write( 01, 56, "CARTELA N§ : " + Bingo->Reg )
      Write( 02, 03, "ENDE:" + Repl("_",40))
      Write( 02, 56, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))
      Write( 03, 03, "FONE:" + Repl("_",40))

      Write( 08, 00, Chr(14) + Padc(AllTrim( Dados->Nome), 40 ))
      Write( 11, 15, Dados->Promocao )
      Write( 13, 15, Dados->Local )
      Write( 13, 64, Bingo->Reg )
      Write( 14, 15, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 14, 64, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      nPos   := 01
      nCol   := 20
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 3
            Write( nCol, nRow01, SubStr(Bingo->Numero, nPos+01, 02 ))
            Write( nCol, nRow02, SubStr(Bingo->Numero, nPos+16, 02 ))
            Write( nCol, nRow03, SubStr(Bingo->Numero, nPos+31, 02 ))
            Write( nCol, nRow04, SubStr(Bingo->Numero, nPos+46, 02 ))
            Write( nCol, nRow05, SubStr(Bingo->Numero, nPos+61, 02 ))
            nRow01 += 27
            nRow02 += 27
            nRow03 += 27
            nRow04 += 27
            nRow05 += 27
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      Write( nCol, 29, Dados->Premio2 )
      Write( nCol, 55, Dados->Premio3 )
      nCol++
      FPrint("")
      Write( ++nCol, 01, AllTrim(Dados->Patroc1) + ' ' + Bingo->Numero )
//    Write( ++nCol, 01, AllTrim(Dados->Patroc1))
      Write( ++nCol, 01, AllTrim(Dados->Patroc2))
      Write( ++nCol, 01, AllTrim(Dados->Patroc3))
      Write( ++nCol, 01, AllTrim(Dados->Patroc4))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo

Proc Prn_4_1()
*******************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId := 0
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "##"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "####" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "####" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela  := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Fprint( Chr(18))
      Write( 00, 00, "")
      Write( 01, 03, "NOME:" + Repl("_",40))
      Write( 01, 56, "CARTELA N§ : " + Bingo->Reg )
      Write( 02, 03, "ENDE:" + Repl("_",40))
      Write( 02, 56, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))
      Write( 03, 03, "FONE:" + Repl("_",40))

      Write( 08, 01, Chr(14) + Padc(AllTrim( Dados->Nome), 37 ))
      Write( 11, 14, Dados->Promocao )
      Write( 13, 14, Dados->Local )
      Write( 13, 64, Bingo->Reg )
      Write( 14, 14, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 14, 64, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      // Primeira Carreira
      nPos   := 01
      nCol   := 20
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 2
            IF nY = 1
               cString1 := SubStr(Bingo->Numero, nPos+01, 02 )
               cString2 := SubStr(Bingo->Numero, nPos+16, 02 )
               cString3 := SubStr(Bingo->Numero, nPos+31, 02 )
               cString4 := SubStr(Bingo->Numero, nPos+46, 02 )
               cString5 := SubStr(Bingo->Numero, nPos+61, 02 )
            Else
               cString1 := 'XX'
               cString2 := 'XX'
               cString3 := 'XX'
               cString4 := 'XX'
               cString5 := 'XX'
            EndIF
            Write( nCol, nRow01, cString1 )
            Write( nCol, nRow02, cString2 )
            Write( nCol, nRow03, cString3 )
            Write( nCol, nRow04, cString4 )
            Write( nCol, nRow05, cString5 )
            nRow01 += 54
            nRow02 += 54
            nRow03 += 54
            nRow04 += 54
            nRow05 += 54
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      nCol++

      // Segunda Carreira
      nCol   += 06
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 2
            cString1 := 'XX'
            cString2 := 'XX'
            cString3 := 'XX'
            cString4 := 'XX'
            cString5 := 'XX'
            Write( nCol, nRow01, cString1 )
            Write( nCol, nRow02, cString2 )
            Write( nCol, nRow03, cString3 )
            Write( nCol, nRow04, cString4 )
            Write( nCol, nRow05, cString5 )
            nRow01 += 54
            nRow02 += 54
            nRow03 += 54
            nRow04 += 54
            nRow05 += 54
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      nCol ++
      FPrint("")
      Write( ++nCol, 01, Padc( '#####' + Bingo->Numero + '#####', 128 ))
      Write( ++nCol, 01, Padc( '***** Se Houver mais de um ganhador o premio sera dividido entre os mesmos *****', 128 ))
      Write( ++nCol, 01, Padc( '+++++ CARTELAS EM BRANCO E/OU RASURADAS NAO TERAO VALIDADE +++++', 128 ))
      nCol += 2
      Write( ++nCol, 03, AllTrim(Dados->Patroc1))
      Write( ++nCol, 03, AllTrim(Dados->Patroc2))
      Write( ++nCol, 03, AllTrim(Dados->Patroc3))
      Write( ++nCol, 03, AllTrim(Dados->Patroc4))
      Write( ++nCol, 03, AllTrim(Dados->Patroc5))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo

Proc Prn_4_3()
**************
LOCAL GetList := {}
LOCAL cScreen := SaveScreen()
LOCAL nId     := 0
LOCAL cIni    := Space(04)
LOCAL cFim    := Space(04)

Area('Bingo')
Inde On Bingo->Reg To Bingo1
WHILE OK
   oMenu:Limpa()
   nId := 0
   MaBox( 10, 10, 14, 40 )
   @ 11, 11 Say "Id..............." Get nId  Pict "##"   Valid IdErrado( @nId )
   @ 12, 11 Say "Cartela Inicial.." Get cIni Pict "####" Valid AchaCartela( @cIni )
   @ 13, 11 Say "Cartela Final...." Get cFim Pict "####" Valid AchaCartela( @cFim ) .AND. IF( cFim < cIni, ( ErrorBeep(), Alerta("Erro: Cartela tem que ser maior ou igual Inicial"), FALSO ), OK )
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF !Instru80() .OR. !LptOk()
      Restela( cScreen )
      Return
   EndIF
   Dados->(Order( DADOS_ID ))
   Dados->(DbSeek( nId ))
   IF Dados->(!DbSeek( nId ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   Bingo->(Order( BINGO_REG ))
   IF Bingo->(!DbSeek( cIni ))
      ErrorBeep()
      Alerta("Erro: Favor reindexar o sistema.")
      Loop
   EndIF
   oBloco := {|| Bingo->Reg >= cIni .AND. Bingo->Reg <= cFim }
   cTela  := Mensagem("Aguarde, Imprimindo Cartelas.")
   PrintOn()
   WHILE Eval( oBloco ) .AND. Rep_Ok()
      Fprint( Chr(18))
      Write( 00, 00, "")
      Write( 01, 03, "NOME:" + Repl("_",40))
      Write( 01, 56, "CARTELA N§ : " + Bingo->Reg )
      Write( 02, 03, "ENDE:" + Repl("_",40))
      Write( 02, 56, "VALOR R$   : " + AllTrim(Tran( Dados->Valor, "@E 999.99")))
      Write( 03, 03, "FONE:" + Repl("_",40))
      Write( 07, 01, Chr(14) + Padc(AllTrim( Dados->Nome), 37 ))
      Write( 08, 01, Chr(14) + Padc(AllTrim( Dados->Nome1), 37 ))
      FPrint('E')
      Write( 11, 14, Dados->Promocao )
      FPrint('F')
      Write( 13, 14, Dados->Local )
      Write( 13, 64, Bingo->Reg )
      Write( 14, 14, Dtoc(Dados->Data) + ' as ' + Dados->Hora + 'H')
      Write( 14, 64, AllTrim(Tran( Dados->Valor, "@E 999.99")))

      // Primeira Carreira
      nCol   := 20
      nPos   := 00
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 2
            cString1 := SubStr(Bingo->Numero, nPos+01, 02 )
            cString2 := SubStr(Bingo->Numero, nPos+16, 02 )
            cString3 := SubStr(Bingo->Numero, nPos+31, 02 )
            cString4 := SubStr(Bingo->Numero, nPos+46, 02 )
            cString5 := SubStr(Bingo->Numero, nPos+61, 02 )
            Write( nCol, nRow01, cString1 )
            Write( nCol, nRow02, cString2 )
            Write( nCol, nRow03, cString3 )
            Write( nCol, nRow04, cString4 )
            Write( nCol, nRow05, cString5 )
            nRow01 += 54
            nRow02 += 54
            nRow03 += 54
            nRow04 += 54
            nRow05 += 54
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio1 )
      Write( nCol, 55, Dados->Premio2 )
      nCol++

      // Segunda Carreira
      nPos   := 00
      nCol   += 06
      For nX := 1 To 5
         nRow01 := 02
         nRow02 := 06
         nRow03 := 10
         nRow04 := 14
         nRow05 := 18
         For nY := 1 To 2
            IF nY = 1
               cString1 := SubStr(Bingo->Numero, nPos+01, 02 )
               cString2 := SubStr(Bingo->Numero, nPos+16, 02 )
               cString3 := SubStr(Bingo->Numero, nPos+31, 02 )
               cString4 := SubStr(Bingo->Numero, nPos+46, 02 )
               cString5 := SubStr(Bingo->Numero, nPos+61, 02 )
            Else
               cString1 := 'XX'
               cString2 := 'XX'
               cString3 := 'XX'
               cString4 := 'XX'
               cString5 := 'XX'
            EndIF
            Write( nCol, nRow01, cString1 )
            Write( nCol, nRow02, cString2 )
            Write( nCol, nRow03, cString3 )
            Write( nCol, nRow04, cString4 )
            Write( nCol, nRow05, cString5 )
            nRow01 += 54
            nRow02 += 54
            nRow03 += 54
            nRow04 += 54
            nRow05 += 54
         Next nY
         nCol += 2
         nPos += 03
      Next nX
      Write( nCol, 01, Dados->Premio3 )
      nCol++
      FPrint("")
      Write( ++nCol, 01, Padc( '#####' + Bingo->Numero + '#####', 128 ))
      Write( ++nCol, 01, Padc( '***** Se Houver mais de um ganhador o premio sera dividido entre os mesmos *****', 128 ))
      Write( ++nCol, 01, Padc( '+++++ CARTELAS EM BRANCO E/OU RASURADAS NAO TERAO VALIDADE +++++', 128 ))
      nCol += 2
      Write( ++nCol, 03, Padc( AllTrim(Dados->Patroc1),128))
      Write( ++nCol, 03, Padc( AllTrim(Dados->Patroc2),128))
      Write( ++nCol, 03, Padc( AllTrim(Dados->Patroc3),128))
      Write( ++nCol, 03, Padc( AllTrim(Dados->Patroc4),128))
      Write( ++nCol, 03, Padc( AllTrim(Dados->Patroc5),128))
      __Eject()
      Bingo->(DbSkip(1))
   EndDo
   PrintOff()
EndDo
