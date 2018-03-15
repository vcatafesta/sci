*	NOTE: compile with /m /n /w /b
#include "hbclass.ch"
#include "hblang.ch"
#include "color.ch"
#include "setcurs.ch"
#include "button.ch"

#include "Inkey.ch"
#include "Getexit.ch"

#define GET_CLR_UNSELECTED      0
#define GET_CLR_ENHANCED        1
#define GET_CLR_CAPTION         2
#define GET_CLR_ACCEL           3

//#include "hbapigt.h"

#Define VAR_AGUDO 		 39	 // Indicador de agudo
#Define VAR_CIRCUN		 94	 // Indicador de circunflexo
#Define VAR_TREMA 		 34	 // Indicador de trema
#Define VAR_CEDMIN		 91	 // Cedilha min�sculo opcional [
#Define VAR_CEDMAI		 123	 // Cedilha mai�sculo opcional {
#Define VAR_GRAVE 		 96	 // Indicador de grave
#Define VAR_TIL			 126	 // Indicador de til
#Define VAR_HIFEN 		 95	 // Indicador de � � sublinhado+a/o
#define _GET_INSERT_ON	 7 	 // "Ins"
#define _GET_INSERT_OFF  8 	 // "   "
#define _GET_INVD_DATE	 9 	 // "Data Invalida"
#define _GET_RANGE_FROM  10	 // "Range: "
#define _GET_RANGE_TO	 11		 // " - "
#define K_UNDO 			 K_CTRL_U
#define CTRL_END_SPECIAL OK		 // Para Ficar no Ultimo Get qdo teclar ctr+end
#define ECHO_CHAR        "*"
#define ECHO_CHAR 		 "�"
#define LOW 				 32
#define HIGH				 127


STATIC sbFormat
STATIC slUpdated	:= .F.
STATIC slKillRead
STATIC slBumpTop
STATIC slBumpBot
STATIC snLastExitState
STATIC snLastPos
STATIC soActiveGet
STATIC scReadProcName
STATIC snReadProcLine


#define GSV_KILLREAD 		1
#define GSV_BUMPTOP			2
#define GSV_BUMPBOT			3
#define GSV_LASTEXIT 		4
#define GSV_LASTPOS			5
#define GSV_ACTIVEGET		6
#define GSV_READVAR			7
#define GSV_READPROCNAME	8
#define GSV_READPROCLINE	9
#define GSV_COUNT 			9

FUNCTION ReadModal( GetList, nPos )
***********************************
	LOCAL oGet
	LOCAL aSavGetSysVars
	LOCAL nTam := Len( GetList )
	LOCAL x

	IF ( VALTYPE( sbFormat ) == "B" )
		EVAL( sbFormat )
	ENDIF

	IF ( EMPTY( GetList ) )

		// S'87 compatibility
		SETPOS( MAXROW() - 1, 0 )
		RETURN (.F.)						// NOTE

	ENDIF

	// Preserve state variables
	aSavGetSysVars := ClearGetSysVars()

	// Set these for use in SET KEYs
	scReadProcName := PROCNAME( 1 )
	snReadProcLine := PROCLINE( 1 )

	// Set initial GET to be read
	IF !( VALTYPE( nPos ) == "N" .AND. nPos > 0 )
		nPos := Settle( Getlist, 0 )
	ENDIF

	// Vilmar
	IF oAmbiente:Get_Ativo
		For x := 1 To nTam
			PostActiveGet( oGet := GetList[ x ] )
			oGet:Display()
		Next
	EndIF
	WHILE !( nPos == 0 )
		//aVarGet := Array( Len( GetList ) )  // by JPA to otimize screen update
      //FOR EACH oElement IN GetList        // by JPA to otimize screen update
      //   aVarGet[ oElement:__EnumIndex ] := oElement:VarGet()
      //NEXT
	
	
		// Get next GET from list and post it as the active GET
		PostActiveGet( oGet := GetList[ nPos ] )

		// Read the GET
		if oGet:Picture != nil
			if oGet:cType != "N" .AND. oGet:cType != "L" .AND. oGet:cType != "D"
				IF At("@S", oGet:picture) > 0    // Campo Senha?
					oGet:lHideInput := .T.
					oGet:cStyle     := ECHO_CHAR 
					//ATail(GetList):reader := {|o| o:varPut(GetPsw(o))}
				endif	
			endif
		endif
		IF ( VALTYPE( oGet:reader ) == "B" )
			EVAL(oGet:reader,oGet)			// Use custom reader block
		ELSE
			GetReader(oGet)					// Use standard reader
		ENDIF

		//FOR EACH oElement IN GetList // by JPA to otimize screen update
      //   IF aVarGet[ oElement:__EnumIndex ] != oElement:VarGet()
      //      oElement:Display()
      //   ENDIF
      //NEXT
				
		// Move to next GET based on exit condition
		nPos := Settle( GetList, nPos )

	ENDDO


	// Restore state variables
	RestoreGetSysVars( aSavGetSysVars )

	// S'87 compatibility
	SETPOS( MAXROW() - 1, 0 )

	RETURN ( slUpdated )

	
