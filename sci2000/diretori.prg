#include "Fileman.ch"
#include "Directry.ch"
#include "Inkey.ch"
#include "Memoedit.ch"
#include "Achoice.ch"

Function Diretorio( nRowTop, nColumnTop, nRowBottom, ;
                  cColorString, cDefaultPath )
*****************************************************
Local lSetScore
MEMVAR GetList
PUBL aFileMan, aFileList
PUBL hScrollBar, nMenuItem, nTagged
PUBL nEl, nRel, lReloadDir, nFileItem

   nMenuItem   := 1
   nTagged     := 0
   nFileItem   := 1
   nEl         := 1
   nRel        := 1
   lReloadDir  := .T.
   aFileMan    := {}
   aFileList   := {}
   aFileMan    := ARRAY( FM_ELEMENTS )
   IF nRowTop  = NIL
      nRowTop  := 0

   ELSE
      IF nRowTop > (MaxRow() - 7)
         nRowTop := MaxRow() - 7

      EndIf
   EndIf
   aFileMan[ FM_ROWTOP ] := nRowTop
   IF nColumnTop = NIL
      nColumnTop := 0

   ELSE
      IF nColumnTop > (MaxCol() - 52)
         nColumnTop := MaxRow() - 52

      EndIf

   EndIf
   aFileMan[ FM_COLTOP ] := nColumnTop

   IF nRowBottom = NIL
      nRowBottom := 0

   ELSE
      IF nRowBottom > MaxRow()
         nRowBottom := MaxRow()

      EndIf
   EndIf
   aFileMan[ FM_ROWBOTTOM ] := nRowBottom
   aFileMan[ FM_COLBOTTOM ] := nColumnTop + 51

   IF cColorString = NIL
      cColorString := SetColor()

   EndIf
   aFileMan[ FM_COLOR ] := cColorString

   IF cDefaultPath = NIL
      cDefaultPath := FCURDIR() + "\*.*"
      cDefaultPath := STRTRAN( cDefaultPath, "\\", "\" )

   EndIf
   aFileMan[ FM_PATH ] := cDefaultPath
   aFileMan[ FM_OLDCOLOR ] := SetColor( aFileMan[ FM_COLOR ] )
   aFileMan[ FM_OLDSELECT ] := SELECT()
   lSetScore := SET( _SET_SCOREBOARD, .F. )
   aFileMan[ FM_OLDSCREEN ] := SaveScreen( aFileMan[ FM_ROWTOP    ], ;
                                           aFileMan[ FM_COLTOP    ], ;
                                           aFileMan[ FM_ROWBOTTOM ], ;
                                           aFileMan[ FM_COLBOTTOM ] )
   CreateScreen()
   GetFiles()

   RestScreen( aFileMan[ FM_ROWTOP    ], ;
               aFileMan[ FM_COLTOP    ], ;
               aFileMan[ FM_ROWBOTTOM ], ;
               aFileMan[ FM_COLBOTTOM ], ;
               aFileMan[ FM_OLDSCREEN ] )
   SetColor( aFileMan[ FM_OLDCOLOR ] )
   SET( _SET_SCOREBOARD, lSetScore )
   SELECT ( aFileMan[ FM_OLDSELECT ] )
   RETURN( aFileMan[ FM_RETURNFILE ] )

Static Function GetFiles
************************
   Local lDone       := .F.
   Local nCurrent    := 0
   Local nLastKey    := 0

   DO WHILE !lDone
      IF lReloadDir
         nEl   := 1
         nRel  := 1
         IF !LoadFiles()
            ErrorBeep()
            Message( "Erro: Arquivos nao Encontrados!..." )
            InKey( 0 )
            IF YesOrNo( "Mudar de path? (S/N)", "S" )
               GetNewPath( aFileMan[ FM_PATH ] )
               IF LASTKEY() == K_ESC
                  lDone := .T.

               ELSE
                  LOOP

               EndIf
            ELSE
               lDone := .T.

            EndIf
         ELSE
            lReloadDir := .F.

         EndIf
      EndIf
      TabUpdate( hScrollBar, nEl, LEN( aFileList ), .T. )
      nCurrent := ACHOICE( aFileMan[ FM_ROWTOP ] + 3, ;
                           aFileMan[ FM_COLTOP ] + 2, ;
                           aFileMan[ FM_ROWBOTTOM ] - 3, ;
                           aFileMan[ FM_COLBOTTOM ] - 4, ;
                           aFileList, .T., "ProcessKey", nEl, nRel )

      nFileItem := nCurrent
      nLastKey := LASTKEY()

      DO CASE
         CASE UPPER(CHR(nLastKey)) $ "LCRDPO"
            nMenuItem := AT( UPPER(CHR(nLastKey)), "LCRDPO" )
            DisplayMenu()

         CASE nLastKey == K_RIGHT
            nMenuItem++
            IF nMenuItem > 6
               ErrorBeep()
               nMenuItem := 6

            EndIf
            DisplayMenu()

         CASE nLastKey == K_LEFT
            nMenuItem--
            IF nMenuItem < 1
               ErrorBeep()
               nMenuItem := 1
            EndIf
            DisplayMenu()

         CASE nLastKey == K_ESC
            aFileMan[ FM_RETURNFILE ] := ""
            lDone := .T.

         CASE nLastKey == K_ENTER
            aFileMan[ FM_RETURNFILE ] := ;
                     SUBSTR( aFileMan[ FM_PATH ], 1, ;
                     RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                     TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12 ) )

            DO CASE
               CASE nMenuItem == MN_LOOK
                  LookAtFile()

               CASE nMenuItem == MN_COPY
                  CopyFile()

               CASE nMenuItem == MN_RENAME
                  RenameFile()

               CASE nMenuItem == MN_DELETE
                  DeleteFile()

               CASE nMenuItem == MN_PRINT
                  PrintFile()

               CASE nMenuItem == MN_OPEN
                  IF AT( '<DIR>', aFileList[ nFileItem ] ) = 0
                     lDone := .T.
                  ELSE
                     LookAtFile()
                  EndIf

            ENDCASE

         CASE nLastKey == K_DEL
            DeleteFile()

         CASE nLastKey == K_F5
            TagAllFiles()

         CASE nLastKey == K_F6
            UnTagAllFiles()

         CASE nLastKey == K_SPACE
            IF AT( "D", SUBSTR( aFileList[ nCurrent ], 43, 6 ) ) == 0
               IF SUBSTR( aFileList[ nCurrent ], 14, 1 ) == " "
                  aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                           14, 1, FM_CHECK )
                  nTagged++
               ELSE
                  aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                           14, 1, " " )
                  nTagged--
               EndIf
            EndIf

      ENDCASE
   ENDDO

   RETURN NIL

