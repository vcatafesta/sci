#include "hbclass.ch"
#include "inkey.ch"
#require "hbziparc"

/*
#ifdef __PLATFORM__WINDOWS
   REQUEST HB_GT_WVT_DEFAULT
   #define THREAD_GT hb_gtVersion()
#else
   REQUEST HB_GT_STD_DEFAULT
   #define THREAD_GT "XWC"
#endif
*/

function main()
   cls
	? Infinity(.t.)
	? CharMix( "ABC", "123" )    // "A1B2C3"
	? CharMix( "ABCDE", "12" )   // "A1B2C1D2E1"
	? CharMix( "AB", "12345" )   // "A1B2"
	? CharMix( "HELLO", " " )    //  "H E L L O "
	? CharMix( "HELLO", "" )     //  "HELLO"
	? CharSList( "Hello World !" ) 
	main14()
	Inkey(0)


function main0()
	Local str1 := e"Hello\r\nWorld \x21\041\x21\000abcdefgh"
	Local t1 := {^ 2012-11-28 10:22:30 }   // ??? {^ 2012/11/28 10:22:30 }
	Local t2 := t"2009-03-21 17:31:45.437" // ??? t"2009-03-21T17:31:45.437"
	Local d1 := 0d20161110  // Template: 0dYYYYMMDD
	Local n := 0x1F

	Local o1 := HSamp1():New()
	Local o2 := HSamp2():New()
	 
	? o1:x, o2:x                        // 10       20
	? o1:Calc( 2,3 ), o2:Mul( 2,3 )     // 60      120
	? o1:Sum( 5 )                       // 15
	?
	 
	? n
	? d1
	? t1 + 1      // 11/29/12 10:22:30.000
	? t1 - t2     // 1347.701905
	? str1
	return nil
 
********************************************************************************************** 

CLASS HSamp1
	DATA x   INIT 10
   METHOD New()  INLINE Self
   METHOD Sum( y )  BLOCK {|Self,y|::x += y}
   METHOD Calc( y,z ) EXTERN fr1( y,z )
ENDCLASS
 
CLASS HSamp2
   DATA x   INIT 20
   METHOD New()  INLINE Self
   METHOD Mul( y,z ) EXTERN fr1( y,z )
ENDCLASS
 
Function fr1( y, z )
	Local o := QSelf()
	Return o:x * y * z

********************************************************************************************** 

FUNCTION Main2
   LOCAL oTable
   oTable := Table():Create( "sample.dbf", { {"F1","C", 10, 0 }, {"F2","N", 8, 0}})
   oTable:AppendRec()
   oTable:F1 := "FirstRec"
   oTable:F2 := 1
   oTable:AppendRec()
   ? oTable:nRec                // 2
   oTable:nRec := 1
   ? oTable:nRec                // 1
   ? oTable:F1	                 // "FirstRec"     1
	? oTable:F2						  //  1
   ?
   RETURN nil
 
CLASS Table
   METHOD Create( cName, aStru )
   METHOD AppendRec()   INLINE dbAppend()
   METHOD nRec( n )     SETGET
   ERROR HANDLER OnError( xParam )
ENDCLASS
 
METHOD Create( cName, aStru ) CLASS Table
   dbCreate( cName, aStru )
   USE (cName) NEW EXCLUSIVE
	RETURN Self
 
METHOD nRec( n ) CLASS Table
   IF n != Nil
      dbGoTo( n )
   ENDIF
	RETURN Recno()
 
METHOD OnError( xParam ) CLASS Table
	Local cMsg := __GetMessage(), cFieldName, nPos
	Local xValue
	
   IF Left( cMsg, 1 ) == '_'
      cFieldName := Substr( cMsg,2 )
   ELSE
      cFieldName := cMsg
   ENDIF
   IF ( nPos := FieldPos( cFieldName ) ) == 0
      Alert( cFieldName + " wrong field name!" )
   ELSEIF cFieldName == cMsg
      RETURN FieldGet( nPos )
   ELSE
      FieldPut( nPos, xParam )
   ENDIF
	Return Nil

