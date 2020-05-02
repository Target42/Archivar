object ReportFrame: TReportFrame
  Left = 0
  Top = 0
  Width = 683
  Height = 551
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 185
    Height = 551
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    ExplicitHeight = 305
  end
  object PageControl1: TPageControl
    Left = 185
    Top = 0
    Width = 498
    Height = 551
    ActivePage = TabSheet1
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
        Top = 373
        Width = 490
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
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object SynEdit2: TSynEdit
        Left = 0
        Top = 0
        Width = 782
        Height = 658
        Align = alClient
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
        Highlighter = SynHTMLSyn1
        Lines.Strings = (
          'SynEdit2')
        FontSmoothing = fsmNone
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Preview'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 782
        Height = 658
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 742
        ExplicitHeight = 454
        ControlData = {
          4C000000D2500000024400000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
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
end
