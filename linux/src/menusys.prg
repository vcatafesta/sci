/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
/*
   CA-Clipper 5.3 menu item class definition
   February, 1994

*/

/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
// include files

#include "button.ch"
#include "setcurs.ch"
//#include "llibg.ch"
#include "inkey.ch"

/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
/* static variable declarations. */

static aMenuList, nMenuLevel, oMenu
static OldMessage:= NIL
static OldMsgPos := 0

/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
function MenuModal( oTopBar, nSelection, nMsgRow, nMsgLeft, nMsgRight, cMsgColor )
   local nKey, nOldItem, nNewItem, lSaveCursor, lLeftDown, oOldMenu, ;
         oNewMenu, nOldLevel, nNewLevel, lMsgFlag, cOldMsg, nMsgWidth, ;
         oMenuItem, nMenuItem, nReturn, nCol, nRow, nTemp, bKeyBlock

   nReturn := 0
   nCol:=COL()
   nRow:=ROW()
   lSaveCursor := SetCursor( SC_NONE )

   if     ( ! ValType( nMsgRow ) == "N" )
      lMsgFlag := .f.

   elseif ( ! ValType( nMsgLeft ) == "N" )
      lMsgFlag := .f.

   elseif ( ! ValType( nMsgRight ) == "N" )
      lMsgFlag := .f.

   else
      lMsgFlag := .t.
      cOldMsg := SaveScreen( nMsgRow, nMsgLeft, nMsgRow, nMsgRight )
      nMsgWidth := nMsgRight - nMsgLeft + 1
   endif

   while ( nSelection == 0 )
      nKey := Inkey( 0 )

      if ( nKey == K_LBUTTONDOWN )
         nSelection := oTopBar:HitTest( MRow(), MCol() )

      elseif ( ( nSelection := oTopBar:GetAccel( nKey ) ) != 0 )

      elseif ( IsShortCut( oTopBar, nKey, @nReturn ) )
         return ( nReturn )                                      /* NOTE! */

      endif
   enddo

   if ( ! oTopBar:GetItem( nSelection ):Enabled )
      return ( 0 )                                               /* NOTE! */
   endif

   oMenu := oTopBar

   aMenuList  := Array( 16 )
   nMenuLevel := 1

   aMenuList[ 1 ] := oMenu

   lLeftDown := mLeftDown()

   oMenu:Select( nSelection )
   oMenu:Display()
   PushMenu( .t. )
   ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

   while (.T.)
      nKey := INKEY( 0 )

      // Check for SET KEY first
      if !( ( bKeyBlock := setkey( nKey ) ) == NIL )
         eval( bKeyBlock, procname(1), procline(1), "" )
         loop
      endif

      if ( nKey == K_MOUSEMOVE )
//====== mouse movement.

         if ( lLeftDown )

            if ( ! HitTest( @oNewMenu, @nNewLevel, @nNewItem ) )
//------------ hit nowhere.
            elseif ( nMenuLevel != nNewLevel )
//------------ menu level change.

               if ( nNewItem == oNewMenu:Current )
               elseif ( oNewMenu:GetItem( nNewItem ):Enabled )
                  oMenu := oNewMenu
                  PopChild( nNewLevel )
                  oMenu:Select( nNewItem )
                  oMenu:Display()
                  PushMenu()
                  ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )
               endif

            elseif ( nNewItem != oNewMenu:Current() )
//------------ menu item change.

               PopChild( nMenuLevel )

               if ( oMenu:GetItem( nNewItem ):Enabled )
                  oMenu:Select( nNewItem )
                  oMenu:Display()
                  PushMenu()
                  ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )
               endif

            endif

         endif

      elseif ( nKey == K_DOWN )
//====== down arrow key.

         if ( nMenuLevel > 1 )
            nTemp = oMenu:GetNext()
            if (nTemp == 0 )
              nTemp = oMenu:GetFirst()
            endif
            oMenu:Select( nTemp )
            oMenu:Display()
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

         endif

      elseif ( nKey == K_UP )
//====== up arrow key.

         if ( nMenuLevel > 1 )
            nTemp = oMenu:GetPrev()
            if (nTemp == 0 )
              nTemp = oMenu:GetLast()
            endif
            oMenu:Select( nTemp )
            oMenu:Display()
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

         endif

      elseif ( nKey == K_LEFT )
//====== left arrow key.

         if ( nMenuLevel > 1 )
            PopMenu()
         endif

         if ( nMenuLevel == 1 )
            nTemp = oMenu:GetPrev()
            if (nTemp == 0 )
              nTemp = oMenu:GetLast()
            endif
            oMenu:Select( nTemp )
            oMenu:Display()
            PushMenu( .t. )
         endif
         ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

      elseif ( nKey == K_RIGHT )
//====== right arrow key.

         if ( ! PushMenu( .t. ) )
            PopAll()
            nTemp = oMenu:GetNext()
            if (nTemp == 0 )
              nTemp = oMenu:GetFirst()
            endif
            oMenu:Select( nTemp )
            oMenu:Display()
            PushMenu( .t. )
         endif
         ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

      elseif ( nKey == K_ENTER )
