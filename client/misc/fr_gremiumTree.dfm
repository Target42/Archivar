object GremiumTreeFrame: TGremiumTreeFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object TV: TTreeView
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    DragMode = dmAutomatic
    HideSelection = False
    Indent = 19
    PopupMenu = PopupMenu1
    ReadOnly = True
    SortType = stText
    TabOrder = 0
    OnClick = TVClick
    OnDragOver = TVDragOver
  end
  object DSProviderConnection1: TDSProviderConnection
    Left = 48
    Top = 24
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    Top = 152
    object Ablageffnen1: TMenuItem
      Caption = 'Ablage '#246'ffnen'
      OnClick = Ablageffnen1Click
    end
  end
end
