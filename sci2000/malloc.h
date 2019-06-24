/***
*malloc.h - declarations and definitions for memory allocation functions
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   Contains the function declarations for memory allocation functions;
*   also defines manifest constants and types used by the heap routines.
*   [System V]
*
*******************************************************************************/


#define _HEAPEMPTY      -1
#define _HEAPOK         -2
#define _HEAPBADBEGIN   -3
#define _HEAPBADNODE    -4
#define _HEAPEND        -5
#define _HEAPBADPTR     -6
#define _FREEENTRY      0
#define _USEDENTRY      1

#ifndef _SIZE_T_DEFINED
typedef unsigned int size_t;
#define _SIZE_T_DEFINED
#endif

#if (!defined(NO_EXT_KEYS))

#ifndef _HEAPINFO_DEFINED
typedef struct _heapinfo {
    int far * _pentry;
    size_t _size;
    int _useflag;
    } _HEAPINFO;
#define _HEAPINFO_DEFINED
#endif

#else   /* NO_EXT_KEYS */
#if (defined(M_I86CM) || defined(M_I86LM) || defined(M_I86HM))

#ifndef _HEAPINFO_DEFINED

typedef struct _heapinfo {
    int far * _pentry;
    size_t _size;
    int _useflag;
    } _HEAPINFO;

#define _HEAPINFO_DEFINED
#endif

#endif  /* M_I86CM || M_I86LM || M_I86HM */

#endif  /* NO_EXT_KEYS */


#if (defined(M_I86SM) || defined(M_I86MM))
#define _heapchk  _nheapchk
#define _heapset  _nheapset
#define _heapwalk _nheapwalk
#endif
#if (defined(M_I86CM) || defined(M_I86LM) || defined(M_I86HM))
#define _heapchk  _fheapchk
#define _heapset  _fheapset
#define _heapwalk _fheapwalk
#endif

#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
    #define _NEAR   near
#else /* extensions not enabled */
    #define _CDECL
    #define _NEAR
#endif /* NO_EXT_KEYS */


/* external variable declarations */
#ifdef DLL
extern unsigned far * cdecl far __amblksiz(void);
#define _amblksiz   *__amblksiz()
#else
extern unsigned int _NEAR _CDECL _amblksiz;
#endif

/* function prototypes */

void far * far _CDECL alloca(size_t);
void far * far _CDECL calloc(size_t, size_t);
void far * far _CDECL _expand(void far *, size_t);
int far _CDECL _fheapchk(void);
int far _CDECL _fheapset(unsigned int);
unsigned int far _CDECL _freect(size_t);
void far _CDECL free(void far *);
void far * far _CDECL malloc(size_t);
size_t far _CDECL _memavl(void);
size_t far _CDECL _memmax(void);
size_t far _CDECL _msize(void far *);
int far _CDECL _nheapchk(void);
int far _CDECL _nheapset(unsigned int);
void far * far _CDECL realloc(void far *, size_t);
void far * far _CDECL sbrk(int);
size_t far _CDECL stackavail(void);


#ifndef NO_EXT_KEYS /* extensions enabled */

void far cdecl _ffree(void far *);
void far * cdecl _fmalloc(size_t);
size_t far cdecl _fmsize(void far *);
#ifndef _QC
void huge * cdecl halloc(long, size_t);
void far cdecl hfree(void huge *);
#endif
void far cdecl _nfree(void near *);
void near * cdecl _nmalloc(size_t);
size_t far cdecl _nmsize(void near *);
int far cdecl _nheapwalk(struct _heapinfo far *);
int far cdecl _fheapwalk(struct _heapinfo far *);

#else
#if (defined(M_I86CM) || defined(M_I86LM) || defined(M_I86HM))

int far _nheapwalk(struct _heapinfo far *);
int far _fheapwalk(struct _heapinfo far *);

#endif  /* M_I86CM || M_I86LM || M_I86HM */

#endif /* NO_EXT_KEYS */
