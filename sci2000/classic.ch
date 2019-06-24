// Here it is! A Class Creation Utility
// Written by John D. Van Etten
// Copyright 1994 VanSoft

#xTranslate Self: => self\[ 1 \]\[ 5 \]:
#xTranslate :: => self\[ 1 \]\[ 5 \]:
#xTranslate ::: => iif( valtype( ::Super )=="A", ::Super\[1\], ::Super ):
#xTranslate ::<cFunc>([<cParms,...>]) => @:<cFunc>(<cParms>)
#xTranslate ::New([<cParms,...>]) => self\[ 1 \]\[ 5 \]:New(<cParms>)

#ifndef TRACE
  #xTranslate @:<cFunc>([<cParms,...>]) => self\[ 1 \]\[ 5 \]:<cFunc>(<cParms>)
#else
  #xTranslate @:<cFunc> => self\[ 1 \]\[ 5 \]:<cFunc>
#endif

#Command Begin Class <cFunc>                                      ;
      => Function <cFunc>                                         ;
       ; Static _oJVObject := {}                                  ;
       ; Local FIRSTOBJECT := Empty( _oJVObject )                 ;
       ; Local Self        := NIL                                 ;
       ; Local _oJVInherit := {}                                  ;
       ; Local _oJVHandle  := _oJVClass( <(cFunc)>, _oJVObject, {} )

#Command Begin Class <cFunc>                                      ;
                   [Inherit] From <cInherit1>                     ;
                               [ ,<cInheritn> ]                   ;
                   [ Select [From] <csInherit1>                   ;
                                   [ ,<csInheritn> ] ]            ;
      => Function <cFunc>                                         ;
       ; Static _oJVObject := {}                                  ;
       ; Local FIRSTOBJECT := Empty( _oJVObject )                 ;
       ; Local Self        := NIL                                 ;
       ; Local _oJVInherit := {[ { <cInherit1>,  <(cInherit1)> } ]     ;
                               [,{ <cInheritn>,  <(cInheritn)> } ]     ;
                               [,{ <csInherit1>, <(csInherit1)>, } ]   ;
                               [,{ <csInheritn>, <(csInheritn)>, } ] } ;
       ; Local _oJVHandle  := _oJVClass( <(cFunc)>, _oJVObject,   ;
                                         _oJVInherit )

#Command Begin Class <cFunc>                                      ;
                   Select [From] <csInherit1>                     ;
                                   [ ,<csInheritn> ]              ;
                   [[Inherit] From <cInherit1>                    ;
                               [ ,<cInheritn> ]]                  ;
      => Function <cFunc>                                         ;
       ; Static _oJVObject := {}                                  ;
       ; Local FIRSTOBJECT := Empty( _oJVObject )                 ;
       ; Local Self        := NIL                                 ;
       ; Local _oJVInherit := {[ { <csInherit1>, <(csInherit1)>, } ] ;
                               [,{ <csInheritn>, <(csInheritn)>, } ] ;
                               [,{ <cInherit1>,  <(cInherit1)> } ]   ;
                               [,{ <cInheritn>,  <(cInheritn)> } ] } ;
       ; Local _oJVHandle  := _oJVClass( <(cFunc)>, _oJVObject,   ;
                                         _oJVInherit )

#Command New Class                                                ;
      => If !FIRSTOBJECT                                          ;
       ;   _oJVHandle  := _oJVClass(,_oJVObject,_oJVInherit )     ;
       ;   _oJVObject  := {}                                      ;
       ;   Self        := NIL                                     ;
       ;   FIRSTOBJECT := .t.                                     ;
       ; End

// Vars
#Command Var <cVar1>[,<cVarN>] [<ro:READONLY,RO>]                 ;
         [Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT>]  ;
      => _oJVAddVar( _oJVHandle, { <(cVar1)>[, <(cVarN)>] },,,, <.ro.>[,<(Type)>] )

#Command Static Var <cVar1>[,<cVarN>] [<ro:READONLY,RO>]          ;
         [Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT>]                ;
      => _oJVAddVar( _oJVHandle, { <(cVar1)>[, <(cVarN)>] },,,.t., <.ro.>[,<(Type)>] )

#Command Var <cName> <opt1:is,inherits> [[Var] <cVar>] [<opt:In,From> <cInherit>]    ;
      => _oJVAddRename( _oJVHandle, <(cVar)>, <(cName)>, .t., <(cInherit)> )

#Command Method <cName> <opt1:is,inherits> [[Method] <cFunc>] [<opt:In,From> <cInherit>]       ;
      => _oJVAddRename( _oJVHandle, <(cFunc)>, <(cName)>, .f., <(cInherit)> )

