object PluginAdmin: TPluginAdmin
  Left = 0
  Top = 0
  Caption = 'Pluginverwaltung'
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 280
    Width = 635
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 224
    Align = alClient
    Caption = #220'bersicht'
    TabOrder = 1
    object LV: TListView
      Left = 2
      Top = 15
      Width = 631
      Height = 207
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 250
        end
        item
          Caption = 'Dateiname'
          Width = 150
        end
        item
          Caption = 'Status'
          Width = 90
        end>
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 0
      ViewStyle = vsReport
      ExplicitLeft = 4
      ExplicitTop = 14
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 224
    Width = 635
    Height = 56
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Upload'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 112
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Aktivieren'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 208
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Deaktivieren'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 304
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Entwicklung'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object FileOpenDialog1: TFileOpenDialog
    DefaultExtension = '.bpl'
    FavoriteLinks = <>
    FileTypes = <
      item
        DisplayName = 'Plugins (*.bpl)'
        FileMask = '*.bpl'
      end
      item
        DisplayName = 'Alle Dateien (*.*)'
        FileMask = '*.*'
      end>
    Options = [fdoFileMustExist]
    Title = 'Plugin ausw'#228'hlen'
    Left = 48
    Top = 104
  end
end
