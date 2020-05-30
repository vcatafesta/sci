#include <sci.ch>

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

class TIni
Export:
    Var File
    Var Handle
    Var Aberto
    Var Separador
Export:
    METHOD New CONSTRUCTOR
    METHOD ReadBool
    METHOD ReadInteger
    METHOD ReadString
    METHOD ReadDate
    METHOD Write     
	 METHOD Close    
	 METHOD Open       
	 
    MESSAGE WriteBool    METHOD Write
    MESSAGE WriteInteger METHOD Write
    MESSAGE WriteString  METHOD Write
    MESSAGE WriteDate    METHOD Write
	 MESSAGE Destroy      METHOD Close
    MESSAGE Free         METHOD Close
    MESSAGE Create       METHOD New
	 	 
EndClass

METHOD New( cFile ) class Tini
*******************
::File      := cFile
::Separador := ';'
if RAT( ".", ::File ) == 0
   ::File := UPPER( ALLTRIM( cFile )) + ".INI"
endif
::Open()
::Close()
return( Self )

METHOD Close() class Tini
***************
FCLOSE( ::Handle )
::Aberto := .F.
return( Self )

METHOD Open() class Tini
**************
::Handle := FOPEN( ::File, FO_READWRITE + FO_SHARED )
if FERROR() == 2
   ::Handle := FCREATE( ::File, 0 )
endif
::Aberto := .T.
return( Self )

METHOD Write( cSection, cKey, xValue ) class Tini
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

if LEFT( cSection, 1 ) <> "["
	cSection := "[" + cSection
endif
if RIGHT( cSection, 1 ) <> "]"
	cSection += "]"
endif
lProceed := .F.
nSecLen  := 0
cType    := VALTYPE( xValue )
DO CASE
	CASE cType == "C"
		cNewValue := xValue
   CASE cType == "N"
		cNewValue := ALLTRIM( STR( xValue ))
   CASE cType == "L"
		cNewValue := if( xValue, "1", "0" )
   CASE cType == "D"
		cNewValue := DTOS( xValue )
   OTHERWISE
		cNewValue := ""
ENDCASE
::Open()
if ::Handle > 0
   nFileLen := FSEEK( ::Handle, 0, FS_END )
   FSEEK( ::Handle, 0 , FS_SET )
   cBuffer := SPACE( nFileLen )
   if FREAD( ::Handle, @cBuffer, nFileLen ) == nFileLen
		nSecStart := AT( cSection, cBuffer )
      if nSecStart > 0
			nSecStart += LEN( cSection ) + 2 // Length of cSection + CR/LF
			cSecBuf := RIGHT( cBuffer, nFileLen - nSecStart + 1 )
         if !EMPTY( cSecBuf )
				nSecEnd := AT( "[", cSecBuf )
				if nSecEnd > 0
					cSecBuf := LEFT( cSecBuf, nSecEnd - 1 )
				endif
            nSecLen := LEN( cSecBuf )
				nKeyStart := AT( cKey, cSecBuf )
            if nKeyStart > 0
					nKeyStart += LEN( cKey ) + 1
					nKeyEnd   := nKeyStart
               cOldValue := cChar := ""
               DO WHILE cChar <> CHR(13)
						cChar := SUBSTR( cSecBuf, nKeyEnd, 1 )
                  if cChar <> CHR(13)
							cOldValue += cChar
                     ++ nKeyEnd
						endif
					ENDDO
					nKeyLen := LEN( cOldValue )
					cSecBuf := STUFF( cSecBuf, nKeyStart, nKeyLen, cNewValue )
               lProceed := .T.
				else
					cSecBuf := cKey + "=" + cNewValue + _CRLF + cSecBuf
               lProceed := .T.
				endif
			endif
		else
         cSecBuf := cSection + _CRLF + cKey + "=" + cNewValue + _CRLF + _CRLF
         lProceed := .T.
		endif
	endif
   if lProceed
		if nSecStart == 0
			nSecStart := LEN( cBuffer )
		endif
      cBuffer := STUFF( cBuffer, nSecStart, nSecLen, cSecBuf )
      FSEEK( ::Handle, 0 , FS_SET )
     
	  
      //if !FTruncate( ::Handle )
      //   ::Close()
      //   ::Handle := FCREATE( ::File, 0 )
      //endif
     
      if FWRITE( ::Handle, cBuffer ) == LEN( cBuffer )
			lRetCode := .T.
		endif
	endif
