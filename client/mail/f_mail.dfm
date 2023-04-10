object Mailform: TMailform
  Left = 0
  Top = 0
  Caption = 'Maileinstellungen'
  ClientHeight = 496
  ClientWidth = 469
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
    Top = 436
    Width = 469
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 436
    ExplicitWidth = 469
    inherited StatusBar1: TStatusBar
      Width = 469
      ExplicitWidth = 469
    end
    inherited Panel1: TPanel
      Width = 469
      ExplicitWidth = 469
      inherited OKBtn: TBitBtn
        Left = 370
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 370
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 469
    Height = 436
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 469
      Height = 152
      Align = alTop
      Caption = 'Konten'
      TabOrder = 0
      object Panel2: TPanel
        Left = 2
        Top = 109
        Width = 465
        Height = 41
        Align = alBottom
        Caption = 'Panel2'
        ShowCaption = False
        TabOrder = 0
        object DBNavigator1: TDBNavigator
          Left = 13
          Top = 6
          Width = 240
          Height = 25
          DataSource = DataSource1
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = DBNavigator1Click
        end
        object BitBtn1: TBitBtn
          Left = 280
          Top = 6
          Width = 105
          Height = 25
          Caption = 'Konfiguration'
          Enabled = False
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
          OnClick = BitBtn1Click
        end
      end
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 465
        Height = 94
        Align = alClient
        DataSource = DataSource1
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'MAC_TITLE'
            Title.Caption = 'Kontoname'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MAC_TYPE'
            PickList.Strings = (
              'imap/smtp')
            Title.Caption = 'Typ'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MAC_ACTIVE'
            PickList.Strings = (
              'Aktiv'
              'Inaktiv')
            Title.Caption = 'Aktiv'
            Width = 75
            Visible = True
          end>
      end
    end
    object GroupBox2: TGroupBox
      Left = 0
      Top = 152
      Width = 469
      Height = 284
      Align = alClient
      Caption = 'Verzeichnisse'
      TabOrder = 1
      object Panel3: TPanel
        Left = 2
        Top = 241
        Width = 465
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel3'
        ShowCaption = False
        TabOrder = 0
        object DBNavigator2: TDBNavigator
          Left = 14
          Top = 12
          Width = 240
          Height = 25
          DataSource = DataSource2
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
        end
      end
      object DBGrid2: TDBGrid
        Left = 2
        Top = 15
        Width = 465
        Height = 226
        Align = alClient
        DataSource = DataSource2
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'MAF_NAME'
            Title.Caption = 'Name'
            Width = 300
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MAF_ACTIVE'
            PickList.Strings = (
              'Aktiv'
              'Inaktiv')
            Title.Caption = 'Status'
            Width = 120
            Visible = True
          end>
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TDSMail'
    Left = 168
    Top = 248
  end
  object Accounts: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MailAccount'
    RemoteServer = DSProviderConnection1
    BeforePost = AccountsBeforePost
    AfterPost = AccountsAfterPost
    Left = 272
    Top = 240
    object AccountsMAC_ID: TIntegerField
      FieldName = 'MAC_ID'
      Required = True
    end
    object AccountsMAC_TITLE: TStringField
      FieldName = 'MAC_TITLE'
      Size = 150
    end
    object AccountsMAC_TYPE: TStringField
      FieldName = 'MAC_TYPE'
      Size = 32
    end
    object AccountsMAC_DATA: TBlobField
      FieldName = 'MAC_DATA'
    end
    object AccountsMAC_ACTIVE: TStringField
      FieldName = 'MAC_ACTIVE'
      OnGetText = AccountsMAC_ACTIVEGetText
      OnSetText = AccountsMAC_ACTIVESetText
      FixedChar = True
      Size = 1
    end
  end
  object Folder: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Mailfolder'
    RemoteServer = DSProviderConnection1
    Left = 280
    Top = 296
    object FolderMAF_ID: TIntegerField
      FieldName = 'MAF_ID'
      Required = True
    end
    object FolderMAC_ID: TIntegerField
      FieldName = 'MAC_ID'
    end
    object FolderMAF_NAME: TStringField
      FieldName = 'MAF_NAME'
      Size = 255
    end
    object FolderMAF_ACTIVE: TStringField
      FieldName = 'MAF_ACTIVE'
      OnGetText = AccountsMAC_ACTIVEGetText
      OnSetText = AccountsMAC_ACTIVESetText
      FixedChar = True
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = Accounts
    Left = 336
    Top = 240
  end
  object DataSource2: TDataSource
    DataSet = Folder
    Left = 352
    Top = 312
  end
end
