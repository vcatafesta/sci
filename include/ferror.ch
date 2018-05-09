#ifndef _FERROR_CH_
#define _FERROR_CH_

#define F_ERRO                    !(0)
#define FERROR_OK                 0  //            Successful
#define FERROR_FILENOTFOUND       2  //            File not found
#define FERROR_PATHNOTFOUND       3  //            Path not found
#define FERROR_TOMANYFILESOPEN    4  //            Too many files open
#define FERROR_ACESSDENIED        5  //            Access denied
#define FERROR_INVALIDHANDLE      6  //            Invalid handle
#define FERROR_INSUFFICIENTMEMORY 8  //            Insufficient memory
#define FERROR_INVALIDDRIVE      15  //            Invalid drive specified
#define FERROR_WRITEPROTECT      19  //            Attempted to write to a write-protected disk
#define FERROR_DRIVENOTREADY     21  //            Drive not ready
#define FERROR_CRCERROR          23  //            Data CRC error
#define FERROR_WRITEFAULT        29  //            Write fault
#define FERROR_READFAULT         30  //            Read fault
#define FERROR_SHAREVIOLATION    32  //            Sharing violation
#define FERROR_LOCKVIOLATION     33  //            Lock Violation
#endif /* _DEFINE_CH_ */