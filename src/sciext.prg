
//cls
//SayCls(23, "**°±²VILMAR**", 0, 00, 00)
for x := 0 to 255   
	MS_Cls(x, "°±²")
	Qout( x )
	inkey(0.01)
	//inkey(5)
next	

//MS_Cls(15)
//cscreen := SaveScreen()
//inkey(0)
//cls
//inkey(0)
//restScreen(,,,, cScreen)
//inkey(0)

//MessageBox( NULL, "Parametro 1 incorrecto", "Atencion", MB_OK | MB_ICONINFORMATION | MB_SYSTEMMODAL )
//ms_writechar(31, "°±²VILMAR****")

//Qout( Ms_MaxRow())
//Qout( Ms_MaxCol())


#pragma BEGINDUMP
	#include <hbapi.h>
	#include <hbapifs.h>
	#include <hbdefs.h>
	#include <hbapigt.h>
	#include <iostream>
	#include <windows.h>
	#include <stdio.h>
	#include <conio.h>
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
	
	typedef const char   			HB_TCHAR;
	typedef unsigned const char   HB_UCCHAR;
	static void _color( int iNewColor);
	static bool hb_ctGetWinCord( int * piTop, int * piLeft, int * piBottom, int * piRight);
	void _xcolor_fundo(WORD BackColor);
	
		
	//HANDLE  hConsole;                   
	//COORD   coordScreen = {0, 0};
	//HANDLE  hRunMutex;                  
	//HANDLE  hScreenMutex;               
	//CONSOLE_SCREEN_BUFFER_INFO csbi;    
	//DWORD cCharsWritten;
   //DWORD dwWindowSize;
	//DWORD dwConSize;
	//CHAR_INFO                  chiFill;
	//TCOR					      	TColor;
	//int     							ThreadNr;     
	//WORD							 	Color = 0x0003 | 0x0004;

static int len( char *str)
{
    return((int)strlen(str));
}	
	
static int ms_maxrow(void)
	{	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		DWORD dwMaxRow;
		
		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
			 
		dwMaxRow = csbi.dwMaximumWindowSize.Y;
		
		return( dwMaxRow );
	}
	
	static int ms_maxcol(void)
	{	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		DWORD dwMaxCol;
		
		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
			 
		dwMaxCol = csbi.dwMaximumWindowSize.X;
		
		return( dwMaxCol );
	}
	
	
static char *replicate(char *str, int vezes)
//==========================================

{
   int lenstr = (int) strlen(str);
   int tam = lenstr * vezes;
   //char *ptr  = (char*)malloc(tam+1);
   char *ptr = (char*) malloc(tam * sizeof (char *));

   /*
   cout << "====================================" << endl;
   cout << "lenstr: " << lenstr << endl;
   cout << "tam   : " << tam << endl;
   cout << "str #1: " << str[0] <<endl;
   cout << "str #1: " << str[1] <<endl;
   cout << "str #1: " << str <<endl;
   cout << "str #2: " << (char*)str <<endl;
   cout << "ptr   : " << ptr <<endl;
   cout << "strlen ptr :" << strlen(ptr) <<endl;

    */

   int x;
   int y;
   for (x = 0; x < tam;)
      for (y = 0; y < lenstr; y++, x++) {
         ptr[x] = str[y];
      }
   return (ptr);
}

char *chr(int n)
//==============
{
   char *ch = (char *)malloc(sizeof(char*));
	ch[1]    = '\0';
	memset(ch, n, 1);	
   // sprintf(ch, "%c", (char) n);
   // sprintf(ch, "%c", n);
   return (ch);
}

//********************************************************************************	

