#include "hbclass.ch"
#Include "box.ch"
#Include "inkey.ch"
#Include "common.ch"
#Include "translate.ch"
#xcommand PUBLIC:           =>    nScope := HB_OO_CLSTP_EXPORTED ; HB_SYMBOL_UNUSED( nScope )

#Define S_TOP               0
#Define S_BOTTOM            1
#Define FALSO               .F.
#Define OK                  .T.
#Define ESC                  K_ESC
#define SETA_CIMA 			  5
#define SETA_BAIXO			  24
#define SETA_ESQUERDA		  19
#define SETA_DIREITA 		  4
#define TECLA_SPACO			  32
#define TECLA_ALT_F4 		  -33
#define ENABLE 				  .T.
#define DISABLE				  .F.
#DEFINE CURSOR 				  { || Setcursor(IIf( Readinsert(!Readinsert()), 1, 2 )) }
#DEFINE ALTERACAO_PERMITIDA  .T.
#DEFINE ALTERACAO_NEGADA	  .F.

CLASS MsBrowse FROM TBrowse
		Export:
         Var Titulo
         Var Topo
         Var Esquerda
         Var Baixo
         Var Direita
         Var PreDoGet
         Var PosDoGet
         Var PreDoDel
         Var PosDoDel
         Var KeyHotKey
         Var Registro
         Var Deletado
         Var Alterado

		Export:
        Method  New CONSTRUCTOR
		  Method  Processa
		  Method  Doget
		  Method  FreshOrder
		  Method  Skipped
		  Method  Show
        Method  ExitKey
        Method  TrocaChave
        Method  SeekChave
        Method  FiltraChave
        Method  ForceStable
        Method  InsToggle
        MESSAGE Add METHOD TAdd
        Method  HotKey
		  METHOD DupReg(cAlias, cCampo, nOrder)
End Class

Method New( nLint, nColt, nLinB, nColb )
**************************************************
   LOCAL cFrame2     := SubStr( oAmbiente:Frame, 2, 1 )
   LOCAL cFrame3     := SubStr( oAmbiente:Frame, 3, 1 )
   LOCAL cFrame4     := SubStr( oAmbiente:Frame, 4, 1 )
   LOCAL cFrame6     := SubStr( oAmbiente:Frame, 6, 1 )

   ::Titulo    := "CONSULTA/ALTERACAO"
   ::Topo      := 00
   ::Esquerda  := 00
   ::Baixo     := MaxRow()-4
   ::Direita   := MaxCol()
   ::PreDoGet  := NIL         // Procedimento do Usuario Antes de Editar o Registro
   ::PosDoGet  := NIL         // Procedimento do Usuario Apos Editar o Registro
   ::PreDoDel  := NIL         // Procedimento do Usuario Antes de Excluir o Registro
   ::PosDoDel  := NIL         // Procedimento do Usuario Apos Excluir o Registro
   ::KeyHotKey := NIL         // Procedimento do Usuario Para Tecla de Atalho
   ::nTop      := IF( nLint = NIL, ::Topo+1,     nLint )
   ::nLeft     := IF( nColt = NIL, ::Esquerda+1, nColt )
   ::nRight    := IF( nColb = NIL, ::Direita-1,  nColb )
   ::nBottom   := IF( nLinb = NIL, ::Baixo-1,    nLinb )
   ::HeadSep   := cFrame2 + cFrame3 + cFrame2
   ::ColSep    := Chr(032) + cFrame4 + Chr(032)
   ::FootSep   := cFrame2  + cFrame2 + cFrame2
   ::Topo      := ::nTop
   ::Esquerda  := ::nLeft
   ::Baixo     := ::nBottom
   ::Direita   := ::nRight
   ::Registro  := 0
   ::Deletado  := NIL
   ::Alterado  := NIL
Return( Self )

