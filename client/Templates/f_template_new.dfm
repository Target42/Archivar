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
  DesignSize = (
    351
    315)
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
    ExplicitTop = 255
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
        Enabled = False
        Kind = bkCustom
        ModalResult = 0
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 252
      end
    end
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 27
    Width = 248
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    DataField = 'TE_NAME'
    DataSource = TESrc
    TabOrder = 1
    OnKeyPress = DBEdit1KeyPress
  end
  object DBCheckBox1: TDBCheckBox
    Left = 270
    Top = 29
    Width = 68
    Height = 17
    Anchors = [akTop, akRight]
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
    Anchors = [akLeft, akTop, akRight]
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
  object LV: TListView
    Left = 16
    Top = 165
    Width = 322
    Height = 84
    Anchors = [akLeft, akTop, akRight]
    Columns = <
      item
        Caption = 'Name'
        Width = 75
      end
      item
        Caption = 'Vorhanden'
        Width = 65
      end
      item
        Caption = 'CLID'
        Width = 150
      end>
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 6
    ViewStyle = vsReport
    Visible = False
    OnClick = LVClick
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTemplate'
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
    Top = 8
  end
  object TYSrc: TDataSource
    DataSet = TYTab
    Left = 208
    Top = 24
  end
end
