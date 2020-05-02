object BaseFrame: TBaseFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 60
  Align = alBottom
  AutoSize = True
  TabOrder = 0
  object StatusBar1: TStatusBar
    Left = 0
    Top = 41
    Width = 451
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      451
      41)
    object AbortBtn: TBitBtn
      Left = 16
      Top = 8
      Width = 89
      Height = 25
      Kind = bkAbort
      NumGlyphs = 2
      TabOrder = 0
    end
    object OKBtn: TBitBtn
      Left = 352
      Top = 8
      Width = 86
      Height = 25
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
    end
  end
end
