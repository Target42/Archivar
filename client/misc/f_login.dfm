object LoginForm: TLoginForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Anmeldung'
  ClientHeight = 183
  ClientWidth = 240
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 193
    Height = 21
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = 'Benutzer'
    TabOrder = 0
    Text = 'Admin'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 72
    Width = 193
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Password'
    PasswordChar = '*'
    TabOrder = 1
    Text = 'admin'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 123
    Width = 240
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 2
    ExplicitTop = 123
    ExplicitWidth = 240
    inherited StatusBar1: TStatusBar
      Width = 240
      ExplicitWidth = 240
    end
    inherited Panel1: TPanel
      Width = 240
      ExplicitWidth = 240
      inherited OKBtn: TBitBtn
        Left = 141
        ExplicitLeft = 141
      end
    end
  end
end