Method Show
************
   MaBox( ::Baixo+2, ::Esquerda-1, ::Baixo+5, ::Direita+1,"OPCOES")
   Write( ::Baixo+3, 01, "[-+]Alterar  [F2]Localizar [F3]Filtrar  [CTRL+INSERT]Ins Campo [A-Z]Localizar")
   Write( ::Baixo+4, 01, "[ESC]Encerrar [F6]Ordem     [F4]Duplicar [CTRL+DELETE]Esc Campo [DEL]Excluir")
   MaBox( ::Topo-1, ::Esquerda-1, ::Baixo+1, ::Direita+1, ::Titulo )
   Seta1( ::Baixo+1 )
Return( Self )

Method TAdd( cNome, cField, cPicture, cAlias )
**********************************************
   LOCAL oCol

   IF Valtype( cField ) = 'B'
      oCol := TBColumnNew( cNome, cField )
   Else
      IF cAlias = NIL
         oCol := TBColumnNew( cNome,  FieldBlock( FieldName( FieldPos( cField ))))
      Else
         oCol := TBColumnNew( cNome,  FieldWBlock( FieldName( FieldPos( cField )), Select( cAlias )))
      EndIF
   EndIF
   IF cPicture != NIL
      oCol:Picture := cPicture
   EndIF
   ::AddColumn( oCol )
Return( Self )


