/***
*io.h - declarations for low-level file handling and I/O functions
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file contains the function declarations for the low-level
*   file handling and I/O functions.
*
*******************************************************************************/


#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
#else /* extensions not enabled */
    #define _CDECL
#endif /* NO_EXT_KEYS */

/* function prototypes */

int far _CDECL access(char far *, int);
int far _CDECL chmod(char far *, int);
int far _CDECL chsize(int, long);
int far _CDECL close(int);
int far _CDECL creat(char far *, int);
int far _CDECL dup(int);
int far _CDECL dup2(int, int);
int far _CDECL eof(int);
long far _CDECL filelength(int);
int far _CDECL isatty(int);
int far _CDECL locking(int, int, long);
long far _CDECL lseek(int, long, int);
char far * far _CDECL mktemp(char far *);
int far _CDECL open(char far *, int, ...);
int far _CDECL read(int, char far *, unsigned int);
int far _CDECL remove(const char far *);
int far _CDECL rename(const char far *, const char far *);
int far _CDECL setmode(int, int);
int far _CDECL sopen(char far *, int, int, ...);
long far _CDECL tell(int);
int far _CDECL umask(int);
int far _CDECL unlink(const char far *);
int far _CDECL write(int, char far *, unsigned int);
