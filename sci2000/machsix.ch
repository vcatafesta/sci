/*
ÕÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¸
³ Source file: MachSIx.CH  ( Clipper 5.2x )                                ³Û
³ Description: #Include file for the Mach SIx query optimizer.             ³Û
³ Notes      : Include this file (#include "MACHSIX.CH") in your program's ³Û
³              source code.                                                ³Û
³ Notice     : Copyright 1992-1995 - SuccessWare 90, Inc.                  ³Û
ÔÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¾Û
  ÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛÛ
*/

#translate NO OPTIMIZE  =>  NOOPTIMIZE
#translate DBFILTER([<x>])    => M6_DBFILTER([<x>])
#translate DbSetFilter([<x>]) => M6_DBFILTER([<x>])

//=============================================================================
// RETURN VALUES FROM M6_ISOPTIMIZE()
//-----------------------------------------------------------------------------

#define OPT_FULL          2
#define OPT_PARTIAL       1
#define OPT_NONE          0

//=============================================================================
// M6_SET() DEFINITIONS
//-----------------------------------------------------------------------------

#define _SET_TYPECHECK    1
#define _SET_OPTIMIZE     2
#define _SET_RECHECK      4

//=============================================================================
// M6_FILTJOIN() DEFINITIONS
//-----------------------------------------------------------------------------

#define JOIN_UNION        1
#define JOIN_INTERSECT    2
#define JOIN_DIFFERENCE   3

//=============================================================================
// FILTER OWNERSHIP DEFINITIONS
//-----------------------------------------------------------------------------

#define OWN_SYSTEM        1
#define OWN_USER          2

//=============================================================================
// M6_FILTINFO() RETURN ARRAY ELEMENT DEFINITIONS
//-----------------------------------------------------------------------------

#define INFO_EXPR         1
#define INFO_NONEXPR      2
#define INFO_OPTLVL       3
#define INFO_COUNT        4
#define INFO_SIZE         5
#define INFO_OWNER        6
#define INFO_POS          7

//=============================================================================
// SPECIFY "NOOPTIMIZE" TO OVERRIDE AUTOMATIC OPTIMIZATION
//-----------------------------------------------------------------------------

#command AVERAGE [ <x1> [, <xn>]  TO  <v1> [, <vn>] ]                   ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => M->__Avg := <v1> := [ <vn> := ] 0                              ;
                                                                        ;
       ; DBEval(                                                        ;
                 {|| M->__Avg := M->__Avg + 1,                          ;
                 <v1> := <v1> + <x1> [, <vn> := <vn> + <xn>] },         ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )                                                        ;
                                                                        ;
       ; <v1> := <v1> / M->__Avg [; <vn> := <vn> / M->__Avg ]


#command CONTINUE [NOOPTIMIZE]              => __dbContinue()

#command COUNT [TO <var>]                                               ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => <var> := 0                                                     ;
       ; DBEval(                                                        ;
                 {|| <var> := <var> + 1 },                              ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )


#command COPY [TO <(file)>]                                             ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
         [DELIMITED [WITH <*delim*>]]                                   ;
                                                                        ;
      => __dbDelim(     .T.,                                            ;
                        <(file)>, <(delim)>, { <(fields)> },            ;
                        <{for}>, <{while}>, <next>, <rec>, <.rest.>     ;
                      )


#command COPY [TO <(file)>] [SDF]                                       ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbSDF(     .T.,                                              ;
                      <(file)>, { <(fields)> },                         ;
                      <{for}>, <{while}>, <next>, <rec>, <.rest.>       ;
                    )


#command COPY [TO <(file)>]                                             ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [VIA <rdd>]                                                    ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbCopy(                                                      ;
                   <(file)>, { <(fields)> },                            ;
                   <{for}>, <{while}>, <next>, <rec>, <.rest.>, <rdd>   ;
                 )

#command DELETE                                                         ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => DBEval(                                                        ;
                 {|| dbDelete()},                                       ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )

#command DISPLAY [<list,...>]                                           ;
         [<off:OFF>]                                                    ;
         [<toPrint: TO PRINTER>]                                        ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [<all:ALL>]                                                    ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __DBList(                                                      ;
                   <.off.>, { <{list}> }, <.all.>,                      ;
                   <{for}>, <{while}>, <next>, <rec>, <.rest.>,         ;
                   <.toPrint.>, <(toFile)>                              ;
                 )

#command LABEL FORM <lbl>                                               ;
         [<sample: SAMPLE>]                                             ;
         [<noconsole: NOCONSOLE>]                                       ;
         [<print: TO PRINTER>]                                          ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __LabelForm(                                                   ;
                      <(lbl)>, <.print.>, <(toFile)>, <.noconsole.>,    ;
                      <{for}>, <{while}>, <next>, <rec>, <.rest.>,      ;
                      <.sample.>                                        ;
                    )

