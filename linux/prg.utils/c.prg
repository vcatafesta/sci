#require "gtwvg"
#require "hbwin"
#require "hbxpp"
#require "hbct"
#require "hbgt"
#require "hbnf"


#include "HBclass.ch"
#include "Box.Ch"
#include "inkey.Ch"
#include <common.ch>
#include "box.ch"
#include "setcurs.ch"
#include "box.ch"
#include "setcurs.ch"
#include "inkey.ch"
#include "dbinfo.ch"
#include "hbsix.ch"
#include "hbgtinfo.ch"
#include "wvgparts.ch"
#include "translate.ch"
#Include "FileIO.Ch"
#Include "Directry.ChF"
#include "error.ch"
#Include "libsci.prg"

#define C_NAME   1
#define C_CLR    2
#define C_TYPE   3
#define C_CHAR   4

#xtranslate Single( <t>, <l>, <b>, <r> )      => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_SINGLE_UNI )
#xtranslate Double( <t>, <l>, <b>, <r> )      => hb_DispBox( <t>, <l>, <b>, <r>, HB_B_DOUBLE_UNI )
#xtranslate BkGrnd( <t>, <l>, <b>, <r>, <c> ) => hb_DispBox( <t>, <l>, <b>, <r>, Replicate( <c>, 9 ) )

#command DEFAULT <variable1> TO <value1> [, <variableN> TO <valueN> ] => ;
      if < variable1 > == NIL; < variable1 > := < value1 > ; END;
      [; if <variableN> == NIL; <variableN> := <valueN>; END ]

#command DEFAU <variable1> TO <value1> [, <variableN> TO <valueN> ] => ;
      if < variable1 > == NIL; < variable1 > := < value1 > ; END;
      [; if <variableN> == NIL; <variableN> := <valueN>; END ]

REQUEST HB_CODEPAGE_PT850
REQUEST HB_CODEPAGE_PTISO
REQUEST HB_CODEPAGE_PT860
REQUEST HB_CODEPAGE_UTF8

REQUEST HB_LANG_PT_BR
REQUEST HB_LANG_PT

Function main()
	hb_langSelect( "pt_br" )       // Default language is now Portuguese
	hb_cdpSelect( "PT860" )
	hb_langSelect( "pt_br" )       // Default language is now Portuguese

	//CDoW( Date() )            // Segunda-feira
	//"Current language is", hb_langName()      
	//? hb_cdpSelect( "PT850" )
	//ms_cls("???TESTE??")
	//setcolor("W+/r")
	//? hb_UTF8ToStr(hb_StrToUTF8("???"))
	//? hb_Translate("???", "PT850", "UTF8")
	//? hb_Translate(hb_Translate("???", "PT850", "UTF8"), "UTF8", "PT850")
	//charwin(00,00,MaxRow(),MaxCol(),hb_Translate(chr(176), "PT850", "UTF8"), 31)
	//tela("V?I?L?M?A?R??C?A?T?A?F?E?S?T?A????????????????????????")
	//ColorWin(0, 0, 33, 80, 31)

	
	cls
	for i = 1 to 252
		cnome := Space(10)
		ms_cls("???", i)
		ms_tela("?",  i)
		@       0, 0 say replicate("?",  MaxCol())
		@ maxRow(), 0 say replicate("?", MaxCol())
		@ 00, 10 Say i
		// @ 10, 10 Say "Nome :" get cNome
		// read
		inkey(0)
	next	

/*
FOR nX = 1 to MaxRow()
         FOR nY = 1 to MaxCol()
            FT_WRTCHR( nX, nY, " ", (nX - 1)c+(nY * 16) )
         NEXT
      NEXT
*/
		
