Program Normal;

Uses Crt, Dos;

Procedure Inicio;
Begin
  Verde;
  WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴');
  Branco;
  WriteLn('NORMAL  Restaurador de modo de Video.');
  WriteLn('Copyright (c) Macrosoft Informatica 1992,97.');
  Verde;
  WriteLn('컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴컴');
End ;

Function Alt254 : String;
Begin
  Alt254 := #254#32 ;
End;

Procedure MostraData;
const
  Dias : array [0..6] of String[7] = ('Domingo', 'Segunda', 'Terca', 'Quarta', 'Quinta', 'Sexta', 'Sabado');
var
  y, m, d, dow : Word;
begin
  GetDate( y, m, d, dow );
  Writeln( Alt254, dias[ dow ],', ', d:0, '/', m:0, '/', y:0);
end;

Procedure Versao;
Var
  Ver : Word;
Begin
  Ver := DosVersion;
  WriteLn( Alt254, 'OS Versao ', Lo(Ver), '.', Hi(Ver));
End;

Begin { Corpo do Sistema }
  Sound( 220 );
  { Delay(100); }
  TextMode( CO80);
  NoSound;
  Inicio;
  WriteLn( Alt254, DiskSize(0), ' Bytes Total');
  WriteLn( Alt254, DiskFree(0), ' Bytes livres');
  MostraData;
  Versao;
End.
