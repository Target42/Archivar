object MeetingFrame: TMeetingFrame
  Left = 0
  Top = 0
  Width = 827
  Height = 290
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Lv: TListView
    Left = 0
    Top = 0
    Width = 827
    Height = 290
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
        Width = 150
      end
      item
        Caption = 'Ende'
      end
      item
        Caption = 'Letzte '#196'nderung'
        Width = 150
      end
      item
        Caption = 'Status'
        Width = 100
      end
      item
        Caption = 'Gelesen'
        Width = 150
      end>
    Groups = <
      item
        Header = 'Laufend'
        GroupID = 1
        State = [lgsNormal, lgsCollapsible]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end
      item
        Header = 'Geplant'
        GroupID = 0
        State = [lgsNormal, lgsCollapsible]
        HeaderAlign = taLeftJustify
        FooterAlign = taLeftJustify
        TitleImage = -1
      end>
    GroupView = True
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
