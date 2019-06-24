  @Echo Off
  Goto DoLists
:Return
  FT_Doc OSLib.Mnu
  If Exist Assembl.Bat Call Assembl.Bat
  Del *.Ngo > Nul
  Del *.Txt > Nul
  Del *.Log > Nul
  Del Assembl.Bat > Nul
  Del Ngi\*.* /Y > Nul
  If Exist OSLib.Ng Move OSLib.NG ..\Ng
  Goto End

Rem This bit of code will compile any "lists" or tables that I want
Rem to include in the Norton guide. FT_Doc will not handle these and
Rem it's easier to do it like this that to start mucking around with
Rem the source for FT_Doc.

:DoLists
  Echo Compiling Source Files in Docs\
  For %a In (Docs\*.Txt) Do Ngc %a
  Move Docs\*.Ngo > Nul
  Goto Return

:End
