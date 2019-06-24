#include <fcntl.h>
#include <io.h>
#include <stdlib.h>
#include <mem.h>
#include <errno.h>
#include <dos.h>
#include "dbapi.h"

static char nullstr[20];

static DBFFILE *__create(char *fn,int ver,DBFFIELD *fields)
{
    DBFFILE *dbf;
    DBFFIELD *s;
    FILE *fp;
    int fh,nfields=0;
    struct date d;
        if (_chmod(fn,0)!=-1) {
                errno=EEXIST;
                return NULL;
        }
        fh=_creat(fn,0);
        if (fh==-1)
                return NULL;
        _close(fh);
        fh=_open(fn,O_BINARY|O_RDWR|O_DENYNONE);
        fp=fdopen(fh,"r+b");
        if (!fp)
                return NULL;
        dbf=malloc(sizeof(DBFFILE));
        if (dbf) {
                setmem(dbf,sizeof(DBFFILE),0);
                getdate(&d);
                s=fields;
                while (s) {
                        nfields++;
                        dbf->reclen+=s->f.len;
                        s=s->next;
                }
                dbf->reclen++;
                if (ver==2)
                        dbf->hdrlen=32*sizeof(DBF2FIELD)+sizeof(DBF2HEADER)+1;
                else
                        dbf->hdrlen=nfields*sizeof(DBF3FIELD)+sizeof(DBF3HEADER)+1;
                dbf->fp=fp;
                dbf->ver=(byte)ver;
                dbf->fields=fields;
                dbf->update.year=d.da_year%100;
                dbf->update.month=d.da_mon;
                dbf->update.day=d.da_day;
                fwrite(&dbf->ver,1,1,fp);
                if (ver==2) {
                        fwrite(&dbf->nrecords,2,1,fp);
                }
                fwrite(&dbf->update,3,1,fp);
                if (ver!=2) {
                        fwrite(&dbf->nrecords,4,1,fp);
                        fwrite(&dbf->hdrlen,2,1,fp);
                }
                fwrite(&dbf->reclen,2,1,fp);
                if (ver!=2) {
                        fwrite(nullstr,20,1,fp);
                }
                s=fields;
                while (s) {
                        fwrite(&s->f.name,11,1,fp);
                        fwrite(&s->f.type,1,1,fp);
                        if (ver!=2)
                                fwrite("\0",1,4,fp);
                        fwrite(&s->f.len,1,1,fp);
                        if (ver==2)
                                fwrite(nullstr,2,1,fp);
                        fwrite(&s->f.deccount,1,1,fp);
                        if (ver!=2)
                                fwrite(nullstr,14,1,fp);
                        s=s->next;
                }
                if (!fwrite("\r",1,1,fp)) {
                        dbfclose(dbf);
                        unlink(fn);
                        return NULL;
                }
                return dbf;
        }
        return NULL;
}

/*man****************************************************************
NAME
        dbfcreate

SYNOPSIS
        #include "dbapi.h"

        DBFFILE *dbfcreate(char *fn,int ver,DBFFIELD *fields)

DESCRIPTION
        dbfcreate creates a new dbase file. fn is a file name for
        database and ver is version number (2 or 3 are supported
        at the moment). fields is a list of field definitions
        built with dbaddfld.

DIAGNOSTICS
        dbfcreate will return opened dbase file pointer to newly
        created file if successful or NULL when create fails or
        the file already exists. In case of failure the field list 
        is disposed and becomes invalid.

SEE ALSO
        dbaddfld
********************************************************************/
DBFFILE *dbfcreate(char *fn,int ver,DBFFIELD *fields)
{
DBFFILE *dbf;
        dbf=__create(fn,ver,fields);
        if (!dbf)
                dbkillflds(fields);
        return dbf;
}
