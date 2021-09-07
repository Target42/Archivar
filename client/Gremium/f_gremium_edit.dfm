object GremiumEditForm: TGremiumEditForm
  Left = 0
  Top = 0
  ActiveControl = DBEdit2
  Caption = 'Gremium'
  ClientHeight = 213
  ClientWidth = 323
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
  object Label1: TLabel
    Left = 16
    Top = 53
    Width = 51
    Height = 13
    Caption = 'Abk'#252'rzung'
  end
  object Name: TLabel
    Left = 16
    Top = 7
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 17
    Top = 101
    Width = 42
    Height = 13
    Caption = 'Vorfahre'
  end
  object Label3: TLabel
    Left = 111
    Top = 50
    Width = 28
    Height = 13
    Caption = 'image'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 153
    Width = 323
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 3
    ExplicitTop = 153
    ExplicitWidth = 323
    inherited StatusBar1: TStatusBar
      Width = 323
      ExplicitWidth = 323
    end
    inherited Panel1: TPanel
      Width = 323
      ExplicitWidth = 323
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 235
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 235
      end
    end
  end
  object DBEdit1: TDBEdit
    Left = 16
    Top = 72
    Width = 75
    Height = 21
    DataField = 'GR_SHORT'
    DataSource = GTSrc
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 16
    Top = 26
    Width = 288
    Height = 21
    DataField = 'GR_NAME'
    DataSource = GTSrc
    TabOrder = 0
  end
  object DBComboBox1: TDBComboBox
    Left = 16
    Top = 120
    Width = 81
    Height = 21
    DataField = 'GR_PARENT_SHORT'
    DataSource = GTSrc
    TabOrder = 2
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 112
    Top = 69
    Width = 137
    Height = 21
    DataField = 'GR_PIC_NAME'
    DataSource = GTSrc
    KeyField = 'PI_NAME'
    ListField = 'PI_NAME'
    ListSource = ImageSrc
    TabOrder = 4
  end
  object DBImage1: TDBImage
    Left = 272
    Top = 61
    Width = 32
    Height = 32
    DataField = 'PI_DATA'
    DataSource = ImageSrc
    ReadOnly = True
    TabOrder = 5
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsGremium'
    Left = 56
    Top = 8
  end
  object GRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'GRTab'
    RemoteServer = DSProviderConnection1
    Left = 120
  end
  object GTSrc: TDataSource
    AutoEdit = False
    DataSet = GRTab
    Left = 184
    Top = 8
  end
  object Images: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Images'
    RemoteServer = DSProviderConnection1
    Left = 32
    Top = 72
  end
  object ImageSrc: TDataSource
    DataSet = Images
    Left = 80
    Top = 72
  end
end
