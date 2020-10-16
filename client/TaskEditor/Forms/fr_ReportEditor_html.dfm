inherited ReportFrameEditorHtml: TReportFrameEditorHtml
  inherited Panel1: TPanel
    TabOrder = 1
    ExplicitWidth = 451
    inherited SpeedButton1: TSpeedButton
      Left = 425
      ExplicitLeft = 425
    end
  end
  object SynEdit1: TSynEdit
    Left = 0
    Top = 21
    Width = 451
    Height = 284
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 0
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
    Highlighter = SynHTMLSyn1
    FontSmoothing = fsmNone
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 96
    Top = 88
  end
  object SynCssSyn1: TSynCssSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 224
    Top = 112
  end
end
