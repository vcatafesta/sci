#Include "Lista.Ch"
#Define  XEXE            "SCI.EXE"
#Define  XSISTEM_VERSAO  "- Vers„o 01.08.2016.6.3.20 for DOS"
#Define  XSISTEM_1       "Macrosoft SCI - MENU PRINCIPAL"
#Define  XSISTEM_2       "Macrosoft SCI - CONTROLE ESTOQUE"
#Define  XSISTEM_3       "Macrosoft SCI - CONTAS RECEBER"
#Define  XSISTEM_4       "Macrosoft SCI - CONTAS PAGAR"
#Define  XSISTEM_5       "Macrosoft SCI - CONTAS CORRENTES"
#Define  XSISTEM_6       "Macrosoft SCI - CONTROLE VENDEDORES"
#Define  XSISTEM_7       "Macrosoft SCI - CONTROLE PRODUCAO"
#Define  XSISTEM_8       "Macrosoft SCI - CONTROLE PONTO"
#Define  DATALIMITE      DTOC(DATE()+15) // MM/DD/YY

LOCAL cEncrypt       := ENCRYPT
LOCAL cVersao        := XSISTEM_VERSAO
LOCAL cSis1          := XSISTEM_1
LOCAL cSis2          := XSISTEM_2
LOCAL cSis3          := XSISTEM_3
LOCAL cSis4          := XSISTEM_4
LOCAL cSis5          := XSISTEM_5
LOCAL cSis6          := XSISTEM_6
LOCAL cSis7          := XSISTEM_7
LOCAL cSis8          := XSISTEM_8
LOCAL cExe           := XEXE
LOCAL cXnomefir      := ENCRYPT
LOCAL cSystem_Versao := XSISTEM_VERSAO
LOCAL cSci           := XSISTEM_1
LOCAL cTestelan      := XSISTEM_2
LOCAL cReceLan       := XSISTEM_3
LOCAL cPagalan       := XSISTEM_4
LOCAL cChelan        := XSISTEM_5
LOCAL cVendedores    := XSISTEM_6
LOCAL cProducao      := XSISTEM_7
LOCAL cPonto         := XSISTEM_8
Set Century On
Cls

Qout("þþþ Deletando SCI.CFG...")
Ferase("SCI.CFG")
handle := FCreate("SCI.CFG")
Qout("þþþ Criando novo SCI.CFG...")
IF ( Ferror() != 0 )
   Alert("Erro de Criacao de SCI.CFG")
   Quit
EndIF
Qout("þþþ Gravando String em SCI.CFG...")
cMicrobras := "Copyright (c) Vilmar Catafesta"
cEndereco  := "Av Castelo Branco, 693 * (69)3451-3085/98110-1393 * P. Bueno/RO"
cTelefone  := "email * vcatafesta@sybernet.com.br/vcatafesta@gmail.com   "
cCidade    := "http://www.sybernet.com.br - Todos Direitos Reservados"
MsWriteLine( Handle, "[ENDERECO_STRING]")
MsWriteLine( Handle, cMicroBras )
MsWriteLine( Handle, cEndereco )
MsWriteLine( Handle, cTelefone )
MsWriteLine( Handle, cCidade )
//
MsWriteLine( Handle, "" )
//
MsWriteLine( Handle, "[ENDERECO_CODIGO]")
MsWriteLine( Handle, MsCriptar( cMicrobras ))
MsWriteLine( Handle, MsCriptar( cEndereco ))
MsWriteLine( Handle, MsCriptar( cTelefone ))
MsWriteLine( Handle, MsCriptar( cCidade ))
//
MsWriteLine( Handle, "" )
//
MsWriteLine( Handle, "[SCI_STRING]")
MsWriteLine( Handle, " ÚÄÄÄÄÄ¿    ÚÄÄÄÄÄ¿  ÚÄ¿")
MsWriteLine( Handle, " ßßßßßßÀ¿   ßßßßßßÀ¿ ßß³")
MsWriteLine( Handle, "ßßßßßßßß³  ßßßßßßßß³ ßß³")
MsWriteLine( Handle, "ßß³   ßßÙ  ßß³   ßßÙ ßß³")
MsWriteLine( Handle, "ßßÀÄÄÄÄ¿   ßß³       ßß³")
MsWriteLine( Handle, "ßßßßßßßÀ¿  ßß³       ßß³")
MsWriteLine( Handle, " ßßßßßßß³  ßß³       ßß³")
MsWriteLine( Handle, "      ßß³  ßß³       ßß³")
MsWriteLine( Handle, "ßßÄÄÄÄßß³  ßßÀÄÄÄßß³ ßß³")
MsWriteLine( Handle, "ßßßßßßßßÙ  ßßßßßßßßÙ ßß³")
MsWriteLine( Handle, " ßßßßßßÙ    ßßßßßßÙ  ßßÙ")
//
MsWriteLine( Handle, "" )
//
MsWriteLine( Handle, "[SCI_CODIGO]")
MsWriteLine( Handle, MsCriptar(" ÚÄÄÄÄÄ¿    ÚÄÄÄÄÄ¿  ÚÄ¿"))
MsWriteLine( Handle, MsCriptar(" ßßßßßßÀ¿   ßßßßßßÀ¿ ßß³"))
MsWriteLine( Handle, MsCriptar("ßßßßßßßß³  ßßßßßßßß³ ßß³"))
MsWriteLine( Handle, MsCriptar("ßß³   ßßÙ  ßß³   ßßÙ ßß³"))
MsWriteLine( Handle, MsCriptar("ßßÀÄÄÄÄ¿   ßß³       ßß³"))
MsWriteLine( Handle, MsCriptar("ßßßßßßßÀ¿  ßß³       ßß³"))
MsWriteLine( Handle, MsCriptar(" ßßßßßßß³  ßß³       ßß³"))
MsWriteLine( Handle, MsCriptar("      ßß³  ßß³       ßß³"))
MsWriteLine( Handle, MsCriptar("ßßÄÄÄÄßß³  ßßÀÄÄÄßß³ ßß³"))
MsWriteLine( Handle, MsCriptar("ßßßßßßßßÙ  ßßßßßßßßÙ ßß³"))
MsWriteLine( Handle, MsCriptar(" ßßßßßßÙ    ßßßßßßÙ  ßßÙ"))
Fclose(handle)      
Qout("þþþ Arquivo SCI.CFG. OK.")
Qout("þþþ")
Qout("þþþ Criando SCI.DBF.")
CriaDbf()
Qout("þþþ Anexando Informacoes.")
Set Date To USA
Use Sci New
DbAppend()
Sci->EMPRESA  := MsCriptar( ENCRYPT )        ; Sci->NOME     := ENCRYPT
Sci->CODI_SCI := MsCriptar( XSISTEM_1 )      ; Sci->NOME_SCI := XSISTEM_1
Sci->CODI_EST := MsCriptar( XSISTEM_2 )      ; Sci->NOME_EST := XSISTEM_2
Sci->CODI_REC := MsCriptar( XSISTEM_3 )      ; Sci->NOME_REC := XSISTEM_3
Sci->CODI_PAG := MsCriptar( XSISTEM_4 )      ; Sci->NOME_PAG := XSISTEM_4
Sci->CODI_CHE := MsCriptar( XSISTEM_5 )      ; Sci->NOME_CHE := XSISTEM_5
Sci->CODI_VEN := MsCriptar( XSISTEM_6 )      ; Sci->NOME_VEN := XSISTEM_6
Sci->CODI_PRO := MsCriptar( XSISTEM_7 )      ; Sci->NOME_PRO := XSISTEM_7
Sci->CODI_PON := MsCriptar( XSISTEM_8 )      ; Sci->NOME_PON := XSISTEM_8
Sci->CODI_VER := MsCriptar( XSISTEM_VERSAO ) ; Sci->NOME_VER := XSISTEM_VERSAO
Sci->NOMEEXE  := MsCriptar( XEXE )
Sci->LIMITE   := MsCriptar( DATALIMITE )
Set Date Brit
Qout("þþþ", Sci->Nome )
Qout("þþþ Limite", Sci->(MsDcriptar( Limite )))
Qout("þþþ Arquivos de Configuracao OK.")
Qout()
Quit

