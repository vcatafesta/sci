//////////////////////////////////////////////////////////////////////////////
// sample.prg -- Programa exemplo para ECF-Zanthus
//               Versao: 1.00  07/96   S.M.S
//
// OBS:     1. Esse programa e para fins de demostracao somente.
//             A Zanthus nao se responsabiliza por quaisquer problemas
//             ocasionados pelo uso deste exemplo.
//
//          2. Esse programa nao possui todas as consistencias necessarias
//             para um programa real, mas informa nos comentarios quais
//             elas seriam.
//
//          3. Este exemplo permite o acesso de qualquer operacao na impressora
//             em qualquer estado (Dia nao inicializado, Dia inicializado,
//             venda iniciada, etc..) para visualizacao do retorno da
//             ECF - Zanthus nestes casos (certamente com erro)
//
//          4. Para referencia completa dos comandos da ECF-Zanthus
//             cheque o manual de programacao.
//
//          5. Para continuar a operacao apos uma queda de sistema e necessario
//             armazenar todas as operacoes efetuadas na impressora em disco
//             e depois ao reinicializar o sistema, comparar o estado da
//             impressora e totais gerados na memoria da ECF - Zanthus
//             com as gravacoes para retornar a venda.
//////////////////////////////////////////////////////////////////////////////

#include "box.ch"
#include "Fileio.ch"
#include "Inkey.ch"
#define F_BLOCK 134

//////////////////////////////////////////////////////////////////////////////
// GLOBAIS
//             nColunas -- Numero de colunas na ECF
//                         Inicializado em ZanthusBuscaInformacoesPreliminares
//                         Utilizado em  ZT_VD_Item e  ZT_VD_Total
//
//             flag_Aut -- Autenticacao por cima  - Sim ou nao
//          flag_Cheque -- Impressao de Cheque    - Sim ou nao
//////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////
// Main                 -- Modulo pricipal de execucao do programa
//
//            USADO POR -- <>
//                  USA -- ZanthusInicializaDriver
//                         InicializaTela
//                         ZanthusBuscaInformacoesPreliminares
//                         MainMenu
//                         ZanthusBeginDiaFiscal
//                         ZanthusVendaProduto
//                         ZanthusEndDiaFiscal
//                         ZanthusAutenticacaoDocumento
//                         ZanthusImpressaoCheque
//                         ZanthusLeituraX(nHandle, BufferDriverZanthus)
//                         ZanthusNaoSujeitaICMS(nHandle, BufferDriverZanthus)
//                         ZanthusTerminaDriver
//////////////////////////////////////////////////////////////////////////////
PROCEDURE Main
    LOCAL nChoice, car
    LOCAL Saida, nHandle
    SET COLOR TO "W+/B, GR+/B"
    BufferDriverZanthus := SPACE(F_BLOCK)
    nHandle := ZanthusInicializaDriver(BufferDriverZanthus)
    InicializaTela()
    Saida    := 0
    nColunas := 0
    nChoice  := 0
    flag_Aut := 0
    flag_Cheque := 0
    car := 10
    DO WHILE(Saida=0)
        ZanthusBuscaInformacoesPreliminares(nHandle, BufferDriverZanthus)
        nChoice := MainMenu(nChoice)
        @ 23,1 SAY SPACE(78)
        DO CASE
        CASE nChoice = 1
            @ 23,28 SAY "[Inicio de Dia Fiscal]"
            ZanthusBeginDiaFiscal(nHandle, BufferDriverZanthus)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE nChoice = 2
            @ 23,36 SAY "[Venda]"
            ZanthusVendaProduto(nHandle, BufferDriverZanthus)
            @  11, 1 CLEAR TO 21,78
            @  12, 0 SAY "º"
            @  12,79 SAY "º"
        CASE nChoice = 3
            @ 23,27 SAY "[Termino de Dia Fiscal]"
            ZanthusEndDiaFiscal(nHandle, BufferDriverZanthus)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE nChoice = 4
            @ 23,24 SAY "[Autenticacao de documento]"
            ZanthusAutenticacaoDocumento(nHandle, BufferDriverZanthus)
        CASE nChoice = 5
            @ 23, 34 SAY "[Leitura X]"
            ZanthusLeituraX(nHandle, BufferDriverZanthus)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE nChoice = 6
            @ 23, 25 SAY "[Operacao nao sujeita ao ICMS]"
            ZanthusNaoSujeitaICMS(nHandle, BufferDriverZanthus)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE nChoice = 7
            @ 23,29 SAY "[Impressao de cheque]"
            IF(flag_Cheque=1)
                ZanthusImpressaoCheque(nHandle, BufferDriverZanthus)
            ENDIF
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
             @  11, 1 CLEAR TO 21,78
        CASE nChoice = 8
            @ 23,30 SAY "[Saida do programa]"
            Saida := 1
        OTHERWISE
            @ 23,30 SAY "[Programa abortado]"
            Saida := 1
        ENDCASE
    ENDDO
    ZanthusTerminaDriver(nHandle)
RETURN

//////////////////////////////////////////////////////////////////////////////
// InicializaTela       -- Formatacao Inicial de tela
//
//            USADO POR -- Main
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
PROCEDURE InicializaTela()
    CLEAR SCREEN
    @  10, 0 TO 22, 79
    @  0, 0,24, 79 BOX B_DOUBLE
    @  0, 0, 2, 79 BOX B_DOUBLE
    @  2, 0 SAY "Ì"
    @  2,79 SAY "¹"
    @  10, 0 SAY "Ç"
    @  10,79 SAY "¶"
    @ 22, 0 SAY "Ç"
    @ 22,79 SAY "¶"
    @  1, 1 SAY "          ZANTHUS - Programa de comunicacao com a ECF - Zanthus           "
    @  3, 1 SAY "       Versao:__.__    Tipo:__        Data:__/__/__ Hora:__:__:__" COLOR "RB+/B"
    @  4, 1 SAY "      Colunas:__     Linhas:__     Bobinas:__  Tracejado:__"  COLOR "RB+/B"
    @  5, 1 SAY "      Picotar:___        Impressao Cheques:___  Imprime folha avulsa:___"  COLOR "RB+/B"
    @  6, 1 SAY "      Aliquotas ICMS:__.__ __.__ __.__ __.__ __.__ Subtotal Cupom:___.___,__"  COLOR "RB+/B"
    @  7, 1 SAY "                     __.__ __.__ __.__ __.__ __.__"  COLOR "RB+/B"
    @  8, 1 SAY "              Estado:" COLOR "RB+/B"
    @  9, 1 SAY "            Sensores:" COLOR "RB+/B"
RETURN

