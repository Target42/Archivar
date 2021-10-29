object InputBoxForm: TInputBoxForm
  Left = 0
  Top = 0
  ActiveControl = Edit1
  BorderStyle = bsDialog
  Caption = 'Eingabe'
  ClientHeight = 125
  ClientWidth = 316
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 65
    Width = 316
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 65
    ExplicitWidth = 316
    inherited StatusBar1: TStatusBar
      Width = 316
      ExplicitWidth = 316
    end
    inherited Panel1: TPanel
      Width = 316
      ExplicitWidth = 316
      inherited OKBtn: TBitBtn
        Left = 217
        ExplicitLeft = 217
      end
    end
  end
  object Edit1: TEdit
    Left = 16
    Top = 16
    Width = 277
    Height = 21
    TabOrder = 1
    OnKeyPress = Edit1KeyPress
  end
end
