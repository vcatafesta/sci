/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "achoice.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( ACHOICE );
HB_FUNC( TACHOICENEW );
HB_FUNC_EXTERN( __MVPRIVATE );
HB_FUNC_EXTERN( HB_DEFAULT );
HB_FUNC_EXTERN( MAXCOL );
HB_FUNC_EXTERN( MAXROW );
HB_FUNC_EXTERN( HB_ISARRAY );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( SETCURSOR );
HB_FUNC_EXTERN( COLORSELECT );
HB_FUNC_EXTERN( EMPTY );
HB_FUNC_EXTERN( VALTYPE );
HB_FUNC_EXTERN( HB_ISLOGICAL );
HB_FUNC_EXTERN( ARRAY );
HB_FUNC_EXTERN( AFILL );
HB_FUNC_STATIC( ACH_LIMITS );
HB_FUNC_EXTERN( MIN );
HB_FUNC_EXTERN( MAX );
HB_FUNC_STATIC( DISPPAGE );
HB_FUNC_EXTERN( DO );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_STATIC( ACH_SELECT );
HB_FUNC_STATIC( DISPLINE );
HB_FUNC_EXTERN( DISPBEGIN );
HB_FUNC_EXTERN( HB_SCROLL );
HB_FUNC_EXTERN( DISPEND );
HB_FUNC_EXTERN( SETKEY );
HB_FUNC_EXTERN( PROCNAME );
HB_FUNC_EXTERN( PROCLINE );
HB_FUNC_EXTERN( NEXTKEY );
HB_FUNC_EXTERN( HB_KEYSETLAST );
HB_FUNC_STATIC( HITTEST );
HB_FUNC_EXTERN( MROW );
HB_FUNC_EXTERN( MCOL );
HB_FUNC_EXTERN( HB_KEYINS );
HB_FUNC_EXTERN( UPPER );
HB_FUNC_EXTERN( HB_KEYCHAR );
HB_FUNC( LEFTEQI );
HB_FUNC_EXTERN( HB_ISNUMERIC );
HB_FUNC_EXTERN( HB_DISPOUTAT );
HB_FUNC_EXTERN( SPACE );
HB_FUNC_EXTERN( HB_ISSTRING );
HB_FUNC_EXTERN( PADR );
HB_FUNC_EXTERN( HB_ISEVALITEM );
HB_FUNC_EXTERN( HB_MACROBLOCK );
HB_FUNC_EXTERN( LEFT );
HB_FUNC( TACHOICE );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( TRECEPOSI );
HB_FUNC_STATIC( TACHOICE_NEW );
HB_FUNC_STATIC( TACHOICE_HELLO );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( LETO );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFFPT );
HB_FUNC_EXTERN( SIXCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_MEMIO );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITSTATICS();
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_ACHOICE )
{ "ACHOICE", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( ACHOICE )}, NULL },
{ "OACHOICE", {HB_FS_PUBLIC | HB_FS_MEMVAR}, {NULL}, NULL },
{ "TACHOICENEW", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TACHOICENEW )}, NULL },
{ "__MVPRIVATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( __MVPRIVATE )}, NULL },
{ "HB_DEFAULT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_DEFAULT )}, NULL },
{ "MAXCOL", {HB_FS_PUBLIC}, {HB_FUNCNAME( MAXCOL )}, NULL },
{ "MAXROW", {HB_FS_PUBLIC}, {HB_FUNCNAME( MAXROW )}, NULL },
{ "HB_ISARRAY", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISARRAY )}, NULL },
{ "LEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEN )}, NULL },
{ "SETPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETPOS )}, NULL },
{ "SETCURSOR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETCURSOR )}, NULL },
{ "COLORSELECT", {HB_FS_PUBLIC}, {HB_FUNCNAME( COLORSELECT )}, NULL },
{ "EMPTY", {HB_FS_PUBLIC}, {HB_FUNCNAME( EMPTY )}, NULL },
{ "VALTYPE", {HB_FS_PUBLIC}, {HB_FUNCNAME( VALTYPE )}, NULL },
{ "HB_ISLOGICAL", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISLOGICAL )}, NULL },
{ "ARRAY", {HB_FS_PUBLIC}, {HB_FUNCNAME( ARRAY )}, NULL },
{ "AFILL", {HB_FS_PUBLIC}, {HB_FUNCNAME( AFILL )}, NULL },
{ "ACH_LIMITS", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( ACH_LIMITS )}, NULL },
{ "_CURELEMENTO", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "MIN", {HB_FS_PUBLIC}, {HB_FUNCNAME( MIN )}, NULL },
{ "MAX", {HB_FS_PUBLIC}, {HB_FUNCNAME( MAX )}, NULL },
{ "DISPPAGE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( DISPPAGE )}, NULL },
{ "DO", {HB_FS_PUBLIC}, {HB_FUNCNAME( DO )}, NULL },
{ "INKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( INKEY )}, NULL },
{ "CURELEMENTO", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "ACH_SELECT", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( ACH_SELECT )}, NULL },
{ "DISPLINE", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( DISPLINE )}, NULL },
{ "DISPBEGIN", {HB_FS_PUBLIC}, {HB_FUNCNAME( DISPBEGIN )}, NULL },
{ "HB_SCROLL", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_SCROLL )}, NULL },
{ "DISPEND", {HB_FS_PUBLIC}, {HB_FUNCNAME( DISPEND )}, NULL },
{ "SETKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETKEY )}, NULL },
{ "EVAL", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "PROCNAME", {HB_FS_PUBLIC}, {HB_FUNCNAME( PROCNAME )}, NULL },
{ "PROCLINE", {HB_FS_PUBLIC}, {HB_FUNCNAME( PROCLINE )}, NULL },
{ "NEXTKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( NEXTKEY )}, NULL },
{ "HB_KEYSETLAST", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYSETLAST )}, NULL },
{ "HITTEST", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( HITTEST )}, NULL },
{ "MROW", {HB_FS_PUBLIC}, {HB_FUNCNAME( MROW )}, NULL },
{ "MCOL", {HB_FS_PUBLIC}, {HB_FUNCNAME( MCOL )}, NULL },
{ "HB_KEYINS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYINS )}, NULL },
{ "UPPER", {HB_FS_PUBLIC}, {HB_FUNCNAME( UPPER )}, NULL },
{ "HB_KEYCHAR", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_KEYCHAR )}, NULL },
{ "LEFTEQI", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( LEFTEQI )}, NULL },
{ "HB_ISNUMERIC", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISNUMERIC )}, NULL },
{ "HB_DISPOUTAT", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_DISPOUTAT )}, NULL },
{ "SPACE", {HB_FS_PUBLIC}, {HB_FUNCNAME( SPACE )}, NULL },
{ "HB_ISSTRING", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISSTRING )}, NULL },
{ "PADR", {HB_FS_PUBLIC}, {HB_FUNCNAME( PADR )}, NULL },
{ "HB_ISEVALITEM", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_ISEVALITEM )}, NULL },
{ "HB_MACROBLOCK", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_MACROBLOCK )}, NULL },
{ "LEFT", {HB_FS_PUBLIC}, {HB_FUNCNAME( LEFT )}, NULL },
{ "TACHOICE", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( TACHOICE )}, NULL },
{ "__CLSLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSLOCKDEF )}, NULL },
{ "NEW", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "HBCLASS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HBCLASS )}, NULL },
{ "TRECEPOSI", {HB_FS_PUBLIC}, {HB_FUNCNAME( TRECEPOSI )}, NULL },
{ "ADDMULTIDATA", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "ADDMETHOD", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "TACHOICE_NEW", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TACHOICE_NEW )}, NULL },
{ "TACHOICE_HELLO", {HB_FS_STATIC | HB_FS_LOCAL}, {HB_FUNCNAME( TACHOICE_HELLO )}, NULL },
{ "CREATE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__CLSUNLOCKDEF", {HB_FS_PUBLIC}, {HB_FUNCNAME( __CLSUNLOCKDEF )}, NULL },
{ "INSTANCE", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "__OBJHASMSG", {HB_FS_PUBLIC}, {HB_FUNCNAME( __OBJHASMSG )}, NULL },
{ "INITCLASS", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_CWHO", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "_CNOME", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "CWHO", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "CNOME", {HB_FS_PUBLIC | HB_FS_MESSAGE}, {NULL}, NULL },
{ "LETO", {HB_FS_PUBLIC}, {HB_FUNCNAME( LETO )}, NULL },
{ "DBFNTX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNTX )}, NULL },
{ "DBFCDX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFCDX )}, NULL },
{ "DBFFPT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFFPT )}, NULL },
{ "SIXCDX", {HB_FS_PUBLIC}, {HB_FUNCNAME( SIXCDX )}, NULL },
{ "DBFNSX", {HB_FS_PUBLIC}, {HB_FUNCNAME( DBFNSX )}, NULL },
{ "HB_MEMIO", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_MEMIO )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITSTATICS00001)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITSTATICS}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_ACHOICE, "achoice.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_ACHOICE
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_ACHOICE )
   #include "hbiniseg.h"
#endif

HB_FUNC( ACHOICE )
{
	static const HB_BYTE pcode[] =
	{
		13,19,10,51,97,99,104,111,105,99,101,46,112,114,
		103,58,65,67,72,79,73,67,69,0,37,1,0,78,
		84,79,80,0,37,2,0,78,76,69,70,84,0,37,
		3,0,78,66,79,84,84,79,77,0,37,4,0,78,
		82,73,71,72,84,0,37,5,0,65,67,73,84,69,
		77,83,0,37,6,0,88,83,69,76,69,67,84,0,
		37,7,0,88,85,83,69,82,70,85,78,67,0,37,
		8,0,78,80,79,83,0,37,9,0,78,72,73,76,
		73,84,69,82,79,87,0,37,10,0,76,80,65,71,
		69,67,73,82,67,85,76,65,82,0,36,5,0,37,
		11,0,78,78,85,77,67,79,76,83,0,36,6,0,
		37,12,0,78,78,85,77,82,79,87,83,0,36,7,
		0,37,13,0,78,82,79,87,83,67,76,82,0,36,
		8,0,37,14,0,65,76,83,69,76,69,67,84,0,
		36,9,0,37,15,0,78,78,69,87,80,79,83,0,
		121,80,15,36,10,0,37,16,0,76,70,73,78,73,
		83,72,69,68,0,36,11,0,37,17,0,78,75,69,
		89,0,121,80,17,36,12,0,37,18,0,78,77,79,
		68,69,0,36,13,0,37,19,0,78,65,84,84,79,
		80,0,36,14,0,37,20,0,78,73,84,69,77,83,
		0,121,80,20,36,15,0,37,21,0,78,71,65,80,
		0,36,18,0,37,22,0,76,85,83,69,82,70,85,
		78,67,0,36,19,0,37,23,0,78,85,83,69,82,
		70,85,78,67,0,36,20,0,37,24,0,78,83,65,
		86,69,67,83,82,0,36,21,0,37,25,0,78,70,
		82,83,84,73,84,69,77,0,121,80,25,36,22,0,
		37,26,0,78,76,65,83,84,73,84,69,77,0,121,
		80,26,36,24,0,37,27,0,66,65,67,84,73,79,
		78,0,36,25,0,37,28,0,67,75,69,89,0,36,
		26,0,37,29,0,78,65,85,88,0,36,27,0,95,
		10,100,8,28,5,120,80,10,36,28,0,176,2,0,
		12,0,176,3,0,108,1,20,1,81,1,0,36,34,
		0,176,4,0,96,1,0,121,20,2,36,35,0,176,
		4,0,96,3,0,121,20,2,36,37,0,176,4,0,
		96,2,0,121,20,2,36,38,0,176,4,0,96,4,
		0,121,20,2,36,40,0,95,4,176,5,0,12,0,
		15,28,12,36,41,0,176,5,0,12,0,80,4,36,
		44,0,95,3,176,6,0,12,0,15,28,12,36,45,
		0,176,6,0,12,0,80,3,36,48,0,176,7,0,
		95,5,12,1,28,13,176,8,0,95,5,12,1,121,
		8,28,22,36,49,0,176,9,0,95,1,95,4,122,
		72,20,2,36,50,0,121,110,7,36,53,0,176,10,
		0,121,12,1,80,24,36,54,0,176,11,0,121,20,
		1,36,61,0,176,12,0,95,7,12,1,28,31,176,
		13,0,95,6,12,1,106,4,67,66,83,0,24,28,
		15,36,62,0,95,6,80,7,36,63,0,100,80,6,
		36,66,0,176,12,0,95,7,12,1,68,21,28,17,
		73,176,13,0,95,7,12,1,106,4,67,66,83,0,
		24,80,22,36,68,0,176,7,0,95,6,12,1,31,
		17,176,14,0,95,6,12,1,31,8,36,69,0,120,
		80,6,36,72,0,176,4,0,96,8,0,122,20,2,
		36,73,0,176,4,0,96,9,0,121,20,2,36,75,
		0,95,4,95,2,49,122,72,80,11,36,76,0,95,
		3,95,1,49,122,72,80,12,36,78,0,176,7,0,
		95,6,12,1,28,11,36,79,0,95,6,80,14,25,
		31,36,81,0,176,15,0,176,8,0,95,5,12,1,
		12,1,80,14,36,82,0,176,16,0,95,14,95,6,
		20,2,36,85,0,176,17,0,96,25,0,96,26,0,
		96,20,0,95,14,95,5,12,5,165,80,18,92,4,
		8,28,22,36,86,0,121,80,8,36,87,0,48,18,
		0,109,1,0,95,8,112,1,73,36,91,0,176,19,
		0,176,20,0,95,25,95,8,12,2,95,26,12,2,
		80,8,36,92,0,48,18,0,109,1,0,95,8,112,
		1,73,36,95,0,176,19,0,176,20,0,121,95,9,
		12,2,95,12,122,49,12,2,80,9,36,98,0,176,
		19,0,176,20,0,122,176,20,0,122,95,8,95,9,
		49,12,2,12,2,95,20,12,2,80,19,36,101,0,
		95,19,95,12,72,122,49,95,20,15,28,20,36,102,
		0,176,20,0,122,95,20,95,12,49,122,72,12,2,
		80,19,36,105,0,176,21,0,95,5,95,14,95,1,
		95,2,95,4,95,12,95,8,95,19,95,20,95,20,
		20,10,36,107,0,95,18,92,4,8,80,16,36,108,
		0,95,16,28,25,95,22,28,21,36,109,0,176,22,
		0,95,7,95,18,95,8,95,8,95,19,49,20,4,
		36,112,0,95,16,32,185,19,36,113,0,95,18,92,
		3,69,28,33,95,18,92,4,69,28,26,95,18,92,
		10,69,28,19,36,114,0,176,23,0,121,12,1,80,
		17,36,115,0,121,80,18,36,119,0,95,18,92,10,
		5,29,107,1,36,120,0,48,24,0,109,1,0,112,
		0,80,15,36,121,0,176,25,0,95,14,95,15,12,
		2,31,10,36,122,0,173,15,0,25,236,36,124,0,
		95,15,95,19,16,28,98,95,15,95,19,95,12,72,
		122,49,34,28,86,36,125,0,176,26,0,95,5,95,
		8,1,95,1,95,8,72,95,19,49,95,2,176,25,
		0,95,14,95,8,12,2,9,95,11,95,8,20,7,
		36,126,0,95,15,80,8,36,127,0,176,26,0,95,
		5,95,8,1,95,1,95,8,72,95,19,49,95,2,
		176,25,0,95,14,95,8,12,2,120,95,11,95,8,
		20,7,26,161,16,36,129,0,176,27,0,20,0,36,
		130,0,176,26,0,95,5,95,8,1,95,1,95,8,
		72,95,19,49,95,2,176,25,0,95,14,95,8,12,
		2,9,95,11,95,8,20,7,36,131,0,176,28,0,
		95,1,95,2,95,3,95,4,95,15,95,19,95,12,
		72,122,49,49,20,5,36,132,0,95,15,80,19,36,
		133,0,176,20,0,95,8,95,19,95,12,72,122,49,
		12,2,80,8,36,134,0,95,8,95,15,15,28,63,
		36,135,0,95,1,95,8,72,95,19,49,95,3,34,
		28,39,36,136,0,176,26,0,95,5,95,8,1,95,
		1,95,8,72,95,19,49,95,2,176,25,0,95,14,
		95,8,12,2,9,95,11,95,8,20,7,36,138,0,
		173,8,0,25,187,36,140,0,176,26,0,95,5,95,
		8,1,95,1,95,8,72,95,19,49,95,2,176,25,
		0,95,14,95,8,12,2,120,95,11,95,8,20,7,
		36,141,0,176,29,0,20,0,36,142,0,26,198,15,
		36,144,0,176,30,0,95,17,12,1,165,80,27,100,
		69,29,37,1,36,145,0,48,31,0,95,27,176,32,
		0,122,12,1,176,33,0,122,12,1,106,1,0,112,
		3,73,36,146,0,176,34,0,12,0,121,8,28,19,
		36,147,0,176,35,0,93,255,0,20,1,36,148,0,
		121,80,17,36,151,0,176,19,0,95,12,95,20,12,
		2,80,13,36,152,0,176,17,0,96,25,0,96,26,
		0,96,20,0,95,14,95,5,12,5,165,80,18,92,
		4,8,28,29,36,153,0,121,80,8,36,154,0,176,
		20,0,122,95,8,95,12,49,122,72,12,2,80,19,
		26,137,0,36,156,0,95,8,95,26,35,28,21,176,
		25,0,95,14,95,8,12,2,31,10,36,157,0,174,
		8,0,25,229,36,160,0,95,8,95,26,15,28,23,
		36,161,0,176,19,0,176,20,0,95,25,95,8,12,
		2,95,26,12,2,80,8,36,164,0,176,19,0,95,
		19,95,8,12,2,80,19,36,165,0,95,19,95,12,
		72,122,49,95,20,15,28,32,36,166,0,176,19,0,
		176,20,0,122,95,8,95,12,49,122,72,12,2,95,
		20,95,12,49,122,72,12,2,80,19,36,169,0,95,
		19,122,35,28,8,36,170,0,122,80,19,36,174,0,
		176,21,0,95,5,95,14,95,1,95,2,95,4,95,
		12,95,8,95,19,95,20,95,13,20,10,26,146,14,
		36,176,0,95,17,92,27,8,31,9,95,18,92,4,
		8,28,65,95,22,31,61,36,178,0,95,8,121,69,
		28,31,36,179,0,176,26,0,95,5,95,8,1,95,
		1,95,8,72,95,19,49,95,2,120,9,95,11,95,
		8,20,7,36,182,0,121,80,18,36,183,0,121,80,
		8,36,184,0,120,80,16,26,66,14,36,186,0,95,
		17,93,238,3,8,31,11,95,17,93,234,3,8,29,
		180,0,36,187,0,176,36,0,95,1,95,2,95,3,
		95,4,176,37,0,12,0,176,38,0,12,0,12,6,
		80,29,36,188,0,95,29,121,69,29,8,14,95,19,
		95,29,72,122,49,165,80,15,95,20,34,29,248,13,
		36,189,0,176,25,0,95,14,95,15,12,2,29,233,
		13,36,190,0,176,26,0,95,5,95,8,1,95,1,
		95,8,72,95,19,49,95,2,176,25,0,95,14,95,
		8,12,2,9,95,11,95,8,20,7,36,191,0,95,
		15,80,8,36,192,0,176,26,0,95,5,95,8,1,
		95,1,95,8,72,95,19,49,95,2,176,25,0,95,
		14,95,8,12,2,120,95,11,95,8,20,7,36,193,
		0,95,17,93,238,3,8,28,12,36,194,0,176,39,
		0,92,13,20,1,36,197,0,26,125,13,36,202,0,
		95,17,92,5,8,31,11,95,17,93,246,3,8,29,
		178,1,36,204,0,95,8,122,49,80,15,36,205,0,
		95,15,95,25,35,28,67,36,206,0,95,26,80,8,
		36,207,0,176,20,0,122,95,8,95,12,49,122,72,
		12,2,80,19,36,208,0,95,8,80,15,36,209,0,
		176,21,0,95,5,95,14,95,1,95,2,95,4,95,
		12,95,8,95,19,95,20,20,9,36,210,0,92,2,
		80,18,36,213,0,176,25,0,95,14,95,15,12,2,
		31,10,36,214,0,173,15,0,25,236,36,216,0,95,
		15,95,19,16,28,98,95,15,95,19,95,12,72,122,
		49,34,28,86,36,217,0,176,26,0,95,5,95,8,
		1,95,1,95,8,72,95,19,49,95,2,176,25,0,
		95,14,95,8,12,2,9,95,11,95,8,20,7,36,
		218,0,95,15,80,8,36,219,0,176,26,0,95,5,
		95,8,1,95,1,95,8,72,95,19,49,95,2,176,
		25,0,95,14,95,8,12,2,120,95,11,95,8,20,
		7,26,150,12,36,221,0,176,27,0,20,0,36,222,
		0,176,26,0,95,5,95,8,1,95,1,95,8,72,
		95,19,49,95,2,176,25,0,95,14,95,8,12,2,
		9,95,11,95,8,20,7,36,223,0,176,28,0,95,
		1,95,2,95,3,95,4,95,15,95,19,95,12,72,
		122,49,49,20,5,36,224,0,95,15,80,19,36,225,
		0,176,20,0,95,8,95,19,95,12,72,122,49,12,
		2,80,8,36,226,0,95,8,95,15,15,28,63,36,
		227,0,95,1,95,8,72,95,19,49,95,3,34,28,
		39,36,228,0,176,26,0,95,5,95,8,1,95,1,
		95,8,72,95,19,49,95,2,176,25,0,95,14,95,
		8,12,2,9,95,11,95,8,20,7,36,230,0,173,
		8,0,25,187,36,232,0,176,26,0,95,5,95,8,
		1,95,1,95,8,72,95,19,49,95,2,176,25,0,
		95,14,95,8,12,2,120,95,11,95,8,20,7,36,
		233,0,176,29,0,20,0,36,234,0,26,187,11,36,
		239,0,95,17,92,24,8,31,11,95,17,93,247,3,
		8,29,150,1,36,243,0,95,8,122,72,80,15,36,
		244,0,95,15,95,26,15,28,55,36,245,0,95,25,
		80,8,36,246,0,95,8,80,19,36,247,0,95,8,
		80,15,36,248,0,176,21,0,95,5,95,14,95,1,
		95,2,95,4,95,12,95,8,95,19,95,20,20,9,
		36,249,0,122,80,18,36,252,0,176,25,0,95,14,
		95,15,12,2,31,10,36,253,0,174,15,0,25,236,
		36,0,1,95,15,95,19,16,28,98,95,15,95,19,
		95,12,72,122,49,34,28,86,36,1,1,176,26,0,
		95,5,95,8,1,95,1,95,8,72,95,19,49,95,
		2,176,25,0,95,14,95,8,12,2,9,95,11,95,
		8,20,7,36,2,1,95,15,80,8,36,3,1,176,
		26,0,95,5,95,8,1,95,1,95,8,72,95,19,
		49,95,2,176,25,0,95,14,95,8,12,2,120,95,
		11,95,8,20,7,26,224,10,36,5,1,176,27,0,
		20,0,36,6,1,176,26,0,95,5,95,8,1,95,
		1,95,8,72,95,19,49,95,2,176,25,0,95,14,
		95,8,12,2,9,95,11,95,8,20,7,36,7,1,
		176,28,0,95,1,95,2,95,3,95,4,95,15,95,
		19,95,12,72,122,49,49,20,5,36,8,1,95,15,
		95,12,49,122,72,80,19,36,9,1,176,20,0,95,
		8,95,19,12,2,80,8,36,10,1,95,8,95,15,
		35,28,47,36,11,1,176,26,0,95,5,95,8,1,
		95,1,95,8,72,95,19,49,95,2,176,25,0,95,
		14,95,8,12,2,9,95,11,95,8,20,7,36,12,
		1,174,8,0,25,203,36,14,1,176,26,0,95,5,
		95,8,1,95,1,95,8,72,95,19,49,95,2,176,
		25,0,95,14,95,8,12,2,120,95,11,95,8,20,
		7,36,15,1,176,29,0,20,0,36,16,1,26,21,
		10,36,20,1,95,17,92,31,8,31,14,95,17,122,
		8,29,219,0,95,22,32,214,0,36,22,1,95,8,
		95,25,8,29,157,0,36,23,1,95,10,28,70,36,
		24,1,95,26,80,8,36,25,1,176,20,0,122,95,
		8,95,12,49,122,72,12,2,80,19,36,26,1,95,
		8,80,15,36,27,1,176,21,0,95,5,95,14,95,
		1,95,2,95,4,95,12,95,8,95,19,95,20,20,
		9,36,28,1,92,2,80,18,26,169,9,36,30,1,
		95,19,176,20,0,122,95,8,95,12,49,122,72,12,
		2,8,28,10,36,31,1,122,80,18,25,46,36,33,
		1,176,20,0,122,95,8,95,12,49,122,72,12,2,
		80,19,36,34,1,176,21,0,95,5,95,14,95,1,
		95,2,95,4,95,12,95,8,95,19,95,20,20,9,
		36,36,1,26,90,9,36,38,1,95,25,80,8,36,
		39,1,95,8,80,19,36,40,1,176,21,0,95,5,
		95,14,95,1,95,2,95,4,95,12,95,8,95,19,
		95,20,20,9,36,41,1,26,44,9,36,43,1,95,
		17,92,30,8,31,15,95,17,92,6,8,29,83,1,
		95,22,32,78,1,36,45,1,95,8,95,26,8,29,
		161,0,36,46,1,95,10,28,58,36,47,1,95,25,
		80,8,36,48,1,95,8,80,19,36,49,1,95,8,
		80,15,36,50,1,176,21,0,95,5,95,14,95,1,
		95,2,95,4,95,12,95,8,95,19,95,20,20,9,
		36,51,1,122,80,18,26,203,8,36,53,1,95,19,
		176,19,0,95,26,95,20,176,19,0,95,20,95,12,
		12,2,49,122,72,12,2,8,28,17,36,54,1,122,
		80,18,36,55,1,92,2,80,18,25,47,36,57,1,
		176,19,0,95,26,95,20,95,12,49,122,72,12,2,
		80,19,36,58,1,176,21,0,95,5,95,14,95,1,
		95,2,95,4,95,12,95,8,95,19,95,20,20,9,
		36,60,1,26,108,8,36,62,1,95,26,95,19,16,
		28,97,95,26,95,19,95,12,72,122,49,34,28,85,
		36,63,1,176,26,0,95,5,95,8,1,95,1,95,
		8,72,95,19,49,95,2,176,25,0,95,14,95,8,
		12,2,9,95,11,95,8,20,7,36,64,1,95,26,
		80,8,36,65,1,176,26,0,95,5,95,8,1,95,
		1,95,8,72,95,19,49,95,2,176,25,0,95,14,
		95,8,12,2,120,95,11,95,8,20,7,25,53,36,
		67,1,95,26,80,8,36,68,1,176,20,0,122,95,
		8,95,12,49,122,72,12,2,80,19,36,69,1,176,
		21,0,95,5,95,14,95,1,95,2,95,4,95,12,
		95,8,95,19,95,20,20,9,36,71,1,26,202,7,
		36,73,1,95,17,92,29,8,29,219,0,36,75,1,
		95,8,95,25,8,28,82,36,76,1,95,19,176,20,
		0,122,95,8,95,12,49,122,72,12,2,8,28,11,
		36,77,1,122,80,18,26,151,7,36,79,1,176,20,
		0,122,95,8,95,12,49,122,72,12,2,80,19,36,
		80,1,176,21,0,95,5,95,14,95,1,95,2,95,
		4,95,12,95,8,95,19,95,20,20,9,36,81,1,
		26,101,7,36,83,1,95,19,80,15,36,84,1,176,
		25,0,95,14,95,15,12,2,31,10,36,85,1,174,
		15,0,25,236,36,87,1,95,15,95,8,69,28,83,
		36,88,1,176,26,0,95,5,95,8,1,95,1,95,
		8,72,95,19,49,95,2,176,25,0,95,14,95,8,
		12,2,9,95,11,95,8,20,7,36,89,1,95,15,
		80,8,36,90,1,176,26,0,95,5,95,8,1,95,
		1,95,8,72,95,19,49,95,2,176,25,0,95,14,
		95,8,12,2,120,95,11,95,8,20,7,36,92,1,
		26,231,6,36,94,1,95,17,92,23,8,29,248,0,
		36,96,1,95,8,95,26,8,28,99,36,97,1,95,
		19,176,19,0,95,8,95,20,176,19,0,95,20,95,
		12,12,2,49,122,72,12,2,8,31,9,95,8,95,
		20,8,28,12,36,98,1,92,2,80,18,26,164,6,
		36,100,1,176,19,0,95,8,95,20,95,12,49,122,
		72,12,2,80,19,36,101,1,176,21,0,95,5,95,
		14,95,1,95,2,95,4,95,12,95,8,95,19,95,
		20,20,9,36,102,1,26,113,6,36,104,1,176,19,
		0,95,19,95,12,72,122,49,95,20,12,2,80,15,
		36,105,1,176,25,0,95,14,95,15,12,2,31,10,
		36,106,1,173,15,0,25,236,36,108,1,95,15,95,
		8,69,28,83,36,109,1,176,26,0,95,5,95,8,
		1,95,1,95,8,72,95,19,49,95,2,176,25,0,
		95,14,95,8,12,2,9,95,11,95,8,20,7,36,
		110,1,95,15,80,8,36,111,1,176,26,0,95,5,
		95,8,1,95,1,95,8,72,95,19,49,95,2,176,
		25,0,95,14,95,8,12,2,120,95,11,95,8,20,
		7,36,113,1,26,231,5,36,115,1,95,17,92,18,
		8,29,138,1,36,117,1,95,8,95,25,8,29,155,
		0,36,118,1,95,10,28,70,36,119,1,95,26,80,
		8,36,120,1,176,20,0,122,95,8,95,12,49,122,
		72,12,2,80,19,36,121,1,95,8,80,15,36,122,
		1,176,21,0,95,5,95,14,95,1,95,2,95,4,
		95,12,95,8,95,19,95,20,20,9,36,123,1,92,
		2,80,18,26,134,5,36,125,1,122,80,18,36,126,
		1,95,19,176,20,0,122,95,8,95,12,49,122,72,
		12,2,15,28,46,36,127,1,176,20,0,122,95,8,
		95,12,49,122,72,12,2,80,19,36,128,1,176,21,
		0,95,5,95,14,95,1,95,2,95,4,95,12,95,
		8,95,19,95,20,20,9,36,130,1,26,57,5,36,
		132,1,95,25,95,19,16,28,42,95,25,95,19,95,
		12,72,122,49,34,28,30,36,134,1,95,25,80,8,
		36,135,1,176,20,0,95,8,95,12,49,122,72,122,
		12,2,80,19,26,149,0,36,137,1,95,8,95,12,
		49,122,72,95,25,35,28,18,36,138,1,95,25,80,
		8,36,139,1,95,25,80,19,25,117,36,141,1,176,
		20,0,95,25,95,8,95,12,49,122,72,12,2,80,
		8,36,142,1,176,20,0,122,95,19,95,12,49,122,
		72,12,2,80,19,36,143,1,95,8,95,25,15,28,
		27,176,25,0,95,14,95,8,12,2,31,16,36,144,
		1,173,8,0,36,145,1,173,19,0,25,223,36,147,
		1,176,20,0,122,95,19,12,2,80,19,36,148,1,
		95,19,95,12,35,28,22,95,8,95,12,35,28,15,
		36,149,1,95,12,80,8,36,150,1,122,80,19,36,
		154,1,176,21,0,95,5,95,14,95,1,95,2,95,
		4,95,12,95,8,95,19,95,20,20,9,36,155,1,
		26,85,4,36,157,1,95,17,92,3,8,29,182,1,
		36,159,1,95,8,95,26,8,29,146,0,36,160,1,
		95,10,28,58,36,161,1,95,25,80,8,36,162,1,
		95,8,80,19,36,163,1,95,8,80,15,36,164,1,
		176,21,0,95,5,95,14,95,1,95,2,95,4,95,
		12,95,8,95,19,95,20,20,9,36,165,1,122,80,
		18,26,0,4,36,167,1,92,2,80,18,36,168,1,
		95,19,176,19,0,95,8,95,20,95,12,49,122,72,
		12,2,35,28,47,36,169,1,176,19,0,95,8,95,
		20,95,12,49,122,72,12,2,80,19,36,170,1,176,
		21,0,95,5,95,14,95,1,95,2,95,4,95,12,
		95,8,95,19,95,20,20,9,36,172,1,26,176,3,
		36,174,1,95,26,95,19,16,28,98,95,26,95,19,
		95,12,72,122,49,34,28,86,36,176,1,176,26,0,
		95,5,95,8,1,95,1,95,8,72,95,19,49,95,
		2,176,25,0,95,14,95,8,12,2,9,95,11,95,
		8,20,7,36,177,1,95,26,80,8,36,178,1,176,
		26,0,95,5,95,8,1,95,1,95,8,72,95,19,
		49,95,2,176,25,0,95,14,95,8,12,2,120,95,
		11,95,8,20,7,26,172,0,36,180,1,95,8,95,
		19,49,80,21,36,181,1,176,19,0,95,26,95,8,
		95,12,72,122,49,12,2,80,8,36,182,1,95,8,
		95,12,72,122,49,95,26,15,28,33,36,184,1,95,
		26,95,12,49,122,72,80,19,36,185,1,176,19,0,
		95,26,95,19,95,21,72,12,2,80,8,25,12,36,
		188,1,95,8,95,21,49,80,19,36,191,1,95,8,
		95,26,35,28,27,176,25,0,95,14,95,8,12,2,
		31,16,36,192,1,174,8,0,36,193,1,174,19,0,
		25,223,36,196,1,95,19,95,12,72,122,49,95,20,
		15,28,10,36,197,1,173,19,0,25,235,36,199,1,
		176,21,0,95,5,95,14,95,1,95,2,95,4,95,
		12,95,8,95,19,95,20,20,9,36,201,1,26,151,
		2,36,203,1,95,17,92,13,8,28,59,95,22,31,
		55,36,205,1,95,8,121,69,28,31,36,206,1,176,
		26,0,95,5,95,8,1,95,1,95,8,72,95,19,
		49,95,2,120,9,95,11,95,8,20,7,36,209,1,
		121,80,18,36,210,1,120,80,16,26,84,2,36,212,
		1,95,17,92,4,8,28,59,95,22,31,55,36,214,
		1,95,8,121,69,28,31,36,215,1,176,26,0,95,
		5,95,8,1,95,1,95,8,72,95,19,49,95,2,
		120,9,95,11,95,8,20,7,36,218,1,121,80,8,
		36,219,1,120,80,16,26,17,2,36,221,1,95,17,
		92,19,8,28,59,95,22,31,55,36,223,1,95,8,
		121,69,28,31,36,224,1,176,26,0,95,5,95,8,
		1,95,1,95,8,72,95,19,49,95,2,120,9,95,
		11,95,8,20,7,36,227,1,121,80,8,36,228,1,
		120,80,16,26,206,1,36,231,1,95,22,28,10,95,
		18,92,3,8,29,65,1,176,40,0,176,41,0,95,
		17,12,1,12,1,165,80,28,106,1,0,8,32,43,
		1,36,234,1,95,8,122,72,165,80,15,25,36,36,
		235,1,176,25,0,95,14,95,15,12,2,28,16,176,
		42,0,95,5,95,15,1,95,28,12,2,31,13,36,
		234,1,175,15,0,95,20,15,28,219,36,239,1,95,
		15,95,20,122,72,8,28,52,36,240,1,122,165,80,
		15,25,36,36,241,1,176,25,0,95,14,95,15,12,
		2,28,16,176,42,0,95,5,95,15,1,95,28,12,
		2,31,15,36,240,1,175,15,0,95,8,122,49,15,
		28,217,36,247,1,95,15,95,8,69,29,166,0,36,
		248,1,95,15,95,19,16,28,97,95,15,95,19,95,
		12,72,122,49,34,28,85,36,250,1,176,26,0,95,
		5,95,8,1,95,1,95,8,72,95,19,49,95,2,
		176,25,0,95,14,95,8,12,2,9,95,11,95,8,
		20,7,36,251,1,95,15,80,8,36,252,1,176,26,
		0,95,5,95,8,1,95,1,95,8,72,95,19,49,
		95,2,176,25,0,95,14,95,8,12,2,120,95,11,
		95,8,20,7,25,60,36,255,1,95,15,80,8,36,
		0,2,176,19,0,176,20,0,122,95,8,95,12,49,
		122,72,12,2,95,20,12,2,80,19,36,1,2,176,
		21,0,95,5,95,14,95,1,95,2,95,4,95,12,
		95,8,95,19,95,20,20,9,36,5,2,121,80,18,
		26,129,0,36,7,2,95,18,92,3,8,28,23,36,
		8,2,48,24,0,109,1,0,112,0,80,8,36,10,
		2,121,80,18,25,97,36,12,2,95,18,92,10,8,
		28,61,36,13,2,48,24,0,109,1,0,112,0,80,
		8,36,14,2,95,8,121,69,28,31,36,15,2,176,
		26,0,95,5,95,8,1,95,1,95,8,72,95,19,
		49,95,2,120,9,95,11,95,8,20,7,36,17,2,
		121,80,18,25,28,36,19,2,95,18,92,4,69,28,
		18,36,20,2,95,17,121,8,28,5,121,25,4,92,
		3,80,18,36,24,2,95,22,29,148,238,36,25,2,
		176,43,0,176,22,0,95,7,95,18,95,8,95,8,
		95,19,49,12,4,165,80,23,12,1,29,252,1,36,
		27,2,26,212,0,36,29,2,120,80,16,36,30,2,
		121,80,8,36,31,2,26,244,0,36,34,2,48,24,
		0,109,1,0,112,0,80,8,36,35,2,95,8,121,
		69,28,31,36,36,2,176,26,0,95,5,95,8,1,
		95,1,95,8,72,95,19,49,95,2,120,9,95,11,
		95,8,20,7,36,38,2,9,80,16,36,39,2,26,
		31,238,36,42,2,95,8,121,69,28,31,36,43,2,
		176,26,0,95,5,95,8,1,95,1,95,8,72,95,
		19,49,95,2,120,9,95,11,95,8,20,7,36,45,
		2,120,80,16,36,46,2,121,80,8,36,47,2,26,
		125,0,36,49,2,95,8,121,69,28,31,36,50,2,
		176,26,0,95,5,95,8,1,95,1,95,8,72,95,
		19,49,95,2,120,9,95,11,95,8,20,7,36,52,
		2,120,80,16,36,53,2,25,75,36,56,2,121,80,
		18,36,57,2,25,64,36,61,2,92,3,80,18,36,
		62,2,25,52,95,23,133,6,0,97,0,0,0,0,
		26,37,255,97,10,0,0,0,26,47,255,97,4,0,
		0,0,26,102,255,97,1,0,0,0,25,150,97,2,
		0,0,0,25,192,97,3,0,0,0,25,196,36,65,
		2,95,8,121,15,29,27,1,95,18,92,3,69,29,
		19,1,36,73,2,176,17,0,96,25,0,96,26,0,
		96,20,0,95,14,95,5,12,5,165,80,18,92,4,
		8,28,29,36,74,2,121,80,8,36,75,2,176,20,
		0,122,95,8,95,12,49,122,72,12,2,80,19,26,
		137,0,36,77,2,95,8,95,26,35,28,21,176,25,
		0,95,14,95,8,12,2,31,10,36,78,2,174,8,
		0,25,229,36,81,2,95,8,95,26,15,28,23,36,
		82,2,176,19,0,176,20,0,95,25,95,8,12,2,
		95,26,12,2,80,8,36,85,2,176,19,0,95,19,
		95,8,12,2,80,19,36,87,2,95,19,95,12,72,
		122,49,95,20,15,28,32,36,88,2,176,19,0,176,
		20,0,122,95,8,95,12,49,122,72,12,2,95,20,
		95,12,49,122,72,12,2,80,19,36,91,2,95,19,
		122,35,28,8,36,92,2,122,80,19,36,96,2,176,
		21,0,95,5,95,14,95,1,95,2,95,4,95,12,
		95,8,95,19,95,20,20,9,36,97,2,26,125,236,
		36,99,2,95,8,121,69,28,31,36,100,2,176,26,
		0,95,5,95,8,1,95,1,95,8,72,95,19,49,
		95,2,120,9,95,11,95,8,20,7,36,102,2,121,
		80,8,36,103,2,120,80,16,36,105,2,26,69,236,
		36,107,2,176,10,0,95,24,20,1,36,108,2,95,
		8,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( HITTEST )
{
	static const HB_BYTE pcode[] =
	{
		13,0,6,51,97,99,104,111,105,99,101,46,112,114,
		103,58,72,73,84,84,69,83,84,0,37,1,0,78,
		84,79,80,0,37,2,0,78,76,69,70,84,0,37,
		3,0,78,66,79,84,84,79,77,0,37,4,0,78,
		82,73,71,72,84,0,37,5,0,77,82,79,87,0,
		37,6,0,77,67,79,76,0,36,115,2,95,6,95,
		2,16,28,35,95,6,95,4,34,28,28,95,5,95,
		1,16,28,21,95,5,95,3,34,28,14,36,116,2,
		95,5,95,1,49,122,72,110,7,36,119,2,121,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( DISPPAGE )
{
	static const HB_BYTE pcode[] =
	{
		13,3,10,51,97,99,104,111,105,99,101,46,112,114,
		103,58,68,73,83,80,80,65,71,69,0,37,1,0,
		65,67,73,84,69,77,83,0,37,2,0,65,76,83,
		69,76,69,67,84,0,37,3,0,78,84,79,80,0,
		37,4,0,78,76,69,70,84,0,37,5,0,78,82,
		73,71,72,84,0,37,6,0,78,78,85,77,82,79,
		87,83,0,37,7,0,78,80,79,83,0,37,8,0,
		78,65,84,84,79,80,0,37,9,0,78,65,82,82,
		76,69,78,0,37,10,0,78,82,79,87,83,67,76,
		82,0,36,123,2,37,11,0,78,67,78,84,82,0,
		36,124,2,37,12,0,78,82,79,87,0,36,125,2,
		37,13,0,78,73,78,68,69,88,0,36,127,2,176,
		4,0,96,10,0,95,9,20,2,36,129,2,176,27,
		0,20,0,36,130,2,122,165,80,11,25,123,36,132,
		2,95,3,95,11,72,122,49,80,12,36,133,2,95,
		11,95,8,72,122,49,80,13,36,135,2,95,13,122,
		16,28,51,95,13,95,9,34,28,44,36,136,2,176,
		26,0,95,1,95,13,1,95,12,95,4,176,25,0,
		95,2,95,13,12,2,95,13,95,7,8,95,5,95,
		4,49,122,72,95,13,20,7,25,35,36,138,2,176,
		11,0,121,20,1,36,139,2,176,44,0,95,12,95,
		4,176,45,0,95,5,95,4,49,122,72,12,1,20,
		3,36,130,2,175,11,0,176,19,0,95,6,95,10,
		12,2,15,29,125,255,36,142,2,176,29,0,20,0,
		36,144,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( DISPLINE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,7,51,97,99,104,111,105,99,101,46,112,114,
		103,58,68,73,83,80,76,73,78,69,0,37,1,0,
		67,76,73,78,69,0,37,2,0,78,82,79,87,0,
		37,3,0,78,67,79,76,0,37,4,0,76,83,69,
		76,69,67,84,0,37,5,0,76,72,73,76,73,84,
		69,0,37,6,0,78,78,85,77,67,79,76,83,0,
		37,7,0,78,67,85,82,69,76,69,77,69,78,84,
		79,0,36,149,2,176,11,0,95,4,28,21,176,46,
		0,95,1,12,1,28,12,95,5,28,5,122,25,7,
		121,25,4,92,4,20,1,36,150,2,176,44,0,95,
		2,95,3,176,46,0,95,1,12,1,28,13,176,47,
		0,95,1,95,6,12,2,25,9,176,45,0,95,6,
		12,1,20,3,36,151,2,95,5,28,14,36,152,2,
		176,9,0,95,2,95,3,20,2,36,154,2,176,11,
		0,121,20,1,36,155,2,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( ACH_LIMITS )
{
	static const HB_BYTE pcode[] =
	{
		13,1,5,51,97,99,104,111,105,99,101,46,112,114,
		103,58,65,67,72,95,76,73,77,73,84,83,0,37,
		1,0,78,70,82,83,84,73,84,69,77,0,37,2,
		0,78,76,65,83,84,73,84,69,77,0,37,3,0,
		78,73,84,69,77,83,0,37,4,0,65,76,83,69,
		76,69,67,84,0,37,5,0,65,67,73,84,69,77,
		83,0,36,159,2,37,6,0,78,67,78,84,82,0,
		36,161,2,121,165,80,3,165,80,2,80,1,36,163,
		2,122,165,80,6,25,85,36,164,2,176,46,0,95,
		5,95,6,1,12,1,28,80,176,8,0,95,5,95,
		6,1,12,1,121,15,28,66,36,165,2,174,3,0,
		36,166,2,176,25,0,95,4,95,6,12,2,28,30,
		36,167,2,95,1,121,8,28,14,36,168,2,95,6,
		165,80,2,80,1,25,9,36,170,2,95,3,80,2,
		36,163,2,175,6,0,176,8,0,95,5,12,1,15,
		28,165,36,178,2,95,1,121,8,28,16,36,179,2,
		95,3,80,2,36,180,2,92,4,110,7,36,183,2,
		121,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( ACH_SELECT )
{
	static const HB_BYTE pcode[] =
	{
		13,1,2,51,97,99,104,111,105,99,101,46,112,114,
		103,58,65,67,72,95,83,69,76,69,67,84,0,37,
		1,0,65,76,83,69,76,69,67,84,0,37,2,0,
		78,80,79,83,0,36,187,2,37,3,0,83,69,76,
		0,36,189,2,95,2,122,16,28,107,95,2,176,8,
		0,95,1,12,1,34,28,95,36,190,2,95,1,95,
		2,1,80,3,36,191,2,176,48,0,95,3,12,1,
		28,16,36,192,2,48,31,0,95,3,112,0,80,3,
		25,40,36,193,2,176,46,0,95,3,12,1,28,28,
		176,12,0,95,3,12,1,31,19,36,194,2,48,31,
		0,176,49,0,95,3,12,1,112,0,80,3,36,196,
		2,176,14,0,95,3,12,1,28,9,36,197,2,95,
		3,110,7,36,201,2,120,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( LEFTEQI )
{
	static const HB_BYTE pcode[] =
	{
		13,1,2,51,97,99,104,111,105,99,101,46,112,114,
		103,58,76,69,70,84,69,81,73,0,37,1,0,83,
		84,82,73,78,71,0,37,2,0,67,75,69,89,0,
		36,204,2,37,3,0,78,76,69,78,0,176,8,0,
		95,2,12,1,80,3,36,205,2,176,50,0,95,1,
		95,3,12,2,95,2,8,28,5,120,25,3,9,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TACHOICE )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,78,0,51,97,99,104,111,105,99,101,
		46,112,114,103,58,84,65,67,72,79,73,67,69,0,
		36,208,2,118,0,1,0,83,95,79,67,76,65,83,
		83,0,36,208,2,37,1,0,78,83,67,79,80,69,
		0,37,2,0,79,67,76,65,83,83,0,37,3,0,
		79,73,78,83,84,65,78,67,69,0,103,1,0,100,
		8,29,186,1,176,52,0,104,1,0,12,1,29,175,
		1,166,113,1,0,122,80,1,48,53,0,176,54,0,
		12,0,106,9,84,65,99,104,111,105,99,101,0,108,
		55,4,1,0,108,51,112,3,80,2,36,209,2,48,
		56,0,95,2,100,100,95,1,121,72,121,72,121,72,
		106,5,99,87,104,111,0,4,1,0,9,112,5,73,
		36,210,2,48,56,0,95,2,100,100,95,1,121,72,
		121,72,121,72,106,6,99,78,111,109,101,0,4,1,
		0,9,112,5,73,36,211,2,48,56,0,95,2,100,
		4,0,0,95,1,121,72,121,72,121,72,106,9,97,
		68,101,102,97,117,108,116,0,4,1,0,9,112,5,
		73,36,212,2,48,56,0,95,2,100,122,95,1,121,
		72,121,72,121,72,106,12,67,117,114,69,108,101,109,
		101,110,116,111,0,4,1,0,9,112,5,73,36,213,
		2,48,56,0,95,2,100,4,0,0,95,1,121,72,
		121,72,121,72,106,12,67,111,108,111,114,95,112,70,
		111,114,101,0,4,1,0,9,112,5,73,36,214,2,
		48,56,0,95,2,100,4,0,0,95,1,121,72,121,
		72,121,72,106,12,67,111,108,111,114,95,112,66,97,
		99,107,0,4,1,0,9,112,5,73,36,215,2,48,
		56,0,95,2,100,4,0,0,95,1,121,72,121,72,
		121,72,106,11,67,111,108,111,114,95,112,85,110,115,
		0,4,1,0,9,112,5,73,36,216,2,48,57,0,
		95,2,106,4,78,101,119,0,108,58,95,1,92,8,
		72,121,72,121,72,112,3,73,36,217,2,48,57,0,
		95,2,106,6,72,101,108,108,111,0,108,59,95,1,
		121,72,121,72,121,72,112,3,73,36,218,2,48,60,
		0,95,2,112,0,73,167,14,0,0,176,61,0,104,
		1,0,95,2,20,2,168,48,62,0,95,2,112,0,
		80,3,176,63,0,95,3,106,10,73,110,105,116,67,
		108,97,115,115,0,12,2,28,12,48,64,0,95,3,
		164,146,1,0,73,95,3,110,7,48,62,0,103,1,
		0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TACHOICE_NEW )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,97,99,104,111,105,99,101,46,112,114,
		103,58,84,65,67,72,79,73,67,69,95,78,69,87,
		0,36,220,2,37,1,0,83,69,76,70,0,102,80,
		1,36,221,2,48,65,0,95,1,106,10,84,84,65,
		99,104,111,105,99,101,0,112,1,73,36,222,2,48,
		66,0,95,1,176,32,0,12,0,112,1,73,36,223,
		2,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TACHOICE_HELLO )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,97,99,104,111,105,99,101,46,112,114,
		103,58,84,65,67,72,79,73,67,69,95,72,69,76,
		76,79,0,36,225,2,37,1,0,83,69,76,70,0,
		102,80,1,36,226,2,176,67,0,106,6,72,101,108,
		108,111,0,48,68,0,95,1,112,0,20,2,36,227,
		2,176,67,0,106,6,72,101,108,108,111,0,48,69,
		0,95,1,112,0,20,2,36,228,2,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TACHOICENEW )
{
	static const HB_BYTE pcode[] =
	{
		51,97,99,104,111,105,99,101,46,112,114,103,58,84,
		65,67,72,79,73,67,69,78,69,87,0,36,231,2,
		48,53,0,176,51,0,12,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,78,0,1,0,116,78,0,51,97,99,104,111,105,
		99,101,46,112,114,103,58,40,95,73,78,73,84,83,
		84,65,84,73,67,83,41,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,97,99,104,111,105,99,101,46,112,114,103,58,40,
		95,73,78,73,84,76,73,78,69,83,41,0,106,12,
		97,99,104,111,105,99,101,46,112,114,103,0,121,106,
		94,224,255,124,31,108,51,103,224,52,219,230,152,100,
		58,143,247,254,117,159,55,115,70,205,253,39,244,103,
		239,95,135,248,51,239,223,209,223,214,235,239,214,187,
		186,187,87,119,247,234,239,213,238,123,172,191,87,119,
		147,179,106,214,172,153,140,131,157,163,245,26,235,220,
		236,54,99,2,110,166,25,219,26,152,184,182,77,225,
		141,250,5,156,232,55,50,255,247,158,0,4,3,0,
		4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}
