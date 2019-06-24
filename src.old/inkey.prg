function main()
qout("Tecle uma tecla: ESC sair.")
while lastkey() != 27
	ch := inkey(0)
	Qout("Codigo ASCII : ", ch)
enddo	