#command LIST [<list,...>]                                              ;
         [<off:OFF>]                                                    ;
         [<toPrint: TO PRINTER>]                                        ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbList(                                                      ;
                   <.off.>, { <{list}> }, .t.,                          ;
                   <{for}>, <{while}>, <next>, <rec>, <.rest.>,         ;
                   <.toPrint.>, <(toFile)>                              ;
                 )


#command LOCATE                                                         ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbLocate( <{for}>, <{while}>, <next>, <rec>, <.rest.> )



#command REPLACE [ <f1> WITH <x1> [, <fn> WITH <xn>] ]                  ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => DBEval(                                                        ;
                 {|| _FIELD-><f1> := <x1> [, _FIELD-><fn> := <xn>]},    ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )

#command REPORT FORM <frm>                                              ;
         [HEADING <heading>]                                            ;
         [<plain: PLAIN>]                                               ;
         [<noeject: NOEJECT>]                                           ;
         [<summary: SUMMARY>]                                           ;
         [<noconsole: NOCONSOLE>]                                       ;
         [<print: TO PRINTER>]                                          ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __ReportForm(                                                  ;
                       <(frm)>, <.print.>, <(toFile)>, <.noconsole.>,   ;
                       <{for}>, <{while}>, <next>, <rec>, <.rest.>,     ;
                       <.plain.>, <heading>,                            ;
                       <.noeject.>, <.summary.>                         ;
                     )

#command SET FILTER TO <xpr>                                            ;
         [NOOPTIMIZE]                                                   ;
      => m6_SetFilter( <{xpr}>, <"xpr">, .T. )


#command SET FILTER TO <x:&>                                            ;
         [NOOPTIMIZE]                                                   ;
      => if ( Empty(<(x)>) )                                            ;
       ;    dbClearFilter()                                             ;
       ; else                                                           ;
       ;    m6_SetFilter( <{x}>, <(x)>, .T. )                           ;
       ; endif

#command SUM [ <x1> [, <xn>]  TO  <v1> [, <vn>] ]                       ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => <v1> := [ <vn> := ] 0                                          ;
       ; DBEval(                                                        ;
                 {|| <v1> := <v1> + <x1> [, <vn> := <vn> + <xn> ]},     ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )

#command SORT [TO <(file)>] [ON <fields,...>]                           ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbSort(                                                      ;
                   <(file)>, { <(fields)> },                            ;
                   <{for}>, <{while}>, <next>, <rec>, <.rest.>          ;
                 )


#command TOTAL [TO <(file)>] [ON <key>]                                 ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => __dbTotal(                                                     ;
                    <(file)>, <{key}>, { <(fields)> },                  ;
                    <{for}>, <{while}>, <next>, <rec>, <.rest.>         ;
                  )


#command RECALL                                                         ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => DBEval(                                                        ;
                 {|| dbRecall()},                                       ;
                 <{for}>, <{while}>, <next>, <rec>, <.rest.>            ;
               )


//=============================================================================
// MACHSIX OPTIMIZED COMMANDS
//-----------------------------------------------------------------------------

#command AVERAGE [ <x1> [, <xn>]  TO  <v1> [, <vn>] ]                   ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         M->__Avg := <v1> := [ <vn> := ] 0                              ;;
         m6_dbEval( {|| M->__Avg := M->__Avg + 1,                       ;
                    <v1> := <v1> + <x1> [, <vn> := <vn> + <xn>] },      ;
                    <"for">, <{for}>)                                   ;
                                                                        ;
       ; <v1> := <v1> / M->__Avg [; <vn> := <vn> / M->__Avg ]


#command CONTINUE    => m6_dbContinue()


#command COPY [TO <(file)>] [FIELDS <fields,...>]                       ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [DELIMITED [WITH <*delim*>]]                                   ;
 =>                                                                     ;
         m6_CopyDelim( <(file)>, <(delim)>, { <(fields)> },             ;
                      <"for">, <{for}> )


#command COPY [TO <(file)>] [SDF]                                       ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_CopySdf( <(file)>,{ <(fields)> }, <"for">, <{for}>)


#command COPY [TO <(file)>]                                             ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [VIA <rdd>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_Copy( <(file)>, { <(fields)> }, <"for">, <{for}>, <rdd> )


#command COPY TO ARRAY <var>                                            ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [WHILE <while>]                                                ;
         [NEXT <next>]                                                  ;
         [RECORD <rec>]                                                 ;
         [<rest:REST>]                                                  ;
         [ALL]                                                          ;
         [<x:OFF>]                                                      ;
                                                                        ;
 =>                                                                     ;
         <var>:={}                                                      ;;
         m6_CopyToArray( @<var>, { <(fields)> }, <"for">, <{for}>,      ;
                         <{while}>, <next>, <rec>, <.rest.>, !<.x.>)    ;


