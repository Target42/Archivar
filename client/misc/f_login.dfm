object LoginForm: TLoginForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Anmeldung'
  ClientHeight = 224
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
  object Label1: TLabel
    Left = 16
    Top = 37
    Width = 43
    Height = 13
    Caption = 'Benutzer'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 120
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
    Top = 164
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
  object LabeledEdit1: TComboBox
    Left = 16
    Top = 72
    Width = 193
    Height = 21
    TabOrder = 0
    Text = 'Admin'
    Items.Strings = (
      'admin'
      'npn2hi'
      'bmn2hi'
      'abn2hi'
      'rke2hi'
      'pbr2hi'
      'sfa2hi'
      'rce2gi'
      'ird2hi'
      'ole2hi'
      'bss2hi'
      'abe2hi'
      'eol2hi'
      'sao2hi'
      'rfc2hi'
      'asy2hi'
      'dhy2hi'
      'steph'
      'dln2hi'
      'mwe2hi'
      'chn2hi')
  end
  object LabeledEdit3: TLabeledEdit
    Left = 16
    Top = 32
    Width = 193
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'Host'
    TabOrder = 3
    Text = 'localhost'
  end
end
