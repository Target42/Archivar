object ReportFrameEditor: TReportFrameEditor
  Left = 0
  Top = 0
  Width = 484
  Height = 389
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 484
    Height = 21
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      AlignWithMargins = True
      Left = 458
      Top = 1
      Width = 23
      Height = 19
      Margins.Top = 1
      Margins.Bottom = 1
      Align = alRight
      Caption = 'X'
      OnClick = SpeedButton1Click
      ExplicitLeft = 461
      ExplicitTop = 0
      ExplicitHeight = 21
    end
  end
end
