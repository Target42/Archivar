object ProtokollViewForm: TProtokollViewForm
  Left = 0
  Top = 0
  Caption = 'Protkoll'
  ClientHeight = 402
  ClientWidth = 627
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 383
    Width = 627
    Height = 19
    Panels = <>
    ExplicitLeft = 464
    ExplicitTop = 88
    ExplicitWidth = 0
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 0
    Width = 627
    Height = 383
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 96
    ExplicitTop = 48
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000CD400000962700000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
end
