object TaskTypeForm: TTaskTypeForm
  Left = 0
  Top = 0
  Caption = 'Aufgabentypen'
  ClientHeight = 281
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 221
    Width = 417
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 221
    ExplicitWidth = 417
    inherited StatusBar1: TStatusBar
      Width = 417
      ExplicitWidth = 417
    end
    inherited Panel1: TPanel
      Width = 417
      ExplicitWidth = 417
      inherited OKBtn: TBitBtn
        Left = 318
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 318
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 417
    Height = 190
    Align = alClient
    DataSource = TYSrc
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'TY_NAME'
        Title.Caption = 'Name'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TY_TAGE'
        Title.Caption = 'Tage'
        Visible = True
      end>
  end
  object DBNavigator1: TDBNavigator
    AlignWithMargins = True
    Left = 3
    Top = 193
    Width = 411
    Height = 25
    DataSource = TYSrc
    Align = alBottom
    ParentShowHint = False
    ShowHint = True
    TabOrder = 2
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TStammMod'
    SQLConnection = GM.SQLConnection1
    Left = 48
    Top = 16
  end
  object TYTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TYTab'
    RemoteServer = DSProviderConnection1
    BeforePost = TYTabBeforePost
    Left = 48
    Top = 72
  end
  object TYSrc: TDataSource
    DataSet = TYTab
    Left = 48
    Top = 128
  end
end
