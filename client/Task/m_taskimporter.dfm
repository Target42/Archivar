object TaskImporterMod: TTaskImporterMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 356
  Width = 546
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTask'
    Left = 39
    Top = 22
  end
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTableSrc'
    RemoteServer = DSProviderConnection1
    Left = 144
    Top = 24
    object TaskTabTA_REST: TStringField
      FieldKind = fkCalculated
      FieldName = 'TA_REST'
      Size = 10
      Calculated = True
    end
    object TaskTabTE_ID: TIntegerField
      FieldName = 'TE_ID'
      Origin = 'TE_ID'
    end
    object TaskTabTA_ID: TIntegerField
      FieldName = 'TA_ID'
      Origin = 'TA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TaskTabTY_ID: TIntegerField
      FieldName = 'TY_ID'
      Origin = 'TY_ID'
    end
    object TaskTabTA_STARTED: TDateField
      FieldName = 'TA_STARTED'
      Origin = 'TA_STARTED'
    end
    object TaskTabTA_CREATED: TSQLTimeStampField
      FieldName = 'TA_CREATED'
      Origin = 'TA_CREATED'
    end
    object TaskTabTA_NAME: TStringField
      FieldName = 'TA_NAME'
      Origin = 'TA_NAME'
      Size = 200
    end
    object TaskTabTA_DATA: TBlobField
      FieldName = 'TA_DATA'
      Origin = 'TA_DATA'
    end
    object TaskTabTA_CREATED_BY: TStringField
      FieldName = 'TA_CREATED_BY'
      Origin = 'TA_CREATED_BY'
      Size = 200
    end
    object TaskTabTA_TERMIN: TDateField
      FieldName = 'TA_TERMIN'
      Origin = 'TA_TERMIN'
    end
    object TaskTabTA_CLID: TStringField
      FieldName = 'TA_CLID'
      Origin = 'TA_CLID'
      Size = 38
    end
    object TaskTabTA_FLAGS: TIntegerField
      FieldName = 'TA_FLAGS'
      Origin = 'TA_FLAGS'
    end
    object TaskTabTA_STATUS: TStringField
      FieldName = 'TA_STATUS'
      Origin = 'TA_STATUS'
      Size = 50
    end
    object TaskTabTA_STYLE: TStringField
      FieldName = 'TA_STYLE'
      Origin = 'TA_STYLE'
      Size = 200
    end
    object TaskTabTA_STYLE_CLID: TStringField
      FieldName = 'TA_STYLE_CLID'
      Origin = 'TA_STYLE_CLID'
      Size = 38
    end
    object TaskTabTA_REM: TStringField
      FieldName = 'TA_REM'
      Origin = 'TA_REM'
      Size = 256
    end
    object TaskTabTA_COLOR: TIntegerField
      FieldName = 'TA_COLOR'
      Origin = 'TA_COLOR'
    end
    object TaskTabTA_DELETED: TStringField
      FieldName = 'TA_DELETED'
      Origin = 'TA_DELETED'
      FixedChar = True
      Size = 1
    end
    object TaskTabTA_BEARBEITER: TStringField
      FieldName = 'TA_BEARBEITER'
      Origin = 'TA_BEARBEITER'
      Size = 255
    end
  end
end
