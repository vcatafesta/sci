/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ?
 İ³																								 ?
 İ³	Programa.....: FUNCOES.PRG 														 ?
 İ³	Aplicacaoo...: MODULO DE FUNCOES DE APOIO AO SCI							 ?
 İ³	Versao.......: 19.50 																 ?
 İ³	Programador..: Vilmar Catafesta													 ?
 İ³	Empresa......: Microbras Com de Prod de Informatica Ltda 				 ?
 İ³	Inicio.......: 12 de Novembro de 1991. 										 ?
 İ³	Ult.Atual....: 06 de Dezembro de 1998. 										 ?
 İ³	Compilacao...: Clipper 5.2e														 ?
 İ³	Linker.......: Blinker 7.0													   	 ?
 İ³	Bibliotecas..: Clipper/Funcoes/Mouse/Funcky15/Funcky50/Classe/Classic ?
 İÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
#include <sci.ch>

STATIC static1 := "ÕÍ¸³¾ÍÔ³"
STATIC static2 := ""
STATIC static3 := {1, 1, 0, 0, 0, 0, 0, 0, 0, 24, 79, 1, 0, 0, 0, 1, 8, 1, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, -999, 0, 0, Nil}

*==================================================================================================*		

def AchaCampo( aStruct, Dbf1, nX, cCampo )
	LOCAL cTipo, nTam, nDec
	LOCAL nPos := Ascan2( aStruct, cCampo, 1 )
	IF nPos > 0
		cTipo := Dbf1[nX,2]
		nTam	:= Dbf1[nX,3]
		nDec	:= Dbf1[nX,4]
		if cCampo == "ID"
			return OK
		endif
		return(( aStruct[ nPos, 2 ] == cTipo .AND. ;
					aStruct[ nPos, 3 ] == nTam  .AND. ;
					aStruct[ nPos, 4 ] == nDec ))
	EndIf
	Return(FALSO)
endef

*==================================================================================================*		

def VerIndice()
	LOCAL lReindexar := FALSO
	LOCAL aIndice	  := ArrayIndices()
	LOCAL cDbf
	LOCAL cLocalDbf
	LOCAL cIndice
	LOCAL nTodos
	LOCAL nX

	oReindexa := TIniNew("REINDEXA.INI")
	oMenu:Limpa()
	nTodos := Len( aIndice )

#ifdef FOXPRO
	for nX := 1 To nTodos
		cDbf		 := aIndice[nX,1]
		cLocalDbf := cDbf + '.DBF'
		cIndice	 := cDbf + '.' + CEXT
		
		if !ms_swap_file(cIndice)
			//if !AbreArquivo( cDbf )
			//	return( FALSO )
			//EndIF
			CriaIndice(cDbf)
		else			   
			/*
			if !oReindexa:ReadBool('reindexando', cLocalDbf, FALSO )
				ErrorBeep()
				if Conf('Erro: Arquivo ' + cDbf + ' nao foi reindexado com sucesso. Reindexar agora ?')
					if !AbreArquivo( cDbf )
						return( FALSO )
					endif
				  CriaIndice( cDbf )
				endif
			endif
			*/
		endif
	next
#else 
	for nX := 1 To nTodos
		cDbf		 := aIndice[nX,1]
		cLocalDbf := cDbf + '.DBF'
		nLen		 := Len(aIndice[nX])
		
		For nY := 2 To nLen
			cIndice := aIndice[nX, nY ]
			IF !File( cIndice + '.' + CEXT )
				IF !AbreArquivo( cDbf )
					Return( FALSO )
				EndIF
				CriaIndice( cDbf )
				Exit
			Else
				IF !oReindexa:ReadBool('reindexando', cLocalDbf, FALSO )
					IF !AbreArquivo( cDbf )
						Return( FALSO )
					EndIF
					CriaIndice( cDbf )
					Exit
				EndIF
			EndIF
		Next
	Next
#endif
	if oIndice:Reindexado
		oReindexa:Close()
		return true
	endif
	oReindexa:Close()
	ErrorBeep()
	if !Conf("Pergunta: Deseja entrar sem reindexar ?")
		if MenuIndice()
			CriaIndice()
		else	
			return false
		endif
	endif
	return(OK)
endef

*==================================================================================================*		

def MenuIndice()
	LOCAL cScreen := SaveScreen()
	LOCAL aMenu   := {"Cancelar",;
							"Sem grafico progresso (recomendado)",;
							"Com grafico de progresso",;
							"Com compactacao e sem grafico (periodicamente)",;
							"Com compactacao e com grafico (periodicamente)"}

	oMenu:Limpa()
	M_Title("ESCOLHA O TIPO DE REINDEXACAO")
	nChoice := FazMenu( 07, 15, aMenu, Cor())
	IF nChoice = 0 .OR. nChoice = 1
		oIndice:ProgressoNtx := false
		ResTela( cScreen )
		Return( FALSO )
	ElseIF nChoice = 2
	  oIndice:ProgressoNtx := false
	  oIndice:Compactar    := false
	ElseIF nChoice = 3
	  oIndice:ProgressoNtx := true
	  oIndice:Compactar    := false
	ElseIF nChoice = 4
	  oIndice:ProgressoNtx := false
	  oIndice:Compactar    := true
	ElseIF nChoice = 5
	  oIndice:Compactar    := true
	  oIndice:ProgressoNtx := true
	EndIF
	ResTela( cScreen )
	Return( OK )
endef

*==================================================================================================*		

def AbreArquivo( cArquivo )
	LOCAL cTela  := Mensagem(" Aguarde... Verificando Arquivos.")
	LOCAL nQt
	LOCAL nPos
	LOCAL nQtArquivos
	LOCAL aArquivos

	// FechaTudo()
	aArquivos := ArrayArquivos()
	if cArquivo != NIL
	   CriaArquivo(cArquivo)		
		//CriaIndice(cArquivo)		
		nPos := Ascan( aArquivos,{ |oBloco|oBloco[1] = cArquivo })
		if nPos != 0
			cArquivo := aArquivos[nPos,1]
			cTela := mensagem(" Aguarde... Verificando Arquivo ;-;;#" + TrimStr(nPos) + ' ' + cArquivo )					
			if !NetUse( cArquivo, MONO )			
				ResTela( cTela )
				return(FALSO)
			endif
			return( OK )
		endif
		return( FALSO )
	endif
	nQtArquivos := Len( aArquivos )
	For nQt := 1 To nQtArquivos
		cArquivo := aArquivos[nQt,1]
		cTela := mensagem(" Aguarde... Verificando Arquivo ;-;;#" + TrimStr(nQt) + ' ' + cArquivo)
		if !NetUse( cArquivo, MONO )
			ResTela( cTela )
			return(FALSO)
		endif
	Next
	ResTela( cTela )
	return( OK )

*==================================================================================================*			

def CriaArquivo( cArquivo )
	LOCAL cScreen   := SaveScreen()
	LOCAL aArquivos := {}
	LOCAL cTela
	LOCAL nQtArquivos
	LOCAL nQt
	LOCAL nTam
	LOCAL nX
	LOCAL nPos
	LOCAL cHost 
	
	aArquivos := ArrayArquivos()
	if cArquivo != nil
		nPos := Ascan( aArquivos,{ |oBloco|oBloco[1] = cArquivo })
		if nPos != 0
			cArquivo := aArquivos[nPos,1]

			if !ms_swap_file(cArquivo)
				Mensagem( "Aguarde, Gerando Arquivo " + cArquivo)
				ms_swap_DbCreate( cArquivo, aArquivos[ nPos, 2] )
				return true
			endif
		endif
		return false
	endif
	
	nQtArquivos := Len( aArquivos )
	for nQt := 1 To nQtArquivos
		cArquivo := aArquivos[nQt,1]
		
		if !ms_swap_file(cArquivo)			
			Mensagem("Aguarde, Gerando Arquivo " + cArquivo)
			ms_swap_DbCreate(cArquivo, aArquivos[nQt,2] )
		else			
			if NetUse( cArquivo, MULTI )
				Integridade(cArquivo, aArquivos[nQt, 2])
			else
				SetMode(oAmbiente:AlturaFonteDefaultWindows, oAmbiente:LarguraFonteDefaultWindows)
				Cls
				Quit
			endif
		endif
	Next
	resTela( cScreen )
	cTela := Mensagem("Aguarde, Fechando Base de Dados.", Cor())
	FechaTudo()
	resTela( cTela )
	Return
