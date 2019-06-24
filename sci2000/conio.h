/***
*conio.h - console and port I/O declarations
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This include file contains the function declarations for
*   the MS C V2.03 compatible console and port I/O routines.
*
*******************************************************************************/


#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
#else /* extensions not enabled */
    #define _CDECL
#endif /* NO_EXT_KEYS */

/* function prototypes */

char far * far _CDECL cgets(char far *);
int far _CDECL cprintf(char far *, ...);
int far _CDECL cputs(char far *);
int far _CDECL cscanf(char far *, ...);
int far _CDECL getch(void);
int far _CDECL getche(void);
int far _CDECL inp(unsigned int);
unsigned far _CDECL inpw(unsigned int);
int far _CDECL kbhit(void);
int far _CDECL outp(unsigned int, int);
unsigned far _CDECL outpw(unsigned int, unsigned int);
int far _CDECL putch(int);
int far _CDECL ungetch(int);

