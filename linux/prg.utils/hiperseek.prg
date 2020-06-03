	// Lists all record numbers that contain the word "John" anywhere in
    // either the FIRST, LAST, STREET, or CITY fields.  Uses hs_Verify()
    // to prevent "fuzzy" matches.

    LOCAL cExpr := "Receber->Codi + Receber->Nome + Receber->Cida + Receber->Ende"
    LOCAL bExpr := &( "{||" + cExpr + "}" )
    LOCAL cVal := "RUA", h := 0, nRec := 0

    CLS
    USE receber EXCL

    IF !file("RECEBER.HSX")
      ? "Building HiPer-SEEK Index..."
      h := hs_Index( "RECEBER.HSX", cExpr, 2 )
    ELSE
      h := hs_Open( "RECEBER.HSX", 8, 1 )
    ENDIF
	 inkey(0)

    hs_Set( h, cVal )
    nRec := hs_Next( h )

    DO WHILE nRec > 0
      dbGoto( nRec )
      IF hs_Verify( bExpr, cVal )
        ? nRec
      ENDIF
      nRec := hs_Next( h )
    ENDDO

    hs_Close( h )
    