Proc GetReader( oGet )
**********************
	LOCAL nTimeSaver := oIni:ReadInteger( 'sistema', 'screensaver', 60 )
	LOCAL nKey		  := 0

	IF ( GetPreValidate( oGet ) )
		oGet:setFocus()
		SetCursor( iif( Upper( "on" ) == "ON", 1, 0 ) )
		WHILE ( oGet:exitState == GE_NOEXIT )
		   IF ( oGet:typeOut )
				oGet:exitState := GE_ENTER
			ENDIF
			WHILE ( oGet:exitState == GE_NOEXIT )
				WHILE (( nKey := INKEY( nTimeSaver )) = 0 )
					SetCursor( iif( Upper( "on" ) == "ON", 1, 0 ) )
					protela()
					//Shuffle()
				ENDDO
				GetApplyKey(oGet,nKey)
			ENDDO
			IF (!GetPostValidate(oGet))
			  oGet:exitState := GE_NOEXIT
			ENDIF
		ENDDO
	ENDIF
	oGet:killFocus()
	RETURN

PROCEDURE GetApplyKey( oGet, nKey )
***********************************
LOCAL VAR_CNF_AC := ['a�'e�'i�'o�'u�'A�'E�'I�'O�'U�'c�'C�] + ; // Agudo
						  [`a�`e�`i�`o�`u�`A�`E�`I�`O�`U�`c�`C�] + ; // Grave
						  [^a�^e�^o�^A�^E�^O�^c�^C�]				  + ; // Circunflexo
						  [~a�~n�~o�~A�~N�~O�~c�~C�]				  + ; // Til
						  ["u�"U�]                               + ; // Trema
						  [_a�_A�_o�_O�]								  + ; // H�fen
						  [ �{ �]                                   // Cedilha
	LOCAL cKey
	LOCAL Cod_Acento
	LOCAL bKeyBlock

	IF !( ( bKeyBlock := setkey( nKey ) ) == NIL )
		GetDoSetKey( bKeyBlock, oGet )
		RETURN
	ENDIF

	DO CASE
	CASE ( nKey == K_UP )
		oGet:exitState := GE_UP

	CASE ( nKey == K_SH_TAB )
		oGet:exitState := GE_UP

	CASE ( nKey == K_DOWN )
		oGet:exitState := GE_DOWN

	CASE ( nKey == K_TAB )
		oGet:exitState := GE_ENTER // GE_DOWN

	CASE ( nKey == K_ENTER )
		oGet:exitState := GE_ENTER

	CASE ( nKey == K_ESC )
		IF ( SET( _SET_ESCAPE ) )
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		ENDIF

	CASE ( nKey == K_ALT_F4 )
		IF ( SET( _SET_ESCAPE ) )
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		ENDIF

	CASE ( nKey == K_PGUP )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_PGDN )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_CTRL_HOME )
		oGet:exitState := GE_TOP

	CASE ( nKey == K_CTRL_PGDN )
		oGet:exitState := GE_BOTTOM

	CASE ( nKey == K_CTRL_PGUP )
		oGet:exitState := GE_TOP

