object ReportFrame: TReportFrame
  Left = 0
  Top = 0
  Width = 999
  Height = 645
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 645
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    ExplicitHeight = 305
  end
  object PageControl1: TPageControl
    Left = 185
    Top = 0
    Width = 814
    Height = 645
    ActivePage = TabSheet3
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 266
    ExplicitHeight = 305
    object TabSheet1: TTabSheet
      Caption = 'Testdaten'
      ExplicitWidth = 258
      ExplicitHeight = 277
      object SynEdit1: TSynEdit
        Left = 0
        Top = 467
        Width = 806
        Height = 150
        Align = alBottom
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        TabOrder = 0
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.ShowCollapsedLine = True
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynXMLSyn1
        Lines.Strings = (
          'SynEdit1')
        FontSmoothing = fsmNone
        ExplicitTop = 127
        ExplicitWidth = 258
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'HTML'
      ImageIndex = 1
      object SynEdit2: TSynEdit
        Left = 0
        Top = 0
        Width = 806
        Height = 617
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Courier New'
        Font.Style = []
        PopupMenu = PopupMenu1
        TabOrder = 0
        CodeFolding.CollapsedLineColor = clGrayText
        CodeFolding.FolderBarLinesColor = clGrayText
        CodeFolding.ShowCollapsedLine = True
        CodeFolding.IndentGuidesColor = clGray
        CodeFolding.IndentGuides = True
        UseCodeFolding = False
        Gutter.Font.Charset = DEFAULT_CHARSET
        Gutter.Font.Color = clWindowText
        Gutter.Font.Height = -11
        Gutter.Font.Name = 'Courier New'
        Gutter.Font.Style = []
        Highlighter = SynHTMLSyn1
        Lines.Strings = (
          'SynEdit2')
        FontSmoothing = fsmNone
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Preview'
      ImageIndex = 2
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 41
        Width = 806
        Height = 576
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 2
        ExplicitTop = 88
        ExplicitWidth = 782
        ExplicitHeight = 658
        ControlData = {
          4C0000004D530000883B00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 806
        Height = 41
        Align = alTop
        Caption = 'Panel1'
        TabOrder = 1
        ExplicitLeft = 64
        ExplicitTop = 16
        ExplicitWidth = 185
        object Button1: TButton
          Left = 24
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Button1'
          TabOrder = 0
          OnClick = Button1Click
        end
      end
    end
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 69
    Top = 288
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 613
    Top = 176
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 445
    Top = 152
    object Feldhinzufgen1: TMenuItem
      AutoHotkeys = maManual
      Caption = 'Feld hinzuf'#252'gen'
    end
  end
end
