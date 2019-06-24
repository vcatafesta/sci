/*****
 *
 *         Name: SeekIt()
 *  Description: Seeks a record on a TBrowse object
 *       Author: Luiz Quintela
 * Date created: 12-31-92
 *    Copyright: Computer Associates
 *
 *    Arguments: xKey      - Key's value
 *             : lSoftSeek - .T. softseek will be on
 *             : oObj      - Browse object
 * Return Value: lFound    - .T. if found, .F. otherwise
 *     See Also: SetHilite()
 *
 */

FUNCTION SeekIt(xKey, lSoftSeek, oObj)
   LOCAL lFound, nRecNo

   nRecNo    := RecNo()
   lSoftSeek := IF(ValType(lSoftSeek) == "L", lSoftSeek, .F.)

   IF !(lFound := DBSeek( xKey, lSoftSeek ))
      IF EoF()
         // Not found.
         // Keep pointer in the same place
         DBGoto(nRecNo)
         oObj:invalidate()

      ELSE
         // Not Found but, SoftSeek is on!
         // But there is that behaviour on TBrowse...
         //
         SetHilite(oObj)

      ENDIF

   ELSE
      // Found!
      // But there is that behaviour on TBrowse...
      //
      SetHilite(oObj)

   ENDIF

   RETURN (lFound)

/*****
 *
 *         Name: SetHilite()
 *  Description: Hilites the correct record
 *       Author: Luiz Quintela
 * Date created: 12-31-92
 *    Copyright: Computer Associates
 *
 *    Arguments: oObj   - TBrowse object
 * Return Value: .T.
 *     See Also: SeekIt()
 *
 */

FUNCTION SetHilite(oObj)
   LOCAL nRecNo := RecNo()

   DispBegin()

   oObj:refreshAll()
   WHILE !oObj:stabilize()
   END

   WHILE (nRecNo != RECNO()) .AND. !(oObj:hitTop())
      oObj:up()
      WHILE !oObj:stabilize()
      END

   END

   DispEnd()
   RETURN (.T.)

// EOF - BROWSEEK.PRG //