#ifdef CTRL_END_SPECIAL

	// Both ^W and ^End go to the last GET
	CASE ( nKey == K_CTRL_END )
		oGet:exitState := GE_BOTTOM

#else

	// Both ^W and ^End terminate the READ (the default)
	CASE ( nKey == K_CTRL_W )
		oGet:exitState := GE_WRITE

#endif


	CASE ( nKey == K_INS )
		SET( _SET_INSERT, !SET( _SET_INSERT ) )
		ShowScoreboard()

	CASE ( nKey == K_UNDO )
		oGet:undo()

	CASE ( nKey == K_HOME )
		oGet:home()

	CASE ( nKey == K_END )
		oGet:end()

	CASE ( nKey == K_RIGHT )
		oGet:right()

	CASE ( nKey == K_LEFT )
		oGet:left()

	CASE ( nKey == K_CTRL_RIGHT )
		oGet:wordRight()

	CASE ( nKey == K_CTRL_LEFT )
		oGet:wordLeft()

	CASE ( nKey == K_BS )
		oGet:backSpace()

	CASE ( nKey == K_DEL )
		oGet:delete()

	CASE ( nKey == K_CTRL_T )
		oGet:delWordRight()

	CASE ( nKey == K_CTRL_Y )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_DEL )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_BS )
		oGet:delWordLeft()

	OTHERWISE

		IF ( nKey >= 32 .AND. nKey <= 255 )
			cKey		  := CHR( nKey )
			Cod_Acento := Chr( nKey )
			***************************************************************
			// Codigo Acrescentado em 19.02.2015
			// Codigo Alterado	  em 11.07.2016

			if oGet:Picture != NIL
				if oGet:cType != "N" .AND. oGet:cType != "L" .AND. oGet:cType != "D" // Codigo Acrescentado em 29.09.2016
					IF At("@L", oGet:picture) > 0
						cKey	  := Lower( cKey )
					EndIF
					IF At("@U", oGet:picture) > 0
						cKey	  := Upper( cKey )
					EndIF
				endif	
			endif	
			***************************************************************
			IF ( oGet:type == "N" .AND. ( cKey == "." .OR. cKey == "," ) )
				oGet:toDecPos()
			ELSE
				IF nKey = VAR_AGUDO	.OR. ;
					nKey = VAR_CIRCUN .OR. ;
					nKey = VAR_TREMA	.OR. ;
					nKey = VAR_CEDMIN .OR. ;
					nKey = VAR_CEDMAI .OR. ;
					nKey = VAR_GRAVE	.OR. ;
					nKey = VAR_TIL 	.OR. ;
					nKey = VAR_HIFEN
					IF COD_ACENTO $ "[{"                       && Tratamento do cedilha aternativo
						COD_ACENTO += " "                       && Completa tamanho do ACENTO
					Else
						COD_ACENTO += chr( abs( inkey( 0 ) ) ) && Obt�m pr�ximo caractere
					EndIF
					COD_ACENTO = at( COD_ACENTO, VAR_CNF_AC )  && Obt�m caractere correspondente
					IF COD_ACENTO != 0								 && Se existe correspond�ncia
						cKey := SubStr( VAR_CNF_AC, COD_ACENTO + 2, 1 )
					Else													 && Sinaliza erro
						IF ( SET( _SET_BELL ) )
							?? CHR(7)
						ENDIF
					EndiF
				EndIF
		 IF (SET( _SET_INSERT))
			 oGet:insert( cKey )
		 ELSE
			 oGet:overstrike( cKey )
		 ENDIF


		 IF ( oGet:typeOut )
			 IF ( SET( _SET_BELL ) )
				 ?? CHR(7)
			 ENDIF

			 IF ( !SET( _SET_CONFIRM ) )
				 oGet:exitState := GE_ENTER
			 ENDIF
		 ENDIF

	 ENDIF

		ENDIF

	ENDCASE

	RETURN



