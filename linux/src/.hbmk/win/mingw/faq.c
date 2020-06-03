/* C source generated by Harbour */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( MAIN );
HB_FUNC_EXTERN( ERRORNEW );
HB_FUNC_EXTERN( __MVPRIVATE );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( QOUT );
HB_FUNC( MAIN1 );
HB_FUNC( MAIN2 );
HB_FUNC( MAIN3 );
HB_FUNC( MAIN4 );
HB_FUNC( MAIN5 );
HB_FUNC( FNC1 );
HB_FUNC_EXTERN( SECONDS );
HB_FUNC_EXTERN( INKEY );
HB_FUNC( P );
HB_FUNC_EXTERN( AEVAL );
HB_FUNC( F );
HB_FUNC( AGET );
HB_FUNC( INFO );
HB_FUNC_EXTERN( DATE );

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_FAQ )
{ "MAIN", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN ) }, NULL },
{ "ERRORNEW", { HB_FS_PUBLIC }, { HB_FUNCNAME( ERRORNEW ) }, NULL },
{ "VAR", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "__MVPRIVATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( __MVPRIVATE ) }, NULL },
{ "UPPER", { HB_FS_PUBLIC }, { HB_FUNCNAME( UPPER ) }, NULL },
{ "QOUT", { HB_FS_PUBLIC }, { HB_FUNCNAME( QOUT ) }, NULL },
{ "MAIN1", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN1 ) }, NULL },
{ "MAIN2", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN2 ) }, NULL },
{ "MAIN3", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN3 ) }, NULL },
{ "MAIN4", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN4 ) }, NULL },
{ "MAIN5", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN5 ) }, NULL },
{ "FNC1", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( FNC1 ) }, NULL },
{ "SECONDS", { HB_FS_PUBLIC }, { HB_FUNCNAME( SECONDS ) }, NULL },
{ "EVAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "INKEY", { HB_FS_PUBLIC }, { HB_FUNCNAME( INKEY ) }, NULL },
{ "P", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( P ) }, NULL },
{ "AEVAL", { HB_FS_PUBLIC }, { HB_FUNCNAME( AEVAL ) }, NULL },
{ "F", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( F ) }, NULL },
{ "AGET", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( AGET ) }, NULL },
{ "INFO", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( INFO ) }, NULL },
{ "DATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( DATE ) }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_FAQ, "", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_FAQ
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_FAQ )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,2,0,36,3,0,176,1,0,12,0,80,1,106,6,99,97,114,103,
		111,0,80,2,36,4,0,106,4,67,65,82,0,176,3,0,108,2,20,
		1,81,2,0,36,6,0,106,2,95,0,95,2,72,46,95,1,106,8,
		47,99,97,114,103,111,47,0,112,1,73,36,7,0,106,2,95,0,176,
		4,0,95,2,12,1,72,46,95,1,21,176,4,0,95,2,12,1,46,
		163,0,112,0,106,8,47,118,97,108,117,101,47,0,72,112,1,73,36,
		8,0,176,5,0,106,8,38,86,65,82,46,71,79,0,47,46,95,1,
		112,0,20,1,36,10,0,176,6,0,20,0,36,11,0,176,7,0,20,
		0,36,12,0,176,8,0,20,0,36,13,0,176,9,0,20,0,36,14,
		0,176,10,0,20,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN1 )
{
	static const HB_BYTE pcode[] =
	{
		13,2,0,36,20,0,176,11,0,176,12,0,12,0,12,1,80,1,36,
		21,0,176,5,0,48,13,0,95,1,112,0,20,1,36,23,0,176,5,
		0,106,14,80,114,101,115,115,32,97,110,121,32,107,101,121,0,20,1,
		36,24,0,176,14,0,121,20,1,36,26,0,176,11,0,176,12,0,12,
		0,12,1,80,2,36,27,0,176,5,0,48,13,0,95,2,112,0,20,
		1,36,29,0,176,5,0,106,14,80,114,101,115,115,32,97,110,121,32,
		107,101,121,0,20,1,36,30,0,176,14,0,121,20,1,36,32,0,176,
		5,0,48,13,0,95,1,176,12,0,12,0,112,1,20,1,36,34,0,
		176,5,0,106,14,80,114,101,115,115,32,97,110,121,32,107,101,121,0,
		20,1,36,35,0,176,14,0,121,20,1,36,37,0,176,5,0,48,13,
		0,95,1,112,0,20,1,36,38,0,176,5,0,20,0,36,40,0,100,
		110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( FNC1 )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,36,44,0,89,36,0,1,0,1,0,1,0,36,45,0,95,
		255,36,46,0,95,1,100,69,28,9,36,47,0,95,1,80,255,36,49,
		0,95,2,6,80,2,36,52,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN2 )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,36,56,0,122,92,2,92,3,4,3,0,80,1,36,58,0,
		176,5,0,95,1,122,1,95,1,92,2,1,95,1,92,3,1,20,3,
		36,59,0,176,15,0,95,1,92,2,148,20,1,36,60,0,176,5,0,
		95,1,122,1,95,1,92,2,1,95,1,92,3,1,20,3,36,62,0,
		100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( P )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,65,0,126,1,10,0,36,66,0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN3 )
{
	static const HB_BYTE pcode[] =
	{
		36,80,0,176,16,0,176,17,0,106,2,49,0,106,2,50,0,106,2,
		65,0,106,2,66,0,106,2,67,0,12,5,89,17,0,2,0,0,0,
		176,5,0,95,2,95,1,12,2,6,20,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( F )
{
	static const HB_BYTE pcode[] =
	{
		149,0,2,36,83,0,176,5,0,106,4,80,49,58,0,95,1,20,2,
		36,84,0,176,5,0,106,4,80,50,58,0,95,2,20,2,36,85,0,
		176,5,0,106,18,111,116,104,101,114,32,112,97,114,97,109,101,116,101,
		114,115,58,0,122,164,124,2,0,36,86,0,106,2,88,0,122,164,106,
		2,89,0,122,164,106,2,90,0,122,41,5,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN4 )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,36,90,0,122,92,2,4,2,0,92,3,92,4,4,2,0,
		92,5,4,3,0,80,1,36,91,0,176,5,0,176,18,0,95,1,122,
		92,2,12,3,176,18,0,95,1,92,2,122,12,3,176,18,0,95,1,
		92,3,12,2,20,3,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( AGET )
{
	static const HB_BYTE pcode[] =
	{
		149,0,1,36,94,0,95,1,164,43,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( MAIN5 )
{
	static const HB_BYTE pcode[] =
	{
		36,98,0,176,19,0,106,6,116,101,115,116,49,0,20,1,36,99,0,
		176,19,0,106,6,116,101,115,116,50,0,92,10,176,20,0,12,0,120,
		20,4,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( INFO )
{
	static const HB_BYTE pcode[] =
	{
		149,0,1,36,102,0,176,5,0,106,2,91,0,95,1,72,106,4,93,
		58,32,0,72,122,164,124,2,0,7
	};

	hb_vmExecute( pcode, symbols );
}
