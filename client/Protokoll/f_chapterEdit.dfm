object ChapterEditForm: TChapterEditForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'TOP'
  ClientHeight = 302
  ClientWidth = 504
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 242
    Width = 504
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 242
    ExplicitWidth = 504
    inherited StatusBar1: TStatusBar
      Width = 504
      ExplicitWidth = 504
    end
    inherited Panel1: TPanel
      Width = 504
      ExplicitWidth = 504
      inherited OKBtn: TBitBtn
        Left = 416
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 416
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 504
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
    Width = 504
    Height = 169
    Align = alClient
    TabOrder = 2
    ExplicitTop = 73
    ExplicitWidth = 504
    ExplicitHeight = 169
    inherited RE: TRichEdit
      Width = 504
      Height = 169
      ExplicitWidth = 504
      ExplicitHeight = 169
    end
  end
end
