object WebFileForm: TWebFileForm
  Left = 0
  Top = 0
  Caption = 'Dateiupload'
  ClientHeight = 195
  ClientWidth = 361
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  DesignSize = (
    361
    195)
  PixelsPerInch = 96
  TextHeight = 13
  object SpeedButton1: TSpeedButton
    Left = 325
    Top = 31
    Width = 23
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    OnClick = SpeedButton1Click
    ExplicitLeft = 599
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
    Top = 135
    Width = 361
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 135
    ExplicitWidth = 361
    inherited StatusBar1: TStatusBar
      Width = 361
      ExplicitWidth = 361
    end
    inherited Panel1: TPanel
      Width = 361
      ExplicitWidth = 361
      inherited OKBtn: TBitBtn
        Left = 262
        ExplicitLeft = 262
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 295
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
    Width = 321
    Height = 21
    TabOrder = 2
    Text = 'ComboBox1'
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoFileMustExist]
    Left = 168
    Top = 16
  end
end