#command COUNT [TO <var>] [FOR <for>] [ALL]                             ;
 =>                                                                     ;
         <var> := m6_CountFor( <"for">, <{for}> )


#command DELETE [FOR <for>] [ALL]                                       ;
 =>                                                                     ;
         m6_dbEval( {|| dbDelete()}, <"for">, <{for}> )

#command DELETE                                                         ;
 =>                                                                     ;
         dbDelete()

#command DISPLAY [<list,...>]                                           ;
         [<off:OFF>]                                                    ;
         [<toPrint: TO PRINTER>]                                        ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_ListFor( <.off.>, { <{list}> }, .T.,                        ;
                    <"for">, <{for}>, <.toPrint.>, <(toFile)>)


#command INDEX ON <key> TO <(file)>                                     ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [ASCENDING]                                                    ;
         [<dec:   DESCENDING>]                                          ;
         [<u:     UNIQUE>]                                              ;
         [<cur:   USECURRENT>]                                          ;
         [<cur:   SUBINDEX>]                                            ;
         [EVAL    <opt> [EVERY <step>]]                                 ;
         [OPTION  <opt> [STEP <step>]]                                  ;
         [<non:   NONCOMPACT>]                                          ;
         [<add:   ADDITIVE>]                                            ;
         [<filt:  FILTERON>]                                            ;
 =>                                                                     ;
         m6_ordCondSet(<"for">, <{for}>, NIL, NIL, <{opt}>,             ;
                    <step>, RECNO(), NIL, NIL, NIL, [<.dec.>],          ;
                    .F., NIL, <.cur.>, .F., <.non.>, <.add.>, NIL,      ;
                    <.filt.> )                                          ;
       ; m6_CreateIndex(<(file)>, <"key">, <{key}>, [<.u.>] )


#command INDEX ON <key> TAG <(tag)> [OF <(cdx)>]                        ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [ASCENDING]                                                    ;
         [<dec:  DESCENDING>]                                           ;
         [<u:    UNIQUE>]                                               ;
         [<cur:   USECURRENT>]                                          ;
         [<cur:   SUBINDEX>]                                            ;
         [EVAL    <opt> [EVERY <step>]]                                 ;
         [OPTION <opt> [STEP <step>]]                                   ;
         [<add:   ADDITIVE>]                                            ;
         [<filt:  FILTERON>]                                            ;
 =>                                                                     ;
         m6_ordCondSet(<"for">, <{for}>, NIL, NIL, <{opt}>,             ;
                       <step>, RECNO(), NIL, NIL, NIL, [<.dec.>],       ;
                       .T., <(cdx)>, <.cur.>, .F., NIL, <.add.>, NIL,   ;
                       <.filt.> )                                       ;
       ; m6_ordCreate( <(cdx)>, <(tag)>, <"key">, <{key}>, [<.u.>] )


#command LABEL FORM <lbl>                                               ;
         [<sample: SAMPLE>]                                             ;
         [<noconsole: NOCONSOLE>]                                       ;
         [<print: TO PRINTER>]                                          ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_LabelForm( <(lbl)>, <.print.>, <(toFile)>, <.noconsole.>,   ;
                       <"for">, <{for}>, <.sample.> )


#command LIST [<list,...>]                                              ;
         [<off:OFF>]                                                    ;
         [<toPrint: TO PRINTER>]                                        ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_ListFor( <.off.>, { <{list}> }, .t.,                        ;
                     <"for">, <{for}>, <.toPrint.>, <(toFile)> )


#command LOCATE                                                         ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [NOOPTIMIZE]                                                   ;
                                                                        ;
      => m6_dbLocate( <"for">, <{for}> )


#command RECALL [FOR <for>] [ALL]                                       ;
 =>                                                                     ;
         m6_dbEval( {|| dbRecall()}, <"for">, <{for}> )


#command RECALL                                                         ;
 =>                                                                     ;
         dbRecall()


#command REFRESH FILTER                                                 ;
 =>                                                                     ;
         m6_RefreshFilter()


#command REPLACE [ <f1> WITH <x1> [, <fn> WITH <xn>] ]                  ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_dbEval( {|| _FIELD-><f1> := <x1> [, _FIELD-><fn> := <xn>]}, ;
                    <"for">, <{for}> )

#command REPLACE <f1> WITH <v1> [, <fN> WITH <vN> ]                     ;
 =>      _FIELD-><f1> := <v1> [; _FIELD-><fN> := <vN>]


