/*
 ??????????????????????????????????????
?   Function......: BrowText()                                             ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 12, 1994                                           ?
?                                                                          ?
?   Notes.........: Browsing of a text file.                               ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nTop				NUMERIC                                 ?
?                      Top Row Position on Screen                          ?
?                   nLeft          NUMERIC                                 ?
?                      Left Column Position on Screen                      ?
?                   nBottom        NUMERIC                                 ?
?                      Bottom Row Position on Screen                       ?
?                   nRight         NUMERIC                                 ?
?                      Right Column Position on Screen                     ?
?                   cFileName      CHARACTER                               ?
?                      Name of file to browse                              ?
?                   [lFrame]       LOGICAL                                 ?
?                      Display a frame around the browse window            ?
?                                                                          ?
?   Returns.......: NIL                                                    ?
?                                                                          ?
?   Functions.....: FileInit(), Skipper(), GetLast(),        					 ?
?                   GetFirst(), GoPrevLn(), GoNextLn(),                    ?
?                   FReadLn(), TBrowse(), StdMeth()                        ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/

#include "inkey.ch"

#xtranslate FALSE            => .F.
#xtranslate TRUE             => .T.
#xtranslate CR               => Chr(13)
#xtranslate LF               => Chr(10)
#xtranslate CRLF             => CR + LF

#command DEFAULT <variable1> TO <value1> [, <variableN> TO <valueN> ] => ;
         IF <variable1> == NIL; <variable1> := <value1>; END;
         [; IF <variableN> == NIL; <variableN> := <valueN>; END ]


STATIC cLine,		;	// Current Line
		 nFileSize		// File Size

#include "fileio.ch"

#define FTELL(nHandle)  FSEEK(nHandle, 0, FS_RELATIVE)

#define MAX_LINE_LEN 256

FUNCTION BrowText( nTop, nLeft, nBottom, nRight, cFileName, lFrame )
LOCAL oBrowse,		;	// Browse Object
		oCol,			;	// Browse Column Object
		nHandle			// File Handle

DEFAULT nTop TO 0, nLeft TO 0, nBottom TO MAXROW(), nRight TO MAXCOL(), ;
	lFrame TO TRUE

// Open the file
nHandle := FileInit(cFileName)
IF nHandle == 0
   RETURN NIL
ENDIF

// Display the frame adjust the coordinates for the browse object
IF lFrame

	DISPBOX(nTop, nLeft, nBottom, nRight)
	nTop++
	nLeft++
	nBottom--
	nRight--

ENDIF

// Create the browse object
oBrowse := TBROWSENEW(nTop, nLeft, nBottom, nRight)

// Create the first column object
oCol := TBCOLUMNNEW(, {|| cLine })
oCol:width := (nRight - nLeft) + 1
oBrowse:addColumn(oCol)

// Create the second column object
oCol := TBCOLUMNNEW(, {|| SUBSTR(cLine, (nRight - nLeft) + 2) })
oCol:width := (nRight - nLeft) + 1
oBrowse:addColumn(oCol)

// Browse movement blocks
oBrowse:goBottomBlock := {|| GetLast(nHandle) }
oBrowse:goTopBlock    := {|| GetFirst(nHandle) }
oBrowse:skipBlock 	 := {|n| Skipper(n, nHandle) }

// Activate it...
TBrowse(oBrowse)

// Close the file
FCLOSE(nHandle)

RETURN NIL

/*
 ??????????????????????????????????????
?   Function......: Skipper()                                              ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Attempts to skip a specified number of rows in the     ?
?                   browse window.                                         ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nSkip          NUMERIC                                 ?
?                      Number of rows to skip                              ?
?                   nHandle        NUMERIC                                 ?
?                      File Handle                                         ?
?                                                                          ?
?                                                                          ?
?   Returns.......: Number of rows successfully skipped                    ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION Skipper( nSkip, nHandle )

LOCAL nSkipped := 0

// Skip down 
IF nSkip > 0
	DO WHILE nSkipped != nSkip .AND. GoNextLn( nHandle )
		nSkipped++
	ENDDO
// Skip Up
ELSE
	DO WHILE nSkipped != nSkip .AND. GoPrevLn( nHandle )
		nSkipped--
	ENDDO
ENDIF

RETURN (nSkipped)

/*
 ??????????????????????????????????????
?   Function......: FileInit                                               ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 12, 1994                                           ?
?                                                                          ?
?   Notes.........: Initialize the file to browse                          ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nFname         CHARACTER                               ?
?                      Name of file to initialize                          ?
?                                                                          ?
?                                                                          ?
?   Returns.......: File Handle                                            ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION FileInit( nFname )
LOCAL nHandle			// File Handle

IF (nHandle := FOPEN(nFname)) > 0
	FSEEK(nHandle, 0, FS_END)
	nFileSize := FTELL(nHandle)
	GetFirst(nHandle)
ENDIF

RETURN (nHandle)

/*
 ??????????????????????????????????????
?   Function......: GetLast()                                              ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Moves to the last line of the file                     ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nHandle        NUMERIC                                 ?
?                      File Handle                                         ?
?                                                                          ?
?   Returns.......: NIL                                                    ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION GetLast( nHandle )

FSEEK(nHandle, -1, FS_END)
GoPrevLn( nHandle )

RETURN NIL

/*
 ??????????????????????????????????????
?   Function......: GetFirst()                                             ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Moves the file pointer to the first line of the file.  ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nHandle        NUMERIC                                 ?
?                      File Handle                                         ?
?                                                                          ?
?                                                                          ?
?   Returns.......: NIL                                                    ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION GetFirst( nHandle )

FSEEK(nHandle, 0, FS_SET)
FReadLn(nHandle, @cline)
FSEEK(nHandle, 0, FS_SET)

RETURN NIL


/*
 ??????????????????????????????????????
?   Function......: GoPrevLn                                               ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Move the file pointer to the previous line of the file.?
?                                                                          ?
?                                                                          ?
?   Parameters....: nHandle        NUMERIC                                 ?
?                      File Handle                                         ?
?                                                                          ?
?                                                                          ?
?   Returns.......: TRUE if move was successful, or FALSE otherwise.       ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION GoPrevLn( nHandle )

LOCAL nOrigPos,	;	// Original File Pointer Position
		nMaxRead, 	;	// Maximum Line Length
		nNewPos, 	;	// New File Pointer Position
      lMoved, 		;	// Pointer Moved
      cBuff, 		;	// Line buffer
      nWhereCrLf, ;	// Position of CRLF
      nPrev				// Previous File Pointer Position

// Save Original file position
nOrigPos := FTELL(nHandle)

IF nOrigPos = 0
	lMoved := FALSE
ELSE
	lMoved := TRUE
	IF nOrigPos != nFileSize
		//  Skip over preceeding CR / LF
		FSEEK(nHandle, -2, FS_RELATIVE)
	ENDIF
	nMaxRead := MIN(MAX_LINE_LEN, FTELL(nHandle))

	// Capture the line into a buffer, strip off the CRLF
	cBuff := SPACE(nMaxRead)
	nNewPos := FSEEK(nHandle, -nMaxRead, FS_RELATIVE)
	FREAD(nHandle, @cBuff, nMaxRead)
	nWhereCrLf := RAT(CRLF, cBuff)

	IF nWhereCrLf = 0
		nPrev := nNewPos
		cLine = cBuff
	ELSE
		nPrev := nNewPos + nWhereCrLf + 1
		cline := SUBSTR(cBuff, nWhereCrLf + 2)
	ENDIF

	// Move to the beginning of the line
	FSEEK(nHandle, nPrev, FS_SET)

ENDIF

RETURN (lMoved)

/*
 ??????????????????????????????????????
?   Function......: GoNext                                                 ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Try to move the File Pointer to the next line of the   ?
?                   file.                                                  ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nHandle        NUMERIC                                 ?
?                      File Handle                                         ?
?                                                                          ?
?                                                                          ?
?   Returns.......: TRUE if move was successful, or FALSE otherwise.       ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION GoNextLn( nHandle )

LOCAL nSavePos,		;	// Save File pointer position
      cBuff := "", 	;	// Line Buffer
      lMoved, 			;	// Pointer Moved
      nNewPos				// New File Pointer Position

// Save the file pointer position
nSavePos := FTELL(nHandle)

// Find the end of the current line
FSEEK(nHandle, LEN(cLine) + 2, FS_RELATIVE)
nNewPos := FTELL(nHandle)
// Read in the next line
IF FReadLn(nHandle, @cBuff)
	lMoved := TRUE
	cLine := cBuff
	FSEEK(nHandle, nNewPos, FS_SET)
ELSE
	lMoved := FALSE
	FSEEK(nHandle, nSavePos, FS_SET)
ENDIF

RETURN (lMoved)

/*
 ??????????????????????????????????????
?   Function......: FReadLn()                                              ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Reads the current line of the file into a buffer       ?
?                                                                          ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nHandle        NUMERIC                                 ?
?                      File Handle Number                                  ?
?                   cBuffer        CHARACTER                               ?
?                      Line Buffer                                         ?
?                                                                          ?
?   Returns.......: TRUE if anything was read in.                          ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION FReadLn( nHandle, cBuffer )

LOCAL nEOL, 	;	// End Of Line Postion
		nRead, 	;	// Number of characters read
		nSaveFPos	// Saved File Postion

cBuffer = SPACE(MAX_LINE_LEN)

// First save current file pointer
nSaveFPos = FTELL(nHandle)
nRead = FREAD(nHandle, @cBuffer, MAX_LINE_LEN)

IF (nEOL := AT(CRLF, SUBSTR(cBuffer, 1, nRead))) = 0
	// Line overflow or eof
	// Cline has the line we need
ELSE
	// Copy up to EOL
	cBuffer = SUBSTR(cBuffer, 1, nEOL - 1)
	// Position file pointer to next line
	FSEEK(nHandle, nSaveFPos + nEOL + 1, FS_SET)
ENDIF

RETURN (nRead != 0)

/*
 ??????????????????????????????????????
?   Function......: TBrowse()                                              ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Pass tbrowse() a tbrowse object, and up to three code  ?
?                   blocks. The first is the code block to check for keys  ?
?                   before checking the standard keys, the second          ?
?                   indicates how long the user stays in the browse, the   ?
?                   third code block to check keys after the standard 		 ?
?                   keys have been checked.                                ?
?                                                                          ?
?   Parameters....: oBrowse		   OBJECT                                  ?
?                      TBrowse Object                                      ?
?                   [bBefore]      BLOCK                                   ?
?                      Block to handle before keys                         ?
?                   [bWhileCond]   BLOCK                                   ?
?                      Block to exit of browse                             ?
?                   [bAfter]       BLOCK                                   ?
?                      Block to handle after keys                          ?
?                                                                          ?
?   Returns.......: NIL                                                    ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION TBrowse( oBrowse, bBefore, bWhileCond, bAfter )

LOCAL nKey, 			;	// ASCII Key Pressed
		lExitRequested 	// Exit Requested

DEFAULT bBefore TO {|nKey| IF(nKey == K_ENTER .OR. nKey == K_ESC, ;
	lExitRequested := TRUE, FALSE) }

DEFAULT bWhileCond TO {|| !lExitRequested}

DEFAULT bAfter TO {|| FALSE}

lExitRequested := FALSE

DO WHILE EVAL(bWhileCond, oBrowse)
	DO WHILE NEXTKEY() = 0 .AND. !oBrowse:stabilize()
	ENDDO

	nKey = INKEY(0)
	IF EVAL(bBefore, nKey, oBrowse)
		// Processed key as before key
	ELSEIF StdMeth(nKey, oBrowse)
		// Processed key as standard key
	ELSEIF oBrowse:stable .AND. EVAL(bAfter, nKey, oBrowse)
		// Processed key as after key
	ENDIF
ENDDO

RETURN NIL

/*
 ??????????????????????????????????????
?   Function......: StdMeth                                                ?
???????????????????????????????????????
?   ORIGINAL                                                               ?
?   Programmer....: Rick Spence                                            ?
?   Date..........: NA                                                     ?
?                                                                          ?
?   LAST MODIFICATION                                                      ?
?   Author........: Mark Nowakowski                                        ?
?   Date..........: May 10, 1994                                           ?
?                                                                          ?
?   Notes.........: Process standard keys of browse                        ?
?                                                                          ?
?                                                                          ?
?                                                                          ?
?   Parameters....: nKey           NUMERIC                                 ?
?                      ASCII Code of key pressed                           ?
?                   oBrowse         OBJECT                                 ?
?                      Tbrowse Object                                      ?
?                                                                          ?
?   Returns.......: TRUE if key handled correctly.                         ?
?                                                                          ?
???????????????????????????????????????
???????????????????????????????????
*/
STATIC FUNCTION StdMeth( nKey, oBrowse )

LOCAL lKeyHandled := TRUE	// Key Processed

DO CASE
	CASE nKey = K_DOWN
		oBrowse:down()
	CASE nKey = K_UP
		oBrowse:up()
	CASE nKey = K_PGDN
		oBrowse:pageDown()
	CASE nKey = K_PGUP
		oBrowse:pageUp()
	CASE nKey = K_CTRL_PGUP
		oBrowse:goTop()
	CASE nKey = K_CTRL_PGDN
		oBrowse:goBottom()
	CASE nKey = K_RIGHT
		oBrowse:right()
	CASE nKey = K_LEFT
		oBrowse:left()
	CASE nKey = K_HOME
		oBrowse:home()
	CASE nKey = K_END
		oBrowse:end()
	CASE nKey = K_CTRL_LEFT
		oBrowse:panLeft()
	CASE nKey = K_CTRL_RIGHT
		oBrowse:panRight()
	CASE nKey = K_CTRL_HOME
		oBrowse:panHome()
	CASE nKey = K_CTRL_END
		oBrowse:panEnd()
	OTHERWISE
		lKeyHandled := FALSE
ENDCASE

RETURN (lKeyHandled)
