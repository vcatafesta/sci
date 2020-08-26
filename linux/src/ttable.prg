#include "hbclass.ch"

FUNCTION Main
   LOCAL oTable
 
   oTable := Table():Open( "sample.dbf", {{"ID","+",10,0},{"F1","C",10,0}, {"F2","N",8,0}} )
   oTable:AppendRec()
   oTable:F1 := "FirstRec"
   oTable:F2 := 1
   oTable:AppendRec()
   ? oTable:nRec                // 2
   oTable:nRec := 1
   ? oTable:nRec                // 1
   ? oTable:F1, oTable:F2       // "FirstRec"     1
   ?
 
	sample()
   RETURN nil
 
CLASS Table
 
   METHOD Open( cName, aStru )
   METHOD Create( cName, aStru )
   METHOD AppendRec()   INLINE dbAppend()
   METHOD nRec( n )     SETGET
 
   ERROR HANDLER OnError( xParam )
ENDCLASS
 
METHOD Open( cName, aStru ) CLASS Table
	if !file(cName)
		::Create( cName, aStru )
	endif	
   USE (cName) NEW EXCLUSIVE
RETURN Self

 
 
METHOD Create( cName, aStru ) CLASS Table
   dbCreate( cName, aStru )
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


function Sample()
Local o1 := HSamp1():New()
Local o2 := HSamp2():New()
 
   ? o1:x, o2:x                        // 10       20
   ? o1:Calc( 2,3 ), o2:Mul( 2,3 )     // 60      120
   ? o1:Sum( 5 )                       // 15
   ?
 
return nil
 
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
