/*
 * Author....: Dave Pearson
 */

#include <extend.api>

#pragma optimize("lge", off)

/*  $DOC$
 *  $FUNCNAME$
 *      OL_OsVerMin()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Get the minor version of the OS.
 *  $SYNTAX$
 *      OL_OsVerMin() --> nVer
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      The minor version of the operating system.
 *  $DESCRIPTION$
 *      OL_OsVerMin() will return the minor version number of the OS.
 *  $EXAMPLES$
 *      // Print the current Dos version.
 *
 *      ? alltrim( str( OL_OsVerMaj() ) ) + "." + ;
 *        alltrim( str( OL_OsVerMin() ) )
 *  $SEEALSO$
 *      
 *  $END$
 */

CLIPPER Dos_VerMi/*n*/( void )
{
    unsigned char bVer;

    _asm {
        Mov     AH, 0x30;
        Int     0x21;
        Mov     bVer, AH;
    }
    
    _retni( bVer );
}

/*  $DOC$
 *  $FUNCNAME$
 *      OL_OsVerMaj()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Get the major version of the OS.
 *  $SYNTAX$
 *      OL_OsVerMaj() --> nVer
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      The major version of the operating system.
 *  $DESCRIPTION$
 *      OL_OsVerMaj() will return the major version number of the OS.
 *  $EXAMPLES$
 *      // Print the current Dos version.
 *
 *      ? alltrim( str( OsVerMaj() ) ) + "." + alltrim( str( OsVerMin() ) )
 *  $SEEALSO$
 *      
 *  $END$
 */

CLIPPER Dos_VerMa/*j*/( void )
{
    unsigned char bVer;

    _asm {
        Mov     AH, 0x30;
        Int     0x21;
        Mov     bVer, AL;
    }
    
    _retni( bVer );
}
