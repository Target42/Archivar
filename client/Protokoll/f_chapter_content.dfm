object ChapterContentForm: TChapterContentForm
  Left = 0
  Top = 0
  Caption = 'Kapitelstruktur'
  ClientHeight = 459
  ClientWidth = 934
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
    Top = 399
    Width = 934
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 254
    ExplicitWidth = 821
    inherited StatusBar1: TStatusBar
      Width = 934
      ExplicitWidth = 918
    end
    inherited Panel1: TPanel
      Width = 934
      ExplicitWidth = 821
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 846
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 733
      end
    end
  end
  inline ChapterFrame1: TChapterFrame
    Left = 0
    Top = 0
    Width = 934
    Height = 399
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 821
    ExplicitHeight = 254
    inherited Splitter1: TSplitter
      Height = 399
      ExplicitHeight = 254
    end
    inherited GroupBox1: TGroupBox
      Height = 399
      ExplicitHeight = 254
      inherited Panel1: TPanel
        Top = 250
        ExplicitTop = 105
        ExplicitWidth = 247
        inherited SpeedButton8: TBitBtn
          Caption = '&Unterkapitel  '
        end
        inherited SpeedButton3: TBitBtn
          Caption = 'Kapitel &l'#246'schen    '
        end
        inherited SpeedButton4: TBitBtn
          Caption = 'Kapitel hoch  '
        end
        inherited SpeedButton6: TBitBtn
          Caption = 'Ausr'#252'cken          '
        end
        inherited SpeedButton7: TBitBtn
          Caption = 'Einr'#252'cken           '
        end
      end
      inherited TV: TTreeView
        Height = 219
        ExplicitTop = 31
        ExplicitWidth = 247
        ExplicitHeight = 74
      end
    end
    inherited GroupBox2: TGroupBox
      Width = 680
      Height = 399
      ExplicitLeft = 254
      ExplicitWidth = 567
      ExplicitHeight = 254
      inherited Panel2: TPanel
        Width = 676
        ExplicitWidth = 563
      end
      inherited TaskList2Frame1: TTaskList2Frame
        Width = 676
        Height = 341
        ExplicitWidth = 563
        ExplicitHeight = 196
        inherited LV: TListView
          Width = 603
          Height = 300
          ExplicitLeft = 73
          ExplicitWidth = 490
          ExplicitHeight = 155
        end
        inherited Panel1: TPanel
          Top = 300
          Width = 676
          ExplicitTop = 155
          ExplicitWidth = 563
        end
        inherited Panel2: TPanel
          Height = 300
          ExplicitHeight = 155
        end
      end
    end
  end
end
