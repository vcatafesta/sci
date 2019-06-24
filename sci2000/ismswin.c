/*
 * Author....: Dave Pearson
 */

#include <extend.h>

#pragma optimize("lge", off)

/*  $DOC$
 *  $FUNCNAME$
 *      OL_IsMSWin()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Check to see if we are running under MS-Windows.
 *  $SYNTAX$
 *      OL_IsMSWin() --> lIsWin
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      A logical value, .T. if we are running under MS-Windows, .F. if
 *      not.
 *  $DESCRIPTION$
 *      OL_IsMSWin() can be used to check if your application is been run
 *      under MS-Windows. This could come in handy if you want to provide
 *      your users with extra features such as pasting text into the
 *      Windows clipboard.
 *  $EXAMPLES$
 *      // Check if we are running under MS-Windows.
 *
 *      If OL_IsMSWin()
 *         ? "Oh well, never mind....."
 *      Else
 *         ? "Ahhh! This ain't Windows.... ;-)"
 *      EndIf
 *  $END$
 */

CLIPPER OL_IsMSWin( void )
{
    int iIsWin = 0;
    
    _asm {
        Mov     AX, 0x1600;
        Int     0x2F;
        Test    AL, 0x7F;
        Jnz     IsWin;
        Mov     AX, 0x4680;
        Int     0x2F;
        Or      AX, AX;
        Jz      IsWin;
        Jmp     CheckDone;
    IsWin:
        Mov     iIsWin, 1;
    CheckDone:
    }
    
    _retl( iIsWin );
}
