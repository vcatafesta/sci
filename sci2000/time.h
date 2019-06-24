/***
*time.h - definitions/declarations for time routines
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file has declarations of time routines and defines
*   the structure returned by the localtime and gmtime routines and
*   used by asctime.
*   [ANSI/System V]
*
*******************************************************************************/


#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL  cdecl
    #define _NEAR   near
#else /* extensions not enabled */
    #define _CDECL
    #define _NEAR
#endif /* NO_EXT_KEYS */


/* define the implementation defined time type */

#ifndef _TIME_T_DEFINED
typedef long time_t;            /* time value */
#define _TIME_T_DEFINED         /* avoid multiple def's of time_t */
#endif

#ifndef _CLOCK_T_DEFINED
typedef long clock_t;
#define _CLOCK_T_DEFINED
#endif

#ifndef _TM_DEFINED
struct tm {
    int tm_sec;         /* seconds after the minute - [0,59] */
    int tm_min;         /* minutes after the hour - [0,59] */
    int tm_hour;        /* hours since midnight - [0,23] */
    int tm_mday;        /* day of the month - [1,31] */
    int tm_mon;         /* months since January - [0,11] */
    int tm_year;        /* years since 1900 */
    int tm_wday;        /* days since Sunday - [0,6] */
    int tm_yday;        /* days since January 1 - [0,365] */
    int tm_isdst;       /* daylight savings time flag */
    };
#define _TM_DEFINED
#endif

#define CLK_TCK 1000


/* extern declarations for the global variables used by the ctime family of
 * routines.
 */

#ifdef DLL
long far * _CDECL far _timezone(void);
int far * _CDECL far _daylight(void);
char far * far * _CDECL far _tzname(void);

#define daylight    *_daylight()
#define timezone    *_timezone()
#define tzname      _tzname()
#else
extern int _NEAR _CDECL daylight;     /* non-zero if daylight savings time is used */
extern long _NEAR _CDECL timezone;    /* difference in seconds between GMT and local time */
extern char * _NEAR _CDECL tzname[2]; /* standard/daylight savings time zone names */
#endif


/* function prototypes */

char far * far _CDECL asctime(const struct tm far *);
char far * far _CDECL ctime(const time_t far *);
clock_t far _CDECL clock(void);
double far _CDECL difftime(time_t, time_t);
struct tm far * far _CDECL gmtime(const time_t far *);
struct tm far * far _CDECL localtime(const time_t far *);
time_t far _CDECL mktime(struct tm far *);
char far * far _CDECL _strdate(char far *);
char far * far _CDECL _strtime(char far *);
time_t far _CDECL time(time_t far *);
void far _CDECL tzset(void);
