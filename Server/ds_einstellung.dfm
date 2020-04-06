object dsEinstellung: TdsEinstellung
  OldCreateOrder = False
  OnDestroy = DSServerModuleDestroy
  Height = 325
  Width = 531
  object Task: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TA_TASK'
    UpdateObject = IBUpdateSQL2
    UniDirectional = False
    Left = 56
    Top = 80
  end
  object Einstellung: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'ES_EINSTELLUNG'
    UpdateObject = IBUpdateSQL1
    UniDirectional = False
    Left = 256
    Top = 136
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 128
    Top = 16
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
  object TaskTab: TDataSetProvider
    DataSet = Task
    UpdateMode = upWhereChanged
    Left = 32
    Top = 248
  end
  object DataTab: TDataSetProvider
    DataSet = Einstellung
    Left = 96
    Top = 248
  end
  object TaskInfo: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_GR a, TA_TASK b'
      'where a.TA_ID = :ta_id'
      'and a.TA_ID = b.TA_ID')
    Left = 144
    Top = 80
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ta_id'
        ParamType = ptUnknown
      end>
  end
  object GremiumQry: TDataSetProvider
    DataSet = TaskInfo
    Left = 168
    Top = 248
  end
  object EinstellungTab: TDataSetProvider
    DataSet = Einstellung
    UpdateMode = upWhereChanged
    OnUpdateError = EinstellungTabUpdateError
    Left = 240
    Top = 248
  end
  object FindTaskQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = UdateTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_TASK'
      'where ta_id = :ta_id')
    Left = 392
    Top = 32
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object AddDataQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = UdateTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'insert into ES_EINSTELLUNG(ES_ID)'
      'values( :es_id);')
    Left = 392
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'es_id'
        ParamType = ptInput
      end>
  end
  object UpdateTask: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = UdateTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update TA_TASK'
      'set TA_SUB_ID = :id'
      'where TA_ID = :ta_id')
    Left = 392
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object IBUpdateSQL1: TIBUpdateSQL
    Left = 312
    Top = 248
  end
  object IBUpdateSQL2: TIBUpdateSQL
    Left = 56
    Top = 128
  end
  object UdateTrans: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 472
    Top = 88
  end
end
