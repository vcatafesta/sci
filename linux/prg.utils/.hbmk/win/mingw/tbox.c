/* C source generated by Harbour */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( TBOX );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_STATIC( TBOX_NEW );
HB_FUNC_STATIC( TBOX_SHOW );
HB_FUNC_STATIC( TBOX_HIDE );
HB_FUNC_STATIC( TBOX_UP );
HB_FUNC_STATIC( TBOX_DOWN );
HB_FUNC_STATIC( TBOX_RIGHT );
HB_FUNC_STATIC( TBOX_PAGEUP );
HB_FUNC_STATIC( TBOX_PAGEDOWN );
HB_FUNC_STATIC( TBOX_MOVE );
HB_FUNC_STATIC( TBOX_MOVEGET );
HB_FUNC_STATIC( TBOX_INKEYMBOX );
HB_FUNC_STATIC( TBOX_LEFTMBOX );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( LEN );
HB_FUNC_EXTERN( RESTELA );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_EXTERN( LASTKEY );
HB_FUNC_EXTERN( SAVESCREEN );
HB_FUNC_EXTERN( DISPBEGIN );
HB_FUNC_EXTERN( MAXCOL );
HB_FUNC_EXTERN( COLORSET );
HB_FUNC_EXTERN( MS_BOX );
HB_FUNC_EXTERN( APRINT );
HB_FUNC_EXTERN( ROLOC );
HB_FUNC_EXTERN( PADC );
HB_FUNC_EXTERN( CSETCOLOR );
HB_FUNC_EXTERN( SETCOLOR );
HB_FUNC_EXTERN( NSETCOLOR );
HB_FUNC_EXTERN( DISPEND );
HB_FUNC( TBOXNEW );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFFPT );
HB_FUNC_EXTERN( SIXCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_MEMIO );
HB_FUNC_INITSTATICS();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TBOX )
{ "TBOX", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX ) }, NULL },
{ "__CLSLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSLOCKDEF ) }, NULL },
{ "NEW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "HBCLASS", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBCLASS ) }, NULL },
{ "HBOBJECT", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBOBJECT ) }, NULL },
{ "ADDMULTIDATA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ADDMETHOD", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TBOX_NEW", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_NEW ) }, NULL },
{ "TBOX_SHOW", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_SHOW ) }, NULL },
{ "TBOX_HIDE", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_HIDE ) }, NULL },
{ "TBOX_UP", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_UP ) }, NULL },
{ "TBOX_DOWN", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_DOWN ) }, NULL },
{ "TBOX_RIGHT", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_RIGHT ) }, NULL },
{ "TBOX_PAGEUP", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_PAGEUP ) }, NULL },
{ "TBOX_PAGEDOWN", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_PAGEDOWN ) }, NULL },
{ "TBOX_MOVE", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_MOVE ) }, NULL },
{ "TBOX_MOVEGET", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_MOVEGET ) }, NULL },
{ "TBOX_INKEYMBOX", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_INKEYMBOX ) }, NULL },
{ "TBOX_LEFTMBOX", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOX_LEFTMBOX ) }, NULL },
{ "CREATE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__CLSUNLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSUNLOCKDEF ) }, NULL },
{ "INSTANCE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__OBJHASMSG", { HB_FS_PUBLIC }, { HB_FUNCNAME( __OBJHASMSG ) }, NULL },
{ "INITCLASS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_CIMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_ESQUERDA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_BAIXO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_DIREITA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_COR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_CABECALHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_RODAPE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_FRAME", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "LEN", { HB_FS_PUBLIC }, { HB_FUNCNAME( LEN ) }, NULL },
{ "CIMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ESQUERDA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "HIDE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "SHOW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "MOVEGET", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_ROW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ROW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_COL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "COL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "RESTELA", { HB_FS_PUBLIC }, { HB_FUNCNAME( RESTELA ) }, NULL },
{ "CSCREEN", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "INKEY", { HB_FS_PUBLIC }, { HB_FUNCNAME( INKEY ) }, NULL },
{ "LASTKEY", { HB_FS_PUBLIC }, { HB_FUNCNAME( LASTKEY ) }, NULL },
{ "UP", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "BAIXO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "PAINT", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_CSCREEN", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "SAVESCREEN", { HB_FS_PUBLIC }, { HB_FUNCNAME( SAVESCREEN ) }, NULL },
{ "DIREITA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "COR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "CABECALHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "RODAPE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "DISPBEGIN", { HB_FS_PUBLIC }, { HB_FUNCNAME( DISPBEGIN ) }, NULL },
{ "MAXCOL", { HB_FS_PUBLIC }, { HB_FUNCNAME( MAXCOL ) }, NULL },
{ "COLORSET", { HB_FS_PUBLIC }, { HB_FUNCNAME( COLORSET ) }, NULL },
{ "MS_BOX", { HB_FS_PUBLIC }, { HB_FUNCNAME( MS_BOX ) }, NULL },
{ "FRAME", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "SUPER", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "APRINT", { HB_FS_PUBLIC }, { HB_FUNCNAME( APRINT ) }, NULL },
{ "ROLOC", { HB_FS_PUBLIC }, { HB_FUNCNAME( ROLOC ) }, NULL },
{ "PADC", { HB_FS_PUBLIC }, { HB_FUNCNAME( PADC ) }, NULL },
{ "CSETCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( CSETCOLOR ) }, NULL },
{ "SETCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETCOLOR ) }, NULL },
{ "NSETCOLOR", { HB_FS_PUBLIC }, { HB_FUNCNAME( NSETCOLOR ) }, NULL },
{ "DISPEND", { HB_FS_PUBLIC }, { HB_FUNCNAME( DISPEND ) }, NULL },
{ "TBOXNEW", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( TBOXNEW ) }, NULL },
{ "DBFNTX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNTX ) }, NULL },
{ "DBFCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFCDX ) }, NULL },
{ "DBFFPT", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFFPT ) }, NULL },
{ "SIXCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( SIXCDX ) }, NULL },
{ "DBFNSX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNSX ) }, NULL },
{ "HB_MEMIO", { HB_FS_PUBLIC }, { HB_FUNCNAME( HB_MEMIO ) }, NULL },
{ "(_INITSTATICS00001)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITSTATICS }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TBOX, "", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TBOX
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TBOX )
   #include "hbiniseg.h"
#endif

HB_FUNC( TBOX )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,75,0,36,3,0,103,1,0,100,8,29,16,3,176,1,
		0,104,1,0,12,1,29,5,3,166,199,2,0,122,80,1,48,2,0,
		176,3,0,12,0,106,5,84,66,111,120,0,108,4,4,1,0,108,0,
		112,3,80,2,36,4,0,122,80,1,36,5,0,48,5,0,95,2,100,
		100,95,1,121,72,121,72,121,72,106,5,67,105,109,97,0,4,1,0,
		9,112,5,73,36,6,0,48,5,0,95,2,100,100,95,1,121,72,121,
		72,121,72,106,9,69,115,113,117,101,114,100,97,0,4,1,0,9,112,
		5,73,36,7,0,48,5,0,95,2,100,100,95,1,121,72,121,72,121,
		72,106,6,66,97,105,120,111,0,4,1,0,9,112,5,73,36,8,0,
		48,5,0,95,2,100,100,95,1,121,72,121,72,121,72,106,8,68,105,
		114,101,105,116,97,0,4,1,0,9,112,5,73,36,9,0,48,5,0,
		95,2,100,100,95,1,121,72,121,72,121,72,106,8,99,83,99,114,101,
		101,110,0,4,1,0,9,112,5,73,36,10,0,48,5,0,95,2,100,
		100,95,1,121,72,121,72,121,72,106,10,67,97,98,101,99,97,108,104,
		111,0,4,1,0,9,112,5,73,36,11,0,48,5,0,95,2,100,100,
		95,1,121,72,121,72,121,72,106,7,82,111,100,97,112,101,0,4,1,
		0,9,112,5,73,36,12,0,48,5,0,95,2,100,100,95,1,121,72,
		121,72,121,72,106,4,67,111,114,0,4,1,0,9,112,5,73,36,13,
		0,48,5,0,95,2,100,100,95,1,121,72,121,72,121,72,106,6,70,
		114,97,109,101,0,4,1,0,9,112,5,73,36,15,0,122,80,1,36,
		16,0,48,6,0,95,2,106,4,78,101,119,0,108,7,95,1,92,8,
		72,121,72,121,72,112,3,73,36,17,0,48,6,0,95,2,106,5,83,
		104,111,119,0,108,8,95,1,121,72,121,72,121,72,112,3,73,36,18,
		0,48,6,0,95,2,106,5,72,105,100,101,0,108,9,95,1,121,72,
		121,72,121,72,112,3,73,36,19,0,48,6,0,95,2,106,3,85,112,
		0,108,10,95,1,121,72,121,72,121,72,112,3,73,36,20,0,48,6,
		0,95,2,106,5,68,111,119,110,0,108,11,95,1,121,72,121,72,121,
		72,112,3,73,36,21,0,48,6,0,95,2,106,6,82,105,103,104,116,
		0,108,12,95,1,121,72,121,72,121,72,112,3,73,36,22,0,48,6,
		0,95,2,106,7,80,97,103,101,85,112,0,108,13,95,1,121,72,121,
		72,121,72,112,3,73,36,23,0,48,6,0,95,2,106,9,80,97,103,
		101,68,111,119,110,0,108,14,95,1,121,72,121,72,121,72,112,3,73,
		36,24,0,48,6,0,95,2,106,5,77,111,118,101,0,108,15,95,1,
		121,72,121,72,121,72,112,3,73,36,25,0,48,6,0,95,2,106,8,
		77,111,118,101,71,101,116,0,108,16,95,1,121,72,121,72,121,72,112,
		3,73,36,26,0,48,6,0,95,2,106,6,73,110,107,101,121,0,108,
		17,95,1,121,72,121,72,121,72,112,3,73,36,27,0,48,6,0,95,
		2,106,9,69,115,113,117,101,114,100,97,0,108,18,95,1,121,72,121,
		72,121,72,112,3,73,36,29,0,48,19,0,95,2,112,0,73,167,14,
		0,0,176,20,0,104,1,0,95,2,20,2,168,48,21,0,95,2,112,
		0,80,3,176,22,0,95,3,106,10,73,110,105,116,67,108,97,115,115,
		0,12,2,28,12,48,23,0,95,3,164,146,1,0,73,95,3,110,7,
		48,21,0,103,1,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_NEW )
{
	static const HB_BYTE pcode[] =
	{
		13,0,7,36,32,0,48,24,0,102,95,1,100,69,28,6,95,1,25,
		4,92,10,112,1,73,36,33,0,48,25,0,102,95,2,100,69,28,6,
		95,2,25,4,92,10,112,1,73,36,34,0,48,26,0,102,95,3,100,
		69,28,6,95,3,25,4,92,20,112,1,73,36,35,0,48,27,0,102,
		95,4,100,69,28,6,95,4,25,4,92,40,112,1,73,36,36,0,48,
		28,0,102,95,7,100,69,28,6,95,7,25,4,92,31,112,1,73,36,
		37,0,48,29,0,102,95,5,100,69,28,6,95,5,25,3,100,112,1,
		73,36,38,0,48,30,0,102,95,6,100,69,28,6,95,6,25,3,100,
		112,1,73,36,39,0,48,31,0,102,106,9,218,196,191,179,217,196,192,
		179,0,112,1,73,36,40,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_MOVE )
{
	static const HB_BYTE pcode[] =
	{
		13,3,5,36,43,0,176,32,0,95,1,12,1,80,6,36,44,0,95,
		2,48,33,0,102,112,0,49,80,7,36,45,0,95,3,48,34,0,102,
		112,0,49,80,8,36,46,0,48,35,0,102,112,0,73,36,47,0,48,
		36,0,102,95,2,95,3,95,4,95,5,112,4,73,36,48,0,95,6,
		121,69,28,20,36,49,0,48,37,0,102,95,1,95,6,95,7,95,8,
		112,4,73,36,51,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_MOVEGET )
{
	static const HB_BYTE pcode[] =
	{
		13,1,4,36,55,0,122,165,80,5,25,58,36,56,0,48,38,0,95,
		1,95,5,1,21,48,39,0,163,0,112,0,95,3,72,112,1,73,36,
		57,0,48,40,0,95,1,95,5,1,21,48,41,0,163,0,112,0,95,
		4,72,112,1,73,36,55,0,175,5,0,95,2,15,28,197,36,59,0,
		102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_HIDE )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,36,62,0,176,42,0,48,43,0,102,112,0,20,1,36,63,
		0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_INKEYMBOX )
{
	static const HB_BYTE pcode[] =
	{
		36,66,0,176,44,0,121,20,1,36,67,0,176,45,0,12,0,93,141,
		1,5,28,12,36,68,0,48,46,0,102,112,0,73,36,70,0,102,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_UP )
{
	static const HB_BYTE pcode[] =
	{
		36,73,0,48,35,0,102,112,0,73,36,74,0,48,24,0,102,21,48,
		33,0,163,0,112,0,17,112,1,73,36,75,0,48,26,0,102,21,48,
		47,0,163,0,112,0,17,112,1,73,36,76,0,48,48,0,102,112,0,
		73,36,77,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_PAGEUP )
{
	static const HB_BYTE pcode[] =
	{
		36,80,0,48,35,0,102,112,0,73,36,81,0,48,49,0,102,176,50,
		0,12,0,112,1,73,36,82,0,48,24,0,102,121,112,1,73,36,83,
		0,48,26,0,102,92,4,112,1,73,36,84,0,48,48,0,102,112,0,
		73,36,85,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_PAGEDOWN )
{
	static const HB_BYTE pcode[] =
	{
		36,88,0,48,35,0,102,112,0,73,36,89,0,48,49,0,102,176,50,
		0,12,0,112,1,73,36,90,0,48,24,0,102,92,20,112,1,73,36,
		91,0,48,26,0,102,92,24,112,1,73,36,92,0,48,48,0,102,112,
		0,73,36,93,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_DOWN )
{
	static const HB_BYTE pcode[] =
	{
		36,96,0,48,35,0,102,112,0,73,36,97,0,48,49,0,102,176,50,
		0,12,0,112,1,73,36,98,0,48,24,0,102,21,48,33,0,163,0,
		112,0,23,112,1,73,36,99,0,48,26,0,102,21,48,47,0,163,0,
		112,0,23,112,1,73,36,100,0,48,48,0,102,112,0,73,36,101,0,
		102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_LEFTMBOX )
{
	static const HB_BYTE pcode[] =
	{
		36,104,0,48,35,0,102,112,0,73,36,105,0,48,49,0,102,176,50,
		0,12,0,112,1,73,36,106,0,48,25,0,102,21,48,34,0,163,0,
		112,0,17,112,1,73,36,107,0,48,27,0,102,21,48,51,0,163,0,
		112,0,17,112,1,73,36,108,0,48,48,0,102,112,0,73,36,109,0,
		102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_RIGHT )
{
	static const HB_BYTE pcode[] =
	{
		36,112,0,48,35,0,102,112,0,73,36,113,0,48,49,0,102,176,50,
		0,12,0,112,1,73,36,114,0,48,25,0,102,21,48,34,0,163,0,
		112,0,23,112,1,73,36,115,0,48,27,0,102,21,48,51,0,163,0,
		112,0,23,112,1,73,36,116,0,48,48,0,102,112,0,73,36,117,0,
		102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TBOX_SHOW )
{
	static const HB_BYTE pcode[] =
	{
		13,3,7,36,120,0,106,2,32,0,80,8,36,123,0,48,49,0,102,
		176,50,0,12,0,112,1,73,36,124,0,48,24,0,102,95,1,100,69,
		28,6,95,1,25,8,48,33,0,102,112,0,112,1,73,36,125,0,48,
		25,0,102,95,2,100,69,28,6,95,2,25,8,48,34,0,102,112,0,
		112,1,73,36,126,0,48,26,0,102,95,3,100,69,28,6,95,3,25,
		8,48,47,0,102,112,0,112,1,73,36,127,0,48,27,0,102,95,4,
		100,69,28,6,95,4,25,8,48,51,0,102,112,0,112,1,73,36,128,
		0,48,28,0,102,95,7,100,69,28,6,95,7,25,8,48,52,0,102,
		112,0,112,1,73,36,129,0,48,29,0,102,95,5,100,69,28,6,95,
		5,25,8,48,53,0,102,112,0,112,1,73,36,130,0,48,30,0,102,
		95,6,100,69,28,6,95,6,25,8,48,54,0,102,112,0,112,1,73,
		36,132,0,48,52,0,102,112,0,80,9,36,133,0,176,55,0,20,0,
		36,134,0,48,51,0,102,112,0,92,79,5,28,17,36,135,0,48,27,
		0,102,176,56,0,12,0,112,1,73,36,138,0,176,57,0,96,9,0,
		96,10,0,20,2,36,139,0,176,58,0,48,33,0,102,112,0,48,34,
		0,102,112,0,48,47,0,102,112,0,48,51,0,102,112,0,48,59,0,
		109,60,0,112,0,95,8,72,48,52,0,102,112,0,20,6,36,140,0,
		48,53,0,102,112,0,100,69,28,113,36,141,0,176,61,0,48,33,0,
		102,112,0,48,34,0,102,112,0,122,72,106,2,219,0,176,62,0,48,
		52,0,102,112,0,12,1,48,51,0,102,112,0,48,34,0,102,112,0,
		49,122,49,20,5,36,142,0,176,61,0,48,33,0,102,112,0,48,34,
		0,102,112,0,122,72,176,63,0,48,53,0,102,112,0,48,51,0,102,
		112,0,48,34,0,102,112,0,49,122,49,12,2,176,62,0,48,52,0,
		102,112,0,12,1,20,4,36,144,0,48,54,0,102,112,0,100,69,28,
		113,36,145,0,176,61,0,48,47,0,102,112,0,48,34,0,102,112,0,
		122,72,106,2,219,0,176,62,0,48,52,0,102,112,0,12,1,48,51,
		0,102,112,0,48,34,0,102,112,0,49,122,49,20,5,36,146,0,176,
		61,0,48,47,0,102,112,0,48,34,0,102,112,0,122,72,176,63,0,
		48,54,0,102,112,0,48,51,0,102,112,0,48,34,0,102,112,0,49,
		122,49,12,2,176,62,0,48,52,0,102,112,0,12,1,20,4,36,148,
		0,176,64,0,176,65,0,12,0,20,1,36,149,0,176,66,0,95,9,
		176,62,0,95,9,12,1,20,2,36,150,0,176,67,0,20,0,36,151,
		0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TBOXNEW )
{
	static const HB_BYTE pcode[] =
	{
		36,155,0,48,2,0,176,0,0,12,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,75,0,1,0,7
	};

	hb_vmExecute( pcode, symbols );
}