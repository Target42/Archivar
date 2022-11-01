object TestBlockListForm: TTestBlockListForm
  Left = 0
  Top = 0
  Caption = 'Textbaussteine'
  ClientHeight = 299
  ClientWidth = 589
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 589
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 589
    inherited StatusBar1: TStatusBar
      Width = 589
      ExplicitWidth = 589
    end
    inherited Panel1: TPanel
      Width = 589
      ExplicitWidth = 589
      inherited OKBtn: TBitBtn
        Left = 490
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 490
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 589
    Height = 239
    Align = alClient
    DataSource = DataSource1
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
        FieldName = 'TB_NAME'
        Title.Caption = 'Name'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TB_TAGS'
        Title.Caption = 'Tags'
        Width = 350
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTextBlock'
    Left = 88
    Top = 40
  end
  object TBTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TBTab'
    RemoteServer = DSProviderConnection1
    Left = 104
    Top = 104
  end
  object DataSource1: TDataSource
    DataSet = TBTab
    Left = 184
    Top = 104
  end
  object DelQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'tb_id'
        ParamType = ptInput
      end>
    ProviderName = 'DelTB'
    RemoteServer = DSProviderConnection1
    Left = 320
    Top = 104
  end
end
