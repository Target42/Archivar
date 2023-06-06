object MeetingFrame: TMeetingFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object Lv: TListView
    Left = 0
    Top = 0
    Width = 451
    Height = 305
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
      end
      item
        Caption = 'Einladender'
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
    PopupMenu = PopupMenu1
    TabOrder = 0
    ViewStyle = vsReport
    OnCustomDrawItem = LvCustomDrawItem
    OnCustomDrawSubItem = LvCustomDrawSubItem
    OnDblClick = LvDblClick
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
    Left = 80
    Top = 72
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 224
    Top = 64
  end
  object PopupMenu1: TPopupMenu
    Left = 384
    Top = 104
    object Bearbeiten1: TMenuItem
      Caption = 'Bearbeiten'
      OnClick = Bearbeiten1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Ausfhren1: TMenuItem
      Caption = 'Ausf'#252'hren'
      OnClick = Ausfhren1Click
    end
  end
end
