object WebServerFilesForm: TWebServerFilesForm
  Left = 0
  Top = 0
  Caption = 'Webserverdareien'
  ClientHeight = 329
  ClientWidth = 530
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
    Top = 269
    Width = 530
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 269
    ExplicitWidth = 530
    inherited StatusBar1: TStatusBar
      Width = 530
      ExplicitWidth = 530
    end
    inherited Panel1: TPanel
      Width = 530
      ExplicitWidth = 530
      inherited OKBtn: TBitBtn
        Left = 431
        ExplicitLeft = 431
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 530
    Height = 216
    Align = alClient
    DataSource = HCsrc
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'HC_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HC_PATH'
        Title.Caption = 'Path'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'HC_MD5'
        Title.Caption = 'MD5'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 216
    Width = 530
    Height = 53
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object bntUpload: TBitBtn
      Left = 97
      Top = 22
      Width = 89
      Height = 25
      Caption = 'Update'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B6523F7DB5513FFFB5513FFFB5513FFFB5513FFFB551
        3FFFB5513FFFB550407CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FF000001B5513FADB5513FFFB5513FFFB5513FFFB551
        3FFFB5523EACFF000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B946460BB5513FCFB5513FFFB5513FFFB550
        3FCEB946460BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B94F3E1DB5513FE8B5513FE7B94F
        3E1DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5534034B4504133FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 1
      OnClick = bntUploadClick
    end
    object btnDownload: TBitBtn
      Left = 192
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Download'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B5534034B5534034FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B14E4317B5503FE1B5503FE1B14E
        4317FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00BF604008B6513FC6B5513FFFB5513FFFB651
        3FC6BF604008FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FF000001B5513FA3B5513FFFB5513FFFB5513FFFB551
        3FFFB5513FA3FF000001FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00B4503F82B5513FFFB5513FFFB5513FFFB5513FFFB551
        3FFFB5513FFFB6513F81FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00B4513F55B5513FFFB5513FFFB451
        3F55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 2
    end
    object btnDelete: TBitBtn
      Left = 273
      Top = 22
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
      TabOrder = 3
    end
    object btnNew: TBitBtn
      Left = 16
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Neu'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004499440F47A0
        439B47A043ED47A043ED48A0439949A4490EFFFFFF00FFFFFF00FFFFFF00FFAA
        5503F5A442D6F5A542FFF5A542FFF5A542FFF5A542FFF5A542FF7FA242FF47A0
        43FF99CA97FF99CA97FF47A043FF56A142BDFFFFFF00FFFFFF00FFFFFF00F5A4
        4335F5A542FFF5A542FFF5A542FFF5A542FFF5A542FFD7A543FF47A043FF84C0
        82FFD6EAD6FFD6EAD6FF84C082FF47A043FF44A24429FFFFFF00FFFFFF00F6A4
        4038F6AE57CAF7B461D2F7B461D2F7B461D2F7B461D2BEAE58DF47A043FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF47A043FF469F4345FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFE9C689FF4BA145FF47A0
        43FFC2E0C1FFC2E0C1FF47A043FF47A043F946A24616FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFA7B76CFF47A0
        43FF6FB56CFF6FB56CFF47A043FE47A04373FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9241FFDF9241FFE39C4EFFC8BA
        74FF8FB162FF7EAD5BDD469F4345FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
        68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
        68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
        40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
        40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
        90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
        90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
        90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = btnNewClick
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsFileCache'
    Left = 72
    Top = 24
  end
  object HCTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'HCTab'
    RemoteServer = DSProviderConnection1
    Left = 80
    Top = 72
  end
  object HCsrc: TDataSource
    DataSet = HCTab
    Left = 136
    Top = 72
  end
end