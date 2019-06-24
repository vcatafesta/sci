/*
 * Harbour 3.2.0dev (r1607181832)
 * Open Watcom C 12.90 (32-bit)
 * Generated C source from "sciapi.prg"
 */

#include "hbvmpub.h"
#include "hbinit.h"


HB_FUNC( TESTE );
HB_FUNC_EXTERN( SETCOLOR );
HB_FUNC_EXTERN( SCROLL );
HB_FUNC_EXTERN( SETPOS );
HB_FUNC_EXTERN( MS_CLS );
HB_FUNC_EXTERN( DEVPOS );
HB_FUNC_EXTERN( DEVOUT );
HB_FUNC_EXTERN( MS_REPLICATE );
HB_FUNC_EXTERN( QOUT );
HB_FUNC_EXTERN( MS_SETCONSOLETITLE );
HB_FUNC_EXTERN( PROCNAME );
HB_FUNC_EXTERN( INKEY );
HB_FUNC_EXTERN( __DBGENTRY );
HB_FUNC_INITLINES();


HB_INIT_SYMBOLS_BEGIN( hb_vm_SymbolInit_SCIAPI )
{ "TESTE", {HB_FS_PUBLIC | HB_FS_FIRST | HB_FS_LOCAL}, {HB_FUNCNAME( TESTE )}, NULL },
{ "SETCOLOR", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETCOLOR )}, NULL },
{ "SCROLL", {HB_FS_PUBLIC}, {HB_FUNCNAME( SCROLL )}, NULL },
{ "SETPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( SETPOS )}, NULL },
{ "MS_CLS", {HB_FS_PUBLIC}, {HB_FUNCNAME( MS_CLS )}, NULL },
{ "DEVPOS", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVPOS )}, NULL },
{ "DEVOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( DEVOUT )}, NULL },
{ "MS_REPLICATE", {HB_FS_PUBLIC}, {HB_FUNCNAME( MS_REPLICATE )}, NULL },
{ "QOUT", {HB_FS_PUBLIC}, {HB_FUNCNAME( QOUT )}, NULL },
{ "MS_SETCONSOLETITLE", {HB_FS_PUBLIC}, {HB_FUNCNAME( MS_SETCONSOLETITLE )}, NULL },
{ "PROCNAME", {HB_FS_PUBLIC}, {HB_FUNCNAME( PROCNAME )}, NULL },
{ "INKEY", {HB_FS_PUBLIC}, {HB_FUNCNAME( INKEY )}, NULL },
{ "__DBGENTRY", {HB_FS_PUBLIC}, {HB_FUNCNAME( __DBGENTRY )}, NULL },
{ "(_INITLINES)", {HB_FS_INITEXIT | HB_FS_LOCAL}, {hb_INITLINES}, NULL }
HB_INIT_SYMBOLS_EX_END( hb_vm_SymbolInit_SCIAPI, "sciapi.prg", 0x0, 0x0003 )

#if defined( HB_PRAGMA_STARTUP )
   #pragma startup hb_vm_SymbolInit_SCIAPI
#elif defined( HB_DATASEG_STARTUP )
   #define HB_DATASEG_BODY    HB_DATASEG_FUNC( hb_vm_SymbolInit_SCIAPI )
   #include "hbiniseg.h"
#endif

HB_FUNC( TESTE )
{
	static const HB_BYTE pcode[] =
	{
		13,1,0,51,115,99,105,97,112,105,46,112,114,103,
		58,84,69,83,84,69,0,36,27,0,37,1,0,78,
		67,79,82,0,92,31,80,1,36,29,0,176,1,0,
		106,1,0,20,1,36,30,0,176,2,0,20,0,176,
		3,0,121,121,20,2,36,32,0,176,4,0,92,31,
		20,1,36,33,0,176,5,0,121,121,20,2,176,6,
		0,176,7,0,106,2,61,0,92,100,12,2,20,1,
		36,34,0,176,5,0,92,10,121,20,2,176,6,0,
		176,7,0,106,2,61,0,92,100,12,2,20,1,36,
		35,0,176,8,0,176,9,0,176,10,0,12,0,12,
		1,20,1,36,44,0,176,11,0,121,20,1,36,69,
		0,100,110,7
	};

	hb_vmExecute( pcode, symbols );
}

HB_FUNC_INITLINES()
{
	static const HB_BYTE pcode[] =
	{
		51,115,99,105,97,112,105,46,112,114,103,58,40,95,
		73,78,73,84,76,73,78,69,83,41,0,106,11,115,
		99,105,97,112,105,46,112,114,103,0,92,24,106,7,
		104,15,16,0,0,32,0,4,3,0,4,1,0,110,
		7
	};

	hb_vmExecute( pcode, symbols );
}

#line 74 "sciapi.prg"
#include <hbapi.h>
#include <hbapifs.h>
#include <hbdefs.h>
#include <hbapigt.h>
#include <iostream>
#include <windows.h>
#include <stdio.h>
#include <conio.h>
#include "hbapi.h"
#include "hbapiitm.h"
#include "hbapierr.h"

using namespace std;

typedef struct _tcor {
	WORD	fBlue;
	WORD 	fGreen;
	WORD	fRed;
	WORD	fIntensity;
	
	WORD 	bBlue;
	WORD 	bGreen;
	WORD 	bRed;
	WORD 	bIntesity;
} TCOR, *TCOR_PTR;

// C++9
//enum Range   { Max = 2147483648L, Min = 255L };
enum Days    {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
enum _color_ {c1 = 0x0003 };

// C++11
//enum Range   : LONG  { Max = 2147483648L, Min = 255L };
//enum Days    : BYTE  {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
//enum _color_ : DWORD {c1 = 0x0003 };

#define true            1
#define false           0
#define OK	            1
#define NOK	            0

typedef char						HB_CHAR;
typedef const char   			HB_TCHAR;
typedef unsigned const char   HB_UCCHAR;

typedef HB_CHAR					MS_CHAR;
typedef HB_TCHAR	   			MS_TCHAR;
typedef HB_UCCHAR				   MS_UCCHAR;
typedef HB_SIZE               MS_SIZE;
typedef int                   MS_INT;
typedef unsigned long int     MS_ULINT;
typedef HB_SHORT              MS_SHORT;

static void _color( int iNewColor);
static bool hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
void   _xcolor_fundo(WORD BackColor);

CONSOLE_SCREEN_BUFFER_INFO csbi;    	
HANDLE		hConsole;                   
COORD 		coordScreen = {0, 0};
DWORD 		dwWindowSize;
DWORD 		dwConSize;
DWORD 		dwMaxRow;
DWORD 		dwMaxCol;
DWORD 		cCharsWritten;
HANDLE  		hRunMutex;                  
HANDLE  		hScreenMutex;               
CHAR_INFO   chifill;
TCOR			TColor;
WORD		 	Color = 0x0003 | 0x0004;

/*-----------------------------------------------------------------------------------------------*/	

static MS_SIZE len(MS_CHAR *str)
{
	return((MS_INT)strlen(str));
}	

/*-----------------------------------------------------------------------------------------------*/	
	
static MS_SIZE ms_maxrow(void)
{	
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	                    	
	GetConsoleScreenBufferInfo(hConsole, &csbi);		 
	dwMaxRow = csbi.dwMaximumWindowSize.Y;		
	return(dwMaxRow);
}

/*-----------------------------------------------------------------------------------------------*/	
	
static MS_SIZE ms_maxcol(void)
{	
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 	
	GetConsoleScreenBufferInfo(hConsole, &csbi);		 
	dwMaxCol = csbi.dwMaximumWindowSize.X;		
	return(dwMaxCol);
}

/*-----------------------------------------------------------------------------------------------*/	

static MS_CHAR *replicate(HB_CHAR *str, HB_SIZE vezes)
{
	MS_SIZE lenstr = (int) strlen(str);
	MS_SIZE tam    = lenstr * vezes;
	MS_CHAR *ptr   = (MS_CHAR*)malloc(tam * sizeof(MS_CHAR*)); // (MS_CHAR*)malloc(tam+1);
	MS_SIZE x;
	MS_SIZE y;
	
	for (x = 0; x < tam;)
		for (y = 0; y < lenstr; y++, x++) {
			ptr[x] = str[y];
		}
	return (ptr);
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_REPLICATE)
{
	MS_CHAR *szText = replicate((MS_CHAR*)hb_parc(1), hb_parni(2));
	hb_retc(szText);
}

/*-----------------------------------------------------------------------------------------------*/	

MS_CHAR *chr(MS_SIZE n)
{
	MS_CHAR *ch = (char *)malloc(sizeof(char*));
	ch[1]       = '\0';
	memset(ch, n, 1);	   
   return(ch);
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_CLS )
{
	HB_TCHAR	*szText;
	HB_SIZE  nTextLen;
	HB_SIZE  nLen;
	MS_INT  	iRow;
	MS_INT  	iCol;
	MS_INT  	iMaxRow;
	MS_INT  	iMaxCol;	
	
	if(hb_parclen(2) == 0){
		szText   = chr(32);
		nTextLen = (HB_SIZE)strlen(szText);
		nLen     = (HB_SIZE)szText;
	}
	else{		
		szText   = hb_parc(2);
		nTextLen = hb_parclen(2);
		nLen     = hb_parclen(2);
	}
		
   long lDelay = hb_parnldef( 3, 0 );
   hb_gtSetPos(0 , 0);
	hb_gtGetPos(&iRow, &iCol);
	
   if(HB_ISNUM(3))
      iRow = 0; // hb_parni( 3 );
   
	if(HB_ISNUM(4))
      iCol = 0; // hb_parni( 4 );
   
	iMaxRow = hb_gtMaxRow();
   iMaxCol = hb_gtMaxCol();
   if( iRow >= 0 && iCol >= 0 && iRow <= iMaxRow && iCol <= iMaxCol )
   {
		MS_SIZE      iTop    = 0;
		MS_SIZE      iLeft   = 0;
		MS_SIZE      iBottom = iMaxRow;
		MS_SIZE      iRight  = iMaxCol;		
	   MS_SIZE      size    = (HB_SIZE)(((iBottom-iTop)+1) * ((iRight-iLeft)+1));
		MS_CHAR      *buffer = (MS_CHAR*)calloc(size, sizeof(buffer));
		PHB_CODEPAGE cdp     = hb_gtHostCP();			
      HB_SIZE      nIndex  = 0;
      MS_SIZE      iColor  = hb_parni(1); 
		HB_WCHAR     wc;
		
		if( iColor == 0)
			iColor = hb_gtGetCurrColor();

      if( nLen > ( HB_SIZE ) ( iMaxRow - iRow + 1 ) )
         nLen = ( HB_SIZE ) ( iMaxRow - iRow + 1 );

      hb_gtBeginWrite();
		
		for (MS_SIZE n=0; n<size;)
			for (HB_SIZE y=0; y<nTextLen; y++, n++){
				buffer[n] = szText[y];
				if( n == size)
					break;
			}
			buffer[size]='\0';   			
		nLen = size;
		
      while( nLen-- )
      {
			if( HB_CDPCHAR_GET( cdp, buffer, size, &nIndex, &wc ))
				hb_gtPutChar( iRow, iCol++, iColor, 0, wc );
         else
            break;

			if( iCol > iMaxCol){
				iCol = 0;
				iRow++;
			}
				
         if( lDelay )
         {
            hb_gtEndWrite();
            hb_idleSleep( ( double ) lDelay / 1000 );
            hb_gtBeginWrite();
         }
      }			
      hb_gtEndWrite();			
		free(buffer);
     }
	hb_retc_null();
}	

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_CHAR)
{	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE   hConsole       = GetStdHandle(STD_OUTPUT_HANDLE);		
	COORD    coordScreen    = {0, 0};
	WORD     BackColor      = (WORD)hb_parni(1);		 
	LPVOID   lpReservedvoid = NULL; 
	DWORD    nNumberOfCharsToWrite;
	DWORD    cCharsWritten;
	DWORD    dwWindowSize;
	MS_TCHAR *string; 
	MS_CHAR  *buffer;
	MS_INT   size;
	MS_INT   x;
	MS_ULINT lpNumberOfCharsWritten;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	dwWindowSize	= csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	string       	= hb_parc(2);
	x      		 	= hb_parclen(2);
	size   		 	= dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer  			= (MS_CHAR*)malloc(size);
	
	for (int n=0; n<=size;){
		for (int y=0; y<x; y++, n++){
			buffer[n] = string[y];
		}
	}
	buffer[size]          = '\0';
	nNumberOfCharsToWrite = size;		
	coordScreen.X 			 = 0;  // iTop
	coordScreen.Y 			 = 0;  // iBottom
	
	WriteConsole(hConsole, buffer, nNumberOfCharsToWrite, &lpNumberOfCharsWritten, lpReservedvoid);
	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwWindowSize, coordScreen, &cCharsWritten))
		return;
			
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;				
				 
	free(buffer);	
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_TEMP_CHAR)
{	
	HANDLE hConsole;                   
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	//CHAR_INFO chiBuffer;     
	COORD coordScreen = {0, 0};
	DWORD nNumberOfCharsToWrite;
	DWORD dwWindowSize;
	DWORD cCharsWritten;
	unsigned long int lpNumberOfCharsWritten;
	LPVOID  lpReservedvoid = NULL; 
	const char *string; 
	char *buffer;
	int size;
	int n;
	int x;
	int y;
	 
	WORD BackColor = (WORD)hb_parni(1);
	 
	dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	 
	string = hb_parc(2);
	x      = hb_parclen(2);
	size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer = (char*)malloc(size);
	for (n=0; n<=size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
	
	buffer[size]  				= '\0';
	nNumberOfCharsToWrite	= size;		
	coordScreen.X 				= 0;  // iTop
	coordScreen.Y 				= 0;  // iBottom
	WriteConsole(hConsole, buffer, nNumberOfCharsToWrite, &lpNumberOfCharsWritten, lpReservedvoid);  

	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwWindowSize, coordScreen, &cCharsWritten))
		return;			
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;		
				 
	cout << endl<< size << endl << lpNumberOfCharsWritten;
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_WRITECHAR)
{	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);	
	COORD 	coordScreen = {0, 0};
	DWORD 	dwWindowSize;
	MS_TCHAR *string; 
	MS_CHAR	*buffer;
	MS_INT 	size;
	MS_INT 	n;
	MS_INT	x;
	MS_INT 	y;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);	
	coordScreen.X 	= 0;  // iTop
	coordScreen.Y 	= 0;  // iBottom
	csbi.dwSize.X 	= 1;  // iLeft  - vezes a replicar o caractere
	csbi.dwSize.Y 	= 1;  // iRight - vezes a multiplicar o caractere acima	
	dwWindowSize 	= csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;	
	string 			= hb_parc(2);
	x      			= hb_parclen(2);
	size   			= dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer 			= (MS_CHAR*)malloc(size);
	
   for (n=0; n<=size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];			 
			 if( coordScreen.X < csbi.dwMaximumWindowSize.X){
					coordScreen.X++;  // iTop
			 }else{
				coordScreen.X = 0;  // iTop
			   coordScreen.Y++;  // iBottom			
			}
		 }
	}
 
	//chiBuffer.Char.AsciiChar = 176;	 
	//WriteConsoleOutput(hConsole, chiBuffer, coordBuffer, coordScreen, pWriteRegion);
	buffer[size]='\0';
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SAY )
{
	HANDLE hConsole;                   
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	//DWORD dwConSize;
	DWORD dwWindowSize;
	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	
	HB_TCHAR *string; 
	char       *buffer;
	int        size;
	int        n;
	int        x;
	int        y;
	//int iTop    = 0;
	//int iLeft   = 0;
	//int iBottom  = csbi.dwSize.Y;
	//int iRight   = csbi.dwSize.X;
	
	//dwConSize    = csbi.dwSize.X * csbi.dwSize.Y;
	dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
	
	//if(!FillConsoleOutputCharacter(hConsole, '²', dwConSize, coordScreen, &cCharsWritten))
	//   return;
	
	string = hb_parc(2);
	x      = hb_parclen(2);
	size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
	buffer = (char*)malloc(size);
	
   for (n=0; n<size;)
		 for (y=0; y<x; y++, n++)
		  {
			buffer[n] = string[y];
			if( n == size)
				break;
			 
		  }
	buffer[size]='\0';
	cout << buffer << flush;
	_xcolor_fundo((WORD)hb_parni(1));
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_CLEAR)
{
	MS_CHAR	*string 	= (char*) hb_parc(2);	
	MS_INT	x 			= strlen(string);
	MS_INT	iTop    	= 0;
	MS_INT 	iLeft   	= 0;
	MS_INT 	iBottom 	= hb_gtMaxRow();
	MS_INT	iRight  	= hb_gtMaxCol();	
	MS_INT	size 		= (MS_INT)(((iBottom-iTop)) * ((iRight-iLeft)));
	MS_CHAR	*buffer 	= (MS_CHAR*)malloc(size);	
	MS_INT	n;	
	MS_INT 	y;
		
	for (n=0; n<size;){
		for (y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
	buffer[size]	= '\0';
	_color(75);
	printf(buffer);
	free(buffer);
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

static bool hb_ctGetWinCord(MS_INT *piTop, MS_INT *piLeft, MS_INT *piBottom, MS_INT *piRight )
{
	MS_INT	iMaxRow	= hb_gtMaxRow();
	MS_INT 	iMaxCol 	= hb_gtMaxCol();

	//hb_gtGetPosEx(piTop, piLeft);
	hb_gtGetPos(piTop, piLeft);
	if(HB_ISNUM(1))
		*piTop = hb_parni(1);
		
	if(HB_ISNUM(2))
		*piLeft   = hb_parni(2);
		
	if( HB_ISNUM(3)){
		*piBottom = hb_parni(3) ;
		if(*piBottom > iMaxRow)
			*piBottom = iMaxRow;
	}
	else
		*piBottom = iMaxRow;
	
	if( HB_ISNUM(4))
	{
		*piRight = hb_parni(4);
		if( *piRight > iMaxCol )
			*piRight = iMaxCol;
	}
	else
		*piRight = iMaxCol;

	return *piTop  >= 0 && 
	       *piLeft >= 0 && 
	       *piTop  <= *piBottom && 
			 *piLeft <= *piRight;
}

/*-----------------------------------------------------------------------------------------------*/	

static void _color(MS_INT iNewColor)
{	
	MS_INT iTop		= 0;
	MS_INT iLeft   = 0;
	MS_INT iBottom	= hb_gtMaxRow();
	MS_INT iRight  = hb_gtMaxCol();
		
	if( hb_ctGetWinCord( &iTop, &iLeft, &iBottom, &iRight)){
		hb_gtBeginWrite();
		while(iTop <= iBottom){
			int iCol = iLeft;
			while( iCol <= iRight ){
				int iColor;
				HB_BYTE   bAttr;
				HB_USHORT usChar;
				hb_gtGetChar( iTop, iCol, &iColor, &bAttr, &usChar );
				hb_gtPutChar( iTop, iCol, iNewColor, bAttr, usChar );
				++iCol;
			}
			++iTop;
		}
		hb_gtEndWrite();
	}
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(FORX_C)
{
	MS_INT n;
	for( n=0; n <= 1000; ++n )
		printf("??");
}

/*-----------------------------------------------------------------------------------------------*/	

void _xcolor_fundo(WORD BackColor)
{
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE hConsole 	= GetStdHandle(STD_OUTPUT_HANDLE);    	 
	COORD coordScreen	= {0, 0};
	DWORD dwConSize;	
	DWORD cCharsWritten;
   
	GetConsoleScreenBufferInfo(hConsole, &csbi);
	//BackColor = 0x0001 | 0x0004;
		 
	// Get the number of character cells in the current buffer
	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;

	dwConSize              = csbi.dwSize.X * csbi.dwSize.Y;
		 
	//chifill.Attributes     = BACKGROUND_RED | FOREGROUND_INTENSITY;
	//chifill.Char.AsciiChar = (char)177;
		 
	// Fill the entire screen with blanks
	//if(!FillConsoleOutputCharacter(hConsole, '²', dwConSize, coordScreen, &cCharsWritten))
	//	  return;

	// Set the buffer's attributes accordingly.
	if(!FillConsoleOutputAttribute(hConsole, BackColor, dwConSize, coordScreen, &cCharsWritten))
		return;

	// SetConsoleTextAttribute(hConsole, BackColor);

	if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
		return;

	// Put the cursor at its home coordinates.
	SetConsoleCursorPosition(hConsole, coordScreen);
	return;
}
	
/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( CLEARSCREEN )
{
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
   HANDLE 	hConsole 	= GetStdHandle(STD_OUTPUT_HANDLE);		
   COORD  	coordHome	= {0 , 0 };
	MS_CHAR 	caractere 	= 32;
	DWORD 	dummy;
	COORD 	coordCursor;
   
	coordCursor.X 	= 0;
   coordCursor.Y 	= 0;	
	GetConsoleScreenBufferInfo(hConsole, &csbi);	
	FillConsoleOutputCharacter( hConsole, caractere, csbi.dwSize.X * csbi.dwSize.Y, coordHome, &dummy);

	if (! SetConsoleCursorPosition(hConsole, coordCursor)) 
    {
        MessageBox(NULL, TEXT("SetConsoleCursorPosition"), TEXT("Console Error"), MB_OK); 
        return;
    }
}						

/*-----------------------------------------------------------------------------------------------*/	
				  
HB_FUNC( MS_CLEARSCREEN)
{
	system("cls");
	hb_retc_null();
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXROW)
{	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);	
	DWORD 		dwMaxRow;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);			 
	dwMaxRow = csbi.dwMaximumWindowSize.Y;	
	hb_retni( dwMaxRow );
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC( MS_MAXCOL)
{	
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);
	DWORD 	dwMaxCol;		

	GetConsoleScreenBufferInfo(hConsole, &csbi);
	dwMaxCol = csbi.dwMaximumWindowSize.X;		
	hb_retni( dwMaxCol );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXBUFFERROW )
{	
	HANDLE	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 		
	COORD 	size 		= GetLargestConsoleWindowSize(hConsole);
	DWORD 	dwMaxRow;
		
	dwMaxRow = size.Y;
	hb_retni( dwMaxRow );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_MAXBUFFERCOL )
{	
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 	
	COORD 	size 		= GetLargestConsoleWindowSize(hConsole);
	DWORD dwMaxCol;
	
	dwMaxCol = size.X;
	hb_retni( dwMaxCol );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETBUFFER )
{
	CONSOLE_SCREEN_BUFFER_INFO csbi;    		
//	MS_SHORT x 			= hb_parni(1);
//	MS_SHORT y 			= hb_parni(2);
	HANDLE 	hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	COORD 	coordScreen;
	
	GetConsoleScreenBufferInfo(hConsole, &csbi);			 		
	coordScreen	= csbi.dwMaximumWindowSize;				
	hb_retl(SetConsoleScreenBufferSize(hConsole, coordScreen));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETCONSOLETITLE)
{		
	MS_TCHAR	*cTitulo = hb_parc(1);
	hb_retl(SetConsoleTitle(cTitulo));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(ISFILE)
{
	hb_retl(hb_fsFile(hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(NUMBERCURDRV)
{
	hb_retni(hb_fsCurDrv()); 
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC(FCHDIR)
{
	hb_retl(hb_fsChDir( hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	
	
HB_FUNC(MKDIR)
{
	hb_retl(hb_fsMkDir( hb_parc(1)));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MSG)
{
	MessageBox( GetActiveWindow(), hb_parc(1), hb_parc(2), 0 );
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(TELA)
{
   MS_TCHAR	*string  = hb_parc(2);;
   MS_INT	iTop     = 0;
   MS_INT	iLeft    = 0;   
   MS_INT 	iBottom  = ms_maxrow();
   MS_INT	iRight   = ms_maxcol();	
	MS_INT 	x        = hb_parclen(2);	
   MS_INT 	size     = (MS_INT)(((iBottom-iTop)) * ((iRight-iLeft)));
   MS_CHAR 	*buffer 	= (MS_CHAR*)calloc(size, sizeof(buffer));
	
   for (int n=0; n<size;){
		for (int y=0; y<x; y++, n++){
			buffer[n] = string[y];
			if( n == size)
				break;
		}
	}
   
	buffer[size]='\0';   
	hb_gtBeginWrite();
   cout << buffer << flush;
	cout << endl << iTop;
	cout << endl << iLeft;
	cout << endl << iBottom;
	cout << endl << iRight;
	cout << endl << len(buffer);
	cout << endl << size;
	hb_gtEndWrite();
	free(buffer);	
	hb_retc_null();
}	

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC( MS_SETCONSOLEDISPLAYMODE )
{	
	HB_SHORT Bottom     = hb_parni(1);	
	HB_SHORT Right      = hb_parni(2);
	HANDLE   hConsole   = GetStdHandle(STD_OUTPUT_HANDLE);    	 		
	COORD    ScreenSize = {Bottom, Right};		
		
	hb_retl(SetConsoleDisplayMode(hConsole, CONSOLE_FULLSCREEN_MODE, &ScreenSize));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_SETWINDOWSIZE)
{
	HANDLE		hConsole		= GetStdHandle(STD_OUTPUT_HANDLE);
	HB_SHORT		Top        	= hb_parni(1);	
	HB_SHORT   	Left       	= hb_parni(2);
	HB_SHORT   	Bottom     	= hb_parni(3);	
	HB_SHORT   	Right      	= hb_parni(4);	
	SMALL_RECT 	ScreenSize 	= {Left, Top, Right, Bottom};	

	if (hConsole == INVALID_HANDLE_VALUE){
		MessageBox(NULL, TEXT("GetStdHandle"), TEXT("Console Error"), MB_OK);
		hb_retl(0);		
	}
	hb_retl(SetConsoleWindowInfo(hConsole, true, &ScreenSize));
}

/*-----------------------------------------------------------------------------------------------*/	

HB_FUNC(MS_SETCONSOLE)
{
	HANDLE     hConsole	= GetStdHandle(STD_OUTPUT_HANDLE); 
	HB_SHORT   Bottom  	= hb_parni(1);	
	HB_SHORT   Right   	= hb_parni(2);	
	SMALL_RECT Rect;     
	COORD      coord;
	
	coord.X     = Right;
	coord.Y     = Bottom;
	Rect.Top    = 0; 
   Rect.Left   = 0; 
   Rect.Bottom = Bottom - 1; 
   Rect.Right  = Right  - 1; 	
	
	if (hConsole == INVALID_HANDLE_VALUE){
		MessageBox(NULL, TEXT("GetStdHandle"), TEXT("Console Error"), MB_OK);
		hb_retl(0);		
	}
	
	//Change the internal buffer size:
	SetConsoleScreenBufferSize(hConsole, coord);
	
	// Change the console window size:
	hb_retl(SetConsoleWindowInfo(hConsole, TRUE, &Rect));	
	//hb_retl(SetConsoleDisplayMode(hStdout,CONSOLE_FULLSCREEN_MODE, &c));
}

#line 872 "sciapi.prg"

	// synonymn for MS_* 
	HB_FUNC_TRANSLATE(TRIM,    	RTRIM)
	HB_FUNC_TRANSLATE(MS_TRIM,    RTRIM)
	HB_FUNC_TRANSLATE(MS_LTRIM,   LTRIM)
	HB_FUNC_TRANSLATE(MS_STRZERO, STRZERO)
	HB_FUNC_TRANSLATE(MS_LEN,     LEN)

	#include "hbapi.h"
	#include "hbapiitm.h"
	#include "hbapierr.h"
	
	HB_FUNC( STRZERO )
	{
		
		int iParams = hb_pcount();

		if( iParams >= 1 && iParams <= 3 )
		{
			PHB_ITEM pNumber = hb_param( 1, HB_IT_NUMERIC );
			PHB_ITEM pWidth  = NULL;
			PHB_ITEM pDec    = NULL;

			if( iParams >= 2 )
			{
				pWidth = hb_param( 2, HB_IT_NUMERIC );
				if( pWidth == NULL )
					pNumber = NULL;
				else if( iParams >= 3 )
				{
					pDec = hb_param( 3, HB_IT_NUMERIC );
					if( pDec == NULL )
						pNumber = NULL;
				}
			}

			if( pNumber )
			{
				char * szResult = hb_itemStr( pNumber, pWidth, pDec );

				if( szResult )
				{
					HB_SIZE nPos = 0;

					while( szResult[ nPos ] != '\0' && szResult[ nPos ] != '-' )
						nPos++;

					if( szResult[ nPos ] == '-' )
					{
						// NOTE: Negative sign found, put it to the first position 

						szResult[ nPos ] = ' ';

						nPos = 0;
						while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
							szResult[ nPos++ ] = '0';

						szResult[ 0 ] = '-';
					}
					else
					{
						// Negative sign not found 

						nPos = 0;
						while( szResult[ nPos ] != '\0' && szResult[ nPos ] == ' ' )
							szResult[ nPos++ ] = '0';
					}

					hb_retc_buffer( szResult );
				}
				else
					hb_retc_null();
			}
			else
	#ifdef HB_CLP_STRICT
				// NOTE: In CA-Cl*pper StrZero() is written in Clipper, and will call
				//			Str() to do the job, the error (if any) will also be thrown
				//			by Str().  [vszakats] 
				hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, "STR", HB_ERR_ARGS_BASEPARAMS );
	#else
				hb_errRT_BASE_SubstR( EG_ARG, 6003, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
	#endif
		}	
	
	}
	
	HB_FUNC( STR )
	{
		int iParams      		= hb_pcount();
		const char *string	= hb_parc(1);;
		PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
		PHB_ITEM pWidth  		= NULL;
		PHB_ITEM pDec    		= NULL;

		if( iParams >= 2 )
		{
			pWidth = hb_param( 2, HB_IT_NUMERIC );
			if( pWidth == NULL )
				pNumber = NULL;
			else if( iParams >= 3 )
			{
				pDec = hb_param( 3, HB_IT_NUMERIC );
				if( pDec == NULL )
					pNumber = NULL;
			}
		}

		if( pNumber )
		{
			char * szResult = hb_itemStr( pNumber, pWidth, pDec );

			if( szResult )
				hb_retc_buffer( szResult );
			else		   
				//hb_retc_null();
				hb_retc(string);
		}
		else
			//hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
				hb_retc(string);		
	}
		

	// trims from the left, and returns a new pointer to szText 
	// also returns the new length in lLen 
	const char * hb_strLTrim( const char * szText, HB_SIZE * nLen )
	{
		HB_TRACE( HB_TR_DEBUG, ( "hb_strLTrim(%s, %p)", szText, ( void * ) nLen ) );

		while( *nLen && HB_ISSPACE( *szText ) )
		{
			szText++;
			( *nLen )--;
		}

		return szText;
	}

	// return length of szText ignoring trailing white space (or true spaces) 
	HB_SIZE hb_strRTrimLen( const char * szText, HB_SIZE nLen, HB_BOOL bAnySpace )
	{
		HB_TRACE( HB_TR_DEBUG, ( "hb_strRTrimLen(%s, %lu. %d)", szText, nLen, ( int ) bAnySpace ) );

		if( bAnySpace )
		{
			while( nLen && HB_ISSPACE( szText[ nLen - 1 ] ) )
				nLen--;
		}
		else
		{
			while( nLen && szText[ nLen - 1 ] == ' ' )
				nLen--;
		}

		return nLen;
	}

	// trims leading spaces from a string 

	HB_FUNC( LTRIM )
	{
		PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

		if( pText )
		{
			HB_SIZE nLen;
			HB_SIZE nSrc;
			const char * szText;

			nLen   = hb_itemGetCLen( pText );
			nSrc   = hb_itemGetCLen( pText );
			szText = hb_strLTrim( hb_itemGetCPtr( pText ), &nLen );

			if( nLen == nSrc )
				hb_itemReturn( pText );
			else
				hb_retclen( szText, nLen );
		}
		else 
		{
			// NOTE: "TRIM" is correct here [vszakats] 
			// hb_errRT_BASE_SubstR( EG_ARG, 1100, NULL, "TRIM", HB_ERR_ARGS_BASEPARAMS );		
		
			int iParams      		= hb_pcount();
			const char *string	= hb_parc(1);;
			PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
			PHB_ITEM pWidth  		= NULL;
			PHB_ITEM pDec    		= NULL;

			if( iParams >= 2 )
			{
				pWidth = hb_param( 2, HB_IT_NUMERIC );
				if( pWidth == NULL )
					pNumber = NULL;
				else if( iParams >= 3 )
				{
					pDec = hb_param( 3, HB_IT_NUMERIC );
					if( pDec == NULL )
						pNumber = NULL;
				}
			}

			if( pNumber )
			{
				char * szResult = hb_itemStr( pNumber, pWidth, pDec );

				if( szResult )
					hb_retc_buffer( szResult );
				else		   
					//hb_retc_null();
					hb_retc(string);
			}
			else
				//hb_errRT_BASE_SubstR( EG_ARG, 1101, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
				hb_retc(string);				
		}
	}


	HB_FUNC( RTRIM )
	{
		PHB_ITEM pText   = hb_param( 1, HB_IT_STRING );
		
		if( pText )
		{
			HB_SIZE nLen, nSrc;
			const char * szText = hb_itemGetCPtr( pText );

			nSrc = hb_itemGetCLen( pText );
			nLen = hb_strRTrimLen( szText, nSrc, HB_FALSE );

			if( nLen == nSrc )
				hb_itemReturn( pText );
			else
				hb_retclen( szText, nLen );
		}
		else
		{
		
			if( HB_ISNUM(1))
			{
				// NOTE: "TRIM" is correct here [vszakats] 
				//hb_errRT_BASE_SubstR( EG_ARG, 1100, NULL, "TRIM", HB_ERR_ARGS_BASEPARAMS );		
				//hb_retni((HB_SIZE)pNumber);		

				int iParams      		= hb_pcount();
				const char *string	= hb_parc(1);;
				PHB_ITEM pNumber 		= hb_param( 1, HB_IT_NUMERIC );
				PHB_ITEM pWidth  		= NULL;
				PHB_ITEM pDec    		= NULL;

				if( iParams >= 2 )
				{
					pWidth = hb_param( 2, HB_IT_NUMERIC );
					if( pWidth == NULL )
						pNumber = NULL;
					else if( iParams >= 3 )
					{
						pDec = hb_param( 3, HB_IT_NUMERIC );
						if( pDec == NULL )
							pNumber = NULL;
					}
				}

				if( pNumber )
				{
					char * szResult = hb_itemStr( pNumber, pWidth, pDec );

					if( szResult )
						hb_retc_buffer( szResult );
					else		   
						//hb_retc_null();
						hb_retc(string);
				}
				else
					//hb_errRT_BASE_SubstR( EG_ARG, 1099, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
					hb_retc(string);				
			}
		}
	}


	// trims leading and trailing spaces from a string 
	// NOTE: The second parameter is a Harbour extension.

	HB_FUNC( ALLTRIM )
	{
		PHB_ITEM pText = hb_param( 1, HB_IT_STRING );

		if( pText )
		{
			HB_SIZE nLen, nSrc;
			const char * szText = hb_itemGetCPtr( pText );

			nSrc   = hb_itemGetCLen( pText );
			nLen   = hb_strRTrimLen( szText, nSrc, HB_FALSE );
			szText = hb_strLTrim( szText, &nLen );

			if( nLen == nSrc )
				hb_itemReturn( pText );
			else
				hb_retclen( szText, nLen );
		}
		else
	#ifdef HB_COMPAT_C53
			// NOTE: This runtime error appeared in CA-Cl*pper 5.3 [vszakats] 
	#ifdef HB_CLP_STRICT
			hb_errRT_BASE_SubstR( EG_ARG, 2022, NULL, HB_ERR_FUNCNAME, 0 );
	#else
			hb_errRT_BASE_SubstR( EG_ARG, 2022, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
	#endif
	#else
			hb_retc_null();
	#endif
	}

#include "hbapi.h"
#include "hbapierr.h"
#include "hbapiitm.h"
#include "hbapicdp.h"

HB_FUNC( LEN )
{
   PHB_ITEM pItem   	= hb_param(1, HB_IT_ANY);
	PHB_ITEM pWidth 	= NULL;
	PHB_ITEM	pDec 		= NULL;

   if(pItem){		
		if( HB_IS_NUMERIC(pItem)){						
			char *pText = hb_itemStr(pItem, pWidth, pDec);
			if( pText ){
				HB_SIZE nLen, nSrc, nret;
				const char *szText = hb_itemGetCPtr( pText );
				nSrc   = strlen( pText );								
				nLen   = hb_strRTrimLen( pText, nSrc, HB_FALSE );
				szText = hb_strLTrim( pText, &nLen );				
				nret 	 = strlen(szText);
				
				if(nret)
				  hb_retns(nret);
				else						
					hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
					//hb_retc_null();
				return;
			}			
		}
		
		if(pItem){
			if( HB_IS_STRING( pItem )){				
				HB_SIZE nLen = hb_itemGetCLen( pItem );
				PHB_CODEPAGE cdp = hb_vmCDP();
				if( HB_CDP_ISCHARIDX( cdp ) )
					nLen = hb_cdpTextLen( cdp, hb_itemGetCPtr( pItem ), nLen );
				hb_retns( nLen );
				return;
			}
			else if( HB_IS_ARRAY( pItem )){
				hb_retns( hb_arrayLen( pItem ) );
				return;
			}
			else if( HB_IS_HASH( pItem )){
				hb_retns( hb_hashLen( pItem ) );
				return;
			}
		}
   }
	//hb_retc_null();
   hb_errRT_BASE_SubstR( EG_ARG, 1111, NULL, HB_ERR_FUNCNAME, HB_ERR_ARGS_BASEPARAMS );
}

