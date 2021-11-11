inherited ReportFrameEditorHtml: TReportFrameEditorHtml
  Width = 594
  Height = 477
  inherited Panel1: TPanel
    Width = 594
    TabOrder = 1
    inherited SpeedButton1: TSpeedButton
      Left = 568
      ExplicitLeft = 425
    end
  end
  object SynEdit1: TSynEdit
    Left = 0
    Top = 21
    Width = 594
    Height = 456
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
    ExplicitWidth = 451
    ExplicitHeight = 284
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
  object SynCompletionProposal1: TSynCompletionProposal
    EndOfTokenChr = '()[]. '
    TriggerChars = '.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBtnText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = [fsBold]
    Columns = <>
    ShortCut = 16416
    Editor = SynEdit1
    Left = 88
    Top = 208
  end
end
