﻿object ImagesForm: TImagesForm
  Left = 0
  Top = 0
  Caption = 'Bilder'
  ClientHeight = 412
  ClientWidth = 571
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
    Top = 352
    Width = 571
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 352
    ExplicitWidth = 571
    inherited StatusBar1: TStatusBar
      Width = 571
      ExplicitWidth = 571
    end
    inherited Panel1: TPanel
      Width = 571
      ExplicitWidth = 571
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 483
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 483
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 296
    Width = 571
    Height = 56
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      571
      56)
    object Hinzufügen: TBitBtn
      Left = 16
      Top = 10
      Width = 75
      Height = 25
      Caption = 'Hinzuf'#252'gen'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF008099660A769D
        5E7F769C5EDB769C5EFD769C5EDA759C5D7E71AA5509FFFFFF00FFFFFF00FFFF
        FF009C8B78FF9C8B78FF9C8B78FF9C8B78FFA59481FFD7CEBDFF8CA874FF769C
        5EFF769C5EFF769C5EFF769C5EFF769C5EFF779C5EC88099660AFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB9CDADFF769C5EFF769C
        5EFF769C5EFFFFFFFFFF769C5EFF769C5EFF769C5EFF759C5D7EFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88A973FF769C5EFF769C
        5EFF769C5EFFFFFFFFFF769C5EFF769C5EFF769C5EFF769C5EDBFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF799E62FF769C5EFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF769C5EFF769C5EF8FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF88A973FF769C5EFF769C
        5EFF769C5EFFFFFFFFFF769C5EFF769C5EFF769C5EFF769C5EDBFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB9CDADFF769C5EFF769C
        5EFF769C5EFFFFFFFFFF769C5EFF769C5EFF769C5EFF759C5D7EFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9FBF8FF93B180FF769C
        5EFF769C5EFF769C5EFF769C5EFF769C5EFF779C5EC88099660AFFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAFBF9FFBBCE
        AFFF89AA75FF7FA369FF8AAA75FFAAB892FF71AA5509FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFC3B7A6FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B78FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B
        78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FFFFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B
        78FFFFFFFFFFF9F8F7FFAD9E8FFFA29281CAFFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B
        78FFF9F8F7FFAD9F8FFFA19380CFFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF9C8B
        78FFAC9D8EFFA49483C9FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF009C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B78FF9C8B
        78FFA0917ECAFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = HinzufügenClick
    end
    object BitBtn1: TBitBtn
      Left = 483
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
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
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 571
    Height = 296
    Align = alClient
    Columns = <>
    LargeImages = ImageList1
    SmallImages = ImageList1
    SortType = stText
    TabOrder = 2
    OnDblClick = LVDblClick
    ExplicitLeft = 227
    ExplicitTop = 196
    ExplicitWidth = 250
    ExplicitHeight = 150
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsImage'
    Left = 64
    Top = 40
  end
  object PicTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PicturesTab'
    RemoteServer = DSProviderConnection1
    Left = 128
    Top = 104
  end
  object PicSrc: TDataSource
    DataSet = PicTab
    Left = 192
    Top = 104
  end
  object OpenPictureDialog1: TOpenPictureDialog
    Filter = 'PNG (*.png)|*.png'
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Title = 'Bild laden'
    Left = 48
    Top = 232
  end
  object ImageList1: TImageList
    Left = 176
    Top = 184
  end
end
