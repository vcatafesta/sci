/*****
 *
 *    File Name: BROWRDD.CH
 *  Description: RDD demo program
 *       Author: Luiz Quintela
 * Date created: 12-29-92
 *    Copyright: 1992 by Computer Associates
 *
 */

#define BRO_1_COLOR                 "N/W*,GR+/R*,N"
#define BRO_2_COLOR                 "W+/BG,B/BG*,N"
#define BRO_3_COLOR                 "W+/W,N/GR*,N"
#define BRO_4_COLOR                 "N+/BG*,W+/G,N"

#define BRO_HEAD_SEP                CHR(205) + CHR(209) + CHR(205)
#define BRO_COL_SEP                 CHR(32)  + CHR(179) + CHR(32)

#define SCR_BROW1_TITLE             "Clipper  - NTX"
#define SCR_BROW2_TITLE             "dBASE IV - MDX"
#define SCR_BROW3_TITLE             "FoxPro   - CDX"
#define SCR_BROW4_TITLE             "Paradox  - DB"
#define SCR_OPTIONS_TITLE           "ESC - Quit     TAB/SH_TAB - Shift Focus     " +;
                                    "F1 - About     F2 - Copy"
#define SCR_PLEASEWAIT              "Please Wait..."
#define SCR_COPYFROM                "Copy from "
#define SCR_TO                      " to "

#define SCR_COPY_COLOR              "W+/RB,W/RB,W+/RB"
#define SCR_MAIN_BGND_COLOR         "W+/B*"
#define SCR_ABOUT_COLOR             "W+/RB"
#define SCR_OPTIONS_COLOR           "BG+/B"
#define SCR_COPYRECO_COLOR          "W+/RB"

#define ERR_DATABASE_OPEN           "Unable to open database/index file(s);" +;
                                    "Please check file availability"
#define ERR_CANNOT_COPY_RECORD      "Sorry! I am not allowed to "      +;
                                    "append what is already there"
#define ERR_COLOR                   "BG+/RB*,W+/B*"

#define NO_OF_BROWSES               4
#define NTX                         1
#define CDX                         2
#define MDX                         3
#define PDX                         4

#define FNAME                       "First Name"
#define LNAME                       "Last Name"
#define DEPT                        "Department"

#define MSG_CREATE                  "Creating demo files..."
#define TIME_TO_WAIT_ON_HELP_SCREEN 60

#xtranslate ErrMsg(<cMsg>, [<aArr>], [<cClr>]) => ;
                                    Alert(<cMsg>, <aArr>, <cClr>)

// EOF - BROWRDD.CH //
