/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "letodir.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( RDDSETDEFAULT );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( DEVPOS );
HB_FUNC_EXTERN( DEVOUT );
HB_FUNC_EXTERN( LETO_DIRECTORY );
HB_FUNC_EXTERN( SPACE );
HB_FUNC_EXTERN( STR );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( LETO_DIREXIST );
HB_FUNC_EXTERN( LETO_CONNECT );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_EXTERN( LETO );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_LETODIR )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "RDDSETDEFAULT", {HB_FS_PUBLIC}, {HB_FUNCNAME( RDDSETDEFAULT )}, NULL },
{ "SCROLL", {HB_FS_PUBLIC}, {HB_FUNCNAME( SCROLL )}, NULL },
{ "SETPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETPOS )}, NULL },
{ "DEVPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVPOS )}, NULL },
{ "DEVOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVOUT )}, NULL },
{ "LETO_DIRECTORY", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO_DIRECTORY )}, NULL },
{ "SPACE", {HB_FS_PUBLIC}, {HB_FUNCNAME( SPACE )}, NULL },
{ "STR", {HB_FS_PUBLIC}, {HB_FUNCNAME( STR )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "LETO_DIREXIST", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO_DIREXIST )}, NULL },
{ "LETO_CONNECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO_CONNECT )}, NULL },
{ "INKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( INKEY )}, NULL },
{ "LETO", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_LETODIR, "letodir.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_LETODIR
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_LETODIR )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,2,0,51,108,101,116,111,100,105,114,46,112,114,
		103,58,77,65,73,78,0,36,3,0,37,1,0,67,
		80,65,84,72,0,37,2,0,65,68,73,82,0,36,
		6,0,176,1,0,106,5,76,69,84,79,0,20,1,
		36,8,0,176,2,0,20,0,176,3,0,121,121,20,
		2,36,9,0,106,18,47,47,49,50,55,46,48,46,
		48,46,49,58,50,56,49,50,47,0,80,1,36,10,
		0,176,4,0,122,92,2,20,2,176,5,0,106,44,
		76,101,116,111,95,68,105,114,101,99,116,111,114,121,
		40,32,99,80,97,84,72,44,32,99,80,97,114,97,
		109,32,41,32,32,32,32,65,114,113,117,105,118,111,
		115,0,20,1,36,12,0,176,6,0,95,1,12,1,
		80,2,36,13,0,176,4,0,92,2,92,2,20,2,
		176,5,0,106,13,99,80,97,114,97,109,32,61,32,
		39,32,39,0,176,7,0,92,25,12,1,72,176,8,
		0,176,9,0,95,2,12,1,92,6,12,2,72,20,
		1,36,15,0,176,6,0,95,1,106,2,68,0,12,
		2,80,2,36,16,0,176,4,0,92,3,92,2,20,
		2,176,5,0,106,13,99,80,97,114,97,109,32,61,
		32,39,68,39,0,176,7,0,92,25,12,1,72,176,
		8,0,176,9,0,95,2,12,1,92,6,12,2,72,
		20,1,36,18,0,176,6,0,95,1,106,2,72,0,
		12,2,80,2,36,19,0,176,4,0,92,4,92,2,
		20,2,176,5,0,106,13,99,80,97,114,97,109,32,
		61,32,39,72,39,0,176,7,0,92,25,12,1,72,
		176,8,0,176,9,0,95,2,12,1,92,6,12,2,
		72,20,1,36,21,0,176,6,0,95,1,106,2,83,
		0,12,2,80,2,36,22,0,176,4,0,92,5,92,
		2,20,2,176,5,0,106,13,99,80,97,114,97,109,
		32,61,32,39,83,39,0,176,7,0,92,25,12,1,
		72,176,8,0,176,9,0,95,2,12,1,92,6,12,
		2,72,20,1,36,24,0,176,6,0,95,1,106,2,
		86,0,12,2,80,2,36,25,0,176,4,0,92,6,
		92,2,20,2,176,5,0,106,13,99,80,97,114,97,
		109,32,61,32,39,86,39,0,176,7,0,92,25,12,
		1,72,176,8,0,176,9,0,95,2,12,1,92,6,
		12,2,72,20,1,36,27,0,176,10,0,176,11,0,
		95,1,106,9,47,69,77,80,48,48,48,56,0,72,
		12,1,20,1,36,29,0,176,10,0,176,12,0,106,
		10,108,111,99,97,108,104,111,115,116,0,100,100,93,
		48,117,12,4,121,35,20,1,36,30,0,176,10,0,
		176,12,0,106,10,49,50,55,46,48,46,48,46,49,
		0,100,100,93,48,117,12,4,121,35,20,1,36,32,
		0,176,13,0,121,20,1,36,35,0,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,108,101,116,111,100,105,114,46,112,114,103,58,40,
		95,73,78,73,84,76,73,78,69,83,41,0,106,12,
		108,101,116,111,100,105,114,46,112,114,103,0,121,106,
		6,72,183,109,107,9,0,4,3,0,4,1,0,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}
