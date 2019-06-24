Function Main
     LOCAL aColors  := {}
     LOCAL aBar     := { " Sair ", " Relatorios ", " Video " }

     // Include the following two lines of code in your program, as is.
     // The first creates aOptions with the same length as aBar.  The
     // second assigns a three-element array to each element of aOptions.
     LOCAL aOptions[ LEN( aBar ) ]
	  Cls
	    
     AEVAL( aBar, { |x,i| aOptions[i] := { {},{},{} } } )

     // fill color array
     // Box Border, Menu Options, Menu Bar, Current Selection, Unselected
     aColors := {"W+/G", "N/G", "N/G", "N/W", "N+/G"}

  // array for first pulldown menu
  FT_FILL( aOptions[1], '1. Execute A Dummy Procedure' , {|| VC_quit()}, .t. )
  FT_FILL( aOptions[1], '2. Enter Daily Charges'       , {|| .t.},     .f. )
  FT_FILL( aOptions[1], '3. Enter Payments On Accounts', {|| .t.},     .t. )

  // array for second pulldown menu
  FT_FILL( aOptions[2], '1. Print Member List'         , {|| .t.},     .t. )
  FT_FILL( aOptions[2], '2. Print Active Auto Charges' , {|| .t.},     .t. )

  // array for third pulldown menu
  FT_FILL( aOptions[3], '1. Transaction Totals Display', {|| .t.},     .t. )
  FT_FILL( aOptions[3], '2. Display Invoice Totals'    , {|| .t.},     .t. )
  FT_FILL( aOptions[3], '3. Exit To DOS'               , {|| .f.},     .t. )

  nChoice := FT_MENU1( aBar, aOptions, aColors, 0 )

Function Fubar()
	  Return .t.

Function VC_quit()
    Devpos(10,0)
    __Quit()
    Return NIL
	  
	  
