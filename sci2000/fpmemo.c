#include "dbapi.h"

/*man*************************************************************
NAME
	fpmemoopen - open a foxpro memo file

SYNOPSIS
	#include "dbapi.h"

	FPMEMOFILE *fpmemoopen(char *fn);

DESCRIPTION
	opens a foxpro memo file for read/write and retrieves a block
	size for later offset calculations.
*****************************************************************/
FPMEMOFILE *fpmemoopen(char *fn)
{
FILE *fp;
FPMEMOFILE *mf;
FPMEMOHEADER hd;
	fp=_fsopen(fn,"r+b",SH_DENYNONE);
	if (fp) {
		if (fread(&hd,sizeof hd,1,fp)) {
			mf=malloc(sizeof(FPMEMOFILE));
			if (mf) {
				mf->fp=fp;
				mf->blocksize=dbapiwordswap(hd.blocksize);
				return mf;
			}
		}
		fclose(fp);
	}
	return NULL;
}
/*man*************************************************************
NAME
	fpmemoclose - close memo file

SYNOPSIS
	#include "dbapi.h"

	void fpmemoclose(FPMEMOFILE *mf);

DESCRIPTION
	closes a memo file
*****************************************************************/
void fpmemoclose(FPMEMOFILE *mf)
{
	fclose(mf->fp);
	free(mf);
}

/*man*************************************************************
NAME
	fpmemofindblock - seet to beginning of the memo data in memo file

SYNOPSIS
	#include "dbapi.h"

	long fpmemofindblock(FPMEMOFILE *mf,long blockno);

DESCRIPTION
	this function seeks to the given memo block number in memo file
	and returns length of the memo data in bytes. file data pointer
	will be at the beginning of memo data.
*/
long fpmemofindblock(FPMEMOFILE *mf,long blockno)
{
FPMEMOBLOCK b;
	fseek(mf->fp,blockno*mf->blocksize,SEEK_SET);
	if (fread(&b,sizeof b,1,mf->fp)) {
		return dbapilongswap(b.memosize);
	}
	return -1l;
}
