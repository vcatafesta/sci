#include "classic.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"
#Define  OK    .T.
#Define  FALSO .F.

ANNOUNCE Profile
#ifndef _FILEIO_CH
   #include "FileIO.ch"
#endif
#ifndef _SET_CH
   #include "Set.ch"
#endif
#ifndef _CRLF
   #define  _CRLF    CHR(13) + CHR(10)
#endif

BEGIN CLASS TIni
Export:
    Var File
    Var Handle
    Var Aberto
    Var Separador
Export:
    METHOD Init
    METHOD ReadBool
    METHOD ReadInteger
    METHOD ReadString
    METHOD ReadDate
    MESSAGE Write        METHOD IniWrite
    MESSAGE WriteBool    METHOD IniWrite
    MESSAGE WriteInteger METHOD IniWrite
    MESSAGE WriteString  METHOD IniWrite
    MESSAGE WriteDate    METHOD IniWrite
    MESSAGE Destroy      METHOD IniClose
    MESSAGE Free         METHOD IniClose
    MESSAGE Close        METHOD IniClose
    MESSAGE Open         METHOD IniOpen
    MESSAGE Create       METHOD Init
End Class

METHOD PROCEDURE Init ( cFile )
*******************************
::File      := cFile
::Separador := ';'
IF RAT( ".", ::File ) == 0
   ::File := UPPER( ALLTRIM( cFile )) + ".INI"
ENDIF
::Open()
::Close()
Return( Self )

METHOD IniClose
***************
FCLOSE( ::Handle )
::Aberto := .F.
Return( Self )

METHOD IniOpen
**************
::Handle := FOPEN( ::File, FO_READWRITE + FO_SHARED )
IF FERROR() == 2
   ::Handle := FCREATE( ::File, 0 )
EndIF
::Aberto := .T.
Return( Self )

METHOD IniWrite( cSection, cKey, xValue )
*****************************************
LOCAL lRetCode,      ; // Function's return code
		cType,         ; // Data type of the value
		cOldValue,     ; // Current value
		cNewValue,     ; // New value to be written
		cBuffer,       ; // Buffer for the read
		nFileLen,      ; // Length of the file in bytes
		nSecStart,     ; // Start position in the file of the section
		nSecEnd,       ; // Ending position in the file of the section
		nSecLen,       ; // Initial length of the section
		cSecBuf,       ; // Section subtring
		nKeyStart,     ; // Start position in the file of the key
		nKeyEnd,       ; // Ending position in the file of the key
		nKeyLen,       ; // Initial length of the key
		lProceed,      ; // .T. if proceeding with the change
		cChar            // Single character read from file

IF LEFT( cSection, 1 ) <> "["
	cSection := "[" + cSection
ENDIF
IF RIGHT( cSection, 1 ) <> "]"
	cSection += "]"
ENDIF
lProceed := .F.
nSecLen  := 0
cType    := VALTYPE( xValue )
DO CASE
	CASE cType == "C"
		cNewValue := xValue
   CASE cType == "N"
		cNewValue := ALLTRIM( STR( xValue ))
   CASE cType == "L"
		cNewValue := IF( xValue, "1", "0" )
   CASE cType == "D"
		cNewValue := DTOS( xValue )
   OTHERWISE
		cNewValue := ""
ENDCASE
::Open()
IF ::Handle > 0
   nFileLen := FSEEK( ::Handle, 0, FS_END )
   FSEEK( ::Handle, 0 , FS_SET )
   cBuffer := SPACE( nFileLen )
   IF FREAD( ::Handle, @cBuffer, nFileLen ) == nFileLen
		nSecStart := AT( cSection, cBuffer )
      IF nSecStart > 0
			nSecStart += LEN( cSection ) + 2 // Length of cSection + CR/LF
			cSecBuf := RIGHT( cBuffer, nFileLen - nSecStart + 1 )
         IF !EMPTY( cSecBuf )
				nSecEnd := AT( "[", cSecBuf )
				IF nSecEnd > 0
					cSecBuf := LEFT( cSecBuf, nSecEnd - 1 )
				ENDIF
            nSecLen := LEN( cSecBuf )
				nKeyStart := AT( cKey, cSecBuf )
            IF nKeyStart > 0
					nKeyStart += LEN( cKey ) + 1
					nKeyEnd   := nKeyStart
               cOldValue := cChar := ""
               DO WHILE cChar <> CHR(13)
						cChar := SUBSTR( cSecBuf, nKeyEnd, 1 )
                  IF cChar <> CHR(13)
							cOldValue += cChar
                     ++ nKeyEnd
						ENDIF
					ENDDO
					nKeyLen := LEN( cOldValue )
					cSecBuf := STUFF( cSecBuf, nKeyStart, nKeyLen, cNewValue )
               lProceed := .T.
				ELSE
					cSecBuf := cKey + "=" + cNewValue + _CRLF + cSecBuf
               lProceed := .T.
				ENDIF
			ENDIF
		ELSE
         cSecBuf := cSection + _CRLF + cKey + "=" + cNewValue + _CRLF + _CRLF
         lProceed := .T.
		ENDIF
	ENDIF
   IF lProceed
		IF nSecStart == 0
			nSecStart := LEN( cBuffer )
		ENDIF
      cBuffer := STUFF( cBuffer, nSecStart, nSecLen, cSecBuf )
      ::Close()
      ::Handle := FCREATE( ::File, 0 )
      IF FWRITE( ::Handle, cBuffer ) == LEN( cBuffer )
			lRetCode := .T.
		ENDIF
	ENDIF
