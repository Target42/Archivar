object TaskFilterForm: TTaskFilterForm
  Left = 0
  Top = 0
  Caption = 'Filter'
  ClientHeight = 216
  ClientWidth = 323
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 156
    Width = 323
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 128
    inherited StatusBar1: TStatusBar
      Width = 323
      ExplicitWidth = 324
    end
    inherited Panel1: TPanel
      Width = 323
      inherited OKBtn: TBitBtn
        Left = 224
      end
    end
  end
  object LB: TCheckListBox
    Left = 0
    Top = 0
    Width = 323
    Height = 156
    Align = alClient
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
end
