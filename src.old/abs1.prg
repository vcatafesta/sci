
#pragma BEGINDUMP
	#include "hbdefs.h"
	#include "hbapi.h"
	#include "hbapigt.h"
	#include "hbapiitm.h"
	#include "hbapistr.h"
	#include "hbapierr.h"
	#include "hbapicdp.h"	
	//#include <stdio.h>	

	HB_FUNC(CUBO)
	{
		printf("\n%d\n", 0);
		hb_retni(110);
	}

	HB_FUNC(SOMA)
	{
		int nValue = hb_parni(1);
		printf("\n%d\n", nValue);
		hb_retni(nValue);
	}

	HB_FUNC(FORC)
	{
		char *pItem = "Hello World from C";
		int n       = 0;
		for(n=0; n <= 1000; ++n )			
			printf("%s %i ", pItem, n);	
		free(pItem);
		hb_retc_null();
	}
#pragma ENDDUMP	