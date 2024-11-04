object WebEditorForm: TWebEditorForm
  Left = 0
  Top = 0
  Caption = 'Editor'
  ClientHeight = 571
  ClientWidth = 779
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 511
    Width = 779
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 507
    ExplicitWidth = 777
    inherited StatusBar1: TStatusBar
      Width = 779
      SimplePanel = True
      ExplicitWidth = 779
    end
    inherited Panel1: TPanel
      Width = 779
      ExplicitWidth = 777
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 680
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 678
      end
    end
  end
  object SynEdit1: TSynEdit
    Left = 0
    Top = 0
    Width = 779
    Height = 511
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Font.Quality = fqClearTypeNatural
    TabOrder = 1
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
    Lines.Strings = (
      'SynEdit1')
    SelectedColor.Alpha = 0.400000005960464500
    ExplicitWidth = 777
    ExplicitHeight = 507
  end
  object SynCssSyn1: TSynCssSyn
    Left = 160
    Top = 120
  end
  object SynHTMLSyn1: TSynHTMLSyn
    Left = 48
    Top = 104
  end
  object SynJSONSyn1: TSynJSONSyn
    Left = 48
    Top = 200
  end
  object SynXMLSyn1: TSynXMLSyn
    WantBracesParsed = False
    Left = 408
    Top = 152
  end
  object SynIniSyn1: TSynIniSyn
    Left = 144
    Top = 248
  end
  object SynJScriptSyn1: TSynJScriptSyn
    Left = 192
    Top = 368
  end
  object SynPythonSyn1: TSynPythonSyn
    Left = 296
    Top = 128
  end
  object SynSTSyn1: TSynSTSyn
    Left = 376
    Top = 40
  end
  object SynPasSyn1: TSynPasSyn
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
