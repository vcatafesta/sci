/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "leto1.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( LETO1 );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( LETO_GETAPPOPTIONS );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_LETO1 )
{ "LETO1", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( LETO1 )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "LETO_GETAPPOPTIONS", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO_GETAPPOPTIONS )}, NULL },
{ "CPATH", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_LETO1, "leto1.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_LETO1
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_LETO1 )
   #include "hbiniseg.h"
#endif

HB_FUNC( LETO1 )
{
	static const HB_BYTE pcode[] =
	{
		51,108,101,116,111,49,46,112,114,103,58,76,69,84,
		79,49,0,36,1,0,176,1,0,176,2,0,122,12,
		1,165,83,3,0,20,1,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,108,101,116,111,49,46,112,114,103,58,40,95,73,
		78,73,84,76,73,78,69,83,41,0,106,10,108,101,
		116,111,49,46,112,114,103,0,121,106,2,2,0,4,
		3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

