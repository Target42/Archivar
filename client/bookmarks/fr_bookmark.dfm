object BookmarkFrame: TBookmarkFrame
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
        Caption = 'Titel'
        Width = 250
      end>
    Groups = <
      item
        GroupID = 0
        State = [lgsNormal]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    GroupView = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = LVDblClick
    OnKeyDown = LVKeyDown
    OnKeyUp = LVKeyUp
  end
  object PopupMenu1: TPopupMenu
    Left = 136
    Top = 160
    object ffnen1: TMenuItem
      Action = ac_open
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Lschen1: TMenuItem
      Action = ac_delete
    end
  end
  object ActionList1: TActionList
    Left = 256
    Top = 152
    object ac_open: TAction
      Caption = #214'ffnen'
      OnExecute = ac_openExecute
    end
    object ac_delete: TAction
      Caption = 'L'#246'schen'
      OnExecute = ac_deleteExecute
    end
  end
end
