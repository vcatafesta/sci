Function main

use recibo new
use recemov new
inde on docnr to docnr


recibo->(DbGotop())
while recibo->(!Eof())
   qout( recibo->(Recno()))
   cdocnr   := recibo->docnr
	ddatapag := recibo->data
	nvlrpag  := recibo->vlr
	
	if recemov->(dbseek( cdocnr))
	   recemov->datapag := ddatapag
		recemov->vlrpag  := nvlrpag
		recemov->stpag   := .t.
	endif	
	recibo->(DbSkip(1))

enddo