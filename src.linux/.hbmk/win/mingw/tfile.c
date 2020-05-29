/*
 * Harbour 3.4.0dev (096e85514a) (2019-07-15 13:50)
 * MinGW GNU C 9.2 (32-bit)
 * PCode version: 0.3
 * Generated C source from "src\tfile.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"

HB_FUNC( TFILE );
HB_FUNC_EXTERN( __CLSLOCKDEF );
HB_FUNC_EXTERN( HBCLASS );
HB_FUNC_EXTERN( HBOBJECT );
HB_FUNC_STATIC( TFILE_NEW );
HB_FUNC_STATIC( TFILE_INICIO );
HB_FUNC_STATIC( TFILE_EJECT );
HB_FUNC_STATIC( TFILE_PRINTON );
HB_FUNC_STATIC( TFILE_PRINTOFF );
HB_FUNC_EXTERN( FT_DFCLOSE );
HB_FUNC_EXTERN( FT_DFSETUP );
HB_FUNC_EXTERN( FT_DISPFILE );
HB_FUNC_EXTERN( FT_FAPPEND );
HB_FUNC_EXTERN( FT_FDELETE );
HB_FUNC_EXTERN( FT_FEOF );
HB_FUNC_EXTERN( FT_FERROR );
HB_FUNC_EXTERN( FT_FGOBOT );
HB_FUNC_EXTERN( FT_FGOTO );
HB_FUNC_EXTERN( FT_FGOTOP );
HB_FUNC_EXTERN( FT_FINSERT );
HB_FUNC_EXTERN( FT_FLASTRE );
HB_FUNC_EXTERN( FT_FREADLN );
HB_FUNC_EXTERN( FT_FRECNO );
HB_FUNC_EXTERN( FT_FSELECT );
HB_FUNC_EXTERN( FT_FSKIP );
HB_FUNC_EXTERN( FT_FUSE );
HB_FUNC_EXTERN( FT_FWRITELN );
HB_FUNC_EXTERN( __CLSUNLOCKDEF );
HB_FUNC_EXTERN( __OBJHASMSG );
HB_FUNC_EXTERN( LTRIM );
HB_FUNC_EXTERN( RTRIM );
HB_FUNC_EXTERN( TIME );
HB_FUNC_EXTERN( DTOC );
HB_FUNC_EXTERN( DATE );
HB_FUNC_EXTERN( DEVPOS );
HB_FUNC_EXTERN( QQOUT );
HB_FUNC_EXTERN( PADC );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( PADR );
HB_FUNC_EXTERN( STRZERO );
HB_FUNC_EXTERN( PADL );
HB_FUNC_EXTERN( REPLICATE );
HB_FUNC_EXTERN( PRINTON );
HB_FUNC_EXTERN( FPRINT );
HB_FUNC_EXTERN( SETPRC );
HB_FUNC_EXTERN( PRINTOFF );
HB_FUNC_EXTERN( __EJECT );
HB_FUNC( TFILENEW );
HB_FUNC_EXTERN( DBFNTX );
HB_FUNC_EXTERN( DBFCDX );
HB_FUNC_EXTERN( DBFFPT );
HB_FUNC_EXTERN( SIXCDX );
HB_FUNC_EXTERN( DBFNSX );
HB_FUNC_EXTERN( HB_MEMIO );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITSTATICS();
HB_FUNC_INITLINES();

HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_TFILE )
{ "TFILE", { HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE ) }, NULL },
{ "__CLSLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSLOCKDEF ) }, NULL },
{ "NEW", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "HBCLASS", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBCLASS ) }, NULL },
{ "HBOBJECT", { HB_FS_PUBLIC }, { HB_FUNCNAME( HBOBJECT ) }, NULL },
{ "ADDMULTIDATA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "ADDMETHOD", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TFILE_NEW", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE_NEW ) }, NULL },
{ "TFILE_INICIO", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE_INICIO ) }, NULL },
{ "TFILE_EJECT", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE_EJECT ) }, NULL },
{ "TFILE_PRINTON", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE_PRINTON ) }, NULL },
{ "TFILE_PRINTOFF", { HB_FS_STATIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILE_PRINTOFF ) }, NULL },
{ "ADDINLINE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "FT_DFCLOSE", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_DFCLOSE ) }, NULL },
{ "FT_DFSETUP", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_DFSETUP ) }, NULL },
{ "FT_DISPFILE", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_DISPFILE ) }, NULL },
{ "FT_FAPPEND", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FAPPEND ) }, NULL },
{ "FT_FDELETE", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FDELETE ) }, NULL },
{ "FT_FEOF", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FEOF ) }, NULL },
{ "FT_FERROR", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FERROR ) }, NULL },
{ "FT_FGOBOT", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FGOBOT ) }, NULL },
{ "FT_FGOTO", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FGOTO ) }, NULL },
{ "FT_FGOTOP", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FGOTOP ) }, NULL },
{ "FT_FINSERT", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FINSERT ) }, NULL },
{ "FT_FLASTRE", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FLASTRE ) }, NULL },
{ "FT_FREADLN", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FREADLN ) }, NULL },
{ "FT_FRECNO", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FRECNO ) }, NULL },
{ "FT_FSELECT", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FSELECT ) }, NULL },
{ "FT_FSKIP", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FSKIP ) }, NULL },
{ "FT_FUSE", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FUSE ) }, NULL },
{ "FT_FWRITELN", { HB_FS_PUBLIC }, { HB_FUNCNAME( FT_FWRITELN ) }, NULL },
{ "CREATE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__CLSUNLOCKDEF", { HB_FS_PUBLIC }, { HB_FUNCNAME( __CLSUNLOCKDEF ) }, NULL },
{ "INSTANCE", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "__OBJHASMSG", { HB_FS_PUBLIC }, { HB_FUNCNAME( __OBJHASMSG ) }, NULL },
{ "INITCLASS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_ROWPRN", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_PAGINA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_TAMANHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_NOMEFIRMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "XNOMEFIR", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "LTRIM", { HB_FS_PUBLIC }, { HB_FUNCNAME( LTRIM ) }, NULL },
{ "RTRIM", { HB_FS_PUBLIC }, { HB_FUNCNAME( RTRIM ) }, NULL },
{ "XFANTA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "OAMBIENTE", { HB_FS_PUBLIC | HB_FS_MEMVAR }, { NULL }, NULL },
{ "_SISTEMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_TITULO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_CABECALHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_SEPARADOR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "_REGISTROS", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TAMANHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TIME", { HB_FS_PUBLIC }, { HB_FUNCNAME( TIME ) }, NULL },
{ "DTOC", { HB_FS_PUBLIC }, { HB_FUNCNAME( DTOC ) }, NULL },
{ "DATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( DATE ) }, NULL },
{ "PAGINA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "DEVPOS", { HB_FS_PUBLIC }, { HB_FUNCNAME( DEVPOS ) }, NULL },
{ "QQOUT", { HB_FS_PUBLIC }, { HB_FUNCNAME( QQOUT ) }, NULL },
{ "PADC", { HB_FS_PUBLIC }, { HB_FUNCNAME( PADC ) }, NULL },
{ "NOMEFIRMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "QOUT", { HB_FS_PUBLIC }, { HB_FUNCNAME( QOUT ) }, NULL },
{ "SISTEMA", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "TITULO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "PADR", { HB_FS_PUBLIC }, { HB_FUNCNAME( PADR ) }, NULL },
{ "STRZERO", { HB_FS_PUBLIC }, { HB_FUNCNAME( STRZERO ) }, NULL },
{ "PADL", { HB_FS_PUBLIC }, { HB_FUNCNAME( PADL ) }, NULL },
{ "REPLICATE", { HB_FS_PUBLIC }, { HB_FUNCNAME( REPLICATE ) }, NULL },
{ "SEPARADOR", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "CABECALHO", { HB_FS_PUBLIC | HB_FS_MESSAGE }, { NULL }, NULL },
{ "PRINTON", { HB_FS_PUBLIC }, { HB_FUNCNAME( PRINTON ) }, NULL },
{ "FPRINT", { HB_FS_PUBLIC }, { HB_FUNCNAME( FPRINT ) }, NULL },
{ "SETPRC", { HB_FS_PUBLIC }, { HB_FUNCNAME( SETPRC ) }, NULL },
{ "PRINTOFF", { HB_FS_PUBLIC }, { HB_FUNCNAME( PRINTOFF ) }, NULL },
{ "__EJECT", { HB_FS_PUBLIC }, { HB_FUNCNAME( __EJECT ) }, NULL },
{ "TFILENEW", { HB_FS_PUBLIC | HB_FS_LOCAL }, { HB_FUNCNAME( TFILENEW ) }, NULL },
{ "DBFNTX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNTX ) }, NULL },
{ "DBFCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFCDX ) }, NULL },
{ "DBFFPT", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFFPT ) }, NULL },
{ "SIXCDX", { HB_FS_PUBLIC }, { HB_FUNCNAME( SIXCDX ) }, NULL },
{ "DBFNSX", { HB_FS_PUBLIC }, { HB_FUNCNAME( DBFNSX ) }, NULL },
{ "HB_MEMIO", { HB_FS_PUBLIC }, { HB_FUNCNAME( HB_MEMIO ) }, NULL },
{ "__DBGENTRY", { HB_FS_PUBLIC }, { HB_FUNCNAME( __DBGENTRY ) }, NULL },
{ "(_INITSTATICS00001)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITSTATICS }, NULL },
{ "(_INITLINES)", { HB_FS_INITEXIT | HB_FS_LOCAL }, { hb_INITLINES }, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_TFILE, "src\\tfile.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_TFILE
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_TFILE )
   #include "hbiniseg.h"
#endif

HB_FUNC( TFILE )
{
	static const HB_BYTE pcode[] =
	{
		149,3,0,116,81,0,51,115,114,99,92,116,102,105,108,101,46,112,114,
		103,58,84,70,73,76,69,0,36,4,0,118,0,1,0,83,95,79,67,
		76,65,83,83,0,36,4,0,37,1,0,78,83,67,79,80,69,0,37,
		2,0,79,67,76,65,83,83,0,37,3,0,79,73,78,83,84,65,78,
		67,69,0,103,1,0,100,8,29,95,7,176,1,0,104,1,0,12,1,
		29,84,7,166,22,7,0,122,80,1,48,2,0,176,3,0,12,0,106,
		6,84,70,105,108,101,0,108,4,4,1,0,108,0,112,3,80,2,36,
		5,0,122,80,1,36,6,0,48,5,0,95,2,100,100,95,1,121,72,
		121,72,121,72,106,7,82,111,119,80,114,110,0,4,1,0,9,112,5,
		73,36,7,0,48,5,0,95,2,100,100,95,1,121,72,121,72,121,72,
		106,7,80,97,103,105,110,97,0,4,1,0,9,112,5,73,36,8,0,
		48,5,0,95,2,100,100,95,1,121,72,121,72,121,72,106,8,84,97,
		109,97,110,104,111,0,4,1,0,9,112,5,73,36,9,0,48,5,0,
		95,2,100,100,95,1,121,72,121,72,121,72,106,10,78,111,109,101,70,
		105,114,109,97,0,4,1,0,9,112,5,73,36,10,0,48,5,0,95,
		2,100,100,95,1,121,72,121,72,121,72,106,8,83,105,115,116,101,109,
		97,0,4,1,0,9,112,5,73,36,11,0,48,5,0,95,2,100,100,
		95,1,121,72,121,72,121,72,106,7,84,105,116,117,108,111,0,4,1,
		0,9,112,5,73,36,12,0,48,5,0,95,2,100,100,95,1,121,72,
		121,72,121,72,106,10,67,97,98,101,99,97,108,104,111,0,4,1,0,
		9,112,5,73,36,13,0,48,5,0,95,2,100,100,95,1,121,72,121,
		72,121,72,106,10,83,101,112,97,114,97,100,111,114,0,4,1,0,9,
		112,5,73,36,14,0,48,5,0,95,2,100,100,95,1,121,72,121,72,
		121,72,106,10,82,101,103,105,115,116,114,111,115,0,4,1,0,9,112,
		5,73,36,16,0,122,80,1,36,17,0,48,6,0,95,2,106,4,78,
		101,119,0,108,7,95,1,92,8,72,121,72,121,72,112,3,73,36,19,
		0,48,6,0,95,2,106,7,73,110,105,99,105,111,0,108,8,95,1,
		121,72,121,72,121,72,112,3,73,36,20,0,48,6,0,95,2,106,6,
		69,106,101,99,116,0,108,9,95,1,121,72,121,72,121,72,112,3,73,
		36,21,0,48,6,0,95,2,106,8,80,114,105,110,116,79,110,0,108,
		10,95,1,121,72,121,72,121,72,112,3,73,36,22,0,48,6,0,95,
		2,106,9,80,114,105,110,116,79,102,102,0,108,11,95,1,121,72,121,
		72,121,72,112,3,73,36,23,0,48,6,0,95,2,106,6,99,97,98,
		101,99,0,108,8,95,1,121,72,121,72,121,72,112,3,73,36,24,0,
		48,12,0,95,2,106,8,68,102,67,108,111,115,101,0,89,42,0,1,
		0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,0,37,1,0,83,69,76,70,0,176,13,0,12,0,6,
		95,1,121,72,121,72,121,72,112,3,73,36,25,0,48,12,0,95,2,
		106,8,68,102,83,101,116,117,112,0,89,42,0,1,0,0,0,51,115,
		114,99,92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,
		37,1,0,83,69,76,70,0,176,14,0,12,0,6,95,1,121,72,121,
		72,121,72,112,3,73,36,26,0,48,12,0,95,2,106,11,68,102,68,
		105,115,112,102,105,108,101,0,89,42,0,1,0,0,0,51,115,114,99,
		92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,
		0,83,69,76,70,0,176,15,0,12,0,6,95,1,121,72,121,72,121,
		72,112,3,73,36,27,0,48,12,0,95,2,106,7,65,112,112,101,110,
		100,0,89,42,0,1,0,0,0,51,115,114,99,92,116,102,105,108,101,
		46,112,114,103,58,84,70,73,76,69,0,37,1,0,83,69,76,70,0,
		176,16,0,12,0,6,95,1,121,72,121,72,121,72,112,3,73,36,28,
		0,48,12,0,95,2,106,7,68,101,108,101,116,101,0,89,42,0,1,
		0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,0,37,1,0,83,69,76,70,0,176,17,0,12,0,6,
		95,1,121,72,121,72,121,72,112,3,73,36,29,0,48,12,0,95,2,
		106,4,69,111,102,0,89,42,0,1,0,0,0,51,115,114,99,92,116,
		102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,0,83,
		69,76,70,0,176,18,0,12,0,6,95,1,121,72,121,72,121,72,112,
		3,73,36,30,0,48,12,0,95,2,106,7,70,101,114,114,111,114,0,
		89,42,0,1,0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,
		114,103,58,84,70,73,76,69,0,37,1,0,83,69,76,70,0,176,19,
		0,12,0,6,95,1,121,72,121,72,121,72,112,3,73,36,31,0,48,
		12,0,95,2,106,9,71,111,66,111,116,116,111,109,0,89,42,0,1,
		0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,0,37,1,0,83,69,76,70,0,176,20,0,12,0,6,
		95,1,121,72,121,72,121,72,112,3,73,36,32,0,48,12,0,95,2,
		106,5,71,111,116,111,0,89,42,0,1,0,0,0,51,115,114,99,92,
		116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,0,
		83,69,76,70,0,176,21,0,12,0,6,95,1,121,72,121,72,121,72,
		112,3,73,36,33,0,48,12,0,95,2,106,6,71,111,116,111,112,0,
		89,42,0,1,0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,
		114,103,58,84,70,73,76,69,0,37,1,0,83,69,76,70,0,176,22,
		0,12,0,6,95,1,121,72,121,72,121,72,112,3,73,36,34,0,48,
		12,0,95,2,106,7,73,110,115,101,114,116,0,89,42,0,1,0,0,
		0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,70,73,
		76,69,0,37,1,0,83,69,76,70,0,176,23,0,12,0,6,95,1,
		121,72,121,72,121,72,112,3,73,36,35,0,48,12,0,95,2,106,8,
		76,97,115,116,82,101,99,0,89,42,0,1,0,0,0,51,115,114,99,
		92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,
		0,83,69,76,70,0,176,24,0,12,0,6,95,1,121,72,121,72,121,
		72,112,3,73,36,36,0,48,12,0,95,2,106,7,82,101,97,100,108,
		110,0,89,42,0,1,0,0,0,51,115,114,99,92,116,102,105,108,101,
		46,112,114,103,58,84,70,73,76,69,0,37,1,0,83,69,76,70,0,
		176,25,0,12,0,6,95,1,121,72,121,72,121,72,112,3,73,36,37,
		0,48,12,0,95,2,106,6,82,101,99,110,111,0,89,42,0,1,0,
		0,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,70,
		73,76,69,0,37,1,0,83,69,76,70,0,176,26,0,12,0,6,95,
		1,121,72,121,72,121,72,112,3,73,36,38,0,48,12,0,95,2,106,
		7,83,101,108,101,99,116,0,89,42,0,1,0,0,0,51,115,114,99,
		92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,
		0,83,69,76,70,0,176,27,0,12,0,6,95,1,121,72,121,72,121,
		72,112,3,73,36,39,0,48,12,0,95,2,106,5,83,107,105,112,0,
		89,42,0,1,0,0,0,51,115,114,99,92,116,102,105,108,101,46,112,
		114,103,58,84,70,73,76,69,0,37,1,0,83,69,76,70,0,176,28,
		0,12,0,6,95,1,121,72,121,72,121,72,112,3,73,36,40,0,48,
		12,0,95,2,106,4,85,115,101,0,89,42,0,1,0,0,0,51,115,
		114,99,92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,69,0,
		37,1,0,83,69,76,70,0,176,29,0,12,0,6,95,1,121,72,121,
		72,121,72,112,3,73,36,41,0,48,12,0,95,2,106,8,87,114,105,
		116,101,108,110,0,89,42,0,1,0,0,0,51,115,114,99,92,116,102,
		105,108,101,46,112,114,103,58,84,70,73,76,69,0,37,1,0,83,69,
		76,70,0,176,30,0,12,0,6,95,1,121,72,121,72,121,72,112,3,
		73,36,42,0,48,31,0,95,2,112,0,73,167,14,0,0,176,32,0,
		104,1,0,95,2,20,2,168,48,33,0,95,2,112,0,80,3,176,34,
		0,95,3,106,10,73,110,105,116,67,108,97,115,115,0,12,2,28,12,
		48,35,0,95,3,164,146,1,0,73,95,3,110,7,48,33,0,103,1,
		0,112,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TFILE_NEW )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,95,78,69,87,0,36,44,0,37,1,0,83,69,76,70,
		0,102,80,1,36,45,0,48,36,0,95,1,121,112,1,73,36,46,0,
		48,37,0,95,1,121,112,1,73,36,47,0,48,38,0,95,1,92,80,
		112,1,73,36,48,0,48,39,0,95,1,109,40,0,100,5,28,22,176,
		41,0,176,42,0,48,43,0,109,44,0,112,0,12,1,12,1,25,5,
		109,40,0,112,1,73,36,49,0,48,45,0,95,1,106,27,77,97,99,
		114,111,115,111,102,116,32,78,79,77,69,32,68,79,32,80,82,79,71,
		82,65,77,65,0,112,1,73,36,50,0,48,46,0,95,1,106,20,84,
		73,84,85,76,79,32,68,79,32,82,69,76,65,84,79,82,73,79,0,
		112,1,73,36,51,0,48,47,0,95,1,106,17,67,79,68,73,71,79,
		32,68,69,83,67,82,73,67,65,79,0,112,1,73,36,52,0,48,48,
		0,95,1,106,2,61,0,112,1,73,36,53,0,48,49,0,95,1,121,
		112,1,73,36,54,0,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TFILE_INICIO )
{
	static const HB_BYTE pcode[] =
	{
		13,4,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,95,73,78,73,67,73,79,0,36,56,0,37,1,0,83,
		69,76,70,0,102,80,1,36,57,0,37,2,0,78,84,65,77,0,48,
		50,0,95,1,112,0,92,2,18,80,2,36,58,0,37,3,0,72,79,
		82,65,0,176,51,0,12,0,80,3,36,59,0,37,4,0,68,65,84,
		65,0,176,52,0,176,53,0,12,0,12,1,80,4,36,60,0,48,37,
		0,95,1,21,48,54,0,163,0,112,0,23,112,1,73,36,62,0,176,
		55,0,121,121,20,2,176,56,0,176,57,0,48,58,0,95,1,112,0,
		48,50,0,95,1,112,0,12,2,20,1,36,63,0,176,59,0,176,57,
		0,48,60,0,95,1,112,0,48,50,0,95,1,112,0,12,2,20,1,
		36,64,0,176,59,0,176,57,0,48,61,0,95,1,112,0,48,50,0,
		95,1,112,0,12,2,20,1,36,65,0,176,59,0,176,62,0,106,10,
		80,97,103,105,110,97,32,58,32,0,176,63,0,48,54,0,95,1,112,
		0,92,3,12,2,72,95,2,12,2,176,64,0,95,4,106,4,32,45,
		32,0,72,95,3,72,95,2,12,2,72,20,1,36,66,0,176,59,0,
		176,65,0,48,66,0,95,1,112,0,48,50,0,95,1,112,0,12,2,
		20,1,36,67,0,176,59,0,48,67,0,95,1,112,0,20,1,36,68,
		0,176,59,0,176,65,0,48,66,0,95,1,112,0,48,50,0,95,1,
		112,0,12,2,20,1,36,69,0,48,36,0,95,1,92,7,112,1,73,
		36,70,0,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TFILE_PRINTON )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,95,80,82,73,78,84,79,78,0,37,1,0,67,67,79,
		68,73,71,79,67,79,78,84,82,79,76,69,0,36,72,0,37,2,0,
		83,69,76,70,0,102,80,2,36,73,0,176,68,0,20,0,36,74,0,
		95,1,100,69,28,12,36,75,0,176,69,0,95,1,20,1,36,77,0,
		176,70,0,121,121,20,2,36,78,0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TFILE_PRINTOFF )
{
	static const HB_BYTE pcode[] =
	{
		13,1,1,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,95,80,82,73,78,84,79,70,70,0,37,1,0,67,67,
		79,68,73,71,79,67,79,78,84,82,79,76,69,0,36,80,0,37,2,
		0,83,69,76,70,0,102,80,2,36,81,0,95,1,100,69,28,12,36,
		82,0,176,69,0,95,1,20,1,36,84,0,176,71,0,20,0,36,85,
		0,95,2,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_STATIC( TFILE_EJECT )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,
		70,73,76,69,95,69,74,69,67,84,0,36,87,0,37,1,0,83,69,
		76,70,0,102,80,1,36,88,0,48,36,0,95,1,121,112,1,73,36,
		89,0,176,72,0,20,0,36,90,0,176,70,0,121,121,20,2,36,91,
		0,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( TFILENEW )
{
	static const HB_BYTE pcode[] =
	{
		51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,84,70,73,76,
		69,78,69,87,0,36,95,0,48,2,0,176,0,0,12,0,112,0,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITSTATICS()
{
	static const HB_BYTE pcode[] =
	{
		117,81,0,1,0,116,81,0,51,115,114,99,92,116,102,105,108,101,46,
		112,114,103,58,40,95,73,78,73,84,83,84,65,84,73,67,83,41,0,
		7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,115,114,99,92,116,102,105,108,101,46,112,114,103,58,40,95,73,78,
		73,84,76,73,78,69,83,41,0,106,14,115,114,99,92,116,102,105,108,
		101,46,112,114,103,0,121,106,13,240,127,251,255,255,247,127,223,127,111,
		183,143,0,4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}