Static Function LoadFiles
*************************
   Local aDirectory := {}
   Local nItem := 0
   Local lReturnValue := .T.
   Local nNumberOfItems := 0
   Local cFileString := ""

   Message( "Chamando o Diretorio Corrente..." )
   @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2 CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ] - 3, aFileMan[ FM_COLBOTTOM ] - 4

   aDirectory := DIRECTORY( aFileMan[ FM_PATH ], "D" )
   nNumberOfItems := IF( VALTYPE( aDirectory ) != "A", 0, LEN( aDirectory ) )
   aFileList := {}
   IF nNumberOfItems < 1
      lReturnValue := .F.

   ELSE
      Message( "Sorteando o Diretorio Corrente..." )
      ASORT( aDirectory,,, { | x, y | x[ F_NAME ] < y[ F_NAME ] } )
      Message( "Processando o Diretorio Corrente..." )
      FOR nItem := 1 TO nNumberOfItems
         AADD( aFileList, PADR( aDirectory[ nItem, F_NAME ], 15 ) + ;
                          IF( SUBSTR( aDirectory[ nItem, F_ATTR ], ;
                          1, 1 ) == "D", "   <DIR>", ;
                          STR( aDirectory[ nItem, F_SIZE ], 8 ) ) + "  " + ;
                          DTOC( aDirectory[ nItem, F_DATE ] ) + "  " + ;
                          SUBSTR( aDirectory[ nItem, F_TIME ], 1, 5) + "  " + ;
                          SUBSTR( aDirectory[ nItem, F_ATTR ], 1, 4 ) + "  " )
      NEXT

   EndIf
   Message( aFileMan[ FM_PATH ] )
   Return( lReturnValue )

