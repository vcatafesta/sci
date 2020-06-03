proc main()
   memvar var
   local o := errorNew(), msg := "cargo"
   private var := "CAR"
 
   o:&msg := "/cargo/"
   o:&( upper( msg ) ) += "/value/"
   ? o:&var.go
	
main1()
main2()	
main3()	
main4()	
main5()	
		
Function Main1
 
   Local b1, b2
 
   b1 := Fnc1( Seconds() )
   ? Eval( b1 )
 
   ? "Press any key"
   inkey(0)
 
   b2 := Fnc1( Seconds() )
   ? Eval( b2 )
 
   ? "Press any key"
   inkey(0)
 
   ? Eval( b1,Seconds() )
 
   ? "Press any key"
   inkey(0)
 
   ? Eval( b1 )
   ?
 
Return Nil
 
Function Fnc1( nSec )
 
   Local bCode := {|p1|
      Local tmp := nSec
      IF p1 != Nil
         nSec := p1
      ENDIF
      Return tmp
   }
 
Return bCode


function main2()
Local arr := { 1,2,3 } 
 
   ? arr[1], arr[2], arr[3]   // 1   2   3
   p( @arr[2] )
   ? arr[1], arr[2], arr[3]   // 1  12   3
 
return nil
 
Function p( x )
   x += 10
return nil


// as the array elements
proc main3()
   AEval( F( "1", "2", "A", "B", "C" ), {|x, i| qout( i, x ) } )
 
func f( p1, p2, ... )
   ? "P1:", p1
   ? "P2:", p2
   ? "other parameters:", ...
return { "X", ... , "Y", ..., "Z" }
 
// as indexes of the array:
proc main4()
   local a := { { 1, 2 }, { 3, 4 }, 5 }
   ? aget( a, 1, 2 ), aget( a, 2, 1 ), aget( a, 3 )
 
func aget( aVal, ... )
return aVal[ ... ]
 
// as the parameters of the function:
proc main5()
   info( "test1" )
   info( "test2", 10, date(), .t. )
 
proc info( msg, ... )
   qout( "[" + msg +"]: ", ... )