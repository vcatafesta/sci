#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <mem.h>
#include <errno.h>
#include <dos.h>
#include "dbapi.h"

/*man******************************************************************
NAME
	dbfopen

SYNOPSIS
	#include "dbapi.h"

	DBFFILE *dbfopen(char *fn)

DESCRIPTION
	dbfopen opens an existing dbase file, automatically handling
	both version2 and version3 files.

DIAGNOSTICS
	pointer to opened file is returned if everything's ok, NULL
	if something goes wrong.
**********************************************************************/
DBFFILE *dbfopen(char *fn)
{
int fh;
FILE *fp;
DBFFILE *dbf;
DBFFIELD *fld,*ofld=NULL;
char c;
	fh=_open(fn,O_BINARY|O_RDWR|O_DENYNONE);
	if (fh) {
		fp=fdopen(fh,"r+b");
		if (fp) {
			dbf=malloc(sizeof(DBFFILE));
			if (dbf) {
				setmem(dbf,sizeof(DBFFILE),0);
				dbf->fp=fp;
				dbf->ver=getc(fp);
				switch (dbf->ver) {
					default:
						fread(&dbf->update,3,1,fp);
						fread(&dbf->nrecords,4,1,fp);
						fseek(fp,2,SEEK_CUR);
						fh=fread(&dbf->reclen,2,1,fp);
						if (fh)
							fseek(fp,20,SEEK_CUR);
						break;
					case 2:
						fread(&dbf->nrecords,2,1,fp);
						fread(&dbf->update,3,1,fp);
						fh=fread(&dbf->reclen,2,1,fp);
						break;
				}
				if (fh) {
				/* read descriptors now... */
					while (1) {
						if (fread(&c,1,1,fp)) {
							if (c!=0x0d) {
								fld=malloc(sizeof(DBFFIELD));
								if (fld) {
									dbf->nfields++;
									setmem(fld,sizeof(DBFFIELD),0);
									*fld->f.name=c;
									fread(&fld->f.name[1],10,1,fp);
									fread(&fld->f.type,1,1,fp);
									if (dbf->ver!=2)
										fseek(fp,4,SEEK_CUR);
									fread(&fld->f.len,1,1,fp);
									if (dbf->ver==2)
										fseek(fp,2,SEEK_CUR);
									fread(&fld->f.deccount,1,1,fp);
									if (dbf->ver!=2)
										fseek(fp,14,SEEK_CUR);
									if (ofld) {
										ofld->next=fld;
										ofld=fld;
									}
									else {
										ofld=dbf->fields=fld;
									}
								}
								else {
									dbfclose(dbf);
									errno=ENOMEM;
									return NULL;
								}
							}
							else {
								dbf->hdrlen=(word)ftell(fp);
								return dbf;
							}
						}
						else {
							dbfclose(dbf);
							errno=EBADF;
							return NULL;
						}
					}
				}
				else {
					dbfclose(dbf);
					errno=EBADF;
					return NULL;
				}
			}
			else
				fclose(fp);
		}
		else
			_close(fh);
	}
	return NULL;
}
