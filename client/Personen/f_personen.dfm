object PersonenForm: TPersonenForm
  Left = 0
  Top = 0
  Caption = 'Personen'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
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
      ExplicitTop = -6
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 547
        ExplicitLeft = 547
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 168
    Width = 635
    Height = 71
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    DesignSize = (
      635
      71)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Neu'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 112
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Bearbeiten'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 547
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Import'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 168
    Align = alClient
    DataSource = PESrc
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
  object OpenDialog1: TOpenDialog
    DefaultExt = 'csb'
    Filter = 'CSV (*.csv)|*.csv|Alle Dateien (*.*)|*-*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Personen importieren'
    Left = 288
    Top = 192
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsPerson'
    Left = 56
    Top = 32
  end
  object PETab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PETab'
    RemoteServer = DSProviderConnection1
    Left = 168
    Top = 24
  end
  object PESrc: TDataSource
    DataSet = PETab
    Left = 224
    Top = 32
  end
end