//====== enter key .

         if ( PushMenu( .t. ) )
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

         else
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .f. )
            nReturn := Execute()
            exit

         endif

      elseif ( nKey == K_ESC )
//====== escape key - go to previous menu

         PopMenu()
         oMenu:Display()
         ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

      elseif ( nKey == K_LBUTTONDOWN )
//====== mouse left button press.

         if ( ! HitTest( @oNewMenu, @nNewLevel, @nNewItem ) )
         elseif ( nNewLevel == nMenuLevel )

            oMenu:Select( nNewItem )
            oMenu:Display()
            if ( ! PushMenu() )
               oMenu:Display()
            endif
            PushMenu()
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

         else
            nMenuLevel := nNewLevel
            oMenu      := aMenuList[ nMenuLevel ]

            nMenuItem :=  oMenu:Current
            oMenuItem := oMenu:GetItem( nMenuItem )
            if ( ( oMenuItem := oMenu:GetItem( oMenu:Current ) ):IsPopUp() )
               oMenuItem:Data:Close()
            endif

            if ( nMenuItem != nNewItem )
               nMenuItem := nNewItem
               oMenu:Select( nNewItem )
               oMenu:Display()
               PushMenu()
            endif

            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

         endif

         lLeftDown := .t.

      elseif ( nKey == K_LBUTTONUP )
//====== mouse left button release.

         lLeftDown := .f.

         if ( ! HitTest( @oNewMenu, @nNewLevel, @nNewItem ) )
         elseif ( nNewLevel == nMenuLevel )
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .f. )
            nReturn := Execute()
            if ( nReturn <> 0 )
              exit
            endif

         else
            nNewItem := oMenu:GetFirst()
            if ( nNewItem == 0 )
            else
               oMenu:Select(  nNewItem )
               oMenu:Display()
               ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )
            endif

         endif

      elseif ( ( nNewItem := oMenu:GetAccel( nKey ) ) != 0 )
//=== check for menu item accelerator key.

         oMenu:Select( nNewItem )
         oMenu:Display()

         if ( ! PushMenu( .t. ) )
            ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .f. )
            nReturn := Execute()
            exit
         endif
         ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

      elseif ( IsShortCut( oTopBar, nKey, @nReturn ) )
         exit

     elseif ( ( nNewItem := oTopBar:GetAccel( nKey ) ) != 0 )
//=== check for topbar accelerator key

         PopAll()
         oMenu:Select( nNewItem )
         oMenu:Display()
         if ( oTopBar:GetItem( nNewItem ):IsPopUp() )
            PushMenu( .t. )
         else
        	ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .f. )
            nReturn := Execute()
            exit
         endif
         ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, .t. )

      endif
   enddo

   IF ( lMsgFlag .and. !_ISGRAPHIC() )
      RestScreen( nMsgRow, nMsgLeft, nMsgRow, nMsgRight, cOldMsg )
   ENDIF

   PopAll()

   oMenu:Select( 0 )
   oTopBar:Display()
   setpos(nRow,nCol)
   SetCursor( lSaveCursor )

   return ( nReturn )



