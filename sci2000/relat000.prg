* ETIQUETA MODELO 61,30  PIMACO.
public esc,null,printer,height
esc = chr(27)
null = ""
height = 4
printer = "E"

_ini= 0
_fin= 0
_col= 0
set delete on
X1=0
set color to w+/b
@ 04,01 CLEAR TO 21,79
do while .t.
   use REGISTRO
   set color to w+/b
   @ 23,15 say 'Mensagem : Pressione ESC para sair '
   GO TOP
   @ 04,01 to 19,77
   dbedit(05, 2, 18, 76, {"Numero"}, Nil, Nil, {"Telefones Cadastrados"})
   set color to W+/r
   _conf   = space(01)
   @ 23,15 say 'Confirma o inicio da impressao das Etiquetas (S/N) : '
   set color to n/w
   @ 23,69 GET _conf
   set cursor on
   read
   set cursor off
   if lastkey()=27
       set color to w+/b
       @ 04,01 CLEAR TO 21,79
       close database
       retu .t.
   endif
   m = space(10)
   N = space(10)
   O = space(10)
   if _conf = 'S' .or. _conf = 's'
      do while NUMERO=NUMERO .and. .not. eof()
         MESSAGE=NUMERO
         if printer = "L"
            do setup_hp
         elseif printer = "E"
            do setup_epson
         endif
         do DEF_CODE39
         m->MESSAGE = "*"+trim(m->MESSAGE)+"*"
         set device to print
         ***** print barcoded m->MESSAGE *****
          @ prow()+height,00 say barcode(m->MESSAGE)
         ***** Print message text below barcode ****
         @ prow()+if(printer="L",height,0),int(len(m->MESSAGE)/4) say m->MESSAGE
         @ prow()+3,000 say ''
         skip
      enddo
   Else
      set device to screen
      set color to w+/b
      @ 04,01 CLEAR TO 21,79
      set color to n/w
      @ 23,15 SAY '                                                               '
      set color to w+/b
      set cursor on
      retu .f.
   Endif
   set color to w+/b
   @ 04,01 CLEAR TO 21,79
   set color to n/w
   @ 23,15 SAY '                                                               '
   set device to screen
   set cursor on
Enddo
retu .t.


function barcode
parameters MESSAGE
code = ""

do case
case printer = "L"
* read message character at a time and build barcode
for i = 1 to len(m->MESSAGE)
letter = substr(m->MESSAGE,i,1)
code = code + if(at(letter,chars)=0,letter,char[at(letter,chars)]) + NS
next
code = start + code + end

case printer = "E"
for h = 1 to height
for i = 1 to len(m->MESSAGE)
letter = substr(m->MESSAGE,i,1)

* build barcoded string
code = if(at(letter,chars)=0,letter,char[at(letter,chars)]) + NS

* print barcode character at a time on Epson
printcode(esc + chr(76) + chr(N1) + chr(N2) + code)
next

* perform 23/216 line feed
printcode(esc+chr(74)+chr(23)+chr(13))
next

* perform 5/216 line feed
printcode(esc+chr(74)+chr(5)+chr(13))
* reset printer to turn off graphics and reset to 10cpi
printcode(esc+"@")

endcase

return code
***** End of Function(BARCODE) *****


*****************
***
*** Procedure: Setup_HP
*** Purpose: Defines characters for HP LaserJet
*** Parameters: None
*** Returns: Initialized Public variables
***
*****************

procedure setup_hp
public nb,wb,ns,ws,start,end
*** define bars and spaces for HP LaserJet II
small_bar = 3 && number of points per bar
wide_bar = round(small_bar * 2.25,0) && 2.25 x small_bar
dpl = 50 && dots per line 300dpi/6lpi = 50dpl

