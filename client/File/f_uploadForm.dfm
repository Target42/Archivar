object UploadForm: TUploadForm
  Left = 0
  Top = 0
  Caption = 'Dateiupload'
  ClientHeight = 295
  ClientWidth = 633
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 235
    Width = 633
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 235
    ExplicitWidth = 633
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 633
      inherited OKBtn: TBitBtn
        Left = 547
        OnClick = Button1Click
        ExplicitLeft = 545
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 633
    Height = 235
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
        FieldName = 'FNAME'
        Title.Caption = 'Dateiname'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FD_TEXT'
        Title.Caption = 'L'#246'schfrist'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Uploaded'
        Visible = True
      end>
  end
  object DataTab: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 112
    Top = 72
    object DataTabID: TIntegerField
      DisplayWidth = 10
      FieldName = 'ID'
    end
    object DataTabFNAME: TStringField
      DisplayWidth = 200
      FieldName = 'FNAME'
      Size = 200
    end
    object DataTabFD_ID: TIntegerField
      FieldName = 'FD_ID'
    end
    object DataTabFD_TEXT: TStringField
      DisplayWidth = 100
      FieldKind = fkLookup
      FieldName = 'FD_TEXT'
      LookupDataSet = DeleteTimesTab
      LookupKeyFields = 'FD_ID'
      LookupResultField = 'FD_NAME'
      KeyFields = 'FD_ID'
      Size = 100
      Lookup = True
    end
    object DataTabUploaded: TBooleanField
      FieldName = 'Uploaded'
    end
  end
  object DataSource1: TDataSource
    DataSet = DataTab
    Left = 216
    Top = 56
  end
  object DeleteTimesTab: TFDMemTable
    FieldDefs = <>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 376
    Top = 64
    object DeleteTimesTabFD_ID: TIntegerField
      FieldName = 'FD_ID'
    end
    object DeleteTimesTabFD_NAME: TStringField
      FieldName = 'FD_NAME'
      Size = 100
    end
    object DeleteTimesTabFD_MONATE: TIntegerField
      FieldName = 'FD_MONATE'
    end
  end
end