/***
*
*	GetPreValidate()
*
*	Test entry condition (WHEN clause) for a GET
*
*/
FUNCTION GetPreValidate( oGet )

	LOCAL lSavUpdated
	LOCAL lWhen := .T.

	IF !( oGet:preBlock == NIL )

		lSavUpdated := slUpdated

		lWhen := EVAL( oGet:preBlock, oGet )

		oGet:display()

		ShowScoreBoard()
		slUpdated := lSavUpdated

	ENDIF

	IF ( slKillRead )

		lWhen := .F.
		oGet:exitState := GE_ESCAPE		 // Provokes ReadModal() exit

	ELSEIF ( !lWhen )

		oGet:exitState := GE_WHEN			 // Indicates failure

	ELSE

		oGet:exitState := GE_NOEXIT		 // Prepares for editing

	END

	RETURN ( lWhen )




/***
*
*	GetDoSetKey()
*
*	Process SET KEY during editing
*
*/
PROCEDURE GetDoSetKey( keyBlock, oGet )

	LOCAL lSavUpdated

	// If editing has occurred, assign variable
	IF ( oGet:changed )
		oGet:assign()
		slUpdated := .T.
	ENDIF

	lSavUpdated := slUpdated

	EVAL( keyBlock, scReadProcName, snReadProcLine, ReadVar() )

	ShowScoreboard()
	oGet:updateBuffer()

	slUpdated := lSavUpdated

	IF ( slKillRead )
		oGet:exitState := GE_ESCAPE		// provokes ReadModal() exit
	ENDIF

	RETURN





/***
*					READ services
*/



/***
*
*	Settle()
*
*	Returns new position in array of Get objects, based on:
*		- current position
*		- exitState of Get object at current position
*
*	NOTES: return value of 0 indicates termination of READ
*			 exitState of old Get is transferred to new Get
*
*/
STATIC FUNCTION Settle( GetList, nPos )

	LOCAL nExitState

	IF ( nPos == 0 )
		nExitState := GE_DOWN
	ELSE
		nExitState := GetList[ nPos ]:exitState
	ENDIF

	IF ( nExitState == GE_ESCAPE .or. nExitState == GE_WRITE )
		RETURN ( 0 )					// NOTE
	ENDIF

	IF !( nExitState == GE_WHEN )
		// Reset state info
		snLastPos := nPos
		slBumpTop := .F.
		slBumpBot := .F.
	ELSE
		// Re-use last exitState, do not disturb state info
		nExitState := snLastExitState
	ENDIF

	//
	// Move
	//
	DO CASE
	CASE ( nExitState == GE_UP )
		nPos--

	CASE ( nExitState == GE_DOWN )
		nPos++

	CASE ( nExitState == GE_TOP )
		nPos		  := 1
		slBumpTop  := .T.
		nExitState := GE_DOWN

	CASE ( nExitState == GE_BOTTOM )
		nPos		  := LEN( GetList )
		slBumpBot  := .T.
		nExitState := GE_UP

	CASE ( nExitState == GE_ENTER )
		nPos++

	ENDCASE

	//
	// Bounce
	//
	IF ( nPos == 0 )								// Bumped top
		IF ( !ReadExit() .and. !slBumpBot )
	 slBumpTop	:= .T.
	 nPos 		:= snLastPos
	 nExitState := GE_DOWN
		ENDIF

	ELSEIF ( nPos == len( GetList ) + 1 )	// Bumped bottom
		IF ( !ReadExit() .and. !( nExitState == GE_ENTER ) .and. !slBumpTop )
	 slBumpBot	:= .T.
	 nPos 		:= snLastPos
	 nExitState := GE_UP
		ELSE
	 nPos := 0
		ENDIF
	ENDIF

	// Record exit state
	snLastExitState := nExitState

	IF !( nPos == 0 )
		GetList[ nPos ]:exitState := nExitState
	ENDIF

	RETURN ( nPos )