nb = esc+"*c"+transform(small_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+esc+"*p+"+transform(small_bar,'99')+"X"
wb = esc+"*c"+transform(wide_bar,'99')+"a"+alltrim(str(height*dpl))+"b0P"+esc+"*p+"+transform(wide_bar,'99')+"X"
ns = esc+"*p+"+transform(small_bar,'99')+"X"
ws = esc+"*p+"+transform(wide_bar,'99')+"X"

*** adjust cusor position to start at top of line and return to bottom of line
start = esc+"*p-50Y"
end = esc+"*p+50Y"

return
***** End of Procedure(SETUP_HP) *****

*****************
***
*** Procedure: Setup_Epson
*** Purpose: Defines characters for Espon or IBM Graphics printer
*** Parameters: None
*** Returns: Initialized Public variables
***
*****************

procedure setup_epson
public nb,wb,ns,ws,n1,n2
***** define Epson bars and spaces
ns = chr(0) + chr(0)
ws = chr(0) + chr(0) + chr(0) + chr(0)
nb = chr(255)
wb = chr(255) + chr(255) + chr(255)

***** set printer to 2/216 lines per inch
printcode(esc+chr(51)+chr(2)) 

***** calculate N1 and N2 values for dot graphics command
cols = 21
N1 = cols % 256 && modulus 
N2 = INT(cols/256)

return 
***** End of Procedure(SETUP_EPSON) *****
procedure def_code39
public char[46], chars

chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%()"
*chars = "1234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ-. *$/+%!#&'(),:;<=>?@]\[^_`abcdefghijklmnopqrstuvwxyz{|}~"

CHAR[01] = WB+NS+NB+WS+NB+NS+NB+NS+WB && "1"
CHAR[02] = NB+NS+WB+WS+NB+NS+NB+NS+WB && "2"
CHAR[03] = WB+NS+WB+WS+NB+NS+NB+NS+NB && "3"
CHAR[04] = NB+NS+NB+WS+WB+NS+NB+NS+WB && "4"
CHAR[05] = WB+NS+NB+WS+WB+NS+NB+NS+NB && "5"
CHAR[06] = NB+NS+WB+WS+WB+NS+NB+NS+NB && "6"
CHAR[07] = NB+NS+NB+WS+NB+NS+WB+NS+WB && "7"
CHAR[08] = WB+NS+NB+WS+NB+NS+WB+NS+NB && "8"
CHAR[09] = NB+NS+WB+WS+NB+NS+WB+NS+NB && "9"
CHAR[10] = NB+NS+NB+WS+WB+NS+WB+NS+NB && "0"
CHAR[11] = WB+NS+NB+NS+NB+WS+NB+NS+WB && "A"
CHAR[12] = NB+NS+WB+NS+NB+WS+NB+NS+WB && "B"
CHAR[13] = WB+NS+WB+NS+NB+WS+NB+NS+NB && "C"
CHAR[14] = NB+NS+NB+NS+WB+WS+NB+NS+WB && "D"
CHAR[15] = WB+NS+NB+NS+WB+WS+NB+NS+NB && "E"
CHAR[16] = NB+NS+WB+NS+WB+WS+NB+NS+NB && "F"
CHAR[17] = NB+NS+NB+NS+NB+WS+WB+NS+WB && "G"
CHAR[18] = WB+NS+NB+NS+NB+WS+WB+NS+NB && "H"
CHAR[19] = NB+NS+WB+NS+NB+WS+WB+NS+NB && "I"
CHAR[20] = NB+NS+NB+NS+WB+WS+WB+NS+NB && "J"
CHAR[21] = WB+NS+NB+NS+NB+NS+NB+WS+WB && "K"
CHAR[22] = NB+NS+WB+NS+NB+NS+NB+WS+WB && "L"
CHAR[23] = WB+NS+WB+NS+NB+NS+NB+WS+NB && "M"
CHAR[24] = NB+NS+NB+NS+WB+NS+NB+WS+WB && "N"
CHAR[25] = WB+NS+NB+NS+WB+NS+NB+WS+NB && "O"
CHAR[26] = NB+NS+WB+NS+WB+NS+NB+WS+NB && "P"
CHAR[27] = NB+NS+NB+NS+NB+NS+WB+WS+WB && "Q"
CHAR[28] = WB+NS+NB+NS+NB+NS+WB+WS+NB && "R"
CHAR[29] = NB+NS+WB+NS+NB+NS+WB+WS+NB && "S"
CHAR[30] = NB+NS+NB+NS+WB+NS+WB+WS+NB && "T"
CHAR[31] = WB+WS+NB+NS+NB+NS+NB+NS+WB && "U"
CHAR[32] = NB+WS+WB+NS+NB+NS+NB+NS+WB && "V"
CHAR[33] = WB+WS+WB+NS+NB+NS+NB+NS+NB && "W"
CHAR[34] = NB+WS+NB+NS+WB+NS+NB+NS+WB && "X"
CHAR[35] = WB+WS+NB+NS+WB+NS+NB+NS+NB && "Y"
CHAR[36] = NB+WS+WB+NS+WB+NS+NB+NS+NB && "Z"
CHAR[37] = NB+WS+NB+NS+NB+NS+WB+NS+WB && "-"
CHAR[38] = WB+WS+NB+NS+NB+NS+WB+NS+NB && "."
CHAR[39] = NB+WS+WB+NS+NB+NS+WB+NS+NB && " "
CHAR[40] = NB+WS+NB+NS+WB+NS+WB+NS+NB && "*"
CHAR[41] = NB+WS+NB+WS+NB+WS+NB+NS+NB && "$"
CHAR[42] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "/"
CHAR[43] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "+"
CHAR[44] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "%"
CHAR[45] = NB+WS+NB+WS+NB+NS+NB+WS+NB+NS+WB+NS+NB+NS+NB+WS+WB+NS+NB    && "("
CHAR[46] = NB+WS+NB+WS+NB+NS+NB+WS+NB+NS+NB+NS+WB+NS+NB+WS+WB+NS+NB    && ")"
*
*CHAR[45] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "!"
*CHAR[46] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "#"
*CBAR[47] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "&"
*CHAR[48] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "'"
*CHAR[49] = NB+WS+NB+WS+NB+NS+NB+WS+NB && "("
*CHAR[50] = NB+WS+NB+WS+NB+NS+NB+WS+NB && ")"
*CHAR[51] = NB+WS+NB+WS+NB+NS+NB+WS+NB && ","
*CHAR[52] = NB+WS+NB+WS+NB+NS+NB+WS+NB && ":"
*CHAR[53] = NB+NS+NB+WS+NB+WS+NB+WS+NB && ";"
*CHAR[54] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "<"
*CHAR[55] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "="
*CHAR[56] = NB+NS+NB+WS+NB+WS+NB+WS+NB && ">"
*CHAR[57] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "?"
*CHAR[58] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "@"
*CHAR[59] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "]"
*CHAR[60] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "\"
*CHAR[61] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "["
*CHAR[62] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "^"
*CHAR[63] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "_"
*CHAR[64] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "`"
*CHAR[65] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "a"
*CHAR[66] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "b"
*CHAR[67] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "c"
*CHAR[68] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "d"
*CHAR[69] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "e"
*CHAR[70] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "f"
*CHAR[71] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "g"
*CHAR[72] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "h"
*CHAR[73] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "i"
*CHAR[74] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "j"
*CHAR[75] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "k"
*CHAR[76] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "l"
*CHAR[77] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "m"
*CHAR[78] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "n"
*CHAR[79] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "o"
*CHAR[80] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "p"
*CHAR[81] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "q"
*CHAR[82] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "r"
*CHAR[83] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "s"
*CHAR[84] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "t"
*CHAR[85] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "u"
*CHAR[86] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "v"
*CHAR[87] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "w"
*CHAR[88] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "x"
*CHAR[89] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "y"
*CHAR[90] = NB+WS+NB+NS+NB+WS+NB+WS+NB && "z"
*CHAR[91] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "{"
*CHAR[92] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "|"
*CHAR[93] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "}"
*CHAR[94] = NB+NS+NB+WS+NB+WS+NB+WS+NB && "~"
return
***** End of Procedure(DEF_CODE39) *****

*****************
***
*** Function: Printcode
*** Purpose: Sends escape codes to printer
*** Parameters: Character string or escape sequence
*** Returns: Nothing
***
*****************

function printcode
parameters code
set console off
set print on
?? code
set print off
set console on
return null
***** End of Function(PRINTCODE) *****
