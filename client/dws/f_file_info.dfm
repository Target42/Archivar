object FileInfoForm: TFileInfoForm
  Left = 0
  Top = 0
  Caption = 'Dateiinformationen'
  ClientHeight = 405
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
    Top = 345
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 345
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
  object LV: TListView
    Left = 0
    Top = 0
    Width = 635
    Height = 280
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = 'Name'
        Width = 150
      end
      item
        Caption = 'Version'
      end
      item
        Caption = 'Gr'#246#223'e'
        Width = 75
      end
      item
        Caption = 'Erzeugt'
        Width = 75
      end
      item
        Caption = 'L'#246'schdatum'
        Width = 75
      end
      item
        Caption = 'Benutzer'
        Width = 150
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 280
    Width = 635
    Height = 65
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'L'#246'schen'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00003DFF2E003CFF44003CFF44003CFF44003CFF44003C
        FF44003CFF44003DFF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003AFF30003DFFFE003DFFFF003DFFFF003DFFFF003DFFFF003D
        FFFF003DFFFF003DFFFE003DFF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
        FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF3D6BFEFF003DFFFF003DFFFF3D6B
        FEFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF3A69FEFFFAFAFAFF7696FDFF7797FDFFFAFA
        FAFF3968FEFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF86A2FCFFFAFAFAFFFAFAFAFF85A1
        FCFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF6E90FDFFFAFAFAFFF9F9FAFF6E90
        FDFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF3A69FEFFFAFAFAFF7696FDFF7797FDFFFAFA
        FAFF3968FEFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF3D6BFEFF003DFFFF003DFFFF3D6B
        FEFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
        FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
        FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF003D6BFFB33666FFCA2C5EFFF92B5DFFFF2B5DFFFF2B5DFFFF2B5D
        FFFF2C5EFFF93666FFCA3D6BFFB3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00416EFF92406EFFBB3B6AFFCC3061FFFC2F61FFFF2F61FFFF3062
        FFFB3B6AFFCA406EFFBB3F6FFF91FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000040FF28003CFF55003CFF550040
        FF28FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
end