Function CriaDbf()
******************
LOCAL Dbf1 := {{ "EMPRESA",    "C", 40, 0 },;
               { "NOME",       "C", 40, 0 },;
               { "CODI_SCI",   "C", 45, 0 },;
               { "NOME_SCI",   "C", 45, 0 },;
               { "CODI_EST",   "C", 40, 0 },;
               { "NOME_EST",   "C", 40, 0 },;
               { "CODI_REC",   "C", 40, 0 },;
               { "NOME_REC",   "C", 40, 0 },;
               { "CODI_PAG",   "C", 40, 0 },;
               { "NOME_PAG",   "C", 40, 0 },;
               { "CODI_CHE",   "C", 40, 0 },;
               { "NOME_CHE",   "C", 40, 0 },;
               { "CODI_VEN",   "C", 40, 0 },;
               { "NOME_VEN",   "C", 40, 0 },;
               { "CODI_PRO",   "C", 40, 0 },;
               { "NOME_PRO",   "C", 40, 0 },;
               { "CODI_PON",   "C", 40, 0 },;
               { "NOME_PON",   "C", 40, 0 },;
               { "CODI_VER",   "C", 40, 0 },;
               { "NOME_VER",   "C", 40, 0 },;
               { "NOMEEXE",    "C", 12, 0 },;
               { "LIMITE",     "C", 10, 0 }}
DbCreate("SCI.DBF", Dbf1 )
Return

Function CodiOrigin()
Return NIl

Function Criptar( Pal )
***********************
    LOCAL Fra
    LOCAL X
    LOCAL L
    Fra := ""
    Tam := Len( Pal )
    FOR X := 1 TO Tam
        L := SubStr(Pal, X, 1)
        Fra += Chr(Asc(L) + 61 - 2 * X + 3 * x )
    NEXT
    RETURN Fra

Function DCriptar( Pal )
************************
    LOCAL Fra
    LOCAL X
    LOCAL L
    LOCAL Tam
    Fra := ""
    Tam := Len( Pal )
    FOR X := 1 TO Tam
        L := SubStr(Pal, X, 1)
        Fra += Chr(Asc(L) - 61 + 2 * X - 3 * x )
    NEXT
    RETURN Fra

Function MsDCriptar( Pal )
**************************
LOCAL cChave   := ""
LOCAL nX       := 0

For nX := 0 To 10
   cChave += Chr( Asc( Chr( nX )))
Next
Return( MsDecrypt( Pal, cChave ))

Function MsCriptar( Pal )
*************************
LOCAL cChave   := ""
LOCAL nX       := 0

For nX := 0 To 10
   cChave += Chr( Asc( Chr( nX )))
Next
Return( MsEncrypt( Pal, cChave ))
