/*
 * Harbour 3.4.0dev (cf51c11f74) (2017-12-20 13:44)
 * MinGW GNU C 7.3 (64-bit)
 * PCode version: 0.3
 * Generated C source from "tbdemo.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( MAIN );
HB_FUNC_EXTERN( ADIR );
HB_FUNC_EXTERN( SET );
HB_FUNC_EXTERN( AFILL );
HB_FUNC_EXTERN( AEVAL );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( DIRECTORY );
HB_FUNC_EXTERN( AADD );
HB_FUNC_EXTERN( DTOC );
HB_FUNC_EXTERN( SUBSTR );
HB_FUNC_EXTERN( TRANSFORM );
HB_FUNC_EXTERN( PADR );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( SETCOLOR );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( DISPBOX );
HB_FUNC_EXTERN( SPACE );
HB_FUNC_EXTERN( ACHOICE );
HB_FUNC( QUITTBDEMO );
HB_FUNC_EXTERN( DBUSEAREA );
HB_FUNC_EXTERN( ALLTRIM );
HB_FUNC_EXTERN( RIGHT );
HB_FUNC_EXTERN( BROWSE );
HB_FUNC_EXTERN( MAXROW );
HB_FUNC_EXTERN( __QUIT );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TBDEMO )
{ "MAIN", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( MAIN ) }, NULL },
{ "ADIR", { HB_FS_PUBLIC }, { HB_FUNCNAME( ADIR ) }, NULL },
{ "SET", { HB_FS_PUBLIC }, { HB_FUNCNAME( SET ) }, NULL },
{ "AFILL", { HB_FS_PUBLIC }, { HB_FUNCNAME( AFILL ) }, NULL },
{ "AEVAL", { HB_FS_PUBLIC }, { HB_FUNCNAME( AEVAL ) }, NULL },
{ "QOUT", { HB_FS_PUBLIC }, { HB_FUNCNAME( QOUT ) }, NULL },
{ "DIRECTORY", { HB_FS_PUBLIC }, { HB_FUNCNAME( DIRECTORY ) }, NULL },
{ "AADD", { HB_FS_PUBLIC }, { HB_FUNCNAME( AADD ) }, NULL },
{ "DTOC", { HB_FS_PUBLIC }, { HB_FUNCNAME( DTOC ) }, NULL },
{ "SUBSTR", { HB_FS_PUBLIC }, { HB_FUNCNAME( SUBSTR ) }, NULL },
{ "TRANSFORM", { HB_FS_PUBLIC }, { HB_FUNCNAME( TRANSFORM ) }, NULL },
{ "PADR", { HB_FS_PUBLIC }, { HB_FUNCNAME( PADR ) }, NULL },
{ "SCROLL", { HB_FS_PUBLIC }, { HB_FUNCNAME( SCROLL ) }, NULL },
{ "SETPOS", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETPOS ) }, NULL },
{ "SETCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETCOLOR ) }, NULL },
{ "LEN", { HB_FS_PUBLIC }, { HB_FUNCNAME( LEN ) }, NULL },
{ "NROW1", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "DISPBOX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DISPBOX ) }, NULL },
{ "SPACE", { HB_FS_PUBLIC }, { HB_FUNCNAME( SPACE ) }, NULL },
{ "ACHOICE", { HB_FS_PUBLIC }, { HB_FUNCNAME( ACHOICE ) }, NULL },
{ "QUITTBDEMO", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( QUITTBDEMO ) }, NULL },
{ "DBUSEAREA", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBUSEAREA ) }, NULL },
{ "ALLTRIM", { HB_FS_PUBLIC }, { HB_FUNCNAME( ALLTRIM ) }, NULL },
{ "RIGHT", { HB_FS_PUBLIC }, { HB_FUNCNAME( RIGHT ) }, NULL },
{ "BROWSE", { HB_FS_PUBLIC }, { HB_FUNCNAME( BROWSE ) }, NULL },
{ "MAXROW", { HB_FS_PUBLIC }, { HB_FUNCNAME( MAXROW ) }, NULL },
{ "__QUIT", { HB_FS_PUBLIC }, { HB_FUNCNAME( __QUIT ) }, NULL },
{ "__DBGENTRY", { HB_FS_PUBLIC }, { HB_FUNCNAME( __DBGENTRY ) }, NULL },
{ "(_INITLINES)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITLINES }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TBDEMO, "tbdemo.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TBDEMO
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TBDEMO )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,5,1,51,116,98,100,101,109,111,46,112,114,103,58,77,65,73,78,
		0,37,1,0,65,82,71,67,0,36,11,0,37,2,0,88,67,79,82,
		73,78,71,65,0,106,6,42,46,68,66,70,0,80,2,36,12,0,37,
		3,0,65,70,73,76,69,76,73,83,84,0,4,0,0,80,3,36,13,
		0,37,4,0,65,70,73,76,69,83,0,176,1,0,95,2,12,1,3,
		1,0,80,4,36,14,0,37,5,0,65,83,69,76,69,67,84,0,176,
		1,0,95,2,12,1,3,1,0,80,5,36,15,0,37,6,0,78,67,
		72,79,73,67,69,0,36,17,0,176,2,0,92,11,106,3,79,78,0,
		20,2,36,18,0,95,1,100,5,29,33,2,36,19,0,176,3,0,95,
		5,120,20,2,36,20,0,176,1,0,95,2,95,4,20,2,36,21,0,
		176,4,0,95,4,89,43,0,1,0,0,0,51,116,98,100,101,109,111,
		46,112,114,103,58,77,65,73,78,0,37,1,0,69,76,69,77,69,78,
		84,0,176,5,0,95,1,12,1,6,20,2,36,28,0,176,4,0,176,
		6,0,95,2,12,1,89,177,0,1,0,1,0,3,0,51,116,98,100,
		101,109,111,46,112,114,103,58,77,65,73,78,0,37,255,255,65,70,73,
		76,69,76,73,83,84,0,37,1,0,65,68,73,82,69,67,84,79,82,
		89,0,176,7,0,95,255,176,8,0,95,1,92,3,1,12,1,106,3,
		32,32,0,72,176,9,0,95,1,92,4,1,122,92,5,12,3,72,106,
		3,32,32,0,72,176,9,0,95,1,92,5,1,122,122,12,3,106,2,
		68,0,8,28,15,106,9,32,32,32,60,68,73,82,62,0,25,31,176,
		10,0,95,1,92,2,1,106,17,57,57,44,57,57,57,44,57,57,57,
		32,66,121,116,101,115,0,12,2,72,106,3,32,32,0,72,176,11,0,
		95,1,122,1,92,15,12,2,72,12,2,6,20,2,36,30,0,176,12,
		0,20,0,176,13,0,121,121,20,2,36,31,0,176,5,0,106,51,77,
		97,99,114,111,115,111,102,116,32,84,68,66,100,101,109,111,44,32,67,
		111,112,121,114,105,103,104,116,32,40,99,41,44,32,86,105,108,109,97,
		114,32,67,97,116,97,102,101,115,116,97,0,20,1,36,32,0,176,5,
		0,106,31,91,69,83,67,93,32,115,97,105,114,44,32,91,69,78,84,
		69,82,93,32,115,101,108,101,99,105,111,110,97,114,0,20,1,36,33,
		0,176,14,0,106,5,87,43,47,66,0,20,1,36,34,0,92,5,176,
		15,0,95,3,12,1,72,83,16,0,36,35,0,109,16,0,92,24,15,
		28,10,36,36,0,92,24,83,16,0,36,38,0,176,17,0,92,5,92,
		10,109,16,0,122,72,92,70,106,9,214,196,183,186,189,196,211,186,0,
		176,18,0,122,12,1,72,20,5,36,39,0,176,19,0,92,6,92,11,
		109,16,0,92,69,95,3,12,5,80,6,36,40,0,95,6,121,5,28,
		10,36,41,0,176,20,0,20,0,36,43,0,176,21,0,120,100,176,22,
		0,176,23,0,95,3,95,6,1,92,15,12,2,12,1,100,100,9,20,
		6,25,17,36,45,0,176,21,0,120,100,95,1,100,100,9,20,6,36,
		47,0,176,24,0,20,0,36,48,0,176,20,0,20,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( QUITTBDEMO )
{
	static const HB_BYTE pcode[] =
	{
		51,116,98,100,101,109,111,46,112,114,103,58,81,85,73,84,84,66,68,
		69,77,79,0,36,51,0,176,14,0,106,1,0,20,1,36,52,0,176,
		13,0,176,25,0,12,0,121,20,2,36,53,0,176,5,0,106,29,77,
		97,99,114,111,115,111,102,116,32,84,68,66,100,101,109,111,32,116,101,
		114,109,105,110,97,116,101,33,0,20,1,36,54,0,176,26,0,20,0,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,116,98,100,101,109,111,46,112,114,103,58,40,95,73,78,73,84,76,
		73,78,69,83,41,0,106,11,116,98,100,101,109,111,46,112,114,103,0,
		92,8,106,7,248,62,208,223,171,121,0,4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}