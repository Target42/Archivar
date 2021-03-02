object SelectMeetingForm: TSelectMeetingForm
  Left = 0
  Top = 0
  Caption = 'Sitzung ausw'#228'hlen'
  ClientHeight = 488
  ClientWidth = 499
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
  object Splitter1: TSplitter
    Left = 0
    Top = 249
    Width = 499
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 179
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 428
    Width = 499
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 239
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 499
      ExplicitWidth = 464
    end
    inherited Panel1: TPanel
      Width = 499
      ExplicitWidth = 635
      inherited OKBtn: TBitBtn
        Left = 400
        ExplicitLeft = 536
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 499
    Height = 249
    Align = alTop
    Caption = 'Gremien'
    TabOrder = 1
    ExplicitWidth = 744
    inline GremiumFrame1: TGremiumFrame
      Left = 2
      Top = 15
      Width = 495
      Height = 232
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      inherited TV: TTreeView
        Width = 495
        Height = 232
        OnChange = GremiumFrame1TVChange
        ExplicitLeft = -4
        ExplicitTop = -4
        ExplicitWidth = 245
        ExplicitHeight = 278
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 252
    Width = 499
    Height = 176
    Align = alClient
    Caption = 'Sitzungen'
    TabOrder = 2
    ExplicitLeft = 48
    ExplicitTop = 280
    ExplicitWidth = 185
    ExplicitHeight = 105
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 495
      Height = 159
      Align = alClient
      DataSource = ELSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'EL_TITEL'
          Title.Caption = 'Titel'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EL_DATUM'
          Title.Caption = 'Datum'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EL_ZEIT'
          Title.Caption = 'Uhrzeit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EL_DATA_STAMP'
          Title.Caption = 'Aktualisierung'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'EL_ENDE'
          Title.Caption = 'Ende'
          Visible = True
        end>
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMeeing'
    SQLConnection = GM.SQLConnection1
    Left = 56
    Top = 32
  end
  object ELTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ElTab'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 96
    object ELTabEL_ID: TIntegerField
      FieldName = 'EL_ID'
      Required = True
    end
    object ELTabGR_ID: TIntegerField
      FieldName = 'GR_ID'
    end
    object ELTabEL_DATUM: TDateField
      FieldName = 'EL_DATUM'
    end
    object ELTabEL_ZEIT: TTimeField
      FieldName = 'EL_ZEIT'
      DisplayFormat = 'hh:nn'
    end
    object ELTabEL_TITEL: TWideStringField
      FieldName = 'EL_TITEL'
      Size = 200
    end
    object ELTabEL_DATA: TBlobField
      FieldName = 'EL_DATA'
      Size = 8
    end
    object ELTabEL_DATA_STAMP: TDateTimeField
      FieldName = 'EL_DATA_STAMP'
      DisplayFormat = 'dd.mm.yy hh:nn'
    end
    object ELTabPR_ID: TIntegerField
      FieldName = 'PR_ID'
    end
    object ELTabEL_ENDE: TTimeField
      FieldName = 'EL_ENDE'
      DisplayFormat = 'hh:nn'
    end
    object ELTabEL_STATUS: TWideStringField
      FieldName = 'EL_STATUS'
      FixedChar = True
      Size = 1
    end
  end
  object ELSrc: TDataSource
    DataSet = ELTab
    Left = 56
    Top = 152
  end
end
