object PassWdform: TPassWdform
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Passwort'
  ClientHeight = 126
  ClientWidth = 285
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
  object Edit1: TEdit
    Left = 32
    Top = 16
    Width = 217
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 66
    Width = 285
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitLeft = 184
    ExplicitTop = 152
    inherited StatusBar1: TStatusBar
      Width = 285
      ExplicitWidth = 275
    end
    inherited Panel1: TPanel
      Width = 285
      inherited OKBtn: TBitBtn
        Left = 186
      end
    end
  end
end
