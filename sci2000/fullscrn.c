/*
 * File......: AUTYIELD.C
 * Author....: Dave Pearson
 */

#include <extend.api>

#pragma optimize("lge", off)

/*  $DOC$
 *  $FUNCNAME$
 *      OL_WinFullScreen()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Force a DOS window into full screen mode.
 *  $SYNTAX$
 *      OL_WinFullScreeen() --> NIL
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      Nothing.
 *  $DESCRIPTION$
 *      This function can be used to force your application into full
 *      screen mode when running under MS Windows. It should work
 *      correctly for Windows 3.x and Windows 95.
 *  $EXAMPLES$
 *      OL_WinFullScreen()
 *      alert( "Boo!" )
 *  $SEEALSO$
 *
 *  $END$
 */

CLIPPER OL_WinFull/*Screen*/( void )
{
    _asm {
        Mov AX, 0x168B;
        Mov BX, 0;
        Int 0x2F;
    }

    _ret();
}