Method Processa()
*****************
   LOCAL cScreen  := SaveScreen()
   LOCAL Local3   := OK
   LOCAL Local5   := FALSO
   LOCAL Local6   := FALSO
   LOCAL LOCAL8   := Setcursor(0)
   LOCAL LOCAL9   := FALSO
   LOCAL aCampos  := {}
   LOCAL nKey
   LOCAL cCombinado := ""

   ::skipBlock( { |x| ::Skipped( x, Local5 ) })
   ::ForceStable()
   If ( LastRec() == 0 )
      nKey := 24
      LOCAL9 := .T.
   Else
      LOCAL9 := .F.
   EndIf
   LOCAL3 := .T.
   Do While ( LOCAL3 )
      If ( !LOCAL9 )
         ::ForceStable()
      EndIf
      If ( !LOCAL9 )
         If ( ::Hitbottom() .AND. ( !LOCAL5 .OR. RecNo()  !=  LastRec() + 1 ) )
            If ( LOCAL5 )
               ::Refreshcurrent()
               ::ForceStable()
               Goto Bottom
            Else
               LOCAL5 := .T.
               Setcursor(IIf( Readinsert(), 2, 1 ))
            EndIf
            ::Down()
            ::ForceStable()
            ::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
         EndIf
         ::ForceStable()
         nKey := InKey(0)
         If ( ( cRotina := SetKey(nKey) )  !=  Nil )
            Eval( cRotina, Procname(1), Procline(1), "")
            Loop
         EndIf
         IF ::KeyHotKey != NIL
            nHot := Len( ::KeyHotKey )
            IF ( nPos := Ascan( ::KeyHotKey, { |oBloco|oBloco[1] = nKey })) != 0
               Eval( ::KeyHotKey[nPos,2])
               Loop
            EndIF
         EndIF
      Else
         LOCAL9 := .F.
      EndIf
      do case
      case nKey == K_F6
         ::TrocaChave()
         ::refreshCurrent():forceStable()
         ::up():forceStable()
         ::Freshorder()

      case nKey == K_F2
         SetCursor(1)
         ::SeekChave()
         ::FreshOrder()
         SetCursor(0)

      case nKey == K_F3
         SetCursor(1)
         ::FiltraChave()
         ::FreshOrder()
         SetCursor(0)

      case nKey == K_CTRL_INS
         cTela := SaveScreen()
         oMenu:Limpa()
         M_Title("INSERIR COLUNAS")
         nChoice := FazMenu( 10, 10, {" Individual", " Combinado", " Todos " })
         nLen  := FCount()
         IF nChoice = 0
            ResTela( cTela )
            Loop
         ElseIF nChoice = 1
            For i := 1 To nLen
               cString := FieldName( i )
               Aadd( aCampos, cString )
            Next
            oMenu:Limpa()
            MaBox( 01, 10, 23, 50, "ESCOLHA O CAMPO",, Roloc( Cor()))
            n  := Achoice( 02, 11, 22, 39, aCampos )
            IF n = 0
               ResTela( cTela )
               Loop
            EndIF
            oColuna := TBColumnNew( field( n ), FieldWBlock( field( n ), select() ) )
            ::InsColumn( ::ColPos, oColuna )

         ElseIF nChoice = 2
            SetCursor(1)
            oMenu:Limpa()
            cCombinado := Space(50)
            MaBox( 10, 05, 13, 70, "ENTRE COM A SEQUENCIA",, Roloc( Cor()))
            @ 12, 06 Say "Combinacao :" Get cCombinado
            Read
            IF !LastKey() = ESC
               oColuna := TBColumnNew( AllTrim( cCombinado ) , {|| &cCombinado. })
               ::InsColumn( ::ColPos, oColuna )
            EndIF
            SetCursor(0)

         ElseIF nChoice = 3
            For i := 1 To nLen
               oColuna := TBColumnNew( field( i ), FieldWBlock( field( i ), select() ) )
               ::InsColumn( ::ColPos, oColuna )
            Next
          EndIF
          ResTela( cTela )

      case nKey == K_CTRL_DEL
         ErrorBeep()
         IF ::ColCount = 1
            Alerta("Erro: Nao se pode Excluir a Ultima Coluna")
         Else
            IF Conf("Pergunta: Esconder a Coluna ?" )
               oPos := ::ColPos
               ::DelColumn( ::ColPos )
            EndIF
        EndIF

      case nKey == K_F10
         ::Freeze := ::ColPos

      Case nKey == 24
         If ( LOCAL5 )
            ::Hitbottom(.T.)
         Else
            ::Down()
         EndIf
      Case nKey == 5
         If ( LOCAL5 )
            LOCAL6 := .T.
         Else
            ::Up()
         EndIf
      Case nKey == 3
         If ( LOCAL5 )
            ::Hitbottom(.T.)
         Else
            ::Pagedown()
         EndIf
      Case nKey == 18
         If ( LOCAL5 )
            LOCAL6 := .T.
         Else
            ::Pageup()
         EndIf

      Case nKey == K_CTRL_PGUP
		   DbGotop()     // 07.08.2016
		   If ( LOCAL5 )
            LOCAL6 := .T.
         Else
            ::Gotop()
         EndIf
      Case nKey == K_CTRL_PGDN
		   DbGoBottom() // 07.08.2016
		   If ( LOCAL5 )
            LOCAL6 := .T.
         Else
            ::Gobottom()
         EndIf
			
		Case nKey == 4
         ::Right()
      Case nKey == 19
         ::Left()
      Case nKey == 1
         ::Home()
      Case nKey == 6
         ::End()
      Case nKey == 26
         ::Panleft()
      Case nKey == 2
         ::Panright()
      Case nKey == 29
         ::Panhome()
      Case nKey == 23
         ::Panend()
      Case nKey == 22
         If ( LOCAL5 )
            Eval( CURSOR )
         EndIf
      Case nKey == K_DEL
         IF !PodeExcluir()
            ErrorBeep()
            Alerta("Erro: Exclusao nao Permitida")
            Loop
         EndIF
         IF ::PreDoDel != NIL
            IF !Eval( ::PreDoDel )
               Loop
            EndIF
         EndIF
         IF PodeExcluir()
            ErrorBeep()
            IF Conf("Pergunta: Excluir Registro Sob o Cursor ?")
               IF TravaReg()
                  If ( RecNo()  !=  LastRec() + 1 )
                     If ( Deleted() )
                        ::Deletado := NIL
                        DbRecall()
                     Else
                        ::Deletado := OK
                        DbDelete()
                     EndIf
                     ::refreshCurrent():forceStable()
                     ::up():forceStable()
                     ::Freshorder()
                     Libera()
                  EndIf
               EndIf
            EndIf
         EndIF
         IF ::PosDoDel != NIL
            Eval( ::PosDoDel )
         EndIF

      Case nKey == K_RETURN
         oCol := ::getColumn( ::colPos )
			//xValue := Eval( oCol:block )
			//cType  := ValType( xValue )
			
			if oCol:Heading = "ID"
			   ErrorBeep()
            Alerta("ERRO;;Campo de autoincremento.;Alteracao nao Permitida!")
            Loop
         EndIF
			
         IF !PodeAlterar()
            ErrorBeep()
            Alerta("Erro: Alteracao nao Permitida")
            Loop
         EndIF
         If ( LOCAL5 .OR. RecNo()  !=  LastRec() + 1 )
            SetCursor(1)
            nKey    := ::Doget( LOCAL5)
            LOCAL9  := nKey  !=  0
            SetCursor(0)
         Else
            nKey := 24
            LOCAL9 := .T.
         EndIf

      Case nKey == 27
         LOCAL3 := .F.
      Otherwise
         If ( nKey >= 32 .AND. nKey <= 255 )
            SetCursor(1)
            Keyb Chr(nKey)
            ::SeekChave()
            ::FreshOrder()
            SetCursor(0)
            //Keyboard Chr(13) + Chr(nKey)
         EndIf
      EndCase
      If ( LOCAL6 )
         LOCAL6 := .F.
         LOCAL5 := .F.
         ::Freshorder()
         Setcursor(0)
      EndIf
   EndDo
   Setcursor(LOCAL8)
   RestScreen( cScreen )