// Method Vars
#Command Method Var <cFunc> Message <cVar> [<ro:READONLY,RO>]     ;
         [Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT>]  ;
      => _oJVAddVar( _oJVHandle, {<(cVar)>},                        ;
                        {|s,x| <cFunc>(s,x) }, {|s| <cFunc>(s) },,<.ro.>[,<(Type)>] )

#Command Method Var <cFunc> [<ro:READONLY,RO>]                     ;
         [Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT>]  ;
      => _oJVAddVar( _oJVHandle, {<(cFunc)>},                        ;
                        {|s,x| <cFunc>(s,x) }, {|s| <cFunc>(s) },,<.ro.>[,<(Type)>] )

// Methods: Typed
#Command Method <cFunc>                                           ;
         Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cFunc>() }, .f., .t., <(Type)> )
#Command Method <cCalls> Message <cFunc>                          ;
         Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cCalls>() }, .f., .t., <(Type)> )
#Command Method <cFunc>( [<cVars,...>] )                          ;
         Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|s[,<cVars>]| <cFunc>(s[,<cVars>]) },    ;
                        .f., .f., <(Type)> )
#Command Method <cCalls>( [<cVars,...>] ) Message <cFunc>         ;
         Type <Type:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>  ;
        => _oJVAddMethod( _oJVHandle, <(cFunc)>,                  ;
                        {|s[,<cVars>]| <cCalls>(s[,<cVars>]) },   ;
                        .f., .f., <(Type)> )

// Methods: Untyped
#ifndef TRACE
#Command Method <cFunc> [<con:CONSTRUCTOR,CTOR>]                  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cFunc>() }, <.con.>, .t. )           ;
       ;  #xTranslate @:<cFunc>(\[\<cParms,...\>\])               ;
                   => <cFunc>(self\[,\<cParms\>\])
#else
#Command Method <cFunc> [<con:CONSTRUCTOR,CTOR>]                  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cFunc>() }, <.con.>, .t. )
#endif

#ifndef TRACE
#Command Method <cCalls> Message <cFunc> [<con:CONSTRUCTOR,CTOR>] ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cCalls>() }, <.con.>, .t. )          ;
       ;  #xTranslate @:<cFunc>(\[\<cParms,...\>\])               ;
                   => <cCalls>(self\[,\<cParms\>\])
#else
#Command Method <cCalls> Message <cFunc> [<con:CONSTRUCTOR,CTOR>] ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|| <cCalls>() }, <.con.>, .t. )
#endif

#ifndef TRACE
#Command Method <cFunc>( [<cVars,...>] ) [<con:CONSTRUCTOR,CTOR>] ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|_1self[,<cVars>]| <cFunc>(_1self[,<cVars>]) },    ;
                        <.con.>, .f. )                            ;
       ;  #xTranslate @:<cFunc>(\[\<cVars,...\>\])               ;
                   => <cFunc>(self\[,\<cVars\>\])
#else
#Command Method <cFunc>( [<cVars,...>] ) [<con:CONSTRUCTOR,CTOR>] ;
        => _oJVAddMethod( _oJVHandle, <(cFunc)>,                    ;
                        {|_1self[,<cVars>]| <cFunc>(_1self[,<cVars>]) },    ;
                        <.con.>, .f. )
#endif

#ifndef TRACE
#Command Method <cCalls>( [<cVars,...>] )                         ;
                Message <cFunc> [<con:CONSTRUCTOR,CTOR>]          ;
        => _oJVAddMethod( _oJVHandle, <(cFunc)>,                  ;
                        {|_1self[,<cVars>]| <cCalls>(_1self[,<cVars>]) },   ;
                        <.con.>, .f. )                            ;
        ;  #xTranslate @:<cFunc>(\[\<cParms,...\>\])              ;
                    => <cCalls>(self\[,\<cParms\>\])
#else
#Command Method <cCalls>( [<cVars,...>] )                         ;
                Message <cFunc> [<con:CONSTRUCTOR,CTOR>]          ;
        => _oJVAddMethod( _oJVHandle, <(cFunc)>,                  ;
                        {|_1self[,<cVars>]| <cCalls>(_1self[,<cVars>]) },   ;
                        <.con.>, .f. )
#endif

#Command NIL Method <cFunc>                                        ;
         [<con:CONSTRUCTOR,CTOR>]                                  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>, {|| NIL }, .f., .f. )

