/*
 * Author....: Dave Pearson
 */

#include <cpmi.h>
#include <extend.api>

#pragma optimize("lge", off)

#define _OL_FP_OFF(fp)     ((unsigned)((unsigned long)fp))
#define _OL_FP_SEG(fp)     ((unsigned)((unsigned long)(fp) >> 16))
#define _OL_MK_FP(seg,ofs) ((void far *)(((unsigned long)(seg) << 16) | (unsigned)(ofs)))

/* Clipper internals. */
char *strcpy( char *, const char * );
void _bset( void *, char, unsigned );

/* Local support. */
static void _ol_SetTitle( int, char far *, int );
static void _ol_GetTitle( int, char far *, int );

/*  $DOC$
 *  $FUNCNAME$
 *      OL_95AppTitle()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Set/get the Windows 95 application title.
 *  $SYNTAX$
 *      OL_95AppTitle( [<cNew>] ) --> cOld
 *  $ARGUMENTS$
 *      <cNew> is the optional new title.
 *  $RETURNS$
 *      The current title.
 *  $DESCRIPTION$
 *      OL_95AppTitle() can be used to set/get the application title. This is
 *      the right hand text you see displayed on a DOS session's title bar.
 *
 *      NOTE: Because this function needs to do some extra stuff when your
 *      application is running in protected mode I've had to make use of
 *      the CPMI library. You ^Bmust^b link this in if you intend to use
 *      this function, even if you are linking for real mode operation.
 *  $EXAMPLES$
 *      // Fiddle with the application title.
 *
 *      Local cOldTitle := OL_95AppTitle( "Month end routine" )
 *
 *      MonthEnd()
 *      OL_95AppTitle( cOldTitle )
 *  $SEEALSO$
 *      OL_95VMTitle()
 * $END$
 */
    
CLIPPER OL_95AppTi/*tle*/( void )
{
    char szTitle[ 80 ];

    _bset( szTitle, 0, sizeof( szTitle ) );
    _ol_GetTitle( 2, (char far *) szTitle, sizeof( szTitle ) );
    _retc( szTitle );
    
    if ( PCOUNT && ISCHAR( 1 ) )
    {
        _ol_SetTitle( 0, _parc( 1 ), _parclen( 1 ) );
    }
}

/*  $DOC$
 *  $FUNCNAME$
 *      OL_95VMTitle()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Set/get the Windows 95 virtual machine title.
 *  $SYNTAX$
 *      OL_95VMTitle( [<cNew>] ) --> cOld
 *  $ARGUMENTS$
 *      <cNew> is the optional new title.
 *  $RETURNS$
 *      The current title.
 *  $DESCRIPTION$
 *      OL_95VMTitle() can be used to set the virtual machine title. This is
 *      the left hand text you see displayed on a DOS session's title bar.
 *
 *      NOTE: Because this function needs to do some extra stuff when your
 *      application is running in protected mode I've had to make use of
 *      the CPMI library. You ^Bmust^b link this in if you intend to use
 *      this function, even if you are linking for real mode operation.
 *  $EXAMPLES$
 *      // Fiddle with the virtual machine title.
 *
 *      Local cOldTitle := OL_95VMTitle( "Stock System" )
 *
 *      // ...
 *      OL_95VMTitle( cOldTitle )
 *  $SEEALSO$
 *      OL_95AppTitle()
 * $END$
 */

CLIPPER OL_95VMTit/*le*/( void )
{
    char szTitle[ 30 ];

    _bset( szTitle, 0, sizeof( szTitle ) );
    _ol_GetTitle( 3, szTitle, sizeof( szTitle ) );
    _retc( szTitle );
    
    if ( PCOUNT && ISCHAR( 1 ) )
    {
        _ol_SetTitle( 1, _parc( 1 ), _parclen( 1 ) );
    }
}

static void _ol_SetTitle( int iType, char far *pszTitle, int iLen )
{
    if ( cpmiIsProtected() )
    {
        SELECTOR selTitle    = cpmiAllocateDOSMem( iLen + 1 );
        char     *pszRMTitle = _OL_MK_FP( selTitle, 0 );
        CPUREGS  regs;

        strcpy( pszRMTitle, pszTitle );
        
        regs.Reg.AX = 0x168E;
        regs.Reg.DX = iType;
        regs.Reg.ES = _OL_FP_SEG( cpmiRealPtr( pszRMTitle ) );
        regs.Reg.DI = _OL_FP_OFF( cpmiRealPtr( pszRMTitle ) );
        cpmiInt86( 0x2F, &regs, &regs );
        
        cpmiFreeDOSMem( selTitle );
    }
    else
    {
        unsigned uSeg = _OL_FP_SEG( pszTitle );
        unsigned uOff = _OL_FP_OFF( pszTitle );
        
        _asm {
            Push DI;
            Mov AX, 168Eh;
            Mov DX, iType;
            Mov ES, uSeg;
            Mov DI, uOff;
            Int 2Fh;
            Pop DI;
        }
    }
}

static void _ol_GetTitle( int iType, char far *pszBuf, int iLen )
{
    if ( cpmiIsProtected() )
    {
        SELECTOR selBuf    = cpmiAllocateDOSMem( iLen );
        char     *pszRMBuf = _OL_MK_FP( selBuf, 0 );
        CPUREGS  regs;

        regs.Reg.AX = 0x168E;
        regs.Reg.DX = iType;
        regs.Reg.CX = iLen;
        regs.Reg.ES = _OL_FP_SEG( cpmiRealPtr( pszRMBuf ) );
        regs.Reg.DI = _OL_FP_OFF( cpmiRealPtr( pszRMBuf ) );
        cpmiInt86( 0x2F, &regs, &regs );
        
        strcpy( pszBuf, pszRMBuf );
        
        cpmiFreeDOSMem( selBuf );
    }
    else
    {
        unsigned uSeg = _OL_FP_SEG( pszBuf );
        unsigned uOff = _OL_FP_OFF( pszBuf );
        
        _asm {
            Push DI;
            Mov AX, 168Eh;
            Mov DX, iType;
            Mov CX, iLen;
            Mov ES, uSeg;
            Mov DI, uOff;
            Int 2Fh;
            Pop DI;
        }
    }
}
