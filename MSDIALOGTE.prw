//{IX} ================================================================================
//{IX} 000025 = User Function MSDIALOGTE()
//{IX} 000115 = Static Function pesquisar(cOper,cdoc, cser,ccli)
//{IX} 000290 = Static function atualizar()
//{IX} 000295 = Static function atlztela1()
//{IX} 000310 = Static Function atlztela2()
//{IX} 000325 = Static Function MHoBrw1()
//{IX} 000374 = Static Function MCoBrw1()
//{IX} 000384 = Static Function MHoBrw2()
//{IX} 000440 = Static Function MCoBrw2()
//{IX} 000452 = Static Function MHoBrw3()
//{IX} 000476 = Static Function MCoBrw3()
//{IX} 000488 = Static Function MHoBrw4()
//{IX} 000512 = Static Function MCoBrw4()
//{IX} 000524 = Static Function MHoBrw5()
//{IX} 000548 = Static Function MCoBrw5()
//{IX} 000560 = Static Function MHoBrw6()
//{IX} 000586 = Static Function MCoBrw6()
//{IX} ================================================================================
#INCLUDE 'PROTHEUS.CH'
#INCLUDE 'RWMAKE.CH'
#INCLUDE 'FONT.CH'
#INCLUDE 'COLORS.CH'