#Command NIL Method <cCall> Message <cFunc>                        ;
         [<con:CONSTRUCTOR,CTOR>]                                  ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>, {|| NIL }, .f., .f. )

#Command Method <cFunc> [IS] DEFERRED                              ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                     ;
                        {|_1self| _1self:subclass:<cFunc>()},;
                        .f., .f. )
#Command Method <cFunc> Message <cCall> [IS] DEFERRED ;
      => _oJVAddMethod( _oJVHandle, <(cCall)>,                     ;
                        {|_1self| _1self:subclass:<cFunc>()},;
                        .f., .f. )

#Command Method <cFunc>( [<cParm,...>] ) [IS] DEFERRED             ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>,                     ;
                        {|_1self[,<cParm>]| _1self:subclass:<cFunc>([<cParm>])},;
                        .f., .f. )
#Command Method <cFunc>( [<cParm,...>] ) Message <cCall> [IS] DEFERRED ;
      => _oJVAddMethod( _oJVHandle, <(cCall)>,                     ;
                        {|_1self[,<cParm>]| _1self:subclass:<cFunc>([<cParm>])},;
                        .f., .f. )

#Command BLOCK <bBlock> Message <cFunc>                           ;
      => _oJVAddMethod( _oJVHandle, <(cFunc)>, <bBlock>, .f., .f. )

// Class Commands
#Command Make Class                                                ;
      => Self := _oJVAddClass( _oJVObject := _oJVHandle, _oJVInherit )

#xCommand End Class[:<init>]                                       ;
       => Return( ( IIf( Self == NIL,                              ;
            Self := _oJVAddClass( _oJVObject := _oJVHandle,        ;
                   _oJVInherit ), NIL )) [,self:<init>], ;
            iif( ProcName( 1 ) == "", self:New(), Self ));
        ; #include "CLASSIC2.CH"

#Command EndClass[:<init>] => End Class[:<init>]

#Command Global: => _oJVHandle\[9\] := NIL
#Command Local:  => _oJVHandle\[9\] := "H"
#Command Class:  => _oJVHandle\[9\] := "P"

// Make it work like the that other class utility!
// Please let me know if I missed something!
#Command Visible: => Global:
#Command Export: => Global:
#Command Hidden: => Local:
#Command Protected: => Class:

#Command Create Class <Stuff> [from <cSuper>] ;
      => Begin Class <Stuff> [From <cSuper>()] ;
       ;   Local:
#Command Var <Stuff> to Class =>
#Command Var <Stuff> as <Stuff2> => Var <Stuff2> is <Stuff>
#Command Method <Stuff> as <Stuff2> => Method <Stuff2> is <Stuff>
#Command Class Method <*Stuff*> => Method <Stuff>
#Command Class Var <*Stuff*> => Static Var <Stuff>
#Command Method <Stuff> [IS] NULL => NIL METHOD <Stuff>
#Command Message <Stuff1> Method <Stuff2> [<con:CONSTRUCTOR,CTOR>] ;
      => Method <Stuff2> Message <Stuff1> <con>
#Command Class Message <Stuff1> Method <Stuff2> [<con:CONSTRUCTOR,CTOR>] ;
      => Method <Stuff2> Message <Stuff1> <con>
#Command Initialize [Class] => Make Class
#Command Message <Stuff1> [IS] DEFERRED => Method <Stuff1> DEFERRED
// End look alike!

#ifdef DEBUG
  // Assumption Checking
  #Command Check <xVar1>[,<xVarN>]                                       ;
                 is [Type] <Type1:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>;
                 [ , <TypeN:ARRAY,BLOCK,CHARACTER,DATE,LOGICAL,NUMERIC,OBJECT,NIL>];
                 [ Message <cMsg> ]                                      ;
          => _oJVAssume( { {<(xVar1)>,{|| <xVar1> }}                     ;
                         [,{<(xVarN)>,{|| <xVarN> }}] }, {<(Type1)>[,<(TypeN)>]}, [<(cMsg)>] )
  #Command Check <xVar1>[,<xVarN>] [ IS NOT NIL ]                        ;
                 [ Message <cMsg> ]                                      ;
          => _oJVAssume( { { <(xVar1)>, {|| <xVar1> } }                  ;
                         [,{<(xVarN)>,{|| <xVarN> }}] }, {"!NIL"}, [<(cMsg)>] )
  #Command Check if <xVar1> [ Message <cMsg> ];
          => _oJVAssume( { {<(xVar1)>,{|| <xVar1> } } },{}, [<(cMsg)>] )
#else
 #Command Check <*Stuff*> =>
#endif

#include "Addon.ch"
