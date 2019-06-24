#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <mem.h>
#include <errno.h>
#include <dos.h>
#include "dbapi.h"

/*man*************************************************************
NAME
	dbread

SYNOPSIS
	#include "dbapi.h"

	char *dbread(char *buf,dword recno,DBFFILE *dbf)

DESCRIPTION
	dbread reads a single record from dbase into buf. the record
	length is taken from file record, recno is 0-based, so the
	first record in the file is #0, second is #1 and so on.

DIAGNOSTICS
	returns buf if successful, NULL if fails.
*****************************************************************/
char *dbread(char *buf,dword recno,DBFFILE *dbf)
{
    long offset;
	offset=(recno*(dbf->reclen))+dbf->hdrlen;
	fseek(dbf->fp,offset,SEEK_SET);
	if (fread(buf,dbf->reclen,1,dbf->fp))
		return buf;
	return NULL;
}
