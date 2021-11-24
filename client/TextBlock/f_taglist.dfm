object TagListForm: TTagListForm
  Left = 0
  Top = 0
  Caption = 'Tags'
  ClientHeight = 299
  ClientWidth = 297
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object LB: TListBox
    Left = 0
    Top = 0
    Width = 297
    Height = 239
    Align = alClient
    ItemHeight = 13
    MultiSelect = True
    TabOrder = 0
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 297
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 239
    ExplicitWidth = 297
    inherited StatusBar1: TStatusBar
      Width = 297
      ExplicitWidth = 297
    end
    inherited Panel1: TPanel
      Width = 297
      ExplicitWidth = 297
      inherited OKBtn: TBitBtn
        Left = 198
        ExplicitLeft = 198
      end
    end
  end
end
