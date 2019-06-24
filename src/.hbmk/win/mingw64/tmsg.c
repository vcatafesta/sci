/*
 * Harbour 3.4.0dev (dad733a) (2017-05-10 08:44)
 * MinGW GNU C 6.3 (64-bit)
 * Generated C source from "tmsg.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( TMSG );
HB_FUNC_EXTERN( MSG );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TMSG )
{ "TMSG", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( TMSG )}, NULL },
{ "MSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( MSG )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TMSG, "tmsg.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TMSG
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TMSG )
   #include "hbiniseg.h"
#endif

HB_FUNC( TMSG )
{
	static const HB_BYTE pcode[] =
	{
		51,116,109,115,103,46,112,114,103,58,84,77,83,71,
		0,36,1,0,176,1,0,106,6,116,101,115,116,101,
		0,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,116,109,115,103,46,112,114,103,58,40,95,73,78,
		73,84,76,73,78,69,83,41,0,106,9,116,109,115,
		103,46,112,114,103,0,121,106,2,2,0,4,3,0,
		4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

