//{IX} ================================================================================

//{IX} 000010 = User Function ml_680v

//{IX} 000104 = Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

//{IX} ================================================================================  

 

#INCLUDE "rwmake.ch"

#INCLUDE "PROTHEUS.CH"

#INCLUDE "TOPCONN.CH"

 

 

User Function ml_680v

 

   //declara variaveis

   Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "

   Local cDesc2         := "de acordo com os parametros informados pelo usuario."

   Local cDesc3         := "PEDIDOS"

   Local cPict          := ""

   Local titulo       := "PEDIDOS"

   Local nLin         := 80

   Local Cabec1       :=  "Numero              CodCli       Loja          Emissao                        Nome Transport                                               Nome do cliente"   

   Local Cabec2       := "                                   Cod.Produto              Descricao"

   Local imprime      := .T.

   Local aOrd := {}

   Private lEnd         := .F.

   Private lAbortPrint  := .F.

   Private CbTxt        := ""

   Private limite           := 132

   Private tamanho          := "M"

   Private nomeprog         := "RELPEDIDOS" // Coloque aqui o nome do programa para impressao no cabecalho

   Private nTipo            := 18

   Private aReturn          := { "Zebrado", 1, "Administracao", 2, 2, 1, "", 1}

   Private nLastKey        := 0

   Private cbtxt      := Space(10)

   Private cbcont     := 00

   Private CONTFL     := 01

   Private m_pag      := 01

   Private wnrel      := "1234567891" // Coloque aqui o nome do arquivo usado para impressao em disco

 

   Private cString := ""

   //perguntes

   Private cPerg:= "1234567891"

   Private aPerg:={}

   //              1      2                3         4     5        6        7           8    9        0          1       2       3

   //..   Grupo    Ordem, Pergunt        , Variavl , Tipo, Tamanho,  Decimal, Var01     , GSC, F3      ,valid    , presel, def01 , def02   .....

   aAdd( aPerg , { "01", "Nome Cliente De", "mv_ch1", "C" ,  10     , 0      , "MV_PAR01", "G", ""   ,""       , 0     , ""    , ""      })   // normal caractere com F3

   aAdd( aPerg , { "02", "Nome ate Cliente ", "mv_ch2", "C" ,  10    , 0      , "MV_PAR02", "G", ""   ,""       , 0     , ""    , ""      })   // normal data

   //aAdd( aPerg , { "03" , "Peso ou Vlr ?", "mv_ch3", "C" ,  1     , 0      , "MV_PAR03", "C", ""      ,""       , 1     , "Peso", "Valor" })   // combo com 2 opções (pode ter até 5)

   // MANEIRAS DE SELECIONAR ARQUIVOS

   //aAdd( aPerg , { "04" , "ARQCSV no F3.", "mv_ch4", "C" ,  99    , 0      , "MV_PAR04", "G", "ARQCSV", ""      , 0     , ""    , ""      })   // normal caractere com pesquisa diretorio

   //aAdd( aPerg , { "04" , "DIR no F3    ", "mv_ch4", "C" ,  99    , 0      , "MV_PAR04", "G", "DIR"   , ""      , 0     , ""    , ""      })   // normal caractere com pesquisa diretorio

   //aAdd( aPerg , { "04" , "fDir no VALID", "mv_ch4", "C" ,  99    , 0      , "MV_PAR04", "G", ""      , "FDIR()", 0     , ""    , ""      })   // normal caractere com pesquisa diretorio

   //aAdd( aPerg , { "04" , "F no GSC     ", "mv_ch4", "C" ,  99    , 0      , "MV_PAR04", "F", ""      , ""      , 0     , ""    , ""      })   // normal caractere com pesquisa diretorio

 

   DbSelectArea("SX1")

   DbSetOrder(1)

   For nn := 1 to Len( aPerg )

      If !DbSeek(cPerg + aPerg[nn,1] )

         RecLock("SX1",.t.)

         SX1->X1_GRUPO   := cPerg

         SX1->X1_ORDEM   := aPerg[nn,01]

         SX1->X1_PERGUNT := aPerg[nn,02]

         SX1->X1_VARIAVL := aPerg[nn,03]

         SX1->X1_TIPO    := aPerg[nn,04]

         SX1->X1_TAMANHO := aPerg[nn,05]

         SX1->X1_DECIMAL := aPerg[nn,06]

         SX1->X1_VAR01   := aPerg[nn,07]

         SX1->X1_GSC     := aPerg[nn,08]

         SX1->X1_F3      := APERG[nn,09]

         SX1->X1_VALID   := APERG[nn,10]

         SX1->X1_PRESEL  := APERG[nn,11]

         SX1->X1_DEF01   := APERG[nn,12]

         SX1->X1_DEF02   := APERG[nn,13]

         MsUnlock()

      ENDIF

   NEXT

   If !Pergunte(cPerg,.T.,"Titulo")

      Return

   Endif

 

 

 

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿

   //³ Monta a interface padrao com o usuario...                           ³

   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

 

   wnrel := SetPrint(cString,NomeProg,"",@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

   If nLastKey == 27

      Return

   Endif

 

   SetDefault(aReturn,cString)

 

   If nLastKey == 27

      Return

   Endif

 

   nTipo := If(aReturn[4]==1,15,18)

 

   //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿

   //³ Processamento. RPTSTATUS monta janela com a regua de processamento. ³

   //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

   RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return

 

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)

 

   Local nOrdem

 

   SetRegua(RecCount())

   //query 

      