Function ProcessKey( nStatus, nElement, nRelative )
***************************************************
   Local nReturnValue := AC_CONT
   nEl  := nElement
   nRel := nRelative
   DO CASE
   CASE nStatus == AC_IDLE
      TabUpdate( hScrollBar, nElement, LEN( aFileList ) )
      Message( aFileMan[ FM_PATH ] )

   CASE nStatus == AC_HITTOP .OR. nStatus == AC_HITBOTTOM
      ErrorBeep()

   CASE nStatus == AC_EXCEPT
      DO CASE
      CASE LASTKEY() == K_ESC
         nReturnValue := AC_ABORT

      CASE LASTKEY() == K_HOME
         KEYBOARD CHR( K_CTRL_PGUP )
         nReturnValue := AC_CONT

      CASE LASTKEY() == K_END
         KEYBOARD CHR( K_CTRL_PGDN )
         nReturnValue := AC_CONT

      CASE LASTKEY() == K_LEFT .OR. LASTKEY() == K_RIGHT
         nReturnValue := AC_SELECT

      CASE UPPER(CHR(LASTKEY())) $ ;
         "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 " .OR. ;
         LASTKEY() == K_DEL .OR. LASTKEY() == K_ENTER .OR. ;
         LASTKEY() == K_F5 .OR. LASTKEY() == K_F6

         nReturnValue := AC_SELECT

      ENDCASE

   ENDCASE

   RETURN (nReturnValue)

Static Function Message( cString )
**********************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   ClearMessage()
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
      SUBSTR( cString, 1, (aFileMan[FM_COLBOTTOM] - aFileMan[FM_COLTOP] - 6 ))

   SetColor( cOldColor )

   RETURN NIL

Static Function GetNewPath( cPath )
***********************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   ClearMessage()
   cPath := PADR( cPath, 45 )
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 GET ;
     cPath PICTURE "@!@S45@K"
   READ

   cPath := LTRIM(TRIM(cPath))

   IF RIGHT( cPath, 1 ) == "\"
      cPath += "*.*"
   EndIf
   IF RIGHT( cPath, 1 ) == ":"
      cPath += "\*.*"
   EndIf

   aFileMan[ FM_PATH ] := cPath

   Message( cPath )

   SetColor( cOldColor )
   RETURN( TRIM( cPath ) )

Static Function YesOrNo( cMessage, cDefault )
*********************************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   Local lYesOrNo

   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
     TRIM( SUBSTR( cMessage, 1, ;
         (aFileMan[FM_COLBOTTOM] - aFileMan[FM_COLTOP] - 8 )) ) GET ;
         cDefault PICTURE "!"
   READ

   lYesOrNo := IF( cDefault == "S", .T., .F. )
   SetColor( cOldColor )

   RETURN (lYesOrNo)

Static Function ClearMessage
****************************
   Local cOldColor := SetColor( aFileMan[ FM_COLOR ] )
   @ aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLTOP ] + 2 CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ] - 1, aFileMan[ FM_COLBOTTOM ] - 4

   SetColor( cOldColor )

   RETURN NIL