ENDIF
::Close()

METHOD ReadString( cSection, cKey, cDefault, nPos )
***************************************************
LOCAL cString, cBuffer, nFileLen, nSecPos
LOCAL cSecBuf, nKeyPos, cChar
LOCAL xTemp

IF LEFT( cSection, 1 ) <> "["
	cSection := "[" + cSection
ENDIF
IF RIGHT( cSection, 1 ) <> "]"
	cSection += "]"
ENDIF
IF cDefault == NIL
	cDefault := ""
ENDIF
cString := cDefault
::Open()
IF ::Handle > 0
   nFileLen := FSEEK( ::Handle, 0, FS_END )
   FSEEK( ::Handle, 0 , FS_SET )
   cBuffer := SPACE( nFileLen )
   IF FREAD( ::Handle, @cBuffer, nFileLen ) == nFileLen
		nSecPos := AT( cSection, cBuffer )
		IF nSecPos > 0
         cSecBuf := Upper(RIGHT( cBuffer, nFileLen - ( nSecPos + LEN( cSection ))))
			IF !EMPTY( cSecBuf )
				nSecPos := AT( "[", cSecBuf )
				IF nSecPos > 0
               cSecBuf := Upper(LEFT( cSecBuf, nSecPos - 1 ))
				ENDIF
            nKeyPos := AT( Upper(cKey), cSecBuf )
            IF nKeyPos > 0
               nKeyPos += LEN( Upper(cKey )) + 1
               cString := cChar := ""
               DO WHILE cChar <> CHR(13)
						cChar := SUBSTR( cSecBuf, nKeyPos, 1 )
                  IF cChar <> CHR(13)
							cString += cChar
                     ++ nKeyPos
						ENDIF
					ENDDO
				ENDIF
			ENDIF
		ENDIF
	ENDIF
   ::Close()
ENDIF
IF nPos = NIL .OR. nPos = 0
   RETURN cString
Else
   xTemp := StrExtract( cString, ::Separador, nPos )
   IF Empty( xTemp )
      RETURN( cDefault )
   EndIF
   RETURN( xTemp )
EndIF

METHOD ReadBool( cSection, cKey, lDefault, nPos )
*************************************************
LOCAL cValue, cDefault, nValue

IF lDefault == NIL
   lDefault := FALSO
ENDIF
cValue   := ::ReadString( cSection, cKey, nPos )
IF EMPTY( cValue )
   Return( lDefault )
ENDIF
RETURN ( nValue := VAL( cValue )) == 1

METHOD ReadDate( cSection, cKey, dDefault, nPos )
*******************************************
LOCAL cDateFmt, cValue, cDefault, dDate

IF VALTYPE( dDefault ) <> "D"
	dDefault := CTOD( "" )
ENDIF
dDate    := dDefault
cDefault := ALLTRIM( DTOS( dDefault ))
cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
IF !EMPTY( cValue )
	dDate := CTOD( cValue )
   IF EMPTY( dDate )
		cDateFmt := SET(_SET_DATEFORMAT, "mm/dd/yy" )
      dDate := CTOD( SUBSTR( cValue, 5, 2 ) + "/" + RIGHT( cValue, 2 ) + "/" + LEFT( cValue, 4 ))
      SET(_SET_DATEFORMAT, cDateFmt )
	ENDIF
ENDIF
RETURN dDate

METHOD ReadInteger( cSection, cKey, nDefault, nPos )
****************************************************
LOCAL cValue, cDefault, nValue

IF nDefault == NIL
	nDefault := 0
ENDIF
nValue   := nDefault
cDefault := ALLTRIM( STR( nDefault ))
cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
IF !EMPTY( cValue )
	nValue := VAL( cValue )
ENDIF
RETURN nValue

Function TIniNew( cFile )
*************************
Return( TIni():New( cFile ))
