/*
ษออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออป
บ                                o:Clip                                บ
บ             An Object Oriented Extension to Clipper 5.01             บ
บ                 (c) 1991 Peter M. Freese, CyberSoft                  บ
ศออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผ

Version 1.01 - November 8, 1991
*/

#xcommand CLASS <name> FROM <parent> => ;
  CLASS <name> XFROM <parent>()

#xcommand CLASS <name> [ XFROM <parent> ] => ;
  FUNCTION <name>;;
  STATIC hClass := 0, oParent;;
  LOCAL oNew;;
    if hClass == 0;;
      oParent := __DefineClass(<"name">,<{parent}>)

#xcommand VAR <var1> [,<varN>] => ;
      __AddVar(<"var1">) [; __AddVar(<"varN">)]

#xcommand METHOD <methodName> [,<*methodN*>] => ;
      __AddMethod(<"methodName">, <"methodName">) [; METHOD <methodN>]

#xcommand METHOD <methodName> = <methodUDF> [,<*methodN*>] => ;
      __AddMethod(<"methodName">, <"methodUDF">) [; METHOD <methodN>]

#xcommand ENDCLASS => ;
      hClass := __MakeClass();;
    end;;
  oNew := __ClassIns(hClass);;
  oNew\[1] := oParent;;
  RETURN oNew

#xtranslate :: => self:

#xtranslate self => QSELF()

#xtranslate super => parent

#xtranslate METODO => FUNCTION
#xtranslate CLASSE => CLASS
#xtranslate ENDCLASSE => ENDCLASS

#xtranslate parent:<method> => ;
  __PARENT( {|o| o:<method> } )

#xtranslate parent:<method>:<*Anything*> => ;
  parent:<method> ;;
  #error Chaining not allowed after overridden method call.

