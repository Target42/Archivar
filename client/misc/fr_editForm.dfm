object EditFrame: TEditFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object RE: TRichEdit
    Left = 0
    Top = 49
    Width = 451
    Height = 256
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    HideSelection = False
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    Zoom = 100
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 451
    Height = 49
    Align = alTop
    Caption = 'Aktionen'
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 3
      Top = 21
      Width = 23
      Height = 22
      OnClick = SpeedButton1Click
    end
  end
end
