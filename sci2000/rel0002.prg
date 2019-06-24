*------------------------------------------------------------------------------*
* Autor        : Luciano Borges Mancini                                        *
*------------------------------------------------------------------------------*
public esc,null,printer,height
esc = chr(27)
null = ""
height = 4
printer = "L"
sele 1
use REGISTRO
if lastkey() = 27
        close data
        Keyboard(chr(27))
        return
Endif
declare _op[10]
afill(_op,space(10))
set color to w+/B
@ 04,00 clear to 21,79
set color to w+/B
@ 06,06 say 'Digite at‚ 10 numeros cadastrados para listagem de etiquetas: '
set color to n/w,w/g+
x = 0
for a=10 to 19
        x = x+1
        @ a,15 get _op[a-9]
next
set cursor on
read
set cursor off
if lastkey() = 27
        close data
        Keyboard(chr(27))
        return
endif
go top
if .not. impok()
        close data
        return
endif
@ 23,15 say 'Aguarde: imprimindo...'
set device to print
@ prow(),pcol() say chr(27)+'@'+chr(15)+' '
@ prow(),001 say ''
set devi to print
set print on
set cons off
lin = 99
pag = 0
begin sequence
for a=1 to 10
    if empty(_op[a])
       break
    endif
    index on numero to REGISTRO
    _num = _op[a]
    seek _num
    if found()
        do while numero =_num .and. .not. eof()
          MESSAGE=_num
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
          ***** Print message text below barcode *****
          @ prow()+if(printer="L",height,0),int(len(m->MESSAGE)/4) say m->MESSAGE
          @ prow()+2,000 say ''
          skip
        enddo
   endif
next
end sequence
set color to w+/B
@ 04,00 clear to 21,79
set color to n/w
@ 23,15 SAY '                                                               '
set color to w+/b
@ 23,15 say 'Mensagem : Pressione ESC para sair '
set devi to screen
set print off
set cons on
close data
erase clt01.ntx
return

