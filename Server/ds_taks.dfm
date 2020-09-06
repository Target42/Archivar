object dsTask: TdsTask
  OldCreateOrder = False
  Height = 472
  Width = 689
  object TaskTypesQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TY_TASKTYPE'
      'order by TY_NAME')
    Left = 48
    Top = 80
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 168
    Top = 32
  end
  object TaskTypes: TDataSetProvider
    DataSet = TaskTypesQry
    Left = 56
    Top = 136
  end
  object TaskTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TA_TASK'
    UpdateObject = IBUpdateSQL1
    UniDirectional = False
    Left = 136
    Top = 88
  end
  object Task: TDataSetProvider
    DataSet = TaskTab
    Left = 136
    Top = 144
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 248
    Top = 32
  end
  object GremiumQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from GR_GREMIUM'
      'order by GR_NAME')
    Left = 248
    Top = 104
  end
  object GremiumList: TDataSetProvider
    DataSet = GremiumQry
    Left = 248
    Top = 160
  end
  object OpenTasks: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TO_OPEN'
    UniDirectional = False
    Left = 328
    Top = 152
  end
  object ArchivQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'insert into GR_ARCHIV( GR_ID, TA_ID)'
      'values( :gr_id, :ta_id);')
    Left = 448
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object RemoveOpenTask: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :ta_id')
    Left = 448
    Top = 336
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object DeleteTrans: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Left = 528
    Top = 216
  end
  object RemoveTask: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :ta_id')
    Left = 328
    Top = 224
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object AddTask: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'insert into TO_OPEN( GR_ID, TA_ID)'
      'values( :GR_ID, :TA_ID)')
    Left = 328
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object SetFlagQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update TA_TASK'
      'set TA_FLAGS = :TA_FLAGS'
      'where TA_ID = :TA_ID')
    Left = 512
    Top = 56
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_FLAGS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object DeleteOpenTA: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :TA_ID')
    Left = 64
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object DeleteFITA: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from FI_TA'
      'where TA_ID = :TA_ID')
    Left = 64
    Top = 352
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object DeleteFiles: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from FI_FILE '
      'where FI_ID in'
      '(select FI_ID from FI_TA'
      'where TA_ID = :TA_ID)')
    Left = 64
    Top = 296
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object DeleteTaskQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 64
    Top = 408
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object TATab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TO_OPEN'
    UniDirectional = False
    Left = 344
    Top = 40
  end
  object FindTask: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 448
    Top = 216
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object SetStatusQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update TA_TASK'
      'set TA_FLAGS = :TA_FLAGS, TA_STATUS = :TA_STATUS'
      'where TA_ID = :TA_ID')
    Left = 344
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_FLAGS'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'TA_STATUS'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object TaskClidQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 128
    Top = 360
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object DelEinstellung: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from ES_EINSTELLUNG'
      'where ES_ID = :ES_ID')
    Left = 152
    Top = 424
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ES_ID'
        ParamType = ptInput
      end>
  end
  object Templates: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TY_ID = :id')
    Left = 304
    Top = 360
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end>
  end
  object TemplatesQry: TDataSetProvider
    DataSet = Templates
    Left = 304
    Top = 408
  end
  object Template: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TE_TEMPLATE'
    UniDirectional = False
    Left = 592
    Top = 328
  end
  object TemplateTab: TDataSetProvider
    DataSet = Template
    Left = 592
    Top = 400
  end
  object IBUpdateSQL1: TIBUpdateSQL
    Left = 192
    Top = 232
  end
  object TaskTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TA_TASK'
    UniDirectional = False
    Left = 624
    Top = 32
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 624
    Top = 152
  end
  object TaskTableSrc: TDataSetProvider
    DataSet = TaskTable
    UpdateMode = upWhereKeyOnly
    Left = 624
    Top = 80
  end
end