#pragma BEGINDUMP
#include "hbdefs.h"
#include "hbapi.h"
#include "hbapigt.h"
#include <iostream>
#include <windows.h>
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
enum Range   { Max = 2147483648L, Min = 255L };
enum Days    {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
enum _color_ {c1 = 0x0003 };

// C++11
//enum Range   : LONG  { Max = 2147483648L, Min = 255L };
//enum Days    : BYTE  {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
//enum _color_ : DWORD {c1 = 0x0003 };

typedef const char   			HB_TCHAR;
typedef unsigned const char   HB_UCCHAR;
static void 						_color( int iNewColor);
static bool 						hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
void 									_xcolor_fundo(int BackColor);

HB_FUNC( MS_CLS )
{
	 const char *string; 
    char *buffer;
    int size;
    int n;
    int x;
    int y;
    int iTop    = 0;
    int iLeft   = 0;
	 int iBottom = hb_gtMaxRow();
    int iRight  = hb_gtMaxCol();
	 
	 string = hb_parc(1);
    x      = hb_parclen(1);
    size   = (((iBottom-iTop)+1) * ((iRight-iLeft)+1)*2);
	 buffer = (char*)malloc(size * sizeof(char*));

    for (n=0; n<size;)
       for (y=0; y<x; y++, n++)
        {
          buffer[n] = string[y];
        }
    buffer[size]='\0';
    cout <<buffer <<flush;
    free (buffer);
	 _xcolor_fundo(hb_parni(2));
	 hb_retc_null();
}

HB_FUNC( MS_TELA )
{
	int iMaxRow = hb_gtMaxRow();
   int iMaxCol = hb_gtMaxCol();
   char *string = (char*) hb_parc(1);
	char *buffer;
   int size;
	int n;
	int x = strlen(string);
	int y;

   size   = (((iMaxRow-0)+1) * ((iMaxCol-0)+1)*2);
	buffer = (char*)malloc(size * sizeof(char*));
	
	for (n=0; n<size;)
		for (y=0; y<x; y++, n++)
			buffer[n] = string[y];
		
  buffer[size]='\0';
  _color(75);
  printf(buffer);
  free (buffer);
  hb_retc_null();
}

static bool hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight )
{
   int iMaxRow = hb_gtMaxRow();
   int iMaxCol = hb_gtMaxCol();

   hb_gtGetPosEx( piTop, piLeft );

   if( HB_ISNUM( 1 ) )
      *piTop = hb_parni( 1 );
   if( HB_ISNUM( 2 ) )
      *piLeft   = hb_parni( 2 );
   if( HB_ISNUM( 3 ) )
   {
      *piBottom = hb_parni( 3 );
      if( *piBottom > iMaxRow )
         *piBottom = iMaxRow;
   }
   else
      *piBottom = iMaxRow;
   if( HB_ISNUM( 4 ) )
   {
      *piRight = hb_parni( 4 );
      if( *piRight > iMaxCol )
         *piRight = iMaxCol;
   }
   else
      *piRight = iMaxCol;

   return *piTop >= 0 && *piLeft >= 0 &&
          *piTop <= *piBottom && *piLeft <= *piRight;
}

static void _color( int iNewColor)
{	
	int iTop    = 0;
   int iLeft   = 0;
	int iBottom = hb_gtMaxRow();
   int iRight  = hb_gtMaxCol();
	
	if( hb_ctGetWinCord( &iTop, &iLeft, &iBottom, &iRight ) )
   {
      hb_gtBeginWrite();
      while( iTop <= iBottom )
      {
         int iCol = iLeft;
         while( iCol <= iRight )
         {
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

HB_FUNC( FORX_C )
{
   int n;
	for( n=0; n <= 1000; ++n )
      printf("??");
 
}

void _xcolor_fundo(int BackColor)
{
    // home for the cursor
    HANDLE hConsole     = GetStdHandle(STD_OUTPUT_HANDLE);
    COORD coordScreen   = {0, 0};
    DWORD               cCharsWritten;
    CONSOLE_SCREEN_BUFFER_INFO csbi;
    DWORD                      dwConSize;
	 //CHAR_INFO                  chifill;
    //TCOR					      	TColor;
	 //WORD							 	Color = 0x0003 | 0x0004;
	 //BackColor = 0x0001 | 0x0004;
	 
    // Get the number of character cells in the current buffer
    if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
        return;

    dwConSize              = csbi.dwSize.X * csbi.dwSize.Y;
    //chifill.Attributes     = BACKGROUND_RED | FOREGROUND_INTENSITY;
    //chifill.Char.AsciiChar = (char)177;
	 
    // Fill the entire screen with blanks
    //if(!FillConsoleOutputCharacter(hConsole, chifill.Char.AsciiChar, dwConSize, coordScreen, &cCharsWritten))
      //  return;

    // Set the buffer's attributes accordingly.
    if(!FillConsoleOutputAttribute(hConsole, BackColor, dwConSize, coordScreen, &cCharsWritten))
        return;

    //if(BackColor != 99) // ***
       // SetConsoleTextAttribute(hConsole, BACKGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_RED | BACKGROUND_INTENSITY);

    // Get the current text attribute.
    if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
        return;

    // Put the cursor at its home coordinates.
    // SetConsoleCursorPosition(hConsole, coordScreen);
}

#pragma ENDDUMP