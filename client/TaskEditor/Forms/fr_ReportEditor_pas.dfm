inherited ReportFrameEditorPas: TReportFrameEditorPas
  object Splitter1: TSplitter [0]
    Left = 0
    Top = 169
    Width = 451
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 21
    ExplicitWidth = 235
  end
  inherited Panel1: TPanel
    inherited SpeedButton1: TSpeedButton
      ExplicitLeft = 425
    end
  end
  object SynEdit1: TSynEdit
    Left = 0
    Top = 21
    Width = 451
    Height = 148
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 1
    OnKeyPress = SynEdit1KeyPress
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
    Gutter.ShowLineNumbers = True
    Highlighter = SynDWSSyn1
    Lines.Strings = (
      'SynEdit1')
    Options = [eoAutoIndent, eoDragDropEditing, eoEnhanceEndKey, eoGroupUndo, eoScrollPastEol, eoShowScrollHint, eoSmartTabDelete, eoSmartTabs, eoTabIndent, eoTabsToSpaces]
    WantTabs = True
    FontSmoothing = fsmNone
    ExplicitLeft = 1
    ExplicitTop = 19
  end
  object Panel2: TPanel
    Left = 0
    Top = 172
    Width = 451
    Height = 133
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 2
    object Memo1: TMemo
      Left = 1
      Top = 42
      Width = 449
      Height = 90
      Align = alClient
      Lines.Strings = (
        'Memo1')
      ReadOnly = True
      ScrollBars = ssBoth
      TabOrder = 0
      WordWrap = False
    end
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 449
      Height = 41
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel3'
      ShowCaption = False
      TabOrder = 1
      object btnCompile: TBitBtn
        Left = 16
        Top = 10
        Width = 75
        Height = 25
        Caption = 'Compile'
        TabOrder = 0
        OnClick = btnCompileClick
      end
    end
  end
  object SynEditOptionsDialog1: TSynEditOptionsDialog
    UseExtendedStrings = False
    Left = 320
    Top = 56
  end
  object SynDWSSyn1: TSynDWSSyn
    DefaultFilter = 'DWScript Files (*.dws;*.pas;*.inc)|*.dws;*.pas;*.inc'
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 224
    Top = 112
  end
end
