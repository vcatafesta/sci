// Here it is! A Class Creation Utility
// Written by John D. Van Etten (c) 1994

#xTranslate ClassVar => Self\[_oJVVar\]\[1\]  // compatibility only!
#xTranslate MethodVar => Self\[_oJVVar\]\[1\] // Use this instead!

#Command Method <cFunc>                                            ;
      => Method <cFunc>()

#Command Method Var <cFunc>                                        ;
      => Method Var <cFunc>()

#Command Method Var <cFunc>( [ <cParms,...> ] )                    ;
      => Static Function <cFunc>( Self [, <cParms>] )              ;
       ;   Local _oJVVar := Self\[1\]\[7\]                         ;
       ;   Local Set := pcount() > 1

#Command Method [<Type:FUNCTION,PROCEDURE>] <cFunc>( [ <cParms,...> ] );
      => Static Func <cFunc>( Self [, <cParms> ] )             ;
       ;   Local _oJVParms := iif( Self == NIL, _oJVParms({|self[,<cParms>]| <cFunc>(self[,<cParms>]) } ),)

#Command Method [<Type:FUNCTION,PROCEDURE>] <cFunc>( [ <cParm,...> ] )   ;
                                           , [<cParms1>]                 ;
                                          [, [<cParms2>]                 ;
                                          [, [<cParms3>]                 ;
                                          [, [<cParms4>]                 ;
                                          [, [<cParms5>]                 ;
                                          [, [<cParms6>]                 ;
                                          [, [<cParms7>]                 ;
                                          [, [<cParms8>]                 ;
                                          [, [<cParms9>]                 ;
                                          [, [<cParms10>]                ;
                                          [, [<cParms11>]                ;
                                          [, [<cParms12>]                ;
                                          [, [<cParms13>]                ;
                                          [, [<cParms14>]                ;
                                          [, [<cParms15>]                ;
                                          [, [<cParms16>]]]]]]]]]]]]]]]] ;
      => Method <cFunc>( [ <cParm> ] ) ;
       ; Local _SendNum := 1           ;
       ; Local _SendNew := { 1CL_SUPER(  <cParms1>  )   ;
                            ,2CL_SUPER( [<cParms2>] )   ;
                            ,2CL_SUPER( [<cParms3>] )   ;
                            ,2CL_SUPER( [<cParms4>] )   ;
                            ,2CL_SUPER( [<cParms5>] )   ;
                            ,2CL_SUPER( [<cParms6>] )   ;
                            ,2CL_SUPER( [<cParms7>] )   ;
                            ,2CL_SUPER( [<cParms8>] )   ;
                            ,2CL_SUPER( [<cParms9>] )   ;
                            ,2CL_SUPER( [<cParms10>] )  ;
                            ,2CL_SUPER( [<cParms11>] )  ;
                            ,2CL_SUPER( [<cParms12>] )  ;
                            ,2CL_SUPER( [<cParms13>] )  ;
                            ,2CL_SUPER( [<cParms14>] )  ;
                            ,2CL_SUPER( [<cParms15>] )  ;
                            ,2CL_SUPER( [<cParms16>] )  }

#Translate 1CL_SUPER( [<Parms>] ) => :::New<Parms>
#Translate 2CL_SUPER( [<Parms>] ) => ::Super\[ ++_SendNum \]:New<Parms>
#Translate 1CL_SUPER( )       =>
#Translate 2CL_SUPER( )       => ++_SendNum
