/*

  File.........:  FCOPY.CH
  Purpose......:  Support for enhanced COPY FILE command.  Requires FCOPY.PRG
                  source file.
  Author.......:  Loren Scott, SuccessWare 90, Inc. - (909)699-9657
  Last Update..:  11/02/93

*/

#define BUFSIZE 8      // 8k read/write buffer

#xcommand COPY FILE <old> TO <new>                                 ;
          [OPTION <opt> [STEP <step>]]                             ;
          [BUFFER <buf>]                                           ;
       => CopyFile( <"old">, <"new">, <{opt}>, <step>, <buf> )

