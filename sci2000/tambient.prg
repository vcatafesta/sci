#ifdef MSWINDOWS
   #include "hbclass.ch"
   #Include "Pragma.Ch"
#else
   #include "classic.ch"
#endif
#Include "Box.Ch"
#Include "Inkey.Ch"

#define ENABLE     .T.
#define DISABLE    .F.
#define FALSO      DISABLE
#define OK         ENABLE
#define ESC        27
#define ENTER      13

#ifdef MSWINDOWS
   CLASS TAmbiente
#else
   BEGIN CLASS TAmbiente
#endif

    Export:
        VAR Ano2000
        VAR Frame
        VAR Visual
        VAR CorMenu
		  VAR CorLightBar
		  VAR CorHotKey
		  VAR CorHKLightBar
        VAR xUsuario
        VAR Selecionado
        VAR CorDesativada
        VAR CorAntiga
        VAR CorCabec
        VAR Sombra
        VAR CorBorda
        VAR CorAlerta
        VAR CorBox
        VAR CorCima
        VAR CorFundo
        VAR Fonte
        VAR Panos
        VAR PanoFundo
        VAR Isprinter
        VAR aPermissao
        VAR xBase
        VAR xBaseDados
        VAR xBaseDoc
        Var xImpressora
        VAR Get_Ativo
        VAR Acento
        VAR xDataCodigo
        VAR Spooler
        VAR Externo
        VAR cArquivo
        VAR TabelaFonte
        VAR CorMsg
        VAR Argumentos
        VAR Drive
        VAR Normal
        VAR Mostrar_Desativados
        VAR Mostrar_Recibo
        VAR PosiAgeInd
        VAR PosiAgeAll
        VAR RecePosi
        VAR lReceber
        VAR cTipoRecibo
        VAR lGreenCard
        VAR lComCodigoAcesso
        VAR aFiscalIni
        VAR xLimite
        VAR _Empresa
        VAR xFanta
        VAR xNomefir
        VAR xEmpresa
        VAR xJuroMesComposto
        VAR xJuroMesSimples
        VAR aSciArray
        VAR aAtivo
        VAR lContinuarAchoice
        VAR lK_Insert
  		  VAR Menu 
        VAR Disp 
		  VAR nPos
		  
    Export:
        METHOD New CONSTRUCTOR
		  METHOD ConfAmbiente
        METHOD Ano2000On
        METHOD Ano2000Off
        METHOD SetVar
        METHOD SetSet
		  METHOD SetPano
  
ENDCLASS

METHOD Ano2000On()
   Set Epoch To 1950
   ::Ano2000 := OK
Return( Self )

METHOD Ano2000Off()
   Set Epoch To 1900
   ::Ano2000 := FALSO
Return( Self )

METHOD New()
        ::Argumentos          := Argc()          
        ::Drive               := IF( ::Argumentos = 0,  NIL, Argv(1))
        ::Normal              := IF( ::Argumentos <= 2, NIL, Argv(3))
		  ::Visual              := IF( ::Argumentos <= 1, FALSO, OK )
	
        ::Panos               := ::SetPano()    
	     ::Selecionado         := 10     // Pano de Fundo Selecionado
	     ::PanoFundo           := ::Panos[10]
	     ::Frame               := "ÚÄ¿³ÙÄÀ³"
        ::Cormenu             := 48
		  ::CorDesativada       := 56
        ::CorLightBar         := 15
		  ::CorHotKey           := 63
        ::CorHKLightBar       := 14
        ::Ano2000             := DISABLE
   	  ::Menu                := xMenu()
        ::Disp                := xDisp()
		  ::nPos                := 1
		  ::SetPano()

        M_Frame( ::Frame )
		  Qout("þ Carregando Configuracao.")
        IF ::Drive = NIL
           ::Drive := FCurdir()
		  Else
           ::Drive := AllTrim(Upper(::Drive))
           IF Left(::Drive, 2) == "\\"      // Drive Mapeado
              IF Len(::Drive) > 2
                 IF Right(::Drive, 1) == "\"   // Drive Mapeado em Diretorio
                    ::Drive := Left(::Drive,Len(::Drive)-1)
                 EndIF
              EndIF
           EndIF

           IF Len(::Drive) = 3
              IF SubStr(::Drive, 2,2) == ":\"
                 ::Drive := Left(::Drive,Len(::Drive)-1)
              EndIF
           EndIF

           /*
           IF !IsDir(::Drive)
				  ErrorBeep()
              IF Alert("Pergunta: Drive " + ::Drive + " invalido. Usar o corrente ?", {"Sim", "Nao"}) == 1
                 ::Drive := FCurdir()
				  Else
					  Quit
				  EndIF
           EndIF
           */

		  EndIF

        IF ::Normal = NIL .OR. ::Drive = NIL
           //Visual()
        EndIF

        ::SetVar()
        ::Isprinter     := 1
        ::aPermissao    := {}
        ::xBase         := ( ::Drive )
        ::xBaseDados    := ( ::Drive )
        ::xBaseDoc      := ( ::Drive )
        ::xImpressora   := 1
        ::Get_Ativo     := OK
        ::Acento        := FALSO
        ::xDataCodigo   := "  /  /  "
        ::Spooler       := FALSO
        ::Externo       := FALSO
        ::cArquivo      := ""
        ::ConfAmbiente()
