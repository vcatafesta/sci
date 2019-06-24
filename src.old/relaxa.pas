Program Relaxa;

Uses Crt;

Procedure Janelas;
Var
  x       : Byte;
  y       : Byte;
  nMaxRow : Byte;
  nMaxCol : Byte;

Begin
  nMaxRow := 25;
  nMaxCol := 80;
  TextBackGround( Black );
  ClrScr;
  Repeat
     x := Succ( Random( nMaxCol));
     y := Succ( Random( nMaxRow));
     Window( x, y, x + Random(10), y + Random(8));
     TextBackGround( Random( 16 ));
     ClrScr;
  Until KeyPressed;
End;

Begin
  Janelas;
  TextMode( CO80 );
  ClrScr;
  TextColor( Green );
  WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�');
  TextColor( White );
  Writeln('RELAXA  Um Relax para seu monitor.');
  Writeln('Copyright (c) Macrosoft Sistemas de Informatica 1991,97.');
  TextColor( Green );
  WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴�');
End.
