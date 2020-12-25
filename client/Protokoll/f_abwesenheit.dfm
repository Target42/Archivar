object AbwesenForm: TAbwesenForm
  Left = 0
  Top = 0
  Caption = 'Abwesenheit'
  ClientHeight = 148
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 29
    Height = 13
    Caption = 'Grund'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 88
    Width = 248
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 88
    ExplicitWidth = 248
    inherited StatusBar1: TStatusBar
      Width = 248
      ExplicitWidth = 248
    end
    inherited Panel1: TPanel
      Width = 248
      ExplicitWidth = 248
      inherited OKBtn: TBitBtn
        Left = 149
        ExplicitLeft = 149
      end
    end
  end
  object ComboBox1: TComboBox
    Left = 16
    Top = 32
    Width = 217
    Height = 21
    ItemIndex = 0
    TabOrder = 1
    Text = 'Krankheit'
    Items.Strings = (
      'Krankheit'
      'Urlaub'
      'Elternzeit'
      'Schulung'
      'Verpflichtungen a.d. Beriebsratsamt')
  end
end
