object TaskListForm: TTaskListForm
  Left = 0
  Top = 0
  Caption = 'Aufgabeliste'
  ClientHeight = 509
  ClientWidth = 635
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
    Left = 0
    Top = 233
    Width = 635
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 333
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 449
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 449
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 547
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 547
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 233
    Align = alTop
    Caption = 'Gremium'
    TabOrder = 1
    inline GremiumFrame1: TGremiumFrame
      Left = 2
      Top = 15
      Width = 631
      Height = 216
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 631
      ExplicitHeight = 216
      inherited TV: TTreeView
        Width = 631
        Height = 216
        OnChange = GremiumFrame1TVChange
        ExplicitLeft = 0
        ExplicitWidth = 631
        ExplicitHeight = 216
      end
    end
  end
  inline TaskListFrame1: TTaskListFrame
    Left = 0
    Top = 236
    Width = 635
    Height = 213
    Align = alClient
    TabOrder = 2
    ExplicitTop = 236
    ExplicitWidth = 635
    ExplicitHeight = 213
    inherited LV: TListView
      Width = 635
      Height = 213
      ExplicitWidth = 635
      ExplicitHeight = 213
    end
    inherited Tasks: TClientDataSet
      Left = 200
    end
  end
end
