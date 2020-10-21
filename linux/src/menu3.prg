/*
	Exemplo de menu usando menumodal e 
	menusys1 (menusys original modificado para eventos do mouse
	Major Anilto - 17Abr2020
*/

#include "button.ch"
#include "inkey.ch"
#include "box.ch"

/* Para usar acentuações, mouse, etc */
#include "hbgtinfo.ch"		//acrescentado no harbour
REQUEST HB_LANG_PT			//acrescentado no harbour - português
REQUEST HB_CODEPAGE_PTISO	//acrescentado no harbour - codepage 
REQUEST HB_GT_WVT_DEFAULT

Function Main()
	LOCAL oInfo
	LOCAL Retorno := 0
	LOCAL sai := "N"
	PUBLIC Coluna := 80
	PUBLIC Linha := 40
	
	/* Para usar acentuações, etc.) */
	HB_LANGSELECT('PT')
	HB_CDPSELECT('PTISO')   
   	HB_GtInfo( HB_GTI_MAXIMIZED, .F. )
	HB_GtInfo( HB_GTI_FONTNAME, "Courier Prime" )
	HB_GtInfo( HB_GTI_WINTITLE, "Teste de menu" )
	
	/* Configurações do ambiente */
	SET( _SET_EVENTMASK, INKEY_ALL )	   
	MSETCURSOR(.T.)
	set cursor off
	set score off
	setmode(Linha,Coluna)
	Cls
	/* Isto permite mudar toda a paleta de cores */
	PALETA()
	/* Chamada para criar um objeto de menu */
	oInfo:=CriaMenu()
	/* Loop para execução do menu */
	WHILE Retorno == 0
		Retorno := MENUMODAL(oInfo,1,Linha-1,0,Coluna-1,"W+/b")
		/* Aqui chama alguma função para tratar a saída do sistema */
	ENDDO
Return ( NIL )
	
/* Criação da estrutura do menu */
Function CriaMenu() // Usando a função MenuModal()
   LOCAL oTopBar, oPopUp, oPopUp1, oPopUp2
   LOCAL COR := "w/bg,W+/rb,gr+/bg,gr+/rb,w/N,w/B" 
   LOCAL COR1 := "w+/b,W+/rb,gr+/g,gr+/rb,w/N,w/B"
   
	/* Cria a barra de menus na linha 1, a partir da coluna 1 até a coluna Coluna-2) */
    oTopBar := TopBar( 1,0, Coluna - 1) 	/* linha, coluna tamanho */
    oTopBar:ColorSpec :=cor1				/* especifica as cores */
	
	/* Coloca os elementos do menu */
    oTopBar:AddItem( MenuItem ( "Pedido",{ || Pedido()},,"Novo pedido") )			
    oTopBar:AddItem( MenuItem ( "Cadastro",{ || Cadastro()},, "Cadastro de clientes") )	
    oTopBar:AddItem( MenuItem ( "Fornecedores",{ || Forn()},,"Cadastro de fornecedores") )		
    oTopBar:AddItem( MenuItem ( "Estoque",{ || Estoque()},, "Controle de estoque") )	
    oTopBar:AddItem( MenuItem ( "Utilitários",{ || Util()},,"POPUP") )	
	
Return ( oTopBar)

/* Funções chamadas pelos itens do menu */
Function Pedido()
Alert("Novos pedidos")
Return

Function Cadastro()
Alert("Cadastramento de clientes")
Return

Function Forn()
Alert("Cadastramento de fornecedores")
Return

Function Estoque()
Alert("Controle de estoque")
Return

Function Util()
Alert("Utilitários do sistema")
Return

/* Função que muda a paleta de cores */
Function paleta()
	local aPal := { 	0x000000, ; //0 N
						0xd27619, ; //1 B
						0x004d00, ; //2 G
						0xc1ac00, ; //3 BG
						0x1c1cb7, ; //4 R
						0xdaa89f, ; //5 RB
						0xc8ccd7, ; //6 GR
						0x222222, ; //7 N+
						0x888888, ; //8 W 
						0xfab481, ; //9 B+
						0x84c781, ; //10 G+
						0xf2ebb2, ; //11 BG+
						0x7373e5, ; //12 R+
						0xdb9db3, ; //13 RB+
						0x58eeff, ; //14  GR+
						0xffffff }  //15 W+
	aPal1 := HB_GtInfo( HB_GTI_PALETTE, aPal)

Return NIL




