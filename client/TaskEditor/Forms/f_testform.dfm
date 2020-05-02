object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'Testformular'
  ClientHeight = 615
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 555
    Width = 802
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 179
    ExplicitTop = 80
    ExplicitWidth = 802
    inherited StatusBar1: TStatusBar
      Width = 802
      ExplicitWidth = 802
    end
    inherited Panel1: TPanel
      Width = 802
      ExplicitWidth = 802
      inherited OKBtn: TBitBtn
        Left = 714
        ExplicitLeft = 363
      end
    end
  end
  object ScrollBox1: TScrollBox
    Left = 0
    Top = 0
    Width = 802
    Height = 555
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 800
    ExplicitHeight = 356
  end
end
