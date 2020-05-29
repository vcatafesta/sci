/*
 * Harbour 3.2.0dev (r1607181832)
 * Borland C++ 5.5.1 (32-bit)
 * Generated C source from "sql.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( MAIN );
HB_FUNC_EXTERN( SQLITE3_OPEN );
HB_FUNC_EXTERN( SQLITE3_EXEC );
HB_FUNC_EXTERN( QOUT );
HB_FUNC( CRUDADD );
HB_FUNC_EXTERN( HB_NTOS );
HB_FUNC_EXTERN( SQLITE3_CHANGES );
HB_FUNC_EXTERN( SQLITE3_TOTAL_CHANGES );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_SQL )
{ "MAIN", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( MAIN )}, NULL },
{ "SQLITE3_OPEN", {HB_FS_PUBLIC}, {HB_FUNCNAME( SQLITE3_OPEN )}, NULL },
{ "SQLITE3_EXEC", {HB_FS_PUBLIC}, {HB_FUNCNAME( SQLITE3_EXEC )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "CRUDADD", {HB_FS_PUBLIC | HB_FS_LOCAL}, {HB_FUNCNAME( CRUDADD )}, NULL },
{ "HB_NTOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( HB_NTOS )}, NULL },
{ "SQLITE3_CHANGES", {HB_FS_PUBLIC}, {HB_FUNCNAME( SQLITE3_CHANGES )}, NULL },
{ "SQLITE3_TOTAL_CHANGES", {HB_FS_PUBLIC}, {HB_FUNCNAME( SQLITE3_TOTAL_CHANGES )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_SQL, "sql.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_SQL
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_SQL )
   #include "hbiniseg.h"
#endif

HB_FUNC( MAIN )
{
	static const HB_BYTE pcode[] =
	{
		13,4,0,51,115,113,108,46,112,114,103,58,77,65,
		73,78,0,36,6,0,37,1,0,68,66,0,176,1,
		0,106,10,110,111,118,111,100,98,46,100,98,0,120,
		12,2,80,1,36,7,0,37,2,0,83,81,76,0,
		106,1,0,80,2,36,13,0,37,3,0,84,65,66,
		67,76,73,69,78,84,69,0,106,124,67,82,69,65,
		84,69,32,84,65,66,76,69,32,99,108,105,101,110,
		116,101,40,32,32,105,100,99,108,105,101,110,116,101,
		32,73,78,84,69,71,69,82,32,80,82,73,77,65,
		82,89,32,75,69,89,32,65,85,84,79,73,78,67,
		82,69,77,69,78,84,44,32,32,110,111,109,101,32,
		67,72,65,82,40,49,48,48,41,44,32,32,105,100,
		97,100,101,32,73,78,84,69,71,69,82,44,32,32,
		100,116,110,97,115,99,105,109,101,110,116,111,32,68,
		65,84,69,32,41,59,32,0,80,3,36,19,0,37,
		4,0,84,65,66,85,83,85,65,82,73,79,0,106,
		142,67,82,69,65,84,69,32,84,65,66,76,69,32,
		117,115,117,97,114,105,111,40,32,32,105,100,117,115,
		117,97,114,105,111,32,73,78,84,69,71,69,82,32,
		80,82,73,77,65,82,89,32,75,69,89,32,65,85,
		84,79,73,78,67,82,69,77,69,78,84,44,32,32,
		110,111,109,101,32,67,72,65,82,40,49,48,48,41,
		44,32,32,115,101,110,104,97,32,67,72,65,82,40,
		49,53,41,44,32,32,110,105,118,101,108,32,73,78,
		84,69,71,69,82,32,78,79,84,32,78,85,76,76,
		32,68,69,70,65,85,76,84,32,40,49,41,32,41,
		59,32,0,80,4,36,21,0,176,2,0,95,1,95,
		3,12,2,121,8,28,51,36,22,0,176,3,0,106,
		39,32,84,97,98,101,108,97,32,99,108,105,101,110,
		116,101,115,32,99,114,105,97,100,97,32,99,111,109,
		32,115,117,99,101,115,115,111,46,46,46,0,20,1,
		36,25,0,176,2,0,95,1,95,4,12,2,121,8,
		28,50,36,26,0,176,3,0,106,38,32,84,97,98,
		101,108,97,32,117,115,117,97,114,105,111,32,99,114,
		105,97,100,97,32,99,111,109,32,115,117,99,101,115,
		115,111,46,46,46,0,20,1,36,31,0,176,4,0,
		12,0,80,2,36,33,0,176,2,0,95,1,95,2,
		12,2,121,8,29,137,0,36,34,0,176,3,0,106,
		31,32,78,111,118,111,115,32,117,115,117,97,114,105,
		111,115,32,99,97,100,97,115,116,114,97,100,111,115,
		46,46,46,0,20,1,36,36,0,176,3,0,106,26,
		78,117,109,101,114,111,32,76,105,110,104,97,115,32,
		105,110,99,108,117,237,100,97,115,58,32,0,176,5,
		0,176,6,0,95,1,12,1,12,1,72,20,1,36,
		37,0,176,3,0,106,19,84,111,116,97,108,32,65,
		108,116,101,114,97,231,245,101,115,58,32,0,176,5,
		0,176,7,0,95,1,12,1,12,1,72,20,1,25,
		43,36,40,0,176,3,0,106,31,69,114,114,111,58,
		32,97,111,32,103,114,97,118,97,114,32,110,111,118,
		111,115,32,117,115,117,225,114,105,111,115,0,20,1,
		36,47,0,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC( CRUDADD )
{
	static const HB_BYTE pcode[] =
	{
		13,0,1,51,115,113,108,46,112,114,103,58,67,82,
		85,68,65,68,68,0,37,1,0,83,81,76,0,36,
		56,0,105,30,1,32,66,69,71,73,78,32,84,82,
		65,78,83,65,67,84,73,79,78,59,73,78,83,69,
		82,84,32,73,78,84,79,32,117,115,117,97,114,105,
		111,32,40,32,110,111,109,101,44,32,115,101,110,104,
		97,32,44,32,110,105,118,101,108,32,41,32,86,65,
		76,85,69,83,40,32,39,67,97,114,108,111,115,39,
		44,32,39,57,57,57,57,57,57,39,44,32,51,32,
		41,59,73,78,83,69,82,84,32,73,78,84,79,32,
		117,115,117,97,114,105,111,32,40,32,110,111,109,101,
		44,32,115,101,110,104,97,32,41,32,86,65,76,85,
		69,83,40,32,39,74,111,115,101,39,44,32,39,49,
		50,51,39,32,41,59,73,78,83,69,82,84,32,73,
		78,84,79,32,117,115,117,97,114,105,111,32,40,32,
		110,111,109,101,44,32,115,101,110,104,97,32,41,32,
		86,65,76,85,69,83,40,32,39,83,105,109,111,110,
		101,39,44,32,39,49,50,51,39,32,41,59,73,78,
		83,69,82,84,32,73,78,84,79,32,117,115,117,97,
		114,105,111,32,40,32,110,111,109,101,44,32,115,101,
		110,104,97,32,41,32,86,65,76,85,69,83,40,32,
		39,90,101,99,97,39,44,32,39,49,50,51,39,32,
		41,59,32,67,79,77,77,73,84,59,0,80,1,36,
		58,0,95,1,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,115,113,108,46,112,114,103,58,40,95,73,78,73,
		84,76,73,78,69,83,41,0,106,8,115,113,108,46,
		112,114,103,0,121,106,9,192,32,104,134,54,129,0,
		5,0,4,3,0,4,1,0,110,7
	};

	hb_vmExecute( pcode, symbols );
}
