/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "parametro.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( HB_APARAMS );
HB_FUNC_EXTERN( QOUT );
HB_FUNC( TESTE );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_PARAMETRO )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "HB_APARAMS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_APARAMS )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "TESTE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TESTE )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_PARAMETRO, "parametro.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_PARAMETRO
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_PARAMETRO )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		149,2,0,51,112,97,114,97,109,101,116,114,111,46,
		112,114,103,58,77,65,73,78,0,36,2,0,37,1,
		0,65,80,65,82,0,176,1,0,12,0,80,1,36,
		3,0,37,2,0,67,80,65,82,0,36,4,0,95,
		1,96,2,0,129,1,1,28,31,36,5,0,176,2,
		0,106,11,80,97,114,97,109,101,116,114,111,58,0,
		95,2,20,2,36,6,0,130,31,229,132,36,7,0,
		176,3,0,164,124,1,0,36,9,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TESTE )
{
	static const HB_BYTE pcode[] =
	{
		149,2,0,51,112,97,114,97,109,101,116,114,111,46,
		112,114,103,58,84,69,83,84,69,0,36,12,0,37,
		1,0,65,80,65,82,0,176,1,0,12,0,80,1,
		36,13,0,37,2,0,67,80,65,82,0,36,14,0,
		95,1,96,2,0,129,1,1,28,38,36,15,0,176,
		2,0,106,11,80,97,114,97,109,101,116,114,111,58,
		0,95,2,176,4,0,95,2,12,1,20,3,36,16,
		0,130,31,222,132,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,112,97,114,97,109,101,116,114,111,46,112,114,103,
		58,40,95,73,78,73,84,76,73,78,69,83,41,0,
		106,14,112,97,114,97,109,101,116,114,111,46,112,114,
		103,0,121,106,3,252,242,1,4,3,0,4,1,0,
		110,7
	};

	hb_vmExecute( pcode, symbols );
}

