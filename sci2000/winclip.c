/*
 * Author....: Dave Pearson
 */

#include <fm.api>
#include <cpmi.h>
#include <extend.api>

#pragma optimize("lge", off)

#define _OL_FP_OFF(fp)     ((unsigned)((unsigned long)fp))
#define _OL_FP_SEG(fp)     ((unsigned)((unsigned long)(fp) >> 16))
#define _OL_MK_FP(seg,ofs) ((void far *)(((unsigned long)(seg) << 16) | (unsigned)(ofs)))

/* Clipper internals. */
char *strcpy( char *, const char * );

/* Local internals. */
static int  _ol_ClipboardAvail( void );
static int  _ol_OpenClipboard( void );
static void _ol_CloseClipboard( void );

/*  $DOC$
 *  $FUNCNAME$
 *      OL_WinCBPaste()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Place text into the MS Windows clipboard.
 *  $SYNTAX$
 *      OL_WinCBPaste( <cText> ) --> lPasted
 *  $ARGUMENTS$
 *      <cText> is the text to place into the Windows clipboard.
 *  $RETURNS$
 *      A logical value, .T. if the text was pasted, .F. if not.
 *  $DESCRIPTION$
 *      OL_WinCBPaste() can be used to place text into the Windows
 *      clipboard when your application is running in a DOS window.
 *
 *      If the text is pasted into the clipboard the function will return
 *      true (.T.), if not, it will return false (.F.). For the function
 *      to fail to paste one of the following has to happen:
 *
 *              a) The application is not running under MS Windows.
 *              b) The DOS paste service is not available.
 *              c) The clipboard could not be opened.
 *
 *      The information used to write this function was taken from ``Hands
 *      On - Low Level'' in Personal Computer World - December 1992, Page
 *      451. This article states that there is a problem using the
 *      described method with Windows 3.1. I have tested this function with
 *      Windows 3.1, WFWG versions 3.1 and 3.11 and Windows 95 and it appears
 *      to work fine.
 *
 *      NOTE: Because this function needs to do some extra stuff when your
 *      application is running in protected mode I've had to make use of
 *      the CPMI library. You ^Bmust^b link this in if you intend to use
 *      this function, even if you are linking for real mode operation.
 *  $EXAMPLES$
 *      // Function to take a customer's address details and paste them
 *      // Into the Windows clipboard.
 *
 *      #define CR_LF   chr(13) + chr(10)
 *
 *      Function AddresToClip()
 *
 *         If OL_WinCBPaste( alltrim( Customer->Address1 ) + CR_LF + ;
 *                           alltrim( Customer->Address2 ) + CR_LF + ;
 *                           alltrim( Customer->Address3 ) + CR_LF + ;
 *                           alltrim( Customer->Address4 ) + CR_LF + ;
 *                           alltrim( Customer->Address5 ) + CR_LF )
 *            // Tell the user that it worked.
 *         Else
 *            // Tell the user that it didn't work.
 *         EndIf
 *
 *      Return(NIL)
 *  $SEEALSO$
 *      OL_WinCBCopy()
 *  $END$
 */

CLIPPER OL_WinCBPa/*ste*/( void )
{
    int iOk = 0;
    
    if ( PCOUNT && ISCHAR( 1 ) )
    {
        if ( _ol_ClipboardAvail() && _ol_OpenClipboard() )
        {
            char     *pszText = _parc( 1 );
            unsigned uSize    = _parclen( 1 );
            unsigned uHiSize  = (int) _OL_FP_SEG( uSize );
            unsigned uLoSize  = (int) _OL_FP_OFF( uSize );

            if ( cpmiIsProtected() )
            {
                SELECTOR selText    = cpmiAllocateDOSMem( uSize + 1 );
                char     *pszRMText = _OL_MK_FP( selText, 0 );
                CPUREGS regs;

                strcpy( pszRMText, pszText );

                regs.Reg.DX = 1;
                regs.Reg.ES = _OL_FP_SEG( cpmiRealPtr( pszRMText ) );
                regs.Reg.BX = _OL_FP_OFF( cpmiRealPtr( pszRMText ) );
                regs.Reg.SI = uHiSize;
                regs.Reg.CX = uLoSize;
                regs.Reg.AX = 0x1703;
                cpmiInt86( 0x2F, &regs, &regs );

                iOk = regs.Reg.AX;

                cpmiFreeDOSMem( selText );
            }
            else
            {
                int iSeg = _OL_FP_SEG( pszText );
                int iOff = _OL_FP_OFF( pszText );

                _asm {
                    Mov DX, 1;
                    Mov ES, iSeg;
                    Mov BX, iOff;
                    Mov SI, uHiSize;
                    Mov CX, uLoSize;
                    Mov AX, 1703h;
                    Int 2Fh;
                    Mov iOk, AX;
                }
            }
            _ol_CloseClipboard();
        }
    }

    _retl( iOk );
}