Static Function CreateScreen()
******************************
   Local cFrameType  := FM_SINGLEFRAME
   Local cBorderType := FM_SINGLEBORDER
   Local nRow        := 0

   @ aFileMan[ FM_ROWTOP ], aFileMan[ FM_COLTOP ] CLEAR TO ;
     aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ]
   @ aFileMan[ FM_ROWTOP ], aFileMan[ FM_COLTOP ], ;
     aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ] BOX cFrameType

   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLTOP ];
     SAY SUBSTR( cBorderType, FM_LEFT, 1 )
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLBOTTOM ];
     SAY SUBSTR( cBorderType, FM_RIGHT, 1 )
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLTOP ] + 1;
     SAY REPLICATE( SUBSTR( cFrameType, FM_HORIZONTAL, 1 ),;
         ( aFileMan[ FM_COLBOTTOM ] - aFileMan[ FM_COLTOP ] - 1 )  )

   FOR nRow := (aFileMan[ FM_ROWTOP ] + 3) TO (aFileMan[ FM_ROWBOTTOM ] - 1)
      @ nRow, aFileMan[ FM_COLBOTTOM ] - 2 ;
        SAY SUBSTR( cFrameType, FM_VERTICAL, 1 )
   NEXT
   @ aFileMan[ FM_ROWTOP ] + 2, aFileMan[ FM_COLBOTTOM ] - 2 SAY ;
     SUBSTR( cBorderType, FM_TOP, 1 )
   @ aFileMan[ FM_ROWBOTTOM ], aFileMan[ FM_COLBOTTOM ] - 2 SAY ;
     SUBSTR( cBorderType, FM_BOTTOM, 1 )

   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLTOP ] ;
     SAY SUBSTR( cBorderType, FM_LEFT, 1 )
   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLBOTTOM ] -2 ;
     SAY SUBSTR( cBorderType, FM_RIGHT, 1 )
   @ aFileMan[ FM_ROWBOTTOM ] - 2, aFileMan[ FM_COLTOP ] + 1 ;
     SAY REPLICATE( SUBSTR( cFrameType, FM_HORIZONTAL, 1 ), ;
         ( aFileMan[ FM_COLBOTTOM ] - aFileMan[ FM_COLTOP ] - 3 )  )

   hScrollBar := TabNew( aFileMan[ FM_ROWTOP ] + 3, ;
                         aFileMan[ FM_COLBOTTOM ] - 1, ;
                         aFileMan[ FM_ROWBOTTOM ] - 1, ;
                         aFileMan[ FM_COLOR ], 1 )
   TabDisplay( hScrollBar )

   DisplayMenu()

   RETURN NIL

Static Function DisplayMenu
***************************
   Local cOldColor := SetColor(), nCol := aFileMan[ FM_COLTOP ] + 2
   Local cItemName

   @ aFileMan[ FM_ROWTOP ] + 1, aFileMan[ FM_COLTOP ] + 2 SAY ;
     "Abrir Copiar Renomear Deletar Imprimir  Tipo"
   SetColor( "I" )
   DO CASE
   CASE nMenuItem == MN_OPEN
      nCol := aFileMan[ FM_COLTOP ] + 2
      cItemName := "Abrir"

   CASE nMenuItem == MN_COPY
      nCol := aFileMan[ FM_COLTOP ] + 8
      cItemName := "Copiar"

   CASE nMenuItem == MN_RENAME
      nCol := aFileMan[ FM_COLTOP ] + 15
      cItemName := "Renomear"

   CASE nMenuItem == MN_DELETE
      nCol := aFileMan[ FM_COLTOP ] + 24
      cItemName := "Deletar"

   CASE nMenuItem == MN_PRINT
      nCol := aFileMan[ FM_COLTOP ] + 32
      cItemName := "Imprimir"

   CASE nMenuItem == MN_LOOK
      nCol := aFileMan[ FM_COLTOP ] + 42
      cItemName := "Tipo"

   ENDCASE

   @ aFileMan[ FM_ROWTOP ] + 1, nCol SAY cItemName
   Message( aFileMan[ FM_PATH ] )

   SetColor( cOldColor )

   RETURN NIL


Static Function TabNew( nTopRow, nTopColumn, nBottomRow, ;
						cColorString, nInitPosition )
*****************************************************************************
   Local aTab := ARRAY( TB_ELEMENTS )

   aTab[ TB_ROWTOP ]	:= nTopRow
   aTab[ TB_COLTOP ]	:= nTopColumn
   aTab[ TB_ROWBOTTOM ] := nBottomRow
   aTab[ TB_COLBOTTOM ] := nTopColumn

   IF cColorString == NIL
	  cColorString := "W/N"
   EndIf
   aTab[ TB_COLOR ] 	:= cColorString

   IF nInitPosition == NIL
	  nInitPosition := 1
   EndIf
   aTab[ TB_POSITION ]	:= nInitPosition

   RETURN aTab