#command REPORT FORM <frm>                                              ;
         [HEADING <heading>]                                            ;
         [<plain: PLAIN>]                                               ;
         [<noeject: NOEJECT>]                                           ;
         [<summary: SUMMARY>]                                           ;
         [<noconsole: NOCONSOLE>]                                       ;
         [<print: TO PRINTER>]                                          ;
         [TO FILE <(toFile)>]                                           ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_ReportForm( <(frm)>, <.print.>, <(toFile)>, <.noconsole.>,  ;
                        <"for">, <{for}>, <.plain.>, <heading>,         ;
                        <.noeject.>, <.summary.> )

#command SEARCH [FOR <for>] [TO <var>]                                  ;
                                                                        ;
 =>      <var>:={}                                                      ;;
         m6_Search( <"for">, <{for}>, @<var> )


#command SET FILTER TO <xpr>                                            ;
      => m6_SetFilter( <{xpr}>, <"xpr">, .F. )


#command SET FILTER TO <x:&>                                            ;
      => if ( Empty(<(x)>) )                                            ;
       ;    dbClearFilter()                                             ;
       ; else                                                           ;
       ;    m6_SetFilter( <{x}>, <(x)>, .F. )                           ;
       ; endif


#command SUBINDEX ON <key> TO <(file)>                                  ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [ASCENDING]                                                    ;
         [<dec:   DESCENDING>]                                          ;
         [<u:     UNIQUE>]                                              ;
         [EVAL    <opt> [EVERY <step>]]                                 ;
         [OPTION  <opt> [STEP <step>]]                                  ;
         [<non:   NONCOMPACT>]                                          ;
         [<add:   ADDITIVE>]                                            ;
         [<filt:  FILTERON>]                                            ;
=>                                                                      ;
         m6_ordCondSet(<"for">, <{for}>, NIL, NIL, <{opt}>,             ;
                    <step>, RECNO(), NIL, NIL, NIL, [<.dec.>],          ;
                    .F., NIL, .T., .F., <.non.>, <.add.>, NIL,          ;
                    <.filt.> )                                          ;
         ; m6_CreateIndex(<(file)>, <"key">, <{key}>, [<.u.>] )


#command SUBINDEX ON <key> TAG <(tag)> [OF <(cdx)>]                     ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
         [ASCENDING]                                                    ;
         [<dec:  DESCENDING>]                                           ;
         [<u:    UNIQUE>]                                               ;
         [EVAL    <opt> [EVERY <step>]]                                 ;
         [OPTION <opt> [STEP <step>]]                                   ;
         [<add:  ADDITIVE>]                                             ;
         [<filt:  FILTERON>]                                            ;
 =>                                                                     ;
         m6_ordCondSet(<"for">, <{for}>, NIL, NIL, <{opt}>,             ;
                       <step>, RECNO(), NIL, NIL, NIL, [<.dec.>],       ;
                       .T., <(cdx)>, .T., .F., NIL, <.add.>, NIL,       ;
                       <.filt.> )                                       ;
         ; m6_ordCreate( <(cdx)>, <(tag)>, <"key">, <{key}>, [<.u.>] )                         ;


#command SUM [ <x1> [, <xn>]  TO  <v1> [, <vn>] ]                       ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         <v1> := [ <vn> := ] 0                                          ;;
         m6_dbEval( {|| <v1> := <v1> + <x1> [, <vn> := <vn> + <xn> ]},  ;
                    <"for">, <{for}> )


#command SORT [TO <(file)>] [ON <fields,...>]                           ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_SortFor( <(file)>, { <(fields)> }, <"for">, <{for}>)


#command TOTAL [TO <(file)>] [ON <key>]                                 ;
         [FIELDS <fields,...>]                                          ;
         [FOR <for>]                                                    ;
         [ALL]                                                          ;
 =>                                                                     ;
         m6_TotalFor( <(file)>, <{key}>, { <(fields)> },                ;
                      <"for">, <{for}> )

#command SET TYPECHECK <x:ON,OFF,&>                                     ;
 =>      m6_Set( _SET_TYPECHECK, <(x)> )

#command SET TYPECHECK (<x>)                                            ;
 =>      m6_Set( _SET_TYPECHECK,  <x>  )

#command SET OPTIMIZE <x:ON,OFF,&>                                      ;
 =>      m6_Set( _SET_OPTIMIZE, <(x)> )

#command SET OPTIMIZE (<x>)                                             ;
 =>      m6_Set( _SET_OPTIMIZE,  <x>  )

#command SET RECHECK <x:ON,OFF,&>                                    ;
 =>      m6_Set( _SET_RECHECK, <(x)> )

#command SET RECHECK (<x>)                                           ;
 =>      m6_Set( _SET_RECHECK,  <x>  )

