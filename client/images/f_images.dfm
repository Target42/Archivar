object ImagesForm: TImagesForm
  Left = 0
  Top = 0
  Caption = 'Bilder'
  ClientHeight = 412
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 352
    Width = 571
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 352
    ExplicitWidth = 571
    inherited StatusBar1: TStatusBar
      Width = 571
      ExplicitWidth = 571
    end
    inherited Panel1: TPanel
      Width = 571
      ExplicitWidth = 571
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 483
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 483
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 571
    Height = 296
    Align = alClient
    DataSource = PicSrc
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
        FieldName = 'PI_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PI_MD5'
        Title.Caption = 'MD5'
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 296
    Width = 571
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    DesignSize = (
      571
      56)
    object Hinzufügen: TBitBtn
      Left = 16
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Hinzuf'#252'gen'
      TabOrder = 0
      OnClick = HinzufügenClick
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'L'#246'schen'
      TabOrder = 1
      OnClick = BitBtn1Click
    end
    object DBImage1: TDBImage
      Left = 248
      Top = 6
      Width = 32
      Height = 32
      DataField = 'PI_DATA'
      DataSource = PicSrc
      Proportional = True
      ReadOnly = True
      TabOrder = 2
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsImage'
    Left = 64
    Top = 40
  end
  object PicTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PicturesTab'
    RemoteServer = DSProviderConnection1
    Left = 128
    Top = 104
  end
  object PicSrc: TDataSource
    DataSet = PicTab
    Left = 192
    Top = 104
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'PNG (*.png)|*.png'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Title = 'Bild laden'
    Left = 48
    Top = 232
  end
end
