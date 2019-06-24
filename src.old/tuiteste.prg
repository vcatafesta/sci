#include "tui.ch"

FUNCTION Main()
  LOCAL oApplication
  LOCAL oWindow

  SETMODE( 40, 100 )

  oApplication := Application():New()

  oWindow := Window():New()
  oWindow:show()

  oApplication:exec()

RETURN ( 0 )