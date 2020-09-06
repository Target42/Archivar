object TaskListForm: TTaskListForm
  Left = 0
  Top = 0
  Caption = 'Aufgabeliste'
  ClientHeight = 299
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
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 24
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 547
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 363
      end
    end
  end
  inline TaskListFrame1: TTaskListFrame
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 635
    ExplicitHeight = 239
    inherited LV: TListView
      Width = 635
      Height = 239
    end
  end
end