endif
::Close()

METHOD ReadString( cSection, cKey, cDefault, nPos ) class Tini
***************************************************
LOCAL cString, cBuffer, nFileLen, nSecPos
LOCAL cSecBuf, nKeyPos, cChar
LOCAL xTemp

if LEFT( cSection, 1 ) <> "["
	cSection := "[" + cSection
endif
if RIGHT( cSection, 1 ) <> "]"
	cSection += "]"
endif
if cDefault == NIL
	cDefault := ""
endif
cString := cDefault
::Open()
if ::Handle > 0
   nFileLen := FSEEK( ::Handle, 0, FS_END )
   FSEEK( ::Handle, 0 , FS_SET )
   cBuffer := SPACE( nFileLen )
   if FREAD( ::Handle, @cBuffer, nFileLen ) == nFileLen
		nSecPos := AT( cSection, cBuffer )
		if nSecPos > 0
         cSecBuf := RIGHT( cBuffer, nFileLen - ( nSecPos + LEN( cSection )))
			if !EMPTY( cSecBuf )
				nSecPos := AT( "[", cSecBuf )
				if nSecPos > 0
					cSecBuf := LEFT( cSecBuf, nSecPos - 1 )
				endif
				nKeyPos := AT( cKey, cSecBuf )
            if nKeyPos > 0
					nKeyPos += LEN( cKey ) + 1
               cString := cChar := ""
               DO WHILE cChar <> CHR(13)
						cChar := SUBSTR( cSecBuf, nKeyPos, 1 )
                  if cChar <> CHR(13)
							cString += cChar
                     ++ nKeyPos
						endif
					ENDDO
				endif
			endif
		endif
	endif
   ::Close()
endif
if nPos = NIL .OR. nPos = 0
   return cString
else
   xTemp := StrExtract( cString, ::Separador, nPos )
   if Empty( xTemp )
      return( cDefault )
   endif
   return( xTemp )
endif

METHOD ReadBool( cSection, cKey, lDefault, nPos ) class Tini
*************************************************
LOCAL cValue, cDefault, nValue

if lDefault == NIL
   lDefault := FALSO
endif
cValue   := ::ReadString( cSection, cKey, nPos )
if EMPTY( cValue )
   return( lDefault )
endif
return ( nValue := VAL( cValue )) == 1

METHOD ReadDate( cSection, cKey, dDefault, nPos ) class Tini
*******************************************
LOCAL cDateFmt, cValue, cDefault, dDate

if VALTYPE( dDefault ) <> "D"
	dDefault := CTOD( "" )
endif
dDate    := dDefault
cDefault := ALLTRIM( DTOS( dDefault ))
cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
if !EMPTY( cValue )
	dDate := CTOD( cValue )
   if EMPTY( dDate )
		cDateFmt := SET(_SET_DATEFORMAT, "mm/dd/yy" )
      dDate := CTOD( SUBSTR( cValue, 5, 2 ) + "/" + RIGHT( cValue, 2 ) + "/" + LEFT( cValue, 4 ))
      SET(_SET_DATEFORMAT, cDateFmt )
	endif
endif
return dDate

METHOD ReadInteger( cSection, cKey, nDefault, nPos ) class Tini
****************************************************
LOCAL cValue, cDefault, nValue

if nDefault == NIL
	nDefault := 0
endif
nValue   := nDefault
cDefault := ALLTRIM( STR( nDefault ))
cValue   := ::ReadString( cSection, cKey, cDefault, nPos )
if !EMPTY( cValue )
	nValue := VAL( cValue )
endif
return nValue

Function TIniNew( cFile )
*************************
return( TIni():New( cFile ))
