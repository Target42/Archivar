object ReportFrame: TReportFrame
  Left = 0
  Top = 0
  Width = 630
  Height = 537
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Splitter1: TSplitter
    Left = 153
    Top = 0
    Height = 537
    ExplicitLeft = 200
    ExplicitTop = 48
    ExplicitHeight = 100
  end
  object PageControl1: TPageControl
    Left = 156
    Top = 0
    Width = 474
    Height = 537
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 295
    ExplicitHeight = 305
    object TabSheet2: TTabSheet
      Caption = 'HTML'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 466
        Height = 509
        Align = alClient
        TabOrder = 0
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Preview'
      ImageIndex = 2
      ExplicitWidth = 287
      ExplicitHeight = 277
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 41
        Width = 466
        Height = 468
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 524
        ExplicitHeight = 395
        ControlData = {
          4C0000002A3000005F3000000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 466
        Height = 41
        Align = alTop
        Caption = 'Panel1'
        TabOrder = 1
        ExplicitWidth = 287
        object Button1: TButton
          Left = 24
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Update'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 537
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 305
    object Splitter2: TSplitter
      Left = 0
      Top = 121
      Width = 153
      Height = 3
      Cursor = crVSplit
      Align = alTop
      ExplicitWidth = 265
    end
    object Splitter3: TSplitter
      Left = 0
      Top = 383
      Width = 153
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 318
      ExplicitWidth = 68
    end
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 153
      Height = 121
      Align = alTop
      Caption = 'Style'
      TabOrder = 0
      object ListBox2: TListBox
        Left = 2
        Top = 15
        Width = 149
        Height = 69
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox2Click
        ExplicitLeft = 18
        ExplicitTop = 0
        ExplicitHeight = 71
      end
      object Panel4: TPanel
        Left = 2
        Top = 84
        Width = 149
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 1
        object SpeedButton1: TSpeedButton
          Left = 16
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton2: TSpeedButton
          Left = 45
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton3: TSpeedButton
          Left = 104
          Top = 6
          Width = 23
          Height = 22
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 386
      Width = 153
      Height = 151
      Align = alBottom
      Caption = 'Testdaten'
      TabOrder = 1
      ExplicitTop = 154
      object Panel3: TPanel
        Left = 2
        Top = 15
        Width = 149
        Height = 34
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel3'
        ShowCaption = False
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 16
          Top = 8
          Width = 97
          Height = 17
          Caption = 'Aktives Formular'
          TabOrder = 0
          OnClick = CheckBox1Click
        end
      end
      object ListBox1: TListBox
        Left = 2
        Top = 49
        Width = 149
        Height = 100
        Align = alClient
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 124
      Width = 153
      Height = 259
      Align = alClient
      Caption = 'Dateien'
      TabOrder = 2
      ExplicitTop = 192
      ExplicitHeight = 194
      object ListBox3: TListBox
        Left = 2
        Top = 15
        Width = 149
        Height = 207
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnDblClick = ListBox3DblClick
        ExplicitHeight = 58
      end
      object Panel5: TPanel
        Left = 2
        Top = 222
        Width = 149
        Height = 35
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 1
        ExplicitTop = 84
        object SpeedButton4: TSpeedButton
          Left = 16
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton5: TSpeedButton
          Left = 45
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton6: TSpeedButton
          Left = 104
          Top = 6
          Width = 23
          Height = 22
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 621
    Top = 264
    object Feldhinzufgen1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Feld hinzuf'#252'gen'
    end
  end
end
