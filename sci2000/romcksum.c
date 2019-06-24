#include "extend.h"                  /* Declare Extend System */
#include "stdio.h"                   /* standard io library */
#include "conio.h"                   /* standard io library */
#include "math.h"                    /* standard math libaray */

/*
compilar tcc -ml -c romcksum
*/


CLIPPER romcksum()
{
	unsigned long checksum = 0;
	unsigned int offset;
	unsigned char far *ptr;
	ptr = ((unsigned char far *) (0xFE00L << 16));
   for(offset = 0; offset <= 0x1FFF; offset++){
       /* printf("Conta %d", checksum); */
        checksum += *(ptr + offset);
   }
   _retnl(checksum);

}