//////////////////////////////////////////////////////////////////////////////
//  MainMenu            -- Menu Principal do Programa.
//                         Aceita default de opcao (Para manter posicao, ao
//                                                  retorna da execucao)
//                         Retorna Opcao escolhida ao Principal
//
//            USADO POR -- Main                                     a
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
FUNCTION MainMenu(menuChoice)
    SET WRAP ON
    SET MESSAGE TO 23 CENTER
    @ 23,1 SAY SPACE(78)
    @ 12,33 SAY "MENU PRINCIPAL"
    @ 11,32,13,47 BOX B_SINGLE
    @ 14,30 PROMPT "1.Inicializacao de dia" MESSAGE "Operacao de inicializacao de fluxo de caixa"
    @ 15,30 PROMPT "2.Venda"                MESSAGE "Emissao de cupom fiscal"
    @ 16,30 PROMPT "3.Finalizacao de dia"   MESSAGE "Operacao de termino de fluxo de caixa"
    @ 17,30 PROMPT "4.Autenticacao"         MESSAGE "Autenticacao de documento - Referencias ao cupom fiscal e ao cliente"
    @ 18,30 PROMPT "5.Leitura X"            MESSAGE "Comando de Leitura X - Relatorio de informacoes contidas na ECF"
    @ 19,30 PROMPT "6.Operacao nao fiscal"  MESSAGE "Exemplo de Operacao nao sujeita ao ICMS"
    @ 20,30 PROMPT "7.Impressao de cheque"  MESSAGE "Impressao de cheque"
    @ 21,30 PROMPT "8.Saida do Programa"    MESSAGE "Termino da execucao do programa exemplo"
    MENU TO menuChoice
RETURN (menuChoice)

//////////////////////////////////////////////////////////////////////////////
// ZanthusInicializaDriver-Abre Device Driver para comunicacao com a impressora
//                         Retorna handle do device driver para chamadas futuras
//                         Aborta programa se apos a inicializacao
/                          nao exista comunicacao com a impressora.
//
//            USADO POR -- Main
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
FUNCTION ZanthusInicializaDriver(Buffer)
    LOCAL nHandle, Qtde, Resposta
    nHandle := FOPEN("ECF$ZANT", FO_READWRITE)
    IF FERROR() != 0
        ? "Cannot open file, DOS error ", FERROR()
        BREAK
    ENDIF
    FWRITE(nHandle, "~1/0/", 5)     // Pedido de Versao da ECF Zanthus
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        ? "Erro = ["
        ?? Resposta
        ?? ",0,"
        ?? LEFT(Buffer, Qtde)
        ?? "]"
        BREAK
    ENDIF
RETURN (nHandle)

