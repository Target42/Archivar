object TaskListFrame: TTaskListFrame
  Left = 0
  Top = 0
  Width = 748
  Height = 305
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 748
    Height = 305
    Align = alClient
    DataSource = TaskSrc
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgMultiSelect, dgTitleClick, dgTitleHotTrack]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyUp = DBGrid1KeyUp
    Columns = <
      item
        Expanded = False
        FieldName = 'TA_NAME'
        Title.Caption = 'Titel'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TA_TERMIN'
        Title.Caption = 'Termin'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'clacRest'
        Title.Caption = 'Verbleiben'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TY_NAME'
        Title.Caption = 'Type'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TA_CREATED_BY'
        Title.Caption = 'Erzeugt'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TA_STARTED'
        Title.Caption = 'Eingang'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Unread'
        Title.Caption = 'Status'
        Visible = True
      end>
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 376
    Top = 56
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMisc'
    Connected = True
    SQLConnection = GM.SQLConnection1
    Left = 72
    Top = 16
  end
  object Tasks: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
    ProviderName = 'OpenTaskQry'
    RemoteServer = DSProviderConnection1
    Left = 144
    Top = 16
    object TaskscalcCreated: TDateField
      FieldKind = fkCalculated
      FieldName = 'calcCreated'
      OnGetText = TaskscalcCreatedGetText
      Calculated = True
    end
    object TasksclacRest: TStringField
      FieldKind = fkCalculated
      FieldName = 'clacRest'
      OnGetText = TasksclacRestGetText
      Calculated = True
    end
    object TasksUnread: TStringField
      FieldKind = fkCalculated
      FieldName = 'Unread'
      OnGetText = TasksUnreadGetText
      Calculated = True
    end
    object TasksGR_ID: TIntegerField
      FieldName = 'GR_ID'
      Required = True
    end
    object TasksTA_ID: TIntegerField
      FieldName = 'TA_ID'
      Required = True
    end
    object TasksTA_ID1: TIntegerField
      FieldName = 'TA_ID1'
      Required = True
    end
    object TasksTY_ID: TIntegerField
      FieldName = 'TY_ID'
    end
    object TasksTA_STARTED: TDateField
      FieldName = 'TA_STARTED'
    end
    object TasksTA_CREATED: TDateTimeField
      FieldName = 'TA_CREATED'
    end
    object TasksTA_NAME: TWideStringField
      FieldName = 'TA_NAME'
      Size = 200
    end
    object TasksTA_DATA: TBlobField
      FieldName = 'TA_DATA'
      Size = 8
    end
    object TasksTA_CREATED_BY: TWideStringField
      FieldName = 'TA_CREATED_BY'
      Size = 200
    end
    object TasksTA_TERMIN: TDateField
      FieldName = 'TA_TERMIN'
    end
    object TasksTA_CLID: TWideStringField
      FieldName = 'TA_CLID'
      Size = 38
    end
    object TasksTA_FLAGS: TIntegerField
      FieldName = 'TA_FLAGS'
    end
    object TasksTA_STATUS: TWideStringField
      FieldName = 'TA_STATUS'
      Size = 50
    end
    object TasksTY_ID1: TIntegerField
      FieldName = 'TY_ID1'
      Required = True
    end
    object TasksTY_NAME: TWideStringField
      FieldName = 'TY_NAME'
      Size = 100
    end
    object TasksTY_TAGE: TIntegerField
      FieldName = 'TY_TAGE'
    end
  end
  object TaskSrc: TDataSource
    DataSet = Tasks
    Left = 264
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 56
    Top = 112
    object Verschieben1: TMenuItem
      Action = av_move
    end
    object Lschen1: TMenuItem
      Action = av_delete
    end
  end
  object ActionList1: TActionList
    Left = 200
    Top = 136
    object av_move: TAction
      Caption = 'Verschieben'
      OnExecute = av_moveExecute
    end
    object av_delete: TAction
      Caption = '&L'#246'schen'
      OnExecute = av_deleteExecute
    end
  end
end
