object StoragesFrame: TStoragesFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object LV: TListView
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 200
      end>
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = LVDblClick
  end
  object PopupMenu1: TPopupMenu
    Left = 264
    Top = 120
    object ffnen1: TMenuItem
      Action = ac_open
    end
  end
  object ActionList1: TActionList
    Left = 312
    Top = 216
    object ac_open: TAction
      Caption = #214'ffnen'
      OnExecute = ac_openExecute
    end
  end
end
