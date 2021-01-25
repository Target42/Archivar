object epubform: Tepubform
  Left = 0
  Top = 0
  Caption = 'eBook-Reader'
  ClientHeight = 299
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 217
    Top = 0
    Height = 280
    ExplicitLeft = 472
    ExplicitTop = 112
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
    ExplicitLeft = 424
    ExplicitTop = 184
    ExplicitWidth = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 217
    Height = 280
    Align = alLeft
    Caption = 'Inhalt'
    TabOrder = 1
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 213
      Height = 263
      Align = alClient
      Indent = 19
      TabOrder = 0
      OnChange = TVChange
      ExplicitLeft = 48
      ExplicitTop = 48
      ExplicitWidth = 121
      ExplicitHeight = 97
    end
  end
  object WebBrowser1: TWebBrowser
    AlignWithMargins = True
    Left = 226
    Top = 6
    Width = 403
    Height = 271
    Margins.Left = 6
    Margins.Top = 6
    Margins.Right = 6
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 264
    ExplicitTop = 32
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000A7290000021C00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