HB_FUNC( MS_CLS )
{
	const char * szText;
	HB_SIZE nLen = hb_parclen(2);
   HB_SIZE nTextLen;
	
   if( nLen == 0 )
		{
			szText   = chr(32);
			nTextLen = (HB_SIZE) strlen(szText);
			nLen     = (HB_SIZE) szText;
		}
	else
		{		
			szText   = hb_parc( 2 );
			nTextLen = hb_parclen( 2 );
			nLen     = hb_parclen(2);
		}
	{
      int iRow, iCol, iMaxRow, iMaxCol;
      long lDelay = hb_parnldef( 3, 0 );

      hb_gtSetPos( 0 , 0 );
		hb_gtGetPos( &iRow, &iCol );
		
      if( HB_ISNUM( 3 ) )
         iRow = 0; // hb_parni( 3 );
      if( HB_ISNUM( 4 ) )
         iCol = 0; // hb_parni( 4 );
      iMaxRow = hb_gtMaxRow();
      iMaxCol = hb_gtMaxCol();
      if( iRow >= 0 && iCol >= 0 && iRow <= iMaxRow && iCol <= iMaxCol )
      {
			int iTop    = 0;
			int iLeft   = 0;
			int iBottom = iMaxRow;
			int iRight  = iMaxCol;
			
		   int size = (int)(((iBottom-iTop)+1) * ((iRight-iLeft)+1));
         //const char * szText = hb_parc( 2 );
         //HB_SIZE nTextLen = hb_parclen( 2 );
			char *buffer = (char*)calloc(size, sizeof(buffer));

         HB_WCHAR wc;
         PHB_CODEPAGE cdp = hb_gtHostCP();
         HB_SIZE nIndex = 0;

         int iColor = hb_parni(1); 
			if( iColor == 0)
				iColor = hb_gtGetCurrColor();

         if( nLen > ( HB_SIZE ) ( iMaxRow - iRow + 1 ) )
            nLen = ( HB_SIZE ) ( iMaxRow - iRow + 1 );

         hb_gtBeginWrite();
			
			for (int n=0; n<size;)
				for (HB_SIZE y=0; y<nTextLen; y++, n++)
					{
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
			//cout << nLen << endl;
			//cout << size << endl;
			//getch();
			
      }
   }

   hb_retc_null();
}	

//********************************************************************************	
	
	HB_FUNC( MS_CHAR)
	{	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		COORD coordScreen = {0, 0};
		DWORD nNumberOfCharsToWrite;
		DWORD cCharsWritten;
		DWORD dwWindowSize;
		//CHAR_INFO chiBuffer;     
		unsigned long int lpNumberOfCharsWritten;
		LPVOID lpReservedvoid = NULL; 
		WORD BackColor = (WORD)hb_parni(1);		 
		const char *string; 
		char *buffer;
		int size;
		int x;
		
		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
		dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
		//chiBuffer.Attributes     = BackColor ;
	   //chiBuffer.Char.AsciiChar = (char)177;
		
		//coordScreen.X = 0;   // iTop
		//coordScreen.Y = 0;   // iBottom
		//csbi.dwSize.X = 1;   // iLeft  - vezes a replicar o caractere
		//csbi.dwSize.Y = dwWindowSize;   // iRight - vezes a multiplicar o caractere acima
		 
		// int iTop    = coordScreen.X = 0; 
		// int iLeft   = coordScreen.Y = 0; 
		// int iRight  = csbi.dwMaximumWindowSize.X;
		// int iBottom = csbi.dwMaximumWindowSize.Y;
		
		string = hb_parc(2);
		x      = hb_parclen(2);
		size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
		buffer = (char*)malloc(size);
		
		for (int n=0; n<=size;){
			for (int y=0; y<x; y++, n++){
				buffer[n] = string[y];
			}
		}
		buffer[size]='\0';
		nNumberOfCharsToWrite = size;		
		coordScreen.X 			 = 0;  // iTop
		coordScreen.Y 			 = 0;  // iBottom
		WriteConsole(hConsole,
						 buffer, 
						 nNumberOfCharsToWrite, 
						 &lpNumberOfCharsWritten, 
						 lpReservedvoid );  
		
		//cout << buffer << flush;
		
		if(!FillConsoleOutputAttribute(hConsole, 
												 BackColor , 
												 dwWindowSize, 
												 coordScreen, 
												 &cCharsWritten))
			return;
				
		if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
			return;				
					 
		//cout << endl<< size << endl << lpNumberOfCharsWritten;
		//cout << replicate("-", iRight);
		//cout << "size:      :" <<size <<endl;
		//cout << "len(buffer):" <<(int)strlen(buffer) <<endl;
		//cout << iBottom <<endl;
		//cout << iRight <<endl;
		free(buffer);	
		hb_retc_null();
	}

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
		 //int iTop    = 0;
		 //int iLeft   = 0;
		 //int iBottom  = csbi.dwSize.Y;
		 //i/nt iRight   = csbi.dwSize.X;
		 WORD BackColor = (WORD)hb_parni(1);
		 
		 dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
		 //chiBuffer.Attributes     = BackColor ;
		 //chiBuffer.Char.AsciiChar = (char)177;
		// coordScreen.X = 0;   // iTop
		 //coordScreen.Y = 0;   // iBottom
		 //csbi.dwSize.X = 1;   // iLeft  - vezes a replicar o caractere
		 //csbi.dwSize.Y = dwWindowSize;   // iRight - vezes a multiplicar o caractere acima
		 
		 string = hb_parc(2);
		 x      = hb_parclen(2);
		 size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
		 buffer = (char*)malloc(size);
		 
		/*
		
		for (y=0; y<x; y++){
			chiBuffer.Char.AsciiChar = string[y];
			csbi.dwSize.X = x;     // iLeft  - vezes a replicar o caractere
			csbi.dwSize.Y = 100;   // iRight - vezes a multiplicar o caractere acima
			dwConSize     = csbi.dwSize.X * csbi.dwSize.Y;
			
			FillConsoleOutputCharacter(hConsole, chiBuffer.Char.AsciiChar, dwConSize, coordScreen, &cCharsWritten);
			//_getch();
			//Sleep(1000);
			coordScreen.X++;  // iTop
			coordScreen.Y += y;  // iBottom
			
		}
		*/
		
		for (n=0; n<=size;){
			for (y=0; y<x; y++, n++)
				{
				buffer[n] = string[y];
				if( n == size)
					break;
				
				//chiBuffer.Char.AsciiChar = string[y];
				//FillConsoleOutputCharacter(hConsole, chiBuffer.Char.AsciiChar, dwConSize, coordScreen, &cCharsWritten);
				 
				//if( coordScreen.X < csbi.dwMaximumWindowSize.X){
				//		coordScreen.X++;  // iTop
				//} else{
			//		coordScreen.X = 0;  // iTop
			//		coordScreen.Y++;  // iBottom
			//	}
			}
			  
		}
		
		buffer[size]='\0';
		nNumberOfCharsToWrite = size;		
		coordScreen.X = 0;  // iTop
		coordScreen.Y = 0;  // iBottom
		WriteConsole(hConsole,
						 buffer, 
						 nNumberOfCharsToWrite, 
						 &lpNumberOfCharsWritten, 
						 lpReservedvoid );  

		if(!FillConsoleOutputAttribute(hConsole, 
												 BackColor, 
												 dwWindowSize, 
												 coordScreen, 
												 &cCharsWritten))
			return;
				
		if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
			return;				
					 
		 cout << endl<< size << endl << lpNumberOfCharsWritten;
		 free(buffer);
		 hb_retc_null();
	}

