/*****
 *
 *   Application: General Purpose Routine
 *   Description: Save/Restore Screen and its settings
 *     File Name: SCRUTI.PRG
 *        Author: Luiz Quintela
 *  Date created: 12-29-92
 *     Copyright: 1992 by Computer Associates
 *
 */

#define     THINGS_TO_SAVE         8

#define     SCR_ROW                1
#define     SCR_COL                2
#define     SCR_COLOR              3
#define     SCR_BLINK              4
#define     SCR_MAXROW             5
#define     SCR_MAXCOL             6
#define     SCR_SCREEN             7
#define     SCR_CURSOR             8

#define     MAX_ARR_SIZE           4096

// Status Array
STATIC aScrSta := {}

/*****
 *
 *         Name: PushScr()
 *  Description: Push screen status
 *               It will add a sub-array to aScrSta
 *               which will hold all screen information
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: VOID
 * Return Value: lRet - .T. success, .F. otherwise
 *     See Also: PopScr()
 *
 */

FUNCTION PushScr()
   LOCAL aSub
   LOCAL lRet := .F.

   // Add another array element (sub-array)
   // Check for maximum size
   IF Len(aScrSta) < MAX_ARR_SIZE
      aSub := Array(THINGS_TO_SAVE)
      aSub[SCR_ROW]    := Row()
      aSub[SCR_COL]    := Col()
      aSub[SCR_COLOR]  := SetColor()
      aSub[SCR_BLINK]  := SetBlink()
      aSub[SCR_MAXROW] := MaxRow()
      aSub[SCR_MAXCOL] := MaxCol()
      aSub[SCR_SCREEN] := SavEscreen(0, 0, MAXROW(), MAXCOL())
      aSub[SCR_CURSOR] := SetCursor()

      lRet := (AAdd(aScrSta, aSub) == aSub)

   ENDIF

   RETURN (lRet)

/*****
 *
 *         Name: PopScr()
 *  Description:
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: lMode - .T. to restore video mode
 * Return Value: lRet  - .T. success, .F. otherwise
 *     See Also: PushScr()
 *
 */

FUNCTION PopScr(lMode)
   LOCAL aSub
   LOCAL lRet := .F.

   lMode := IIF(lMode == NIL, .T., lMode)

   // Non-empty array?
   IF Len(aScrSta) > 0
      aSub := ATail(aScrSta)

      // Put things as before...
      // When you reset video mode your screen might
      // flash depending on your video card
      IF lMode
         SetMode( aSub[SCR_MAXROW] + 1, aSub[SCR_MAXCOL] + 1 )

      ENDIF
      RestScreen( 0, 0, MAXROW(), MAXCOL(), aSub[SCR_SCREEN] )
      SetPos( aSub[SCR_ROW], aSub[SCR_COL] )
      SetColor( aSub[SCR_COLOR] )
      SetBlink( aSub[SCR_BLINK] )
      SetCursor( aSub[SCR_CURSOR] )

      // Resize array
      ASize( aScrSta, Len(aScrSta) - 1 )
      lRet := .T.

   ENDIF

   RETURN (lRet)

// EOF - SCRUTI.PRG //
