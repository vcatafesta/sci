/*****
 *
 *          Name: RddInit()
 *   Description: Disables auto-loading of default driver
 *                and requests linking of all drivers
 *        Author: Luiz Quintela
 *  Date created: 03-05-93
 *     Copyright: Computer Associates
 *
 *    Parameters: None
 *
 */

ANNOUNCE RDDSYS
INIT PROCEDURE RddInit()
   // No driver is set as default
   // Forces drivers to be linked in
   REQUEST DBFNTX
   REQUEST DBFCDX
   REQUEST DBFMDX
   REQUEST DBPX
   RETURN

// EOF - RDDSYS.PRG //
