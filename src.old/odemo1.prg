/*
����������������������������������������������������������������������ͻ
�                                o:Clip                                �
�             An Object Oriented Extension to Clipper 5.01             �
�                 (c) 1991 Peter M. Freese, CyberSoft                  �
����������������������������������������������������������������������ͼ

Version 1.01 - November 8, 1991
*/
#include "oclip.ch"

LOCAL o1 := Sample1():New("World")
        o1:Hello()
        RETURN

CLASSE Sample1
  VAR Who
  METHOD New
  METHOD Hello
ENDCLASSE

METODO New(cWho)
  ::Who := cWho
RETURN Self

METODO Hello
  ? "Hello",::Who
RETURN Self