********************************************************************************************** 

function main3()
	Local c := "alles", s := "abcdefghijk"
	FOR EACH c IN @s
		IF c $ "aei"
			c := UPPER( c )
		ENDIF
	NEXT
	? s      // AbcdEfghIjk
	? s      // alles

proc main4()
   local funcSym
   funcSym := @str()
   ? funcSym:name, "=>", funcSym:exec( 123.456, 10, 5 )
   funcSym := &( "@upper()" )
   ? funcSym:name, "=>", funcSym:exec( "Harbour" )
return

FUNCTION Main5
local harr := hb_Hash( "six", 6, "eight", 8, "eleven", 11 )
 
   harr[10] := "str1"
   harr[23] := "str2"
   harr["fantasy"] := "fiction"
 
   ? harr[10], harr[23]                                   // str1  str2
   ? harr["eight"], harr["eleven"], harr["fantasy"]       // 8       11  fiction
   ? len(harr)                                            // 6
   ?
 
   RETURN nil
	
	
FUNCTION Main6()
   LOCAL cVar := Space( 20 )
 
   CLEAR SCREEN
 
   IF !hb_mtvm()
      ? "There is no support for multi-threading, clocks will not be seen."
      WAIT
   ELSE
      hb_threadStart( @Show_Time() )
   ENDIF
 
   @ 10, 10 SAY "Enter something:" GET cVar
   READ
   SetPos( 12, 0 )
   ? "You enter -> [" + cVar + "]"
   WAIT
 
proc main11( cGT )
   local i, aThreads

   if ! hb_mtvm()
      ? "This program needs HVM with MT support"
		wait
      quit
   endif

   if empty( cGT )
      cGT := THREAD_GT
   endif

   if  cGT == "QTC" .and. ! cGT == hb_gtVersion()
      /* QTC have to be initialized in main thread */
      hb_gtReload( cGT )
   endif

   ? "Starting threads..."
   aThreads := {}
   for i := 1 to 3
      aadd( aThreads, hb_threadStart( @thFunc(), cGT ) )
      ? i, "=>", atail( aThreads )
   next

   ? "Waiting for threads"
   while inkey() != K_ESC
      if hb_threadWait( aThreads, 0.1, .T. ) == len( aThreads )
         wait
         exit
      endif
      ?? "."
   enddo
return

proc thFunc( cGT )
   /* allocate own GT driver */
   hb_gtReload( cGT )
   if ! dbExists( "test" ) .and. dbExists( "../test" )
      use ../test shared
   else
      use test shared
   endif
   browse()
return
 
 
   RETURN Nil
 
