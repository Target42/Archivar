object Taskform: TTaskform
  Left = 0
  Top = 0
  ActiveControl = DBEdit2
  Caption = 'Aufgabe'
  ClientHeight = 389
  ClientWidth = 538
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
    Width = 24
    Height = 13
    Caption = 'Type'
  end
  object Label2: TLabel
    Left = 16
    Top = 56
    Width = 50
    Height = 13
    Caption = 'Bearbeiter'
  end
  object Label3: TLabel
    Left = 16
    Top = 102
    Width = 38
    Height = 13
    Caption = 'Eingang'
  end
  object Label4: TLabel
    Left = 19
    Top = 252
    Width = 20
    Height = 13
    Caption = 'Titel'
  end
  object Label5: TLabel
    Left = 217
    Top = 3
    Width = 41
    Height = 13
    Caption = 'Gremium'
  end
  object Label6: TLabel
    Left = 16
    Top = 152
    Width = 45
    Height = 13
    Caption = 'Fristende'
  end
  object Label7: TLabel
    Left = 19
    Top = 200
    Width = 82
    Height = 13
    Caption = 'Bearbeitungsfrist'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 329
    Width = 538
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 329
    ExplicitWidth = 538
    inherited StatusBar1: TStatusBar
      Width = 538
      ExplicitWidth = 538
    end
    inherited Panel1: TPanel
      Width = 538
      ExplicitWidth = 538
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 450
        Top = 10
        Kind = bkCustom
        ModalResult = 0
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 450
        ExplicitTop = 10
      end
    end
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 16
    Top = 29
    Width = 184
    Height = 21
    DataField = 'TY_ID'
    DataSource = TaskSrc
    KeyField = 'TY_ID'
    ListField = 'TY_NAME'
    ListSource = TaskTypeSrc
    TabOrder = 1
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 75
    Width = 184
    Height = 21
    DataField = 'TA_CREATED_BY'
    DataSource = TaskSrc
    Enabled = False
    TabOrder = 2
  end
  object JvDBDateTimePicker1: TJvDBDateTimePicker
    Left = 16
    Top = 121
    Width = 184
    Height = 21
    Date = 43893.633508275460000000
    Time = 43893.633508275460000000
    TabOrder = 3
    OnChange = JvDBDateTimePicker1Change
    DropDownDate = 43893.000000000000000000
    DataField = 'TA_STARTED'
    DataSource = TaskSrc
  end
  object DBEdit2: TDBEdit
    Left = 19
    Top = 271
    Width = 506
    Height = 21
    DataField = 'TA_NAME'
    DataSource = TaskSrc
    TabOrder = 4
  end
  object JvDBDateTimePicker2: TJvDBDateTimePicker
    Left = 16
    Top = 171
    Width = 186
    Height = 21
    Date = 43895.375511296300000000
    Time = 43895.375511296300000000
    TabOrder = 5
    DropDownDate = 43895.000000000000000000
    DataField = 'TA_TERMIN'
    DataSource = TaskSrc
  end
  object DBEdit3: TDBEdit
    Left = 19
    Top = 219
    Width = 47
    Height = 21
    DataField = 'TY_TAGE'
    DataSource = TaskTypeSrc
    Enabled = False
    ReadOnly = True
    TabOrder = 6
  end
  object LV: TListView
    Left = 217
    Top = 30
    Width = 308
    Height = 210
    Columns = <
      item
        Caption = 'Kurz'
        Width = 75
      end
      item
        Caption = 'Name'
        Width = 200
      end>
    HideSelection = False
    ReadOnly = True
    RowSelect = True
    SortType = stText
    TabOrder = 7
    ViewStyle = vsReport
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTask'
    Left = 48
    Top = 8
  end
  object TaskTypes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTypes'
    RemoteServer = DSProviderConnection1
    Left = 136
    Top = 8
  end
  object TaskTypeSrc: TDataSource
    DataSet = TaskTypes
    Left = 136
    Top = 56
  end
  object Task: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Task'
    RemoteServer = DSProviderConnection1
    Left = 216
    Top = 8
  end
  object TaskSrc: TDataSource
    DataSet = Task
    Left = 216
    Top = 64
  end
end
