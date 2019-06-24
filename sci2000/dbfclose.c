#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <mem.h>
#include <errno.h>
#include <dos.h>
#include "dbapi.h"

/*man*************************************************************
NAME
	dbfclose

SYNOPSIS
	#include "dbapi.h"

	void dbfclose(DBFFILE *dbf)

DESCRIPTION
	closes dbase opened with dbfopen or created with dbfcreate.
	if dbfwrite has been used on the dbase then file header is
	updated as well.
*****************************************************************/
void dbfclose(DBFFILE *dbf)
{
struct date d;
	if (dbf->written) {
		getdate(&d);
		dbf->update.year=d.da_year%100;
		dbf->update.month=d.da_mon;
		dbf->update.day=d.da_day;
	}
	fseek(dbf->fp,1,SEEK_SET);
	if (dbf->ver==2) {
		fwrite(&dbf->nrecords,2,1,dbf->fp);
		fwrite(&dbf->update,3,1,dbf->fp);
	}
	else {
		fwrite(&dbf->update,3,1,dbf->fp);
		fwrite(&dbf->nrecords,4,1,dbf->fp);
	}
	fclose(dbf->fp);
	dbkillflds(dbf->fields);
	free(dbf);
}
