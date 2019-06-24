/*****
 *
 *   Application: General Purpose Routine
 *   Description: Save/Restore Settings
 *     File Name: SETUTI.PRG
 *        Author: Luiz Quintela
 *  Date created: 12-29-92
 *     Copyright: 1992 by Computer Associates
 *
 */

#include "set.ch"

#define     MAX_ARR_SIZE        4096

// Status Array
STATIC aStatus := {}

/*****
 *
 *         Name: PushSets()
 *  Description: Saves settings
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: VOID
 * Return Value: lRet - .T. success, .F. otherwise
 *     See Also: PopSets()
 *
 */

FUNCTION PushSets()
   LOCAL aSub[_SET_COUNT]                        // Array size
   LOCAL lRet := .F.                             // Be pessimist

   // Check for maximum array size
   IF Len(aStatus) < MAX_ARR_SIZE
      // Load Array with SETs
      AEval( aSub, {|x,i| aSub[i] := Set(i)} )

      lRet := (AAdd( aStatus, aSub ) == aSub)

   ENDIF

   RETURN (lRet)


/*****
 *
 *         Name: PopSets()
 *  Description: Restores settings
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: Computer Associates
 *
 *    Arguments: VOID
 * Return Value: lRet - .T. success, .F. otherwise
 *     See Also: PushSets()
 *
 */

FUNCTION PopSets()
   LOCAL aSub := ATAIL(aStatus)                  // Last subarray
   LOCAL lRet := .F.                             // Be pessimist

   // Check array size
   IF Len(aStatus) > 0
      // Restore status from array
      AEval( aSub, {|x,i| Set(i, x)} )

      // Resize array
      ASize( aStatus, Len(aStatus) - 1 )
      lRet := .T.

   ENDIF

   RETURN (lRet)

// EOF - SETUTI.PRG //
