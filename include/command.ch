#ifndef _COMMAND_CH_
#define _COMMAND_CH_
/******************************************************************************************************/
#XCOMMAND DEFAULT <v1> TO <x1> [, <vn> TO <xn> ]	=>	if <v1> == NIL ; <v1> := <x1> ; END	[; if <vn> == NIL ; <vn> := <xn> ; END ]
#XCOMMAND DEFAU   <v1> TO <x1> [, <vn> TO <xn> ]   =>	if <v1> == NIL ; <v1> := <x1> ; END	[; if <vn> == NIL ; <vn> := <xn> ; END ]
/******************************************************************************************************/
#xcommand WA_USE( <alias> )      				=> USE <alias> SHARED NEW ;;
																HB_DBDETACH( <(alias)> )
#xcommand WA_LOCK( <alias> )     				=> HB_DBREQUEST( <(alias)> )
#xcommand WA_UNLOCK( <alias> )   				=> HB_DBDETACH( <(alias)> )
/******************************************************************************************************/
#COMMAND XTRIM <cString>        					=> LTrim(RTrim(<cString>)
#COMMAND PUTS [<list,...>]           			=> QOUT(<list>)
#COMMAND MS_EVAL(<bBloco>, <list,...>)			=> eval(<bBloco>, <list>)
#COMMAND SET BLOCO TO <bBloco>, [<list,...>]	=> eval(<bBloco>, <list>)
#xcommand PUBLIC:     								=> nScope := HB_OO_CLSTP_EXPORTED ; HB_SYMBOL_UNUSED( nScope )
/******************************************************************************************************/
#COMMAND Area( <whatever> )															;
			 => dbSelectArea( <(whatever)> )

#COMMAND Print <row>, <col> <xpr>													;
					[PICTURE <pic>]														;
					[COLOR <color>]														;
			=> DevPos( <row>, <col> )													;
			 ; DevOutPict( <xpr>, <pic> [, <color>] )

#COMMAND Print <row>, <col> <xpr>													;
					[COLOR <color>]														;
			 => DevPos( <row>, <col> ) 												;
			  ; DevOut( <xpr> [, <color>] )

#COMMAND @ <row>, <col> GET <var> [PICTURE <pic>] [VALID <valid>] 		;
								[WHEN <when>]												;
								[SEND <msg>]												;
			=> SetCursor(1)																;
			 ; SetPos( <row>, <col> )													;
			 ; AAdd( GetList, _GET_( <var>, <(var)>, <pic>, <{valid}>, <{when}>));
			 [; ATail(GetList):<msg>]

#COMMAND Print <row>, <col> GET <var> [PICTURE <pic>] [VALID <valid>]	;
									 [WHEN <when>] 										;
									 [SEND <msg>]											;
			 => SetCursor(1)																;
			  ; SetPos( <row>, <col> ) 												;
			  ; AAdd( GetList, _GET_( <var>, <(var)>, <pic>, <{valid}>,<{when}>));
			  [; ATail(GetList):<msg>]

#COMMAND @ <row>, <col> SAY <sayxpr> [<sayClauses,...>]						;
								GET <var>													;
								[<getClauses,...>]										;
			=> SetCursor(1)																;
			 ; @ <row>, <col> SAY <sayxpr> [<sayClauses>]						;
			 ; @ Row(), Col()+1 GET <var> [<getClauses>]

#COMMAND Print <row>, <col> <sayxpr> [<sayClauses,...>]						;
							 GET <var>														;
							 [<getClauses,...>]											;
			=> SetCursor(1)																;
			 ; @ <row>, <col> SAY <sayxpr> [<sayClauses>]						;
			 ; @ Row(), Col()+1 GET <var> [<getClauses>]

#endif /* _COMMAND_CH_ */