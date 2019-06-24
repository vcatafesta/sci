/***
*stdlib.h - declarations/definitions for commonly used library functions
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This include file contains the function declarations for
*   commonly used library functions which either don't fit somewhere
*   else, or, like toupper/tolower, can't be declared in the normal
*   place (ctype.h in the case of toupper/tolower) for other reasons.
*   [ANSI]
*
*******************************************************************************/


#ifndef _SIZE_T_DEFINED
typedef unsigned int size_t;
#define _SIZE_T_DEFINED
#endif

#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
    #define _NEAR   near
#else /* extensions not enabled */
    #define _CDECL
    #define _NEAR
#endif /* NO_EXT_KEYS */


/* definition of the return type for the onexit() function */

#ifndef _ONEXIT_T_DEFINED
typedef int (far _CDECL * _CDECL onexit_t)();
#define _ONEXIT_T_DEFINED
#endif


/* Data structure definitions for div and ldiv runtimes. */

#ifndef _DIV_T_DEFINED

typedef struct {
    int quot;
    int rem;
} div_t;

typedef struct {
    long quot;
    long rem;
} ldiv_t;

#define _DIV_T_DEFINED
#endif

/* Maximum value that can be returned by the rand function. */

#define RAND_MAX 0x7fff


/* min and max macros */

#define max(a,b)    (((a) > (b)) ? (a) : (b))
#define min(a,b)    (((a) < (b)) ? (a) : (b))


/* sizes for buffers used by the _makepath() and _splitpath() functions.
 * note that the sizes include space for 0-terminator
 */

#define _MAX_PATH      144      /* max. length of full pathname */
#define _MAX_DRIVE   3      /* max. length of drive component */
#define _MAX_DIR       130      /* max. length of path component */
#define _MAX_FNAME   9      /* max. length of file name component */
#define _MAX_EXT     5      /* max. length of extension component */

/* external variable declarations */

extern unsigned far * cdecl far _errno(void);
extern unsigned far * cdecl far __doserrno(void);
#define errno       *_errno()
#define _doserrno   *__doserrno()
extern char * _NEAR _CDECL sys_errlist[];   /* perror error message table */
extern int _NEAR _CDECL sys_nerr;           /* # of entries in sys_errlist table */

extern char ** _NEAR _CDECL environ;        /* pointer to environment table */

extern unsigned int _NEAR _CDECL _psp;      /* Program Segment Prefix */

extern int _NEAR _CDECL _fmode;             /* default file translation mode */

/* DOS major/minor version numbers */

extern unsigned char _NEAR _CDECL _osmajor;
extern unsigned char _NEAR _CDECL _osminor;

#define DOS_MODE    0   /* Real Address Mode */
#define OS2_MODE    1   /* Protected Address Mode */

extern unsigned char _NEAR _CDECL _osmode;


/* function prototypes */

double far pascal atof(const char far *);
double far pascal strtod(const char far *, char far * far *);
ldiv_t far pascal ldiv(long, long);

void   far _CDECL abort(void);
int    far _CDECL abs(int);
int    far _CDECL atexit(void (_CDECL far *)(void));
int    far _CDECL atoi(const char far *);
long   far _CDECL atol(const char far *);
void far * far _CDECL bsearch(const void far *, const void far *, size_t, size_t, int (far _CDECL *)(const void far *, const void far *));
void far * far _CDECL calloc(size_t, size_t);
div_t  far _CDECL div(int, int);
char far * far _CDECL ecvt(double, int, int far *, int far *);
void   far _CDECL exit(int);
void   far _CDECL _exit(int);
char far * far _CDECL fcvt(double, int, int far *, int far *);
void   far _CDECL free(void far *);
char far * far _CDECL gcvt(double, int, char far *);
char far * far _CDECL getenv(const char far *);
char far * far _CDECL itoa(int, char far *, int);
long   far _CDECL labs(long);
unsigned long far _CDECL _lrotl(unsigned long, int);
unsigned long far _CDECL _lrotr(unsigned long, int);
char far * far _CDECL ltoa(long, char far *, int);
void   far _CDECL _makepath(char far *, char far *, char far *, char far *, char far *);
void far * far _CDECL malloc(size_t);
onexit_t far _CDECL onexit(onexit_t);
void   far _CDECL perror(const char far *);
int    far _CDECL putenv(char far *);
void   far _CDECL qsort(void far *, size_t, size_t, int (far _CDECL *)(const void far *, const void far *));
unsigned int far _CDECL _rotl(unsigned int, int);
unsigned int far _CDECL _rotr(unsigned int, int);
int    far _CDECL rand(void);
void far * far _CDECL realloc(void far *, size_t);
void   far _CDECL _searchenv(char far *, char far *, char far *);
void   far _CDECL _splitpath(char far *, char far *, char far *, char far *, char far *);
void   far _CDECL srand(unsigned int);
long   far _CDECL strtol(const char far *, char far * far *, int);
unsigned long far _CDECL strtoul(const char far *, char far * far *, int);
void   far _CDECL swab(char far *, char far *, int);
int    far _CDECL system(const char far *);
char far * far _CDECL ultoa(unsigned long, char far *, int);

#ifndef tolower         /* tolower has been undefined - use function */
int far _CDECL tolower(int);
#endif  /* tolower */

#ifndef toupper         /* toupper has been undefined - use function */
int    far _CDECL toupper(int);
#endif  /* toupper */
