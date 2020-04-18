object EditorFrame: TEditorFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  OnMouseDown = FrameMouseDown
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 305
    Align = alLeft
    Caption = 'Struktur'
    TabOrder = 0
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 181
      Height = 288
      Align = alClient
      DragMode = dmAutomatic
      HideSelection = False
      Indent = 19
      TabOrder = 0
      OnChange = TVChange
      OnDragDrop = TVDragDrop
      OnDragOver = TVDragOver
    end
  end
  object Panel1: TPanel
    Left = 266
    Top = 0
    Width = 185
    Height = 305
    Align = alRight
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 1
      Top = 59
      Width = 183
      Height = 245
      Align = alBottom
      Caption = 'Controls'
      TabOrder = 0
      object LV: TListView
        Left = 2
        Top = 15
        Width = 179
        Height = 228
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 100
          end>
        GroupView = True
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = LVClick
        OnKeyPress = LVKeyPress
      end
    end
  end
  object EditPanel: TPanel
    Left = 185
    Top = 0
    Width = 81
    Height = 305
    Align = alClient
    Caption = 'EditPanel'
    Color = 16776176
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    OnMouseDown = EditPanelMouseDown
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 96
    Top = 96
  end
end
