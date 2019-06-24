/*
 * Backup utility for Leto db server
 *
 * Copyright 2012 Pavel Tsarenko <tpe2@mail.ru>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this software; see the file COPYING.  If not, write to
 * the Free Software Foundation, Inc., 59 Temple Place, Suite 330,
 * Boston, MA 02111-1307 USA (or visit the web site http://www.gnu.org/).
 *
 * As a special exception, the Harbour Project gives permission for
 * additional uses of the text contained in its release of Harbour.
 *
 * The exception is that, if you link the Harbour libraries with other
 * files to produce an executable, this does not by itself cause the
 * resulting executable to be covered by the GNU General Public License.
 * Your use of that executable is in no way restricted on account of
 * linking the Harbour library code into it.
 *
 * This exception does not however invalidate any other reasons why
 * the executable file might be covered by the GNU General Public License.
 *
 * This exception applies only to the code released by the Harbour
 * Project under the name Harbour.  If you copy code from other
 * Harbour Project or Free Software Foundation releases into a copy of
 * Harbour, as the General Public License permits, the exception does
 * not apply to the code that you add in this way.  To avoid misleading
 * anyone as to the status of such modified files, you must delete
 * this exception notice from them.
 *
 * If you write modifications of your own for Harbour, it is your choice
 * whether to permit this exception to apply to your modifications.
 * If you do not wish that, delete this exception notice.
 *
 */

/*

# letobackup.ini file sample

# Server connect string
Server   = //127.0.0.1:2812
# Database path at the server
DataPath = c:\database
# Database directory to backup
DataBase = /data1/
# Backup directory
Backup   = c:\backup\
# File masks to backup
Mask     = *.dbf,*.fpt,*.dbt
# If Lock=1, trying to lock server before backup
Lock     = 1
#Lock     = &if(hb_Hour(hb_DateTime())==12, "1", "0")
# Timeout in seconds
Seconds  = 30
#
# If Wait=1, it's need succesfull server lock to backup
Wait     = 1
# Command string to execute archivator after backup
ArcCmd   = "C:\Program files\7-zip\7z.exe" a -r c:\arc\data%dt%_%tm% c:\backup\*.*
#ArcCmd   = "C:\Program files\7-zip\7z.exe" a -r c:\arc\data[DTOS(Date())+if(hb_Hour(hb_DateTime())==7,"","_"+StrZero(hb_Hour(hb_DateTime()),2))] c:\backup\*.*
# eof letobackup.ini

*/

#include "dbinfo.ch"
#include "rddleto.ch"

#ifdef __PLATFORM__WINDOWS
#define DEF_SEP "\"
#else
#define DEF_SEP "/"
#endif

STATIC cDB := ""
STATIC cDir := ""
STATIC cOutDir := ""
STATIC cMask := ""
STATIC lLock := .T.
STATIC cDriver := "DBFNTX"

FUNCTION Main( cAddress, cUser, cPasswd )

   LOCAL nRes, lLocked := .F.
   LOCAL cDirBase := hb_DirBase()
   LOCAL aIni := RdIni( cDirBase + "letodb.ini" ), ai
   LOCAL nSecs := 30
   LOCAL lWait := .T.
   LOCAL cArc
   LOCAL lSuccess := .F.
   LOCAL nSec
   LOCAL lCopyTo
   LOCAL n1, n2
   LOCAL cPort := ""

REQUEST leto, dbfntx, dbfcdx
REQUEST StrZero
REQUEST hb_DateTime, hb_Hour, hb_Minute, hb_Sec
AltD()

rddSetDefault( "LETO" )
SET DELETED OFF

IF ! Empty( aIni )
FOR EACH ai in aIni[ 1, 2 ]
IF ai[ 1 ] == "SERVER"
cAddress := ai[ 2 ]
ELSEIF ai[ 1 ] == "PORT"
cPort := ai[ 2 ]
ELSEIF ai[ 1 ] == "USER"
cUser := ai[ 2 ]
ELSEIF ai[ 1 ] == "PASSWORD"
cPasswd := ai[ 2 ]
ELSEIF ai[ 1 ] == "DATAPATH"
cDB := ai[ 2 ]
ELSEIF ai[ 1 ] == "DATABASE"
cDir := ai[ 2 ]
ELSEIF ai[ 1 ] == "DEFAULT_DRIVER"
cDriver := "DBF" + ai[ 2 ]
ELSEIF ai[ 1 ] == "BACKUP"
cOutDir := ai[ 2 ]
ELSEIF ai[ 1 ] == "MASK"
cMask := ai[ 2 ]
ELSEIF ai[ 1 ] == "LOCK"
lLock := ( IniParam( ai[ 2 ] ) = "1" )
ELSEIF ai[ 1 ] == "SECONDS"
nSecs := Val( ai[ 2 ] )
ELSEIF ai[ 1 ] == "WAIT"
lWait := ( IniParam( ai[ 2 ] ) = "1" )
ELSEIF ai[ 1 ] == "ARCCMD"
cArc := ai[ 2 ]
ENDIF
NEXT
ENDIF

