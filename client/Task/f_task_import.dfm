object TaskImportForm: TTaskImportForm
  Left = 0
  Top = 0
  Caption = 'Aufgabe importieren'
  ClientHeight = 399
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poOwnerFormCenter
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 201
    Top = 0
    Height = 380
    ExplicitLeft = 256
    ExplicitTop = 64
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 380
    Width = 674
    Height = 19
    Panels = <>
    ExplicitTop = 280
    ExplicitWidth = 635
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 201
    Height = 380
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 1
    ExplicitLeft = -3
    ExplicitTop = -6
    ExplicitHeight = 384
    object JvDriveCombo1: TJvDriveCombo
      Left = 2
      Top = 15
      Width = 197
      Height = 22
      Align = alTop
      DriveTypes = [dtFixed, dtRemote, dtCDROM]
      Offset = 4
      TabOrder = 0
    end
    object JvDirectoryListBox1: TJvDirectoryListBox
      Left = 2
      Top = 37
      Width = 197
      Height = 304
      Align = alClient
      Directory = 'c:\windows\tracing'
      DriveCombo = JvDriveCombo1
      ItemHeight = 17
      ScrollBars = ssBoth
      TabOrder = 1
      OnClick = JvDirectoryListBox1Click
    end
    object Panel2: TPanel
      Left = 2
      Top = 341
      Width = 197
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 2
      ExplicitLeft = 32
      ExplicitTop = 304
      ExplicitWidth = 185
    end
  end
  object Panel1: TPanel
    Left = 204
    Top = 0
    Width = 470
    Height = 380
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    ExplicitLeft = 334
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 287
    object Splitter2: TSplitter
      Left = 0
      Top = 241
      Width = 472
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 0
      ExplicitWidth = 192
    end
    object SynEdit1: TSynEdit
      Left = 0
      Top = 0
      Width = 472
      Height = 241
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Courier New'
      Font.Style = []
      Font.Quality = fqClearTypeNatural
      TabOrder = 0
      CodeFolding.ShowCollapsedLine = True
      UseCodeFolding = False
      Gutter.Font.Charset = DEFAULT_CHARSET
      Gutter.Font.Color = clWindowText
      Gutter.Font.Height = -11
      Gutter.Font.Name = 'Courier New'
      Gutter.Font.Style = []
      Gutter.Font.Quality = fqClearTypeNatural
      Gutter.Bands = <
        item
          Kind = gbkMarks
          Width = 13
        end
        item
          Kind = gbkLineNumbers
        end
        item
          Kind = gbkFold
        end
        item
          Kind = gbkTrackChanges
        end
        item
          Kind = gbkMargin
          Width = 3
        end>
      Highlighter = SynXMLSyn1
      Lines.Strings = (
        'SynEdit1')
      SelectedColor.Alpha = 0.400000005960464500
      ExplicitLeft = 1
      ExplicitTop = 15
      ExplicitWidth = 200
      ExplicitHeight = 150
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 244
      Width = 472
      Height = 140
      Align = alBottom
      Caption = 'Files'
      TabOrder = 1
      ExplicitLeft = 1
      ExplicitTop = 192
      ExplicitWidth = 388
    end
  end
  object SynXMLSyn1: TSynXMLSyn
    WantBracesParsed = False
    Left = 392
    Top = 88
  end
end
