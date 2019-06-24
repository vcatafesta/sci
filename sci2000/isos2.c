/*
 * Author....: Dave Pearson
 */

#pragma optimize("lge", off)

#include <extend.api>

/*  $DOC$
 *  $FUNCNAME$
 *      OL_IsOS2()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Are we running under OS/2?
 *  $SYNTAX$
 *      OL_IsOS2() --> lOS2
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      .T. if we are running under OS/2, .F. if not.
 *  $DESCRIPTION$
 *      OL_IsOS2() can be used to test if we are running under OS/2.
 *  $EXAMPLES$
 *      // Sample function for returning the ID of the OS.
 *
 *      Function OSId()
 *      Local nMajor := OL_OsMaj()
 *      Local nMinor := OL_OsMin()
 *      Local cMake  := "Dos "
 *
 *         If OL_IsOS2()
 *            nMajor /= 10
 *            cMake  := "OS/2 Dos "
 *         EndIf
 *
 *      Return( cMake + alltrim( str( nMajor ) ) + "." +;
 *                      alltrim( str( nMinor ) ) )
 *
 *  $SEEALSO$
 *  
 *  $END$
 */

CLIPPER OL_IsOS2( void )
{
    int iIsOS2 = 0;

    _asm {
        Mov     AX, 0x4010;
        Int     0x2F;
        Cmp     AX, 0x4010;
        JZ      End;
        Mov     iIsOS2, 1;
    End:
    }

    _retl( iIsOS2 );
}
