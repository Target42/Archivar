object PersonEditForm: TPersonEditForm
  Left = 0
  Top = 0
  Caption = 'Personendetails'
  ClientHeight = 234
  ClientWidth = 367
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
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 27
    Height = 13
    Caption = 'Name'
  end
  object Label2: TLabel
    Left = 200
    Top = 24
    Width = 42
    Height = 13
    Caption = 'Vorname'
  end
  object Label3: TLabel
    Left = 24
    Top = 70
    Width = 45
    Height = 13
    Caption = 'Abteilung'
  end
  object Label4: TLabel
    Left = 200
    Top = 70
    Width = 25
    Height = 13
    Caption = 'Login'
  end
  object Label5: TLabel
    Left = 24
    Top = 112
    Width = 18
    Height = 13
    Caption = 'Mail'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 174
    Width = 367
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 174
    ExplicitWidth = 367
    inherited StatusBar1: TStatusBar
      Width = 367
      ExplicitWidth = 367
    end
    inherited Panel1: TPanel
      Width = 367
      ExplicitWidth = 367
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 279
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 279
      end
    end
  end
  object DBEdit1: TDBEdit
    Left = 24
    Top = 43
    Width = 121
    Height = 21
    DataField = 'PE_NAME'
    DataSource = PESrc
    TabOrder = 1
  end
  object DBEdit2: TDBEdit
    Left = 200
    Top = 43
    Width = 121
    Height = 21
    DataField = 'PE_VORNAME'
    DataSource = PESrc
    TabOrder = 2
  end
  object DBEdit3: TDBEdit
    Left = 24
    Top = 85
    Width = 121
    Height = 21
    DataField = 'PE_DEPARTMENT'
    DataSource = PESrc
    TabOrder = 3
  end
  object DBEdit4: TDBEdit
    Left = 200
    Top = 89
    Width = 121
    Height = 21
    DataField = 'PE_NET'
    DataSource = PESrc
    TabOrder = 4
  end
  object DBEdit5: TDBEdit
    Left = 24
    Top = 131
    Width = 297
    Height = 21
    DataField = 'PE_MAIL'
    DataSource = PESrc
    TabOrder = 5
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsPerson'
    Left = 152
  end
  object PETab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PETab'
    RemoteServer = DSProviderConnection1
    BeforePost = PETabBeforePost
    Left = 328
  end
  object PESrc: TDataSource
    DataSet = PETab
    Left = 328
    Top = 48
  end
end
