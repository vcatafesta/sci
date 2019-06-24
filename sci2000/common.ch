///////////////////////////////////////////////////////////////////////////////
//
//  Common.ch
//
//  Copyright:
//    Alaska Software GmbH, (c) 1995-96. All rights reserved.
//  
//  Contents :
//    Some commonly used directives
//
///////////////////////////////////////////////////////////////////////////////

#ifndef  _COMMON_CH       // Common.ch is not included

*******************************************************************************
* Constants for logical values
*******************************************************************************

#define  TRUE   .T.
#define  FALSE  .F.
#define  YES    .T.
#define  NO     .F.

*******************************************************************************
* Pseudo functions to check data types
*******************************************************************************

#translate ISARRAY(<v>)      =>  ( VALTYPE(<v>)=="A" )
#translate ISBLOCK(<v>)      =>  ( VALTYPE(<v>)=="B" )
#translate ISCHARACTER(<v>)  =>  ( VALTYPE(<v>)=="C" )
#translate ISDATE(<v>)       =>  ( VALTYPE(<v>)=="D" )
#translate ISLOGICAL(<v>)    =>  ( VALTYPE(<v>)=="L" )
#translate ISNIL(<v>)        =>  ( (<v>)==NIL )
#translate ISNUMBER(<v>)     =>  ( VALTYPE(<v>)=="N" )
#translate ISMEMO(<v>)       =>  ( VALTYPE(<v>)=="M" )
#translate ISOBJECT(<v>)     =>  ( VALTYPE(<v>)=="O" )

*******************************************************************************
* UDCs for parameter checking
*      DEFAULT p1 TO 1 , ;
*              p2 TO "Test" , ;
*              p3 TO {}
*******************************************************************************

#xcommand DEFAULT <var1> TO <val1> [,<varN> TO <valN>];
       => IF <var1> == NIL ; <var1> := <val1> ; ENDIF ;
       [; IF <varN> == NIL ; <varN> := <valN> ; ENDIF ]

*******************************************************************************
* UDC to update variables
*      UPDATE p1 IF VALTYPE(p1)<>"N" TO 1
*******************************************************************************

#command UPDATE <var1> IF <expression> TO <val1> ;
      => IF <expression> ; <var1> := <val1> ; ENDIF

#define  _COMMON_CH       // Common.ch is included

#endif                    // #ifndef _COMMON_CH

// * EOF *
