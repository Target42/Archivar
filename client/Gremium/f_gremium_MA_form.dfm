object GremiumMAForm: TGremiumMAForm
  Left = 0
  Top = 0
  Caption = 'Gremium'
  ClientHeight = 512
  ClientWidth = 919
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
  object Splitter1: TSplitter
    Left = 436
    Top = 41
    Height = 411
    ExplicitLeft = 360
    ExplicitTop = 72
    ExplicitHeight = 100
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 452
    Width = 919
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 463
    ExplicitWidth = 919
    inherited StatusBar1: TStatusBar
      Width = 919
      ExplicitWidth = 919
    end
    inherited Panel1: TPanel
      Width = 919
      ExplicitWidth = 919
      inherited OKBtn: TBitBtn
        Left = 831
        ExplicitLeft = 831
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 919
    Height = 41
    Align = alTop
    Caption = 'Panel1'
    TabOrder = 1
  end
  object Panel3: TPanel
    Left = 393
    Top = 41
    Width = 43
    Height = 411
    Align = alLeft
    BevelOuter = bvNone
    Caption = 'Panel3'
    ShowCaption = False
    TabOrder = 3
    ExplicitHeight = 422
    object SpeedButton1: TSpeedButton
      Left = 11
      Top = 48
      Width = 23
      Height = 22
      Hint = 'Alle '#220'bernehmen'
      Caption = '>>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Left = 11
      Top = 88
      Width = 23
      Height = 22
      Hint = 'Ausgew'#228'hlte '#252'bernehmen'
      Caption = '>'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnDblClick = SpeedButton2DblClick
    end
    object SpeedButton3: TSpeedButton
      Left = 11
      Top = 128
      Width = 23
      Height = 22
      Hint = 'Ausgew'#228'hlte entfernen'
      Caption = '<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton3Click
    end
    object SpeedButton4: TSpeedButton
      Left = 11
      Top = 168
      Width = 23
      Height = 22
      Hint = 'Alle Entfernen'
      Caption = '<<'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton4Click
    end
  end
  object Panel2: TDBGrid
    Left = 0
    Top = 41
    Width = 393
    Height = 411
    TabStop = False
    Align = alLeft
    BorderStyle = bsNone
    Color = clBtnFace
    DataSource = AllUserSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = Panel2DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'PE_NAME'
        Title.Caption = 'Name'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_VORNAME'
        Title.Caption = 'Vorname'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_DEPARTMENT'
        Title.Caption = 'abteilung'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_NET'
        Title.Caption = 'Login'
        Width = 75
        Visible = True
      end>
  end
  object Panel4: TDBGrid
    Left = 439
    Top = 41
    Width = 480
    Height = 411
    TabStop = False
    Align = alClient
    BorderStyle = bsNone
    Color = clBtnFace
    DataSource = GremiumSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'PE_NAME'
        Title.Caption = 'Name'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_VORNAME'
        Title.Caption = 'Vorname'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_DEPARTMENT'
        Title.Caption = 'Abteilung'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PE_NET'
        Title.Caption = 'Login'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GP_ROLLE'
        Title.Caption = 'Rolle'
        Width = 100
        Visible = True
      end>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsGremium'
    Left = 40
  end
  object AllUsers: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'AllUserQry'
    RemoteServer = DSProviderConnection1
    Left = 88
    Top = 104
  end
  object GremiumUser: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
    ProviderName = 'GrUserQry'
    RemoteServer = DSProviderConnection1
    Left = 512
    Top = 56
  end
  object AllUserSrc: TDataSource
    DataSet = AllUsers
    Left = 88
    Top = 152
  end
  object GremiumSrc: TDataSource
    DataSet = GremiumUser
    Left = 520
    Top = 112
  end
  object PopupMenu1: TPopupMenu
    Left = 824
    Top = 136
  end
end
