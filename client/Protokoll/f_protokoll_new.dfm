object ProtokollNewForm: TProtokollNewForm
  Left = 0
  Top = 0
  Caption = 'Neues Protokoll'
  ClientHeight = 392
  ClientWidth = 702
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 332
    Width = 702
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 702
      ExplicitWidth = 703
    end
    inherited Panel1: TPanel
      Width = 702
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 603
        ExplicitLeft = 536
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 225
    Height = 332
    Align = alLeft
    Caption = 'Gremium'
    TabOrder = 1
    ExplicitHeight = 141
    inline GremiumFrame1: TGremiumFrame
      Left = 2
      Top = 15
      Width = 221
      Height = 315
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 221
      ExplicitHeight = 124
      inherited TV: TTreeView
        Width = 221
        Height = 315
        ExplicitWidth = 221
        ExplicitHeight = 315
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 225
    Top = 0
    Width = 292
    Height = 332
    Align = alClient
    Caption = 'Vorschau'
    TabOrder = 2
    ExplicitTop = -6
    ExplicitWidth = 265
    ExplicitHeight = 239
    object TV: TTreeView
      Left = 2
      Top = 15
      Width = 288
      Height = 274
      Align = alClient
      Indent = 19
      TabOrder = 0
    end
    object Panel1: TPanel
      Left = 2
      Top = 289
      Width = 288
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      ExplicitLeft = 4
      ExplicitTop = 288
    end
  end
  object GroupBox3: TGroupBox
    Left = 517
    Top = 0
    Width = 185
    Height = 332
    Align = alRight
    Caption = 'Vorlagen'
    TabOrder = 3
    ExplicitLeft = 450
    ExplicitHeight = 239
    object LB: TListBox
      Left = 2
      Top = 15
      Width = 181
      Height = 315
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnClick = LBClick
    end
  end
end
