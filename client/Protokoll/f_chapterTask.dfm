object ChapterTaskForm: TChapterTaskForm
  Left = 0
  Top = 0
  Caption = 'Aufgabendetails'
  ClientHeight = 516
  ClientWidth = 635
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
    Top = 456
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 456
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited AbortBtn: TBitBtn
        Visible = False
      end
      inherited OKBtn: TBitBtn
        Left = 536
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 536
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 57
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
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
    end
  end
  inline FormFrame1: TFormFrame
    Left = 0
    Top = 57
    Width = 635
    Height = 399
    Align = alClient
    TabOrder = 2
    ExplicitTop = 57
    ExplicitWidth = 635
    ExplicitHeight = 399
    inherited ScrollBox1: TScrollBox
      Width = 635
      Height = 399
      ExplicitWidth = 635
      ExplicitHeight = 399
    end
  end
end
