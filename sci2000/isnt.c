/*
 * Author....: Dave Pearson
 */

#include <extend.h>

#pragma optimize("lge", off)

/*  $DOC$
 *  $FUNCNAME$
 *      OL_IsNT()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Check to see if we are running under MS-Windows NT.
 *  $SYNTAX$
 *      OL_IsNT() --> lIsNT
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      A logical value, .T. if we are running under MS-Windows NT, .F. if
 *      not.
 *  $DESCRIPTION$
 *      OL_IsNT() can be used to check if your application is being run
 *      under MS-Windows NT. This could come in handy if you want to provide
 *      your users with extra features.
 *  $EXAMPLES$
 *      // Check if we are running under MS-Windows NT.
 *
 *      If OL_IsNT()
 *         ? "Oh well, never mind....."
 *      Else
 *         ? "Ahhh! This ain't NT.... ;-)"
 *      EndIf
 *  $END$
 */

CLIPPER OL_IsNT( void )
{
    int iIsNT = 0;

    _asm {
        Mov AX, 3306h;
        Int 21h;
        Cmp BX, 3205h;
        Jne End;
        Mov iIsNT, 1;
    End:
    }

    _retl( iIsNT );
}
