object FileFrame: TFileFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 451
    Height = 227
    Align = alClient
    DataSource = LitFilesSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
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
        FieldName = 'FI_NAME'
        Title.Caption = 'Name'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FI_TYPE'
        Title.Caption = 'Type'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FI_CREATED'
        Title.Caption = 'Angelegt'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FI_TODELETE'
        Title.Caption = 'L'#246'schdatum'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'FI_VERSION'
        Title.Caption = 'Version'
        Width = 40
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 227
    Width = 451
    Height = 78
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 1
    object Button1: TButton
      Left = 16
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Upload'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 112
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Download'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 216
      Top = 32
      Width = 75
      Height = 25
      Caption = 'L'#246'schen'
      TabOrder = 2
      OnClick = Button3Click
    end
    object Panel1: TPanel
      Left = 330
      Top = 15
      Width = 119
      Height = 61
      Align = alRight
      Caption = 'Dropzone'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 3
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsFile'
    Left = 64
    Top = 32
  end
  object ListFilesQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
    ProviderName = 'ListFilesQry'
    RemoteServer = DSProviderConnection1
    Left = 64
    Top = 88
  end
  object LitFilesSrc: TDataSource
    DataSet = ListFilesQry
    Left = 144
    Top = 88
  end
  object JvDragDrop1: TJvDragDrop
    DropTarget = Panel1
    OnDrop = JvDragDrop1Drop
    Left = 142
    Top = 164
  end
  object OpenDialog1: TOpenDialog
    Options = [ofHideReadOnly, ofAllowMultiSelect, ofFileMustExist, ofEnableSizing]
    Left = 48
    Top = 179
  end
end