Static Function TabDisplay( aTab )
*********************************
   Local cOldColor, nRow

   cOldColor := SetColor( aTab[ TB_COLOR ] )

   @ aTab[ TB_ROWTOP ], aTab[ TB_COLTOP ] SAY TB_UPARROW
   @ aTab[ TB_ROWBOTTOM ], aTab[ TB_COLBOTTOM ] SAY TB_DNARROW

   FOR nRow := (aTab[ TB_ROWTOP ] + 1) TO (aTab[ TB_ROWBOTTOM ] - 1)
	  @ nRow, aTab[ TB_COLTOP ] SAY TB_BACKGROUND
   NEXT

   SetColor( cOldColor )

   RETURN aTab


Static Function TabUpdate( aTab, nCurrent, nTotal, lForceUpdate )
*****************************************************************
   Local cOldColor, nNewPosition
   Local nScrollHeight := (aTab[TB_ROWBOTTOM]-1)-(aTab[TB_ROWTOP])

   IF nTotal < 1
	  nTotal := 1
   EndIf

   IF nCurrent < 1
	  nCurrent := 1
   EndIf

   IF nCurrent > nTotal
	  nCurrent := nTotal
   EndIf

   IF lForceUpdate == NIL
	  lForceUpdate := .F.
   EndIf

   cOldColor := SetColor( aTab[ TB_COLOR ] )

   nNewPosition := ROUND( (nCurrent / nTotal) * nScrollHeight, 0 )

   nNewPosition := IF( nNewPosition < 1, 1, nNewPosition )
   nNewPosition := IF( nCurrent == 1, 1, nNewPosition )
   nNewPosition := IF( nCurrent >= nTotal, nScrollHeight, nNewPosition )

   IF nNewPosition <> aTab[ TB_POSITION ] .OR. lForceUpdate
	  @ (aTab[ TB_POSITION ] + aTab[ TB_ROWTOP ]), aTab[ TB_COLTOP ] SAY ;
		TB_BACKGROUND
	  @ (nNewPosition + aTab[ TB_ROWTOP ]), aTab[ TB_COLTOP ] SAY;
		TB_HIGHLIGHT
	  aTab[ TB_POSITION ] := nNewPosition
   EndIf

   SetColor( cOldColor )

   RETURN aTab


