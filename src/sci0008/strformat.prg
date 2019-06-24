local a
? hb_StrToHex( a := hb_StrFormat( "%1"  ) ), "|" + a + "|"  // -> 253100 |%1 |
? hb_StrToHex( a := hb_StrFormat( "%0"  ) ), "|" + a + "|"  // -> 253000 |%0 |
? hb_StrToHex( a := hb_StrFormat( "%1$" ) ), "|" + a + "|"  // -> 25312400 |%1$ |
? hb_StrToHex( a := hb_StrFormat( "%0$" ) ), "|" + a + "|"  // -> 253024 |%0$| (correct)