object ChapterEditForm: TChapterEditForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'TOP'
  ClientHeight = 406
  ClientWidth = 795
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 517
    Top = 73
    Height = 273
    Align = alRight
    ExplicitLeft = 544
    ExplicitTop = 96
    ExplicitHeight = 100
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 346
    Width = 795
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 346
    ExplicitWidth = 795
    inherited StatusBar1: TStatusBar
      Width = 795
      ExplicitWidth = 795
    end
    inherited Panel1: TPanel
      Width = 795
      ExplicitWidth = 795
      inherited OKBtn: TBitBtn
        Left = 707
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 707
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 795
    Height = 73
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 56
      Width = 64
      Height = 13
      Caption = 'Beschreibung'
    end
    object SpeedButton1: TSpeedButton
      Left = 456
      Top = 26
      Width = 23
      Height = 22
      Hint = 'Textbausteine'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C06515ABBF6716ABBF6716ABC06515ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BF6616FF38BCE1FF38BCE1FFBF6616FFFFFFFF00FAC89238F9C99055F9C9
        9055FFFFFF00FAC89238F9C99055F9C99055FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00A1753CFF77DDFFFF77DDFFFFA1753CFFFFFFFF00F9C991ABF9CA90FFF9CA
        90FFFFFFFF00F9C991ABF9CA90FFF9CA90FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C06515FF5F948FFF5F948FFFC06515FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C0661555C0661555C0661555C0661555FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0042B37CFF64C194FF63C093FF42B37CFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF006BC398FFAEE6E7FFAFE6E7FF6AC398FFFFFFFF00F8C98F72F9C991ABF9C9
        91ABFFFFFF00F8C98F72F9C991ABF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF006BC398FFB2E7E9FFB3E7E9FF6AC398FFFFFFFF00F8C98F72F9C991ABF9C9
        91ABFFFFFF00F8C98F72F9C991ABF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0042B37CFF63C093FF63C093FF42B37CFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0006C0FF5506C0FF5506C0FF5506C0FF55FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0005A3F4FF027AE5FF048AF1FF06B0FBFFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0007BCFDFF016DE0FF06ACFAFF07BFFFFFFFFFFF00F9C991ABF9CA90FFF9CA
        90FFFFFFFF00F9C991ABF9CA90FFF9CA90FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0007C1FFFF07BFFEFF66DDFFFF2BCCFFFFFFFFFF00FAC89238F9C99055F9C9
        9055FFFFFF00FAC89238F9C99055F9C99055FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0007C0FFAB07C0FFAB07C0FFAB07C0FFABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      OnClick = SpeedButton1Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 71
      Top = 27
      Width = 274
      Height = 21
      EditLabel.Width = 20
      EditLabel.Height = 13
      EditLabel.Caption = 'Titel'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 16
      Top = 27
      Width = 49
      Height = 21
      EditLabel.Width = 11
      EditLabel.Height = 13
      EditLabel.Caption = 'Nr'
      TabOrder = 1
    end
    object CheckBox1: TCheckBox
      Left = 360
      Top = 29
      Width = 97
      Height = 17
      Caption = 'Numerierung'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
  end
  inline EditFrame1: TEditFrame
    Left = 0
    Top = 73
    Width = 517
    Height = 273
    Align = alClient
    TabOrder = 2
    ExplicitTop = 73
    ExplicitWidth = 517
    ExplicitHeight = 273
    inherited RE: TRichEdit
      Width = 517
      Height = 273
      OnDragDrop = EditFrame1REDragDrop
      OnDragOver = EditFrame1REDragOver
      ExplicitWidth = 517
      ExplicitHeight = 273
    end
  end
  object GroupBox1: TGroupBox
    Left = 520
    Top = 73
    Width = 275
    Height = 273
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 3
    Visible = False
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 271
      Height = 256
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 271
      ExplicitHeight = 256
      inherited Panel1: TPanel
        Top = 200
        Width = 271
        ExplicitTop = 200
        ExplicitWidth = 271
        inherited LabeledEdit1: TLabeledEdit
          Width = 256
          ExplicitWidth = 256
        end
      end
      inherited LV: TListView
        Width = 271
        Height = 200
        ExplicitWidth = 271
        ExplicitHeight = 200
      end
    end
  end
end
