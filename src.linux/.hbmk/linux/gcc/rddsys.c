/*
 * Harbour 3.2.0dev (r1610041322)
 * GNU C 5.4 (64-bit)
 * Generated C source from "src/rddsys.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC_INIT( RDDINIT );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();
HB_FUNC( RDDSYS );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_RDDSYS )
{ "RDDINIT$", {HB_FS_INIT | HB_FS_LOCAL}, {HB_INIT_FUNCNAME( RDDINIT )}, NULL },
{ "DBFNTX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNTX )}, NULL },
{ "DBFCDX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFCDX )}, NULL },
{ "DBFNSX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNSX )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL },
{ "RDDSYS", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( RDDSYS )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_RDDSYS, "src/rddsys.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_RDDSYS
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_RDDSYS )
   #include "hbiniseg.h"
#endif

HB_FUNC_INIT( RDDINIT )
{
	static const HB_BYTE pcode[] =
	{
		51,115,114,99,47,114,100,100,115,121,115,46,112,114,
		103,58,82,68,68,73,78,73,84,36,0,36,28,0,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,115,114,99,47,114,100,100,115,121,115,46,112,114,
		103,58,40,95,73,78,73,84,76,73,78,69,83,41,
		0,106,15,115,114,99,47,114,100,100,115,121,115,46,
		112,114,103,0,92,24,106,2,16,0,4,3,0,4,
		1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( RDDSYS )
{
	static const HB_BYTE pcode[] =
	{
		7
	};

	hb_vmExecute( pcode, symbols );
}

