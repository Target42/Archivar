object GremiumListForm: TGremiumListForm
  Left = 0
  Top = 0
  Caption = 'Gremien'
  ClientHeight = 302
  ClientWidth = 329
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 242
    Width = 329
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 242
    ExplicitWidth = 329
    inherited StatusBar1: TStatusBar
      Width = 329
      ExplicitWidth = 329
    end
    inherited Panel1: TPanel
      Width = 329
      ExplicitWidth = 329
      inherited OKBtn: TBitBtn
        Left = 241
        ExplicitLeft = 241
      end
    end
  end
  inline GremiumFrame1: TGremiumFrame
    Left = 0
    Top = 0
    Width = 329
    Height = 242
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 329
    ExplicitHeight = 242
    inherited TV: TTreeView
      Width = 329
      Height = 242
      OnDblClick = GremiumFrame1TVDblClick
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 329
      ExplicitHeight = 242
    end
  end
end
