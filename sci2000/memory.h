/***
*memory.h - declarations for buffer (memory) manipulation routines
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This include file contains the function declarations for the
*   buffer (memory) manipulation routines.
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

void far * far _CDECL memccpy(void far *, void far *, int, unsigned int);
void far * far _CDECL memchr(const void far *, int, size_t);
int far _CDECL memcmp(const void far *, const void far *, size_t);
void far * far _CDECL memcpy(void far *, const void far *, size_t);
int far _CDECL memicmp(void far *, void far *, unsigned int);
void far * far _CDECL memset(void far *, int, size_t);
void far _CDECL movedata(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);
