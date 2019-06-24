//                           ADDON.CH V1.0
//                        By John D. Van Etten
//                       Thanks for using ADDON!
//
//
// The intent of this file is to collect all the great commands and add
// them to this header file!  Send me your greatest commands that you
// would like to add to this file for free.  Send them to me on C-SERVE at
// 74437,1657.  Don't worry, I'll give you credit for you entry.  Be sure
// to explain them and give some examples!
//
// Please refer to ADDON.DOC for a description of the commands in this file!
//
// This Header File is FREE! Pass it around!
// All I ask is you don't change anything above this line!

#IfNDef _ADDON  // INCLUDE ONLY ONCE!!!

#DEFINE _ADDON
#Include "Common.ch"

// Some people might like to use these.
// In 5.2's COMMON.CH, But I don't know about earlier versions
#IfNDef TRUE
  #Define TRUE  .T.
  #Define FALSE .F.
#Endif

// Default Param to 10
// In 5.2's COMMON.CH, But I don't know about earlier versions
#Command Default <Var1> TO <Value1> [, <Varn> TO <Valuen> ] ;
      => If <Var1> == NIL                                   ;
       ;   <Var1> := <Value1>                               ;
       ; End                                                ;
      [; If <Varn> == NIL                                   ;
       ;   <Varn> := <Valuen>                               ;
       ; End ]

// The opposite of EMPTY()
#xTranslate Full( <xVar> ) => !Empty( <xVar> )

// Works Just like ADEL, but shrinks the array to get rid of the last
// NIL element.
#xTranslate aKill( <aArray>[, <nPlace>] )                    ;
         => aPop( <aArray>[, <nPlace> ] )
#xTranslate aPop( <aArray> )                                 ;
         => ( ADDONPush( atail( <aArray> )),                       ;
              aSize( aDel( <aArray>, len( <aArray> ) ), Len( <aArray> ) - 1 ), ADDONPop() )
#xTranslate aPop( <aArray>, <nPlace> )                       ;
         => ( ADDONPush( <aArray>\[ <nPlace> \] ),                  ;
              aSize( aDel( <aArray>, <nPlace> ), Len( <aArray> ) - 1 ), ADDONPop() )

// Just like AINS, but first grows the array so you don't loose the
// last element!  The 3rd param allows you to put something into the new
// element.
#xTranslate aPush( <aArray>, <xItem> )                      ;
         => aadd( <aArray>, <xItem> )
#xTranslate aPush( <aArray>, <xItem>, <nPlace> )             ;
         => aIns( aSize( <aArray>, Len( <aArray> ) + 1 ), <nPlace> ) ;
          ; <aArray>\[ <nPlace> \] := <xItem>

// Get rid of :  IF x == 1 .or. x == 2 .or. x == 3 .or. x == 4
// and make it:  IF < x == 1,2,3,4 >
#Translate \< <Var> == <List1>[,<ListN>] \> ;
        => ( <Var> == <List1> [.or. <Var> == <ListN>] )
#Translate \< <Var> != <List1>[,<ListN>] \> ;
        => ( <Var> != <List1> [.or. <Var> != <ListN>] )

// Case statements work faster and debug better!
// But I like the way IF statements look so I use them.
#command if <Stuff>      => Do Case;Case <Stuff>
#command elseif <Stuff>  => Case <Stuff>
#command else [<Stuff>]  => otherwise
#command endif [<Stuff>] => end

// To run a code block you can make it look more like a METHOD call to
// the EVAL Class.
// EVAL:bBlock( Param1, Param2 )
#xTranslate EVAL:<Block>( [<Vars,...>] ) => (Eval( <Block>[, <Vars>] ))

// Inline defaults!
#TRANSLATE METHOD <Func>( <Vars,...> := <Vars2,...> )[, <Stuff,...> ];
        => RFunc <Func>(<Vars> := <Vars2>) METHOD 1Parms <Vars> := <Vars2> [1Stuff <Stuff>]

#TRANSLATE PROCEDURE <Func>( <Vars,...> := <Vars2,...> ) ;
        => RFunc <Func>(<Vars> := <Vars2>) PROC 1Parms <Vars> := <Vars2>

#TRANSLATE FUNCTION <Func>( <Vars,...> := <Vars2,...> ) ;
        => RFunc <Func>(<Vars> := <Vars2>) FUNC 1Parms <Vars> := <Vars2>

#XTRANSLATE RFunc <Func> ( <Vars1> [, <VarsN> ] )                      ;
            <type:METHOD,FUNC,PROC>                                    ;
            1Parms <Var1>[, <VarN> ]                                   ;
            [1Stuff <Stuff,...>]                                       ;
         => <type> <Func>( 3Parms( <Vars1> )[, 3Parms( <VarsN> )] ) [, <Stuff> ]   ;
          ; LOCAL _Sets := ( 2Parms ( <Var1> )[, 2Parms ( <VarN> ) ] )

#XTRANSLATE 2Parms ( <Var> ) => NIL
#XTRANSLATE 2Parms ( <Var> := <Val> ) => iif(<Var> == NIL,<Var>:=<Val>,NIL)
#XTRANSLATE 3Parms ( <Var> ) => <Var>
#XTRANSLATE 3Parms ( <Var> := <Val> ) => <Var>

// DO ... UNTIL .t.
#Command Do => While .t.
#Command Until <Cond> => If <Cond> ; Exit ; End ; End

// IF x == "OFF" THEN replace field->Stat with .f.
#Command If <Cond> then <*Cmd1*> ;
      => If <Cond> ; <Cmd1> ; End

// aTail( aList ) := "LAST IN LINE"
#xTranslate aTail( <Array> ) := <Value> ;
         => <Array>\[ Len( <Array> ) \] := <Value>

// UPTRIM( "  AddOn " ) == "ADDON"
#xTranslate UpTrim( <Val> ) ;
         => Upper( Alltrim( <Val> ))

// Multiple record locks!
#xTranslate MRLOCK( [<Rec>]   ) => DBRLOCK( [<Rec>] )
#xTranslate MRUNLOCK( [<Rec>] ) => DBRUNLOCK( [<Rec>] )

//  ** Alias ANY COMMAND!!!! Alias Multiple Commands on the same line!!! **
// Alias COMPANY -> FLOCK() ; Repl All FIELD->NAME with "CA-CLIPPER" ; UnLock
#Command Alias <Alias> -> <*Cmd*>;
      => ADDONPush( Select() ) ; Select <Alias> ; <Cmd> ; Select( ADDONPop() )

// Reverses a logical.   lOK := !lOK  -becomes just-  !lOK
#Command !<Var> => <Var> := !<Var>

  //////////////////////////////////////////////////////////////////////////
 // Internal to ADDON /////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
#Translate ADDONPush( <Value> ) ;
      => IIf(type( "m->_1ADDON" ) != "A", ;
             m->_1ADDON := { <Value> },     ;
             aadd( m->_1ADDON, <Value> ))

#Translate ADDONPop() ;
        => ( m->_2ADDON := iif( type( "m->_1ADDON" ) == "A",          ;
                           aTail( m->_1ADDON ),                  ;
                           NIL ),                           ;
             iif( type( "m->_1ADDON" ) == "A",                   ;
                  aSize( m->_1ADDON, max( 0, len( m->_1ADDON ) - 1 )), NIL ),  ;
             m->_2ADDON)

memvar getlist

#Endif // IfnDef ADDON

