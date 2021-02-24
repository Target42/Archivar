object MeetingForm: TMeetingForm
  Left = 0
  Top = 0
  Caption = 'Sitzungsplanung'
  ClientHeight = 557
  ClientWidth = 599
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
  object Splitter1: TSplitter
    Left = 0
    Top = 389
    Width = 599
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 105
    ExplicitWidth = 176
  end
  object Splitter2: TSplitter
    Left = 0
    Top = 137
    Width = 599
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitTop = 105
    ExplicitWidth = 173
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 497
    Width = 599
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 497
    ExplicitWidth = 599
    inherited StatusBar1: TStatusBar
      Width = 599
      ExplicitWidth = 599
    end
    inherited Panel1: TPanel
      Width = 599
      ExplicitWidth = 599
      inherited OKBtn: TBitBtn
        Left = 500
        ExplicitLeft = 500
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 599
    Height = 137
    Align = alTop
    Caption = 'Sitzungsdaten'
    TabOrder = 1
    object Label1: TLabel
      Left = 224
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Protokoll'
    end
    object Label2: TLabel
      Left = 16
      Top = 70
      Width = 31
      Height = 13
      Caption = 'Datum'
    end
    object Label3: TLabel
      Left = 224
      Top = 70
      Width = 34
      Height = 13
      Caption = 'Uhrzeit'
    end
    object Label4: TLabel
      Left = 303
      Top = 70
      Width = 24
      Height = 13
      Caption = 'Ende'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 43
      Width = 186
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'Gremium'
      ReadOnly = True
      TabOrder = 0
    end
    object DBLookupComboBox1: TDBLookupComboBox
      Left = 224
      Top = 43
      Width = 145
      Height = 21
      DataField = 'PR_ID'
      DataSource = ElSrc
      KeyField = 'PR_ID'
      ListField = 'PR_NAME'
      ListSource = ProcolSrc
      TabOrder = 1
    end
    object JvDBDateTimePicker1: TJvDBDateTimePicker
      Left = 16
      Top = 89
      Width = 186
      Height = 21
      Date = 44234.839669270830000000
      Time = 44234.839669270830000000
      TabOrder = 2
      DropDownDate = 44234.000000000000000000
      DataField = 'EL_DATUM'
      DataSource = ElSrc
    end
    object ComboBox1: TComboBox
      Left = 224
      Top = 89
      Width = 73
      Height = 21
      TabOrder = 3
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
    end
    object ComboBox2: TComboBox
      Left = 303
      Top = 89
      Width = 66
      Height = 21
      TabOrder = 4
      Text = 'ComboBox2'
    end
    object BitBtn1: TBitBtn
      Left = 392
      Top = 48
      Width = 75
      Height = 25
      Caption = 'BitBtn1'
      TabOrder = 5
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 140
    Width = 599
    Height = 249
    Align = alClient
    Caption = 'Tagesordnung'
    TabOrder = 2
    object Memo2: TMemo
      Left = 2
      Top = 15
      Width = 595
      Height = 232
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Memo2')
      ParentFont = False
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 392
    Width = 599
    Height = 105
    Align = alBottom
    Caption = 'Anmerkungen'
    TabOrder = 3
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 595
      Height = 88
      Align = alClient
      Lines.Strings = (
        'Memo1')
      TabOrder = 0
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMeeing'
    Left = 16
    Top = 128
  end
  object ElTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ElTab'
    RemoteServer = DSProviderConnection1
    BeforePost = ElTabBeforePost
    Left = 16
    Top = 192
  end
  object ElSrc: TDataSource
    DataSet = ElTab
    Left = 16
    Top = 244
  end
  object ProtoQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
    ProviderName = 'ListProtocolQry'
    RemoteServer = DSProviderConnection1
    Left = 72
    Top = 192
  end
  object ProcolSrc: TDataSource
    DataSet = ProtoQry
    Left = 72
    Top = 244
  end
end
