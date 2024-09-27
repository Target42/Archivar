inherited ReportFrameEditorHtml: TReportFrameEditorHtml
  inherited Panel1: TPanel
    TabOrder = 1
    inherited SpeedButton1: TSpeedButton
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
    Font.Quality = fqClearTypeNatural
    TabOrder = 0
    OnKeyPress = SynEdit1KeyPress
    CodeFolding.ShowCollapsedLine = True
    UseCodeFolding = False
    Gutter.Font.Charset = DEFAULT_CHARSET
    Gutter.Font.Color = clWindowText
    Gutter.Font.Height = -11
    Gutter.Font.Name = 'Courier New'
    Gutter.Font.Style = []
    Gutter.Font.Quality = fqClearTypeNatural
    Gutter.Bands = <
      item
        Kind = gbkMarks
        Width = 13
      end
      item
        Kind = gbkLineNumbers
      end
      item
        Kind = gbkFold
      end
      item
        Kind = gbkTrackChanges
      end
      item
        Kind = gbkMargin
        Width = 3
      end>
    Highlighter = SynHTMLSyn1
    SelectedColor.Alpha = 0.400000005960464500
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 96
    Top = 88
  end
  object SynCssSyn1: TSynCssSyn
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
