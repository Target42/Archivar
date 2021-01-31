object epubMngrForm: TepubMngrForm
  Left = 0
  Top = 0
  Caption = 'ePub-Manager'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 232
    Align = alClient
    Caption = #220'bersicht'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 631
      Height = 215
      Align = alClient
      DataSource = EPSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
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
          FieldName = 'EP_TITLE'
          Title.Caption = 'Titel'
          Width = 200
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EP_NAME'
          Title.Caption = 'Dateiname'
          Width = 120
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EP_GROUP'
          Title.Caption = 'Gruppe'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EP_SUB'
          Title.Caption = 'Untergruppe'
          Width = 100
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 232
    Width = 635
    Height = 48
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object btnUload: TBitBtn
      Left = 16
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Upload'
      TabOrder = 0
      OnClick = btnUloadClick
    end
    object BitBtn1: TBitBtn
      Left = 105
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Gruppe'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 200
      Top = 17
      Width = 75
      Height = 25
      Caption = 'Untergruppe'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsEpub'
    Left = 72
    Top = 64
  end
  object EPTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ePubTab'
    RemoteServer = DSProviderConnection1
    Left = 80
    Top = 120
  end
  object EPSrc: TDataSource
    DataSet = EPTab
    Left = 224
    Top = 80
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultExtension = '*.pub'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'ePub (*.epub)'
        FileMask = '*.epub'
      end
      item
        DisplayName = 'Alle Datein(*.*)'
        FileMask = '*.*'
      end>
    Options = [fdoAllowMultiSelect, fdoFileMustExist]
    Title = 'ePub laden'
    Left = 136
    Top = 168
  end
end
