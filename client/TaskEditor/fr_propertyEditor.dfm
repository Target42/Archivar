object PropertyFrame: TPropertyFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 451
    Height = 81
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 47
      Height = 13
      Caption = 'Datenfeld'
    end
    object ComboBox1: TComboBox
      Left = 16
      Top = 35
      Width = 145
      Height = 21
      TabOrder = 0
      Text = 'ComboBox1'
    end
  end
  object VE: TValueListEditor
    Left = 0
    Top = 81
    Width = 451
    Height = 224
    Align = alClient
    DefaultColWidth = 100
    TabOrder = 1
    OnExit = VEExit
    OnKeyPress = VEKeyPress
    ExplicitTop = 89
    ExplicitHeight = 216
    ColWidths = (
      100
      345)
  end
end
