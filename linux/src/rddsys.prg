/*
  ┌─────────────────────────────────────────────────────────────────────────?
 ▌│																								 ?
 ▌│	Modulo.......: RDDSYS.PRG						   								 ?						 
 ▌│	Sistema......: FUNCOES RDD      							            	    ?  
 ▌│	Aplicacao....: SCI - SISTEMA COMERCIAL INTEGRADO                      ?
 ▌│	Versao.......: 8.5.00							                            ?
 ▌│	Programador..: Vilmar Catafesta				                            ?
 ▌│   Empresa......: Macrosoft Informatica Ltda                             ?
 ▌│	Inicio.......: 12.11.1991 						                            ?
 ▌│   Ult.Atual....: 12.04.2018                                             ?
 ▌│   Compilador...: Harbour 3.2/3.4                                        ?
 ▌│   Linker.......: BCC/GCC/MSCV                                           ?
 ▌│	Bibliotecas..:  									                            ?
 ▌└─────────────────────────────────────────────────────────────────────────┘
 ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀
*/

ANNOUNCE RDDSYS
INIT PROCEDURE RddInit()
   // No driver is set as default
   // Forces drivers to be linked in
   REQUEST DBFNTX
   REQUEST DBFCDX
	REQUEST DBFNSX
	//REQUEST DBFMDX
   //REQUEST DBPX
   return

// EOF - RDDSYS.PRG //
