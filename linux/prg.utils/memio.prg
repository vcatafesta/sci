 REQUEST HB_MEMIO

       LOCAL i

       dbCreate( "mem:test", { { "F1", "N", 9, 0 } }, , .T., "memarea" )

       FOR i := 1 TO 1000000
          dbAppend()
          FIELD->F1 := hb_Random() * 1000000
       NEXT
       INDEX ON FIELD->F1 TAG f1
       dbEval( {|| QOut( FIELD->F1 ) } )
       dbCloseArea()

       /* Copy files to a disk */
       hb_vfCopyFile( "mem:test.dbf", "test1.dbf" )
       hb_vfCopyFile( "mem:test.ntx", "test1.ntx" )

       /* Free memory */
       dbDrop( "mem:test" )
