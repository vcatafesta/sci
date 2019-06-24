#include <box.ch>
#include <fileIO.ch>
#include <directry.ch>


Function Main(argc)
/******************/
LOCAL xCoringa := "*.DBF"
LOCAL aFileList  := {}
LOCAL aFiles[Adir( xCoringa )]
LOCAL aSelect[Adir( xCoringa )]
LOCAL nChoice

if argc = nil 
	Afill( aselect, .T.)
	Adir( xCoringa , aFiles)
	Aeval(aFiles, { |element| Qout(element) })
	Aeval( Directory(xCoringa), {|aDirectory|;
								Aadd( aFileList,;
								DTOC(       aDirectory[F_DATE])       + "  " + ;
								SUBSTR(     aDirectory[F_TIME], 1, 5) + "  " + ;
								IF( SUBSTR( aDirectory[F_ATTR], 1,1) == "D", "   <DIR>", ;
								TRAN(       aDirectory[F_SIZE], "99,999,999 Bytes"))  + "  " + ;
								Upper(PADR( aDirectory[F_NAME], 15 )))})
								
								/*
								Upper(PADR( aDirectory[F_NAME], 15 )) + ;
                        IF( SUBSTR( aDirectory[F_ATTR], 1,1) == "D", "   <DIR>", ;
                        TRAN(       aDirectory[F_SIZE], "99,999,999 Bytes"))  + "  " + ;
                        DTOC(       aDirectory[F_DATE])       + "  " + ;
                        SUBSTR(     aDirectory[F_TIME], 1, 5) + "  " + ;
								SUBSTR(     aDirectory[F_ATTR], 1, 4) + "  " )})
								*/
	cls
	SetColor("W+/B")
	nRow1 := 05 + Len( aFileList)
	if nRow1 > 24
	   nRow1 = 24
	endif	
	@ 05, 10, nRow1+1, 70 BOX B_SINGLE_DOUBLE + SPACE(1)
	nChoice := aChoice(06, 11, nRow1, 69, aFileList)
	if nchoice = 0
		setcolor("")
	   @ 24, 0 
	   quit
	endif
	use (AllTrim(right(aFileList[nChoice],15))) new
else
	Use (argc) New
endif
Browse()