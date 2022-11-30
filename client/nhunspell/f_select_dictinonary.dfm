object SelectDictionaryForm: TSelectDictionaryForm
  Left = 0
  Top = 0
  Caption = 'Auswahl W'#246'terbuch'
  ClientHeight = 388
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
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 181
    Width = 635
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 143
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 181
    Align = alClient
    Caption = 'W'#246'rterb'#252'cher'
    TabOrder = 0
    object SpellList: TListView
      Left = 2
      Top = 15
      Width = 631
      Height = 164
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 150
        end
        item
          Caption = 'Version'
          Width = 75
        end
        item
          Caption = 'Displayname'
          Width = 350
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 184
    Width = 635
    Height = 144
    Align = alBottom
    Caption = 'Trennungen'
    TabOrder = 1
    object HyphenList: TListView
      Left = 2
      Top = 15
      Width = 631
      Height = 127
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 150
        end
        item
          Caption = 'Version'
          Width = 75
        end
        item
          Caption = 'Displayname'
          Width = 350
        end>
      HideSelection = False
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 369
    Width = 635
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 328
    Width = 635
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    DesignSize = (
      635
      41)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 10
      Width = 75
      Height = 25
      Kind = bkAbort
      NumGlyphs = 2
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 544
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akLeft, akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
end