//////////////////////////////////////////////////////////////////////////////
// ZanthusTerminaDriver -- Fecha device driver de comunicao com impressora
//                         Necessita handle retornado na inicializacao em
//                          ZanthusInicializaDriver.
//
//            USADO POR -- Main
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
FUNCTION ZanthusTerminaDriver(nHandle)
    FCLOSE(nHandle)
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusBuscaInformacoesPreliminares
//                      -- Funcao que preenche a parte superior do programa
//                         com o estado atual da impressora (versoes, sensores,
//                         aliquotas, etc).
//
//            USADO POR -- Main
//                  USA -- HexToDec
//
// OBS:     1. Outras checagens sao possiveis como totalizadores, tempo de
//             operacao, etc. (Verifique no mapa da ECF Zanthus, quais
//             parametros que a impressora controla).
//
//          2. Dois controles sao muitos importantes para operacoes de venda
//             um e o numero de colunas (necessarios pois o registro de item
//             de venda e o total devem ter este exato tamanho) e o outro sao
//             as aliquotas de ICMS pois o registro de item de venda tributada
//             somente aceita estes valores.
//////////////////////////////////////////////////////////////////////////////
FUNCTION ZanthusBuscaInformacoesPreliminares(nHandle, Buffer)
    LOCAL tmpstr, cnt
    ///////////////////////////////////////////////
    //   APAGA INFORMACOES ANTERIORES
    ///////////////////////////////////////////////
    @  3, 15 SAY "__.__"     COLOR "RB+/B"
    @  3, 29 SAY "__"        COLOR "RB+/B"
    @  3, 44 SAY "__/__/__"  COLOR "RB+/B"
    @  3, 58 SAY "__:__:__"  COLOR "RB+/B"
    @  4, 15 SAY "__"        COLOR "RB+/B"
    @  4, 29 SAY "__"        COLOR "RB+/B"
    @  4, 44 SAY "__"        COLOR "RB+/B"
    @  4, 58 SAY "__"        COLOR "RB+/B"
    @  5, 15 SAY "___"       COLOR "RB+/B"
    @  5, 44 SAY "___"       COLOR "RB+/B"
    @  5, 70 SAY "___"       COLOR "RB+/B"
    @  6, 22 SAY "__.__ __.__ __.__ __.__ __.__"  COLOR "RB+/B"
    @  6, 67 SAY "___.___,__" COLOR "RB+/B"
    @  7, 22 SAY "__.__ __.__ __.__ __.__ __.__"  COLOR "RB+/B"
    @  8, 22 SAY "                                               " COLOR "RB+/B"
    @  9, 22 SAY "                                               " COLOR "RB+/B"
    ///////////////////////////////////////////////
    //   INFORMACOES GERAIS
    ///////////////////////////////////////////////
    FWRITE(nHandle, "~1/0/", 5)     // Pedido de Versao da ECF Zanthus
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) = "0")
        @  3,15 SAY SUBSTR(Buffer, 7, 2) + "." + SUBSTR(Buffer, 9, 2) COLOR "RB+/B"
        @  3,29 SAY SUBSTR(Buffer,11, 2)                              COLOR "RB+/B"
        @  4,15 SAY HexToDec(SUBSTR(Buffer,13,2)) PICTURE "99"        COLOR "RB+/B"
        nColunas = HexToDec(SUBSTR(Buffer, 13, 2))
        @  4,29 SAY SUBSTR(Buffer,15, 2)                              COLOR "RB+/B"
        @  4,44 SAY SUBSTR(Buffer,17, 2)                              COLOR "RB+/B"
        @  4,58 SAY SUBSTR(Buffer,19, 2)                              COLOR "RB+/B"
        IF (SUBSTR(Buffer, 21, 2) = "01" )
            @  5, 15 SAY "Sim" COLOR "RB+/B"
        ELSE
            @  5, 15 SAY "Nao" COLOR "RB+/B"
        ENDIF
        IF (SUBSTR(Buffer, 23, 2) = "01" .OR. SUBSTR(Buffer, 23, 2) = "03")
            @  5, 44 SAY "Sim" COLOR "RB+/B"
            flag_Cheque := 1
        ELSE
            @  5, 44 SAY "Nao" COLOR "RB+/B"
            flag_Cheque := 0
        ENDIF
        IF (SUBSTR(Buffer, 23, 2) = "02" .OR. SUBSTR(Buffer, 23, 2) = "03")
            @  5, 70 SAY "Sim" COLOR "RB+/B"
            flag_Aut := 1
        ELSE
            @  5, 70 SAY "Nao" COLOR "RB+/B"
            flag_Aut := 0
        ENDIF
    ENDIF
    ///////////////////////////////////////////////
    //  INFORMACAO DATA/HORA
    ///////////////////////////////////////////////
    Buffer = SPACE(F_BLOCK)
    FWRITE(nHandle, "~1/R/", 5)     // Leitura do Relogio/Calendario
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) = "0")
        @  3, 44 SAY SUBSTR(Buffer, 7, 2) COLOR "RB+/B"
        @  3, 47 SAY SUBSTR(Buffer, 9, 2) COLOR "RB+/B"
        @  3, 50 SAY SUBSTR(Buffer,13, 2) COLOR "RB+/B"
        @  3, 58 SAY SUBSTR(Buffer,15, 2) COLOR "RB+/B"
        @  3, 61 SAY SUBSTR(Buffer,17, 2) COLOR "RB+/B"
        @  3, 64 SAY SUBSTR(Buffer,19, 2) COLOR "RB+/B"
        ENDIF
    ///////////////////////////////////////////////
    //  INFORMACAO ALIQUOTAS ICMS
    ///////////////////////////////////////////////
    Buffer = SPACE(F_BLOCK)
    FWRITE(nHandle, "~5/1/$4,20$", 11)  // Leitura de 20 bytes no endereco
                                        // 0004, contendo as aliquotas ICMS
    FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) = "0")
        @  6,22 SAY SUBSTR(Buffer, 7, 2)  COLOR "RB+/B"
        @  6,25 SAY SUBSTR(Buffer, 9, 2)  COLOR "RB+/B"
        @  6,28 SAY SUBSTR(Buffer,11, 2)  COLOR "RB+/B"
        @  6,31 SAY SUBSTR(Buffer,13, 2)  COLOR "RB+/B"
        @  6,34 SAY SUBSTR(Buffer,15, 2)  COLOR "RB+/B"
        @  6,37 SAY SUBSTR(Buffer,17, 2)  COLOR "RB+/B"
        @  6,40 SAY SUBSTR(Buffer,19, 2)  COLOR "RB+/B"
        @  6,43 SAY SUBSTR(Buffer,21, 2)  COLOR "RB+/B"
        @  6,46 SAY SUBSTR(Buffer,23, 2)  COLOR "RB+/B"
        @  6,49 SAY SUBSTR(Buffer,25, 2)  COLOR "RB+/B"
        @  7,22 SAY SUBSTR(Buffer,27, 2)  COLOR "RB+/B"
        @  7,25 SAY SUBSTR(Buffer,29, 2)  COLOR "RB+/B"
        @  7,28 SAY SUBSTR(Buffer,31, 2)  COLOR "RB+/B"
        @  7,31 SAY SUBSTR(Buffer,33, 2)  COLOR "RB+/B"
        @  7,34 SAY SUBSTR(Buffer,35, 2)  COLOR "RB+/B"
        @  7,37 SAY SUBSTR(Buffer,37, 2)  COLOR "RB+/B"
        @  7,40 SAY SUBSTR(Buffer,39, 2)  COLOR "RB+/B"
        @  7,43 SAY SUBSTR(Buffer,41, 2)  COLOR "RB+/B"
        @  7,46 SAY SUBSTR(Buffer,43, 2)  COLOR "RB+/B"
        @  7,49 SAY SUBSTR(Buffer,45, 2)  COLOR "RB+/B"
    ENDIF
    ///////////////////////////////////////////////
    //  INFORMACAO ESTADO IMPRESSORA
    ///////////////////////////////////////////////
    FWRITE(nHandle, "~5/1/$220,1$", 12) // Leitura de 1 byte no endereco 0220
    FREAD(nHandle, @Buffer, F_BLOCK)     // contendo estado da ECF Zanthus.
    IF(SUBSTR(Buffer, 4, 1) = "0")
        CAR := SUBSTR(Buffer, 8, 1)
        DO CASE
        CASE CAR='1'
            @ 8,22 SAY "1 - Repouso com dia nao Iniciado.         " COLOR "RB+/B"
        CASE CAR='2'
            @ 8,22 SAY "2 - Repouso com dia ja Iniciado.          " COLOR "RB+/B"
        CASE CAR='3'
            @ 8,22 SAY "3 - Venda Iniciada.                       " COLOR "RB+/B"
            FWRITE(nHandle, "~5/1/$557,8$", 12) // Leitura de 1 byte no endereco 0220
            FREAD(nHandle, @Buffer, F_BLOCK)     // contendo estado da ECF Zanthus.
            IF(SUBSTR(Buffer, 4, 1) = "0")
                IF(SUBSTR(Buffer, 7, 8)!="00000000")
                    tmpstr:="XXX.XXX,XX"
                ELSE
                    tmpstr:=SUBSTR(Buffer, 15, 3) + "." + SUBSTR(Buffer, 18,3) + ;
                            "," + SUBSTR(Buffer, 21,2)
                    cnt := 1
                    DO WHILE SUBSTR(tmpstr, cnt, 1)="0" .OR. SUBSTR(tmpstr, cnt, 1)="."
                        tmpstr:=LEFT(tmpstr, cnt - 1) + " " + RIGHT(tmpstr, LEN(tmpstr) - cnt)
                        cnt++
                    ENDDO
                    IF SUBSTR(tmpstr,cnt,1)=","
                        tmpstr:=LEFT(tmpstr, cnt - 2) + "0" + RIGHT(tmpstr, LEN(tmpstr) - cnt + 1)
                    ENDIF
                ENDIF
                @  6, 67 SAY tmpstr COLOR "RB+/B"
            ENDIF
        CASE CAR='4'
            @ 8,22 SAY "4 - Operacao nao ICMS.                    " COLOR "RB+/B"
        CASE CAR='5'
            @ 8,22 SAY "5 - Operacao nao ICMS antes inicio do Dia." COLOR "RB+/B"
        CASE CAR='6'
            @ 8,22 SAY "6 - Venda Iniciada com total ja impresso. " COLOR "RB+/B"
        ENDCASE
    ENDIF
    ///////////////////////////////////////////////
    //  INFORMACAO SENSORES
    ///////////////////////////////////////////////
    FWRITE(nHandle, "~1/S/", 5)     // Leitura de sensores da impressora
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Buffer := SPACE(F_BLOCK)
    FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) = "0")
        IF (SUBSTR(Buffer, 8, 1) = "1" )
            tmpstr := "Gaveta Aberta, "
        ELSE
            tmpstr := "Gaveta fechada, "
        ENDIF
        IF (SUBSTR(Buffer, 10, 1) = "1" )
            tmpstr := tmpstr + "Sem papel, "
        ELSE
            tmpstr := tmpstr + "Com papel, "
        ENDIF
        IF (SUBSTR(Buffer, 12, 1) = "1" )
            tmpstr := tmpstr + "Sem Documento."
        ELSE
            tmpstr := tmpstr + "Com Documento."
        ENDIF
    @  9,22 SAY tmpstr COLOR "RB+/B"
    ENDIF