Query := "SELECT C5.C5_NUM, C5.C5_FILIAL,C5.C5_CLIENTE, C5.C5_TRANSP,  " //selecionando dados da tabela sc5

Query += "       C5.C5_LOJACLI,C5.C5_EMISSAO, C6.C6_PRODUTO, " // campos da tabela sc5

Query += "       A1.A1_NOME, A4.A4_NOME " // da tabela a4

Query += " FROM " + RetSqlName("SC5") + " C5, " + RetSqlName("SA1") + " A1, " + RetSqlName("SC6") + " C6, " // RetSqlName =

Query += RetSqlName("SA4") + " A4 "

Query += " WHERE A4.D_E_L_E_T_ = ' ' "

Query += "   AND A4.A4_COD = C5.C5_TRANSP "

Query += "   AND A4.A4_FILIAL = '" +xFilial("SA4") + "' "

 

Query += "   AND A1.D_E_L_E_T_ = ' ' "

Query += "   AND A1.A1_LOJA = C5.C5_LOJACLI "

Query += "   AND A1.A1_COD = C5.C5_CLIENTE "

Query += "   AND A1.A1_FILIAL = '" + xFilial("SA1") + "' "

 

Query += "   AND C6.C6_NUM = C5.C5_NUM "

Query += "   AND C6.C6_FILIAL = '" + xFilial("SC5") + "' "

Query += "   AND C6.D_E_L_E_T_ = ' ' "

 

Query += "   AND C5.C5_LIBEROK != 'S' "

Query += "   AND C5.D_E_L_E_T_ = ' ' "

//cQry += "   AND C5.C5_NUM = '" + Alltrim(cPedido) + "' "

Query += "   AND C5.C5_FILIAL = '" + xFilial("SC5") + "' "    

 

//MemoWrite("testeqry.sql",cQry)

TCQuery Query NEW ALIAS "TMP"

DbSelectArea("TMP")

  

   dbGoTop()

  

   While !EOF()

    

      If lAbortPrint

         @nLin,00 PSAY "*** CANCELADO PELO OPERADOR ***"

         Exit

      Endif

      //ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿

      //³ Impressao do cabecalho do relatorio. . .                            ³

      //ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

      If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...

         Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)

         nLin := 9

      Endif                         

      

//          1         2         3         4         5         6         7         8         9         0         1         2

//01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789

//Numero              CodCli       Loja          Emissao                        Nome Transport                                               Nome do cliente

//        Cod.Produto                                       Descricao

//123456  123456 12   88/88/8888   01234567890123456789012345678901234567890123456789

//        12345678901234567891234  01234567890123456789012345678901234567890123456789

//C5_NUM

//C5_CLIENTE

//C5_LOJACLI

//C5_EMISSAO

//A1_NOME

 

 

 

      @nLin,20 PSAY TMP->C5_CLIENTE

      @nLin,00 PSAY TMP->C5_NUM

      @nLin,33 PSAY TMP->C5_LOJACLI

      @nLin,77 PSAY TMP->A4_NOME //Nome transportadora

                  @nLin,47 PSAY TMP->C5_EMISSAO      

      @nLin,129 PSAY TMP->A1_NOME

      @nLin,08 PSAY TMP->C6_PRODUTO

      //@nLin,45 PSAY posicione("SB1",1, filialsb1+TMP->C6_PRODUTO, "B1_DESC") //consultando em uma outra tabela (tabela de produtos)

      // @nLin ,35 PSAY B1->B1_DESC

      nLin := nLin + 1 // Avanca a linha de impressao

      tmp->(dbskip())

   enddo

 

   nLin := nLin + 1 // Avanca a linha de impressao

 

   SET DEVICE TO SCREEN

 

 

  If aReturn[5]==1

      dbCommitAll()

      SET PRINTER TO

      OurSpool(wnrel)

   Endif

 

 

 

   MS_FLUSH()

Return