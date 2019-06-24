/*
Compile com Borland Turbo C
tcc -ml -c b_fupper.c

Compile Your C Program With MSC 5.1
cl /c /AL /FPa /Gs /Oalt /Zl b_fupper.c 
 
#Your Clipper Program
function main()
   cls
   qout(b_fupper("hElLo wOrLd!"))
   return(NIL)


*/

#include <stdio.h>
#include <ctype.h>
#include <extend.h>

#define     NOT_ALPHA(x)   ( ((x<65) || (x>91 && x<97) || (x>123)) == 1 )


CLIPPER b_fupper()
{
    int i = 0;
    int lw_space = 1;
    int str_len = strlen(_parc(1));

    if( !ISCHAR(1) ){
        _retc(NULL);
        return;
    }

    for(i=0; i<str_len; i++){
        if( NOT_ALPHA(_parc(1)[i]) ){
            lw_space = 1;
        }
        if( (isalpha(_parc(1)[i])) && (lw_space == 1) && _parc(1)[i] != NULL){
            _parc(1)[i] = toupper(_parc(1)[i]);
            lw_space = 0;
        }
        else{
            _parc(1)[i] = tolower(_parc(1)[i]);
        }
    }
    _retc(_parc(1));
    return;
}
    
