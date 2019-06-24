/*
 * Author....: Dave Pearson
 */

#pragma optimize("lge", off)

#include <extend.api>

/*  $DOC$
 *  $FUNCNAME$
 *      OL_IsOS2Win()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Are we running in a windowed OS/2 Dos session?
 *  $SYNTAX$
 *      OL_IsOS2Win() --> lWindow
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      .T. if we are running in an OS/2 Dos Window, .F. if we are running
 *      in an OS/2 Dos full screen session.
 *  $DESCRIPTION$
 *      OL_IsOS2Win() can be used to check if the current Dos session
 *      under OS/2 is a windowed session or a full screen
 *      session. Note that this function does not check if we are
 *      running under OS/2 and the return value is undocumented if we
 *      are not. You will probably want to check using OL_IsOS2() first.
 *  $EXAMPLES$
 *      // Display the current session details.
 *
 *      If OL_IsOS2()
 *         ? "Running in an OS/2 Dos " + if( OL_IsOS2Win()   ,;
 *                                           "windowed"      ,;
 *                                           "full screen" ) +;
 *                                           " session"
 *      Else
 *         ? "Boring old Dos!"
 *      EndIf
 *  $SEEALSO$
 *      
 * $END$
 */

CLIPPER OL_IsOS2Wi/*n*/( void )
{
    int iIsWin;
    
    _asm {
        Mov     DX, 0x03D6;
        Mov     AL, 0x82;
        Out     DX, AL;
        In      AL, DX;
        Cmp     AL, 00;
        Je      IsWin;
        Mov     iIsWin, 0;
        Jmp     Done;
    IsWin:
        Mov     iIsWin, 1;
    Done:
    }
    
    _retl( iIsWin );
}
