cls
nchar = 0
while lastkey() != 27
   @ 10, 10 Say "Numero UTF-8" get nChar
   read
   @ 10, Row() +1 say HB_UCHAR(nchar)
end
