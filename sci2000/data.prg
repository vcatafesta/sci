
Aqui voce tem que getar uma data ------> no caso dp1

                         MM=MONTH(DP1)
                         AA=YEAR(DP1)
                         MM++
                         IF MM=13
                            MM=1
                            AA++
                         ENDIF
                         MS=STR(MM)
                         AS=STR(AA)
                         xPAR=ALLTRIM(STR(qPAR))
                         DP&xPAR=CTOD(STR(DAY(DP1)) + MS + AS)
