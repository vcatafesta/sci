/***
*string.h - declarations for string manipulation functions
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file contains the function declarations for the string
*   manipulation functions.
*   [ANSI/System V]
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
int far _CDECL memicmp(void far *, void far *, unsigned int);
void far * far _CDECL memcpy(void far *, const void far *, size_t);
void far * far _CDECL memmove(void far *, const void far *, size_t);
void far * far _CDECL memset(void far *, int, size_t);
void far _CDECL movedata(unsigned int, unsigned int, unsigned int, unsigned int, unsigned int);

char far * far _CDECL strcat(char far *, const char far *);
char far * far _CDECL strchr(const char far *, int);
int far _CDECL strcmp(const char far *, const char far *);
int far _CDECL strcmpi(const char far *, const char far *);
int far _CDECL stricmp(const char far *, const char far *);
char far * far _CDECL strcpy(char far *, const char far *);
size_t far _CDECL strcspn(const char far *, const char far *);
char far * far _CDECL strdup(const char far *);
char far * far _CDECL _strerror(char far *);
char far * far _CDECL strerror(int);
size_t far _CDECL strlen(const char far *);
char far * far _CDECL strlwr(char far *);
char far * far _CDECL strncat(char far *, const char far *, size_t);
int far _CDECL strncmp(const char far *, const char far *, size_t);
int far _CDECL strnicmp(const char far *, const char far *, size_t);
char far * far _CDECL strncpy(char far *, const char far *, size_t);
char far * far _CDECL strnset(char far *, int, size_t);
char far * far _CDECL strpbrk(const char far *, const char far *);
char far * far _CDECL strrchr(const char far *, int);
char far * far _CDECL strrev(char far *);
char far * far _CDECL strset(char far *, int);
size_t far _CDECL strspn(const char far *, const char far *);
char far * far _CDECL strstr(const char far *, const char far *);
char far * far _CDECL strtok(char far *, const char far *);
char far * far _CDECL strupr(char far *);