endef

*==================================================================================================*		

def CriaIndice( cDbf )
	LOCAL cScreen						:= SaveScreen()
	LOCAL nY 							:= 0
	LOCAL lRetornaArrayDeArquivos := OK
	LOCAL nTodos						:= 0
	LOCAL nPos							:= 0
	LOCAL cLocalDbf					:= ''
	LOCAL cLocalNtx					:= ''
	LOCAL aProc 						:= {}

	Aadd( aProc, {"CHEMOV",   {||Re_Chemov()}})
	Aadd( aProc, {"SAIDAS",   {||Re_Saidas()}})
	Aadd( aProc, {"RECEBIDO", {||Re_Recebido()}})
	Aadd( aProc, {"LISTA",    {||Re_Lista()}})
	Aadd( aProc, {"CEP",      {||Re_Cep()}})
	Aadd( aProc, {"CHEQUE",   {||Re_Cheque()}})
	Aadd( aProc, {"CHEPRE",   {||Re_Chepre()}})
	Aadd( aProc, {"CONTA",    {||Re_Conta()}})
	Aadd( aProc, {"CORTES",   {||Re_Cortes()}})
	Aadd( aProc, {"CURSOS",   {||Re_Cursos()}})
	Aadd( aProc, {"CURSADO",  {||Re_Cursado()}})
	Aadd( aProc, {"ENTRADAS", {||Re_Entradas()}})
	Aadd( aProc, {"FORMA",    {||Re_Forma()}})
	Aadd( aProc, {"FUNCIMOV", {||Re_Funcimov()}})
	Aadd( aProc, {"GRUPO",    {||Re_Grupo()}})
	Aadd( aProc, {"GRPSER",   {||Re_GrpSer()}})
	Aadd( aProc, {"MOVI",     {||Re_Movi()}})
	Aadd( aProc, {"ENTNOTA",  {||Re_EntNota()}})
	Aadd( aProc, {"NOTA",     {||Re_Nota()}})
	Aadd( aProc, {"PAGAR",    {||Re_Pagar()}})
	Aadd( aProc, {"PAGAMOV",  {||Re_Pagamov()}})
	Aadd( aProc, {"PAGO",     {||Re_Pago()}})
	Aadd( aProc, {"PREVENDA", {||Re_Prevenda()}})
	Aadd( aProc, {"PRINTER",  {||Re_Printer()}})
	Aadd( aProc, {"PONTO",    {||Re_Ponto()}})
	Aadd( aProc, {"RECEMOV",  {||Re_Recemov()}})
	Aadd( aProc, {"REGIAO",   {||Re_Regiao()}})
	Aadd( aProc, {"RECEBER",  {||Re_Receber()}})
	Aadd( aProc, {"REPRES",   {||Re_Representante()}})
	Aadd( aProc, {"RETORNO",  {||Re_Retorno()}})
	Aadd( aProc, {"SERVICO",  {||Re_Servico()}})
	Aadd( aProc, {"SERVIDOR", {||Re_Servidor()}})
	Aadd( aProc, {"SUBCONTA", {||Re_SubConta()}})
	Aadd( aProc, {"SUBGRUPO", {||Re_SubGrupo()}})
	Aadd( aProc, {"TAXAS",    {||Re_Taxas()}})
	Aadd( aProc, {"USUARIO",  {||Re_Usuario()}})
	Aadd( aProc, {"VENDEDOR", {||Re_Vendedor()}})
	Aadd( aProc, {"VENDEMOV", {||Re_Vendemov()}})
	Aadd( aProc, {"RECIBO",   {||Re_Recibo()}})
	Aadd( aProc, {"AGENDA",   {||Re_Agenda()}})
	Aadd( aProc, {"CM",       {||Re_Cm()}})

	nTodos := Len( aProc )
	//----------------------------------------------------------------//
	Aeval( Directory( "*.$$$"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.TMP"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.BAK"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*.MEM"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "T0*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "T1*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "T2*.*"), { | aFile | Ferase( aFile[ F_NAME ] )})
	Aeval( Directory( "*."),    { | aFile | Ferase( aFile[ F_NAME ] )})
	//-----------------------------------------------------------------//

	//hb_mutexLock( s_hMutex )
	//hb_mutexUnlock( s_hMutex )

	//oMenu:Limpa()
	oReindexa := TIniNew("REINDEXA.INI")
	cDbf		 := IF( cDbf != NIL, Upper( cDbf ), NIL )
	
	if cDbf = NIL
		Aeval( Directory( "*.NSX"), { | aFile | Ferase( aFile[ F_NAME ] )})
		Aeval( Directory( "*.CDX"), { | aFile | Ferase( aFile[ F_NAME ] )})
		Aeval( Directory( "*.NTX"), { | aFile | Ferase( aFile[ F_NAME ] )})
	endif
	
	IF cDbf != NIL
		nPos := Ascan( aProc,{ |oBloco|oBloco[1] = cDbf })
		if nPos != 0
			cLocalDbf := aProc[nPos,1] + '.DBF'
			cLocalNtx := aProc[nPos,1] + '.' + CEXT
			Ferase( cLocalNtx )
			oReindexa:WriteBool('reindexando', cLocalDbf, FALSO )
			Eval( aProc[ nPos, 2 ] )
			oReindexa:WriteBool('reindexando', cLocalDbf, OK )
			//ResTela( cScreen )
			Mensagem("Aguarde, Fechando Arquivos.")
			oReindexa:Close()
			//ResTela( cScreen )
			// FechaTudo()
			return(nil)
		endif
	EndIF
	FechaTudo()
	//oIndice:Limpa()
	for nY := 1 To nTodos
		cDbf		 := aProc[ nY, 1 ]
		cLocalDbf := cDbf + '.DBF'
		
		if AbreArquivo( cDbf )
			oReindexa:WriteBool('reindexando', cLocalDbf, FALSO )
			Eval( aProc[ nY, 2 ] )
			oReindexa:WriteBool('reindexando', cLocalDbf, OK )
		EndIF			
	next
	//ResTela( cScreen )
	Mensagem("Aguarde, Fechando Arquivos.", WARNING, _LIN_MSG )
	//ResTela( cScreen )
	// FechaTudo()
	oReindexa:Close()
	return(nil)
endef

*==================================================================================================*		

def Re_Cortes()
	oIndice:DbfNtx("CORTES")
	oIndice:PackDbf("CORTES")
	oIndice:AddNtx("Tabela", "CORTES1", "CORTES" )
	oIndice:CriaNtx()
	return nil
endef

def Re_GrpSer()
	oIndice:DbfNtx("GRPSER")
	oIndice:PackDbf("GRPSER")
	oIndice:AddNtx("Grupo",    "GRPSER1", "GRPSER" )
	oIndice:AddNtx("DesGrupo", "GRPSER2", "GRPSER" )
	oIndice:CriaNtx()
	Return
endef

def Re_Servico()
	oIndice:DbfNtx("SERVICO")
	oIndice:PackDbf("SERVICO")
	oIndice:AddNtx("CodiSer", "SERVICO1", "SERVICO" )
	oIndice:AddNtx("Nome",    "SERVICO2", "SERVICO" )
	oIndice:CriaNtx()
	Return
endef

Proc Re_Movi()
**************
oIndice:DbfNtx("MOVI")
oIndice:PackDbf("MOVI")
oIndice:AddNtx("Tabela",  "MOVI1", "MOVI" )
oIndice:AddNtx("Codiven+Left(Tabela,4)+CodiSer", "MOVI2", "MOVI" )
oIndice:AddNtx("Data",     "MOVI3", "MOVI" )
oIndice:AddNtx("Codiven+dTos(Data)", "MOVI4", "MOVI" )
oIndice:CriaNtx()
Return

Proc Re_Funcimov()
******************
oIndice:DbfNtx("FUNCIMOV")
oIndice:PackDbf("FUNCIMOV")
oIndice:AddNtx("Data",    "FUNCIMO1", "FUNCIMOV" )
oIndice:AddNtx("Docnr",   "FUNCIMO2", "FUNCIMOV" )
oIndice:AddNtx("Codiven+dTos(Data)", "FUNCIMO3", "FUNCIMOV" )
oIndice:CriaNtx()
Return

Proc Re_Retorno()
*****************
oIndice:DbfNtx("RETORNO")
oIndice:PackDbf("RETORNO")
oIndice:AddNtx("Codi", "RETORNO1", "RETORNO" )
oIndice:CriaNtx()
Return

Proc Re_Conta()
***************
oIndice:DbfNtx("CONTA")
oIndice:PackDbf("CONTA")
oIndice:AddNtx("Codi", "CONTA1", "CONTA" )
oIndice:CriaNtx()
Return

Proc Re_SubConta()
***************
oIndice:DbfNtx("SUBCONTA")
oIndice:PackDbf("SUBCONTA")
oIndice:AddNtx("Codi",   "SUBCONT1", "SUBCONTA" )
oIndice:AddNtx("SubCodi","SUBCONT2", "SUBCONTA" )
oIndice:CriaNtx()
Return

Proc Re_Cep()
*************
oIndice:DbfNtx("CEP")
oIndice:PackDbf("CEP")
oIndice:AddNtx("Cep",  "CEP1", "CEP" )
oIndice:AddNtx("Cida", "CEP2", "CEP" )
oIndice:CriaNtx()
Return

Proc Re_Usuario()
*****************
oIndice:DbfNtx("USUARIO")
oIndice:PackDbf("USUARIO")
oIndice:AddNtx("Nome", "USUARIO1", "USUARIO" )
oIndice:CriaNtx()
Return

Proc Re_Forma()
**************
oIndice:DbfNtx("FORMA")
oIndice:PackDbf("FORMA")
oIndice:AddNtx("Forma", "FORMA1", "FORMA" )
oIndice:CriaNtx()
Return

Proc Re_Cursos()
****************
oIndice:DbfNtx("CURSOS")
oIndice:PackDbf("CURSOS")
oIndice:AddNtx("Curso", "CURSOS1", "CURSOS" )
oIndice:CriaNtx()
Return

Proc Re_Cursado()
*****************
oIndice:DbfNtx("CURSADO")
oIndice:PackDbf("CURSADO")
oIndice:AddNtx( "Curso",   "CURSADO1", "CURSADO" )
oIndice:AddNtx( "Codi",    "CURSADO2", "CURSADO" )
oIndice:AddNtx( "Fatura",  "CURSADO3", "CURSADO" )
oIndice:CriaNtx()
Return

Proc Re_Regiao()
****************
oIndice:DbfNtx("REGIAO")
oIndice:PackDbf("REGIAO")
oIndice:AddNtx("Regiao", "REGIAO1", "REGIAO" )
oIndice:AddNtx("Nome",   "REGIAO2", "REGIAO" )
oIndice:CriaNtx()
Return

Proc Re_SubGrupo()
*******************
oIndice:DbfNtx("SUBGRUPO")
oIndice:PackDbf("SUBGRUPO")
oIndice:AddNtx("codsgrupo","SUBGRUPO1", "SUBGRUPO" )
oIndice:CriaNtx()
Return

Proc Re_Nota()
**************
oIndice:DbfNtx("NOTA")
oIndice:PackDbf("NOTA")
oIndice:AddNtx("Numero", "NOTA1", "NOTA" )
oIndice:AddNtx("Codi",   "NOTA2", "NOTA" )
oIndice:AddNtx("Data",   "NOTA3", "NOTA" )
oIndice:CriaNtx()
Return

Proc Re_EntNota()
*****************
oIndice:DbfNtx("ENTNOTA")
oIndice:PackDbf("ENTNOTA")
oIndice:AddNtx("Data",   "ENTNOTA1", "ENTNOTA" )
oIndice:AddNtx("Codi",   "ENTNOTA2", "ENTNOTA" )
oIndice:AddNtx("Numero", "ENTNOTA3", "ENTNOTA" )
oIndice:AddNtx("Entrada","ENTNOTA4", "ENTNOTA" )
oIndice:CriaNtx()
Return

Proc Re_Printer()
*****************
oIndice:Limpa()
oIndice:DbfNtx("PRINTER")
oIndice:PackDbf("PRINTER")
oIndice:AddNtx("Codi", "PRINTER1", "PRINTER" )
oIndice:AddNtx("Nome", "PRINTER2", "PRINTER" )
oIndice:CriaNtx()
Return

Proc Re_Grupo()
***************
oIndice:DbfNtx("GRUPO")
oIndice:PackDbf("GRUPO")
oIndice:AddNtx("CodGrupo","GRUPO1", "GRUPO" )
oIndice:AddNtx("DesGrupo","GRUPO2", "GRUPO" )
oIndice:CriaNtx()
Return

Proc Re_Taxas()
***************
oIndice:DbfNtx("TAXAS")
oIndice:PackDbf("TAXAS")
oIndice:AddNtx("Dini", "TAXAS1", "TAXAS" )
oIndice:AddNtx("DFim", "TAXAS2", "TAXAS" )
oIndice:CriaNtx()
Return

Proc Re_Vendedor()
******************
oIndice:DbfNtx("VENDEDOR")
oIndice:PackDbf("VENDEDOR")
oIndice:AddNtx("Codiven", "VENDEDO1", "VENDEDOR" )
oIndice:AddNtx("nome",    "VENDEDO2", "VENDEDOR" )
oIndice:CriaNtx()
Return

Proc Re_Ponto()
***************
oIndice:DbfNtx("PONTO")
oIndice:PackDbf("PONTO")
oIndice:AddNtx("Codi",  "PONTO1",             "PONTO" )
oIndice:AddNtx("Data",  "PONTO2",             "PONTO" )
oIndice:AddNtx("Codi + dTos( Data)","PONTO3", "PONTO" )
oIndice:CriaNtx()
Return

Proc Re_Cheque()
****************
oIndice:DbfNtx("CHEQUE")
oIndice:PackDbf("CHEQUE")
oIndice:AddNtx("Codi",    "CHEQUE1", "CHEQUE" )
oIndice:AddNtx("Titular", "CHEQUE2", "CHEQUE" )
oIndice:AddNtx("Horario", "CHEQUE3", "CHEQUE" )
oIndice:CriaNtx()
Return

Proc Re_Receber()
*****************
oIndice:DbfNtx("RECEBER")
oIndice:PackDbf("RECEBER")
oIndice:AddNtx("nome",                "RECEBER1", "RECEBER" )
oIndice:AddNtx("codi",                "RECEBER2", "RECEBER" )
oIndice:AddNtx("cida",                "RECEBER3", "RECEBER" )
oIndice:AddNtx("Regiao",              "RECEBER4", "RECEBER" )
oIndice:AddNtx("Esta+dTos(Data)","RECEBER5", "RECEBER" )
oIndice:AddNtx("Fanta",               "RECEBER6", "RECEBER" )
oIndice:AddNtx("Bair+Ende",           "RECEBER7", "RECEBER" )
oIndice:AddNtx("Ende",                "RECEBER8", "RECEBER" )
oIndice:AddNtx("Fone",                "RECEBER9", "RECEBER" )
oIndice:AddNtx("Fax",                 "RECEBER10", "RECEBER" )
oIndice:CriaNtx()
Return

Proc Re_Representante()
***********************
oIndice:DbfNtx("REPRES")
oIndice:PackDbf("REPRES")
oIndice:AddNtx("nome",      "REPRES1", "REPRES" )
oIndice:AddNtx("Repres",    "REPRES2", "REPRES" )
oIndice:AddNtx("cida+nome", "REPRES3", "REPRES" )
oIndice:CriaNtx()
Return

Proc Re_Pagar()
***************
oIndice:DbfNtx("PAGAR")
oIndice:PackDbf("PAGAR")
oIndice:AddNtx("nome",      "PAGAR1", "PAGAR")
oIndice:AddNtx("codi",      "PAGAR2", "PAGAR")
oIndice:AddNtx("cida+nome", "PAGAR3", "PAGAR")
oIndice:CriaNtx()
Return

Proc Re_Pagamov()
*****************
oIndice:DbfNtx("PAGAMOV")
oIndice:PackDbf("PAGAMOV")
oIndice:AddNtx("Docnr",              "PAGAMOV1", "PAGAMOV" )
oIndice:AddNtx("Vcto",               "PAGAMOV2", "PAGAMOV" )
oIndice:AddNtx("Codi + dTos(Vcto)", "PAGAMOV3", "PAGAMOV" )
oIndice:AddNtx("Codi + dTos(Emis)", "PAGAMOV4", "PAGAMOV" )
oIndice:CriaNtx()
Return

Proc Re_Chepre()
****************
oIndice:DbfNtx("CHEPRE")
oIndice:PackDbf("CHEPRE")
oIndice:AddNtx("Codi  + dTos(Vcto)",  "CHEPRE1", "CHEPRE" )
oIndice:AddNtx("Docnr + dTos(Vcto)",  "CHEPRE2", "CHEPRE" )
oIndice:AddNtx("Praca + dTos(Vcto)",  "CHEPRE3", "CHEPRE" )
oIndice:AddNtx("Banco + dTos(Vcto)",  "CHEPRE4", "CHEPRE" )
oIndice:AddNtx("dTos(Vcto)",          "CHEPRE5", "CHEPRE" )
oIndice:CriaNtx()
Return

Proc Re_Pago()
**************
oIndice:DbfNtx("PAGO")
oIndice:PackDbf("PAGO")
oIndice:AddNtx("Docnr",   "PAGO1", "PAGO" )
oIndice:AddNtx("Datapag", "PAGO2", "PAGO" )
oIndice:AddNtx("Codi + dTos( Datapag )", "PAGO3", "PAGO")
oIndice:CriaNtx()
Return

Proc Re_Servidor()
******************
oIndice:DbfNtx("SERVIDOR")
oIndice:PackDbf("SERVIDOR")
oIndice:AddNtx("Nome", "SERVIDO1", "SERVIDOR"  )
oIndice:AddNtx("Codi", "SERVIDO2", "SERVIDOR"  )
oIndice:CriaNtx()
Return

Proc Re_Entradas()
******************
oIndice:DbfNtx("ENTRADAS")
oIndice:PackDbf("ENTRADAS")
oIndice:AddNtx("Codigo+dTos(Data)","ENTRADA1", "ENTRADAS" )
oIndice:AddNtx("Fatura",                "ENTRADA2", "ENTRADAS"  )
oIndice:AddNtx("Data",                  "ENTRADA3", "ENTRADAS"  )
oIndice:AddNtx("Codi",                  "ENTRADA4", "ENTRADAS" )
oIndice:CriaNtx()
Return

Proc Re_Vendemov()
******************
oIndice:DbfNtx("VENDEMOV")
oIndice:PackDbf("VENDEMOV")
oIndice:AddNtx("data",    "VENDEMO1", "VENDEMOV" )
oIndice:AddNtx("docnr",   "VENDEMO2", "VENDEMOV" )
oIndice:AddNtx("Codiven+dTos(Data)", "VENDEMO3", "VENDEMOV" )
oIndice:AddNtx("Fatura",  "VENDEMO4", "VENDEMOV"  )
oIndice:AddNtx("Forma",   "VENDEMO5", "VENDEMOV"  )
oIndice:AddNtx("Regiao",  "VENDEMO6", "VENDEMOV"  )
oIndice:CriaNtx()
Return

Proc Re_Recibo()
******************
oIndice:DbfNtx("RECIBO")
oIndice:PackDbf("RECIBO")
oIndice:AddNtx("tipo",       "RECIBO1", "RECIBO" )
oIndice:AddNtx("codi",       "RECIBO2", "RECIBO" )
oIndice:AddNtx("docnr",      "RECIBO3", "RECIBO" )
oIndice:AddNtx("vcto",       "RECIBO4", "RECIBO" )
oIndice:AddNtx("data",       "RECIBO5", "RECIBO" )
oIndice:AddNtx("usuario",    "RECIBO6", "RECIBO"  )
oIndice:AddNtx("caixa",      "RECIBO7", "RECIBO"  )
oIndice:AddNtx("nome",       "RECIBO8", "RECIBO"  )
oIndice:AddNtx("codi+docnr", "RECIBO9", "RECIBO"  )
oIndice:AddNtx("fatura",     "RECIBO10", "RECIBO"  )
oIndice:AddNtx("Codi+dTos(Data)", "RECIBO11", "RECIBO" )
oIndice:AddNtx("Right(Docnr, 8)",      "RECIBO12", "RECIBO" )
oIndice:CriaNtx()
Return

Proc Re_Agenda()
****************
oIndice:DbfNtx("AGENDA")
oIndice:PackDbf("AGENDA")
oIndice:AddNtx("codi",    "AGENDA1", "AGENDA" )
oIndice:AddNtx("hist",    "AGENDA2", "AGENDA" )
oIndice:AddNtx("data",    "AGENDA3", "AGENDA" )
oIndice:AddNtx("usuario", "AGENDA4", "AGENDA"  )
oIndice:AddNtx("caixa",   "AGENDA5", "AGENDA"  )
oIndice:AddNtx("Codi+dTos(Data)", "AGENDA6", "AGENDA" )
oIndice:AddNtx("dTos(Data)+Codi", "AGENDA7", "AGENDA" )
oIndice:CriaNtx()
Return

Proc Re_Cm()
************
oIndice:DbfNtx("CM")
oIndice:PackDbf("CM")
oIndice:AddNtx("inicio",  "CM1", "CM" )
oIndice:AddNtx("fim",     "CM2", "CM" )
oIndice:AddNtx("dTos(inicio)", "CM3", "CM" )
oIndice:AddNtx("dTos(fim)",    "CM4", "CM" )
oIndice:CriaNtx()
Return

Proc Re_Chemov()
****************
oIndice:DbfNtx("CHEMOV")
oIndice:PackDbf("CHEMOV")
oIndice:AddNtx("docnr",  "CHEMOV1", "CHEMOV"  )
oIndice:AddNtx("data",   "CHEMOV2", "CHEMOV"  )
oIndice:AddNtx("Codi + dTos( Data )", "CHEMOV3", "CHEMOV" )
oIndice:AddNtx("Fatura", "CHEMOV4", "CHEMOV"  )
oIndice:AddNtx("Codi + dTos( Baixa )", "CHEMOV5", "CHEMOV" )
oIndice:AddNtx("dTos( Data ) + Docnr", "CHEMOV6", "CHEMOV" )
oIndice:CriaNtx()
Return

Proc Re_Recemov()
*****************
oIndice:DbfNtx("RECEMOV")
oIndice:PackDbf("RECEMOV")
oIndice:AddNtx("Docnr",      "RECEMOV1", "RECEMOV" )
oIndice:AddNtx("Codi",       "RECEMOV2", "RECEMOV"  )
oIndice:AddNtx("Vcto",       "RECEMOV3", "RECEMOV"  )
oIndice:AddNtx("Fatura",     "RECEMOV4", "RECEMOV"  )
oIndice:AddNtx("Regiao+Codi","RECEMOV5", "RECEMOV"  )
oIndice:AddNtx("Emis",       "RECEMOV6", "RECEMOV"  )
oIndice:AddNtx("Codiven",    "RECEMOV7", "RECEMOV"  )
oIndice:AddNtx("Tipo+Codi",  "RECEMOV8", "RECEMOV"  )
oIndice:AddNtx("Datapag",    "RECEMOV9", "RECEMOV"  )
oIndice:AddNtx("Codi + dTos( Vcto )",    "RECEMOV10", "RECEMOV" )
oIndice:AddNtx("Codi + dTos( Datapag )", "RECEMOV11", "RECEMOV" )
oIndice:AddNtx("Right(Docnr, 8)",             "RECEMOV12", "RECEMOV" )
oIndice:CriaNtx()
Return

Proc Re_Recebido()
******************
oIndice:DbfNtx("RECEBIDO")
oIndice:PackDbf("RECEBIDO")
oIndice:AddNtx("Docnr",    "RECEBID1", "RECEBIDO"  )
oIndice:AddNtx("DataPag",  "RECEBID2", "RECEBIDO"  )
oIndice:AddNtx("Fatura",   "RECEBID3", "RECEBIDO"  )
oIndice:AddNtx("Codi + dTos( Vcto )", "RECEBID4", "RECEBIDO" )
oIndice:AddNtx("CodiVen",  "RECEBID5", "RECEBIDO"  )
oIndice:AddNtx("Port",     "RECEBID6", "RECEBIDO"  )
oIndice:AddNtx("Forma",    "RECEBID7", "RECEBIDO"  )
oIndice:AddNtx("Baixa",    "RECEBID8", "RECEBIDO"  )
oIndice:AddNtx("Regiao",   "RECEBID9", "RECEBIDO"  )
oIndice:AddNtx("Vcto",     "RECEBID10","RECEBIDO"  )
oIndice:AddNtx("Tipo+Codi","RECEBID11","RECEBIDO"  )
oIndice:AddNtx("Codi + dTos( Datapag )", "RECEBID12", "RECEBIDO" )
oIndice:CriaNtx()
Return

Proc Re_Saidas()
****************
oIndice:DbfNtx("SAIDAS")
oIndice:PackDbf("SAIDAS")
oIndice:AddNtx("Codigo",        "SAIDAS1", "SAIDAS" )
oIndice:AddNtx("Regiao",        "SAIDAS2", "SAIDAS" )
oIndice:AddNtx("Fatura+Codigo", "SAIDAS3", "SAIDAS" )
oIndice:AddNtx("Emis",          "SAIDAS4", "SAIDAS" )
oIndice:AddNtx("Codi",          "SAIDAS5", "SAIDAS" )
oIndice:AddNtx("CodiVen",       "SAIDAS6", "SAIDAS" )
oIndice:AddNtx("Forma",         "SAIDAS7", "SAIDAS" )
oIndice:CriaNtx()
Return

Proc Re_prevenda()
****************
oIndice:DbfNtx("PREVENDA")
oIndice:PackDbf("PREVENDA")
oIndice:AddNtx("Fatura", "PREVEND1", "PREVENDA" )
oIndice:AddNtx("Emis",   "PREVEND2", "PREVENDA" )
oIndice:AddNtx("Codigo", "PREVEND3", "PREVENDA" )
oIndice:CriaNtx()
Return

Proc Re_Lista()
***************
oIndice:DbfNtx("LISTA")
oIndice:PackDbf("LISTA")
oIndice:AddNtx("CodGrupo",                         "LISTA1", "LISTA" )
oIndice:AddNtx("Codigo",                           "LISTA2", "LISTA" )
oIndice:AddNtx("Descricao",                        "LISTA3", "LISTA" )
oIndice:AddNtx("CodGrupo + CodSgrupo + Descricao", "LISTA4", "LISTA" )
oIndice:AddNtx("CodGrupo + CodSgrupo + Codigo",    "LISTA5", "LISTA" )
oIndice:AddNtx("Data",                             "LISTA6", "LISTA")
oIndice:AddNtx("CodGrupo + CodSgrupo + N_Original","LISTA7", "LISTA" )
oIndice:AddNtx("CodsGrupo",                        "LISTA8", "LISTA" )
oIndice:AddNtx("Codi + Descricao",                 "LISTA9", "LISTA" )
oIndice:AddNtx("N_Original",                       "LISTA10","LISTA" )
oIndice:AddNtx("CodeBar",                          "LISTA11","LISTA" )
oIndice:CriaNtx()
Return


*==================================================================================================*		

static def MS_Box( nRow, nCol, nRow1, nCol1, cFrame, nCor)
**********************************************************
	LOCAL nComp  := ( nCol1 - nCol )-1
	DEFAU cFrame TO M_Frame()
	DEFAU nCor	 TO Cor()

	return( Hb_DispBox( nRow, nCol, nRow1, nCol1, cFrame + " ", nCor))

	//Box( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )      // Funcky
	//DispBox( nRow, nCol, nRow1, nCol1, M_Frame() + " ", nCor, 1, 8 )  // Harbour

	for x := nRow To nRow1
		Print( x, nCol, Space(1), nCor, nComp+1, " ")
	next

	Print( nRow, nCol, Left(cFrame,1), nCor, 1 )
	Print( nRow, nCol+1, Repl(SubStr(cFrame,2,1),nComp), nCor )
	Print( nRow, nCol1, SubStr(cFrame,3,1), nCor, 1 )
	
	for x := nRow+1 To nRow1
		Print( x, nCol,  SubStr(cFrame,4,1), nCor, 1 )
		Print( x, nCol1, SubStr(cFrame,8,1), nCor, 1 )
	Next
	
	Print( nRow1, nCol, SubStr(cFrame,7,1),  nCor, 1 )
	Print( nRow1, nCol+1, Repl(SubStr(cFrame,6,1),nComp), nCor )
	Print( nRow1, nCol1, SubStr(cFrame,5,1), nCor, 1 )
return NIL

static def Cor( nTipo, nTemp )
******************************
	DEFAU nTipo TO 1 

	if nTemp != NIL   // Cor temporaria
		return( nTemp )
	endif	
	
	Switch nTipo
	Case 1
		return( oAmbiente:CorMenu	)
	Case 2
		return( oAmbiente:CorCabec )
	Case 3 	
		return( oAmbiente:Corfundo )
	Case 4 	
		return( oAmbiente:CorDesativada )		
	Case 5 	
		return( oAmbiente:CorLightBar )				
	Case 6 	
		return( oAmbiente:CorHotKey )				
	Case 7 	
		return( oAmbiente:CorHKLightBar )				
	Case 8 	
		return( oAmbiente:CorAlerta )				
	Case 9 	
		return( oAmbiente:CorMsg )				
	EndSwitch

static def aStrPos(string, delims)
**********************************
	LOCAL nConta  := GT_StrCount(delims, string)
	LOCAL nLen    := Len(delims)
	LOCAL cChar   := Repl("%",nLen)
	LOCAL aNum    := {}
	LOCAL x

	if cChar == delims
		cChar := Repl("*",delims)
	endif	

	if nConta = 0
		return(aNum)
	endif

	FOR x := 1 To nConta 
		nPos   := At( Delims, string )
		string := Stuff(string, nPos, 1, cChar)
		Aadd( aNum, nPos)
	Next
	Aadd( aNum, Len(string)+1)
	return(aNum)

static def StrExtract( string, delims, ocurrence )
**************************************************
	LOCAL nInicio := 1
	LOCAL nConta  := GT_StrCount(delims, string)
	LOCAL aArray  := {}
	LOCAL aNum    := {}
	LOCAL nLen    := Len(delims)
	LOCAL cChar   := Repl('%',nLen)
	LOCAL cNewStr := String
	LOCAL nPosIni := 1
	LOCAL aPos
	LOCAL nFim
	LOCAL x
	LOCAL nPos

	if cChar == delims
		cChar := Repl("*",nLen)
	endif	

	if nConta = 0 .AND. ocurrence > 0
	  return(string)
	endif
		

	/*
	For x := 1 to nConta
		nInicio   := At( Delims, cNewStr)
		cNewStr   := Stuff(cNewStr, nInicio, 1, cChar)
		nFim      := At( Delims, cNewStr)
		cString   := SubStr(cNewStr, nInicio+1, nFim-nInicio-1)
		if !Empty(cString)
			Aadd( aArray, cString)
		End		
	Next
	*/

	/*
	For x := 1 to nConta
		nPos      := At( Delims, cNewStr)
		cNewStr   := Stuff(cNewStr, nPos, 1, cChar)
		nLen      := nPos-nPosini
		cString   := SubStr(cNewStr, nPosIni, nLen)
		nFim      := At( Delims, cNewStr)
		nPosIni   := nPos+1
		if !Empty(cString)
			Aadd( aArray, cString)
		End		
	Next
	*/

	aPos   := aStrPos(string, Delims)
	nConta := Len(aPos)
	For x := 1 to nConta 
		nInicio  := aPos[x]
		if x = 1
			cString   := Left(String, nInicio-1)
		else
			nFim     := aPos[x-1]
			cString  := SubStr(String, nFim+1, nInicio-nFim-1)
		endif	
		Aadd( aArray, cString)
	Next

	nConta := Len(aArray)
	if ocurrence > nConta .OR. oCurrence = 0
		return(string)
	endif
	return(aArray[ocurrence])

static def nSetColor(std, enh, uns)
***********************************
	LOCAL cStd, ;
			cEnh, ;
			cUns, ;
			cColor

	cStd	 := attrtoa(std)
	cEnh	 := attrtoa(enh)
	cUns	 := attrtoa(uns)
	//cColor := setcolor()

	ColorStandard(std)
	ColorEnhanced(enh)
	ColorUnselected(uns)
	cColor := cStd + ',' + cEnh + ',,,' + cUns

	//cColor := strswap(cColor, "," , 1, cStd)
	//cColor := strswap(cColor, "," , 2, cEnh)
	//cColor := strswap(cColor, "," , 4, cUns)
	Setcolor( cColor )
	return COlorStrToInt(cColor)

static def cSetColor(ColorStr)
******************************
	LOCAL nStd, ;
			nEnh, ;
			nUns
			
	nStd := atoattr( strextract( ColorStr, ",", 1))
	nEnh := atoattr( strextract( ColorStr, ",", 2))
	nUns := atoattr( strextract( ColorStr, ",", 4))

	/*
	* Set FUNCky Colors
	*/
	ColorStandard(nStd)
	ColorEnhanced(nEnh)
	Colorunselected(nUns)

	/* Set Clipper Colors */
	SetColor( ColorStr )
	return ColorIntToStr(ColorStrToInt(ColorStr));

static def atoattr(cColor)
***************************
	return (ColorStrToInt(cColor))

static def attrtoa(nColor)
***************************
	return (ColorIntToStr(nColor))		

static def MsFrame( nTopo, nEsquerda, nFundo, nDireita, Cor )
*************************************************************
	LOCAL cFrame2	:= SubStr( oAmbiente:Frame, 2, 1 )
	LOCAL pFore 	:= Iif( Cor = NIL, Cor(), Cor )
	LOCAL cPattern := " "
	LOCAL pBack

	ColorSet( @pfore, @pback )
	Box( nTopo, nEsquerda, nFundo, nDireita, oAmbiente:Frame + cPattern, pFore  )
	cSetColor( SetColor())
	nSetColor( pFore, Roloc( pFore ))
	@ nTopo+2, nEsquerda+1 SAY Repl( cFrame2, (nDireita - nEsquerda )-1 )
	@ nTopo+3, nEsquerda+2 TO  nFundo-1,nEsquerda+2
	@ nTopo+1, nEsquerda+1 SAY Padc( M_Title(), nDireita-nEsquerda-1)
	@ nTopo+3, nDireita-2  TO  nFundo-1, nDireita-2
	return( NIL )

static def m_frame( cFrame )
********************************
   LOCAL pFrame := static1 
	
	if (ISNIL( cFrame ))
      return oAmbiente:Frame 
   else
      Static1 := cFrame
   endif
   return( pFrame )

static def m_title( cTitulo )
******************************
   LOCAL pTitulo := Static2
	
   if (IsNil( cTitulo ))
      return Static2
   else
      Static2 := cTitulo
   endif
   return( pTitulo )

static def ColorStrToInt(xColor)
********************************
	LOCAL nColor
	//return (nColor := hb_ColorToN(xColor()))
	return( nColor := FT_Color2n(xColor))

static def Roloc(nColor)
************************
	LOCAL cColor  := ColorIntToStr(nColor)
	LOCAL inverse := FT_InvClr( cColor)
	return(nColor := ColorStrToInt(inverse))

static def ColorStandard(nStd)
******************************
	STATI nStandard
	LOCAL nSwap := nStandard
	
	if (ISNIL(nStd))
      return nStandard
   else
      nStandard := nStd
   endif
   return nSwap

static def ColorEnhanced(nEnh)
******************************
	STATI nEnhanced
	LOCAL nSwap := nEnhanced
	
	if (ISNIL(nEnh))
      return nEnhanced
   else
      nEnhanced := nEnh
   endif
   return nSwap
		
static def ColorUnselected(nUns)
********************************
	STATI nUnselected
	LOCAL nSwap := nUnselected
	
	if (ISNIL(nUns))
      return nUnselected
   else
      nUnselected := nUns
   endif
   return nSwap

*----------------------------------------*
static def ColorSet( pfore, pback, pUns )
*----------------------------------------*
	if pfore == nil 
		 pfore := Standard()
		 pback := Enhanced()
		 puns  := ColorUnselected()
		 
	elseif pfore < 0 
		 pfore := Standard()
		 pback := Enhanced()
		 puns  := ColorUnselected()
	else
		 pback := Roloc(pfore)
	endif
	return( nil )

*----------------------------*
static def CorAlerta( nTipo )
*----------------------------*
	ifNil( nTipo, 1 )
	return( oAmbiente:CorAlerta )
	
static def CorBox( nTipo )
*--------------------------*
	ifNil( nTipo, 1 )
	return( oAmbiente:CorAlerta )

static def ColorIntToStr(xColor)
*-------------------------------*
	LOCAL cColor
	//return(cColor := hb_NToColor(xColor))
	return(cColor := FT_n2Color(xColor))

static def Alerta( cString, aArray, Color )
*------------------------------------------*
	__DefaultNIL(@cString, '(Pressione qualquer tecla)')	
	__DefaultNIL(@Color, oAmbiente:CorAlerta)
	__DefaultNIL(@aArray, ' Ok ')		
	return( alert( cString, aArray, ColorIntToStr(Color)))
endef	

static def ResTela( cScreen )
*----------------------------*
	RestScreen(,,,,  cScreen )
	return NIL
		
static def ErrorBeep(lOK)
*----------------------------*
	DEFAU lOk TO FALSO

	//return Nil // aff, sem som
	if lOk   // Good Sound
		Tone(  500, 1 )
		//Tone( 4000, 1 )
		//Tone( 2500, 1 )
	else     // Bad Sound
		Tone(  300, 1 )
		//Tone(  499, 5 )
		//Tone(  700, 5 )
	endif

	//TONE(87.3,1)
	//TONE(40,3.5)
	return Nil
endef	

def NetUse( cBcoDados, lModo, nSegundos, cAlias )
	LOCAL cScreen  := SaveScreen()
	LOCAL nArea    := 0
	LOCAL lrestart := OK
	LOCAL cStr1
	LOCAL cStr2
	LOCAL cStr3
	LOCAL cStr4
	LOCAL cStr5
	LOCAL cStr6
	LOCAL lForever
	LOCAL cTela
	LOCAL lAberto    := FALSO
	LOCAL cBcoSemExt := StrTran( cBcoDados, '.DBF')	
	P_DEF( lModo, OK )
	P_DEF( nSegundos, 2 )
	
	cBcoDados = Upper(cBcoDados)     // para compatibilidade em linux 
	
	if right(cBcoDados,4) != '.DBF'
	   cBcoDados += '.DBF'		
	endif	
	
	cAlias := iif( cAlias = NIL, cBcoSemExt, cAlias )
	
	if (oAmbiente:Letoativo)
		cBcoDados := oAmbiente:LetoPath + cBcoDados
	endif	
	
	lForever  := ( nSegundos = 0 )
	lAberto	 := (cBcoDados)->(Used())

	if lAberto  // 14:03 25/04/2018
		(cBcoDados)->(DbCloseArea())
		lAberto := false
	endif
	
	//alert( cAlias + '  ('+RddSetDefault() + ')')
	
	WHILE lrestart
		WHILE ( lForever .OR. nSegundos > 0 )
			if lModo			   
				Use (cBcoDados) SHARED NEW Alias (cAlias) 
			else
				Use (cBcoDados) EXCLUSIVE NEW Alias (cAlias)
			endif
			if !NetErr()
				ResTela( cScreen )
				return( OK )
			endif
			cTela := Mensagem("Tentando acesso a " + Upper(AllTrim(cBcoDados)))
			Inkey(.5)
			nSegundos -= .5
			ResTela( cTela )
		EndDo
		lrestart  := Conf("Acesso Negado a " + Upper(AllTrim( cBcoDados )) + " Novamente ? ")
		nSegundos := 2
		if !lrestart
			DbCloseAll()
			FChDir( oAmbiente:xBase )
			SetColor("")
			Cls
			cStr1 := "#1 Se outra esta‡„o estiver usando o sistema, finalize-a. ;;"
			cStr2 := "#2 Se outra esta‡„o estiver indexando, aguarde o t‚rmino. ;;"
			cStr3 := "#3 Se SHARE estiver instalado, aumente os par„metros de   ;"
			cStr4 := "   travamento de arquivos. Ex.: SHARE /F:18810 /L:510.    ;;"
			cStr5 := "#4 Em ambiente de rede NOVELL, verifique o arquivo NET.CFG;"
			cStr6 := "   e se necess rio, acrescente a linha FILE HANDLES=127.  ;"
			Alert( cStr1 + cStr2 + cStr3 + cStr4 + cStr5 + cStr6, "W+/B")
			Break
			//Quit
		endif
	EndDo
	return( FALSO )

static def DbfEmUso( cBcoDados )
*------------------------*
	LOCAL nArea := Select( cBcoDados )
	if nArea = 0
		return( FALSO )
	endif
	return( OK )
endef	

def ArrayIndices()
*----------------*
	LOCAL aArquivos := {}
	Aadd( aArquivos, { "NOTA",      "NOTA1", "NOTA2", "NOTA3"})
	Aadd( aArquivos, { "LISTA",     "LISTA1", "LISTA2", "LISTA3","LISTA4","LISTA5","LISTA6","LISTA7","LISTA8","LISTA9","LISTA10","LISTA11"})
	Aadd( aArquivos, { "SAIDAS",    "SAIDAS1","SAIDAS2","SAIDAS3","SAIDAS4","SAIDAS5","SAIDAS6","SAIDAS7"})
	Aadd( aArquivos, { "RECEBER",   "RECEBER1","RECEBER2","RECEBER3", "RECEBER4", "RECEBER5","RECEBER6","RECEBER7","RECEBER8","RECEBER9","RECEBER10"})
	Aadd( aArquivos, { "REPRES",    "REPRES1","REPRES2","REPRES3"})
	Aadd( aArquivos, { "GRUPO",     "GRUPO1","GRUPO2"})
	Aadd( aArquivos, { "SUBGRUPO",  "SUBGRUPO1"})
	Aadd( aArquivos, { "VENDEDOR",  "VENDEDO1","VENDEDO2"})
	Aadd( aArquivos, { "VENDEMOV",  "VENDEMO1","VENDEMO2","VENDEMO3","VENDEMO4", "VENDEMO5", "VENDEMO6"})
	Aadd( aArquivos, { "RECEMOV",   "RECEMOV1","RECEMOV2","RECEMOV3","RECEMOV4","RECEMOV5","RECEMOV6","RECEMOV7", "RECEMOV8","RECEMOV9", "RECEMOV10", "RECEMOV11", "RECEMOV12"})
	Aadd( aArquivos, { "ENTRADAS",  "ENTRADA1","ENTRADA2","ENTRADA3","ENTRADA4"})
	Aadd( aArquivos, { "PAGAR",     "PAGAR1","PAGAR2","PAGAR3"})
	Aadd( aArquivos, { "PAGAMOV",   "PAGAMOV1","PAGAMOV2","PAGAMOV3","PAGAMOV4"})
	Aadd( aArquivos, { "TAXAS",     "TAXAS1","TAXAS2"})
	Aadd( aArquivos, { "PAGO",      "PAGO1","PAGO2","PAGO3"})
	Aadd( aArquivos, { "RECEBIDO",  "RECEBID1","RECEBID2","RECEBID3","RECEBID4","RECEBID5","RECEBID6","RECEBID7","RECEBID8","RECEBID9","RECEBID10","RECEBID11","RECEBID12"})
	Aadd( aArquivos, { "CHEQUE",    "CHEQUE1","CHEQUE2","CHEQUE3"})
	Aadd( aArquivos, { "CHEMOV",    "CHEMOV1","CHEMOV2","CHEMOV3","CHEMOV4","CHEMOV5","CHEMOV6"})
	Aadd( aArquivos, { "CHEPRE",    "CHEPRE1","CHEPRE2","CHEPRE3","CHEPRE4", "CHEPRE5"})
	Aadd( aArquivos, { "USUARIO",   "USUARIO1"})
	Aadd( aArquivos, { "FORMA",     "FORMA1","FORMA2"})
	Aadd( aArquivos, { "CURSOS",    "CURSOS1"})
	Aadd( aArquivos, { "CURSADO",   "CURSADO1","CURSADO2","CURSADO3"})
	Aadd( aArquivos, { "REGIAO",    "REGIAO1", "REGIAO2"})
	Aadd( aArquivos, { "CEP",       "CEP1", "CEP2"})
	Aadd( aArquivos, { "PONTO",     "PONTO1", "PONTO2", "PONTO3"})
	Aadd( aArquivos, { "SERVIDOR",  "SERVIDO1", "SERVIDO2"})
	Aadd( aArquivos, { "PRINTER",   "PRINTER1", "PRINTER2"})
	Aadd( aArquivos, { "ENTNOTA",   "ENTNOTA1", "ENTNOTA2", "ENTNOTA3","ENTNOTA4"})
	Aadd( aArquivos, { "CONTA",     "CONTA1"})
	Aadd( aArquivos, { "SUBCONTA",  "SUBCONT1", "SUBCONT2"})
	Aadd( aArquivos, { "RETORNO",   "RETORNO1"})
	Aadd( aArquivos, { "PREVENDA",  "PREVEND1","PREVEND2","PREVEND3"})
	Aadd( aArquivos, { "CORTES",    "CORTES1"})
	Aadd( aArquivos, { "SERVICO",   "SERVICO1", "SERVICO2"})
	Aadd( aArquivos, { "MOVI",      "MOVI1", "MOVI2","MOVI3","MOVI4"})
	Aadd( aArquivos, { "FUNCIMOV",  "FUNCIMO1", "FUNCIMO2","FUNCIMO3"})
	Aadd( aArquivos, { "GRPSER",    "GRPSER1", "GRPSER2"})
	Aadd( aArquivos, { "RECIBO",    "RECIBO1","RECIBO2","RECIBO3", "RECIBO4", "RECIBO5", "RECIBO6","RECIBO7","RECIBO8","RECIBO9","RECIBO10","RECIBO11", "RECIBO12"})
	Aadd( aArquivos, { "AGENDA",    "AGENDA1","AGENDA2","AGENDA3", "AGENDA4", "AGENDA5", "AGENDA6", "AGENDA7"})
	Aadd( aArquivos, { "CM",        "CM1","CM2","CM2","CM3"})
	//Aadd( aArquivos, { "EMPRESA",   "EMPRESA1"})
	return( aArquivos )
endef

def MensFecha()
*--------------*
	Mensagem("Aguarde, Fechando Arquivos.", WARNING, _LIN_MSG )
	FechaTudo()
	Break
	return
endef	

def FechaTudo()
*-------------------*
	DbCloseAll()
	return	
endef
	
def UsaArquivo( cArquivo, cAlias )
*-----------------------------------*
	STATI lJahAcessou := FALSO
	LOCAL cScreen		:= SaveScreen()
	LOCAL nY 			:= 0
	LOCAL aArquivos	:= ArrayIndices()

	nTodos	:= Len( aArquivos )
	cArquivo := Upper( cArquivo )
	if !lJahAcessou
		lJahAcessou := OK
		Mensagem("Aguarde, Compartilhando o Arquivos. ", WARNING, _LIN_MSG )
	endif
	if cArquivo != NIL
		if cAlias = NIL
			if DbfEmUso( cArquivo )
				ResTela( cScreen )
				return( OK )
			endif
		endif
		nPos := Ascan( aArquivos,{ |oBloco|oBloco[1] = cArquivo })
		if nPos != 0
			nLen := Len(aArquivos[nPos])
			if NetUse( cArquivo, MULTI,, cAlias )
				#ifDEF FOXPRO
				   DbSetIndex(aArquivos[nPos,1] + INDEXEXT)					
				#else
					for nY := 2 To nLen
						DbSetIndex( aArquivos[nPos,nY] + INDEXEXT)
					next
				#endif
		  endif
		else
			Alerta("Erro: Arquivo nao localizado: " + cArquivo + ";" + ;					 
					 Procname(2) + ":" + alltrim(str(Procline(2))) + ";" + ;					 
					 Procname(1) + ":" + alltrim(str(Procline(1))) + ";" + ;					 
			       Procname(0) + ":" + alltrim(str(Procline(0))) ;
					 )
			ResTela( cScreen )
			return( FALSO )
		endif
		ResTela( cScreen )
		return( OK )
	else
		For nX := 1 To nTodos
			cArquivo := aArquivos[nX, 1 ]
			nLen		:= Len(aArquivos[nX])
			if !DbfEmUso( cArquivo )
				if NetUse( cArquivo, MULTI )
					#ifDEF FOXPRO
						DbSetIndex( aArquivos[nX,1] + INDEXEXT)
					#else
						For nY := 2 To nLen
							DbSetIndex( aArquivos[nX,nY] + INDEXEXT )
						Next
					#endif
				 else
					Alerta("Erro: Arquivo nao localizado: " + cArquivo )
					ResTela( cScreen )
					return( FALSO )
				endif
			endif
		Next
		ResTela( cScreen )
		return( OK )
	endif
endef
	
static def Refresh()
	DbSkip(0)
	return Nil
endef

*==================================================================================================*		

def Integridade(cArquivo, aStru )
	LOCAL aStruct	 := DbStruct()
	LOCAL lCriarDbf := OK
	LOCAL cTela
	LOCAL nConta
	LOCAL nX
	
	nConta := Len(aStru)
	cTela  := Mensagem(" Verificando Integridade do database #: ;-;" + cArquivo)
	For nX := 1 To nConta
		cCampo := aStru[nX,1] // NOME DO CAMPO
		IF !AchaCampo( aStruct, aStru, nX, cCampo )
			NovoDbf(cArquivo, aStru, cCampo, lCriarDbf )
			IF lCriarDbf = OK
				lCriarDbf := FALSO
			EndIF
		EndIF
	Next
	DbCloseArea()
	ResTela( cTela )
	return NIL
endef	

*==================================================================================================*		
	
def NovoDbf(cArquivo, aStru, cCampo, lCriarDbf )
	LOCAL cLocalNtx := cArquivo + '.' + CEXT
	LOCAL cTela     := SaveScreen()
	LOCAL cAlias    := Alias() 

	IF lCriarDbf
		(cAlias)->(DbCloseArea())

		Mensagem("Aguarde, renomeando Arquivo: ;-;" + cArquivo)
		ms_swap_ferase(cAlias + ".OLD")
		ms_swap_ferase(cAlias + ".NSX")
		ms_swap_ferase(cAlias + ".CDX")		
		ms_swap_rename(cArquivo, cAlias + ".OLD")
		
		Mensagem("Aguarde, Criando Arquivo Novo: ;-;" + cArquivo)		
		CriaArquivo(cArquivo)
		(cAlias)->(DbCloseArea())
				
		if NetUse(cArquivo, MONO, 2, "XTEMP")
			Mensagem("Aguarde, Incluindo Registros no arquivo Novo: ;-;" + cArquivo)
			if (oAmbiente:LetoAtivo)
				Appe From (oAmbiente:LetoPath + cAlias + ".OLD")
			else	
				Appe From (cAlias + ".OLD") 
			endif	
		endif			
	EndIF
	ResTela( cTela )

	IF cArquivo = "LISTA" .AND. cCampo = "CLASSE"
		cTela := msgconverte(cCampo, cArquivo)
		Lista->(DbGoTop())
		WHILE Lista->(!Eof())
			Lista->Classe := AllTrim( Lista->Classe ) + '0'
			Lista->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "LISTA" .AND. cCampo = "CODIGO"
		cTela := msgconverte(cCampo, cArquivo)
		Lista->(DbGoTop())
		WHILE Lista->(!Eof())
			Lista->Codigo := StrZero( Val( Lista->Codigo ), 6 )
			Lista->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "ENTRADAS" .AND. cCampo = "CODIGO"
		cTela := msgconverte(cCampo, cArquivo)
		Entradas->(DbGoTop())
		WHILE Entradas->(!Eof())
			Entradas->Codigo := StrZero( Val( Entradas->Codigo ), 6 )
			Entradas->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "ENTRADAS" .AND. cCampo = "CFOP"
		cTela := msgconverte(cCampo, cArquivo)
		Entradas->(DbGoTop())
		WHILE Entradas->(!Eof())
			Entradas->Cfop := Left( Entradas->cFop, 3) + '0' + SubStr( Entradas->Cfop, 4, 1 )
			Entradas->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "SAIDAS" .AND. cCampo = "CODIGO" .OR. cArquivo = "SAIDAS" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Saidas->(DbGoTop())
		WHILE Saidas->(!Eof())
			Saidas->Codigo   := StrZero( Val( Saidas->Codigo ), 6 )
			Saidas->Codi	  := StrZero( Val( Saidas->Codi	 ), 5 )
			Saidas->(DbSkip(1))
		EndDo
	EndIF
	IF cArquivo = "RECEBER" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Receber->(DbGoTop())
		WHILE Receber->(!Eof())
			Receber->Codi	 := StrZero( Val( Receber->Codi ), 5 )
			Receber->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "RECEMOV" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Recemov->(DbGoTop())
		WHILE Recemov->(!Eof())
			Recemov->Codi	 := StrZero( Val( Recemov->Codi ), 5 )
			Recemov->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "RECEBIDO" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Recebido->(DbGoTop())
		WHILE Recebido->(!Eof())
			Recebido->Codi   := StrZero( Val( Recebido->Codi ), 5 )
			Recebido->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "NOTA" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Nota->(DbGoTop())
		WHILE Nota->(!Eof())
			Nota->Codi		:= StrZero( Val( Nota->Codi ), 5 )
			Nota->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "VENDEMOV" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Vendemov->(DbGoTop())
		WHILE Vendemov->(!Eof())
			Vendemov->Codi   := StrZero( Val( Vendemov->Codi ), 5 )
			Vendemov->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "CURSADO" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Cursado->(DbGoTop())
		WHILE Cursado->(!Eof())
			Cursado->Codi	 := StrZero( Val( Cursado->Codi ), 5 )
			Cursado->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "RETORNO" .AND. cCampo = "CODI"
		cTela := msgconverte(cCampo, cArquivo)
		Retorno->(DbGoTop())
		WHILE Retorno->(!Eof())
			Retorno->Codi	 := StrZero( Val( Retorno->Codi ), 5 )
			Retorno->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "GRPSER" .AND. cCampo = "GRUPO"
		cTela := msgconverte(cCampo, cArquivo)
		GrpSer->(DbGoTop())
		WHILE GrpSer->(!Eof())
			GrpSer->Grupo := StrZero( Val( GrpSer->Grupo ), 3 )
			GrpSer->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "SERVICO" .AND. cCampo = "GRUPO" .OR. cArquivo = "SERVICO" .AND. cCampo = "CODISER"
		cTela := msgconverte(cCampo, cArquivo)
		Servico->(DbGoTop())
		WHILE Servico->(!Eof())
			Servico->Grupo   := StrZero( Val( Servico->Grupo ), 3 )
			Servico->Codiser := StrZero( Val( Servico->CodiSer ), 3 )
			Servico->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "CORTES" .AND. cCampo = "TABELA" .OR. cArquivo = "CORTES" .AND. cCampo = "CODISER"
		cTela := msgconverte(cCampo, cArquivo)
		Cortes->(DbGoTop())
		WHILE Cortes->(!Eof())
			Cortes->Tabela  := Left( Cortes->Tabela, 5 ) + StrZero( Val( SubStr( Cortes->Tabela, 6, 2 )), 3 )
			Cortes->Codiser := StrZero( Val( Cortes->CodiSer ), 3 )
			Cortes->(DbSkip(1))
		EndDo
	EndIF
	ResTela( cTela )
	IF cArquivo = "MOVI" .AND. cCampo = "TABELA" .OR. cArquivo = "MOVI" .AND. cCampo = "CODISER"
		cTela := msgconverte(cCampo, cArquivo)
		Movi->(DbGoTop())
		WHILE Movi->(!Eof())
			Movi->Tabela  := Left( Movi->Tabela, 5 ) + StrZero( Val( SubStr( Movi->Tabela, 6, 2 )), 3 )
			Movi->Codiser := StrZero( Val( Movi->CodiSer ), 3 )
			Movi->(DbSkip(1))
		EndDo
	EndIF
	return( ResTela( cTela ))
endef

*==================================================================================================*		

def msgconverte(cCampo, cArquivo)
		return(Mensagem("Aguarde, Convertendo campo " + cCampo + " do Arquivo :" + cArquivo))
endef