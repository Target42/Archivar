object TaskDatafieldsForm: TTaskDatafieldsForm
  Left = 0
  Top = 0
  Caption = 'Globale Datenfelder'
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
    ExplicitLeft = 184
    ExplicitTop = 80
    inherited StatusBar1: TStatusBar
      Width = 635
    end
    inherited Panel1: TPanel
      Width = 635
      inherited OKBtn: TBitBtn
        Left = 536
        OnClick = BaseFrame1OKBtnClick
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    DataSource = DataFieldsSrc
    Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'DA_NAME'
        Title.Caption = 'Name'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DA_TYPE'
        Title.Caption = 'Type'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DA_REM'
        Title.Caption = 'Bemerkung'
        Width = 300
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTemplate'
    SQLConnection = GM.SQLConnection1
    Left = 48
    Top = 24
  end
  object Datafields: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataFields'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 80
  end
  object DataFieldsSrc: TDataSource
    DataSet = Datafields
    Left = 232
    Top = 40
  end
end
