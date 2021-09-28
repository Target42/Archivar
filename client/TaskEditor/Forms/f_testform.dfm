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
    ExplicitWidth = 646
    inherited StatusBar1: TStatusBar
      Width = 646
      ExplicitWidth = 646
    end
    inherited Panel1: TPanel
      Width = 646
      ExplicitWidth = 646
      inherited AbortBtn: TBitBtn
        Top = 6
        ExplicitTop = 6
      end
      inherited OKBtn: TBitBtn
        Left = 542
        Top = 6
        ExplicitLeft = 542
        ExplicitTop = 6
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
    ExplicitWidth = 646
    ExplicitHeight = 555
    inherited ScrollBox1: TScrollBox
      Width = 646
      Height = 555
      ExplicitWidth = 646
      ExplicitHeight = 555
    end
  end
end