Return( Self )

METHOD ConfAmbiente()
*********************		
		 IF ::Argumentos = 0
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 1
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 2
          ::Frame := "ÉÐËÇÊÌÈ¶"
       ElseIF ::Argumentos = 3
          ::Frame := "ÚÄ¿³ÙÄÀ³"
		 EndIF
		 ::Frame := "ÚÄ¿³ÙÄÀ³"
		 
       M_Frame( ::Frame )
       ::xBase           := ( ::Drive )
       ::TabelaFonte     := Array(16)
       ::TabelaFonte[01] := {|| SetMode(25,80)}
       ::TabelaFonte[02] := {|| SetMode(25,80)}
       ::TabelaFonte[03] := {|| SetMode(25,132)}
		 ::TabelaFonte[04] := {|| SetMode(25,160)}
       ::TabelaFonte[05] := {|| SetMode(28,80)}
       ::TabelaFonte[06] := {|| SetMode(28,132)}
		 ::TabelaFonte[07] := {|| SetMode(28,160)}
       ::TabelaFonte[08] := {|| SetMode(33,80)}
       ::TabelaFonte[09] := {|| SetMode(33,132)}
		 ::TabelaFonte[10] := {|| SetMode(33,160)}
       ::TabelaFonte[11] := {|| SetMode(40,80)}
       ::TabelaFonte[12] := {|| SetMode(40,132)}
		 ::TabelaFonte[13] := {|| SetMode(40,160)}
		 ::TabelaFonte[14] := {|| SetMode(43,80)}
		 ::TabelaFonte[15] := {|| SetMode(50,80)}
		 ::TabelaFonte[16] := {|| SetMode(25,80)}
		 ::SetSet()

       IF ::Fonte > 1
		    Eval( ::TabelaFonte[ ::Fonte ] )
		 EndIF
       #ifdef MSDOS
          //BlinkBit( .F. )
          //Border( ::CorBorda )
          //Shadowtype(1, 512, chr(255)+chr(255)+chr(255))
          //SetShadow( ::Sombra )
          //Palette( ::CorAntiga, ::CorFundo )
          //setattrib("y", ::CorMenu - 1)   // Cor de menu - 1
          //setattrib("v", 12+16)           // Vermelho
          //setattrib("a", 14+16)           // Amarelo
          //setattrib("d", 10+16)           // Verde
          //setattrib("c", 11+16)           // Ciano
          //setattrib("m", 13+16)           // Magenta
          //setattrib("p", ::CorFundo*16)   // Palette color
          //setattrib("q", ::CorFundo*16)   // Palette color
          //setattrib("z", 126)             //
       #else
          FT_Shadow( ::Sombra )
       #endif
return( Self )

METHOD SetSet()
       Set Conf Off
		 Set Bell On
		 Set Scor Off
		 Set Wrap On
		 Set Mess To 22
		 Set Dele On
		 Set Date Brit
		 Set Deci To 2
		 Set Print To
		 Set Fixed On
		 SetCancel( .F. )
return( self )

METHOD SetVar()
        IF ::Visual != NIL
           ::Frame  := "ÉÐËÇÊÌÈ¶"
        Else
           ::Frame  := "ÚÄ¿³ÙÄÀ³"
        EndIF
        ::Sombra              := OK
        ::Mostrar_Desativados := OK
        ::Mostrar_Recibo      := OK
        ::PosiAgeInd          := FALSO
        ::PosiAgeAll          := FALSO
        ::Receposi            := FALSO
        ::lReceber            := OK
        ::cTipoRecibo         := "RECCAR"
        ::lGreenCard          := FALSO
        ::lComCodigoAcesso    := FALSO
        ::aFiscalIni          := NIL
        ::xLimite             := NIL
        ::_Empresa            := NIL
        ::xNomefir            := NIL
        ::xEmpresa            := NIL
        ::xJuroMesSimples     := 0
        ::xJuroMesComposto    := 0
        ::xFanta              := NIL
        ::aSciArray           := Array(1,8)
        ::aAtivo              := {}
        ::lContinuarAchoice   := FALSO
        ::lK_Insert           := FALSO
        ::CorMsg        := 7
        ::CorAlerta     := 88     // Cor do menu Alerta
        ::Fonte         := 1      // FlReset()
        ::CorBorda      := 16     // Cor da Borda
        ::CorAntiga     := 05
        ::CorCima       := 128
        ::CorBox        := 9
        ::CorCabec      := 114    // Cor do Cabecalho
        ::CorFundo      := 31     // Cor Pano de Fundo
        ::Selecionado   := 10     // Pano de Fundo Selecionado
        ::Ano2000       := DISABLE
        ::xUsuario      := "ADMIN"
        ::PanoFundo     := ::Panos[ ::Selecionado ]			 
