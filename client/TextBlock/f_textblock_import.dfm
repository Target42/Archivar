object TextblockImportForm: TTextblockImportForm
  Left = 0
  Top = 0
  Caption = 'Textblock import'
  ClientHeight = 299
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 192
    Align = alClient
    Caption = 'Dateien'
    TabOrder = 0
    object LV: TListView
      Left = 2
      Top = 15
      Width = 631
      Height = 175
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 550
        end
        item
          Caption = 'Status'
        end>
      GridLines = True
      MultiSelect = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 239
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 536
        ExplicitLeft = 536
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 192
    Width = 635
    Height = 47
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    ExplicitLeft = 64
    ExplicitTop = 194
    DesignSize = (
      635
      47)
    object BitBtn1: TBitBtn
      Left = 16
      Top = 16
      Width = 121
      Height = 25
      Caption = 'Dateien hinzuf'#252'gen'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 143
      Top = 16
      Width = 98
      Height = 25
      Caption = 'Eintr'#228'ge l'#246'schen'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 536
      Top = 16
      Width = 86
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Import starten'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object JvDropTarget1: TJvDropTarget
    Control = LV
    OnDragDrop = JvDropTarget1DragDrop
    OnDragAccept = JvDropTarget1DragAccept
    OnDragOver = JvDropTarget1DragOver
    Left = 528
    Top = 80
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTextBlock'
    Left = 48
    Top = 40
  end
  object TBtab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TBTab'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 96
  end
  object FileOpenDialog1: TFileOpenDialog
    FavoriteLinks = <>
    FileTypes = <>
    Options = [fdoAllowMultiSelect, fdoFileMustExist]
    Title = #39'Dateien ausw'#228'hlen'
    Left = 136
    Top = 152
  end
end
