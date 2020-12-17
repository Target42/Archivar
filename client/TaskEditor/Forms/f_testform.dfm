object TestForm: TTestForm
  Left = 0
  Top = 0
  Caption = 'Testformular'
  ClientHeight = 615
  ClientWidth = 646
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
    Width = 646
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 555
    ExplicitWidth = 802
    inherited StatusBar1: TStatusBar
      Width = 646
      ExplicitWidth = 638
    end
    inherited Panel1: TPanel
      Width = 646
      ExplicitWidth = 802
      inherited OKBtn: TBitBtn
        Left = 558
        ExplicitLeft = 714
      end
    end
  end
  inline FormFrame1: TFormFrame
    Left = 0
    Top = 0
    Width = 646
    Height = 555
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 802
    ExplicitHeight = 555
    inherited ScrollBox1: TScrollBox
      Width = 646
      Height = 555
      ExplicitWidth = 802
      ExplicitHeight = 555
    end
  end
end
