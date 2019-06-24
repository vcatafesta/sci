/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "forc.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( FORC );
HB_FUNC( MAIN );
HB_FUNC_EXTERN( MS_FORX_C );


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_FORC )
{ "FORC", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( FORC )}, NULL },
{ "MAIN", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "MS_FORX_C", {HB_FS_PUBLIC}, {HB_FUNCNAME( MS_FORX_C )}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_FORC, "forc.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_FORC
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_FORC )
   #include "hbiniseg.h"
#endif

HB_FUNC( FORC )
{
	static const HB_BYTE pcode[] =
	{
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		36,2,0,176,2,0,20,0,7
	};

	hb_vmExecute( pcode, symbols );
}

#line 6 "forc.prg"
#include "hbdefs.h"
#include "hbapi.h"
#include "hbapigt.h"
#include <iostream>
#include <windows.h>
using namespace std;

HB_FUNC( MS_FORX_C )
{
   int n;
	for( n=0; n <= 1000; ++n )
      printf("Hello World %i\n", n);	
 
}