RETURN

//////////////////////////////////////////////////////////////////////////////
// HexToDec             -- Funcao utilizada para converter valor de numero de
//                         Colunas de BCD para decimal.
//
//            USADO POR -- ZanthusBuscaInformacoesPreliminares
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
FUNCTION HexToDec(Buffer)
    LOCAL value
    value := 0
    IF(LEN(Buffer)<>2)
        RETURN (0)
    ENDIF
    IF(SUBSTR(Buffer, 1, 1) == "A")
        value := 160
    ELSEIF(SUBSTR(Buffer, 1, 1) == "B")
        value := 176
    ELSEIF(SUBSTR(Buffer, 1, 1) == "C")
        value := 192
    ELSEIF(SUBSTR(Buffer, 1, 1) == "D")
        value := 208
    ELSEIF(SUBSTR(Buffer, 1, 1) == "E")
        value := 224
    ELSEIF(SUBSTR(Buffer, 1, 1) == "F")
        value := 240
    ELSE
        value := VAL(SUBSTR(Buffer, 1, 1)) * 16
    ENDIF
    IF(SUBSTR(Buffer, 2, 1) == "A")
        value := value + 10
    ELSEIF(SUBSTR(Buffer, 2, 1) == "B")
        value := value + 11
    ELSEIF(SUBSTR(Buffer, 2, 1) == "C")
        value := value + 12
    ELSEIF(SUBSTR(Buffer, 2, 1) == "D")
        value := value + 13
    ELSEIF(SUBSTR(Buffer, 2, 1) == "E")
        value := value + 14
    ELSEIF(SUBSTR(Buffer, 2, 1) == "F")
        value := value + 15
    ELSE
        value := value +  VAL(SUBSTR(Buffer, 2, 1))
    ENDIF
RETURN (value)

//////////////////////////////////////////////////////////////////////////////
//  ResponseToString    -- Programa Utilizado logo apos a uma execucao de
//                         Operacao na impressora para converter o codigo
//                         de retorno na sua descricao.
//
//            USADO POR -- ZanthusInicializaDriver
//                         ZanthusBeginDiaFiscal
//                         ZT_VD_Inicia
//                         ZT_VD_Item
//                         ZT_VD_Total
//                         ZT_VD_Termina
//                         ZT_VD_Cancela
//                         ZanthusEndDiaFiscal
//                         ZanthusAutenticacaoDocumento
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
FUNCTION ResponseToString(Answer)
    DO CASE
    CASE Answer = "0"
        Answer := "OK"
    CASE Answer = "1"
        Answer := "Comando nao pode ser executado"
    CASE Answer = "2"
        Answer := "Argumentos inconsistentes"
    CASE Answer = "3"
        Answer := "Comando nao executado porque valor passado e muito elevado"
    CASE Answer = "4"
        Answer := "Configuracao do modo fiscal nao permite execucao do comando"
    CASE Answer = "5"
        Answer := "Memoria fiscal esgotada"
    CASE Answer = "6"
        Answer := "Memoria fiscal ja inicializada"
    CASE Answer = "7"
        Answer := "Falha ao iniciar memoria fiscal"
    CASE Answer = "8"
        Answer := "Memoria Fiscal ja tem numero de serie"
    CASE Answer = "9"
        Answer := "Memoria Fiscal nao esta inicializada"
    CASE Answer = ":"
        Answer := "Falha ao gravar na memoria fiscal"
    CASE Answer = ";"
        Answer := "Papel no fim"
    CASE Answer = "<"
        Answer := "Falha na impressora"
    CASE Answer = "="
        Answer := "Memoria do modulo fiscal violada"
    CASE Answer = ">"
        Answer := "Falta memoria fiscal"
    CASE Answer = "?"
        Answer := "Comando inexistente"
    CASE Answer = "@"
        Answer := "Deve fazer reducao"
    CASE Answer = "A"
        Answer := "Memoria do modulo fiscal desprotegida (lacre rompido)"
    CASE Answer = "B"
        Answer := "Data nao permite operacao"
    CASE Answer = "C"
        Answer := "Fim de tabela (CGC/IE ou dias)"
    CASE Answer = "D"
        Answer := "Dados fixos do Modulo fiscal estao incosistentes"
    CASE Answer = "O"
        Answer := "Erro no byte de Verificacao"
    CASE Answer = "P"
        Answer := "Muitos argumentos Passados"
    CASE Answer = "Q"
        Answer := "Erro no numero de controle da mensagem"
    CASE Answer = "R"
        Answer := "Resposta invalida"
    CASE Answer = "S"
        Answer := "Ultrapassou o numero maximo de tentativas de comm"
    CASE Answer = "T"
        Answer := "Falha na transmissao de dados para impressora"
    CASE Answer = "U"
        Answer := "Timeout de resposta da impressora"
    CASE Answer = "V"
        Answer := "Comando nao reconhecido pela impressora"
    CASE Answer = "W"
        Answer := "Impressora desligada"
    CASE Answer = "X"
        Answer := "Erro na recepcao serial"
    CASE Answer = "Y"
        Answer := "Erro no protocolo"
    CASE Answer = "Z"
        Answer := "Erro de resposta perdida"
    CASE Answer = "["
        Answer := "Dados de retorno perdidos"
    CASE Answer = "b"
        Answer := "Parametros para Device Driver incompletos"
    OTHERWISE
        Answer := "COMANDO IRRECONHECIVEL"
    ENDCASE
RETURN (Answer)

