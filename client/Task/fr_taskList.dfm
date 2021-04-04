object TaskListFrame: TTaskListFrame
  Left = 0
  Top = 0
  Width = 859
  Height = 290
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object LV: TListView
    Left = 0
    Top = 0
    Width = 859
    Height = 290
    Align = alClient
    Columns = <
      item
        Caption = 'Titel'
        Width = 150
      end
      item
        Caption = 'Termin'
        Width = 75
      end
      item
        Caption = 'Verbleiben'
        Width = 100
      end
      item
        Caption = 'Typ'
        Width = 100
      end
      item
        Caption = 'Erzeugt'
        Width = 75
      end
      item
        Caption = 'Eingang'
        Width = 75
      end
      item
        Caption = 'Status'
        Width = 100
      end
      item
        Caption = 'Kommentar'
        Width = 250
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnColumnClick = LVColumnClick
    OnCustomDrawItem = LVCustomDrawItem
    OnCustomDrawSubItem = LVCustomDrawSubItem
    OnDblClick = LVDblClick
    OnKeyUp = DBGrid1KeyUp
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 376
    Top = 56
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMisc'
    Left = 72
    Top = 16
  end
  object Tasks: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
    ProviderName = 'OpenTaskQry'
    RemoteServer = DSProviderConnection1
    Left = 144
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 112
    object Verschieben1: TMenuItem
      Action = av_move
    end
    object Lschen1: TMenuItem
      Action = av_delete
    end
  end
  object ActionList1: TActionList
    Left = 200
    Top = 136
    object av_move: TAction
      Caption = 'Verschieben'
      OnExecute = av_moveExecute
    end
    object av_delete: TAction
      Caption = '&L'#246'schen'
      OnExecute = av_deleteExecute
    end
  end
end
