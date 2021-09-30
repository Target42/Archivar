object FileUploadForm: TFileUploadForm
  Left = 0
  Top = 0
  Caption = 'Datei upload'
  ClientHeight = 180
  ClientWidth = 514
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  DesignSize = (
    514
    180)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 463
    Top = 32
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = SpeedButton1Click
  end
  object Label1: TLabel
    Left = 16
    Top = 59
    Width = 53
    Height = 13
    Caption = 'Verzeichnis'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 120
    Width = 514
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 120
    ExplicitWidth = 514
    inherited StatusBar1: TStatusBar
      Width = 514
      ExplicitWidth = 514
    end
    inherited Panel1: TPanel
      Width = 514
      ExplicitWidth = 514
      inherited OKBtn: TBitBtn
        Left = 415
        Kind = bkCustom
        ModalResult = 0
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 415
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 441
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Datei'
    TabOrder = 1
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 78
    Width = 145
    Height = 21
    Sorted = True
    TabOrder = 2
    Text = 'ComboBox1'
    Items.Strings = (
      'dwslib')
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoFileMustExist]
    Left = 288
    Top = 8
  end
end