/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function PushMenu( lSelect )
   local oNewMenu

      oNewMenu := oMenu:GetItem( oMenu:Current )

      if ( oNewMenu == NIL )
      elseif ( oNewMenu:IsPopUp )

         if ( ! ValType( lSelect ) == "L" )
            lSelect := .f.
         endif

         oMenu := oNewMenu:Data
         aMenuList[ ++nMenuLevel ] := oMenu

         if ( lSelect )
            oMenu:Select( oMenu:GetFirst() )

         else
            oMenu:Select( 0 )

         endif

         oMenu:Open()

         return ( .t. )                                         /* NOTE ! */
      endif


   return ( .f. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function PopMenu()

      if ( nMenuLevel > 1 )
         oMenu:Close()
         oMenu := aMenuList[ --nMenuLevel ]

         return ( .t. )                                         /* NOTE ! */
      endif


   return ( .f. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function PopChild( nNewLevel )
   local oOldMenu, nCurrent

      if ( ( nCurrent := oMenu:Current ) != 0 )
         oOldMenu := oMenu:GetItem( nCurrent )

         if ( oOldMenu:IsPopUp )
            oOldMenu:Data:Close()
            nMenuLevel := nNewLevel

            return ( .t. )                                      /* NOTE ! */
         endif
      endif


   return ( .f. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function PopAll()

      if ( nMenuLevel > 1 )
         aMenuList[ 2 ]:Close()
         nMenuLevel := 1
         oMenu := aMenuList[ 1 ]
      endif

   return ( .t. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function Execute()
   local oNewMenu, nCurrent, lPas
      lPas :=.T.
      oNewMenu := oMenu:GetItem( oMenu:Current )

      if ( oNewMenu == NIL )
      elseif ( ! oNewMenu:IsPopUp )
         if (oMenu:classname()== "POPUPMENU")
             oMenu:Close()
             Eval( oNewMenu:Data, oNewMenu )
             lPas:=.F.
         elseif (oMenu:classname() == "TOPBARMENU" )
             Eval( oNewMenu:Data, oNewMenu )
             lPas:=.F.
         endif
         PopAll()
         nCurrent:=oMenu:Current
         oMenu:Select( 0 )
         oMenu:Display()
         oMenu:Select(nCurrent)
         if lPas
           oMenu:Close()
           Eval( oNewMenu:Data, oNewMenu )
         endif
         oMenu:Select(0)
         return ( oNewMenu:Id )                                 /* NOTE ! */

      endif

   return ( 0 )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function HitTest( oNewMenu, nNewLevel, nNewItem )

      for nNewLevel := nMenuLevel to 1 step -1
         oNewMenu := aMenuList[ nNewLevel ]
         nNewItem := oNewMenu:HitTest( mRow(), mCol() )

         if ( nNewItem < 0 )
             return ( .f. )                                        /* NOTE ! */
         elseif ( nNewItem >0)
            return ( .t. )                                      /* NOTE ! */
         endif

      next

   return ( .f. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
static function ShowMsg( lMsgFlag, nMsgRow, nMsgLeft, nMsgWidth, cMsgColor, lMode )
   local cOldColor, nCurrent, lColor, nForeColor, nBackColor, cMsg:=NIL,;
         nAt, nMsgPos, mOldState, nFontRow

      if ( lMsgFlag )
         if ( lColor := ValType( cMsgColor ) == "C" )
            cOldColor := SetColor( cMsgColor )
         endif

         if (! _ISGRAPHIC() )
            SetPos( nMsgRow, nMsgLeft )

            if ( ( nCurrent := oMenu:Current ) == 0 )
               DevOut( Space( nMsgWidth ) )

            elseif ( lMode )
               DevOut( PadC( oMenu:GetItem( nCurrent ):Message, nMsgWidth ) )

            else
               DevOut( Space( nMsgWidth ) )

            endif
         else

            mOldState := MSETCURSOR(.F.)

            nForeColor := _GETNUMCOLOR ( cMsgColor )
            nAt := AT( "/" , cMsgColor )
            nBackColor := _GETNUMCOLOR( Substr( cMsgColor, nAt + 1, len( cMsgColor ) - nAt) )

            nCurrent := oMenu:Current

            if (nCurrent == 0)
               if ( ValType( OldMessage ) == "N" )
                  cMsg := SPACE( LEN( OldMessage ) )
               else
                  cMsg := SPACE( 0 )
               endif
            else
               cMsg := oMenu:GetItem( nCurrent ):Message
            endif

            nMsgPos := int(nMsgWidth / 2) - int(len(cMsg) / 2) + 1

            nFontRow = gMode()[LLG_MODE_FONT_ROW]

            if (OldMessage <> NIL)
               if ( (OldMessage <> cMsg ) .or. (len(cMsg) == 0) )
                  gWriteAt( OldMsgPos * 8,;
                            nMsgRow * nFontRow,;
                            OldMessage,;
                            nBackColor,;
                            LLG_MODE_SET )
                  gFrame(nMsgLeft * 8,;
                        (nMsgRow * nFontRow) - 1,;
                        (nMsgLeft + nMsgWidth) * 8,;
                       ((nMsgRow + 1) * nFontRow) + 1,;
                         nBackColor,;
                         8, 15,;
                         2, 2, 2, 2, LLG_MODE_XOR, LLG_FILL )
               endif
            endif

            if ( (OldMessage <> cMsg) .or. (len(cMsg) == 0) )
               gFrame(nMsgLeft * 8,;
                     (nMsgRow * nFontRow) - 1,;
                     (nMsgLeft + nMsgWidth) * 8,;
                    ((nMsgRow + 1) * nFontRow) + 1,;
                      nBackColor,;
                      8, 15,;
                      2, 2, 2, 2, LLG_MODE_XOR, LLG_FILL )
               gWriteAt( nMsgPos * 8,;
                         nMsgRow * nFontRow,;
                         cMsg,;
                         nForeColor,;
                         LLG_MODE_SET )
            endif

            OldMessage := cMsg
            OldMsgPos := nMsgPos

            MSETCURSOR(mOldState)

         endif

         if ( lColor )
            SetColor( cOldColor )
         endif

         return ( .t. )                                         /* NOTE ! */
      endif

   return ( .f. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
function IsShortCut( oMenu, nKey, nID )
   LOCAL nItem, nTotal, nShortCut, oItem, bData

      IF ( ( nShortCut := oMenu:GetShortCt( nKey ) ) == 0 )
         nTotal := oMenu:ItemCount()
         FOR nItem := 1 TO nTotal
            IF ( ! ( oItem := oMenu:GetItem( nItem ) ):IsPopUp() )
            ELSEIF ( IsShortCut( oItem:Data, nKey, @nID ) )
               RETURN ( .T. )
            ENDIF
         NEXT

      ELSEIF ( ! ( oItem := oMenu:GetItem( nShortCut ) ):IsPopUp() )
         oMenu:select( nShortCut )
         Eval( oItem:Data, oItem )
         nID := oItem:ID
         RETURN ( .T. )                                          /* NOTE! */

      ENDIF

   RETURN ( .F. )


/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/
/*컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴*/

