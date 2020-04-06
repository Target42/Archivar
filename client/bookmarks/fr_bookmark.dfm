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
    SortType = stText
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = LVDblClick
  end
end