FUNCTION Show_Time()
   LOCAL cTime
 
   DO WHILE .T.
      cTime := Dtoc( Date() ) + " " + Time()
      hb_dispOutAt( 0, MaxCol() - Len( cTime ) + 1, cTime, "GR+/N" )
      hb_idleSleep( 1 )
   ENDDO
 
   RETURN nil	
	
	
	Function main7()
   
     LOCAL hPessoa  := hb_hash()
     LOCAL hPessoas := hb_hash()
     LOCAL nPessoa  := 0 
     LOCAL nPessoas := 1000
   
     SET CENTURY ON
     SET DATE TO BRITISH 
     SET DATE FORMAT "mm/dd/yyyy"
   
     hPessoa["PESSOA"] := hb_hash()
     hb_HSetCaseMatch( hPessoa["PESSOA"] , .F. )
   
     hPessoa["PESSOA"]["NOME"]        := "BlackTDN"
     hPessoa["PESSOA"]["NASCIMENTO"]  := Ctod("01/01/2012")
     hPessoa["PESSOA"]["SEXO"]        := "M"
     hPessoa["PESSOA"]["PAIS"]        := "Brasil"
     hPessoa["PESSOA"]["ENDEREÇO"]    := "http://blacktdn.com.br"
     hPessoa["PESSOA"]["CEP"]         := "00000-000"
   
     ? 'hPessoa["PESSOA"]["NOME"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "NOME" ) ))
     ? 'hPessoa["PESSOA"]["NOME"] :' + hb_hGet( hPessoa["PESSOA"] , "NOME" )
     ? hb_OsNewLine()
     
     ? 'hPessoa["PESSOA"]["NASCIMENTO"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "NASCIMENTO" ) ))
     ? 'hPessoa["PESSOA"]["NASCIMENTO"] :' + dtoc( hb_hGet( hPessoa["PESSOA"] , "NASCIMENTO" ) )
     ? hb_OsNewLine()
   
     ? 'hPessoa["PESSOA"]["SEXO"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "SEXO" )))
     ? 'hPessoa["PESSOA"]["SEXO"] :' + hb_hGet( hPessoa["PESSOA"] , "SEXO" )
     ? hb_OsNewLine()
     
     ? 'hPessoa["PESSOA"]["PAIS"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "PAIS" )))
     ? 'hPessoa["PESSOA"]["PAIS"] :' + hb_hGet( hPessoa["PESSOA"] , "PAIS" )
     ? hb_OsNewLine()
     
     ? hb_AnsiToOem('hPessoa["PESSOA"]["ENDEREÇO"] :') + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "ENDEREÇO" ) ))
     ? hb_AnsiToOem('hPessoa["PESSOA"]["ENDEREÇO"] :') + hb_hGet( hPessoa["PESSOA"] , "ENDEREÇO" )
     ? hb_OsNewLine()
     
     ? 'hPessoa["PESSOA"]["CEP"] :' + LTrim(str( hb_hPos( hPessoa["PESSOA"] , "CEP" ) ))
     ? 'hPessoa["PESSOA"]["CEP"] :' + hb_hGet( hPessoa["PESSOA"] , "CEP" )
     ? hb_OsNewLine()
     
     For nPessoa := 1 To nPessoas
        hPessoas[nPessoa]                         := hb_hClone(hPessoa)
        hPessoas[nPessoa]["PESSOA"]["NOME"]       += ' ' + StrZero(nPessoa,4)
        IF ( ( nPessoa % 2 ) == 0 )
           hPessoas[nPessoa]["PESSOA"]["NASCIMENTO"] := YearSum( hPessoas[nPessoa]["PESSOA"]["NASCIMENTO"] , nPessoa )
        Else
           hPessoas[nPessoa]["PESSOA"]["NASCIMENTO"] := YearSub( hPessoas[nPessoa]["PESSOA"]["NASCIMENTO"] , nPessoa )
        EndIF
     Next nPessoa
     
     FOR EACH hPessoa in hPessoas
     
        ? 'hPessoa["PESSOA"]["NOME"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "NOME" ) ))
        ? 'hPessoa["PESSOA"]["NOME"] :' + hb_hGet( hPessoa["PESSOA"] , "NOME" )
        ? hb_OsNewLine()
        
        ? 'hPessoa["PESSOA"]["NASCIMENTO"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "NASCIMENTO" ) ))
        ? 'hPessoa["PESSOA"]["NASCIMENTO"] :' + dtoc( hb_hGet( hPessoa["PESSOA"] , "NASCIMENTO" ) )
        ? hb_OsNewLine()
   
        ? 'hPessoa["PESSOA"]["SEXO"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "SEXO" )))
        ? 'hPessoa["PESSOA"]["SEXO"] :' + hb_hGet( hPessoa["PESSOA"] , "SEXO" )
        ? hb_OsNewLine()
        
        ? 'hPessoa["PESSOA"]["PAIS"] :' + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "PAIS" )))
        ? 'hPessoa["PESSOA"]["PAIS"] :' + hb_hGet( hPessoa["PESSOA"] , "PAIS" )
        ? hb_OsNewLine()
        
        ? hb_AnsiToOem('hPessoa["PESSOA"]["ENDEREÇO"] :') + LTrim(str(hb_hPos( hPessoa["PESSOA"] , "ENDEREÇO" ) ))
        ? hb_AnsiToOem('hPessoa["PESSOA"]["ENDEREÇO"] :') + hb_hGet( hPessoa["PESSOA"] , "ENDEREÇO" )
        ? hb_OsNewLine()
        
        ? 'hPessoa["PESSOA"]["CEP"] :' + LTrim(str( hb_hPos( hPessoa["PESSOA"] , "CEP" ) ))
        ? 'hPessoa["PESSOA"]["CEP"] :' + hb_hGet( hPessoa["PESSOA"] , "CEP" )
        ? hb_OsNewLine()
   
     NEXT EACH \\hPessoa
     
     inkey(0)
   
  Return( .T. )
   
  Function Day2Str( uData )
     Local cType := ValType( uData )
  IF ( cType == "D" )
     Return( StrZero( Day( uData ) , 2 ) )
  ElseIF ( cType == "N" )
     Return( StrZero( uData , 2 ) )
  ElseIF ( cType == "C" )
     Return( StrZero( Val( uData ) , 2 ) )
  EndIF
   
  Function Month2Str( uData )
     Local cType := ValType( uData )
  IF ( cType == "D" )
     Return( StrZero( Month( uData ) , 2 ) )
  ElseIF ( cType == "N" )
     Return( StrZero( uData , 2 ) )
  ElseIF ( cType == "C" )
     Return( StrZero( Val( uData ) , 2 ) )
  EndIF
   
  Function Year2Str( uData )
     Local cType := ValType( uData )
  IF ( cType == "D" )
     Return( StrZero( Year( uData ) , 4 ) )
  ElseIF ( cType == "N" )
     Return( StrZero( uData , 4 ) )
  ElseIF ( cType == "C" )
     Return( StrZero( Val( uData ) , 4 ) )
  EndIF
   
  Function Last_Day( dDate )
   
     Local nMonth
     Local nYear
   
     IF ( ValType( dDate ) == "C" )
        dDate := CToD( dDate )   
     EndIF
   
     nMonth := ( Month( dDate ) + 1 )
     nYear  := Year( dDate )
     IF ( nMonth > 12 )
        nMonth := 1
        ++nYear
     EndIF
   
     dDate := CToD( "01/" + Month2Str( nMonth ) + "/" + Year2Str( nYear ) )
     dDate -= 1
   
  Return( Day( dDate ) )
   
  Function YearSum( dDate , nYear )
   
     Local nMonthAux := Month( dDate )
     Local nDayAux   := Day( dDate )
     Local nYearAux  := Year( dDate )
   
     nYearAux += nYear
     dDate := Ctod( Day2Str( nDayAux ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
     IF Empty( dDate )
        dDate   := Ctod( Day2Str( 1 ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
        nDayAux := Last_Day( dDate )
        dDate   := Ctod( Day2Str( nDayAux ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
     EndIF
   
  Return( dDate )
   
  Function YearSub( dDate , nYear )
   
     Local nMonthAux := Month( dDate )
     Local nDayAux   := Day( dDate )
     Local nYearAux  := Year( dDate )
   
     nYearAux -= nYear
     dDate := Ctod( Day2Str( nDayAux ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
     IF Empty( dDate )
        dDate   := Ctod( Day2Str( 1 ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
        nDayAux := Last_Day( dDate )
        dDate   := Ctod( Day2Str( nDayAux ) + "/" + Month2Str( nMonthAux ) + "/" + Year2Str( nYearAux ) )
     EndIF
   
  Return( dDate )
	
#pragma BEGINDUMP
	#include <extend.h>
	#include <math.h>
	#include <conio.h>
	
	HB_FUNC( SIN )
	{
		double x = hb_parnd(1);
		hb_retnd( sin( x ) );
	}
#pragma ENDDUMP

proc main10()
   local funcSym
   funcSym := @str()
   ? funcSym:name, ":", funcSym:exec( 123.456, 10, 5 )
	funcSym := &("@upper()")
   ? funcSym:name, ":", funcSym:exec("Harbour")	
	funcSym := &("@time()")
   ? funcSym:name, ":", funcSym:exec()
	funcSym := &("@main6()")
   ? funcSym:name, ":", funcSym:exec()		
	
return



/*
 * $Id: memtst.prg 13932 2010-02-20 11:57:17Z vszakats $
 */

/*
 * Harbour Project source code:
 *    a small memory mangaer test code
 */

#include "simpleio.ch"

#define N_LOOPS   100000

#ifdef __HARBOUR__
   #include "hbmemory.ch"
#endif

proc main12()
local nCPUSec, nRealSec, i, a

#ifdef __HARBOUR__
if MEMORY( HB_MEM_USEDMAX ) != 0
   ?
   ? "Warning !!! Memory statistic enabled."
endif
#endif
?
? date(), time(), VERSION()+build_mode()+", "+OS()

?
? "testing single large memory blocks allocation and freeing..."
nRealSec := seconds()
nCPUSec := hb_secondsCPU()
for i := 1 to N_LOOPS
    a := space( 50000 )
next
a := NIL
nCPUSec := hb_secondsCPU() - nCPUSec
nRealSec := seconds() - nRealSec
? " CPU time:", nCPUSec, "sec."
? "real time:", nRealSec, "sec."

?
? "testing many large memory blocks allocation and freeing..."
nRealSec := seconds()
nCPUSec := hb_secondsCPU()
a := array(100)
for i := 1 to N_LOOPS
    a[ i % 100 + 1 ] := space( 50000 )
    if i % 200 == 0
       afill(a,"")
    endif
next
a := NIL
nCPUSec := hb_secondsCPU() - nCPUSec
nRealSec := seconds() - nRealSec
? " CPU time:", nCPUSec, "sec."
? "real time:", nRealSec, "sec."

?
? "testing large memory block reallocation with intermediate allocations..."
? "Warning!!! some compilers may badly fail here"
wait

nRealSec := seconds()
nCPUSec := hb_secondsCPU()
a := {}
for i := 1 to N_LOOPS
   aadd( a, {} )
   if i%1000 == 0
      ?? i
   endif
next
nCPUSec := hb_secondsCPU() - nCPUSec
nRealSec := seconds() - nRealSec
? " CPU time:", nCPUSec, "sec."
? "real time:", nRealSec, "sec."
wait
return

function build_mode()
#ifdef __CLIP__
   return " (MT)"
#else
   #ifdef __XHARBOUR__
      return iif( HB_MULTITHREAD(), " (MT)", "" ) + ;
             iif( MEMORY( HB_MEM_USEDMAX ) != 0, " (FMSTAT)", "" )
   #else
      #ifdef __HARBOUR__
         return iif( HB_MTVM(), " (MT)", "" ) + ;
                iif( MEMORY( HB_MEM_USEDMAX ) != 0, " (FMSTAT)", "" )
      #else
         #ifdef __XPP__
            return " (MT)"
         #else
            return ""
         #endif
      #endif
   #endif
#endif

#if __HARBOUR__ < 0x010100
FUNCTION HB_MTVM()
   RETURN .F.
#endif


proc clock()
   
   cls
   hb_threadStart( @thFuncClock() )
   
   @1,1 SAY "Pulsa tecla para salir"
   inkey( 0 )
  
return

proc thFuncClock()

   while .t.
       DispOutAt( 2, 1, Time() )
       hb_idleSleep( 1 )
   end
   
return 

PROCEDURE Main14()

   IF hb_ZipFile( "test.zip", "test.prg" )
      ? "File was successfully created"
   ENDIF

   IF hb_ZipFile( "test1.zip", { "test.prg", "test.hbp" } )
      ? "File was successfully created"
   ENDIF

   IF hb_ZipFile( "test2.zip", { "test.prg", "test.hbp" }, 9, {| cFile, nPos | QOut( cFile ) } )
      ? "File was successfully created"
   ENDIF

   aFiles := { "test.prg", "test.hbp" }
   nLen   := Len( aFiles )
   aGauge := GaugeNew( 5, 5, 7, 40, "W/B", "W+/B" , "." )
   GaugeDisplay( aGauge )
   hb_ZipFile( "test33.zip", aFiles, 9, {| cFile, nPos | GaugeUpdate( aGauge, nPos / nLen ) },, "hello" )
   RETURN