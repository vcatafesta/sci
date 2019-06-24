Use Receber New
DbgoTop()
nConta = 0
While !Eof()
   cFone     := TrocaFone( Receber->Fone )
   cFax      := TrocaFone( Receber->Fax )
   cFone1    := TrocaFone( Receber->Fone1 )
   cFone2    := TrocaFone( Receber->Fone2 )
   cFoneAval := TrocaFone( Receber->FoneAval )
   Receber->Fone     := cFone
   Receber->Fax      := cFax
   Receber->Fone1    := cFone1
   Receber->Fone2    := cFone2
   Receber->FoneAval := cFoneAval
   Receber->(DbSkip(1))
EnddO


Function TrocaFone( cFone )
***************************
//(0069)451-2286
IF Left(cFone, 6) == "(0069)" .AND. ;
   SubStr( cFone, 10,1) == "-"  .AND. ;
   SubStr( cFone, 07,1) != "9" .AND. ;
   SubStr( cFone, 07,1) != "8"
   cTroca := "(69)93" + Substr(cFone,7,8)
   ? cFone, cTroca

ElsEIF Left(cFone, 6) == "(0069)" .AND. ;
   SubStr( cFone, 10,1) = "-" .AND. ;
   SubStr( cFone, 07,1) = "9" .OR. ;
   SubStr( cFone, 07,1) = "8"
   cTroca := "(69)99" + Substr(cFone,7,8)
   ? cFone, cTroca

ElseIF Left(cFone, 6) == "(069 )" .AND. ;
   SubStr( cFone, 10,1) == "-"  .AND. ;
   SubStr( cFone, 07,1) != "9" .AND. ;
   SubStr( cFone, 07,1) != "8"
   cTroca := "(69)93" + Substr(cFone,7,8)
   ? cFone, cTroca

ElsEIF Left(cFone, 6) == "(069 )" .AND. ;
   SubStr( cFone, 10,1) = "-" .AND. ;
   SubStr( cFone, 07,1) = "9" .OR. ;
   SubStr( cFone, 07,1) = "8"
   cTroca := "(69)99" + Substr(cFone,7,8)
   ? cFone, cTroca

ElsEIF Left(cFone, 6) == "(0693)" .AND. ;
   SubStr( cFone, 10,1) = "-"
   cTroca := "(69)93" + Substr(cFone,7,8)
   ? cFone, cTroca
ElsEIF Left(cFone, 6) == "(0699)" .AND. ;
   SubStr( cFone, 10,1) = "-"
   cTroca := "(69)99" + Substr(cFone,7,8)
   ? cFone, cTroca
ElsEIF Left(cFone, 6) == "(0698)" .AND. ;
   SubStr( cFone, 10,1) = "-"
   cTroca := "(69)98" + Substr(cFone,7,8)
   ? cFone, cTroca
Else
    cTroca := cFone
    Qout(cFone, "Sem troca")
EndIF
Return( cTroca )
