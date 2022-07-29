object MeetingTNFrame: TMeetingTNFrame
  Left = 0
  Top = 0
  Width = 806
  Height = 477
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 305
    Height = 477
    Align = alLeft
    Caption = 'Anwesend'
    TabOrder = 0
    ExplicitHeight = 305
    object Anwesend: TListView
      Left = 2
      Top = 15
      Width = 301
      Height = 460
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 75
        end
        item
          Caption = 'Vorname'
          Width = 75
        end
        item
          Caption = 'Abteilung'
          Width = 75
        end>
      GridLines = True
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      PopupMenu = PopupMenu1
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitHeight = 288
    end
  end
  object Panel1: TPanel
    Left = 305
    Top = 0
    Width = 32
    Height = 477
    Align = alLeft
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 305
  end
  object Panel2: TPanel
    Left = 337
    Top = 0
    Width = 469
    Height = 477
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 2
    ExplicitWidth = 114
    ExplicitHeight = 305
    object Splitter1: TSplitter
      Left = 0
      Top = 357
      Width = 469
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 304
    end
    object Splitter2: TSplitter
      Left = 0
      Top = 249
      Width = 469
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 196
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 360
      Width = 469
      Height = 117
      Align = alBottom
      Caption = 'Unentschuldigt'
      TabOrder = 0
      ExplicitTop = 188
      ExplicitWidth = 114
      object Unentschuldigt: TListView
        Left = 2
        Top = 15
        Width = 465
        Height = 100
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 75
          end
          item
            Caption = 'Vorname'
            Width = 75
          end
          item
            Caption = 'Abteilung'
            Width = 75
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu1
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 110
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 252
      Width = 469
      Height = 105
      Align = alBottom
      Caption = 'Entschuldigt'
      TabOrder = 1
      ExplicitTop = 80
      ExplicitWidth = 114
      object Entschuldigt: TListView
        Left = 2
        Top = 15
        Width = 465
        Height = 88
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 75
          end
          item
            Caption = 'Vorname'
            Width = 75
          end
          item
            Caption = 'Abteilung'
            Width = 75
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu1
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        ExplicitWidth = 110
      end
    end
    object GroupBox4: TGroupBox
      Left = 0
      Top = 0
      Width = 469
      Height = 249
      Align = alClient
      Caption = 'Gremium'
      TabOrder = 2
      ExplicitWidth = 114
      ExplicitHeight = 77
      object Gremium: TListView
        Left = 2
        Top = 15
        Width = 465
        Height = 232
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 75
          end
          item
            Caption = 'Vorname'
            Width = 75
          end
          item
            Caption = 'Abteilung'
            Width = 75
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = PopupMenu1
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnDblClick = GremiumDblClick
        ExplicitWidth = 110
        ExplicitHeight = 60
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 377
    Top = 88
    object Anwesend1: TMenuItem
      Tag = 1
      Caption = 'Anwesend'
      OnClick = Anwesend1Click
    end
    object Entschuldigt1: TMenuItem
      Tag = 2
      Caption = 'Entschuldigt'
      OnClick = Anwesend1Click
    end
    object Unentschuldigt1: TMenuItem
      Tag = 3
      Caption = 'Unentschuldigt'
      OnClick = Anwesend1Click
    end
    object Gremium1: TMenuItem
      Tag = 4
      Caption = 'Gremium'
      OnClick = Anwesend1Click
    end
  end
end