return( self )

#ifdef MSWINDOWS
   METHOD SetPano() CLASS TAmbiente
#else
   METHOD SetPano()
#endif
        ::Panos         := {" MicroBras ", ;
          "Û²°±MicroBrasÛ±²°",;
          "°°°°°°°°°°±±±±±±±±±²²²²²²²²²²±±±±±±±±±±", ;
			 "°°°°°°°°°±±±±±±±±²²²²²²²²²±±±±±±±±±", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²±±²°²²", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²", ;
			 "±±°±²±²°±°±°°²°²±²±²²", ;
			 "°²±²±²°±²±°²°±²°²°²±", ;
			 "±±°±²±²°±°±°°²°²±²±²²±±²Û²°", ;
			 "±±±±±±±°°°°°°°°", ;
			 "²²²²²²²±±±±±±", ;
			 "²²²²²²²±±±±±", ;
          "°±²Û²±°",;
			 " °±²Û²±°", ;
			 "  °°±±²²±±°°", ;
			 " °±²Û", ;
			 "°±²", ;
			 "Û", ;
			 "²", ;
			 "±", ;
          "°", ;
          "ÅÅ", ;
			 " ", ;
          "þþþþþþþþþþþþþþ", ;
			 "ú.ù,ú'ù.';ùþùú    ", ;
          "ú.ù.'ú.'ù.ù'", ;
          "MicroBras Informatica                                       ", ;
          "MicroBras Informatica                                      ", ;
          "MicroBras Informatica                                     ", ;
          "MicroBras Informatica                                    ", ;
          "MicroBras Informatica                                   ", ;
          "MicroBras Informatica                                  ", ;
          "MicroBras Informatica                                 ", ;
          "MicroBras                                            ", ;
          "MicroBras                                           ", ;
          "MicroBras                                          ", ;
          "MicroBras                                         ", ;
          "MicroBras                                        ", ;
          "MicroBras                                       ", ;
          "MicroBras                                      ", ;
          "MicroBras                                     ", ;
          "MicroBras                                    ", ;
          "MicroBras                                   ", ;
          "MicroBras                                  ", ;
          "MicroBras                                 ", ;
          "MicroBras                                ", ;
          "MicroBras                               ", ;
          "MicroBras                              ", ;
          "MicroBras                             ", ;
          "MicroBras                            ", ;
          "MicroBras                           ", ;
          "MicroBras                          ", ;
          "MicroBras                         ", ;
          "MicroBras                        ", ;
          "MicroBras                       ", ;
          "MicroBras                      ", ;
          "MicroBras                     ", ;
          "MicroBras                    ", ;
          "MicroBras                   ", ;
          "MicroBras                  ", ;
          "MicroBras                 ", ;
          "MicroBras                ", ;
          "MicroBras               ", ;
          "MicroBras              ", ;
          "MicroBras             ", ;
          "MicroBras            ", ;
          "MicroBras           ", ;
          "MicroBras          ", ;
          "MicroBras         ", ;
          "MicroBras        ", ;
          "MicroBras       ", ;
          "MicroBras      ", ;
          "MicroBras     ", ;
          "MicroBras    ", ;
          "MicroBras   ", ;
          "MicroBras  ", ;
          "MicroBras ", ;
          "MicroBras","ÄÁÂ", "°±²Û", "²", "±", "Û", "°", "Î", " À¿", " É¼", "ÄÁÂ", " ", "ú.ù.'ú.'ù.ù'",;
          "À¿À¿",;
          "ÊËËÊ",;
          "ÁÂÂÁ",;
          "Ã´´Ã",;
          "¹ÌÌ¹",;
          "°°°°°±±±±±°°°°°²²²²²",;
          "ÍÊÍËÍËÍÊ",;
          "ÄÁÄÂÄÂÄÁ",;
          "=-",;
          ":-",;
          "%%",;
          "##",;
          "@@"}
			
return( self:panos )

Function TAmbienteNew()
**********************
Return( TAmbiente():New())