//********************************************************************************		
	

HB_FUNC( MS_WRITECHAR)
	{	
		 HANDLE hConsole;                   
		 CONSOLE_SCREEN_BUFFER_INFO csbi;    
		 hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		 GetConsoleScreenBufferInfo(hConsole, &csbi);
		 //CHAR_INFO chiBuffer[160];    // [2][80];
		 COORD coordScreen = {0, 0};
		 //COORD coordBuffer = {24, 79};
		 DWORD dwWindowSize;
		 //PSMALL_RECT pWriteRegion;
		 
		 const char *string; 
		 char *buffer;
		 int size;
		 int n;
		 int x;
		 int y;
		 //int iTop    = 0;
		 //int iLeft   = 0;
		 //int iBottom  = csbi.dwSize.Y;
		 //int iRight   = csbi.dwSize.X;
		 
		 coordScreen.X = 0;  // iTop
		 coordScreen.Y = 0;  // iBottom
		 csbi.dwSize.X = 1;   // iLeft  - vezes a replicar o caractere
		 csbi.dwSize.Y = 1;   // iRight - vezes a multiplicar o caractere acima
		 
		 dwWindowSize = csbi.dwMaximumWindowSize.X * csbi.dwMaximumWindowSize.Y;
		 
		 string = hb_parc(2);
		 x      = hb_parclen(2);
		 size   = dwWindowSize; // (int)(((iBottom-iTop)) * ((iRight-iLeft)));
		 buffer = (char*)malloc(size);
		 
       for (n=0; n<=size;){
			 for (y=0; y<x; y++, n++)
			  {
				 buffer[n] = string[y];
				 
				 if( coordScreen.X < csbi.dwMaximumWindowSize.X){
						coordScreen.X++;  // iTop
				 } else{
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

	
//********************************************************************************	
	HB_FUNC( MS_SAY )
	{
  	 	 HANDLE hConsole;                   
		 CONSOLE_SCREEN_BUFFER_INFO csbi;    
		 //DWORD dwConSize;
		 DWORD dwWindowSize;
		 hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		 GetConsoleScreenBufferInfo(hConsole, &csbi);
	
	 	 const char *string; 
		 char *buffer;
		 int size;
		 int n;
		 int x;
		 int y;
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

//********************************************************************************	
	HB_FUNC( MS_CLEAR )
	{
		char *string = (char*) hb_parc(2);
		char *buffer;
		int size;
		int n;
		int x = strlen(string);
		int y;
		int iTop    = 0;
		int iLeft   = 0;
		int iBottom = hb_gtMaxRow();
		int iRight  = hb_gtMaxCol();
		
		size   = (int)(((iBottom-iTop)) * ((iRight-iLeft)));
		buffer = (char*)malloc(size);
		
		for (n=0; n<size;)
		{
			for (y=0; y<x; y++, n++)
			{
				buffer[n] = string[y];
				if( n == size)
					break;
			}
		}
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
	void _xcolor_fundo(WORD BackColor)
	{
	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		DWORD dwConSize;
		COORD coordScreen = {0, 0};
		DWORD cCharsWritten;
   	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
		 //BackColor = 0x0001 | 0x0004;
		 
		 // Get the number of character cells in the current buffer
		 if(!GetConsoleScreenBufferInfo(hConsole, &csbi))
			  return;

		 dwConSize              = csbi.dwSize.X * csbi.dwSize.Y;
		 
		 //chiFill.Attributes     = BACKGROUND_RED | FOREGROUND_INTENSITY;
		 //chiFill.Char.AsciiChar = (char)177;
		 
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
	
//********************************************************************************

HB_FUNC( CLEARSCREEN )
{
   HANDLE hConsole;                   
	CONSOLE_SCREEN_BUFFER_INFO csbi;    
	hConsole    = GetStdHandle(STD_OUTPUT_HANDLE);    	 
	GetConsoleScreenBufferInfo(hConsole, &csbi);
   DWORD    dummy;
   COORD    Home = { 0, 0 };
   FillConsoleOutputCharacter( hConsole, ' ', 
                                csbi.dwSize.X * csbi.dwSize.Y, 
                                Home, &dummy );
}										  

HB_FUNC( MS_MAXROW)
	{	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		DWORD dwMaxRow;
		
		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
			 
		dwMaxRow = csbi.dwMaximumWindowSize.Y;
		
		hb_retni( dwMaxRow );
	}
	
	HB_FUNC( MS_MAXCOL)
	{	
		HANDLE hConsole;                   
		CONSOLE_SCREEN_BUFFER_INFO csbi;    
		DWORD dwMaxCol;
		
		hConsole = GetStdHandle(STD_OUTPUT_HANDLE);    	 
		GetConsoleScreenBufferInfo(hConsole, &csbi);
			 
		dwMaxCol = csbi.dwMaximumWindowSize.X;
		
		hb_retni( dwMaxCol );
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

HB_FUNC( TELA )
{
   const char *string;
   int iTop     = 0;
   int iLeft    = 0;   
   int iBottom  = ms_maxrow();
   int iRight   = ms_maxcol();
	string       = hb_parc(2);
	int x        = hb_parclen(2);
   int size     = (int)(((iBottom-iTop)) * ((iRight-iLeft)));
   //buffer       = (char*)malloc(size);
	char *buffer = (char*)calloc(size, sizeof(buffer));
	
   for (int n=0; n<size;)
		for (int y=0; y<x; y++, n++)
			{
				buffer[n] = string[y];
				if( n == size)
					break;
			}
   buffer[size]='\0';   
	//printf("%s", buffer);
	hb_gtBeginWrite();
   cout << buffer << flush;
	//cout << endl << replicate("=", iRight+1);
	cout << endl << iTop;
	cout << endl << iLeft;
	cout << endl << iBottom;
	cout << endl << iRight;
	cout << endl << len(buffer);
	cout << endl << size;
	
	//cout << replicate("-", iRight);
	//cout << "size:      :" <<size <<endl;
	//cout << "len(buffer):" <<len(buffer) <<endl;
	//cout << iBottom <<endl;
	//cout << iRight <<endl;	
	hb_gtEndWrite();
	free (buffer);
	
	hb_retc_null();
}	

#pragma ENDDUMP