/***
*
*	PostActiveGet()
*
*	Post active GET for ReadVar(), GetActive()
*
*/
STATIC PROCEDURE PostActiveGet( oGet )

	GetActive( oGet )
	ReadVar( GetReadVar( oGet ) )

	ShowScoreBoard()

	RETURN



/***
*
*	ClearGetSysVars()
*
*	Save and clear READ state variables. Return array of saved values
*
*	NOTE: 'Updated' status is cleared but not saved (S'87 compatibility)
*/
STATIC FUNCTION ClearGetSysVars()

	LOCAL aSavSysVars[ GSV_COUNT ]

	// Save current sys vars
	aSavSysVars[ GSV_KILLREAD ]	  := slKillRead
	aSavSysVars[ GSV_BUMPTOP ] 	  := slBumpTop
	aSavSysVars[ GSV_BUMPBOT ] 	  := slBumpBot
	aSavSysVars[ GSV_LASTEXIT ]	  := snLastExitState
	aSavSysVars[ GSV_LASTPOS ] 	  := snLastPos
	aSavSysVars[ GSV_ACTIVEGET ]	  := GetActive( NIL )
	aSavSysVars[ GSV_READVAR ] 	  := ReadVar( "" )
	aSavSysVars[ GSV_READPROCNAME ] := scReadProcName
	aSavSysVars[ GSV_READPROCLINE ] := snReadProcLine

	// Re-init old ones
	slKillRead		 := .F.
	slBumpTop		 := .F.
	slBumpBot		 := .F.
	snLastExitState := 0
	snLastPos		 := 0
	scReadProcName  := ""
	snReadProcLine  := 0
	slUpdated		 := .F.

	RETURN ( aSavSysVars )



/***
*
*	RestoreGetSysVars()
*
*	Restore READ state variables from array of saved values
*
*	NOTE: 'Updated' status is not restored (S'87 compatibility)
*
*/
STATIC PROCEDURE RestoreGetSysVars( aSavSysVars )

	slKillRead		 := aSavSysVars[ GSV_KILLREAD ]
	slBumpTop		 := aSavSysVars[ GSV_BUMPTOP ]
	slBumpBot		 := aSavSysVars[ GSV_BUMPBOT ]
	snLastExitState := aSavSysVars[ GSV_LASTEXIT ]
	snLastPos		 := aSavSysVars[ GSV_LASTPOS ]

	GetActive( aSavSysVars[ GSV_ACTIVEGET ] )

	ReadVar( aSavSysVars[ GSV_READVAR ] )

	scReadProcName  := aSavSysVars[ GSV_READPROCNAME ]
	snReadProcLine  := aSavSysVars[ GSV_READPROCLINE ]

	RETURN



/***
*
*	GetReadVar()
*
*	Set READVAR() value from a GET
*
*/
STATIC FUNCTION GetReadVar( oGet )

	LOCAL cName := UPPER( oGet:name )
	LOCAL i

	// The following code includes subscripts in the name returned by
	// this FUNCTIONtion, if the get variable is an array element
	//
	// Subscripts are retrieved from the oGet:subscript instance variable
	//
	// NOTE: Incompatible with Summer 87
	//
	IF !( oGet:subscript == NIL )
		FOR i := 1 TO LEN( oGet:subscript )
			cName += "[" + LTRIM( STR( oGet:subscript[i] ) ) + "]"
		NEXT
	END

	RETURN ( cName )





/***
*					System Services
*/



/***
*
*	__SetFormat()
*
*	SET FORMAT service
*
*/
PROCEDURE __SetFormat( b )
	sbFormat := IF( VALTYPE( b ) == "B", b, NIL )
	RETURN