Static Function UpPath( cPath )
*******************************
   Local cFileSpec

   cFileSpec := RIGHT( cPath, LEN( cPath ) - RAT( "\", cPath ) )
   cPath     := LEFT( cPath, RAT( "\", cPath ) - 1 )
   cPath     := LEFT( cPath, RAT( "\", cPath ) )
   cPath     += cFileSpec

   RETURN (cPath)

Static Function GetFileExtension( cFile )
*****************************************
   RETURN( UPPER( SUBSTR( cFile, AT( ".", cFile ) + 1, 3 ) ) )

Static Function LookAtFile
**************************
   Local cExtension := ""
   Local cOldScreen := SaveScreen( 0, 0, MaxRow(), MaxCol() )

   IF AT( "D", SUBSTR( aFileList[ nFileItem ], 43, 6 ) ) <> 0
      DO CASE
      CASE SUBSTR( aFileList[ nFileItem ], 1, 3 ) == ".  "
         GetNewPath( aFileMan[ FM_PATH ] )

      CASE SUBSTR( aFileList[ nFileItem ], 1, 3 ) == ".. "
         GetNewPath( UpPath( aFileMan[ FM_PATH ]))

      OTHERWISE
         GetNewPath( SUBSTR( aFileMan[ FM_PATH ], 1, ;
            RAT( "\", aFileMan[ FM_PATH ])) + ;
            TRIM(SUBSTR(aFileList[nFileItem],1,12)) + "\*.*")
      ENDCASE
      lReloadDir := .T.
   ELSE
      cExtension := GetFileExtension( SUBSTR(aFileList[nFileItem],1,12) )

      DO CASE
      CASE cExtension == "DBF"
         DBFViewer( aFileMan[ FM_RETURNFILE ] )

      OTHERWISE
         OlharGenerico( aFileMan[ FM_RETURNFILE ] )

      ENDCASE

      RestScreen( 0, 0, MaxRow(), MaxCol(), cOldScreen )

   EndIf
   RETURN NIL

Static Function CopyFile
************************
   Local cNewName := ""
   Local cOldName := ""
   Local lKeepGoing := .F.
   Local cNewFile := ""
   Local nCurrent := 0
   Local cCurrentFile := ""
   Local nCount := 0
   Local cOldScreen := SaveScreen( aFileMan[ FM_ROWTOP ] + 3,;
                                   aFileMan[ FM_COLTOP ] + 2,;
                                   aFileMan[ FM_ROWTOP ] + 6,;
                                   aFileMan[ FM_COLTOP ] + 51 )
   IF AT( "<DIR>", aFileList[ nFileItem ] ) = 0
      ErrorBeep()
      IF nTagged > 0
         IF YesOrNo( "Copiar Arquivos Marcados ? (S/N)", "N" )
            lKeepGoing := .T.

         EndIf
      ELSE
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
           CHR( 16 )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
           CHR( 17 )
         IF YesOrNo( "Copiar Este Arquivo ? (S/N)", "N" )
            lKeepGoing := .T.
         EndIf
      EndIf

      ClearMessage()

      @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2, ;
        aFileMan[ FM_ROWTOP ] + 6, aFileMan[ FM_COLTOP ] + 51 BOX;
        FM_DOUBLEFRAME
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
        aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50

      cNewName := cOldName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, ;
                              RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                              TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) ),;
                              45 )

      IF lKeepGoing

         IF nTagged > 0

            cNewName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, RAT( "\", ;
                                aFileMan[ FM_PATH ] ) ), 45 )
            DevPos( aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ] + 4 )
            DevOut("Copiar Arquivos Marcados Para...")
            @ aFileMan[ FM_ROWTOP ]+5, aFileMan[ FM_COLTOP ]+4 GET;
              cNewName PICTURE "@!@S46@K"
            READ
            IF LASTKEY() <> K_ESC
               cNewName := TRIM( cNewName )
               IF RIGHT( cNewName, 1 ) <> "\"
                  cNewName += "\"
               EndIf
               FOR nCurrent := 1 TO LEN( aFileList )
                  IF SUBSTR( aFileList[ nCurrent ], 14, 1 ) == FM_CHECK
                     cCurrentFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                                     RAT( "\", aFileMan[ FM_PATH ])) + ;
                                     TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12))
                     cNewFile := cNewName + ;
                                 TRIM( SUBSTR( aFileList[ nCurrent ], 1, 12))
                     Message( "Copiando " + TRIM( cCurrentFile ) )
                     COPY FILE ( cCurrentFile ) TO ( cNewFile )
                     aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                              14, 1, " " )
                     nTagged--
                     nCount++
                     IF InKey() = K_ESC
                        EXIT
                     EndIf
                  EndIf
               NEXT
               @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
                 aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
               @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
                 LTRIM(STR( nCount )) + IF( nCount > 1, " Arquivos Copiados.  ", ;
                                        " Arquivo Copiado.  " ) + "Tecle Algo..."
               InKey(0)
            EndIf
         ELSE
            @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
              "Copiar Arquivo Corrente Para..."
            @ aFileMan[ FM_ROWTOP ]+5, aFileMan[ FM_COLTOP ]+4 GET;
              cNewName PICTURE "@!@S46@K"
            READ
            IF LASTKEY() <> K_ESC
               IF RIGHT( cNewName, 1 ) == "\"
                  cNewName += TRIM( SUBSTR( cOldName, RAT( "\", cOldName) ;
                              + 1, 12 ))
               EndIf
               COPY FILE ( cOldName ) TO ( cNewName )
               @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
                 aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
               @ aFileMan[ FM_ROWTOP ]+4, aFileMan[ FM_COLTOP ]+4 SAY;
                 "1 Arquivo Copiado. Tecle Algo..."
               InKey(0)
            EndIf

         EndIf

         lReloadDir := .T.
      EndIf
   EndIf


   RestScreen( aFileMan[ FM_ROWTOP ] + 3, ;
               aFileMan[ FM_COLTOP ] + 2, ;
               aFileMan[ FM_ROWTOP ] + 6, ;
               aFileMan[ FM_COLTOP ] + 51,;
               cOldScreen )

   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
     CHR( 32 )
   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
     CHR( 32 )

   RETURN NIL

Static Function RenameFile
**************************
   Local cNewName := "", cOldName := ""
   Local cOldScreen := SaveScreen( aFileMan[ FM_ROWTOP ] + 3,;
                                   aFileMan[ FM_COLTOP ] + 2,;
                                   aFileMan[ FM_ROWTOP ] + 6,;
                                   aFileMan[ FM_COLTOP ] + 51 )

   IF AT( "<DIR>", aFileList[ nFileItem ] ) = 0

      @ aFileMan[ FM_ROWTOP ] + 3, aFileMan[ FM_COLTOP ] + 2, ;
        aFileMan[ FM_ROWTOP ] + 6, aFileMan[ FM_COLTOP ] + 51 BOX;
        FM_DOUBLEFRAME
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
        aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50

      cNewName := cOldName := PADR( SUBSTR( aFileMan[ FM_PATH ], 1, ;
                              RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                              TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) ),;
                              45 )

      ErrorBeep()
      @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 4 SAY "Renomear " +;
        SUBSTR( cNewName, 1, 38 )
      @ aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 4 SAY "Para" GET;
        cNewName PICTURE "@!@S43@K"
      READ

      IF LASTKEY() <> K_ESC
         IF FILE( cNewName )
            ErrorBeep()
            @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 3 CLEAR TO ;
              aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 50
            @ aFileMan[ FM_ROWTOP ] + 4, aFileMan[ FM_COLTOP ] + 4 SAY ;
              "Erro: Este Arquivo Ja Existe!"
            @ aFileMan[ FM_ROWTOP ] + 5, aFileMan[ FM_COLTOP ] + 4 SAY ;
               "Tecle Algo..."
            InKey( 0 )
         ELSE
            lReloadDir := .T.
            RENAME ( TRIM( cOldName ) ) TO ( TRIM( cNewName ) )
         EndIf
      EndIf

   EndIf

   RestScreen( aFileMan[ FM_ROWTOP ] + 3, ;
               aFileMan[ FM_COLTOP ] + 2, ;
               aFileMan[ FM_ROWTOP ] + 6, ;
               aFileMan[ FM_COLTOP ] + 51,;
               cOldScreen )

   RETURN NIL

