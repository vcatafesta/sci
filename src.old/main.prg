#include <hmg.ch>

cString := MSDecToChr("#65#66#")

function Main()
LOCAL i, ar[3, 26], aBlocks[3], aHeadings[3]
            LOCAL nElem := 1, bGetFunc

      * Set up two dimensional array "ar"

            FOR i = 1 TO 26
               ar[1, i] := i          //  1  ->  26  Numeric
               ar[2, i] := CHR(i+64)  // "A" -> "Z"  Character
               ar[3, i] := CHR(91-i)  // "Z" -> "A"  Character
             NEXT i

      * SET UP aHeadings Array for column headings

            aHeadings  := { "Numbers", "Letters", "Reverse" }

      * Need to set up individual array blocks for each TBrowse column

        aBlocks[1] := {|| STR(ar[1, nElem], 2) } // prevent default 10 spaces
        aBlocks[2] := {|| ar[2, nElem] }
        aBlocks[3] := {|| ar[3, nElem] }

      * set up TestGet() as the passed Get Function so FT_ArEdit knows how
      * to edit the individual gets.

        //bGetFunc   := { | b, ar, nDim, nElem | TestGet(b, ar, nDim, nElem) }
		  bGetFunc   := { | b, ar, nDim, nElem | colorido(b, ar, nDim, nElem) }
        SetColor( "N/W, W/N, , , W/N" )
        CLEAR SCREEN
        FT_AREDIT(3, 5, 18, 75, ar, @nElem, aHeadings, aBlocks, bGetFunc)




Function Main3()
 // Declare arrays
     LOCAL aColors  := {}
     LOCAL aBar     := { "Editar", "Relatorios", "Video" }

     // Include the following two lines of code in your program, as is.
     // The first creates aOptions with the same length as aBar.  The
     // second assigns a three-element array to each element of aOptions.
     LOCAL aOptions[ LEN( aBar ) ]
     AEVAL( aBar, { |x,i| aOptions[i] := { {},{},{} } } )

     // fill color array
     // Box Border, Menu Options, Menu Bar, Current Selection, Unselected
     //aColors := {"W+/G", "N/G", "N/G", "N/W", "N+/G"} //, {"W+/N", "W+/N", "W/N", "N/W","W/N"}
	  nErrorCode := 0
	  aColors := FT_RESTARR('COR.DAT',@nErrorCode)

  // array for first pulldown menu
  FT_FILL( aOptions[1], 'A. Execute A Dummy Procedure' , {|| FT_XBOX('L','W','D','GR+/R','W/B',5,10,'It is so nice',;
                       'to not have to do the messy chore',;
                       'of calculating the box size!')}, .t. )
  FT_FILL( aOptions[1], 'B. Enter Daily Charges'       , {|| Colorido()},     .t. )
  FT_FILL( aOptions[1], 'C. Enter Payments On Accounts', {|| .t.},     .f. )

  // array for second pulldown menu
  FT_FILL( aOptions[2], 'A. Print Member List'         , {|| .t.},     .t. )
  FT_FILL( aOptions[2], 'B. Print Active Auto Charges' , {|| .t.},     .t. )

  // array for third pulldown menu
  FT_FILL( aOptions[3], 'A. Transaction Totals Display', {|| .t.},     .t. )
  FT_FILL( aOptions[3], 'B. Display Invoice Totals'    , {|| .t.},     .t. )
  FT_FILL( aOptions[3], 'C. Exit To DOS'               , {|| .f.},     .t. )

  // CALL FT_MENU1
  Cls
  FT_MENU1( aBar, aOptions, aColors, 0 )

Function Fubar()
	Return .T.
	
Function Main2()
LOCAL mainmenu := ;
          { { "Data Entry", "Enter data",   { || FT_MENU2(datamenu)  } }, ;
            { "Reports",    "Hard copy",    { || FT_MENU2(repmenu)   } }, ;
            { "Maintenance","Reindex files",{ || FT_MENU2(maintmenu) } }, ;
            { "Quit", "See ya later" } }
		cls
      FT_MENU2(mainmenu)