/***
*
*	__KillRead()
*
*	CLEAR GETS service
*
*/
PROCEDURE __KillRead()
	slKillRead := .T.
	RETURN



/***
*
*	GetActive()
*
*	Retrieves currently active GET object
*/
FUNCTION GetActive( g )

	LOCAL oldActive := soActiveGet

	IF ( PCOUNT() > 0 )
		soActiveGet := g
	ENDIF

	RETURN ( oldActive )



/***
*
*	Updated()
*
*/
FUNCTION Updated()
	RETURN slUpdated



/***
*
*	ReadExit()
*
*/
FUNCTION ReadExit( lNew )
	RETURN ( SET( _SET_EXIT, lNew ) )



/***
*
*	ReadInsert()
*
*/
FUNCTION ReadInsert( lNew )
	RETURN ( SET( _SET_INSERT, lNew ) )



/***
*					Wacky Compatibility Services
*/


// Display coordinates for SCOREBOARD
#define SCORE_ROW 	  0
#define SCORE_COL 	  60


/***
*
*	ShowScoreboard()
*
*/
STATIC PROCEDURE ShowScoreboard()

	LOCAL nRow
	LOCAL nCol

	IF ( SET( _SET_SCOREBOARD ) )
		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( IF( SET( _SET_INSERT ), NationMsg(_GET_INSERT_ON),;
					NationMsg(_GET_INSERT_OFF)) )
		SETPOS( nRow, nCol )
	ENDIF

	RETURN



/***
*
*	DateMsg()
*
*/
STATIC PROCEDURE DateMsg()

	LOCAL nRow
	LOCAL nCol

	IF ( SET( _SET_SCOREBOARD ) )

		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( NationMsg(_GET_INVD_DATE) )
		SETPOS( nRow, nCol )

		WHILE ( NEXTKEY() == 0 )
		END

		SETPOS( SCORE_ROW, SCORE_COL )
		DISPOUT( SPACE( LEN( NationMsg(_GET_INVD_DATE) ) ) )
		SETPOS( nRow, nCol )

	ENDIF

	RETURN



/***
*
*	RangeCheck()
*
*	NOTE: Unused second param for 5.00 compatibility.
*
*/
FUNCTION RangeCheck( oGet, junk, lo, hi )

	LOCAL cMsg, nRow, nCol
	LOCAL xValue

	IF ( !oGet:changed )
		RETURN ( .T. ) 			// NOTE
	ENDIF

	xValue := oGet:varGet()

	IF ( xValue >= lo .and. xValue <= hi )
		RETURN ( .T. ) 			// NOTE
	ENDIF

	IF ( SET(_SET_SCOREBOARD) )

		cMsg := NationMsg(_GET_RANGE_FROM) + LTRIM( TRANSFORM( lo, "" ) ) + ;
			NationMsg(_GET_RANGE_TO) + LTRIM( TRANSFORM( hi, "" ) )

		IF ( LEN( cMsg ) > MAXCOL() )
			cMsg := SUBSTR( cMsg, 1, MAXCOL() )
		ENDIF

		nRow := ROW()
		nCol := COL()

		SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
		DISPOUT( cMsg )
		SETPOS( nRow, nCol )

		WHILE ( NEXTKEY() == 0 )
		END

		SETPOS( SCORE_ROW, MIN( 60, MAXCOL() - LEN( cMsg ) ) )
		DISPOUT( SPACE( LEN( cMsg ) ) )
		SETPOS( nRow, nCol )

	ENDIF

	RETURN ( .F. )



/***
*
*	ReadKill()
*
*/
FUNCTION ReadKill( lKill )

	LOCAL lSavKill := slKillRead

	IF ( PCOUNT() > 0 )
		slKillRead := lKill
	ENDIF

	RETURN ( lSavKill )



/***
*
*	ReadUpdated()
*
*/
FUNCTION ReadUpdated( lUpdated )

	LOCAL lSavUpdated := slUpdated

	IF ( PCOUNT() > 0 )
		slUpdated := lUpdated
	ENDIF

	RETURN ( lSavUpdated )



