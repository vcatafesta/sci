#DEFINE FOXPRO
#IFDEF FOXPRO
  #include "SIXNSX.CH"
  #define MEMOEXT  ".SMT"
  #define INDEXEXT ".NSX"
  #define RDDNAME  "SIXNSX"
  #Define CEXT     "NSX"
#ELSE
  #include "SIXNTX.CH"
  #define MEMOEXT  ".DBT"
  #define INDEXEXT ".NTX"
  #define RDDNAME  "DBFNTX"
  #Define CEXT     "NTX"
#ENDIF
