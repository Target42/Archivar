object WebEditorForm: TWebEditorForm
  Left = 0
  Top = 0
  Caption = 'Editor'
  ClientHeight = 575
  ClientWidth = 781
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 515
    Width = 781
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 515
    ExplicitWidth = 781
    inherited StatusBar1: TStatusBar
      Width = 781
      SimplePanel = True
      ExplicitWidth = 781
    end
    inherited Panel1: TPanel
      Width = 781
      ExplicitWidth = 781
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 682
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 682
      end
    end
  end
  object SynEdit1: TSynEdit
    Left = 0
    Top = 0
    Width = 781
    Height = 515
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    TabOrder = 1
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
    Lines.Strings = (
      'SynEdit1')
    FontSmoothing = fsmNone
  end
  object SynCssSyn1: TSynCssSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 96
    Top = 40
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 48
    Top = 104
  end
  object SynJSONSyn1: TSynJSONSyn
    Options.AutoDetectEnabled = True
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 48
    Top = 200
  end
  object SynXMLSyn1: TSynXMLSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    WantBracesParsed = False
    Left = 408
    Top = 152
  end
  object SynIniSyn1: TSynIniSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 144
    Top = 40
  end
  object SynJScriptSyn1: TSynJScriptSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 176
    Top = 40
  end
  object SynPythonSyn1: TSynPythonSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 296
    Top = 128
  end
  object SynSTSyn1: TSynSTSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    Left = 376
    Top = 40
  end
  object SynPasSyn1: TSynPasSyn
    Options.AutoDetectEnabled = False
    Options.AutoDetectLineLimit = 0
    Options.Visible = False
    CommentAttri.Foreground = clGreen
    DirectiveAttri.Foreground = clFuchsia
    IdentifierAttri.Foreground = clBlack
    KeyAttri.Foreground = clBlue
    NumberAttri.Foreground = clRed
    HexAttri.Foreground = clMoneyGreen
    StringAttri.Foreground = clGreen
    SymbolAttri.Foreground = clOlive
    Left = 296
    Top = 272
  end
end
