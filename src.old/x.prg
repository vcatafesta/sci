#Include "hbclass.ch"

CLASS TLancaDespesasDiversas
   VAR cDocnr     INIT     ::DocnrGeraDocr(@cDocnr)
	METHOD New()  	INLINE 	Self
	METHOD Docnr( cDocnr )  EXTERN GeraDocnr(@::cDocnr)   
endclass
