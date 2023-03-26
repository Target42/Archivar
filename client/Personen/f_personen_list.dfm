object PersonenListForm: TPersonenListForm
  Left = 0
  Top = 0
  Caption = 'Personenliste'
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
        Left = 536
        Top = 10
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 536
        ExplicitTop = 10
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    DataSource = PESrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'PE_NET'
        Title.Caption = 'Login'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_NAME'
        Title.Caption = 'Name'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_VORNAME'
        Title.Caption = 'Vorname'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_DEPARTMENT'
        Title.Caption = 'Abteilung'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_MAIL'
        Title.Caption = 'Mail'
        Width = 200
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsPerson'
    Left = 72
    Top = 32
  end
  object PETab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PETab'
    RemoteServer = DSProviderConnection1
    Left = 168
    Top = 24
    object PETabPE_ID: TIntegerField
      FieldName = 'PE_ID'
      Required = True
    end
    object PETabPE_NAME: TStringField
      FieldName = 'PE_NAME'
      Size = 100
    end
    object PETabPE_VORNAME: TStringField
      FieldName = 'PE_VORNAME'
      Size = 100
    end
    object PETabPE_DEPARTMENT: TStringField
      FieldName = 'PE_DEPARTMENT'
      Size = 25
    end
    object PETabPE_NET: TStringField
      FieldName = 'PE_NET'
      Size = 25
    end
    object PETabPE_MAIL: TStringField
      FieldName = 'PE_MAIL'
      Size = 200
    end
  end
  object PESrc: TDataSource
    DataSet = PETab
    Left = 224
    Top = 32
  end
end
