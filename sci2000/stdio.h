/***
*stdio.h - definitions/declarations for standard I/O routines
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file defines the structures, values, macros, and functions
*   used by the level 2 I/O ("standard I/O") routines.
*   [ANSI/System V]
*
*******************************************************************************/


#ifndef _SIZE_T_DEFINED
typedef unsigned int size_t;
#define _SIZE_T_DEFINED
#endif

#ifndef _VA_LIST_DEFINED
typedef char far *va_list;
#define _VA_LIST_DEFINED
#endif

#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
    #define _NEAR   near
#else /* extensions not enabled */
    #define _CDECL
    #define _NEAR
#endif /* NO_EXT_KEYS */


/* buffered I/O macros */

#define  BUFSIZ  512
#define  _NFILE  40
#define  EOF     (-1)

#ifndef _FILE_DEFINED
#define  FILE    struct _iobuf
#define _FILE_DEFINED
#endif

/* P_tmpnam: Directory where temporary files may be created.
 * L_tmpnam size =  size of P_tmpdir
 *      + 1 (in case P_tmpdir does not end in "\\")
 *      + 6 (for the temp number string)
 *      + 1 (for the null terminator)
 */

#define  P_tmpdir "\\"
#define  L_tmpnam sizeof(P_tmpdir)+8

#define  SEEK_CUR 1
#define  SEEK_END 2
#define  SEEK_SET 0

#define  SYS_OPEN 20
#define  TMP_MAX  32767


/* define NULL pointer value */

#if (defined(M_I86SM) || defined(M_I86MM))
#define  NULL    0
#elif (defined(M_I86CM) || defined(M_I86LM) || defined(M_I86HM))
#define  NULL    0L
#endif


/* define file control block */

#ifndef _IOB_DEFINED
extern FILE {
    char far *_ptr;
    int   _cnt;
    char far *_base;
    char  _flag;
    char  _file;
    } _NEAR _CDECL _iob[];
#define _IOB_DEFINED
#endif

#define  fpos_t  long   /* file position variable */

#ifdef DLL
FILE far * far _CDECL _stdin(void);
FILE far * far _CDECL _stdout(void);
FILE far * far _CDECL _stderr(void);
#define stdin   _stdin()
#define stdout  _stdout()
#define stderr  _stderr()
#else
#define  stdin  (&_iob[0])
#define  stdout (&_iob[1])
#define  stderr (&_iob[2])
#define  stdaux (&_iob[3])
#define  stdprn (&_iob[4])
#endif

#define  _IOREAD    0x01
#define  _IOWRT     0x02

#define  _IOFBF     0x0
#define  _IOLBF     0x40
#define  _IONBF     0x04

#define  _IOMYBUF   0x08
#define  _IOEOF     0x10
#define  _IOERR     0x20
#define  _IOSTRG    0x40
#define  _IORW      0x80

#define getc(f)         fgetc(f)
#define putc(c,f)       fputc(c,f)
#define getchar()       fgetchar()
#define putchar(c)      fputchar(c)

#define feof(f)         ((f)->_flag & _IOEOF)
#define ferror(f)       ((f)->_flag & _IOERR)
#define fileno(f)       ((f)->_file)


/* function prototypes */

int far _CDECL _filbuf(FILE far *);
int far _CDECL _flsbuf(int, FILE far *);
void far _CDECL clearerr(FILE far *);
int far _CDECL fclose(FILE far *);
int far _CDECL fcloseall(void);
FILE far * far _CDECL fdopen(int, char far *);
int far _CDECL fflush(FILE far *);
int far _CDECL fgetc(FILE far *);
int far _CDECL fgetchar(void);
int far _CDECL fgetpos(FILE far *, fpos_t far *);
char far * far _CDECL fgets(char far *, int, FILE far *);
int far _CDECL flushall(void);
FILE far * far _CDECL fopen(const char far *, const char far *);
int far _CDECL fprintf(FILE far *, const char far *, ...);
int far _CDECL fputc(int, FILE far *);
int far _CDECL fputchar(int);
int far _CDECL fputs(const char far *, FILE far *);
size_t far _CDECL fread(void far *, size_t, size_t, FILE far *);
FILE far * far _CDECL freopen(const char far *, const char far *, FILE far *);
int far _CDECL fscanf(FILE far *, const char far *, ...);
int far _CDECL fsetpos(FILE far *, const fpos_t far *);
int far _CDECL fseek(FILE far *, long, int);
long far _CDECL ftell(FILE far *);
size_t far _CDECL fwrite(const void far *, size_t, size_t, FILE far *);
char far * far _CDECL gets(char far *);
int far _CDECL getw(FILE far *);
void far _CDECL perror(const char far *);
int far _CDECL printf(const char far *, ...);
int far _CDECL puts(const char far *);
int far _CDECL putw(int, FILE far *);
int far _CDECL remove(const char far *);
int far _CDECL rename(const char far *, const char far *);
void far _CDECL rewind(FILE far *);
int far _CDECL rmtmp(void);
int far _CDECL scanf(const char far *, ...);
void far _CDECL setbuf(FILE far *, char far *);
int far _CDECL setvbuf(FILE far *, char far *, int, size_t);
int far _CDECL sprintf(char far *, const char far *, ...);
int far _CDECL sscanf(const char far *, const char far *, ...);
char far * _CDECL tempnam(char far *, char far *);
FILE far * far _CDECL tmpfile(void);
char far * far _CDECL tmpnam(char far *);
int far _CDECL ungetc(int, FILE far *);
int far _CDECL unlink(const char far *);
int far _CDECL vfprintf(FILE far *, const char far *, va_list);
int far _CDECL vprintf(const char far *, va_list);
int far _CDECL vsprintf(char far *, const char far *, va_list);

