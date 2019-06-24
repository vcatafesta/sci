/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland/Embarcadero C++ 7.3 (32-bit)
 * Generated C source from "abs.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( ABS );
HB_FUNC_EXTERN( INKEY );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_ABS )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "ABS", {HB_FS_PUBLIC}, {HB_FUNCNAME( ABS )}, NULL },
{ "INKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( INKEY )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_ABS, "abs.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_ABS
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_ABS )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,2,0,36,2,0,92,50,80,1,36,3,0,92,
		27,80,2,36,7,0,176,1,0,176,2,0,95,1,
		95,2,49,12,1,20,1,36,8,0,176,1,0,176,
		2,0,95,2,95,1,49,12,1,20,1,36,9,0,
		176,1,0,176,2,0,93,167,254,12,1,20,1,36,
		10,0,176,3,0,121,20,1,36,11,0,121,110,7
	};

	hb_vmExecute( pcode, symbols );
}

