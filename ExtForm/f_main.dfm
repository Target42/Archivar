object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Button1: TButton
      Left = 224
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button1'
      TabOrder = 0
      OnClick = Button1Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 41
    Width = 635
    Height = 198
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  object Panel3: TPanel
    Left = 0
    Top = 239
    Width = 635
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 3
  end
end
