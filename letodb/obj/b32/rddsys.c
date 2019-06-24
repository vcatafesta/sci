/*
 * Harbour 3.2.0dev (r1310281618)
 * MinGW GNU C 4.8.1 (32-bit)
 * Generated C source from "source\client\rddsys.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( LETO_INIT );
HB_FUNC_EXTERN( RDDSETDEFAULT );
HB_FUNC_EXTERN( LETO );
HB_FUNC( RDDLETO );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_RDDSYS )
{ "LETO_INIT", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( LETO_INIT )}, NULL },
{ "RDDSETDEFAULT", {HB_FS_PUBLIC}, {HB_FUNCNAME( RDDSETDEFAULT )}, NULL },
{ "LETO", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO )}, NULL },
{ "RDDLETO", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( RDDLETO )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_RDDSYS, "source\\client\\rddsys.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_RDDSYS
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_RDDSYS )
   #include "hbiniseg.h"
#endif

HB_FUNC( LETO_INIT )
{
	static const HB_BYTE pcode[] =
	{
		36,57,0,176,1,0,106,5,76,69,84,79,0,20,
		1,36,58,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( RDDLETO )
{
	static const HB_BYTE pcode[] =
	{
		7
	};

	hb_vmExecute( pcode, symbols );
}

