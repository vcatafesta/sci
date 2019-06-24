/***
*search.h - declarations for searcing/sorting routines
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file contains the declarations for the sorting and
*   searching routines.
*   [System V]
*
*******************************************************************************/


#ifndef _SIZE_T_DEFINED
typedef unsigned int size_t;
#define _SIZE_T_DEFINED
#endif

#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
#else /* extensions not enabled */
    #define _CDECL
#endif /* NO_EXT_KEYS */


/* function prototypes */

char far * far _CDECL lsearch(char far *, char far *, unsigned int far *, unsigned int, int (far _CDECL *)(void far *, void far *));
char far * far _CDECL lfind(char far *, char far *, unsigned int far *, unsigned int, int (far _CDECL *)(void far *, void far *));
void far * far _CDECL bsearch(const void far *, const void far *, size_t, size_t, int (far _CDECL *)(const void far *, const void far *));
void far _CDECL qsort(void far *, size_t, size_t, int (far _CDECL *)(const void far *, const void far *));
