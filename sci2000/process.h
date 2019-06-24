/***
*process.h - definition and declarations for process control functions
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file defines the modeflag values for spawnxx calls.  Only
*   P_WAIT and P_OVERLAY are currently implemented on DOS 2 & 3.
*   P_NOWAIT is also enabled on DOS 4.  Also contains the function
*   argument declarations for all process control related routines.
*
*******************************************************************************/


#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
    #define _NEAR   near
#else /* extensions not enabled */
    #define _CDECL
    #define _NEAR
#endif /* NO_EXT_KEYS */


/* modeflag values for spawnxx routines */

#define P_WAIT      0
#define P_NOWAIT    1
#define P_OVERLAY   2
#define OLD_P_OVERLAY  2
#define P_NOWAITO   3


/* Action Codes used with Cwait() */

#define WAIT_CHILD 0
#define WAIT_GRANDCHILD 1


/* function prototypes */

int far _CDECL _beginthread (void (_CDECL far *) (void far *), void far *, unsigned, void far *);
void far _CDECL _endthread(void);
void far _CDECL abort(void);
int far _CDECL cwait(int far *, int, int);
int far _CDECL execl(char far *, char far *, ...);
int far _CDECL execle(char far *, char far *, ...);
int far _CDECL execlp(char far *, char far *, ...);
int far _CDECL execlpe(char far *, char far *, ...);
int far _CDECL execv(char far *, char far * far *);
int far _CDECL execve(char far *, char far * far *, char far * far *);
int far _CDECL execvp(char far *, char far * far *);
int far _CDECL execvpe(char far *, char far * far *, char far * far *);
void far _CDECL exit(int);
void far _CDECL _exit(int);
int far _CDECL getpid(void);
int far _CDECL spawnl(int, char far *, char far *, ...);
int far _CDECL spawnle(int, char far *, char far *, ...);
int far _CDECL spawnlp(int, char far *, char far *, ...);
int far _CDECL spawnlpe(int, char far *, char far *, ...);
int far _CDECL spawnv(int, char far *, char far * far *);
int far _CDECL spawnve(int, char far *, char far * far *, char far * far *);
int far _CDECL spawnvp(int, char far *, char far * far *);
int far _CDECL spawnvpe(int, char far *, char far * far *, char far * far *);
int far _CDECL system(const char far *);
int far _CDECL wait(int far *);
