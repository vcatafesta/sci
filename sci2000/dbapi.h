#ifndef __DBAPI_H__

#include <stdio.h>
#include <share.h>
#include <malloc.h>

/*
DBase file handling functions.

Copyright (C) 1994-1997 Madis Kaal <mast@forex.ee>

http://zerblatt.forex.ee/~mast
*/
#define byte unsigned char
#define word unsigned short
#define dword unsigned long

typedef struct {
	byte year;			/* binary year */
	byte month;			/* month */
	byte day;			/* and day */
} DBFHDATE;

typedef struct {
	byte version;		/* 0x03 for normal, 0x83 if with DBT */
	DBFHDATE update;	/* last update date */
	dword nrecords;		/* number of records in file */
	word hdrlen;		/* header structure length */
	word reclen;		/* record length */
	byte res[20];		/* reserved space, after that, field descriptors */
} DBF3HEADER;

/*
** Field descriptor array is terminated with 0x0d. If this marker is
** found as first name of field descriptor, the next byte is begin
** of first record in file.
*/
typedef struct {
	byte name[11];		/* ASCIIZ field name 10 chars max. */
	byte type;			/* C, N, L, D or M */
	dword faddress;
	byte len;			/* length of field */
	byte deccount;		/* decimal count */
	byte res[14];		/* reserved space */
} DBF3FIELD;

typedef struct {
	byte version;		/* 0x02 */
	word nrecords;		/* number of records in file */
	DBFHDATE update;	/* last update date */
	word reclen;		/* record length */
} DBF2HEADER;

typedef struct {
	byte name[11];		/* ASCIIZ field name 10 chars max. */
	byte type;			/* C, N or L */
	byte len;			/* length of field */
	byte res[2];		/* reserved space, used by DBase */
	byte deccount;		/* decimal count */
} DBF2FIELD;

/*
** All database records are preceeded with ' ' if field is not
** deleted and with '*' if field is deleted. This additional character
** is INCLUDED in record length in file header.
*/

typedef struct _dbffield {
	struct _dbffield *next;
	DBF3FIELD f;
} DBFFIELD;

typedef struct {
	FILE *fp;           /* FILE we used to get this header */
	int written;		/* NZ if file was changed... */
	byte ver;			/* version number from file */
	DBFHDATE update;	/* last update (from file) */
	dword nrecords;		/* number of records */
	word reclen;		/* record length */
	word nfields;		/* number of fields */
	word hdrlen;		/* length of header record */
	DBFFIELD *fields;
} DBFFILE;

/*
** The field contents are dependant of the type and their layout is:
**
** C  Character   Ascii characters
** N  Numeric     - . 0 1 2 3 4 5 6 7 8 9
** L  Logical     ? Y y N n T t F f (? means uninitialized)
** M  Memo        10 digits representing DBT block number
** D  Date        8 digits, representing YYYYMMDD
**
** Data fields are packed into records with no separators nor
** record terminators.
**
** A record, that has 0x1a as first character (after 'record deleted' byte)
** marks end of file (and must be present for full compatibility).
*/

typedef struct {
	long nextfree;				/* next free block */
	unsigned short unused;
	unsigned short blocksize;	/* memo block size */
	char crap[504];				/* filler up to 512 bytes */
} FPMEMOHEADER;

typedef struct {
	long datatype;				/* 1=memo, 0=picture */
	long memosize;				/* size of this memo */
	unsigned char memo[];		/* memo data begins here, can take */
} FPMEMOBLOCK;					/* several conseq. blocks */

typedef struct {
	FILE *fp;
	unsigned short blocksize;
} FPMEMOFILE;

#define dbapiwordswap(a) (((unsigned short)a<<8)|((unsigned short)a>>8))
#define dbapilongswap(a) ( (dbapiwordswap(((unsigned long)a<<16)))|(dbapiwordswap(((unsigned long)a>>16))) )

#ifdef __cplusplus
extern "C" {
#endif

extern DBFFILE *dbfcreate(char *fn,int ver,DBFFIELD *fields);
extern DBFFILE *dbfopen(char *fn);
extern void dbfclose(DBFFILE *dbf);
extern char *dbread(char *buf,dword recno,DBFFILE *dbf);
extern char *dbwrite(char *buf,dword recno,DBFFILE *dbf);
extern DBFFIELD *dbaddfld(DBFFIELD *base,char *name,int type,
	word len,int dec);
extern void dbkillflds(DBFFIELD *fields);

extern long fpmemofindblock(FPMEMOFILE *mf,long blockno);
extern FPMEMOFILE *fpmemoopen(char *fn);
extern void fpmemoclose(FPMEMOFILE *mf);

#ifdef __cplusplus
}
#endif

#define __DBAPI_H__
#endif
