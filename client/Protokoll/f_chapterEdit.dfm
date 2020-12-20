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
      DragMode = dmAutomatic
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
        DragMode = dmAutomatic
        ExplicitWidth = 271
        ExplicitHeight = 200
      end
    end
  end
end
