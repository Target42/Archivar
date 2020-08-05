object TemplateNewForm: TTemplateNewForm
  Left = 0
  Top = 0
  ActiveControl = DBEdit1
  Caption = 'Neue Vorlage erstellen'
  ClientHeight = 315
  ClientWidth = 351
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
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 16
    Top = 54
    Width = 64
    Height = 13
    Caption = 'Beschreibung'
  end
  object Label3: TLabel
    Left = 16
    Top = 100
    Width = 23
    Height = 13
    Caption = 'Tags'
  end
  object Label4: TLabel
    Left = 16
    Top = 146
    Width = 63
    Height = 13
    Caption = 'Aufgabentyp'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 255
    Width = 351
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 168
    ExplicitWidth = 351
    inherited StatusBar1: TStatusBar
      Width = 351
      ExplicitWidth = 351
    end
    inherited Panel1: TPanel
      Width = 351
      ExplicitWidth = 351
      inherited OKBtn: TBitBtn
        Left = 252
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 252
      end
    end
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 27
    Width = 241
    Height = 21
    DataField = 'TE_NAME'
    DataSource = TESrc
    TabOrder = 1
  end
  object DBCheckBox1: TDBCheckBox
    Left = 272
    Top = 29
    Width = 97
    Height = 17
    Caption = 'System'
    DataField = 'TE_SYSTEM'
    DataSource = TESrc
    TabOrder = 2
    ValueChecked = 'T'
    ValueUnchecked = 'F'
    Visible = False
    OnClick = DBCheckBox1Click
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 73
    Width = 322
    Height = 21
    DataField = 'TE_SHORT'
    DataSource = TESrc
    TabOrder = 3
  end
  object DBEdit3: TDBEdit
    Left = 16
    Top = 119
    Width = 322
    Height = 21
    CharCase = ecLowerCase
    DataField = 'TE_TAGS'
    DataSource = TESrc
    TabOrder = 4
  end
  object DBLookupListBox1: TDBLookupListBox
    Left = 16
    Top = 165
    Width = 322
    Height = 82
    DataField = 'TY_ID'
    DataSource = TESrc
    KeyField = 'TY_ID'
    ListField = 'TY_NAME'
    ListSource = TYSrc
    TabOrder = 5
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTemplate'
    SQLConnection = GM.SQLConnection1
    Left = 56
    Top = 24
  end
  object TETab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TemplateTab'
    RemoteServer = DSProviderConnection1
    BeforePost = TETabBeforePost
    OnNewRecord = TETabNewRecord
    Left = 152
    Top = 16
  end
  object TESrc: TDataSource
    DataSet = TETab
    Left = 152
    Top = 72
  end
  object TYTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TYTab'
    RemoteServer = DSProviderConnection1
    Left = 96
    Top = 120
  end
  object TYSrc: TDataSource
    DataSet = TYTab
    Left = 224
    Top = 96
  end
end
