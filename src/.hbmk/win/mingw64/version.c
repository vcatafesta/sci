/*
 * Harbour 3.4.0dev (cf51c11f74) (2017-12-20 13:44)
 * MinGW GNU C 7.3 (64-bit)
 * PCode version: 0.3
 * Generated C source from "version.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( MAIN );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( HB_VERSION );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_VERSION )
{ "MAIN", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN ) }, NULL },
{ "QOUT", { HB_FS_PUBLIC }, { HB_FUNCNAME( QOUT ) }, NULL },
{ "HB_VERSION", { HB_FS_PUBLIC }, { HB_FUNCNAME( HB_VERSION ) }, NULL },
{ "__DBGENTRY", { HB_FS_PUBLIC }, { HB_FUNCNAME( __DBGENTRY ) }, NULL },
{ "(_INITLINES)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITLINES }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_VERSION, "version.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_VERSION
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_VERSION )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		51,118,101,114,115,105,111,110,46,112,114,103,58,77,65,73,78,0,36,
		4,0,176,1,0,20,0,36,5,0,176,1,0,106,45,86,101,114,115,
		105,111,110,44,32,67,111,112,121,114,105,103,104,116,40,99,41,32,50,
		48,49,56,44,32,86,105,108,109,97,114,32,67,97,116,97,102,101,115,
		116,97,0,20,1,36,6,0,176,1,0,106,18,86,101,114,115,97,111,
		32,72,97,114,98,111,117,114,32,58,32,0,176,2,0,121,12,1,20,
		2,36,7,0,176,1,0,106,18,67,111,109,112,105,108,101,114,32,67,
		43,43,32,32,32,58,32,0,176,2,0,122,12,1,20,2,36,8,0,
		176,1,0,20,0,36,9,0,176,1,0,20,0,36,10,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,118,101,114,115,105,111,110,46,112,114,103,58,40,95,73,78,73,84,
		76,73,78,69,83,41,0,106,12,118,101,114,115,105,111,110,46,112,114,
		103,0,121,106,3,240,7,0,4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}
