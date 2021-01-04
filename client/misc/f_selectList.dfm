object SelectListform: TSelectListform
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Auswahlliste'
  ClientHeight = 300
  ClientWidth = 281
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
    Top = 240
    Width = 281
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 240
    ExplicitWidth = 281
    inherited StatusBar1: TStatusBar
      Width = 281
      ExplicitWidth = 281
    end
    inherited Panel1: TPanel
      Width = 281
      ExplicitWidth = 281
      inherited OKBtn: TBitBtn
        Left = 182
        ExplicitLeft = 182
      end
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 0
    Width = 281
    Height = 199
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    OnClick = ListBox1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 199
    Width = 281
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object Edit1: TEdit
      Left = 16
      Top = 8
      Width = 252
      Height = 21
      TabOrder = 0
    end
  end
end
