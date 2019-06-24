/*
 * This sample demonstrates how to use file functions with Leto db server
 * EnableFileFunc = 1 must be set in server's letodb.ini
 */
REQUEST LETO
#include "rddleto.ch"
#include "fileio.ch"

FUNCTION Main( cPath )

   LOCAL cBuf, arr, i, lTmp, nTmp, nHandle
   LOCAL nPort := 2812

   // ALTD()
   IF Empty( cPath )
      cPath := "//127.0.0.1:2812/"
   ELSE
      cPath := "//" + cPath + iif( ":" $ cPath, "", ":" + AllTrim( Str( nPort ) ) )
      cPath += iif( Right( cPath, 1 ) == "/", "", "/" )
   ENDIF

   ? "Hey, LetoDBf:", LETO_PING()
	

   ? "Connect to " + cPath + " - "
   IF ( LETO_CONNECT( cPath ) ) == -1
      ? "Error connecting to server:", LETO_CONNECT_ERR(), LETO_CONNECT_ERR( .T. )
      WAIT
      RETURN NIL
   ELSE
      ?? "Ok"
   ENDIF
	? Leto_getservermode()
	? Leto_getserverversion()
	? leto_GETCURRENTCONNECTION()
	? leto_GETLOCALIP()
	? leto_SMBSERVER()

   ? "Hey, LetoDBf:", LETO_PING()

	#ifndef __XHARBOUR__
   ? 'leto_FCreate( "T.TXT", 0 ) - '
   nHandle := LETO_FCREATE( "TEST3.TXT", 0 )   
   ? nHandle, ValType( nHandle )
   ? leto_ferror()
	
   Inkey( 0 )
   ?? iif( nHandle >= 0, "Ok", "Failure -- no further tests leto_F*() test" )
   IF nHandle >= 0
      ? "Press any key to continue..."
      Inkey( 0 )
      ? 'leto_FClose( nHandle ) - '
      ?? iif( LETO_FCLOSE( nHandle ),  "Ok", "Failure" )
      ?? iif( ! LETO_FCLOSE( nHandle ),  "!", "Fail" )
      ? 'leto_FOpen( "test3.txt", READWRITE ) - '
      nHandle := LETO_FOPEN( "test3.txt", FO_READWRITE )
      ?? iif( nHandle >= 0, "Ok", "Failure" )
      IF nHandle >= 0
         ? 'leto_FWrite( nHandle, "testx12" ) - '
         nTmp := LETO_FWRITE( nHandle, "testx21" )
         ?? iif( nTmp == 7, "Ok", "Failure" )
         ? 'leto_FSeek( nHandle, 4, 0 ) - '
         nTmp := LETO_FSEEK( nHandle, 4, 0 )
         ?? iif( nTmp == 4, "Ok", "Failure" )
         LETO_FWRITE( nHandle, "3" )
         ? 'leto_FSeek( nHandle, 0, 2 ) - '
         nTmp := LETO_FSEEK( nHandle, 0, 2 )
         ?? iif( nTmp == 7, "Ok", "Failure" )
         ?? " --- EOF - " + iif( LETO_FEOF( nHandle ), "Ok", "Failure" )
         LETO_FWRITE( nHandle, "0" + Chr( 0 ) )
         cBuf := Space( 12 )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FRead( nHandle, @cBuf, 10 ) - '
         nTmp := LETO_FREAD( nHandle, @cBuf, 10 )
         ?? iif( nTmp == 9, "Ok", "Failure" )
         ?? iif( Len( cBuf ) == 12 .AND. Left( cBuf, 9 ) == "test3210" + Chr( 0 ), " !!", "" )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FReadSTR( nHandle, 10 ) - '
         cBuf := LETO_FREADSTR( nHandle, 10 )
         ?? iif( Len( cBuf ) == 8 .AND. Left( cBuf, 8 ) == "test3210", "Ok", "Failure" )
         LETO_FSEEK( nHandle, 0, 0 )
         ? 'leto_FReadLEN( nHandle, 10 ) - '
         cBuf := LETO_FREADLEN( nHandle, 10 )
         ?? iif( Len( cBuf ) == 9 .AND. Left( cBuf, 9 ) == "test3210" + Chr( 0 ), "Ok", "Failure" )
         LETO_FCLOSE( nHandle )
         ?
      ENDIF
      ? "Press any key to continue..."
      Inkey( 0 )
      LETO_FERASE( "test3.txt" )
   ENDIF
	
#endif
