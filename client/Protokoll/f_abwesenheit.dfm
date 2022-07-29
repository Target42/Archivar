object AbwesenForm: TAbwesenForm
  Left = 0
  Top = 0
  Caption = 'Abwesenheit'
  ClientHeight = 174
  ClientWidth = 256
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
  object Label1: TLabel
    Left = 16
    Top = 56
    Width = 29
    Height = 13
    Caption = 'Grund'
  end
  object Label2: TLabel
    Left = 16
    Top = 8
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 114
    Width = 256
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 114
    ExplicitWidth = 248
    inherited StatusBar1: TStatusBar
      Width = 256
      ExplicitWidth = 255
    end
    inherited Panel1: TPanel
      Width = 256
      ExplicitWidth = 248
      inherited OKBtn: TBitBtn
        Left = 157
        ExplicitLeft = 149
      end
    end
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 75
    Width = 227
    Height = 21
    TabOrder = 1
    Text = 'Krankheit'
    Items.Strings = (
      'Krankheit'
      'Urlaub'
      'Elternzeit'
      'Schulung'
      'Verpflichtungen a.d. Beriebsratsamt'
      'Privat')
  end
  object ComboBox2: TComboBox
    Left = 16
    Top = 29
    Width = 227
    Height = 21
    TabOrder = 2
    Text = 'ComboBox2'
    OnChange = ComboBox2Change
  end
end
