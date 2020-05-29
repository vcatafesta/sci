/*
 * Harbour 3.2.0dev (r1610041322)
 * GNU C 5.4 (64-bit)
 * Generated C source from "src/tstring.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( TSTRING );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_EXTERN( PROCNAME );
HB_FUNC_STATIC( TSTRING_NEW );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( CAPITALIZE );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( LOWER );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_STATIC( TSTRING_DESTROY );
HB_FUNC_STATIC( TSTRING_GETCHANGED );
HB_FUNC_STATIC( TSTRING_SETCHANGED );
HB_FUNC_STATIC( TSTRING_SETGET );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( HB_ISSTRING );
HB_FUNC_EXTERN( HB_ISLOGICAL );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFFPT );
HB_FUNC_EXTERN( SIXCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_MEMIO );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITSTATICS();
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TSTRING )
{ "TSTRING", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING )}, NULL },
{ "__CLSLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSLOCKDEF )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HBCLASS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBCLASS )}, NULL },
{ "HBOBJECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBOBJECT )}, NULL },
{ "ADDMULTIDATA", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "PROCNAME", {HB_FS_PUBLIC}, {HB_FUNCNAME( PROCNAME )}, NULL },
{ "ADDMETHOD", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TSTRING_NEW", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING_NEW )}, NULL },
{ "ADDINLINE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "BUFFER", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "CAPITALIZE", {HB_FS_PUBLIC}, {HB_FUNCNAME( CAPITALIZE )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "LOWER", {HB_FS_PUBLIC}, {HB_FUNCNAME( LOWER )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "TSTRING_DESTROY", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING_DESTROY )}, NULL },
{ "SETDESTRUCTOR", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TSTRING_GETCHANGED", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING_GETCHANGED )}, NULL },
{ "TSTRING_SETCHANGED", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING_SETCHANGED )}, NULL },
{ "TSTRING_SETGET", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TSTRING_SETGET )}, NULL },
{ "CREATE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__CLSUNLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSUNLOCKDEF )}, NULL },
{ "INSTANCE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__OBJHASMSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( __OBJHASMSG )}, NULL },
{ "INITCLASS", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_SET", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HB_ISSTRING", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISSTRING )}, NULL },
{ "_BUFFER", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_VALUE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_LCHANGED", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LCHANGED", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HB_ISLOGICAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISLOGICAL )}, NULL },
{ "DBFNTX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNTX )}, NULL },
{ "DBFCDX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFCDX )}, NULL },
{ "DBFFPT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFFPT )}, NULL },
{ "SIXCDX", {HB_FS_PUBLIC}, {HB_FUNCNAME( SIXCDX )}, NULL },
{ "DBFNSX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNSX )}, NULL },
{ "HB_MEMIO", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_MEMIO )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITSTATICS00001)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TSTRING, "src/tstring.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TSTRING
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TSTRING )
   #include "hbiniseg.h"
#endif

HB_FUNC( TSTRING )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,40,0,51,115,114,99,47,116,115,116,
		114,105,110,103,46,112,114,103,58,84,83,84,82,73,
		78,71,0,36,10,0,118,0,1,0,83,95,79,67,
		76,65,83,83,0,36,10,0,37,1,0,78,83,67,
		79,80,69,0,37,2,0,79,67,76,65,83,83,0,
		37,3,0,79,73,78,83,84,65,78,67,69,0,103,
		1,0,100,8,29,71,5,176,1,0,104,1,0,12,
		1,29,60,5,166,254,4,0,122,80,1,48,2,0,
		176,3,0,12,0,106,8,84,83,116,114,105,110,103,
		0,108,4,4,1,0,108,0,112,3,80,2,36,11,
		0,92,4,80,1,36,12,0,48,5,0,95,2,100,
		106,1,0,95,1,121,72,121,72,121,72,106,8,120,
		98,117,102,102,101,114,0,4,1,0,9,112,5,73,
		36,14,0,92,2,80,1,36,15,0,48,5,0,95,
		2,100,9,95,1,121,72,121,72,121,72,106,9,108,
		67,104,97,110,103,101,100,0,4,1,0,9,112,5,
		73,36,16,0,48,5,0,95,2,100,106,1,0,95,
		1,121,72,121,72,121,72,106,7,98,117,102,102,101,
		114,0,4,1,0,9,112,5,73,36,17,0,48,5,
		0,95,2,100,106,9,84,84,83,116,114,105,110,103,
		0,95,1,121,72,121,72,121,72,106,5,99,87,104,
		111,0,4,1,0,9,112,5,73,36,18,0,48,5,
		0,95,2,100,176,6,0,12,0,95,1,121,72,121,
		72,121,72,106,6,99,78,111,109,101,0,4,1,0,
		9,112,5,73,36,20,0,122,80,1,36,21,0,48,
		5,0,95,2,100,106,1,0,95,1,121,72,121,72,
		121,72,106,6,118,97,108,117,101,0,4,1,0,9,
		112,5,73,36,23,0,122,80,1,36,24,0,48,7,
		0,95,2,106,4,110,101,119,0,108,8,95,1,92,
		8,72,121,72,121,72,112,3,73,36,25,0,48,9,
		0,95,2,106,4,108,101,110,0,89,53,0,1,0,
		0,0,51,115,114,99,47,116,115,116,114,105,110,103,
		46,112,114,103,58,84,83,84,82,73,78,71,0,37,
		1,0,83,69,76,70,0,176,10,0,48,11,0,95,
		1,112,0,12,1,6,95,1,121,72,121,72,121,72,
		112,3,73,36,26,0,48,9,0,95,2,106,11,99,
		97,112,105,116,97,108,105,122,101,0,89,53,0,1,
		0,0,0,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,0,
		37,1,0,83,69,76,70,0,176,12,0,48,11,0,
		95,1,112,0,12,1,6,95,1,121,72,121,72,121,
		72,112,3,73,36,27,0,48,9,0,95,2,106,7,
		117,112,99,97,115,101,0,89,53,0,1,0,0,0,
		51,115,114,99,47,116,115,116,114,105,110,103,46,112,
		114,103,58,84,83,84,82,73,78,71,0,37,1,0,
		83,69,76,70,0,176,13,0,48,11,0,95,1,112,
		0,12,1,6,95,1,121,72,121,72,121,72,112,3,
		73,36,28,0,48,9,0,95,2,106,6,117,112,112,
		101,114,0,89,53,0,1,0,0,0,51,115,114,99,
		47,116,115,116,114,105,110,103,46,112,114,103,58,84,
		83,84,82,73,78,71,0,37,1,0,83,69,76,70,
		0,176,13,0,48,11,0,95,1,112,0,12,1,6,
		95,1,121,72,121,72,121,72,112,3,73,36,29,0,
		48,9,0,95,2,106,8,116,111,117,112,112,101,114,
		0,89,53,0,1,0,0,0,51,115,114,99,47,116,
		115,116,114,105,110,103,46,112,114,103,58,84,83,84,
		82,73,78,71,0,37,1,0,83,69,76,70,0,176,
		13,0,48,11,0,95,1,112,0,12,1,6,95,1,
		121,72,121,72,121,72,112,3,73,36,30,0,48,9,
		0,95,2,106,9,100,111,119,110,99,97,115,101,0,
		89,53,0,1,0,0,0,51,115,114,99,47,116,115,
		116,114,105,110,103,46,112,114,103,58,84,83,84,82,
		73,78,71,0,37,1,0,83,69,76,70,0,176,14,
		0,48,11,0,95,1,112,0,12,1,6,95,1,121,
		72,121,72,121,72,112,3,73,36,31,0,48,9,0,
		95,2,106,8,116,111,108,111,119,101,114,0,89,53,
		0,1,0,0,0,51,115,114,99,47,116,115,116,114,
		105,110,103,46,112,114,103,58,84,83,84,82,73,78,
		71,0,37,1,0,83,69,76,70,0,176,14,0,48,
		11,0,95,1,112,0,12,1,6,95,1,121,72,121,
		72,121,72,112,3,73,36,32,0,48,9,0,95,2,
		106,6,108,111,119,101,114,0,89,53,0,1,0,0,
		0,51,115,114,99,47,116,115,116,114,105,110,103,46,
		112,114,103,58,84,83,84,82,73,78,71,0,37,1,
		0,83,69,76,70,0,176,14,0,48,11,0,95,1,
		112,0,12,1,6,95,1,121,72,121,72,121,72,112,
		3,73,36,33,0,48,9,0,95,2,106,5,116,121,
		112,101,0,89,53,0,1,0,0,0,51,115,114,99,
		47,116,115,116,114,105,110,103,46,112,114,103,58,84,
		83,84,82,73,78,71,0,37,1,0,83,69,76,70,
		0,176,15,0,48,11,0,95,1,112,0,12,1,6,
		95,1,121,72,121,72,121,72,112,3,73,36,34,0,
		48,7,0,95,2,106,8,68,101,115,116,114,111,121,
		0,108,16,95,1,121,72,121,72,121,72,112,3,73,
		36,35,0,48,17,0,95,2,108,16,112,1,73,36,
		37,0,122,80,1,36,38,0,48,7,0,95,2,106,
		8,99,104,97,110,103,101,100,0,108,18,95,1,121,
		72,121,72,121,72,112,3,73,36,39,0,48,7,0,
		95,2,106,9,95,99,104,97,110,103,101,100,0,108,
		19,95,1,121,72,121,72,121,72,112,3,73,36,40,
		0,48,7,0,95,2,106,5,103,101,116,115,0,108,
		20,95,1,121,72,121,72,121,72,112,3,73,36,41,
		0,48,7,0,95,2,106,4,103,101,116,0,108,20,
		95,1,121,72,121,72,121,72,112,3,73,36,42,0,
		48,7,0,95,2,106,5,95,115,101,116,0,108,20,
		95,1,121,72,121,72,121,72,112,3,73,36,43,0,
		48,7,0,95,2,106,5,95,112,117,116,0,108,20,
		95,1,121,72,121,72,121,72,112,3,73,36,44,0,
		48,21,0,95,2,112,0,73,167,14,0,0,176,22,
		0,104,1,0,95,2,20,2,168,48,23,0,95,2,
		112,0,80,3,176,24,0,95,3,106,10,73,110,105,
		116,67,108,97,115,115,0,12,2,28,12,48,25,0,
		95,3,164,146,1,0,73,95,3,110,7,48,23,0,
		103,1,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TSTRING_NEW )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,95,
		78,69,87,0,37,1,0,88,86,65,76,85,69,0,
		36,46,0,37,2,0,83,69,76,70,0,102,80,2,
		36,47,0,48,26,0,95,2,95,1,112,1,73,36,
		48,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TSTRING_DESTROY )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,95,
		68,69,83,84,82,79,89,0,36,50,0,37,1,0,
		83,69,76,70,0,102,80,1,36,51,0,100,80,1,
		36,52,0,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TSTRING_SETGET )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,95,
		83,69,84,71,69,84,0,37,1,0,88,86,65,76,
		85,69,0,36,54,0,37,2,0,83,69,76,70,0,
		102,80,2,36,55,0,176,27,0,95,1,12,1,28,
		45,36,56,0,48,28,0,95,2,95,1,112,1,73,
		36,57,0,48,29,0,95,2,48,11,0,95,2,112,
		0,112,1,73,36,58,0,48,30,0,95,2,120,112,
		1,73,36,60,0,48,11,0,95,2,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TSTRING_GETCHANGED )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,95,
		71,69,84,67,72,65,78,71,69,68,0,36,62,0,
		37,1,0,83,69,76,70,0,102,80,1,36,63,0,
		48,31,0,95,1,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TSTRING_SETCHANGED )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,51,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,58,84,83,84,82,73,78,71,95,
		83,69,84,67,72,65,78,71,69,68,0,37,1,0,
		76,67,72,65,78,71,69,68,0,36,65,0,37,2,
		0,83,69,76,70,0,102,80,2,36,66,0,176,32,
		0,95,1,12,1,28,16,36,67,0,48,30,0,95,
		2,95,1,112,1,110,7,36,69,0,9,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,40,0,1,0,116,40,0,51,115,114,99,47,116,
		115,116,114,105,110,103,46,112,114,103,58,40,95,73,
		78,73,84,83,84,65,84,73,67,83,41,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,115,114,99,47,116,115,116,114,105,110,103,46,112,
		114,103,58,40,95,73,78,73,84,76,73,78,69,83,
		41,0,106,16,115,114,99,47,116,115,116,114,105,110,
		103,46,112,114,103,0,92,8,106,9,220,183,255,239,
		223,221,215,46,0,4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

