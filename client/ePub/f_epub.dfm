object epubform: Tepubform
  Left = 0
  Top = 0
  Caption = 'eBook-Reader'
  ClientHeight = 439
  ClientWidth = 871
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 305
    Top = 0
    Height = 420
    ExplicitLeft = 472
    ExplicitTop = 112
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 420
    Width = 871
    Height = 19
    Panels = <>
    ExplicitTop = 280
    ExplicitWidth = 635
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 420
    Align = alLeft
    Caption = 'Inhalt'
    TabOrder = 1
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 301
      Height = 403
      Align = alClient
      Indent = 19
      TabOrder = 0
      OnChange = TVChange
      ExplicitWidth = 213
      ExplicitHeight = 263
    end
  end
  object WebBrowser1: TWebBrowser
    AlignWithMargins = True
    Left = 320
    Top = 12
    Width = 539
    Height = 405
    Margins.Left = 12
    Margins.Top = 12
    Margins.Right = 12
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 264
    ExplicitTop = 32
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000B5370000DC2900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
