object UnusedTaskListFrame: TUnusedTaskListFrame
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
    Checkboxes = True
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
      end>
    DoubleBuffered = True
    GridLines = True
    ReadOnly = True
    RowSelect = True
    ParentDoubleBuffered = False
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = LVCustomDrawItem
    OnCustomDrawSubItem = LVCustomDrawSubItem
    OnDblClick = LVDblClick
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTask'
    Left = 72
    Top = 16
  end
  object UnusedQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
    ProviderName = 'UnusedQry'
    RemoteServer = DSProviderConnection1
    Left = 176
    Top = 32
  end
end
