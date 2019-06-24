[configuracao]                      ; Configuracao da Impressora
ImprimirCondensado=0                ; 0=Nao      1=Sim
Imprimir12Cpi=1                     ; 0=Nao      1=Sim
ImprimirNegrito=1                   ; 0=Nao      1=Sim
EspacamentoVertical=1               ; 0=1/6"     1=1/8"
TamanhoPagina=32                    ; Comprimento Vertical do Formulario.

[cabecalho]                         ; Configuracao do Boleto
LocalDePagamento=-1,-1              ; Linha,Coluna do Local do Pagamento
Vencimento=01,68                    ; Linha,Coluna do Vencimento
DataDeEmissao=06,01                 ; Linha,Coluna da Data de Emissao
NrDocumento=06,12                   ; Linha,Coluna da N§ do Documento
Especie=06,35                       ; Linha,Coluna da Especie de Documento
Moeda=-1,-1                         ; Linha,Coluna da Especie de Moeda
ValorDocumento=08,60                ; Linha,Coluna do Valor do Documento
Instrucoes=11,02                    ; Linha,Coluna das Instrucoes
Sacado=20,06                        ; Linha,Coluna do Sacado

              Obs. Para nao imprimir uma opcao digite a Linha, Coluna
                   com valores negativos. Ex.: Especie=-1,-1
