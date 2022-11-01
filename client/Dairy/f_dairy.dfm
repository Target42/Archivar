object DairyForm: TDairyForm
  Left = 0
  Top = 0
  Caption = 'Tagebuch'
  ClientHeight = 540
  ClientWidth = 935
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 209
    Width = 935
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 280
    ExplicitWidth = 241
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 521
    Width = 935
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 935
    Height = 209
    Align = alTop
    Caption = 'Liste'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 931
      Height = 192
      Align = alClient
      DataSource = DISrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'DI_STAMP'
          Title.Caption = 'Zeitpunkt'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'CryptText'
          Title.Caption = 'Verschl'#252'sselt'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DI_TAGS'
          Title.Caption = 'Tags'
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 212
    Width = 935
    Height = 69
    Align = alTop
    Caption = 'Suche'
    TabOrder = 2
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 281
    Width = 935
    Height = 240
    Align = alClient
    Caption = 'Daten'
    TabOrder = 3
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsDairy'
    Left = 280
    Top = 40
  end
  object DITab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DISrc'
    RemoteServer = DSProviderConnection1
    Left = 264
    Top = 96
    object DITabDI_ID: TAutoIncField
      FieldName = 'DI_ID'
      Origin = 'DI_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      ReadOnly = True
    end
    object DITabPE_ID: TIntegerField
      FieldName = 'PE_ID'
      Origin = 'PE_ID'
    end
    object DITabDI_STAMP: TSQLTimeStampField
      FieldName = 'DI_STAMP'
      Origin = 'DI_STAMP'
    end
    object DITabDI_CRYPTED: TStringField
      FieldName = 'DI_CRYPTED'
      Origin = 'DI_CRYPTED'
      FixedChar = True
      Size = 1
    end
    object DITabDI_TEXT: TBlobField
      FieldName = 'DI_TEXT'
      Origin = 'DI_TEXT'
    end
    object DITabDI_TAGS: TStringField
      FieldName = 'DI_TAGS'
      Origin = 'DI_TAGS'
      Size = 255
    end
    object DITabCryptText: TStringField
      FieldKind = fkCalculated
      FieldName = 'CryptText'
      OnGetText = DITabCryptTextGetText
      Calculated = True
    end
  end
  object DISrc: TDataSource
    DataSet = DITab
    Left = 328
    Top = 112
  end
end