/***
*
*	ReadFormat()
*
*/
FUNCTION ReadFormat( b )

	LOCAL bSavFormat := sbFormat

	IF ( PCOUNT() > 0 )
		sbFormat := b
	ENDIF

	RETURN ( bSavFormat )


FUNCTION GetPsw( oGet )
***********************
LOCAL nTimeSaver := oIni:ReadInteger( 'sistema', 'screensaver', 60 )
LOCAL nRet		  := GE_NOEXIT
LOCAL cKey
LOCAL nKey
LOCAL cAuxVar
LOCAL cOriginal
LOCAL cScreen := savescreen()

IF ( GetPreValidate( oGet ) )
	oGet:setFocus()
	oGet:exitState := GE_NOEXIT
   cAuxVar := cOriginal := oGet:original
	WHILE ( oGet:exitState == GE_NOEXIT )
		IF ( oGet:typeOut )
			oGet:exitState := GE_ENTER
		ENDIF
		WHILE (oGet:exitState == GE_NOEXIT)
			WHILE (( nKey := INKEY( nTimeSaver )) = 0 )
				//Protela()
				Shuffle()
			ENDDO
	DO CASE
	CASE ( nKey == K_UP )
      cAuxVar := cOriginal
      oGet:undo()
		oGet:exitState := GE_UP

	CASE ( nKey == K_SH_TAB )
		oGet:exitState := GE_UP

	CASE ( nKey == K_DOWN )
		oGet:exitState := GE_DOWN

	CASE ( nKey == K_TAB )
		oGet:exitState := GE_ENTER // GE_DOWN

	CASE ( nKey == K_ENTER )
		oGet:exitState := GE_ENTER

	CASE ( nKey == K_ESC )
		IF ( SET( _SET_ESCAPE ) )
         cAuxVar := cOriginal
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		ENDIF

	CASE ( nKey == K_ALT_F4 )
		IF ( SET( _SET_ESCAPE ) )
         cAuxVar := cOriginal
			oGet:undo()
			oGet:exitState := GE_ESCAPE
		ENDIF

	CASE ( nKey == K_PGUP )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_PGDN )
		oGet:exitState := GE_WRITE

	CASE ( nKey == K_CTRL_HOME )
		oGet:exitState := GE_TOP

	CASE ( nKey == K_CTRL_PGDN )
		oGet:exitState := GE_BOTTOM

	CASE ( nKey == K_CTRL_PGUP )
		oGet:exitState := GE_TOP

#ifdef CTRL_END_SPECIAL

	// Both ^W and ^End go to the last GET
	CASE ( nKey == K_CTRL_END )
		oGet:exitState := GE_BOTTOM

#else

	// Both ^W and ^End terminate the READ (the default)
	CASE ( nKey == K_CTRL_W )
		oGet:exitState := GE_WRITE

#endif


	CASE ( nKey == K_INS )
		SET( _SET_INSERT, !SET( _SET_INSERT ) )
		ShowScoreboard()

	CASE ( nKey == K_UNDO )
		oGet:undo()

	CASE ( nKey == K_HOME )
		oGet:home()

	CASE ( nKey == K_END )
		oGet:end()

	CASE ( nKey == K_RIGHT )
		oGet:right()

	CASE ( nKey == K_LEFT )
		oGet:left()

	CASE ( nKey == K_CTRL_RIGHT )
		oGet:wordRight()

	CASE ( nKey == K_CTRL_LEFT )
		oGet:wordLeft()

	CASE ( nKey == K_BS )
      cAuxVar := STUFF(cAuxVar, oGet:pos - 1, 1, " ")
		oGet:backSpace()

	CASE ( nKey == K_DEL )
		oGet:delete()

	CASE ( nKey == K_CTRL_T )
		oGet:delWordRight()

	CASE ( nKey == K_CTRL_Y )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_DEL )
		oGet:delEnd()

	CASE ( nKey == K_CTRL_BS )
		oGet:delWordLeft()

	OTHERWISE
				IF (nKey >= LOW) .AND. (nKey <= HIGH)
					cKey := CHR(nKey)
					cAuxVar := STUFF(cAuxVar, oGet:pos, 1, cKey)
					oGet:insert(ECHO_CHAR)
					IF (oGet:typeOut)
						oGet:exitState := GE_ENTER
					ENDIF
				ENDIF
         ENDCASE
		EndDO
      cBuffer     := oGet:Buffer
      IF (!GetPostValidate(oGet, cAuxVar))
			oGet:exitState := GE_NOEXIT
		ENDIF
      //oGet:Buffer := cBuffer
      //oget:varput( cBuffer )
      //oget:end()
	EndDO
