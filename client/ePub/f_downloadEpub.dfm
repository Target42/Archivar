object DownloadEpubform: TDownloadEpubform
  Left = 0
  Top = 0
  Caption = 'ePub ausw'#228'hlen'
  ClientHeight = 299
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 792
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 597
    inherited StatusBar1: TStatusBar
      Width = 792
      ExplicitWidth = 790
    end
    inherited Panel1: TPanel
      Width = 792
      ExplicitWidth = 597
      inherited OKBtn: TBitBtn
        Left = 693
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 498
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 792
    Height = 239
    Align = alClient
    DataSource = DataSource1
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
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
        Width = 550
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
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsEpub'
    Left = 64
    Top = 16
  end
  object EPTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ePubTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 64
    Top = 72
  end
  object DataSource1: TDataSource
    DataSet = EPTab
    Left = 120
    Top = 72
  end
end
