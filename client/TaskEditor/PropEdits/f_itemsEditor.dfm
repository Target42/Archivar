object ItemsEditorForm: TItemsEditorForm
  Left = 0
  Top = 0
  Caption = 'Eintr'#228'ge'
  ClientHeight = 210
  ClientWidth = 321
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
    Top = 150
    Width = 321
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 150
    ExplicitWidth = 321
    inherited StatusBar1: TStatusBar
      Width = 321
      ExplicitWidth = 321
    end
    inherited Panel1: TPanel
      Width = 321
      ExplicitWidth = 321
      inherited OKBtn: TBitBtn
        Left = 233
        ExplicitLeft = 233
      end
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 321
    Height = 150
    Align = alClient
    TabOrder = 1
  end
end
