/*
 * Author....: Dave Pearson, heavily stolen from Ted Means
 */

#include <extend.h>

#pragma optimize("lge", off)

// A (whisper it) static to hold the registration handle.

static USHORT uHandle = 0;

// Structure of a Clipper event.

typedef struct
{
    USHORT uUnknown;
    USHORT uID;
} EVENT;

// *** WARNING ***: Clipper internals, beware!!!!

USHORT _evRegReceiverFunc( void *, USHORT );
void   _evDeregReceiver( USHORT );

// From yield.asm

void pascal _ol_yield( void );

// Prototype local functions.

void _OL_AutoYieldToOS( EVENT * );

/*  $DOC$
 *  $FUNCNAME$
 *      OL_AutoYield()
 *  $CATEGORY$
 *      Functions
 *  $ONELINER$
 *      Automaticly return times slices back to the OS.
 *  $SYNTAX$
 *      OL_AutoYield( [<lOn>] ) --> lOld
 *  $ARGUMENTS$
 *      <lOn> is an optional logical variable that tells the function if
 *      it should turn the yielding on or off. If not supplied the function
 *      just returns the current setting.
 *  $RETURNS$
 *      The current/old setting.
 *  $DESCRIPTION$
 *      OL_AutoYield() can be used to yield time slices back to the
 *      operating system in those situations where you don't have access
 *      to or control over the code that is causing the slice hogging.
 *      For example, if you were to use Clipper's "Menu To" command you
 *      would not be able to make use of the OL_Yield() function so
 *      turning on OL_AutoYield() will allow the yielding of times slices.
 *  $EXAMPLES$
 *      // Turn on auto yielding.
 *
 *      OL_AutoYield( TRUE )
 *  $SEEALSO$
 *      
 *  $END$
 */

CLIPPER OL_AutoYie/*ld*/( void )
{
    _retl( uHandle );
    
    if ( PCOUNT && ISLOG( 1 ) )
    {
        if ( _parl( 1 ) )
        {
            if ( uHandle )
            {
                _evDeregReceiver( uHandle );
            }
            uHandle = _evRegReceiverFunc( _OL_AutoYieldToOS, 0x6001 );
        }
        else
        {
            _evDeregReceiver( uHandle );
            uHandle = 0;
        }
    }
}

// Hidden internal.

static void _OL_AutoYieldToOS( EVENT *pEvent )
{
    if ( pEvent->uID == 0x5108 )
    {
        _ol_yield();
    }
}