IF cAddress == Nil
? "Server address is absent ..."
RETURN NIL
ELSEIF Empty( cDir )
? "Source directory is absent ..."
RETURN NIL
ELSEIF Empty( cOutDir )
? "Output directory is absent ..."
RETURN NIL
ENDIF

IF ! ( Left( cAddress, 2 ) == "//" )
cAddress := "//" + cAddress + IF( ! Empty( cPort ), ":" + cPort, "" ) + "/"
ENDIF
? "Connecting to " + cAddress
IF ( LETO_CONNECT( cAddress, cUser, cPasswd ) ) == -1
nRes := LETO_CONNECT_ERR()
IF nRes == LETO_ERR_LOGIN
? "Login failed"
ELSEIF nRes == LETO_ERR_RECV
? "Recv Error"
ELSEIF nRes == LETO_ERR_SEND
? "Send Error"
ELSE
? "No connection"
ENDIF

RETURN NIL
ENDIF
? "Connected to " + LETO_GETSERVERVERSION()

IF lLock
? "Trying to lock server..."
nSec := Seconds()
lLocked := LETO_LOCKLOCK( .T., nSecs )
? if( lLocked, "Success", "Failure" ), Seconds() - nSec, " seconds"
ENDIF

IF ! lLock .OR. lLocked .OR. ! lWait
lCopyTo := ( cOutDir = StrTran( cDB + cDir, "/", DEF_SEP ) )
Backup( cAddress, lCopyTo )
lSuccess := .T.
ENDIF

IF lLocked
? "Unlocking server ..."
LETO_LOCKLOCK( .F. )
? if( LETO_LOCKLOCK( .F. ), "Failure", "Success" )
ENDIF
? "Backup finished"

IF lSuccess .AND. ! Empty( cArc )
/* leto_udf("leto_backuptables","/tmp/bak/DATEN") */
? 'Runnung archivator'
IF ( n1 := At( "[", cArc ) ) != 0 .AND. ( n2 := At( "]", cArc ) ) != 0 .AND. n2 > n1
cArc := Left( cArc, n1 - 1 ) + &( SubStr( cArc, n1 + 1, n2 - n1 -1 ) ) + SubStr( cArc, n2 + 1 )
ELSE
cArc := StrTran( cArc, "%dt%", DToS( Date() ) )
cArc := StrTran( cArc, "%tm%", StrTran( Time(), ":", "_" ) )
ENDIF
RUN ( cArc )
? "Done."
ENDIF

Inkey( 12 )

   RETURN NIL

STATIC FUNCTION IniParam( cPar )
   RETURN if( cPar = "&", &( SubStr( cPar, 2 ) ), cPar )

STATIC FUNCTION Backup( cAddress, lCopyTo )

   LOCAL aFiles := {}, af, aDirs := {}, cd
   LOCAL aTables
   LOCAL nFiles := 0, nTables := 0
   LOCAL aMask
   LOCAL nSec := Seconds()

   IF Right( cDir, 1 ) != "/"
      cDir += "/"
   ENDIF
   IF Right( cOutDir, 1 ) != DEF_SEP
      cOutDir += DEF_SEP
   ENDIF
   IF Right( cAddress, 1 ) = "/" .AND. cDir = "/"
      cAddress := Left( cAddress, Len( cAddress ) -1 )
   ENDIF
   aMask := hb_ATokens( Lower( cMask ), "," )

   ? "Get list of opened tables..."
   aTables := LETO_MGGETTABLES()
   AEval( aTables, {| a| a[ 2 ] := StrTran( a[ 2 ], DEF_SEP, "/" ) } )
   ? LTrim( Str( Len( aTables ) ) ) + " tables found"

   ? "Scanning directory tree..."
   GetFiles( aFiles, cDir, aMask, aDirs )
   ? LTrim( Str( Len( aFiles ) ) ) + " files found"

   ? "Checking directories..."
   FOR EACH cd in aDirs
      cd := cOutDir + SubStr( cd, Len( cDir ) + 1 )
      IF ! hb_DirExists( cd )
         hb_DirCreate( cd )
      ENDIF
   NEXT
   ? "Copying files..."
   FOR EACH af in aFiles
      MakeCopy( cAddress, cDB, aTables, cDir, cOutDir, af, @nFiles, @nTables, lCopyTo )
   NEXT

   ? LTrim( Str( nFiles ) ) + " files and " + LTrim( Str( nTables ) ) + " tables copied", Seconds() - nSec, " seconds"

   RETURN NIL

