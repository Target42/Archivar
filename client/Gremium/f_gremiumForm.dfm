object GremiumForm: TGremiumForm
  Left = 0
  Top = 0
  Caption = 'Gremien'
  ClientHeight = 319
  ClientWidth = 561
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  inline Frame11: TBaseFrame
    Left = 0
    Top = 259
    Width = 561
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 265
    ExplicitWidth = 571
    inherited StatusBar1: TStatusBar
      Width = 571
      ExplicitWidth = 571
    end
    inherited Panel1: TPanel
      Width = 571
      ExplicitWidth = 571
      inherited OKBtn: TBitBtn
        Left = 483
        ExplicitLeft = 483
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 194
    Width = 561
    Height = 65
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    DesignSize = (
      561
      65)
    object BitBtn1: TBitBtn
      Left = 473
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Import'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D3BDF823D1BAF9A0D1BCF8AAD1BCF8AAD1BCF8AAD1BCF8AAD1BCF8AAD1BC
        F8AAD1BCF8AAD0BBF7A9D0BAF951FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D0BBF99DD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8F1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFCFB9F8FF9262EFFFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFCAB3F7FF834DEEFF631EE9FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFBFA3F6FF7234EBFF631EE9FF631EE9FF631EE9FF631E
        E9FF631EE9FF631EE9FF631EE9FF631EE9FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFBFA3F6FF7335EBFF631EE9FF631EE9FF631EE9FF631E
        E9FF631EE9FF631EE9FF631EE9FF631EE9FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFC9B1F7FF8049EDFF631EE9FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFCFBAF8FF9464F0FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D1BCF8AAD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8FFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D0BBF99DD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BBF8FFD0BB
        F8FFD0BBF8FFD0BBF8FFD0BBF8F1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00D3BDF823CFBBF7A6D1BBF8BBD1BBF8BBD1BBF8BBD1BBF8BBD1BBF8BBD1BB
        F8BBD1BBF8BBD0BBF8B4D0BAF951FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = BitBtn1Click
      ExplicitLeft = 483
    end
    object BitBtn2: TBitBtn
      Left = 16
      Top = 24
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
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 112
      Top = 24
      Width = 81
      Height = 25
      Caption = 'Bearbeiten'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003278889013ACE06C00AE
        FF13FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0011B0E56A06BBFFC60099
        FFCF0097FF16FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFE8DBC0FF24A3F5FF0098
        FFFF24A2F5FFE0D6C2FFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFDAD4C4FF1EA0
        F7FF0098FFFF2AA3F4FFDAD6C3B3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFD57E24FFD57E24FFDA8A39FFE19A51FFDFD2
        BAFF25A2F5FF0098FFFF189EF9F31199F71EFFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0994FFFE0994FFFE0994FFFE0994FFFE099
        4FFFDAC8ACFF1FA1F7FF51AAE1F1C3BCB1CF7B7BDC1DFFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
        85FFF6D3A9FFE4D8C1FFCAC3B3ED928FD3CB7373E683FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
        85FFF6D3A9FFFBDEBBFFE8CFBFB47373E4856666CC05FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
        4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
        4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00EFC6
        A6CEFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDE
        BBFFFBDEBBFFFBDEBBFFEFC6A6CEFFFFFF00FFFFFF00FFFFFF00FFFFFF00DB9E
        83D0E4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B0
        92FFE4B092FFE4B092FFDB9E83D0FFFFFF00FFFFFF00FFFFFF00FFFFFF00B651
        3FAAB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
        3FFFB5513FFFB5513FFFB6513FAAFFFFFF00FFFFFF00FFFFFF00FFFFFF00B351
        412FB4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B451
        3F55B4513F55B4513F55B351412FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object Button1: TBitBtn
      Left = 216
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Mitglieder'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004EC8
        90174BC38B444BC38B444BC38B444BC38B444EC89017FFFFFF00FFFFFF004EC8
        90174BC38B444BC38B444BC38B444BC38B444EC89017FFFFFF00FFFFFF004AC1
        8E2D4AC38BFA4AC38BFF4AC38BFF4AC38BF94AC18E2DFFFFFF00FFFFFF004AC1
        8E2D4AC38BFA4AC38BFF4AC38BFF4AC38BF94AC18E2DFFFFFF00FFFFFF00FFFF
        FF0048C58C354BC28B9349C48C924AC48934FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0048C58C354BC28B9349C48C924AC48934FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0051B9FF164DB7FFDC4DB7FFDB3CA68A48389F68AA389F68AA389F68AA389F
        68AA3BA48C494DB7FFDC4DB7FFDB49B6FF15FFFFFF00FFFFFF00FFFFFF00FFFF
        FF004EB9FF454DB7FFFF4DB7FFFF4DB6DF50389F68D5389F68FF389F68FF38A0
        68D34CB3E3514DB7FFFF4DB7FFFF4FB8FF44FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0040BFFF044DB7FF874CB7FF8655AAFF03339966053FA6A6593FA6A6593399
        660540BFFF044DB7FF874CB7FF8655AAFF03FFFFFF00FFFFFF00FFFFFF002069
        32381E6933AA1E6933AA1E6933AA1E6933AA37919C5D4DB7FFFE4DB7FFFE3790
        985C1E6933AA1E6933AA1E6933AA1E6933AA20693238FFFFFF00FFFFFF001E69
        2D111E6933D51E6933FF1E6933FF1E6933D344AAD03C4DB7FFFE4DB7FFFE44A6
        CC3C1E6933D51E6933FF1E6933FF1E6933D320703010FFFFFF00FFFFFF00FFFF
        FF0033663305228187592281875933663305FFFFFF004EB7FF2E4EB7FF2EFFFF
        FF0033663305228187592281875933663305FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025A5FF3026A7FFFE26A7FFFE27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0025A5FF3026A7FFFE26A7FFFE27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0026A8FF2F26A7FFFE26A7FFFE27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFF
        FF0026A8FF2F26A7FFFE26A7FFFE27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0027A6FF2E27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0027A6FF2E27A6FF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentDoubleBuffered = True
      TabOrder = 3
      OnClick = Button1Click
    end
    object BitBtn4: TBitBtn
      Left = 312
      Top = 24
      Width = 81
      Height = 25
      Caption = 'Aufgaben'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AE9E0081AD9C00C7AD9C00C7C4AB2CB9F9C991ABF9C991ABF9C991ABF9C9
        91ABF9C991ABF9C991ABF9C991ABF8C98F72FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFAD9C00C7FFFFFF00F9C99055F9C99055FFFF
        FF00F9C991ABFFFFFF00FFFFFF00F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFAD9C00C7FFFFFF00F9C99055F9C99055FFFF
        FF00F9C991ABFFFFFF00FFFFFF00F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7B6A300FFB6A300FFB6A210E0F9C991ABF9CA90C7F9CA90C7F9C9
        91ABF9CA90E3F9C991ABF9C991ABF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFAD9C00C7FFFFFF00F9C99055F9C99055FFFF
        FF00F9C991ABFFFFFF00FFFFFF00F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7C5AF00FFC5AF00FFB39E08D3F9C99055FACB918DFACB918DF9C9
        9055F9CA90C7F9C99055F9C99055F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7C5AF00FFC5AF00FFB39E08D3F9C99055FACB918DFACB918DF9C9
        9055F9CA90C7F9C99055F9C99055F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFAD9C00C7FFFFFF00F9C99055F9C99055FFFF
        FF00F9C991ABFFFFFF00FFFFFF00F9C991ABFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7B6A300FFB6A300FFAB9900F2AD9C00C7B39E08D3B39E08D3AD9C
        00C7B6A210E0AD9C00C7AD9C00C7C4AB2CB9FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFB6A300FFD4BC00FFC5AF00FFC5AF00FFD4BC
        00FFB6A300FFD4BC00FFD4BC00FFAD9C00C7FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AD9C00C7D4BC00FFD4BC00FFB6A300FFD4BC00FFC5AF00FFC5AF00FFD4BC
        00FFB6A300FFD4BC00FFD4BC00FFAD9C00C7FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00AE9E0081AD9C00C7AD9C00C7AD9C00C7AD9C00C7AD9C00C7AD9C00C7AD9C
        00C7AD9C00C7AD9C00C7AD9C00C7AE9E0081FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 4
      OnClick = BitBtn4Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 561
    Height = 194
    Align = alClient
    DataSource = DataSource1
    DefaultDrawing = False
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'GR_SHORT'
        Title.Caption = 'K'#252'rzel'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_PARENT_SHORT'
        Title.Caption = #220'bergeordnet'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_PIC_NAME'
        Title.Caption = 'Image'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GR_COLOR'
        Title.Caption = 'Farbe'
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsGremium'
    Left = 64
    Top = 40
  end
  object GRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'GRTab'
    RemoteServer = DSProviderConnection1
    Left = 200
    Top = 56
  end
  object DataSource1: TDataSource
    DataSet = GRTab
    Left = 320
    Top = 64
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = 'csb'
    Filter = 'CSV (*.csv)|*.csv|Alle Dateien (*.*)|*-*'
    Options = [ofHideReadOnly, ofFileMustExist, ofEnableSizing]
    Title = 'Gremium importieren'
    Left = 40
    Top = 128
  end
end
