object PropertyFrame: TPropertyFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object VE: TValueListEditor
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    DefaultColWidth = 100
    TabOrder = 0
    OnEditButtonClick = VEEditButtonClick
    OnExit = VEExit
    OnKeyPress = VEKeyPress
    ColWidths = (
      100
      345)
  end
end