Static Function DeleteFile
**************************
   Local nCurrentFile := 0
   Local cFile := ""
   ErrorBeep()
   IF nTagged > 0
      IF YesOrNo( "Deletar Arquivos Marcados ? (S/N)", "N" )
         lReloadDir := .T.
         FOR nCurrentFile := 1 TO LEN( aFileList )
            cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                     RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                     TRIM( SUBSTR( aFileList[ nCurrentFile ], 1, 12 ) )
            IF SUBSTR( aFileList[ nCurrentFile ], 14, 1 ) == FM_CHECK
               ERASE ( cFile )
               Message( "Deletando... " + TRIM( cFile ) )
            EndIf
         NEXT
         Message( LTRIM( STR( nTagged ) ) + " Arquivo(s) Deletados... ")
         InKey( 0 )
         nTagged := 0
      EndIf
   ELSE
      IF AT( "<DIR>", aFileList[ nFileItem ] ) = 0
         cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                  RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                  TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
           CHR( 16 )
         @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
           CHR( 17 )
         IF YesOrNo( "Deletar Este Arquivo ? (S/N)", "N" )
            ERASE ( cFile )
            lReloadDir := .T.

         EndIf
      EndIf
   EndIf

   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 SAY;
     CHR( 32 )
   @ aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 SAY;
     CHR( 32 )
   Message( aFileMan[ FM_PATH ] )
   RETURN NIL

