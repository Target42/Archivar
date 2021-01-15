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
  Menu = MainMenu1
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
  object PrintDialog1: TPrintDialog
    Left = 320
    Top = 72
  end
  object MainMenu1: TMainMenu
    Left = 104
    Top = 64
    object Protokoll1: TMenuItem
      Caption = '&Protokoll'
      GroupIndex = 100
      object Drucken1: TMenuItem
        Caption = 'Drucken'
        ShortCut = 16464
        OnClick = Drucken1Click
      end
      object Speichernals1: TMenuItem
        Caption = 'Speichern als'
        OnClick = Speichernals1Click
      end
    end
  end
end
