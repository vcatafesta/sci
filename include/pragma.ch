#pragma BEGINDUMP
	#include <hbapi.h>
	#include <hbapifs.h>
	#include <hbdefs.h>
	#include <hbapigt.h>
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
	//enum Range   { Max = 2147483648L, Min = 255L };
	enum Days    {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
	enum _color_ {c1 = 0x0003 };

	// C++11
	//enum Range   : LONG  { Max = 2147483648L, Min = 255L };
	//enum Days    : BYTE  {Domingo=1, Segunda, Terca, Quarta, Quinta, Sexta, Sabado};
	//enum _color_ : DWORD {c1 = 0x0003 };

	typedef const char   			HB_TCHAR;
	typedef unsigned const char   HB_UCCHAR;
	static void _color( int iNewColor);
	static bool hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
	void _xcolor_fundo(int BackColor);
	void ClearScreen(void);
		
	HANDLE  hConsole;                   
	COORD   coordScreen = {0, 0};
	HANDLE  hRunMutex;                  
	HANDLE  hScreenMutex;               
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	DWORD cCharsWritten;
   DWORD dwWindowSize;
	DWORD dwConSize;
	CHAR_INFO                  chiFill;
	TCOR					      	TColor;
	int     							ThreadNr;     
	WORD							 	Color = 0x0003 | 0x0004;

//********************************************************************************	
	HB_FUNC( MS_CLSVIL )
	{
	 	 hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		 GetConsoleScreenBufferInfo(hConsole, &csbi);
		 
		 dwConSize    = csbi.dwSize.X * csbi.dwSize.Y;
		 dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
		 
		 if(!FillConsoleOutputCharacter(hConsole, '�', dwConSize, coordScreen, &cCharsWritten))
		    return;
		 
		 _xcolor_fundo(hb_parni(1));
		 hb_retc_null();
	}
	
	
//********************************************************************************	
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
		 
		 //hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		 //GetConsoleScreenBufferInfo(hConsole, &csbi);
		 //int iBottom  = csbi.dwSize.Y;
		 //int iRight   = csbi.dwSize.X;
		 int iBottom = hb_gtMaxRow();
		 int iRight  = hb_gtMaxCol();
		 //dwConSize    = csbi.dwSize.X * csbi.dwSize.Y;
		 //dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
		 
		 //ClearScreen();
		 //if(!FillConsoleOutputCharacter(hConsole, '�', dwConSize, coordScreen, &cCharsWritten))
		 //   return;
		 
		 string = hb_parc(2);
		 x      = hb_parclen(2);
		 size   = (((iBottom-iTop)+1) * ((iRight-iLeft)+1)*2);
		 buffer = (char*)malloc(size * sizeof(char*));
		 
		 
       for (n=0; n<size;)
			 for (y=0; y<x; y++, n++)
			  {
				 buffer[n] = string[y];
			  }
		 buffer[size]='\0';
		 cout << buffer << flush;
		 //_xcolor_fundo(hb_parni(1));
		 free(buffer);
		 //hb_retc_null();
	}

//********************************************************************************	
	HB_FUNC( MS_CLEAR )
	{
		int iMaxRow = hb_gtMaxRow();
		int iMaxCol = hb_gtMaxCol();
		char *string = (char*) hb_parc(2);
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

//********************************************************************************	
	void _xcolor_fundo(int BackColor)
	{
		 //BackColor = 0x0001 | 0x0004;
		 
		 // Get the number of character cells in the current buffer
		 if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
			  return;

		 dwConSize              = csbi.dwSize.X * csbi.dwSize.Y;
		 
		 //chiFill.Attributes     = BACKGROUND_RED | FOREGROUND_INTENSITY;
		 //chiFill.Char.AsciiChar = (char)177;
		 
		 // Fill the entire screen with blanks
		 //if(!FillConsoleOutputCharacter(hConsole, ' ', dwConSize, coordScreen, &cCharsWritten))
			  //return;

		 // Set the buffer's attributes accordingly.
		 if(!FillConsoleOutputAttribute(hConsole, BackColor, dwConSize, coordScreen, &cCharsWritten))
			  return;

		 //if(BackColor != 99) // ***
			 // SetConsoleTextAttribute(hConsole, BACKGROUND_BLUE | BACKGROUND_GREEN | BACKGROUND_RED | BACKGROUND_INTENSITY);

		 // Get the current text attribute.
		 //if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
	//		  return;

		 // Put the cursor at its home coordinates.
		 SetConsoleCursorPosition(hConsole, coordScreen);
		 return;
	}
	
//********************************************************************************

void ClearScreen( void )
{
    DWORD    dummy;
    COORD    Home = { 0, 0 };
    FillConsoleOutputCharacter( hConsole, ' ', 
                                csbi.dwSize.X * csbi.dwSize.Y, 
                                Home, &dummy );
}										  

//********************************************************************************


	HB_FUNC(ISFILE)
	{
		hb_retl(hb_fsFile(hb_parc(1)));
	}

//********************************************************************************	
	// hb_fsCurDrv( void ) --> ( BYTE )cResult 
	HB_FUNC(NUMBERCURDRV)
	{
		hb_retni(hb_fsCurDrv()); 
	}
	
//********************************************************************************	
	// hb_fsChDir( BYTE * pszDirName ) --> ( BOOL )bResult 
	HB_FUNC(FCHDIR)
	{
		hb_retl(hb_fsChDir( hb_parc(1)));
	}
	
//********************************************************************************	
	//hb_fsMkDir( BYTE * pszDirName ) --> ( BOOL )bResult
	
	HB_FUNC(MKDIR)
	{
		hb_retl(hb_fsMkDir( hb_parc(1)));
	}
	
//*********************************************************************************	
	HB_FUNC(MSG)
	{
		MessageBox( GetActiveWindow(), hb_parc(1), hb_parc(2), 0 );
	}

//********************************************************************************	
	
#pragma ENDDUMP