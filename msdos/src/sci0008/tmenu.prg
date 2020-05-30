#include "hbclass.ch"
#Include "Box.Ch"
#Include "Inkey.Ch"

#Define FALSO               .F.
#Define OK                  .T.
#define SETA_CIMA           5
#define SETA_BAIXO          24
#define SETA_ESQUERDA       19
#define SETA_DIREITA        4
#define TECLA_SPACO         32
#define TECLA_ALT_F4        -33
#define ENABLE              .T.
#define DISABLE             .F.
#define LIG                 .T.
#define DES                 .F.
#define ESC                 27
#define ENTER               13
#xcommand PUBLIC:           =>    nScope := HB_OO_CLSTP_EXPORTED ; HB_SYMBOL_UNUSED( nScope )

class TMenu from TAmbiente

	public:
		method New
		
	public Menu1
	
endclass

method New( oOwner ) class TMenu

   ::New( oOwner )
	//with Self
	    *
		 ::setvar()	
       ::StatusSup      := "MicroBras"
       ::StatusInf      := ""
		 ::Panos          := ::SetPano()
		 ::Menu           := ::xMenu()
       ::Disp           := ::xDisp()
       ::Alterando      := FALSO
       ::Ativo          := 1
       ::nPos           := 1
       ::NomeFirma      := "MICROBRAS COM DE PROD DE INFORMATICA LTDA"
       ::CodiFirma      := '0001'
       ::StSupArray     := { ::StatusSup }
       ::StInfArray     := { ::StatusInf }
       ::MenuArray      := { ::Menu }
       ::DispArray      := { ::Disp }
	//endwith
	
return(self)

Function TMenuNew()
	return( TMenu():New())
