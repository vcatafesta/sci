 #include "hbclass.ch"

 PROCEDURE Main()

    LOCAL oPerson := Person( "Dave" )

    oPerson:Eyes := "Invalid"

    oPerson:Eyes := "Blue"

    Alert( oPerson:Describe() )
 RETURN

 CLASS Person
    DATA Name INIT ""

    METHOD New() CONSTRUCTOR

    ACCESS Eyes INLINE ::pvtEyes
    ASSIGN Eyes( x ) INLINE IIF( ValType( x ) == 'C' .AND. ;
                 x IN "Blue,Brown,Green", ::pvtEyes := x,; 
                 Alert( "Invalid value" ) )

    // Sample of IN-LINE Method definition
    INLINE METHOD Describe()
       LOCAL cDescription

       IF Empty( ::Name )
          cDescription := "I have no name yet."
       ELSE
          cDescription := "My name is: " + ::Name + ";"
       ENDIF

       IF ! Empty( ::Eyes )
          cDescription += "my eyes' color is: " + ::Eyes
       ENDIF
    ENDMETHOD

    PRIVATE:
       DATA pvtEyes
 ENDCLASS

 // Sample of normal Method definition.
 METHOD New( cName ) CLASS Person

   ::Name := cName

 RETURN Self
 