Function Colorido()		
	LOCAL aClrs   := {}
   LOCAL lColour := ISCOLOR()
   LOCAL cChr    := CHR(254) + CHR(254)

   SET SCOREBOARD Off
   SETBLINK( .F. )       // Allow bright backgrounds

   *.... a typical application might have the following different settings
   *     normally these would be stored in a .dbf/.dbv
   aClrs := {;
        { "Desktop",        "N/BG",                         "D", "#" }, ;
        { "Titulo",         "N/W",                          "T"      }, ;
        { "Top Menu",       "N/BG,N/W,W+/BG,W+/N,GR+/N",    "M"      }, ;
        { "Sub Menu",       "W+/N*,GR+/N*,GR+/N*,W+/R,G+/R","M"      }, ;
        { "Standard Gets",  "W/B,  W+/N,,, W/N",            "G"      }, ;
        { "Nested Gets",    "N/BG, W+/N,,, W/N",            "G"      }, ;
        { "Help",           "N/G,  W+/N,,, W/N",            "W"      }, ;
        { "Error Messages", "W+/R*,N/GR*,,,N/R*",           "W"      }, ;
        { "Database Query", "N/BG, N/GR*,,,N+/BG",          "B"      }, ;
        { "Pick List",      "N/GR*,W+/B,,, BG/GR*",         "A"      }}

    aClrs := FT_ClrSel( aClrs, lColour, cChr )		
	 
	 nErrorCode := 0
    FT_SAVEARR(aClrs,'COR.DAT',@nErrorCode)
    IF nErrorCode = 0
      aSave := FT_RESTARR('COR.DAT',@nErrorCode)
      IF nErrorCode # 0
         ? 'Erro lendo array do disco.'
      ENDIF
    ELSE
      ? 'Erro gravando array'
    ENDIF
	 Return(.T.)

Function MSDecToChr( cString )
****************************
LOCAL cNewString := ""
LOCAL nTam
LOCAL nX
LOCAL cNumero

nTam := GT_StrCount( "#", cString )
For nX := 1 To nTam
	? cNumero := StrExtract( cString, "#", nX )
	? cNewString += Chr( Val( cNumero ))
	? nx,valtype( cNumero), len(cNumero)
Next
Return ( cNewString )

Function aStrPos(string, delims)
********************************
LOCAL nConta  := GT_StrCount(delims, string)
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl("%",nLen)
LOCAL aNum    := {}
LOCAL x

IF cChar == delims
   cChar := Repl("*",delims)
EndIF	

IF nConta = 0
   Return(aNum)
EndIF

FOR x := 1 To nConta 
   nPos   := At( Delims, string )
	string := Stuff(string, nPos, 1, cChar)
	Aadd( aNum, nPos)
Next
Aadd( aNum, Len(string)+1)
Return(aNum)

Function StrExtract( string, delims, ocurrence )
************************************************
LOCAL nInicio := 1
LOCAL nConta  := GT_StrCount(delims, string)
LOCAL aArray  := {}
LOCAL aNum    := {}
LOCAL nLen    := Len(delims)
LOCAL cChar   := Repl('%',nLen)
LOCAL cNewStr := String
LOCAL nPosIni := 1
LOCAL aPos
LOCAL nFim
LOCAL x
LOCAL nPos

IF cChar == delims
   cChar := Repl("*",nLen)
EndIF	

IF nConta = 0
   Return NIL
EndIF

/*
For x := 1 to nConta
   nInicio   := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nInicio, 1, cChar)
	nFim      := At( Delims, cNewStr)
	cString   := SubStr(cNewStr, nInicio+1, nFim-nInicio-1)
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

/*
For x := 1 to nConta
   nPos      := At( Delims, cNewStr)
   cNewStr   := Stuff(cNewStr, nPos, 1, cChar)
	nLen      := nPos-nPosini
	cString   := SubStr(cNewStr, nPosIni, nLen)
	nFim      := At( Delims, cNewStr)
	nPosIni   := nPos+1
	if !Empty(cString)
	   Aadd( aArray, cString)
	End		
Next
*/

aPos   := aStrPos(string, Delims)
nConta := Len(aPos)
For x := 1 to nConta 
   nInicio  := aPos[x]
	IF x = 1
	   cString   := Left(String, nInicio-1)
	Else
		nFim     := aPos[x-1]
	   cString  := SubStr(String, nFim+1, nInicio-nFim-1)
	EndIF	
	Aadd( aArray, cString)
Next
nConta := Len(aArray)
IF ocurrence > nConta .OR. oCurrence = 0
   Return NIL
EndIF

Return(aArray[ocurrence])