Return( Self )

Method TrocaChave()
*******************
   LOCAL cScreen := SaveScreen()
   LOCAL aArray  := {}
   LOCAL nX      := 1
   LOCAL nChoice := 0
   LOCAL nMaximo := 12
   LOCAL cString := ""
   LOCAL nAntigo := IndexOrd()

   For nX := 1 To nMaximo
      IF !Empty(( cIndice := IndexKey( nX )))
         Aadd( aArray, Upper(IndexKey( nX )))
      EndIF
   Next
   Aadd( aArray, "Natural" )
   M_Title("ESCOLHA A ORDEM")
   nChoice := FazMenu( 02, 02, aArray, Cor())
   IF nChoice = 0
      Order( nAntigo )
      ResTela( cScreen )
      Return
   EndIF
   cString := aArray[ nChoice ]
   IF cString = "Natural"
      Order( 0 )
   Else
      Order( nChoice )
   EndIF
   ResTela( cScreen )
Return( Self )

Method SeekChave()
******************
   LOCAL cScreen := SaveScreen()
   LOCAL cProcura

   IF Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      Return
   EndIF
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
   cProcura := FieldGet(FieldPos( IndexKey()))
   IF cProcura = NIL
      cProcura := Space(40)
   EndIF
   @ 11, 11 Say "Procurar por : " Get cProcura Pict "@K!"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   EndIF
   DbSeek( cProcura )
   Restela( cScreen )
Return( Self )

Method FiltraChave()
********************
   LOCAL cScreen := SaveScreen()
   LOCAL cProcura

   IF Empty( IndexKey())
      ErrorBeep()
      Alert("Erro: Escolha um indice antes.")
      Return
   EndIF
   MaBox( 10, 10, 12, 70,,, Roloc(Cor()))
   cProcura := FieldGet(FieldPos( IndexKey()))
   IF cProcura = NIL
      cProcura := Space(40)
   EndIF
   @ 11, 11 Say "Filtrar por : " Get cProcura Pict "@K!"
   Read
   IF LastKey() = ESC
      ResTela( cScreen )
      Return
   EndIF
   IF ValType( cProcura ) = "C"
      cProcura := AllTrim( cProcura )
   EndIF
   Sx_SetScope( S_TOP, cProcura)
   Sx_SetScope( S_BOTTOM, cProcura )
   DbGoTop()
Return( Self )

