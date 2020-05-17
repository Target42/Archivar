object FormProperties: TFormProperties
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Formulareigenschaften'
  ClientHeight = 159
  ClientWidth = 336
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
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 193
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 0
  end
  object CheckBox1: TCheckBox
    Left = 224
    Top = 26
    Width = 97
    Height = 17
    Caption = 'Hauptformluar'
    TabOrder = 1
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 99
    Width = 336
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 2
    ExplicitTop = 99
    ExplicitWidth = 336
    inherited StatusBar1: TStatusBar
      Width = 336
      ExplicitWidth = 336
    end
    inherited Panel1: TPanel
      Width = 336
      ExplicitWidth = 336
      inherited OKBtn: TBitBtn
        Left = 237
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 237
      end
    end
  end
end
