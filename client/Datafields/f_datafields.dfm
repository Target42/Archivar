object DataFieldForm: TDataFieldForm
  Left = 0
  Top = 0
  Caption = 'Datenfelder'
  ClientHeight = 591
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 531
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 531
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 547
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 547
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 635
    Height = 476
    Align = alClient
    DataSource = DASrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'DA_NAME'
        Title.Caption = 'Name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DA_TYPE'
        Title.Caption = 'Typ'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'DA_REM'
        Title.Caption = 'Beschreibung'
        Width = 350
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 476
    Width = 635
    Height = 55
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    DesignSize = (
      635
      55)
    object BitBtn1: TBitBtn
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
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 104
      Top = 24
      Width = 75
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
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 200
      Top = 24
      Width = 75
      Height = 25
      Caption = 'L'#246'schen'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003A42
        F71F3742F4873643F4A43644F36D2B55FF06FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003641F42F3643
        F4F13844F4FF3643F4FF3844F4FF3742F5C44040FF04FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFF6A6BE5FF5D67
        F6FFD4D7FDFF747DF8FFD4D7FDFF3845F4FF3544F565FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFF414BF1FF3844
        F4FFC2C6FCFFFCFCFFFF7B85F7FF3643F4FF3643F39BFFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFDD9244FFDD9244FFF0C28FFF555CEBFF5A65
        F6FFEFF0FEFFBBC0FBFFD7D9FDFF3845F4FF3642F57FFFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0994FFFE0994FFFE6A867FFAB9ED3FF3845
        F4FF5963F6FF3643F4FF5B66F6FF3643F4F13A42F71FFFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF6D3A9FFF6D3A9FFF0C290FFF0C290FFF0C290FFF3C99AFFADA0
        D2FF555CEBFF474FEFFF5A5FEAEA3641F42FFFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFF7D5
        ADFFFBDEBBFFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
        4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
        4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
        BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDE
        BBFFFBDEBBFFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00E2AB
        8FB1EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC9CE3EABC
        9CE3EABC9CE3EABC9CE3E2AB8FB1FFFFFF00FFFFFF00FFFFFF00FFFFFF00B651
        3FAAB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
        3FFFB5513FFFB5513FFFB6513FAAFFFFFF00FFFFFF00FFFFFF00FFFFFF00B351
        412FB4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B451
        3F55B4513F55B4513F55B351412FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 466
      Top = 24
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Export'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BDCCFF23BCCCFFA0BCCCFFAABCCCFFAABCCCFFAABCCCFFAABCCCFFAABCCC
        FFAABCCCFFAABDCCFFA9BDCDFF51FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCDFF9DBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFF1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFF91ABFFFF90ABFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFF88A5FFFF2358FFFF7999FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFF88A5FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2257FFA52060FF08FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFF88A5FFFF2257FFFF2257FFFF2257FFFF2257FFFF2257
        FFFF2257FFFF2257FFFF2257FFFF2258FF9D2B55FF06FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFF88A5FFFF2358FFFF6F92FFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFF91ACFFFF91ABFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCCFFAABCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFFFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BCCDFF9DBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCCFFFFBCCC
        FFFFBCCCFFFFBCCCFFFFBCCCFFF1FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00BDCCFF23BBCCFFA6BCCDFFBBBCCDFFBBBCCDFFBBBCCDFFBBBCCDFFBBBCCD
        FFBBBCCDFFBBBCCCFFB4BDCDFF51FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 3
      OnClick = BitBtn4Click
    end
    object BitBtn5: TBitBtn
      Left = 547
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
      TabOrder = 4
      OnClick = BitBtn5Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTaskEdit'
    Left = 296
    Top = 80
  end
  object DATab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DATab'
    RemoteServer = DSProviderConnection1
    Left = 296
    Top = 128
  end
  object DASrc: TDataSource
    DataSet = DATab
    Left = 376
    Top = 128
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.xml'
    Filter = 'XML( *.xml)|*.xml|Alle Dateien(*,*)|*.*'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Title = 'Datenfelder importieren'
    Left = 544
    Top = 112
  end
  object JvBrowseForFolderDialog1: TJvBrowseForFolderDialog
    Title = 'Exportverzeichnis ausw'#228'hlen'
    Left = 416
    Top = 48
  end
end
