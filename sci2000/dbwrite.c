#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <mem.h>
#include <errno.h>
#include <dos.h>
#include "dbapi.h"

/*man**************************************************************
NAME
	dbwrite

SYNOPSIS
	#include "dbapi.h"

	char *dbwrite(char *buf,dword recno,DBFFILE *dbf)

DESCRIPTION
	dbwrite writes a single record into file at specified record
	position. first record is 0.

DIAGNOSTICS
	returns buf if OK, NULL if fails.
******************************************************************/
char *dbwrite(char *buf,dword recno,DBFFILE *dbf)
{
long offset;
	offset=(recno*(dbf->reclen))+dbf->hdrlen;
	fseek(dbf->fp,offset,SEEK_SET);
	if (fwrite(buf,dbf->reclen,1,dbf->fp)) {
		dbf->written=1;
		if (dbf->nrecords<recno+1) {
			dbf->nrecords=recno+1;
			fwrite(" \0x1a",2,1,dbf->fp);
			fflush(dbf->fp);
		}
		return buf;
	}
	return NULL;
}