EndIF
// De-activate GET
oGet:killFocus()
restscreen(,,,,cScreen)
Return(cAuxVar)


/***
*	GetPostValidate()
*	Test exit condition (VALID clause) for a GET
*	NOTE: Bad dates are rejected in such a way as to preserve edit buffer
*/
FUNCTION GetPostValidate(oGet, cAuxVar)
***************************************
	LOCAL lSavUpdated
	LOCAL lValid := .T.

	IF ( oGet:exitState == GE_ESCAPE )
		RETURN ( lValid ) 						// NOTE
	ENDIF

   IF ( oGet:exitState == GE_UP )
		RETURN ( lValid ) 						// NOTE
	ENDIF

	IF oGet:Buffer = "00/00/00"
		oGet:assign()
		oGet:updateBuffer()
		Return( lValid )
	EndIF

	IF ( oGet:badDate() )
		oGet:home()
      Alert("ERRO: Data invalida.")
		oGet:Undo()
		RETURN( !lValid )
	ENDIF

   /*
   IF ( oGet:exitState == GE_ENTER )
      IF cAuxVar != NIL
         IF (oGet:buffer == Space(Len(oget:buffer)))
            oGet:Undo()
            oGet:home()
            oGet:Buffer := cAuxVar
            oGet:Varput( cAuxVar )
            oGet:assign()
            oGet:home()
            RETURN( .F. )
         ENDIF
      ENDIF
   ENDIF
   */

	// If editing occurred, assign the new value to the variable
	IF ( oGet:changed )
		oGet:assign()
		slUpdated := .T.
	ENDIF

   oGet:reset()

	// Check VALID condition if specified
   cBuffer := oGet:Buffer
	IF !( oGet:postBlock == NIL )

		lSavUpdated := slUpdated

		// S'87 compatibility
		SETPOS( oGet:row, oGet:col + LEN( oGet:buffer ) )
      
		/*
		IF !(cAuxVar == NIL)
         oGet:Buffer := cAuxVar
         oGet:Varput( cAuxVar )
         oGet:assign()
      EndIF
		*/
		
		lValid := EVAL( oGet:postBlock, oGet )

		// Reset S'87 compatibility cursor position
		SETPOS( oGet:row, oGet:col )

		ShowScoreBoard()
      /*
		* Codigo Acrescentado em 08.08.2016
		*/
		oGet:cType := ValType(cBuffer) // necessario quando parametro por referencia altera tipo
		oGet:updateBuffer()
		slUpdated  := lSavUpdated

		IF ( slKillRead )
			oGet:exitState := GE_ESCAPE		// Provokes ReadModal() exit
			lValid := .T.

		ENDIF
	ENDIF
	
	/*
   IF cAuxVar != NIL
      oGet:buffer := cBuffer
      oGet:VarPut( cBuffer )
		oGet:end()
   EndIF
		
   IF !lValid
      IF (oGet:buffer == Space(Len(oget:buffer)))
         oGet:home()
      endif
   endif
	*/

	RETURN ( lValid )

class Tget from GET
	EXPORTED:
		VAR cType

endclass

