#ifndef _RDDNAME_CH_
#define _RDDNAME_CH_

REQUEST DBFNTX
REQUEST DBFCDX
//REQUEST DBFMDX  /* velho demais */
//REQUEST DBPX    /* velho demais */	
REQUEST DBFFPT
REQUEST SIXCDX
REQUEST DBFNSX
REQUEST HB_MEMIO
#define RDDALTERNATIVO "DBFCDX"

//#DEFINE FOXPRO
#DEFINE DBFNSX
//#DEFINE LETO
//#DEFINE DBFNTX
//#DEFINE DBFCDX
//#DEFINE DBFMDX
//#DEFINE DBPX


#IFDEF FOXPRO
  #include "sixnsx.ch"
  #define MEMOEXT  ".smt"
  #define INDEXEXT ".cdx"
  #define RDDNAME  "SIXNSX"
  #Define CEXT     "cdx"
#ENDIF
#IFDEF LETO
  #include <hbsix.ch>
  #include <dbinfo.ch>
  #define FOXPRO
  #define MEMOEXT  ".smt"  
  #define INDEXEXT ".cdx"  
  #define RDDNAME  "DBFNSX"
  #define REQNAME  "DBFNSX"
  #define CEXT     "cdx"    
#ENDIF
#IFDEF DBFNSX
  #include <hbsix.ch>
  #include <dbinfo.ch>
  #define FOXPRO
  #define MEMOEXT  ".smt"
  #define INDEXEXT ".nsx"
  #define RDDNAME  "DBFNSX"
  #define REQNAME  "DBFNSX"
  #Define CEXT     "nsx"
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
  #define MEMOEXT  ".dbt"
  #define INDEXEXT ".cdx"
  #define RDDNAME  "DBFCDX"
  #define REQNAME  "DBFCDX"
  #Define CEXT     "cdx"
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
