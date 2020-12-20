object TextBlockFrame: TTextBlockFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object Panel1: TPanel
    Left = 0
    Top = 249
    Width = 451
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    DesignSize = (
      451
      56)
    object LabeledEdit1: TLabeledEdit
      Left = 8
      Top = 24
      Width = 436
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Tag-Filter'
      TabOrder = 0
      OnKeyPress = LabeledEdit1KeyPress
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 451
    Height = 249
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 100
      end
      item
        Caption = 'Tags'
        Width = 150
      end>
    DragMode = dmAutomatic
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    OnDragOver = LVDragOver
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTextBlock'
    Left = 96
    Top = 40
  end
  object TBTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TBTab'
    RemoteServer = DSProviderConnection1
    Left = 96
    Top = 96
  end
end
