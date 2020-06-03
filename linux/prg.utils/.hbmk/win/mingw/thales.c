/* C source generated by Harbour */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( MAIN );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( ALERT );
HB_FUNC_EXTERN( __QUIT );

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_THALES )
{ "MAIN", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN ) }, NULL },
{ "SCROLL", { HB_FS_PUBLIC }, { HB_FUNCNAME( SCROLL ) }, NULL },
{ "SETPOS", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETPOS ) }, NULL },
{ "ALERT", { HB_FS_PUBLIC }, { HB_FUNCNAME( ALERT ) }, NULL },
{ "__QUIT", { HB_FS_PUBLIC }, { HB_FUNCNAME( __QUIT ) }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_THALES, "", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_THALES
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_THALES )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		36,2,0,176,1,0,20,0,176,2,0,121,121,20,2,36,3,0,176,
		3,0,106,26,79,108,195,161,32,84,104,97,108,101,115,44,32,70,101,
		108,105,122,32,78,105,118,101,114,33,0,20,1,36,4,0,176,4,0,
		20,0,7
	};

	hb_vmExecute( pcode, symbols );
}