STATIC FUNCTION IsMatch( aMask, cFileName )

   LOCAL lMatch := .F., cMask

   FOR EACH cMask in aMask
      IF hb_WildMatch( cMask, cFileName, .T. )
         lMatch := .T.
         EXIT
      ENDIF
   NEXT

   RETURN lMatch

STATIC FUNCTION MakeCopy( cAddress, cDB, aTables, cDir, cOutDir, af, nFiles, nTables, lCopyTo )

   LOCAL cNewFile := cOutDir + SubStr( StrTran( af[ 1 ], "/", DEF_SEP ), Len( cDir ) + 1 )
   LOCAL ad := Directory( cNewFile ), i
   LOCAL cTable

   IF Empty( ad ) .OR. Abs( ad[ 1, 2 ] - af[ 2 ] ) > 2 .OR. ad[ 1, 3 ] != af[ 3 ] .OR. ad[ 1, 4 ] != af[ 4 ]

      SetPos( Row(), 0 )
      IF AScan( aTables, {| a| Lower( a[ 2 ] ) == Lower( af[ 1 ] ) } ) != 0

         ?? PadR( "Copying table " + af[ 1 ], MaxCol() )
         // LETO_BACKUP_TABLES
         dbUseArea( .T.,, cAddress + af[ 1 ], "leto_old", .T., .T. )
         IF ( i := RAt( DEF_SEP, cNewFile ) ) # 0
            cNewFile := Left( cNewFile, i ) + SubStr( Lower( cNewFile ), i + 1 )
         ENDIF
         hb_rddInfo( RDDI_MEMOTYPE, dbInfo( DBI_MEMOTYPE ), cDriver )
         hb_rddInfo( RDDI_MEMOEXT, dbInfo( DBI_MEMOEXT ), cDriver )

         SELECT leto_old
         SET ORDER TO 0
         IF lCopyTo

            cTable := cAddress + StrTran( SubStr( cNewFile, Len( cDB ) + 1 ), DEF_SEP, "/" )
            COPY to ( cTable ) all

         ELSE

            dbCreate( cNewFile, dbStruct(), cDriver, .T., "dbf_new" )
            SELECT leto_old
            LETO_SETSKIPBUFFER( 1000 )
            GO TOP
            WHILE ! Eof()
               dbf_new->( dbAppend() )
               FOR i := 1 TO FCount()
                  dbf_new->( FieldPut( i, leto_old->( FieldGet( i ) ) ) )
               NEXT
               IF Deleted()
                  dbf_new->( dbDelete() )
               ENDIF
               SKIP
            ENDDO
            dbf_new->( dbCloseArea() )

         ENDIF

         CLOSE
         hb_FSetDateTime( cNewFile, af[ 3 ], af[ 4 ] )
         nTables++

      ELSEIF ! IsMemoFile( aTables, Lower( af[ 1 ] ) )

         ?? PadR( "Copying file  " + af[ 1 ], MaxCol() )
         __CopyFile( cDB + af[ 1 ], cNewFile )
         hb_FSetDateTime( cNewFile, af[ 3 ], af[ 4 ] )
         nFiles++

      ELSEIF IsMemoFile( aTables, Lower( af[ 1 ] ) )

         nFiles++

      ENDIF
   ENDIF

   RETURN NIL

STATIC FUNCTION GetFiles( aFiles, cDir, aMask, aDirs )

   LOCAL aDir := LETO_DIRECTORY( cDir, "D" ), ad

   AAdd( aDirs, StrTran( cDir, "/", DEF_SEP ) )
   FOR EACH ad in aDir
      IF "D" $ ad[ 5 ]
         IF ! ( ad[ 1 ] = "." .OR. cDir = ad[ 1 ] .OR. StrTran( cDB + cDir + ad[ 1 ] + "/", "/", DEF_SEP ) == cOutDir )
            GetFiles( aFiles, cDir + ad[ 1 ] + "/", aMask, aDirs )
         ENDIF
      ELSEIF IsMatch( aMask, Lower( ad[ 1 ] ) )
         AAdd( aFiles, { cDir + ad[ 1 ], ad[ 2 ], ad[ 3 ], ad[ 4 ], ad[ 5 ] } )
      ENDIF
   NEXT

   RETURN NIL

STATIC FUNCTION IsMemoFile( aTables, cFileName )
   RETURN ( Right( cFileName, 4 ) = '.dbt' .OR. Right( cFileName, 4 ) = '.fpt' ) .AND. ;
      AScan( aTables, {| a| Lower( a[ 2 ] ) = Left( cFileName, Len( cFileName ) -3 ) } ) # 0
