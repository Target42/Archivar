object MeetingFrame: TMeetingFrame
  Left = 0
  Top = 0
  Width = 744
  Height = 340
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Lv: TListView
    Left = 0
    Top = 0
    Width = 744
    Height = 340
    Align = alClient
    Columns = <
      item
        Caption = 'Datum'
        Width = 75
      end
      item
        Caption = 'Zeit'
        Width = 75
      end
      item
        Caption = 'Titel'
        Width = 200
      end
      item
        Caption = 'Ende'
        Width = 75
      end
      item
        Caption = 'Letzte '#196'nderung'
        Width = 150
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = LvCustomDrawItem
    OnCustomDrawSubItem = LvCustomDrawSubItem
    OnDblClick = LvDblClick
    ExplicitWidth = 451
    ExplicitHeight = 305
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMisc'
    Left = 72
    Top = 16
  end
  object MeetingQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end>
    ProviderName = 'MeetingQry'
    RemoteServer = DSProviderConnection1
    Left = 72
    Top = 72
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 224
    Top = 64
  end
end