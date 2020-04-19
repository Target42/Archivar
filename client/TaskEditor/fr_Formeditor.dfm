object EditorFrame: TEditorFrame
  Left = 0
  Top = 0
  Width = 876
  Height = 466
  Align = alClient
  TabOrder = 0
  OnMouseDown = FrameMouseDown
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Splitter2: TSplitter
    Left = 185
    Top = 0
    Height = 466
    ExplicitLeft = 296
    ExplicitTop = 48
    ExplicitHeight = 100
  end
  object Splitter3: TSplitter
    Left = 688
    Top = 0
    Height = 466
    Align = alRight
    ExplicitLeft = 312
    ExplicitTop = 88
    ExplicitHeight = 100
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 466
    Align = alLeft
    Caption = 'Struktur'
    Enabled = False
    TabOrder = 0
    ExplicitHeight = 305
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 181
      Height = 449
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
    Left = 691
    Top = 0
    Width = 185
    Height = 466
    Align = alRight
    Caption = 'Panel1'
    Enabled = False
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 266
    ExplicitHeight = 305
    object Splitter1: TSplitter
      Left = 1
      Top = 246
      Width = 183
      Height = 219
      Align = alClient
      ExplicitLeft = 88
      ExplicitTop = 264
      ExplicitWidth = 3
      ExplicitHeight = 100
    end
    object GroupBox1: TGroupBox
      Left = 1
      Top = 1
      Width = 183
      Height = 245
      Align = alTop
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
    inline PropertyFrame1: TPropertyFrame
      Left = 1
      Top = 246
      Width = 183
      Height = 219
      Align = alClient
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 246
      ExplicitWidth = 183
      ExplicitHeight = 58
      inherited Panel1: TPanel
        Width = 183
        ExplicitWidth = 183
      end
      inherited VE: TValueListEditor
        Width = 183
        Height = 138
        ExplicitTop = 81
        ExplicitWidth = 183
        ExplicitHeight = 208
        ColWidths = (
          100
          77)
      end
    end
  end
  object EditPanel: TPanel
    Left = 188
    Top = 0
    Width = 500
    Height = 466
    Align = alClient
    Caption = 'EditPanel'
    Color = 16776176
    ParentBackground = False
    ShowCaption = False
    TabOrder = 2
    OnMouseDown = EditPanelMouseDown
    ExplicitLeft = 369
    ExplicitTop = 72
    ExplicitWidth = 81
    ExplicitHeight = 305
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 96
    Top = 96
  end
end
