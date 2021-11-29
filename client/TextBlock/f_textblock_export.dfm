object TextBlockExportForm: TTextBlockExportForm
  Left = 0
  Top = 0
  Caption = 'Textblock export'
  ClientHeight = 453
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 280
    Align = alClient
    DataSource = TBSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'TB_NAME'
        Title.Caption = 'Name'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TB_TAGS'
        Title.Caption = 'Tags'
        Width = 250
        Visible = True
      end>
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 393
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 393
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
        Default = False
        Kind = bkCustom
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 536
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 346
    Width = 635
    Height = 47
    Align = alBottom
    Caption = 'Ausgabeverzeichnis'
    TabOrder = 2
    DesignSize = (
      635
      47)
    object SpeedButton1: TSpeedButton
      Left = 599
      Top = 16
      Width = 23
      Height = 22
      Anchors = [akTop, akRight]
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 16
      Width = 577
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 0
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 280
    Width = 635
    Height = 66
    Align = alBottom
    Caption = 'Filter'
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Alle'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 97
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Keine'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 178
      Top = 24
      Width = 151
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'Namensfilter'
      TabOrder = 2
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit2: TLabeledEdit
      Left = 352
      Top = 24
      Width = 121
      Height = 21
      EditLabel.Width = 40
      EditLabel.Height = 13
      EditLabel.Caption = 'Tagfilter'
      TabOrder = 3
      OnKeyPress = LabeledEdit1KeyPress
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTextBlock'
    Left = 48
    Top = 40
  end
  object TBtab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TBTab'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 96
  end
  object TBSrc: TDataSource
    DataSet = TBtab
    Left = 128
    Top = 96
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    RootDirectory = fdMyDocuments
    Title = 'Exportverzeichnis w'#228'hlen'
    Left = 520
    Top = 80
  end
end
