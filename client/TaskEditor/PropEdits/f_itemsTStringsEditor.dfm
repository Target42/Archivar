object StringEditorForm: TStringEditorForm
  Left = 0
  Top = 0
  Caption = 'Text'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 104
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
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    Lines.Strings = (
      'Memo1')
    ScrollBars = ssVertical
    TabOrder = 1
  end
end
