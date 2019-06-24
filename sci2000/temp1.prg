Proc CalculaPonto()
*******************
FIELD Manha1
FIELD Manha2
FIELD Tarde1
FIELD Tarde2
LOCAL nSoma1 := TimeDiff( Manha1, Manha2)
LOCAL nSoma2 := TimeDiff( Tarde1, Tarde2)
LOCAL nSobra := 0
LOCAL nCarga := 0

IF ( Ponto->Manha1 = "00:00" .AND. Ponto->Manha2 = "24:00" .AND. Ponto->Tarde1 = "00:00" .AND. Ponto->Tarde2 = "00:00" )
	 Nsoma1 := "24:00:00"
ENDIF
IF ( Ponto->Manha1 = "00:00" .AND. Ponto->Tarde2 = "24:00" .AND. Ponto->Manha2 = "00:00" .AND. Ponto->Tarde1 = "00:00" )
	 Nsoma1 := "24:00:00"
ENDIF
nSoma1 := Val(Stuff(Left(Nsoma1, 5), 3, 1, "."))
nSoma2 := Val(Stuff(Left(Nsoma2, 5), 3, 1, "."))
***************************************************
nCarga := nSoma1 + nSoma2
nSobra := nCarga - Int( nCarga)
***************************************************
nSobra1 := nSoma1 - Int( nSoma1 )
nSobra2 := nSoma2 - Int( nSoma2 )
nCarga  := Int( nSoma1 ) + Int( nSoma2 )
nSobra  := nSoma1 + nSoma2




Cls
? 'nSoma1', nSoma1
? 'nSoma2', nSoma2
? 'nCarga', nCarga
? 'nSobra', nSobra
Inkey(0)
IF ( nSobra > 0.59 )
    nCarga -= nSobra
    nSobra -= 0.6
    nCarga ++
    nCarga += nSobra
ENDIF
Ponto->Quant  := 0
Ponto->Quant  += nCarga
Return
