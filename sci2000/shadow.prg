/*****
 *
 *         Name: Shadow()    
 *  Description: A "shadow" with "see-thru"       
 *       Author: Luiz Quintela
 * Date created: 03-12-93
 *    Copyright: Computer Associates International, Inc.
 *
 *   Parameters: nTop 
 *             : nLeft
 *             : nBottom
 *             : nRight  - Windows coordinates
 *
 */

PROCEDURE Shadow(nTop, nLeft, nBottom, nRight)
   LOCAL nShadowLen, cShadow

   cShadow := SaveScreen( nTop, nLeft, nBottom, nRight )
   nShadowLen := Len(cShadow)

   RestScreen( nTop, nLeft, nBottom, nRight,;
               Transform(cShadow, Replicate("X" + Chr(7), nShadowLen)))
   RETURN

// EOF - SHADOW.PRG //
