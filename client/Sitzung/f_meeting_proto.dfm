object MeetingProtoForm: TMeetingProtoForm
  Left = 0
  Top = 0
  Caption = 'Protokoll ausw'#228'hlen'
  ClientHeight = 457
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
  object Splitter1: TSplitter
    Left = 0
    Top = 217
    Width = 635
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 133
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 397
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 397
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
        Enabled = False
        ExplicitLeft = 536
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 217
    Align = alTop
    Caption = 'Gremien'
    TabOrder = 1
    inline GremiumFrame1: TGremiumFrame
      Left = 2
      Top = 15
      Width = 631
      Height = 200
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 631
      ExplicitHeight = 200
      inherited TV: TTreeView
        Width = 631
        Height = 200
        OnChange = GremiumFrame1TVChange
        ExplicitLeft = 0
        ExplicitWidth = 631
        ExplicitHeight = 200
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 220
    Width = 635
    Height = 177
    Align = alClient
    Caption = 'Protokolle'
    TabOrder = 2
    object DBGrid1: TDBGrid
      Left = 2
      Top = 15
      Width = 631
      Height = 160
      Align = alClient
      DataSource = ProcolSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'PR_NR'
          Title.Caption = 'Nr'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PR_NAME'
          Title.Caption = 'Name'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'PR_DATUM'
          Title.Caption = 'Datum'
          Visible = True
        end>
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMeeing'
    Left = 56
    Top = 32
  end
  object ProtoQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftUnknown
        Name = 'GR_ID'
        ParamType = ptInput
      end>
    ProviderName = 'ListProtocolQry'
    RemoteServer = DSProviderConnection1
    Left = 80
    Top = 88
  end
  object ProcolSrc: TDataSource
    DataSet = ProtoQry
    Left = 80
    Top = 140
  end
end