METHOD DupReg(cAlias, cCampo, nOrder)
*************************************
LOCAL cScreen := SaveScreen()
LOCAL oCol	  := ::getColumn( ::colPos )
LOCAL Arq_Ant := Alias()
LOCAL Ind_Ant := IndexOrd()
LOCAL xTemp   := FTempName()
LOCAL aStru   := (cAlias)->(DbStruct())
LOCAL nConta  := (cAlias)->(FCount())
LOCAL lAdmin  := TIniNew(oAmbiente:xBaseDados + "\" + oAmbiente:xUsuario + ".INI"):ReadBool('permissao','usuarioadmin', FALSO)
LOCAL xLen
LOCAL cRegisto
LOCAL xRegistro
LOCAL xRegLocal
LOCAL cType

if !lAdmin
	IF !PodeIncluir()
		return(OK)
	endif
endif
ifnil(nOrder, NATURAL)
ErrorBeep()
IF !Conf('Pergunta: Duplicar registro sob o cursor ?')
	return( OK )
EndIF
xRegistro := (cAlias)->(Recno())
DbCreate( xTemp, aStru )
Use (xTemp) Exclusive Alias xAlias New
xAlias->(DbAppend())
For nField := 1 To nConta
   cCampo := xAlias->(FieldName( nField ))
	if cCampo != "ID"
		xAlias->(FieldPut( nField, (cAlias)->(FieldGet( nField ))))
	endif	
Next
IF (cAlias)->(Incluiu())
	For nField := 1 To nConta
		cCampo := xAlias->(FieldName( nField ))
		if cCampo != "ID"
			(cAlias)->(FieldPut( nField, xAlias->(FieldGet( nField ))))
		endif	
	Next
	xRegLocal := (cAlias)->(Recno())
	(cAlias)->(Libera())
	(cAlias)->(Order( nOrder))
	(cAlias)->(DbGoBottom())
	
	cType := ValType((cAlias)->&(cCampo))	   
	if cType == "C"
		xLen  := Len((cAlias)->&(cCampo))
		CRegistro := StrZero(Val((cAlias)->&(cCampo)) + 1 , xLen)
	elseif cType == "N"
		CRegistro := (cAlias)->&(cCampo) + 1
	else
		CRegistro := (cAlias)->&(cCampo)
	endif
	(cAlias)->(DbGoto( xRegistro ))
	IF (cAlias)->(TravaReg())
		(cAlias)->&(cCampo) := cRegistro
		(cAlias)->(Libera())
	EndIF
EndIF
xAlias->(DbCloseArea())
Ferase(xTemp)
AreaAnt( Arq_Ant, Ind_Ant )
(cAlias)->(DbGoto( xRegistro ))
::FreshOrder()
(cAlias)->(DbGoto( xRegistro ))
return( OK )

Method DOGET(  ARG2 )
*********************
LOCAL Local1
LOCAL LOCAL2
LOCAL LOCAL3
LOCAL oCol
LOCAL LOCAL6
LOCAL LOCAL8
LOCAL LOCAL9
LOCAL Local10
LOCAL Local11
LOCAL Local12
LOCAL nIndice
LOCAL oGet
LOCAL xValue

::Hittop(.F.)
::ForceStable()

IF ::PreDoGet != NIL
   IF !Eval( ::PreDoGet )
      Return( 0 )
   EndIF
EndIF

LOCAL2  := Set(_SET_SCOREBOARD, .F.)
LOCAL3  := Set(_SET_EXIT, .T.)
Local1  := SetKey(K_INS, CURSOR )
Local10 := Setcursor(IIf( Readinsert(), 2, 1 ))
nIndice := Indexkey(0)
If ( !Empty( nIndice ))
	LOCAL8 := &nIndice
EndIf
oCol	 := ::Getcolumn(::Colpos())
xValue := Eval( oCol:Block )
cCor1  := AttrToa( 79 )
IF oCol:Picture = NIL
   Do case
   Case ISCHAR( xValue )
      oCol:picture    := repl( "!", len( xValue ) )
   Case ISDATE( xValue )
      oCol:picture    := "##/##/##"
   EndCase
EndIF
Local11 := Eval(oCol:Block())
oGet	  := Getnew(Row(), Col(), { | _1 | IIf( PCount() == 0, Local11, Local11 := _1 ) }, "mGetVar", oCol:Picture, ::Colorspec )
oGet:ColorDisp( cCor1 )
LOCAL9 := .F.
IF ::PreDoGet != NIL
   IF Eval( ::PreDoGet )
      If ( LOCAL9 )
         ::Freshorder()
         LOCAL6 := 0
      Else
         ::Refreshcurrent()
         LOCAL6 := ::Exitkey(ARG2)
      EndIf
      If ( ARG2 )
         ::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
      EndIf
      Setcursor(Local10)
      Set Scoreboard (LOCAL2)
      Set(_SET_EXIT, LOCAL3)
      SetKey(K_INS, Local1)
   EndIF
EndIF
IF TravaReg()
	If ReadModal({oGet})
		If ( ARG2 .AND. RecNo() == LastRec() + 1 )
			IF PodeIncluir()
				IF Incluiu()
				EndIF
			EndIF
		EndIf
		Eval( oCol:Block(), Local11)
      IF ( !ARG2 .AND. !Empty(Local12 := Ordfor(Indexord())) .AND. !&Local12 )
        DbGoTop()
      EndIf
      If ( !ARG2 .AND. !Empty(nIndice) .AND. LOCAL8  !=  &nIndice )
         LOCAL9 := .T.
      EndIf
	EndIf
   IF ::PosDoGet != NIL
      Eval( ::PosDoGet )
   EndIF
   ::Alterado := OK
   _Field->Atualizado := Date()
	Libera()
EndIf
If ( LOCAL9 )
   ::Freshorder()
	LOCAL6 := 0
Else
	::Refreshcurrent()
	LOCAL6 := ::Exitkey(ARG2)
EndIf
If ( ARG2 )
	::Colorrect({::Rowpos(), 1, ::Rowpos(), ::Colcount()}, {2, 2})
EndIf
Setcursor(Local10)
Set Scoreboard (LOCAL2)
Set(_SET_EXIT, LOCAL3)
SetKey(K_INS, Local1)
Return LOCAL6

Method EXITKEY( ARG1 )
**********************
Local nKey

nKey := LastKey()
Do Case
Case nKey == 3
	If ( ARG1 )
		nKey := 0
	Else
		nKey := 24
	EndIf
Case nKey == 18
	If ( ARG1 )
		nKey := 0
	Else
		nKey := 5
	EndIf
Case nKey == 13 .OR. nKey >= 32 .AND. nKey <= 255
	nKey := 4
Case nKey  !=	5 .AND. nKey  !=	24
	nKey := 0
EndCase
Return nKey

Method FreshOrder()
*******************
LOCAL nRecno := RecNo()
::Refreshall()
::ForceStable()
If ( nRecno  !=  LastRec() + 1 )
	Do While ( RecNo()  !=	nRecno .AND. !BOF() )
		::Up()
      ::ForceStable()
	EndDo
EndIf
Return( Self )

Method SKIPPED( ARG1, ARG2 )
****************************
Local oBrowse
oBrowse := 0
If ( LastRec()  !=  0 )
	If ( ARG1 == 0 )
		Skip 0
	ElseIf ( ARG1 > 0 .AND. RecNo()	!=  LastRec() + 1 )
		Do While ( oBrowse < ARG1 )
			Skip
			If ( EOF() )
				If ( ARG2 )
					oBrowse++
				Else
					Skip -1
				EndIf
				Exit
			EndIf
			oBrowse++
		EndDo
	ElseIf ( ARG1 < 0 )
		Do While ( oBrowse > ARG1 )
			Skip -1
			If ( BOF() )
				Exit
			EndIf
			oBrowse--
		EndDo
	EndIf
EndIf
Return oBrowse

Method ForceStable( browse )
****************************
   WHILE !::stabilize()
   EndDo
Return( Self )

Method InsToggle()
******************
   IF READINSERT()
       READINSERT(.F.)
       SETCURSOR(SC_NORMAL)

   Else
       READINSERT(.T.)
       SETCURSOR(SC_INSERT)

   EndIF
   Return( Self )

Method HotKey( cTecla, xFuncao )
*********************************
   IF ::KeyHotKey = NIL
      ::KeyHotKey := {}
   EndIF
   Aadd( ::KeyHotKey, { cTecla, xFuncao } )
Return( Self )

Function TMsBrowseNew( nLint, nColt, nLinB, nColb )
***************************************************
Return( MsBrowse():New( nLint, nColt, nLinb, nColb ))
