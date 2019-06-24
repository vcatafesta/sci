#include <stdio.h>
#include <stdlib.h>

unsigned int numero;
unsigned int contador = 0;

int main(void)
{
   unsigned int base = 1;
   printf("Tabuada em C, Copyright (c) Vilmar Catafesta, 2016\n\n");
   printf("Digite o numero da tabuada :");
   scanf("%d", &numero);

   for(base=1; base<11;base++){
      printf("\t%2d x %2d = %2d\n", numero, base, numero * base);
   }

   return 0;
}

