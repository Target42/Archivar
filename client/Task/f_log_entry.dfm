object LogEntryform: TLogEntryform
  Left = 0
  Top = 0
  Caption = 'Log-Eintrag'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    Caption = 'Kommentar'
    TabOrder = 0
    ExplicitLeft = 144
    ExplicitTop = 72
    ExplicitWidth = 185
    ExplicitHeight = 105
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 631
      Height = 222
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitLeft = 184
    ExplicitTop = 216
    inherited StatusBar1: TStatusBar
      Width = 635
    end
    inherited Panel1: TPanel
      Width = 635
      inherited OKBtn: TBitBtn
        Left = 536
      end
    end
  end
end
