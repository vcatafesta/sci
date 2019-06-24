PROC main(cFile)
LOCAL xI
//SetMode(24,80)
//altd() // debug

? "Decoding"
test("null")
test("true")
test("   false  ")
test("123")
test("123.45")
test('"a"')
test('"Hello, JSON!"')
test('"Hello,\t\"JSON\"\u0021"')
test("[]")
test("{ }")
test('[1, true, "a" ]')
test('{ "a":1, "b" : 2 ,"c" :3, "d": [{"1":null, "2":false}, "4", true]}')
test('"Saules radijas"')
? ""
? "Encoding"
? hb_jsonEncode()
? hb_jsonEncode( .T. )
? hb_jsonEncode( .F. )
? hb_jsonEncode( 123 )
//? hb_jsonEncode( 123.45 )
? hb_jsonEncode( "a" )
? hb_jsonEncode( CHR(0) + 'b\"a' + CHR(13) )
? hb_jsonEncode( DATE() )
? hb_jsonEncode( {} )
? hb_jsonEncode( {=>} )
? hb_jsonEncode( {1,,.T., "hello"} )
? hb_jsonEncode( {"hello"=>"World", "one"=>1, 2=>"two", "three"=>{1, 2, 3}} )
xI := {1, }
xI[ 2 ] := xI
? hb_jsonEncode( xI )  // [1,null]
xI := {1, .T.}
xI := {2, xI, xI}
? hb_jsonEncode( xI )  // [2,[1,true],[1,true]]
IF cFile != NIL
        ? ""
        ? "File decoding"
        test( MEMOREAD( cFile ) )
ENDIF
wait

RETURN

PROC test( cJSON )
    LOCAL xI, nI
    nI := hb_jsonDecode( cJSON, @xI )
    IF nI > 0
       ? "OK:", nI, cJSON, "   ", ValToPrg( xI )
    ELSE
       ? "ERROR", cJSON
    ENDIF
RETURN