/*  $DOC$
 *  $FUNCNAME$
 *      OL_WinCBCopy()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Get text from the MS Windows clipboard.
 *  $SYNTAX$
 *      OL_WinCBCopy() --> cText
 *  $ARGUMENTS$
 *      None.
 *  $RETURNS$
 *      The text contents of the Windows clipboard if there is any text
 *      there, or an empty string if there was an error or there was no
 *      text in the clipboard.
 *  $DESCRIPTION$
 *      OL_WinCBCopy() can be used to retrieve text from the Windows
 *      clipboard when your application is running in a DOS window.
 *
 *      If for any reason the function is unable to locate any text in
 *      the clipboard the function will return an empty string. For the
 *      function to fail to copy from the clipboard one of the following has
 *      to happen:
 *
 *              a) The application is not running under MS Windows.
 *              b) The DOS paste service is not available.
 *              c) The clipboard could not be opened.
 *
 *      This function has been tested under under WFWG 3.11 and Windows 95.
 *
 *      NOTE: Because this function needs to do some extra stuff when your
 *      application is running in protected mode I've had to make use of
 *      the CPMI library. You ^Bmust^b link this in if you intend to use
 *      this function, even if you are linking for real mode operation.
 *  $EXAMPLES$
 *      // Attempt to grab some text from the clipboard and display it.
 *
 *      If OL_IsWin()
 *         ? "The content is '" + OL_WinCBCopy() + "'"
 *      Else
 *         ? "You are not running under Windows"
 *      EndIf
 *  $SEEALSO$
 *      OL_WinCBPaste()
 *  $END$
 */

CLIPPER OL_WinCBCo/*py*/( void )
{
    if ( _ol_ClipboardAvail() && _ol_OpenClipboard() )
    {
        unsigned uLoSize;
        unsigned uHiSize;
        unsigned uSize;

        _asm {
            Mov AX, 1704h;
            Mov DX, 1;
            Int 2Fh;
            Mov uHiSize, DX;
            Mov uLoSize, AX;
        }

        uSize = (unsigned) ( (unsigned long) _OL_MK_FP( uHiSize, uLoSize ) );

        if ( uSize )
        {
            char *pszText = _xgrab( uSize + 1 );

            if ( cpmiIsProtected() )
            {
                SELECTOR selText    = cpmiAllocateDOSMem( uSize + 1 );
                char     *pszRMText = _OL_MK_FP( selText, 0 );
                CPUREGS  regs;

                regs.Reg.AX = 0x1705;
                regs.Reg.DX = 1;
                regs.Reg.ES = _OL_FP_SEG( cpmiRealPtr( pszRMText ) );
                regs.Reg.BX = _OL_FP_OFF( cpmiRealPtr( pszRMText ) );
                cpmiInt86( 0x2F, &regs, &regs );

                strcpy( pszText, pszRMText );
            }
            else
            {
                int iSeg = _OL_FP_SEG( pszText );
                int iOff = _OL_FP_OFF( pszText );

                _asm {
                    Mov AX, 1705h;
                    Mov DX, 1;
                    Mov ES, iSeg;
                    Mov BX, iOff;
                    Int 2Fh;
                }

            }
            
            _retc( pszText );
            _xfree( pszText );
        }
        else
        {
            _retc( "" );
        }
    }
    else
    {
        _retc( "" );
    }
}

static int _ol_ClipboardAvail( void )
{
    int iAvail = 1;

    _asm {
        Mov  AX, 1600h;
        Int  2Fh;
        Test AL, 7Fh;
        Jnz  WinFound;
        Mov  AX, 4680h;
        Int  2Fh;
        Or   AX, AX;
        Jz   WinFound;
        Mov  iAvail, 0;
    WinFound:
    }

    if ( iAvail )
    {
        _asm {
            Mov AX, 1700h;
            Int 2Fh;
            Mov iAvail, AX;
        }

        iAvail = ( iAvail != 0x1700 );
    }
    
    return( iAvail );
}

static int _ol_OpenClipboard( void )
{
    int iOpen = 0;

    _asm {
        Mov AX, 1701h;
        Int 2Fh;
        Mov iOpen, AX
    }
    
    return( iOpen );
}

static void _ol_CloseClipboard( void )
{
    _asm {
        Mov AX, 1708h;
        Int 2Fh;
    }
}
