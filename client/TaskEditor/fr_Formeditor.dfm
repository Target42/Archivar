object EditorFrame: TEditorFrame
  Left = 0
  Top = 0
  Width = 775
  Height = 558
  Align = alClient
  TabOrder = 0
  OnMouseDown = FrameMouseDown
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 558
    Align = alLeft
    Caption = 'Struktur'
    TabOrder = 0
    ExplicitHeight = 305
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 181
      Height = 541
      Align = alClient
      DragMode = dmAutomatic
      HideSelection = False
      Indent = 19
      TabOrder = 0
      OnChange = TVChange
      OnDragDrop = TVDragDrop
      OnDragOver = TVDragOver
      ExplicitHeight = 288
    end
  end
  object Panel1: TPanel
    Left = 590
    Top = 0
    Width = 185
    Height = 558
    Align = alRight
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 266
    ExplicitHeight = 305
    object GroupBox1: TGroupBox
      Left = 1
      Top = 312
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
        ExplicitHeight = 180
      end
    end
  end
  object EditPanel: TPanel
    Left = 185
    Top = 0
    Width = 405
    Height = 558
    Align = alClient
    Caption = 'EditPanel'
    Color = 16776176
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    OnMouseDown = EditPanelMouseDown
    ExplicitWidth = 81
    ExplicitHeight = 305
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 96
    Top = 96
  end
end
