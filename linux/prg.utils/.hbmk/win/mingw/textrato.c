/* C source generated by Harbour */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( TEXTRATOIMP );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_EXTERN( DATE );
HB_FUNC_STATIC( TEXTRATOIMP_ZERAR );
HB_FUNC_STATIC( TEXTRATOIMP_CALCULAPORRATODA );
HB_FUNC_STATIC( TEXTRATOIMP_CONTATRIBUNAL );
HB_FUNC_STATIC( TEXTRATOIMP_CONTARECIBO );
HB_FUNC_STATIC( TEXTRATOIMP_CONTAVENCIDO );
HB_FUNC_STATIC( TEXTRATOIMP_CONTAVENCER );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( ATRASO );
HB_FUNC_EXTERN( CARENCIA );
HB_FUNC_EXTERN( VLRDESCONTO );
HB_FUNC_EXTERN( VLRMULTA );
HB_FUNC_EXTERN( CALCULACM );
HB_FUNC_EXTERN( AANTCOMPOSTO );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFFPT );
HB_FUNC_EXTERN( SIXCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_MEMIO );
HB_FUNC_INITSTATICS();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TEXTRATO )
{ "TEXTRATOIMP", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP ) }, NULL },
{ "__CLSLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSLOCKDEF ) }, NULL },
{ "NEW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "HBCLASS", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBCLASS ) }, NULL },
{ "HBOBJECT", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBOBJECT ) }, NULL },
{ "ADDMULTIDATA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "DATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( DATE ) }, NULL },
{ "ADDINLINE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ADDMETHOD", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TEXTRATOIMP_ZERAR", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_ZERAR ) }, NULL },
{ "TEXTRATOIMP_CALCULAPORRATODA", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_CALCULAPORRATODA ) }, NULL },
{ "TEXTRATOIMP_CONTATRIBUNAL", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_CONTATRIBUNAL ) }, NULL },
{ "TEXTRATOIMP_CONTARECIBO", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_CONTARECIBO ) }, NULL },
{ "TEXTRATOIMP_CONTAVENCIDO", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_CONTAVENCIDO ) }, NULL },
{ "TEXTRATOIMP_CONTAVENCER", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TEXTRATOIMP_CONTAVENCER ) }, NULL },
{ "CREATE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__CLSUNLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSUNLOCKDEF ) }, NULL },
{ "INSTANCE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__OBJHASMSG", { HB_FS_PUBLIC }, { HB_FUNCNAME( __OBJHASMSG ) }, NULL },
{ "INITCLASS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NREGTRIBUNAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NREGRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NREGVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NREGVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRPRINCIPALTRIBUNAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRPRINCIPALRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRPRINCIPALVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRPRINCIPALVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NTOTALRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NTOTALVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NTOTALVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRCORRIGIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRCORRIGIDOTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NSOJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NSOJUROSTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLRCORRIGIDOMAISNSOJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NMULTATOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NTOTALGERAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NMULTA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NSOMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NATRASO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NCARENCIA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NDESCONTO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVALORCM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NCM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NDIAS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NJURO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_AJURO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NJURODIA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NJUROTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NVLR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_DVCTO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ATRASO", { HB_FS_PUBLIC }, { HB_FUNCNAME( ATRASO ) }, NULL },
{ "DCALCULO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "DVCTO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "CARENCIA", { HB_FS_PUBLIC }, { HB_FUNCNAME( CARENCIA ) }, NULL },
{ "VLRDESCONTO", { HB_FS_PUBLIC }, { HB_FUNCNAME( VLRDESCONTO ) }, NULL },
{ "NVLR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NATRASO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NCARENCIA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NJURODIA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NDESCONTO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "VLRMULTA", { HB_FS_PUBLIC }, { HB_FUNCNAME( VLRMULTA ) }, NULL },
{ "NSOMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NMULTA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "CALCULACM", { HB_FS_PUBLIC }, { HB_FUNCNAME( CALCULACM ) }, NULL },
{ "NVALORCM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ASCIARRAY", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "OAMBIENTE", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "AANTCOMPOSTO", { HB_FS_PUBLIC }, { HB_FUNCNAME( AANTCOMPOSTO ) }, NULL },
{ "NJURO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NDIAS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "AJURO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NJUROTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NCM", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NREGTRIBUNAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRPRINCIPALTRIBUNAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRCORRIGIDOTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRCORRIGIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NSOJUROSTOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NSOJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRCORRIGIDOMAISNSOJUROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NMULTATOTAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NTOTALGERAL", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NREGRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRPRINCIPALRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NTOTALRECIBO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "RECIBO", { HB_FS_PUBLIC }, { NULL }, NULL },
{ "VLR", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "NREGVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRPRINCIPALVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NTOTALVENCIDO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NREGVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NVLRPRINCIPALVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "NTOTALVENCER", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "DBFNTX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNTX ) }, NULL },
{ "DBFCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFCDX ) }, NULL },
{ "DBFFPT", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFFPT ) }, NULL },
{ "SIXCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( SIXCDX ) }, NULL },
{ "DBFNSX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNSX ) }, NULL },
{ "HB_MEMIO", { HB_FS_PUBLIC }, { HB_FUNCNAME( HB_MEMIO ) }, NULL },
{ "(_INITSTATICS00001)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITSTATICS }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TEXTRATO, "", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TEXTRATO
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TEXTRATO )
   #include "hbiniseg.h"
#endif

HB_FUNC( TEXTRATOIMP )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,103,0,36,3,0,103,1,0,100,8,29,158,6,176,1,
		0,104,1,0,12,1,29,147,6,166,85,6,0,122,80,1,48,2,0,
		176,3,0,12,0,106,12,84,69,120,116,114,97,116,111,73,109,112,0,
		108,4,4,1,0,108,0,112,3,80,2,36,4,0,48,5,0,95,2,
		100,121,95,1,121,72,121,72,121,72,106,13,110,82,101,103,84,114,105,
		98,117,110,97,108,0,4,1,0,9,112,5,73,36,5,0,48,5,0,
		95,2,100,121,95,1,121,72,121,72,121,72,106,11,110,82,101,103,82,
		101,99,105,98,111,0,4,1,0,9,112,5,73,36,6,0,48,5,0,
		95,2,100,121,95,1,121,72,121,72,121,72,106,12,110,82,101,103,86,
		101,110,99,105,100,111,0,4,1,0,9,112,5,73,36,7,0,48,5,
		0,95,2,100,121,95,1,121,72,121,72,121,72,106,11,110,82,101,103,
		86,101,110,99,101,114,0,4,1,0,9,112,5,73,36,8,0,48,5,
		0,95,2,100,121,95,1,121,72,121,72,121,72,106,22,110,86,108,114,
		80,114,105,110,99,105,112,97,108,84,114,105,98,117,110,97,108,0,4,
		1,0,9,112,5,73,36,9,0,48,5,0,95,2,100,121,95,1,121,
		72,121,72,121,72,106,20,110,86,108,114,80,114,105,110,99,105,112,97,
		108,82,101,99,105,98,111,0,4,1,0,9,112,5,73,36,10,0,48,
		5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,21,110,86,108,
		114,80,114,105,110,99,105,112,97,108,86,101,110,99,105,100,111,0,4,
		1,0,9,112,5,73,36,11,0,48,5,0,95,2,100,121,95,1,121,
		72,121,72,121,72,106,20,110,86,108,114,80,114,105,110,99,105,112,97,
		108,86,101,110,99,101,114,0,4,1,0,9,112,5,73,36,12,0,48,
		5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,13,110,84,111,
		116,97,108,82,101,99,105,98,111,0,4,1,0,9,112,5,73,36,13,
		0,48,5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,14,110,
		84,111,116,97,108,86,101,110,99,105,100,111,0,4,1,0,9,112,5,
		73,36,14,0,48,5,0,95,2,100,121,95,1,121,72,121,72,121,72,
		106,13,110,84,111,116,97,108,86,101,110,99,101,114,0,4,1,0,9,
		112,5,73,36,15,0,48,5,0,95,2,100,121,95,1,121,72,121,72,
		121,72,106,14,110,86,108,114,67,111,114,114,105,103,105,100,111,0,4,
		1,0,9,112,5,73,36,16,0,48,5,0,95,2,100,121,95,1,121,
		72,121,72,121,72,106,19,110,86,108,114,67,111,114,114,105,103,105,100,
		111,84,111,116,97,108,0,4,1,0,9,112,5,73,36,17,0,48,5,
		0,95,2,100,121,95,1,121,72,121,72,121,72,106,9,110,83,111,74,
		117,114,111,115,0,4,1,0,9,112,5,73,36,18,0,48,5,0,95,
		2,100,121,95,1,121,72,121,72,121,72,106,14,110,83,111,74,117,114,
		111,115,84,111,116,97,108,0,4,1,0,9,112,5,73,36,19,0,48,
		5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,26,110,86,108,
		114,67,111,114,114,105,103,105,100,111,77,97,105,115,110,83,111,74,117,
		114,111,115,0,4,1,0,9,112,5,73,36,20,0,48,5,0,95,2,
		100,121,95,1,121,72,121,72,121,72,106,12,110,77,117,108,116,97,84,
		111,116,97,108,0,4,1,0,9,112,5,73,36,21,0,48,5,0,95,
		2,100,121,95,1,121,72,121,72,121,72,106,12,110,84,111,116,97,108,
		71,101,114,97,108,0,4,1,0,9,112,5,73,36,22,0,48,5,0,
		95,2,100,121,95,1,121,72,121,72,121,72,106,8,110,65,116,114,97,
		115,111,0,4,1,0,9,112,5,73,36,23,0,48,5,0,95,2,100,
		121,95,1,121,72,121,72,121,72,106,10,110,67,97,114,101,110,99,105,
		97,0,4,1,0,9,112,5,73,36,24,0,48,5,0,95,2,100,121,
		95,1,121,72,121,72,121,72,106,10,110,68,101,115,99,111,110,116,111,
		0,4,1,0,9,112,5,73,36,25,0,48,5,0,95,2,100,121,95,
		1,121,72,121,72,121,72,106,7,110,74,117,114,111,115,0,4,1,0,
		9,112,5,73,36,26,0,48,5,0,95,2,100,121,95,1,121,72,121,
		72,121,72,106,6,110,83,111,109,97,0,4,1,0,9,112,5,73,36,
		27,0,48,5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,7,
		110,77,117,108,116,97,0,4,1,0,9,112,5,73,36,28,0,48,5,
		0,95,2,100,121,95,1,121,72,121,72,121,72,106,9,110,86,97,108,
		111,114,67,109,0,4,1,0,9,112,5,73,36,29,0,48,5,0,95,
		2,100,121,95,1,121,72,121,72,121,72,106,4,110,67,109,0,4,1,
		0,9,112,5,73,36,30,0,48,5,0,95,2,100,121,95,1,121,72,
		121,72,121,72,106,6,110,68,105,97,115,0,4,1,0,9,112,5,73,
		36,31,0,48,5,0,95,2,100,121,95,1,121,72,121,72,121,72,106,
		6,110,74,117,114,111,0,4,1,0,9,112,5,73,36,32,0,48,5,
		0,95,2,100,4,0,0,95,1,121,72,121,72,121,72,106,6,97,74,
		117,114,111,0,4,1,0,9,112,5,73,36,33,0,48,5,0,95,2,
		100,121,95,1,121,72,121,72,121,72,106,9,110,74,117,114,111,68,105,
		97,0,4,1,0,9,112,5,73,36,34,0,48,5,0,95,2,100,121,
		95,1,121,72,121,72,121,72,106,11,110,74,117,114,111,84,111,116,97,
		108,0,4,1,0,9,112,5,73,36,35,0,48,5,0,95,2,100,121,
		95,1,121,72,121,72,121,72,106,5,110,86,108,114,0,4,1,0,9,
		112,5,73,36,36,0,48,5,0,95,2,100,176,6,0,12,0,95,1,
		121,72,121,72,121,72,106,6,100,86,99,116,111,0,4,1,0,9,112,
		5,73,36,37,0,48,5,0,95,2,100,176,6,0,12,0,95,1,121,
		72,121,72,121,72,106,9,100,67,97,108,99,117,108,111,0,4,1,0,
		9,112,5,73,36,38,0,48,7,0,95,2,106,4,78,101,119,0,89,
		10,0,1,0,0,0,95,1,6,95,1,121,72,121,72,121,72,112,3,
		73,36,39,0,48,8,0,95,2,106,6,90,101,114,97,114,0,108,9,
		95,1,121,72,121,72,121,72,112,3,73,36,40,0,48,8,0,95,2,
		106,17,67,97,108,99,117,108,97,80,111,114,114,97,84,111,100,97,0,
		108,10,95,1,121,72,121,72,121,72,112,3,73,36,41,0,48,8,0,
		95,2,106,14,67,111,110,116,97,84,114,105,98,117,110,97,108,0,108,
		11,95,1,121,72,121,72,121,72,112,3,73,36,42,0,48,8,0,95,
		2,106,12,67,111,110,116,97,82,101,99,105,98,111,0,108,12,95,1,
		121,72,121,72,121,72,112,3,73,36,43,0,48,8,0,95,2,106,13,
		67,111,110,116,97,86,101,110,99,105,100,111,0,108,13,95,1,121,72,
		121,72,121,72,112,3,73,36,44,0,48,8,0,95,2,106,12,67,111,
		110,116,97,86,101,110,99,101,114,0,108,14,95,1,121,72,121,72,121,
		72,112,3,73,36,45,0,48,15,0,95,2,112,0,73,167,14,0,0,
		176,16,0,104,1,0,95,2,20,2,168,48,17,0,95,2,112,0,80,
		3,176,18,0,95,3,106,10,73,110,105,116,67,108,97,115,115,0,12,
		2,28,12,48,19,0,95,3,164,146,1,0,73,95,3,110,7,48,17,
		0,103,1,0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_ZERAR )
{
	static const HB_BYTE pcode[] =
	{
		36,49,0,48,20,0,102,121,112,1,73,36,50,0,48,21,0,102,121,
		112,1,73,36,51,0,48,22,0,102,121,112,1,73,36,52,0,48,23,
		0,102,121,112,1,73,36,53,0,48,24,0,102,121,112,1,73,36,54,
		0,48,25,0,102,121,112,1,73,36,55,0,48,26,0,102,121,112,1,
		73,36,56,0,48,27,0,102,121,112,1,73,36,57,0,48,28,0,102,
		121,112,1,73,36,58,0,48,29,0,102,121,112,1,73,36,59,0,48,
		30,0,102,121,112,1,73,36,60,0,48,31,0,102,121,112,1,73,36,
		61,0,48,32,0,102,121,112,1,73,36,62,0,48,33,0,102,121,112,
		1,73,36,63,0,48,34,0,102,121,112,1,73,36,64,0,48,35,0,
		102,121,112,1,73,36,65,0,48,36,0,102,121,112,1,73,36,66,0,
		48,37,0,102,121,112,1,73,36,67,0,48,38,0,102,121,112,1,73,
		36,68,0,48,39,0,102,121,112,1,73,36,69,0,48,40,0,102,121,
		112,1,73,36,70,0,48,41,0,102,121,112,1,73,36,71,0,48,42,
		0,102,121,112,1,73,36,72,0,48,43,0,102,121,112,1,73,36,73,
		0,48,39,0,102,121,112,1,73,36,74,0,48,38,0,102,121,112,1,
		73,36,75,0,48,44,0,102,121,112,1,73,36,76,0,48,45,0,102,
		121,112,1,73,36,77,0,48,31,0,102,121,112,1,73,36,78,0,48,
		46,0,102,121,112,1,73,36,79,0,48,47,0,102,121,112,1,73,36,
		80,0,48,48,0,102,4,0,0,112,1,73,36,81,0,48,49,0,102,
		121,112,1,73,36,82,0,48,50,0,102,121,112,1,73,36,83,0,48,
		33,0,102,121,112,1,73,36,84,0,48,50,0,102,121,112,1,73,36,
		85,0,48,49,0,102,121,112,1,73,36,86,0,48,51,0,102,121,112,
		1,73,36,87,0,48,52,0,102,176,6,0,12,0,112,1,73,36,88,
		0,48,52,0,102,176,6,0,12,0,112,1,73,36,89,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_CALCULAPORRATODA )
{
	static const HB_BYTE pcode[] =
	{
		36,92,0,48,40,0,102,176,53,0,48,54,0,102,112,0,48,55,0,
		102,112,0,12,2,112,1,73,36,93,0,48,41,0,102,176,56,0,48,
		54,0,102,112,0,48,55,0,102,112,0,12,2,112,1,73,36,94,0,
		48,42,0,102,176,57,0,48,54,0,102,112,0,48,55,0,102,112,0,
		48,58,0,102,112,0,12,3,112,1,73,36,96,0,48,43,0,102,48,
		59,0,102,112,0,121,34,28,5,121,25,15,48,60,0,102,112,0,48,
		61,0,102,112,0,65,112,1,73,36,97,0,48,39,0,102,48,58,0,
		102,112,0,48,62,0,102,112,0,72,48,63,0,102,112,0,49,112,1,
		73,36,98,0,48,38,0,102,176,64,0,48,54,0,102,112,0,48,55,
		0,102,112,0,48,65,0,102,112,0,12,3,112,1,73,36,99,0,48,
		39,0,102,21,48,65,0,163,0,112,0,48,66,0,102,112,0,72,112,
		1,73,36,101,0,48,44,0,102,176,67,0,48,58,0,102,112,0,48,
		55,0,102,112,0,48,54,0,102,112,0,12,3,112,1,73,36,102,0,
		48,45,0,102,48,68,0,102,112,0,48,58,0,102,112,0,49,112,1,
		73,36,103,0,48,31,0,102,48,68,0,102,112,0,112,1,73,36,104,
		0,48,46,0,102,48,54,0,102,112,0,48,55,0,102,112,0,49,112,
		1,73,36,105,0,48,47,0,102,48,69,0,109,70,0,112,0,122,1,
		92,8,1,112,1,73,36,106,0,48,48,0,102,176,71,0,48,58,0,
		102,112,0,48,72,0,102,112,0,48,73,0,102,112,0,101,17,17,17,
		17,17,17,161,63,255,255,12,4,112,1,73,36,107,0,48,49,0,102,
		48,74,0,102,112,0,92,6,1,112,1,73,36,108,0,48,50,0,102,
		48,74,0,102,112,0,92,5,1,112,1,73,36,109,0,48,33,0,102,
		48,74,0,102,112,0,92,5,1,112,1,73,36,110,0,48,50,0,102,
		21,48,75,0,163,0,112,0,48,76,0,102,112,0,72,112,1,73,36,
		111,0,48,49,0,102,48,75,0,102,112,0,48,73,0,102,112,0,18,
		112,1,73,36,112,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_CONTATRIBUNAL )
{
	static const HB_BYTE pcode[] =
	{
		36,115,0,48,20,0,102,21,48,77,0,163,0,112,0,23,112,1,73,
		36,116,0,48,24,0,102,21,48,78,0,163,0,112,0,48,58,0,102,
		112,0,72,112,1,73,36,117,0,48,32,0,102,21,48,79,0,163,0,
		112,0,48,80,0,102,112,0,72,112,1,73,36,118,0,48,34,0,102,
		21,48,81,0,163,0,112,0,48,82,0,102,112,0,72,112,1,73,36,
		119,0,48,35,0,102,21,48,83,0,163,0,112,0,48,80,0,102,112,
		0,48,82,0,102,112,0,72,72,112,1,73,36,120,0,48,36,0,102,
		21,48,84,0,163,0,112,0,48,66,0,102,112,0,72,112,1,73,36,
		121,0,48,37,0,102,21,48,85,0,163,0,112,0,48,80,0,102,112,
		0,48,82,0,102,112,0,72,48,66,0,102,112,0,72,72,112,1,73,
		36,122,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_CONTARECIBO )
{
	static const HB_BYTE pcode[] =
	{
		36,125,0,48,21,0,102,21,48,86,0,163,0,112,0,23,112,1,73,
		36,126,0,48,25,0,102,21,48,87,0,163,0,112,0,48,58,0,102,
		112,0,72,112,1,73,36,127,0,48,28,0,102,21,48,88,0,163,0,
		112,0,108,89,87,90,72,112,1,73,36,128,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_CONTAVENCIDO )
{
	static const HB_BYTE pcode[] =
	{
		36,131,0,48,22,0,102,21,48,91,0,163,0,112,0,23,112,1,73,
		36,132,0,48,26,0,102,21,48,92,0,163,0,112,0,48,58,0,102,
		112,0,72,112,1,73,36,133,0,48,29,0,102,21,48,93,0,163,0,
		112,0,48,65,0,102,112,0,72,112,1,73,36,134,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TEXTRATOIMP_CONTAVENCER )
{
	static const HB_BYTE pcode[] =
	{
		36,137,0,48,23,0,102,21,48,94,0,163,0,112,0,23,112,1,73,
		36,138,0,48,27,0,102,21,48,95,0,163,0,112,0,48,58,0,102,
		112,0,72,112,1,73,36,139,0,48,30,0,102,21,48,96,0,163,0,
		112,0,48,65,0,102,112,0,72,112,1,73,36,140,0,102,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,103,0,1,0,7
	};

	hb_vmExecute( pcode, symbols );
}