Static Function PrintFile
*************************
   Local cFile := SUBSTR( aFileMan[ FM_PATH ], 1, ;
                  RAT( "\", aFileMan[ FM_PATH ] ) ) + ;
                  TRIM( SUBSTR( aFileList[ nFileItem ], 1, 12 ) )

   ErrorBeep()
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 )
   DevOut( Chr( 16 ) )
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3  )
   DevOut( Chr( 17 ) )
   IF YesOrNo( "Imprimir Este Arquivo ?", "N" )
      IF IsPrinter()
         Message( "Imprimindo " + TRIM( cFile ) )
         Copy File ( cFile ) To Prn
         __Eject()

      Else
         ErrorBeep()
         Message( "Erro: Impressora Nao Responde!" )
         InKey( 20 )

      EndIf

   EndIf

   ClearMessage()
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLTOP ] + 1 )
   DevOut( Chr( 32 ) )
   DevPos( aFileMan[ FM_ROWTOP ] + 3 + nRel, aFileMan[ FM_COLBOTTOM ] - 3 )
   DevOut( Chr( 32 ) )
   Message( aFileMan[ FM_PATH ] )
   Return Nil

Static Function DBFViewer( cDatabase )
**************************************
   Local cRecords := ""
   USE (cDatabase) ALIAS LookFile SHARED NEW READONLY
   IF !NetErr()
      cRecords := "REGISTROS # " + LTRIM( STR( RECCOUNT()))
      StatusInf( cRecords, Trim( cDataBase ))
      MaBox( 0, 0, MaxRow() -1, MaxCol() )
      DbEdit( 1, 1, 22, 78 )
      Use
      Select ( aFileMan[ FM_OLDSELECT ] )
   EndIf
   RETURN (cDatabase)

#define GV_BLOCKSIZE    50000

Static Function OlharGenerico( cFile )
*************************************
   Local cBuffer := ""
   Local nHandle := 0
   Local nBytes := 0
   Local cScreen:= SaveScreen()
 
   cBuffer := Space( GV_BLOCKSIZE )
   nHandle := Fopen( cFile )
   IF Ferror() != 0
      cBuffer := "Erro Leitura Arquivo!"
   Else
      nBytes = Fread( nHandle, @cBuffer, GV_BLOCKSIZE )
   EndIf
   Fclose( nHandle )
   cBuffer := RTRIM( cBuffer )
   StatusInf( Trim( cFile ), "USE " + Chr(27)+Chr(18)+Chr(26) + "³ESC Sair")
   MaBox(0, 0, MaxRow()-1, MaxCol())
   DevPos( MaxRow(),  INT( (MaxCol( ) - 48 ) / 2) )
   MemoEdit( cBuffer, 1, 2, MaxRow() - 2, MaxCol() - 1, .F., "MemoUDF" , 300 )
   RestScreen(,,,, cScreen )
   Return( cFile )

#undef GV_BLOCKSIZE

Function MemoUDF( Modo, Linha, Coluna )
***************************************
IF Modo < 4
   Return( ME_DEFAULT )
Else
   Return( ME_DEFAULT )
Endif

Static Function TagAllFiles
***************************
   Local nCurrent

   nTagged := 0
   FOR nCurrent := 1 TO LEN( aFileList )
      IF AT( "D", SUBSTR( aFileList[ nCurrent ], 43, 6 ) ) == 0
         aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], ;
                                         14, 1, FM_CHECK )
         nTagged++
      EndIf
   NEXT
   
   Return NIL

Static Function UnTagAllFiles
*****************************
   Local nCurrent
   nTagged := 0
   FOR nCurrent := 1 TO LEN( aFileList )
      aFileList[ nCurrent ] := STUFF( aFileList[ nCurrent ], 14, 1, " " )

   NEXT
   Return NIL
