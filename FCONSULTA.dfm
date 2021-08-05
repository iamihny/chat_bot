object frmConsulta: TfrmConsulta
  Left = 0
  Top = 0
  Caption = 'Consulta Solu'#231#245'es'
  ClientHeight = 500
  ClientWidth = 699
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 699
    Height = 56
    Align = alTop
    BevelOuter = bvLowered
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = -111
    ExplicitWidth = 657
    object Label3: TLabel
      Left = 83
      Top = 9
      Width = 57
      Height = 13
      Caption = 'Processo :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 88
      Top = 35
      Width = 52
      Height = 13
      Caption = 'Assunto :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edProcesso: TEdit
      Left = 218
      Top = 7
      Width = 325
      Height = 21
      Enabled = False
      TabOrder = 0
    end
    object ceProcesso: TComboEdit
      Left = 146
      Top = 5
      Width = 68
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 1
      OnButtonClick = ceProcessoButtonClick
      OnChange = ceProcessoChange
    end
    object edAssunto: TEdit
      Left = 218
      Top = 32
      Width = 325
      Height = 21
      Enabled = False
      TabOrder = 2
    end
    object ceAssunto: TComboEdit
      Left = 146
      Top = 32
      Width = 68
      Height = 21
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        0400000000000001000000000000000000001000000010000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      TabOrder = 3
      OnButtonClick = ceAssuntoButtonClick
      OnChange = ceAssuntoChange
    end
  end
  object gProcesso: TDBGrid
    Left = 0
    Top = 56
    Width = 699
    Height = 403
    Align = alClient
    DataSource = dsSolucoes
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'COD_SOLUCAO'
        Title.Alignment = taCenter
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DUVIDA'
        Title.Alignment = taCenter
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SOLUCAO'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SOLUCAO2'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'SOLUCAO3'
        Title.Alignment = taCenter
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PALAVRA_CHAVE'
        Title.Alignment = taCenter
        Title.Caption = 'Palavra-Chave'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PALAVRA_CHAVE2'
        Title.Alignment = taCenter
        Title.Caption = 'Palavra-Chave 2'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PALAVRA_CHAVE3'
        Title.Alignment = taCenter
        Title.Caption = 'Palavra-Chave 3'
        Width = 90
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IND_CHATBOT'
        Title.Alignment = taCenter
        Title.Caption = 'CHAT'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'IND_DOCUMENTACAO'
        Title.Alignment = taCenter
        Title.Caption = 'WEB'
        Width = 30
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 459
    Width = 699
    Height = 41
    Align = alBottom
    TabOrder = 2
    ExplicitLeft = 320
    ExplicitTop = 465
    object Label5: TLabel
      Left = 37
      Top = 12
      Width = 119
      Height = 13
      Caption = 'TOTAL DE SOLU'#199#213'ES :'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object totSolucoes: TEdit
      Left = 162
      Top = 9
      Width = 55
      Height = 21
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
    end
  end
  object qryNAssunto: TOraQuery
    SQL.Strings = (
      'SELECT ASSUNTO '
      '  FROM CHAT0200'
      'WHERE COD_ASSUNTO = :COD_ASSUNTO')
    Left = 432
    Top = 296
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COD_ASSUNTO'
      end>
    object qryNAssuntoASSUNTO: TStringField
      FieldName = 'ASSUNTO'
      Required = True
      Size = 50
    end
  end
  object qryAssunto: TOraQuery
    SQL.Strings = (
      'SELECT * '
      '  FROM CHAT0200'
      ' WHERE COD_PROCESSO = :COD_PROCESSO')
    Left = 448
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COD_PROCESSO'
      end>
    object qryAssuntoCOD_ASSUNTO: TFloatField
      FieldName = 'COD_ASSUNTO'
      Required = True
    end
    object qryAssuntoASSUNTO: TStringField
      FieldName = 'ASSUNTO'
      Required = True
      Size = 50
    end
    object qryAssuntoORDEM: TFloatField
      FieldName = 'ORDEM'
    end
  end
  object qryProcesso: TOraQuery
    SQL.Strings = (
      'SELECT *'
      '  FROM CHAT0100'
      ' ORDER BY ORDEM')
    FetchAll = True
    Left = 432
    Top = 160
    object qryProcessoCOD_PROCESSO: TFloatField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'COD_PROCESSO'
      Required = True
    end
    object qryProcessoPROCESSO: TStringField
      DisplayLabel = 'Processo'
      FieldName = 'PROCESSO'
      Required = True
      Size = 50
    end
    object qryProcessoORDEM: TFloatField
      FieldName = 'ORDEM'
    end
  end
  object qryNProcesso: TOraQuery
    SQL.Strings = (
      'SELECT PROCESSO '
      '  FROM CHAT0100'
      'WHERE COD_PROCESSO = :COD_PROCESSO')
    Left = 440
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'COD_PROCESSO'
      end>
    object qryNProcessoPROCESSO: TStringField
      FieldName = 'PROCESSO'
      Required = True
      Size = 50
    end
  end
  object qrySolucoes: TOraQuery
    SQL.Strings = (
      'SELECT * '
      '  FROM CHAT0300'
      ' &PROCESSO'
      ' &ASSUNTO'
      'ORDER BY ORDEM')
    FetchAll = True
    AfterOpen = qrySolucoesAfterOpen
    AfterClose = qrySolucoesAfterClose
    Left = 208
    Top = 248
    MacroData = <
      item
        Name = 'PROCESSO'
      end
      item
        Name = 'ASSUNTO'
      end>
    object qrySolucoesCOD_PROCESSO: TFloatField
      DisplayLabel = 'C'#243'd. Processo'
      FieldName = 'COD_PROCESSO'
      Required = True
    end
    object qrySolucoesCOD_ASSUNTO: TFloatField
      DisplayLabel = 'C'#243'd. Assunto'
      FieldName = 'COD_ASSUNTO'
      Required = True
    end
    object qrySolucoesCOD_SOLUCAO: TFloatField
      DisplayLabel = 'C'#243'd. Solu'#231#227'o'
      FieldName = 'COD_SOLUCAO'
      Required = True
    end
    object qrySolucoesDUVIDA: TStringField
      DisplayLabel = 'D'#250'vida'
      FieldName = 'DUVIDA'
      Required = True
      Size = 500
    end
    object qrySolucoesSOLUCAO: TStringField
      DisplayLabel = 'Solu'#231#227'o - Passo 1'
      FieldName = 'SOLUCAO'
      Size = 500
    end
    object qrySolucoesSOLUCAO2: TStringField
      DisplayLabel = 'Solu'#231#227'o -  Passo 2'
      FieldName = 'SOLUCAO2'
      Size = 500
    end
    object qrySolucoesSOLUCAO3: TStringField
      DisplayLabel = 'Solu'#231#227'o - Passo 3'
      FieldName = 'SOLUCAO3'
      Size = 500
    end
    object qrySolucoesORDEM: TFloatField
      FieldName = 'ORDEM'
    end
    object qrySolucoesIMAGEM: TBlobField
      FieldName = 'IMAGEM'
      BlobType = ftOraBlob
    end
    object qrySolucoesIMAGEM2: TBlobField
      FieldName = 'IMAGEM2'
      BlobType = ftOraBlob
    end
    object qrySolucoesIMAGEM3: TBlobField
      FieldName = 'IMAGEM3'
      BlobType = ftOraBlob
    end
    object qrySolucoesNOME_IMAGEM: TStringField
      FieldName = 'NOME_IMAGEM'
      Size = 200
    end
    object qrySolucoesNOME_IMAGEM2: TStringField
      FieldName = 'NOME_IMAGEM2'
      Size = 200
    end
    object qrySolucoesNOME_IMAGEM3: TStringField
      FieldName = 'NOME_IMAGEM3'
      Size = 200
    end
    object qrySolucoesLINK_VIDEO: TStringField
      FieldName = 'LINK_VIDEO'
      Size = 200
    end
    object qrySolucoesLINK_VIDEO2: TStringField
      FieldName = 'LINK_VIDEO2'
      Size = 200
    end
    object qrySolucoesLINK_VIDEO3: TStringField
      FieldName = 'LINK_VIDEO3'
      Size = 200
    end
    object qrySolucoesPALAVRA_CHAVE: TStringField
      FieldName = 'PALAVRA_CHAVE'
      Size = 30
    end
    object qrySolucoesPALAVRA_CHAVE2: TStringField
      FieldName = 'PALAVRA_CHAVE2'
      Size = 30
    end
    object qrySolucoesPALAVRA_CHAVE3: TStringField
      FieldName = 'PALAVRA_CHAVE3'
      Size = 30
    end
    object qrySolucoesIND_CHATBOT: TStringField
      FieldName = 'IND_CHATBOT'
      Size = 1
    end
    object qrySolucoesIND_DOCUMENTACAO: TStringField
      FieldName = 'IND_DOCUMENTACAO'
      Size = 1
    end
    object qrySolucoesCOD_DOCUMENTO: TFloatField
      FieldName = 'COD_DOCUMENTO'
    end
    object qrySolucoesCOD_DOCUMENTO2: TFloatField
      FieldName = 'COD_DOCUMENTO2'
    end
  end
  object dsSolucoes: TOraDataSource
    DataSet = qrySolucoes
    Left = 184
    Top = 216
  end
  object qryTotais: TOraQuery
    Left = 328
    Top = 296
  end
end
