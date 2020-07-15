object SelectTemplateForm: TSelectTemplateForm
  Left = 0
  Top = 0
  Caption = 'Vorlage ausw'#228'hlen'
  ClientHeight = 299
  ClientWidth = 735
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
    Width = 735
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 80
    inherited StatusBar1: TStatusBar
      Width = 735
      ExplicitWidth = 736
    end
    inherited Panel1: TPanel
      Width = 735
      inherited OKBtn: TBitBtn
        Left = 636
        OnClick = BaseFrame1OKBtnClick
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 735
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
        FieldName = 'TE_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TE_VERSION'
        Title.Caption = 'Version'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TE_SHORT'
        Title.Caption = 'Beschreibung'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TE_TAGS'
        Title.Caption = 'Tags'
        Width = 250
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTemplate'
    SQLConnection = GM.SQLConnection1
    Left = 56
    Top = 24
  end
  object ListDataSet: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'sys'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'state'
        ParamType = ptInput
      end>
    ProviderName = 'ListTempatesQry'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 152
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ListDataSet
    Left = 224
    Top = 24
  end
end