User Function MSDIALOGTE()

   ///*ÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
   //±± Vanessa Limana                                                          ±±
   //Ù±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ*/

   Local nOpc         := GD_INSERT+GD_DELETE+GD_UPDATE
   Local aItems       := {'E','S'}
   Private aCoBrw1    := {}
   Private aCoBrw2    := {}
   Private aCoBrw3    := {}
   Private aCoBrw4    := {}
   Private aCoBrw5    := {}
   Private aCoBrw6    := {}
   Private aHoBrw1    := {}
   Private aHoBrw2    := {}
   Private aHoBrw3    := {}
   Private aHoBrw4    := {}
   Private aHoBrw5    := {}
   Private aHoBrw6    := {}
   Private cCliFor    := Space(6)
   Private cDocumento := "000019   "
   Private cFilial    := Space(4)
   Private cOperacao  := Space(1)
   Private cSerie     := Space(3)
   Private cValor     := Space(14)
   Private noBrw1     := 0
   Private noBrw2     := 0
   Private noBrw3     := 0
   Private noBrw4     := 0
   Private noBrw5     := 0
   Private noBrw6     := 0 
   Private Alias     
 
   SetPrvt("oDlg1","oSay2","oSay3","oSay1","oSay4","oSay5","oSay6","oSay7","oSay8","oSay9","oSay10","oSay11","Documento","Serie","Valor")
   SetPrvt("oSay13","oSay14","oSay15","oSay16","cFilial","oCBox1","oGet4")
   SetPrvt("oBrw2","oBrw3","oBrw4","oBrw5","oBrw6","oMGet1","oGet6")

   oDlg1      := MSDialog():New( 090,217,1100,1555,"Query Analyzer - CONECTADO AO BANCO",,,.F.,,,,,,.T.,,,.T. )
   oSay2      := TSay():New( 048,584,{||"Valor Destacado"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
   oSay3      := TSay():New(  088,580,{||"Campos com o valor"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
   //oSay1      := TSay():New( 008,008,{||"Filial"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay4      := TSay():New( 008,052,{||"Operacao"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay5      := TSay():New( 008,096,{||"Documento"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay6      := TSay():New( 008,140,{||"Serie"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay7      := TSay():New( 008,188,{||"Cli/For"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay8      := TSay():New( 008,232,{||"Destacar Valor"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,052,008)
   oSay9      := TSay():New( 048,008,{||"CAB NF"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay10     := TSay():New( 060,008,{||"SF1/SF2"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay11     := TSay():New( 100,008,{||"ITENS NF"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay12     := TSay():New( 112,008,{||"SD1/SD2"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay13     := TSay():New( 180,008,{||"LIVRO FIS"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay14     := TSay():New( 192,008,{||"SF3"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay15     := TSay():New( 260,008,{||"EFD"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay16     := TSay():New( 272,008,{||"SFT"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay17     := TSay():New( 340,008,{||"LANC DOC FIS"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
   oSay18     := TSay():New( 352,008,{||"CDA"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   oSay19     := TSay():New( 410,008,{||"IMPOSTOS SPED"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,072,008)
   oSay20     := TSay():New( 422,008,{||"CD2"},oDlg1,,,.F.,.F.,.F.,.T.,CLR_BLACK,CLR_WHITE,032,008)
   //cFilial    := TGet():New( 020,008,{|u| If(PCount()>0,cFilial:=u,cFilial)},oDlg1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cFilial",,)
   oCBox1     := TComboBox():new( 020,052,{|u|if(pcount()>0,cOperacao:=u,cOperacao)},aItems,036,010,oDlg1,,{|| atualizar() },,,,.T.,/*oFont*/,,,,,,,,'cOperacao')

   Documento  := TGet():New( 020,096,{|u| If(PCount()>0,cDocumento:=u,cDocumento)},oDlg1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cDocumento",,)
   Serie      := TGet():New( 020,140,{|u| If(PCount()>0,cSerie:=u,cSerie)},oDlg1,040,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cSerie",,)
   oGet4      := TGet():New( 020,188,{|u| If(PCount()>0,cCliFor:=u,cCliFor)},oDlg1,036,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cCliFor",,)
   Valor      := TGet():New( 020,232,{|u| If(PCount()>0,cValor:=u,cValor)},oDlg1,060,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","cValor",,)
   MHoBrw1()
   MCoBrw1()
   oBrw1      := MsNewGetDados():New(044,052,084,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw1,aCoBrw1 )
   MHoBrw2()
   MCoBrw2()
   oBrw2      := MsNewGetDados():New(096,052,164,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw2,aCoBrw2 )
   MHoBrw3()
   MCoBrw3()
   oBrw3      := MsNewGetDados():New(176,052,244,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw3,aCoBrw3 )
   MHoBrw4()
   MCoBrw4()
   oBrw4      := MsNewGetDados():New(256,052,324,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw4,aCoBrw4 )
   MHoBrw5()
   MCoBrw5()
   oBrw5      := MsNewGetDados():New(336,052,404,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw5,aCoBrw5 )
   MHoBrw6()
   MCoBrw6()
   oBrw6      := MsNewGetDados():New(416,052,484,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw6,aCoBrw6 )
   oMGet1     := TMultiGet():New( 104,580,,oDlg1,072,188,,,CLR_BLACK,CLR_WHITE,,.T.,"",,,.F.,.F.,.F.,,,.F.,,  )
   oGet6      := TGet():New( 060,580,,oDlg1,072,008,'',,CLR_BLACK,CLR_WHITE,,,,.T.,"",,,.F.,.F.,,.F.,.F.,"","",,)
   oBtn1      := TButton():New( 016,304,"Pesquisar",oDlg1,{||pesquisar(cOperacao,cDocumento,cSerie,cCliFor)},037,016,,,,.T.,,"",,,,.F. )
   oBtn2      := TButton():New( 016,360,"Salvar",oDlg1,{||salvar(cDocumento, cSerie)},037,16,,,,.T.,,"",,,,.F. )
 
   oDlg1:Activate(,,,.T.)

Return
 
Static Function pesquisar(cOper,cdoc, cser,ccli)
 

   If cOper = 'S'
      //SAIDAS - SF2, SD2
      DBSELECTAREA("SF2")
      DBSETORDER(1)//F2_FILIAL+F2_DOC+F2_SERIE+F2_CLIENTE+F2_LOJA+F2_FORMUL+F2_TIPO
      IF DBSEEK(XFILIAL("SF2")+ cDoc+cSer + alltrim(ccli))
         IF !FOUND()
            ALERT("Documento não localizado!")
         ENDIF
         LINHA:={}
         aItens:={}
         FOR F:=1 TO len(aHoBrw1)-1
            campo:=aHoBrw1[f][2]
            AADD(LINHA, (SF2->&CAMPO))
         NEXT
         AADD(LINHA, .F.)
         AADD(aItens, LINHA)
         linha:={}
         DBSKIP()
         obrw1:SetArray(aItens, .T.)
         oBrw1:ForceRefresh()
         oBrw1:oBrowse:Refresh()
      Endif

      SF2->(DbSeek(xFilial('SF2') + cdoc + cser + alltrim(ccli)))
      DBSELECTAREA("SD2")
      DBSETORDER(3)//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
      DbSeek(xFilial('SD2') + SF2->F2_DOC+SF2->F2_SERIE + AllTrim(SF2->F2_CLIENTE))
      LINHA2:={}
      aItens2:={}
      DO WHILE SD2->(!EOF()) .And. (SD2->D2_FILIAL+SD2->D2_DOC+SD2->D2_SERIE + if(empty(ccli),'',alltrim(SD2->D2_CLIENTE))) = (SF2->F2_FILIAL + SF2->F2_DOC + SF2->F2_SERIE + if(empty(ccli),'',alltrim(SD2->D2_CLIENTE)))
         FOR F:=1 TO len(aHoBrw2)-1
            campo2:=aHoBrw2[f][2]
            AADD(LINHA2, (SD2->&CAMPO2))
         NEXT
         AADD(LINHA2, .F.)
         AADD(aItens2, LINHA2)
         linha2:={}
         DBSKIP()
      ENDDO
      obrw2:setarray(aItens2, .T.)
      oBrw2:ForceRefresh()
      oBrw2:oBrowse:Refresh()
 
   ELSEIF cOper = 'E'
      //ENTRADAS SF1, SD1
      DBSELECTAREA("SF1")
      DBSETORDER(1)//F1_FILIAL+F1_DOC+F1_SERIE+F1_FORNECE+F1_LOJA+F1_TIPO
      IF DBSEEK(XFILIAL("SF1")+ cDoc + cSer + alltrim(ccli))
         linha:={}
         aItens:={}
         FOR F:=1 TO len(aHoBrw1)-1
            campo:=aHoBrw1[f][2]
            AADD(linha,(SF1->&campo))
         NEXT
         AADD(linha, .F.)
         AADD(aItens, linha)
         linha:={}
         DBSKIP()
         obrw1:SetArray(aItens, .T.)
         oBrw1:ForceRefresh()
         oBrw1:oBrowse:Refresh()
      ENDIF
  
      SF1->(DbSeek(xFilial('SF1') + cdoc + cser + alltrim(ccli))
      DBSELECTAREA("SD1")
      DBSETORDER(1)//D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA+D2_COD+D2_ITEM
      DbSeek(xFilial('SD1') + SF1->F1_DOC + SF1->F1_SERIE + allTrim(SF1->F1_FORNECE ))
      LINHA2:={}
      aItens2:={}
      DO WHILE SD1->(!EOF()) .And. (SD1->D1_FILIAL+SD1->D1_DOC+SD1->D1_SERIE +if(empty(ccli),'',alltrim(SD1->D1_FORNECE ))) = (SF1->F1_FILIAL+ SF1->F1_DOC + SF1->F1_SERIE + if(empty(ccli),'',alltrim(SF1->F1_FORNECE )))      
         FOR F:=1 TO len(aHoBrw2)-1
            campo2:=aHoBrw2[f][2]
            AADD(LINHA2, (SD1->&CAMPO2))
         NEXT
         AADD(LINHA2, .F.)
         AADD(aItens2, LINHA2)
         linha2:={}
         DBSKIP()
      ENDDO
      obrw2:setarray(aItens2, .T.)
      oBrw2:ForceRefresh()
      oBrw2:oBrowse:Refresh()
 
   ENDIF
   //----------------------------------------Tabela SD2--------------------------------------------------------------------//


   DbSelectArea("SF3")
   DbSetOrder(5)// F3_FILIAL+F3_SERIE+F3_NFISCAL+F3_CLIEFOR+F3_LOJA+F3_IDENTFT
   DbSeek(xFilial('SF3') + cser + cdoc + alltrim(ccli))
   LINHA3:={}                                                              
   aItens3:={}                                                             // F3_FILIAL  F3_SERIE         +F3_NFISCAL                 +F3_CLIEFOR                                                     
   DO WHILE !EOF() .AND.(XFILIAL("SF3")+ cser + cdoc + alltrim(ccli)) = (SF3->F3_FILIAL + SF3->F3_SERIE +SF3->F3_NFISCAL + if(empty(ccli),'',alltrim(SF3->F3_CLIEFOR)))
      FOR F:=1 TO len(aHoBrw3)-1
         campo3:=aHoBrw3[f][2]
         AADD(LINHA3, (SF3->&CAMPO3))
      NEXT
      AADD(LINHA3, .F.)
      AADD(aItens3, LINHA3)
      linha3:={}
      DBSKIP()
   ENDDO
   obrw3:setarray(aItens3, .T.)
   oBrw3:ForceRefresh()
   oBrw3:oBrowse:Refresh()
  
   //---------------------------------------------Tabela SFT----------------------------------------------------------------//

   DBSELECTAREA("SFT")
   DBSETORDER(1)//FT_FILIAL+FT_TIPOMOV+FT_SERIE+FT_NFISCAL+FT_CLIEFOR
   DBSEEK(XFILIAL("SFT")+ cOper + cSer + cDoc + alltrim(ccli))
   LINHA4:={}
   aItens4:={}
   DO WHILE !EOF() .AND.(XFILIAL("SFT") + cOper + cser + cdoc + alltrim(ccli)) = (SFT->FT_FILIAL+SFT->FT_TIPOMOV+SFT->FT_SERIE+SFT->FT_NFISCAL + if(empty(ccli),'',alltrim(SFT->FT_CLIEFOR)))
      FOR F:=1 TO len(aHoBrw4)-1
         campo4:=aHoBrw4[f][2]
         AADD(LINHA4, (SFT->&CAMPO4))
      NEXT
      AADD(LINHA4, .F.)
      AADD(aItens4, LINHA4)
      linha4:={}
      DBSKIP()
   ENDDO
   obrw4:setarray(aItens4, .T.)
   oBrw4:ForceRefresh()
   oBrw4:oBrowse:Refresh()
 
   //---------------------------------------------Tabela CDA----------------------------------------------------------------
   DBSELECTAREA("CDA")
   DBSETORDER(1)//CDA_FILIAL+CDA_TPMOVI+CDA_ESPECI+CDA_FORMUL+CDA_NUMERO+CDA_SERIE+CDA_CLIFOR+CDA_LOJA+CDA_NUMITE+CDA_SEQ+CDA_CODLAN+CDA_CALPRO
   DBSEEK(XFILIAL("CDA")+ cOper+ cDoc+cSer+alltrim(ccli))
   LINHA5:={}
   aItens5:={}
   DO WHILE !EOF() .AND. (XFILIAL("CDA") + cOper + cDoc + cSer + alltrim(ccli)) = (CDA->CDA_FILIAL +CDA->CDA_TPMOVI +CDA->CDA_NUMERO + CDA->CDA_SERIE + if(empty(ccli),'',alltrim(CDA->CDA_CLIFOR)))
      FOR F:=1 TO len(aHoBrw5)-1
         campo5:=aHoBrw5[f][2]
         AADD(LINHA5, (CDA->&CAMPO5))
      NEXT
      AADD(LINHA5, .F.)
      AADD(aItens5, LINHA5)
      linha5:={}
      DBSKIP()
   ENDDO
   obrw5:setarray(aItens5, .T.)
   oBrw5:ForceRefresh()
   oBrw5:oBrowse:Refresh()
 

   //---------------------------------------------Tabela CD2----------------------------------------------------------------

   DBSELECTAREA("CD2")
   DBSETORDER(1)//CD2_FILIAL+CD2_TPMOV+CD2_SERIE+CD2_DOC+CD2_CODCLI+CD2_LOJCLI+CD2_ITEM+CD2_CODPRO+CD2_IMP
   DBSEEK(XFILIAL("CD2")+ cOper+ cSer + cDoc + alltrim(ccli))
   LINHA6:={}
   aItens6:={}
   DO WHILE !EOF() .AND. (XFILIAL("CD2") + cOper+ cSer + cDoc + alltrim(ccli)) = (CD2->CD2_FILIAL + CD2->CD2_TPMOV + CD2->CD2_SERIE + CD2->CD2_DOC + if(empty(ccli),'',alltrim(CD2->CD2_CODCLI)))
      FOR F:=1 TO len(aHoBrw6)-1
         campo6:=aHoBrw6[f][2]
         AADD(LINHA6, (CD2->&CAMPO6))
      NEXT
      AADD(LINHA6, .F.)
      AADD(aItens6, LINHA6)
      linha6:={}
      DBSKIP()
   ENDDO
   obrw6:setarray(aItens6, .T.)
   oBrw6:ForceRefresh()
   oBrw6:oBrowse:Refresh()
 
RETURN


//Função para atualizar tabelas SF1/SF2 e SD1/SD2
Static function atualizar()
   atlztela1()
   atlztela2()
Return

Static function atlztela1() 
   Local nOpc := GD_INSERT+GD_DELETE+GD_UPDATE
   aCoBrw1 := {}
   aHoBrw1 := {}
   noBrw1  := 0
   MHoBrw1() //aheader
   MCoBrw1() //acols
 
   oBrw1   := MsNewGetDados():New(044,052,084,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw1,aCoBrw1 )
   oBrw1:ForceRefresh()
   oBrw1:oBrowse:Refresh()

Return


Static Function atlztela2() 

   Local nOpc := GD_INSERT+GD_DELETE+GD_UPDATE
   aCoBrw2 := {}
   aHoBrw2 := {}
   noBrw2  := 0
   MHoBrw2()
   MCoBrw2()
   oBrw2   := MsNewGetDados():New(096,052,164,568,nOpc,'AllwaysTrue()','AllwaysTrue()','',,0,99,'AllwaysTrue()','','AllwaysTrue()',oDlg1,aHoBrw2,aCoBrw2 )
   oBrw2:ForceRefresh()
   oBrw2:oBrowse:Refresh()
 
Return

Static Function MHoBrw1()

   If cOperacao = 'E'
      DbSelectArea("SX3")
      DbSetOrder(1)
      DbSeek("SF1")
      aHoBrw1:={}
      While !Eof() .and. SX3->X3_ARQUIVO == "SF1"
         If X3USO(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
            noBrw1++
            Aadd(aHoBrw1,{Trim(X3Titulo()),;
            SX3->X3_CAMPO,;
            SX3->X3_PICTURE,;
           SX3->X3_TAMANHO,;
            SX3->X3_DECIMAL,;
            "",;
            "",;
            SX3->X3_TIPO,;
            "",;
            "" } )
         EndIf
         DbSkip()
      Enddo
 
   ELSE  //cOperacao ='S' //saida

      DbSelectArea("SX3")
      DbSetOrder(1)
      DbSeek("SF2")
      aHoBrw1:={}
      While !Eof() .and. SX3->X3_ARQUIVO == "SF2"
         If X3USO(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
            noBrw1++
            Aadd(aHoBrw1,{Trim(X3Titulo()),;
            SX3->X3_CAMPO,;
            SX3->X3_PICTURE,;
            SX3->X3_TAMANHO,;
            SX3->X3_DECIMAL,;
            "",;
            "",;
            SX3->X3_TIPO,;
            "",;
            "" } )
         EndIf
         DbSkip()
      Enddo
   ENDIF

Return

Static Function MCoBrw1()
 
   Local aAux := {}
   Aadd(aCoBrw1,Array(noBrw1+1))
   For nI := 1 To noBrw1
      aCoBrw1[1][nI] := CriaVar(aHoBrw1[nI][2])
   Next
   aCoBrw1[1][noBrw1+1] := .F.
Return
 
Static Function MHoBrw2()

   If cOperacao = 'E' //entrada
      DbSelectArea("SX3")
      DbSetOrder(1)
      DbSeek("SD1")
      While !Eof() .and. SX3->X3_ARQUIVO == "SD1"
         IF X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
            IF (SX3->X3_CONTEXT) <> 'V'
               noBrw2++
               Aadd(aHoBrw2,{Trim(X3Titulo()),;
               SX3->X3_CAMPO,;
               SX3->X3_PICTURE,;
               SX3->X3_TAMANHO,;
               SX3->X3_DECIMAL,;
               SX3->X3_VALID,;
               SX3->X3_USADO,;
               SX3->X3_TIPO,;
               SX3->X3_F3,;
               SX3->X3_CONTEXT,;
               SX3->X3_CBOX,;
               SX3->X3_RELACAO,;
               SX3->X3_WHEN,;
               " ",;
               SX3->X3_VLDUSER,;
               SX3->X3_PICTVAR,;
               SX3->X3_OBRIGAT})
            ENDIF
         EndIf

         DbSkip()
      Enddo

 

   ELSE//  coperacao == 'S'


      DbSelectArea("SX3")
      DbSetOrder(1)
      DbSeek("SD2")
      While !Eof() .and. SX3->X3_ARQUIVO == "SD2"
         If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
            noBrw2++
            Aadd(aHoBrw2,{Trim(X3Titulo()),;
            SX3->X3_CAMPO,;
            SX3->X3_PICTURE,;
            SX3->X3_TAMANHO,;
            SX3->X3_DECIMAL,;
            "",;
            "",;
            SX3->X3_TIPO,;
            "",;
            "" } )
         EndIf
         DbSkip()
      Enddo
   ENDIF
Return

 

Static Function MCoBrw2()

   Local aAux := {}
   Aadd(aCoBrw2,Array(noBrw2+1))
   For nI := 1 To noBrw2
      aCoBrw2[1][nI] := CriaVar(aHoBrw2[nI][2])
   Next
   aCoBrw2[1][noBrw2+1] := .F.

Return 

Static Function MHoBrw3()

   DbSelectArea("SX3")
   DbSetOrder(1)
   DbSeek("SF3")
   While !Eof() .and. SX3->X3_ARQUIVO == "SF3"
      If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
         noBrw3++
         Aadd(aHoBrw3,{Trim(X3Titulo()),;
         SX3->X3_CAMPO,;
         SX3->X3_PICTURE,;
         SX3->X3_TAMANHO,;
         SX3->X3_DECIMAL,;
         "",;
         "",;
         SX3->X3_TIPO,;
         "",;
         "" } )
      EndIf
      DbSkip()
   Enddo
 
Return
 
Static Function MCoBrw3()

   Local aAux := {}
   Aadd(aCoBrw3,Array(noBrw3+1))
   For nI := 1 To noBrw3
      aCoBrw3[1][nI] := CriaVar(aHoBrw3[nI][2])
   Next
   aCoBrw3[1][noBrw3+1] := .F.
Return

Static Function MHoBrw4()

   DbSelectArea("SX3")
   DbSetOrder(1)
   DbSeek("SFT")
   While !Eof() .and. SX3->X3_ARQUIVO == "SFT"
      If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
         noBrw4++
         Aadd(aHoBrw4,{Trim(X3Titulo()),;
         SX3->X3_CAMPO,;
         SX3->X3_PICTURE,;
         SX3->X3_TAMANHO,;
         SX3->X3_DECIMAL,;
         "",;
         "",;
         SX3->X3_TIPO,;
         "",;
         ""  } )
      EndIf
      DbSkip()
   Enddo

Return
 
Static Function MCoBrw4()

   Local aAux := {}
   Aadd(aCoBrw4,Array(noBrw4+1))
   For nI := 1 To noBrw4
      aCoBrw4[1][nI] := CriaVar(aHoBrw4[nI][2])
   Next
   aCoBrw4[1][noBrw4+1] := .F.

Return
Static Function MHoBrw5()

   DbSelectArea("SX3")
   DbSetOrder(1)
   DbSeek("CDA")
   While !Eof() .and. SX3->X3_ARQUIVO == "CDA"
      If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
         noBrw5++
         Aadd(aHoBrw5,{Trim(X3Titulo()),;
         SX3->X3_CAMPO,;
         SX3->X3_PICTURE,;
         SX3->X3_TAMANHO,;
         SX3->X3_DECIMAL,;
         "",;
         "",;
         SX3->X3_TIPO,;
         "",;
         SX3->X3_CBOX} )
      EndIf
      DbSkip()
   Enddo

 

Return

 

Static Function MCoBrw5()

   Local aAux := {} 
   Aadd(aCoBrw5,Array(noBrw5+1))
   For nI := 1 To noBrw5
      aCoBrw5[1][nI] := CriaVar(aHoBrw5[nI][2])
   Next
   aCoBrw5[1][noBrw5+1] := .F.
Return

Static Function MHoBrw6()
   DbSelectArea("SX3")
   DbSetOrder(1)
   DbSeek("CD2")
   While !Eof() .and. SX3->X3_ARQUIVO == "CD2"
      If X3Uso(SX3->X3_USADO) .and. cNivel >= SX3->X3_NIVEL
         IF (SX3->X3_CONTEXT) <> 'V'
            noBrw6++
            Aadd(aHoBrw6,{Trim(X3Titulo()),;
            SX3->X3_CAMPO,;
            SX3->X3_PICTURE,;
            SX3->X3_TAMANHO,;
            SX3->X3_DECIMAL,;
            "",;
            "",;
            SX3->X3_TIPO,;
            "",;
            SX3->X3_CBOX} )
         ENDIF
      EndIf
      DbSkip()
   Enddo
Return

 

Static Function MCoBrw6()

 

   Local aAux := {}
   Aadd(aCoBrw6,Array(noBrw6+1))
   For nI := 1 To noBrw6
      aCoBrw6[1][nI] := CriaVar(aHoBrw6[nI][2])
   Next
   aCoBrw6[1][noBrw6+1] := .F.
Return