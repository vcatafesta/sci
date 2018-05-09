#ifndef _RDDNAME_CH_
#define _RDDNAME_CH_

//#DEFINE FOXPRO
//#DEFINE DBFNTX
//#DEFINE DBFCDX
#DEFINE LETO
//#DEFINE DBFNSX
//#DEFINE DBFMDX
//#DEFINE DBPX

	REQUEST leto
	REQUEST DBFNTX
   REQUEST DBFCDX
   //REQUEST DBFMDX  /* velho demais */
	//REQUEST DBPX    /* velho demais */	
	REQUEST DBFFPT
	REQUEST SIXCDX
	REQUEST DBFNSX
	REQUEST HB_MEMIO   

#define RDDALTERNATIVO "DBFCDX"

#IFDEF FOXPRO
  #include <sixnsx.ch>
  #define MEMOEXT  ".SMT"
  #define INDEXEXT ".CDX"
  #define RDDNAME  "SIXNSX"
  #Define CEXT     "CDX"
#ENDIF
#IFDEF LETO
  #include <hbsix.ch>
  #include <dbinfo.ch>
  #define FOXPRO
  #define MEMOEXT  ".SMT"  
  #define INDEXEXT ".CDX"  
  #define RDDNAME  "LETO"
  #define REQNAME  "LETO"
  #define CEXT     "CDX"    
#ENDIF
#IFDEF DBFNSX
  #include <hbsix.ch>
  #include <dbinfo.ch>
  #define FOXPRO
  #define MEMOEXT  ".SMT"
  #define INDEXEXT ".NSX"
  #define RDDNAME  "DBFNSX"
  #define REQNAME  "DBFNSX"
  #Define CEXT     "NSX"
#ENDIF
#IFDEF DBFNTX
  #include <dbinfo.ch>
  //REQUEST dbfntx
  #define MEMOEXT  ".DBT"
  #define INDEXEXT ".NTX"
  #define RDDNAME  "DBFNTX"
  #define REQNAME  "DBFNTX"
  #Define CEXT     "NTX"
#ENDIF
#IFDEF DBFCDX
  #include <dbinfo.ch>
  //REQUEST dbfcdx
  #define FOXPRO
  #define MEMOEXT  ".DBT"
  #define INDEXEXT ".CDX"
  #define RDDNAME  "DBFCDX"
  #define REQNAME  "DBFCDX"
  #Define CEXT     "CDX"
#ENDIF
#IFDEF DBFMDX
  #include <dbinfo.ch>
  //REQUEST dbfmdx
  #define FOXPRO
  #define MEMOEXT  ".DBT"
  #define INDEXEXT ".MDX"
  #define RDDNAME  "DBFMDX"
  #define REQNAME  "DBFMDX"
  #Define CEXT     "MDX"
#ENDIF
#IFDEF DBPX
  #include <dbinfo.ch>
  //REQUEST dbpx
  #define FOXPRO
  #define MEMOEXT  ".DBT"
  #define INDEXEXT ".PX"
  #define RDDNAME  "DBPX"
  #define REQNAME  "DBPX"
  #Define CEXT     "PX"
#ENDIF
#endif  /* _RDDNAME_CH_ */