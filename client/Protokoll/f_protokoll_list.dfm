object ProtocollListForm: TProtocollListForm
  Left = 0
  Top = 0
  Caption = 'Protokolle'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 547
        ExplicitLeft = 547
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    DataSource = ListPrSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PR_NAME'
        Title.Caption = 'Name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PR_NR'
        Title.Caption = 'Nr'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PR_DATUM'
        Title.Caption = 'Datum'
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsProtocol'
    Left = 56
    Top = 24
  end
  object ListPrQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
    ProviderName = 'ListPrQry'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 72
  end
  object ListPrSrc: TDataSource
    DataSet = ListPrQry
    Left = 128
    Top = 72
  end
end
