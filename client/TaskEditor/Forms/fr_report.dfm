object ReportFrame: TReportFrame
  Left = 0
  Top = 0
  Width = 772
  Height = 630
  Align = alClient
  AutoSize = True
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Splitter1: TSplitter
    Left = 153
    Top = 0
    Height = 630
    ExplicitLeft = 200
    ExplicitTop = 48
    ExplicitHeight = 100
  end
  object PageControl1: TPageControl
    Left = 156
    Top = 0
    Width = 616
    Height = 630
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 0
    object TabSheet3: TTabSheet
      Caption = 'Preview'
      ImageIndex = 2
      ExplicitWidth = 287
      ExplicitHeight = 277
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 41
        Width = 608
        Height = 561
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 566
        ExplicitHeight = 539
        ControlData = {
          4C000000D73E0000FB3900000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 608
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
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
    object TabSheet2: TTabSheet
      Caption = 'HTML'
      ImageIndex = 1
      object PageControl2: TPageControl
        Left = 0
        Top = 0
        Width = 608
        Height = 602
        Align = alClient
        TabOrder = 0
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 153
    Height = 630
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    ExplicitHeight = 305
    object GroupBox2: TGroupBox
      Left = 0
      Top = 479
      Width = 153
      Height = 151
      Align = alBottom
      Caption = 'Testdaten'
      TabOrder = 0
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
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 153
      Height = 145
      Align = alTop
      Caption = 'Style'
      TabOrder = 1
      object ListBox2: TListBox
        Left = 2
        Top = 15
        Width = 149
        Height = 89
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox2Click
      end
      object Panel4: TPanel
        Left = 2
        Top = 104
        Width = 149
        Height = 39
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 1
        object SpeedButton1: TSpeedButton
          Left = 8
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton2: TSpeedButton
          Left = 37
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton3: TSpeedButton
          Left = 90
          Top = 6
          Width = 23
          Height = 22
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 0
      Top = 145
      Width = 153
      Height = 334
      Align = alClient
      Caption = 'Dateien'
      TabOrder = 2
      ExplicitHeight = 9
      object ListBox3: TListBox
        Left = 2
        Top = 15
        Width = 149
        Height = 278
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
        OnClick = ListBox3DblClick
        ExplicitHeight = 256
      end
      object Panel5: TPanel
        Left = 2
        Top = 293
        Width = 149
        Height = 39
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel4'
        ShowCaption = False
        TabOrder = 1
        ExplicitTop = -32
        object SpeedButton4: TSpeedButton
          Left = 8
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton5: TSpeedButton
          Left = 37
          Top = 6
          Width = 23
          Height = 22
        end
        object SpeedButton6: TSpeedButton
          Left = 90
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
