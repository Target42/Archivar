object ChapterContentForm: TChapterContentForm
  Left = 0
  Top = 0
  Caption = 'Kapitelstruktur'
  ClientHeight = 314
  ClientWidth = 821
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
    Top = 254
    Width = 821
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 254
    ExplicitWidth = 821
    inherited StatusBar1: TStatusBar
      Width = 821
      ExplicitWidth = 821
    end
    inherited Panel1: TPanel
      Width = 821
      ExplicitWidth = 821
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 733
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 733
      end
    end
  end
  inline ChapterFrame1: TChapterFrame
    Left = 0
    Top = 0
    Width = 821
    Height = 254
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 821
    ExplicitHeight = 254
    inherited Splitter1: TSplitter
      Height = 254
      ExplicitHeight = 254
    end
    inherited GroupBox1: TGroupBox
      Height = 254
      ExplicitHeight = 254
      inherited Panel1: TPanel
        Top = 189
        ExplicitTop = 189
      end
      inherited TV: TTreeView
        Height = 161
        ExplicitHeight = 161
      end
    end
    inherited GroupBox2: TGroupBox
      Width = 593
      Height = 254
      ExplicitWidth = 593
      ExplicitHeight = 254
      inherited Panel2: TPanel
        Width = 589
        ExplicitWidth = 589
      end
      inherited TaskList2Frame1: TTaskList2Frame
        Width = 589
        Height = 196
        ExplicitWidth = 589
        ExplicitHeight = 196
        inherited LV: TListView
          Width = 540
          Height = 155
          ExplicitWidth = 540
          ExplicitHeight = 155
        end
        inherited Panel1: TPanel
          Top = 155
          Width = 589
          ExplicitTop = 155
          ExplicitWidth = 589
        end
        inherited Panel2: TPanel
          Height = 155
          ExplicitHeight = 155
        end
      end
    end
  end
end