//////////////////////////////////////////////////////////////////////////////
// ZanthusBeginDiaFiscal-- Programa de Inicalizacao de Dia Fiscal na
//                          impressora zanthus
//
//            USADO POR -- Main
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusBeginDiaFiscal(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    FWRITE(nHandle, "~1/1/", 5)     // Inicio do dia fiscal
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    @ 23,1 SAY SPACE(78)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",1,"
    ELSE
        str := "Operacao realizada = [OK,1,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusVendaProduto  -- Programa para emissao de cupom fiscal.
//                         Este programa nao manipula descontos sobre a venda
//                         de itens ou sobre subtotal.
//
//            USADO POR -- Main
//                  USA -- ZanthusBuscaInformacoesPreliminares
//                         ZT_VD_Cabecalho
//                         ZT_VD_Inicia
//                         ZT_VD_Item
//                         ZT_VD_Total
//                         ZT_VD_Termina
//                         ZT_VD_Cancela
//
// OBS:     1. Sugerimos que uma melhor manipulacao de checagem e necessario
//             antes de registro de items e cancelamento.
//             principalmente no retorno de uma venda apos queda de sistema.
//
//          2. Observe tambem que a impressao de total devera coincidir com
//             o total sendo calculado na ECF Zanthus.
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusVendaProduto(nHandle, Buffer)
    LOCAL Saida, Choice, TotalVenda, car, QtdeItems, tmpValor
    @  11, 1 CLEAR TO 21,78
    @  10, 0,12, 79 BOX B_SINGLE_DOUBLE
    @  10, 0 SAY "Ç"
    @  10,79 SAY "¶"
    @  12, 0 SAY "Ç"
    @  12,79 SAY "¶"
    @  11, 7 SAY "Cupom:"
    @  14, 7 SAY "Venda:  lapis     caneta    caderno   livro     lapiseira"
    @  15,15 SAY         "sulfite   regua     borracha  compasso  esquadro"
    @  17, 8 SAY  "Qtde:  1  2  3  4  5  6  7  8  9 10"
    @  19, 8 SAY  "Tipo:_________________    Aliquota:__.__    Preco unitario:___.___,__"
    @  21, 2 SAY  "Total Item:___.___,__      Qtde de Itens:___         Total Venda:___.___,__"
    SET WRAP ON
    Saida := 0
    TotalVenda := 0.00
    QtdeItems := 0
    car := 10
    DO WHILE (Saida=0)
        ZanthusBuscaInformacoesPreliminares(nHandle, BufferDriverZanthus)
        SET MESSAGE TO 23 CENTER
        @ 23,1 SAY SPACE(78)
        @  11, 15 PROMPT "Cabecalho" MESSAGE "Cabecalho fiscal"
        @  11, 25 PROMPT "Inicia"    MESSAGE "Inicializa o Cupom Fiscal"
        @  11, 32 PROMPT "Item"      MESSAGE "Venda de um Item"
        @  11, 37 PROMPT "EditaItem" MESSAGE "Edita um Item de venda"
        @  11, 47 PROMPT "Total"     MESSAGE "Totaliza o Cupom Fiscal"
        @  11, 53 PROMPT "Termina"   MESSAGE "Termina do Cupom Fiscal"
        @  11, 61 PROMPT "Cancela"   MESSAGE "Cancela o Cupom Fiscal"
        @  11, 69 PROMPT "Saida"     MESSAGE "Abandona o Cupom Fiscal"
        @  11, 75 PROMPT "LF"        MESSAGE "Avanca uma linha no Cupom Fiscal"
        MENU TO Choice
        DO CASE
        CASE Choice = 1
            ZT_VD_Cabecalho(nHandle, Buffer)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
            TotalVenda := 0.00
            QtdeItems  := 0
            @  21, 2 SAY  "Total Item:___.___,__      Qtde de Itens:___         Total Venda:___.___,__"
        CASE Choice = 2
            ZT_VD_Inicia(nHandle, Buffer)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
            TotalVenda := 0.00
            QtdeItems  := 0
            @  21, 2 SAY  "Total Item:___.___,__      Qtde de Itens:___         Total Venda:___.___,__"
        CASE Choice = 3
            tmpValor := TotalVenda
            @  11, 32 SAY "Item"
            TotalVenda := ZT_VD_Item(TotalVenda, nHandle, Buffer)
            IF (TotalVenda != tmpValor)
                QtdeItems++
                @ 21,43 SAY QtdeItems PICTURE "999"
                @ 21,67 SAY TotalVenda PICTURE "999,999.99"
                 car := 11
                 DO WHILE car != K_ESC .AND. car!=K_ENTER
                     car := INKEY()
                 ENDDO
            ENDIF
            @  19, 8 SAY  "Tipo:_________________    Aliquota:__.__    Preco unitario:___.___,__"
            @  21, 2 SAY  "Total Item:___.___,__ "
        CASE Choice = 4
            tmpValor := TotalVenda
            @  11, 37 SAY "EditaItem"
            TotalVenda := ZT_VD_EditaItem(TotalVenda, nHandle, Buffer)
            IF (TotalVenda != tmpValor)
                QtdeItems++
                @ 21,43 SAY QtdeItems PICTURE "999"
                @ 21,67 SAY TotalVenda PICTURE "999,999.99"
                 car := 11
                 DO WHILE car != K_ESC .AND. car!=K_ENTER
                     car := INKEY()
                 ENDDO
            ENDIF
            @  19, 8 SAY  "Tipo:_________________    Aliquota:__.__    Preco unitario:___.___,__"
            @  21, 2 SAY  "Total Item:___.___,__ "
        CASE Choice = 5
            ZT_VD_Total(nHandle, Buffer, TotalVenda)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE Choice = 6
            ZT_VD_Termina(nHandle, Buffer)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE Choice = 7
            ZT_VD_Cancela(nHandle, Buffer)
            car := 11
            DO WHILE car != K_ESC .AND. car!=K_ENTER
                car := INKEY()
            ENDDO
        CASE Choice = 8
            Saida = 1
        CASE Choice = 9
            ZT_VD_LF(nHandle, Buffer)
        OTHERWISE
            Saida = 1
        ENDCASE
    ENDDO
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Cabecalho      -- Opcao de Inicio de Cupom Fiscal
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Cabecalho(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    FWRITE(nHandle, "~1/6/", 5)     // Impressao de Cabecalho
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    @ 23,1 SAY SPACE(78)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",8,"
    ELSE
        str := "Operacao realizada = [OK,8,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Inicia         -- Opcao de Inicio de Cupom Fiscal
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Inicia(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    FWRITE(nHandle, "~1/8/", 5)     // Inicio do Cupom Fiscal
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    @ 23,1 SAY SPACE(78)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",8,"
    ELSE
        str := "Operacao realizada = [OK,8,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Item           -- Emite um Registro de Item de Cupom Fiscal.
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//                         ValueToStr
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Item(TotalVenda, nHandle, Buffer)
    LOCAL Choice2, Choice3, Tipo, Aliquota, Valor, cnt
    LOCAL Descricao
    LOCAL str, str1, str2
    SET MESSAGE TO 19
    @ 23, 1 SAY SPACE(78)
    @ 23,22 SAY "<<< Escolha um item para compra >>>"
    @ 19, 8 SAY "Tipo:_________________    Aliquota:__.__    Preco unitario:___.___,__"
    @ 21,2 SAY "Total Item:___.___,__"
    @ 14,15 PROMPT "lapis    " MESSAGE "º       Tipo:T - Tributada        Aliquota:18.00    Preco Unitario:      1,00"
    @ 14,25 PROMPT "caneta   " MESSAGE "º       Tipo:T - Tributada        Aliquota:18.00    Preco Unitario:      2,00"
    @ 14,35 PROMPT "caderno  " MESSAGE "º       Tipo:T - Tributada        Aliquota:18.00    Preco Unitario:      3,00"
    @ 14,45 PROMPT "livro    " MESSAGE "º       Tipo:N - Nao Incidencia   Aliquota:         Preco Unitario:      4,00"
    @ 14,55 PROMPT "lapiseira" MESSAGE "º       Tipo:T - Tributada        Aliquota:18.00    Preco Unitario:      5,00"
    @ 15,15 PROMPT "sulfite  " MESSAGE "º       Tipo:T - Tributada        Aliquota:18.00    Preco Unitario:     10,00"
    @ 15,25 PROMPT "regua    " MESSAGE "º       Tipo:I - Isento           Aliquota:         Preco Unitario:     20,00"
    @ 15,35 PROMPT "borracha " MESSAGE "º       Tipo:I - Isento           Aliquota:         Preco Unitario:     30,00"
    @ 15,45 PROMPT "compasso " MESSAGE "º       Tipo:I - Isento           Aliquota:         Preco Unitario:     40,00"
    @ 15,55 PROMPT "esquadro " MESSAGE "º       Tipo:I - Isento           Aliquota:         Preco Unitario:    100,00"
    MENU TO Choice2
    @  14, 7 SAY "Venda:  lapis     caneta    caderno   livro     lapiseira"
    @  15,15 SAY         "sulfite   regua     borracha  compasso  esquadro"
    Tipo     := 'X'
    Aliquota := 0.00
    Valor    := 0.00
    DO CASE
    CASE Choice2=1
        Tipo     := " T "
        Aliquota := 17.00
        Valor    := 1.00
        Descricao:= "Lapis     T17.00%          "
    CASE Choice2=2
        Tipo     := " T "
        Aliquota := 17.00
        Valor    := 2.00
        Descricao:= "Caneta    T17.00%          "
    CASE Choice2=3
        Tipo     := " T "
        Aliquota := 18.00
        Valor    := 3.00
        Descricao:= "Caderno   T18.00%          "
    CASE Choice2=4
        Tipo     := " N "
        Aliquota := 18.00
        Valor    := 4.00
        Descricao:= "Livro                      "
    CASE Choice2=5
        Tipo     := " T "
        Aliquota := 18.00
        Valor    := 5.00
        Descricao:= "Lapiseira T18.00%          "
    CASE Choice2=6
        Tipo     := " T "
        Aliquota := 18.00
        Valor    := 10.00
        Descricao:= "Sulfite   T18.00%          "
    CASE Choice2=7
        Tipo     := " I "
        Aliquota := 0.00
        Valor    := 20.00
        Descricao:= "Regua                      "
    CASE Choice2=8
        Tipo     := " I "
        Aliquota := 0.00
        Valor    := 30.00
        Descricao:= "Borracha                   "
    CASE Choice2=9
        Tipo     := " I "
        Aliquota := 0.00
        Valor    := 40.00
        Descricao:= "Compasso                   "
    CASE Choice2=10
        Tipo     := " I "
        Aliquota := 0.00
        Valor    := 100.00
        Descricao:= "Esquadro                   "
    ENDCASE
    IF(nColunas!=44)                     // 38, 42, 44
        Descricao:=LEFT(Descricao, 27 - 44 + nColunas)
    ENDIF
    IF(Tipo!='X')
        @ 23, 1 SAY SPACE(78)
        @ 23,21 SAY "<<< Escolha a quantidade de itens >>>"
        SET MESSAGE TO 21
        FOR cnt := 1 TO 10
            str1 := STR(cnt, 3)
            str2 := "º Total Item:"
            str2 += STR(Valor*cnt, 10, 2)
            @ 17,10+CNT*3 PROMPT str1 MESSAGE str2
        NEXT
        MENU TO Choice3
        @  17, 8 SAY  "Qtde:  1  2  3  4  5  6  7  8  9 10"
        IF Choice3 >= 1 .AND. Choice3 <= 10
            str1 := ValueToStr(Valor*Choice3)
            str  := "~2/;/$" + Descricao + str1 + Tipo +"$" // Registro de item
            FWRITE(nHandle, @str, LEN(str))   // de cupom fiscal -> 44 colunas
            FREAD(nHandle, @Buffer, F_BLOCK)
            FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
            Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
            IF(SUBSTR(Buffer, 4, 1) <> "0")
					 Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
                str := "Erro = ["
                str += Resposta
                str += ",;,"
            ELSE
                str := "Operacao realizada = [OK,;,"
            ENDIF
            str += LEFT(Buffer, Qtde)
            str += "]"
            @ 23, (80 - LEN(str))/2 SAY str
            IF(SUBSTR(Buffer, 4, 1) <> "0")
                RETURN (TotalVenda)
            ELSE
                RETURN (TotalVenda + Valor*Choice3)
            ENDIF
        ENDIF
    ENDIF
RETURN (TotalVenda)

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_EditaItem      -- Emite um Registro de Item de Cupom Fiscal.
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//                         ValueToStr
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_EditaItem(TotalVenda, nHandle, Buffer)
    LOCAL str, str1, str2, car, valor
    str  := SPACE(nColunas)
    str1 := RIGHT("dddddddddddddddddddddddddddddddddddvvv.vvv.vvv,vv t ", nColunas)
    str2 := RIGHT("XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX999.999.999,99 A ", nColunas)
    @ 22,18 SAY str1 COLOR "RG+/B"
    @ 23, 7 SAY "EditaItem:" GET str PICTURE str2
    READ
    @  0,50 SAY "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
    IF(SUBSTR(str, LEN(str) - 14, 1) = " ")
        str := LEFT(str, LEN(str) - 14) + " " + RIGHT(str, 13)
    ENDIF
    IF(SUBSTR(str, LEN(str) - 10, 1) = " ")
        str := LEFT(str, LEN(str) - 10) + " " + RIGHT(str, 9)
    ENDIF
    SET MESSAGE TO 19
    @ 23, 1 SAY SPACE(78)
    @ 23,17 SAY "[" + str + "]"
    str1 := SUBSTR(str, LEN(str)-16, 14)
    str1 := SUBSTR(str1, 1, 3) + SUBSTR(str1, 5, 3) + SUBSTR(str1, 9, 3) + "." + SUBSTR(str1, 13, 2)
    Valor := VAL(str1)
    str  := "~2/;/$" + str +"$" // Registro de item
    @ 22,18 SAY "ÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ"
    @ 23, 1 SAY SPACE(78)
    @ 23, 5 SAY "[" + str + "],[" + STR(Valor) + "]"
    FWRITE(nHandle, @str, LEN(str))   // de cupom fiscal -> 44 colunas
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",;,"
    ELSE
        str := "Operacao realizada = [OK,;,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, 1 SAY SPACE(78)
    @ 23, (80 - LEN(str))/2 SAY str
    IF(SUBSTR(Buffer, 4, 1) <> "0")
        RETURN (TotalVenda)
    ELSE
        RETURN (TotalVenda + Valor)
    ENDIF
RETURN (TotalVenda)

//////////////////////////////////////////////////////////////////////////////
// ValueToStr           -- Programa para formatacao de valor para formato
//                         Aceito pela impressora zanthus.
//
//            USADO POR -- ZT_VD_Item
//                         ZT_VD_Total
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
FUNCTION ValueToStr(value)
    LOCAL str
    str:=STR(value,14,2)
    str:=LEFT(str,11)+","+RIGHT(str,2)
    IF (SUBSTR(str,8,1)!=" ")
       str:=LEFT(str,8)+"."+RIGHT(str,6)
       str:=RIGHT(str,14)
    ENDIF
    IF (SUBSTR(str,4,1)!=" ")
       str:=LEFT(str,4)+"."+RIGHT(str,10)
       str:=RIGHT(str,14)
    ENDIF
RETURN(str)

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Total          -- Emite Total de Cupom Fiscal
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//                         ValueToStr
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Total(nHandle, Buffer, Total)
    LOCAL Qtde, Resposta, str
    LOCAL str1
    str1 := ValueToStr(Total)
    str  := "~2/O/$                           "
    IF(nColunas!=44)                     // 38, 42, 44
        str:=LEFT(str, 33 - 44 + nColunas)
    ENDIF
    str  := str + str1 +"   $"
    FWRITE(nHandle, str, LEN(str))   // Registro de total em cupom fiscal
    FREAD(nHandle, @Buffer, F_BLOCK) // 44 colunas. a palavra Total sera
                                    // colocada automaticamente.
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    @ 23,1 SAY SPACE(78)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",O,"
    ELSE
        str := "Operacao realizada = [OK,O,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Termina        -- Finaliza edicao de cupom Fiscal.
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Termina(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    FWRITE(nHandle, "~1/9/", 5)     // Encerramento de cupom fiscal
    FREAD(nHandle, @Buffer, F_BLOCK)
    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    @ 23,1 SAY SPACE(78)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",9,"
    ELSE
        str := "Operacao realizada = [OK,9,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
    IF(SUBSTR(Buffer, 4, 1) = "0")
        FWRITE(nHandle, "~2/U/$00$", 9)
        FREAD(nHandle, @Buffer, F_BLOCK)
        FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
        Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
        @ 23,1 SAY SPACE(78)
        IF(SUBSTR(Buffer, 4, 1) <> "0")
				Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
            str := "Erro = ["
            str += Resposta
            str += ",U,"
        ELSE
            str := "Operacao realizada = [OK,U,"
        ENDIF
        str += LEFT(Buffer, Qtde)
        str += "]"
        @ 23, (80 - LEN(str))/2 SAY str
    ENDIF
RETURN
// dddddddddddddddddddddddddddvvv.vvv.vvv,vv t "
// d - descricao
// v - valor
// t - tipo
//////////////////////////////////////////////////////////////////////////////
// ZT_VD_Cancela        -- Cancelamento de Cupom Fiscal
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_Cancela(nHandle, Buffer)
     LOCAL Qtde, Resposta, str
     FWRITE(nHandle, "~1/:/", 5)     // Cancela cupom fiscal.
	 FREAD(nHandle, @Buffer, F_BLOCK)
     FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
	 Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
	 @ 23,1 SAY SPACE(78)
	 IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",:,"
    ELSE
        str := "Operacao realizada = [OK,:,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
    IF(SUBSTR(Buffer, 4, 1) = "0")
        FWRITE(nHandle, "~2/U/$00$", 9)
        FREAD(nHandle, @Buffer, F_BLOCK)
        FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
        Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
        @ 23,1 SAY SPACE(78)
        IF(SUBSTR(Buffer, 4, 1) <> "0")
				Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
            str := "Erro = ["
            str += Resposta
            str += ",U,"
        ELSE
            str := "Operacao realizada = [OK,U,"
        ENDIF
        str += LEFT(Buffer, Qtde)
        str += "]"
        @ 23, (80 - LEN(str))/2 SAY str
    ENDIF
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZT_VD_LF             -- Avanca uma linha no  Cupom Fiscal
//
//            USADO POR -- ZanthusVendaProduto
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZT_VD_LF(nHandle, Buffer)
     LOCAL Qtde, Resposta, str
     FWRITE(nHandle, "~2/U/$01$", 9)
     FREAD(nHandle, @Buffer, F_BLOCK)
     FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
     Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
     @ 23,1 SAY SPACE(78)
     IF(SUBSTR(Buffer, 4, 1) <> "0")
             Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
         str := "Erro = ["
         str += Resposta
         str += ",U,"
     ELSE
         str := "Operacao realizada = [OK,U,"
     ENDIF
     str += LEFT(Buffer, Qtde)
     str += "]"
     @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusEndDiaFiscal  -- Finaliza Dia Fiscal - Reducao Z
//
//            USADO POR -- Main
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusEndDiaFiscal(nHandle, Buffer)
     LOCAL Qtde, Resposta, str
     FWRITE(nHandle, "~1/4/", 5)     // Termino de dia Fiscal Reducao Z
	 FREAD(nHandle, @Buffer, F_BLOCK)
     FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
	 Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
	 IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",4,"
    ELSE
        str := "Operacao realizada = [OK,4,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
	 @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusAutenticacaoDocumento
//                      -- Exemplo de autenticacao de documento.
//                         No caso: Impressao do ultimo numero de cupom fiscal
//                         Mais uma numero de documento qualquer:Ex. RG ou CIC
//
//            USADO POR -- Main
//                  USA -- ResponseToString
//                  USA -- HexToDec
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusAutenticacaoDocumento(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    LOCAL car, strdoc
    LOCAL str1, str2
    LOCAL linha, coluna, i
    @ 23, 1 SAY SPACE(78)
    strdoc := SPACE(20)
    CLEAR GETS
    @ 23, 12 SAY "Digite Documento (RG/CIC):" GET strdoc PICTURE "XXXXXXXXXXXXXXXXXXXX"
    READ
    @ 0,50 SAY "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
    car := 11
    @ 23, 1 SAY SPACE(78)
    @ 23, 9 SAY "<<< Coloque o documento na impressora e pressione <ENTER> >>>"
    DO WHILE car != K_ESC .AND. car!=K_ENTER
        car := INKEY()
        IF(car==K_ENTER)
            //////////////////////////////////////
            //  Verifica presenca de documento
            //////////////////////////////////////
            FWRITE(nHandle, "~1/S/", 5)     // Leitura de Sensores da impressora
            FREAD(nHandle, @Buffer, F_BLOCK)
            FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
            Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
            @ 23, 1 SAY SPACE(78)
            IF(SUBSTR(Buffer, 4, 1) <> "0")
                // PROBLEMAS NO COMANDO DE VERIFICACAO DE SENSORES
					 Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
                str := "Erro = ["
                str += Resposta
                str += ",4,"
                str += LEFT(Buffer, Qtde)
                str += "]"
                @ 23, (80 - LEN(str))/2 SAY str
            ELSE
                IF (SUBSTR(Buffer, 12, 1) = "1"  .AND. flag_Aut = 0)
						  // SEM DOCUMENTO
                    @ 23, 15 SAY "<<< SEM DOCUMENTO ... TENTE NOVAMENTE <ENTER> >>>"
                    car := 11
                ELSE // COM DOCUMENTO
                    str2 := SPACE(20)
                    FWRITE(nHandle, "~5/1/$224,3$", 12) // Leitura de 3 bytes
                    FREAD(nHandle, @Buffer, F_BLOCK)     // End 224 ultimo
                                                         // cupom impresso.
                    IF(SUBSTR(Buffer, 4, 1) = "0")  // Impressao de 1 linha
                        str2 := SUBSTR(Buffer,7,6)  // na impressora.
                    ENDIF
                    @ 23, 1 SAY SPACE(78)
                    @ 23,30 SAY "<<< Autenticando >>>"
                    IF(flag_Aut = 1)
                        str := "~2/`/$0000000000001$"
                        FWRITE(nHandle, str, LEN(str))
                        FREAD(nHandle, @Buffer, F_BLOCK)
                        FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
                        Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
                        linha  = HexToDec(SUBSTR(Buffer, 7, 2))
                        Coluna = HexToDec(SUBSTR(Buffer, 9, 2))
                        FOR i := 1 TO linha
                            str1 := TRANSFORM(Coluna*(i-1), "9999")
                            IF(LEFT(str1,3) = "   ")
                                str1:="000" + RIGHT(str1,1)
                            ELSEIF(LEFT(str1,2)="  ")
                                str1:="00"  + RIGHT(str1,2)
                            ELSEIF(LEFT(str1,1)=" ")
                                str1:="0"  + RIGHT(str1,3)
                            ENDIF
                            str := "~2/a/$" + str1 + SPACE((i-1)) + "CUPON:" + str2 + " - " + strdoc + "$"
                            FWRITE(nHandle, str, LEN(str))
                            FREAD(nHandle, @Buffer, F_BLOCK)
                        NEXT
                        str := "~1/b/"      // Impressao do Avulso Armazenado
                    ELSE
                        str := "~2/!/$CUPON:" + str2 + " - " + strdoc + "$"
                    ENDIF
                    FWRITE(nHandle, str, LEN(str))
                    FREAD(nHandle, @Buffer, F_BLOCK)
                    FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
                    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
                    IF(SUBSTR(Buffer, 4, 1) <> "0")
								Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
                        str := "Erro = ["
                        str += Resposta
                        str += ",4,"
                    ELSE
                        str := "Operacao realizada = [OK,4,"
                    ENDIF
                    str += LEFT(Buffer, Qtde)
                    str += "]"
                    @ 23, (80 - LEN(str))/2 SAY str
                ENDIF
            ENDIF
        ENDIF
    ENDDO
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusImpressaoCheque
//                      -- < Aguardando Implementacao..>
//
//            USADO POR -- Main
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusImpressaoCheque(nHandle, Buffer)
     LOCAL Qtde, Resposta, str
     @  11, 1 CLEAR TO 21,78
     Nome   = SPACE(40)
     Cidade = SPACE(20)
     Data   = SPACE(8)
     Banco  = SPACE(3)
     Valor  = SPACE(14)
     @  12, 17 SAY   "NOME:"  GET Nome    PICTURE "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
     @  13, 15 SAY "CIDADE:"  GET Cidade  PICTURE "XXXXXXXXXXXXXXXXXXX"
     @  14, 17 SAY   "DATA:"  GET Data    PICTURE "99/99/99"
     @  15, 16 SAY  "BANCO:"  GET Banco   PICTURE "999"
     @  16, 16 SAY  "VALOR:"  GET Valor   PICTURE "999,999,999.99"
     READ
     @ 0,50 SAY "ÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ"
     Data  := LEFT(Data,2) + SUBSTR(Data, 4, 2) + RIGHT(Data, 2)
     Valor := SUBSTR(Valor,1,3)+SUBSTR(Valor,5,3)+SUBSTR(Valor,9,3)+SUBSTR(Valor,13,2)
     Valor := LTRIM(Valor)
     tmpstr := "~7/$|" + RTRIM(Nome) + "|" + RTRIM(Cidade) + "|" + RTRIM(Data) + "|" + RTRIM(Banco) + "|" + RTRIM(Valor) +"|$"
     IF(LEN(RTRIM(Valor))=0)
        str := "Operacao Abortada"
        @ 23, 1 SAY SPACE(78)
        @ 23, (80 - LEN(str))/2 SAY str
        RETURN
     ENDIF
     @ 18,5 SAY "[" + tmpstr + "]"
     FWRITE(nHandle, tmpstr, LEN(tmpstr))
     FREAD(nHandle, @Buffer, F_BLOCK)
     FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
     Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
     IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",3,"
    ELSE
        str := "Operacao realizada = [OK,3,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
	 @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusLeituraX      -- Executa uma leitura X dos dados da ECF Zanthus
//
//            USADO POR -- Main
//                  USA -- ResponseToString
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusLeituraX(nHandle, Buffer)
     LOCAL Qtde, Resposta, str
     FWRITE(nHandle, "~1/3/", 5)     // Leitura X
	 FREAD(nHandle, @Buffer, F_BLOCK)
     FWRITE(nHandle, "~6/", 3)       // Retorno em ASCII da ultima resposta.
	 Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
	 IF(SUBSTR(Buffer, 4, 1) <> "0")
		  Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
        str := "Erro = ["
        str += Resposta
        str += ",3,"
    ELSE
        str := "Operacao realizada = [OK,3,"
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

//////////////////////////////////////////////////////////////////////////////
// ZanthusNaoSujeitaICMS
//                      -- < Aguardando Implementacao..>
//
//            USADO POR -- Main
//                  USA -- <>
//////////////////////////////////////////////////////////////////////////////
PROCEDURE ZanthusNaoSujeitaICMS(nHandle, Buffer)
    LOCAL Qtde, Resposta, str
    FWRITE(nHandle, "~1/7/", 5)     // Inicio de Operacao nao sujeita ao ICMS
    Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
    IF(SUBSTR(Buffer, 4, 1) <> "0")
         Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
         str := "Erro = ["
         str += Resposta
         str += ",7,"
    ELSE
         FWRITE(nHandle,"~2/!/$********************************$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$* Operacao Nao Sujeita ao ICMS *$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$********************************$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$* Util para retirada de relato-*$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$* rios de vendedores, caixa,   *$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$* sangria, etc..)              *$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle,"~2/!/$********************************$", 39)
         FREAD(nHandle, @Buffer, F_BLOCK)
         FWRITE(nHandle, "~1/?/", 5)     // Fim de Operacao nao sujeita ao ICMS
         Qtde := FREAD(nHandle, @Buffer, F_BLOCK)
         IF(SUBSTR(Buffer, 4, 1) <> "0")
             Resposta = ResponseToString(SUBSTR(Buffer, 4, 1))
             str := "Erro = ["
             str += Resposta
             str += ",?,"
         ELSE
             str := "Operacao realizada = [OK,?,"
         ENDIF
    ENDIF
    str += LEFT(Buffer, Qtde)
    str += "]"
    @ 23, (80 - LEN(str))/2 SAY str
RETURN

*
