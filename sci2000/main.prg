Textblock C:\WIN95_CD\APP\SCI2000\MAIN.PRG
// 06/12/116 20:55:23

function main()

@10, 10 say transform( recno()/lastrec()*100, "@R 999.99%")
return .t.
 