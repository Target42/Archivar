object TableColumnsForm: TTableColumnsForm
  Left = 0
  Top = 0
  Caption = 'Tabellenspalten'
  ClientHeight = 470
  ClientWidth = 477
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
    Top = 410
    Width = 477
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 410
    ExplicitWidth = 477
    inherited StatusBar1: TStatusBar
      Width = 477
      ExplicitWidth = 477
    end
    inherited Panel1: TPanel
      Width = 477
      ExplicitWidth = 477
      inherited OKBtn: TBitBtn
        Left = 389
        ExplicitLeft = 389
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 369
    Width = 477
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object SpeedButton1: TSpeedButton
      Left = 16
      Top = 13
      Width = 23
      Height = 22
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000520B0000520B00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
        82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
        F100C56A31000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE09
        09090909EEEEEEEEEEEEEEEEEEEEEE8181818181EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEE09090909
        10101009090909EEEEEEEEEE81818181ACACAC81818181EEEEEEEEEE09101010
        10101010101009EEEEEEEEEE81ACACACACACACACACAC81EEEEEEEEEE09101010
        10101010101009EEEEEEEEEE81ACACACACACACACACAC81EEEEEEEEEEEE091010
        101010101009EEEEEEEEEEEEEE81ACACACACACACAC81EEEEEEEEEEEEEEEE0910
        1010101009EEEEEEEEEEEEEEEEEE81ACACACACAC81EEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        091009EEEEEEEEEEEEEEEEEEEEEEEEEE81AC81EEEEEEEEEEEEEEEEEEEEEEEEEE
        EE09EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE81EEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 45
      Top = 13
      Width = 23
      Height = 22
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000520B0000520B00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
        82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
        F100C56A31000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EE09EEEEEEEEEEEEEEEEEEEEEEEEEEEEEE81EEEEEEEEEEEEEEEEEEEEEEEEEEEE
        091009EEEEEEEEEEEEEEEEEEEEEEEEEE81AC81EEEEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEE0910
        1010101009EEEEEEEEEEEEEEEEEE81ACACACACAC81EEEEEEEEEEEEEEEE091010
        101010101009EEEEEEEEEEEEEE81ACACACACACACAC81EEEEEEEEEEEE09101010
        10101010101009EEEEEEEEEE81ACACACACACACACACAC81EEEEEEEEEE09101010
        10101010101009EEEEEEEEEE81ACACACACACACACACAC81EEEEEEEEEE09090909
        10101009090909EEEEEEEEEE81818181ACACAC81818181EEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEEEE09
        09090909EEEEEEEEEEEEEEEEEEEEEE8181818181EEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
      OnClick = SpeedButton2Click
    end
    object BitBtn1: TBitBtn
      Left = 88
      Top = 10
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
      Left = 184
      Top = 10
      Width = 90
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
      Left = 288
      Top = 10
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
      Left = 381
      Top = 10
      Width = 86
      Height = 25
      Caption = 'Automatic'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00DCDC
        D116DCD8CFDCDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8
        CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFDADBDBCE15FFFFFF00FFFFFF00DDD7
        D052DCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8
        CFFFDCD8CFFFDCD8CFFFDCD8CFFFDCD8CFFFDDD7D052FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5
        A5FFBDB5A5FFBDB5A5FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CD
        C2FFD2CDC2FFD2CDC2FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5
        A5FFBDB5A5FFBDB5A5FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CD
        C2FFD2CDC2FFD2CDC2FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5A5FFBDB5
        A5FFBDB5A5FFBDB5A5FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00DBD8
        CF55DCD8CFFFDCD8CFFFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CDC2FFD2CD
        C2FFD2CDC2FFD2CDC2FFDCD8CFFFDCD8CFFFDBD8CF55FFFFFF00FFFFFF00B5B8
        D964AFB0D9FFAFB0D9FFAFB0D9FFAFB0D9FFAFB0D9FFAFB0D9FFAFB0D9FFAFB0
        D9FFAFB0D9FFAFB0D9FFAFB0D9FFAFB0D9FFB5B8D964FFFFFF00FFFFFF00535D
        EB683643F4FF3643F4FF323DEBFF323DECFF3643F4FF3643F4FF3643F4FF3643
        F4FF323DEBFF323DECFF3643F4FF3643F4FF535DEB68FFFFFF00FFFFFF003544
        F3523643F4FF3643F4FF7A77B5FF7A76B6FF3643F4FF3643F4FF3643F4FF3643
        F4FF7A77B5FF7A76B6FF3643F4FF3643F4FF3544F352FFFFFF00FFFFFF003A46
        F3163742F4D73643F4FF9190BDFF9190BEFF3643F4FF3643F4FF3643F4FF3643
        F4FF9190BDFF9190BEFF3643F4FF3643F4D63149F315FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00C5BEB189C5BDB088FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00C5BEB189C5BDB088FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 477
    Height = 369
    Align = alClient
    Columns = <
      item
        Caption = #220'berschrift'
        Width = 150
      end
      item
        Caption = 'Breite'
      end
      item
        Caption = 'DatenFeld'
        Width = 200
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 2
    ViewStyle = vsReport
    OnDblClick = LVDblClick
  end
end
