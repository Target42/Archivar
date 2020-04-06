object GremiumForm: TGremiumForm
  Left = 0
  Top = 0
  Caption = 'Gremien'
  ClientHeight = 325
  ClientWidth = 571
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
  inline Frame11: TBaseFrame
    Left = 0
    Top = 265
    Width = 571
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 265
    ExplicitWidth = 571
    inherited StatusBar1: TStatusBar
      Width = 571
      ExplicitWidth = 571
    end
    inherited Panel1: TPanel
      Width = 571
      ExplicitWidth = 571
      inherited OKBtn: TBitBtn
        Left = 483
        ExplicitLeft = 483
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 200
    Width = 571
    Height = 65
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    DesignSize = (
      571
      65)
    object BitBtn1: TBitBtn
      Left = 483
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Import'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Neu'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 112
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Bearbeiten'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object Button1: TButton
      Left = 240
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Mitglieder'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 571
    Height = 200
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'GR_SHORT'
        Title.Caption = 'K'#252'rzel'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_PARENT_SHORT'
        Title.Caption = #220'bergeordnet'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_PIC_NAME'
        Title.Caption = 'Image'
        Width = 150
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsGremium'
    SQLConnection = GM.SQLConnection1
    Left = 64
    Top = 40
  end
  object GRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'GRTab'
    RemoteServer = DSProviderConnection1
    Left = 200
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = GRTab
    Left = 320
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'csb'
    Filter = 'CSV (*.csv)|*.csv|Alle Dateien (*.*)|*-*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Gremium importieren'
    Left = 40
    Top = 128
  end
end
