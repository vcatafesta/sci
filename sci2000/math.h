/***
*math.h - definitions and declarations for math library
*
*   Copyright (c) 1985-1988, Microsoft Corporation.  All rights reserved.
*
*Purpose:
*   This file contains constant definitions and external subroutine
*   declarations for the math subroutine library.
*   [ANSI/System V]
*
*******************************************************************************/


#ifndef NO_EXT_KEYS /* extensions enabled */
    #define _CDECL   cdecl
#else /* extensions not enabled */
    #define _CDECL
#endif /* NO_EXT_KEYS */


/* definition of exception struct - this struct is passed to the matherr
 * routine when a floating point exception is detected
 */

#ifndef _EXCEPTION_DEFINED
struct exception {
    int type;           /* exception type - see below */
    char far *name;   /* name of function where error occured */
    double arg1;        /* first argument to function */
    double arg2;        /* second argument (if any) to function */
    double retval;      /* value to be returned by function */
    } ;
#define _EXCEPTION_DEFINED
#endif


/* definition of a complex struct to be used by those who use cabs and
 * want type checking on their argument
 */

#ifndef _COMPLEX_DEFINED
struct complex {
    double x,y;     /* real and imaginary parts */
    } ;
#define _COMPLEX_DEFINED
#endif


/* Constant definitions for the exception type passed in the exception struct
 */

#define DOMAIN      1   /* argument domain error */
#define SING        2   /* argument singularity */
#define OVERFLOW    3   /* overflow range error */
#define UNDERFLOW   4   /* underflow range error */
#define TLOSS       5   /* total loss of precision */
#define PLOSS       6   /* partial loss of precision */

#define EDOM        33
#define ERANGE      34


/* definitions of HUGE and HUGE_VAL - respectively the XENIX and ANSI names
 * for a value returned in case of error by a number of the floating point
 * math routines
 */

#ifndef DLL
extern double HUGE;
#define HUGE_VAL HUGE

#else   /* DLL */
#define HUGE        1.7976931348623158e+308    /* max value */
#define HUGE_VAL    1.7976931348623158e+308    /* max value */
#endif  /* DLL */


/* function prototypes */

int    far _CDECL abs(int);
double far pascal acos(double);
double far pascal asin(double);
double far pascal atan(double);
double far pascal atan2(double, double);
double far pascal atof(const char far *);
double far pascal cabs(struct complex);
double far pascal ceil(double);
double far pascal cos(double);
double far pascal cosh(double);
int    far _CDECL dieeetomsbin(double far *, double far *);
int    far _CDECL dmsbintoieee(double far *, double far *);
double far pascal exp(double);
double far pascal fabs(double);
int    far _CDECL fieeetomsbin(float far *, float far *);
double far pascal floor(double);
double far pascal fmod(double, double);
int    far _CDECL fmsbintoieee(float far *, float far *);
double far pascal frexp(double, int far *);
double far pascal hypot(double, double);
double far pascal j0(double);
double far pascal j1(double);
double far pascal jn(int, double);
long   far _CDECL labs(long);
double far pascal ldexp(double, int);
double far pascal log(double);
double far pascal log10(double);
int    far _CDECL matherr(struct exception far *);
double far pascal modf(double, double far *);
double far pascal pow(double, double);
double far pascal sin(double);
double far pascal sinh(double);
double far pascal sqrt(double);
double far pascal tan(double);
double far pascal tanh(double);
double far pascal y0(double);
double far pascal y1(double);
double far pascal yn(int, double);

