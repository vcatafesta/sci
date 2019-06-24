#include <stdlib.h>
#include <mem.h>
#include <ctype.h>
#include "dbapi.h"

/*man******************************************************************
NAME
	dbaddfld

SYNOPSIS
	#include "dbapi.h"

	DBFFIELD *dbaddfld(DBFFIELD *base,char *name,
			int type,word len,int dec)

DESCRIPTION
	dbaddfld adds an entry into field list which can be used
	to create dbase file. base is a pointer to first entry in
	list, name is field name (max 10 chars) type is field type
	identifier ( 'C','N','L','D' or 'M') len is a field length
	and dec is number of decimal places for 'N' type.
	the field definitions will be used for newly created
	dbase file and will be automatically disposed when the
	file is closed.

DIAGNOSTICS
	returns pointer to newly created field definition if successful
	or NULL if runs out of memory (already existing entries, if any,
	are _not_ disposed)

EXAMPLE
	#include "dbapi.h"

	DBFFILE *createxxx(void)
	{
	DBFFILE *dbf=NULL;
	DBFFIELD *nfd;
	    nfd=dbaddfld(NULL,"ACCOUNT",'C',6,0);
	    if (nfd) {
	        dbaddfld(nfd,"CLIENT",'C',52,0);
	        dbaddfld(nfd,"PHONE",'C',20,0);
	        dbaddfld(nfd,"REGNUM",'C',11,0);
	        unlink("CLIENTS.DBF");
	        dbf=dbfcreate("CLIENTS.DBF",3,nfd);
	    }
	    return dbf;
	}
	
SEE ALSO
	dbfcreate
**********************************************************************/
DBFFIELD *dbaddfld(DBFFIELD *base,char *name,int type,word len,int dec)
{
int i;
DBFFIELD *fld;
	fld=malloc(sizeof(DBFFIELD));
	if (fld) {
		setmem(fld,sizeof(DBFFIELD),0);
		fld->f.type=(byte)type;
		fld->f.deccount=(byte)dec;
		fld->f.len=len;
		for (i=0;i<10;i++) {
			if (name[i]=='\0')
				break;
			fld->f.name[i]=toupper(name[i]);
		}
		if (base) {
			while (base->next)
				base=base->next;
			base->next=fld;
		}
		return fld;
	}
	return NULL;
}

/*man*************************************************************
NAME
	dbkillflds

SYNOPSIS
	#include "dbapi.h"

	void dbkillflds(DBFFIELD *f)

DESCRIPTION
	disposes the whole field list built with dbaddfld. normally
	not needed as dbfclose disposes the list automatically but
	could be used if dbaddfld fails.

SEE ALSO
	dbaddfld

*****************************************************************/
void dbkillflds(DBFFIELD *f)
{
	if (f) {
		if (f->next)
			dbkillflds(f->next);
		free(f);
	}
}
