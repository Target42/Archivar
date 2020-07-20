object ListBoxForm: TListBoxForm
  Left = 0
  Top = 0
  Caption = 'List'
  ClientHeight = 282
  ClientWidth = 260
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
    Top = 222
    Width = 260
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 222
    ExplicitWidth = 260
    inherited StatusBar1: TStatusBar
      Width = 260
      ExplicitWidth = 260
    end
    inherited Panel1: TPanel
      Width = 260
      ExplicitWidth = 260
      inherited OKBtn: TBitBtn
        Left = 161
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 161
      end
    end
  end
  object LB: TListBox
    Left = 0
    Top = 0
    Width = 260
    Height = 222
    Align = alClient
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
  end
end
