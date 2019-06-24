Set Date Brit
Set Cent On


Cls
dIni  := Date()
dFim  := Date()
dDias := 0
while .t.
	@ 10, 10 Say "Dias Final     :" get dFim
	@ 11, 10 Say "Dias Passados  :" get dDias
	Read
	If LastKey() = 27
	   exit
   endif
   
	@ 13, 10 say "Data Inicial   : " + dToc(dFim - dDias)
	
enddo	
