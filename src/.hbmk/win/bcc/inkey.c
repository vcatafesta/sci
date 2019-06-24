/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "inkey.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( LASTKEY );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_INKEY )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "LASTKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( LASTKEY )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "INKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( INKEY )}, NULL },
{ "NKEY", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_INKEY, "inkey.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_INKEY
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_INKEY )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		51,105,110,107,101,121,46,112,114,103,58,77,65,73,
		78,0,36,4,0,176,1,0,12,0,92,27,69,28,
		121,36,5,0,176,2,0,106,44,73,110,107,101,121,
		44,32,67,111,112,121,114,105,103,104,116,40,99,41,
		44,32,86,105,108,109,97,114,32,67,97,116,97,102,
		101,115,116,97,44,32,50,48,49,56,0,20,1,36,
		6,0,176,2,0,106,27,84,101,99,108,101,32,117,
		109,97,32,116,101,99,108,97,44,32,69,83,67,32,
		115,97,105,114,58,0,20,1,36,7,0,176,3,0,
		121,12,1,83,4,0,36,8,0,176,2,0,176,1,
		0,12,0,20,1,26,127,255,36,9,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,105,110,107,101,121,46,112,114,103,58,40,95,73,
		78,73,84,76,73,78,69,83,41,0,106,10,105,110,
		107,101,121,46,112,114,103,0,121,106,3,240,3,0,
		4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

