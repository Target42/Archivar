object dsTemplate: TdsTemplate
  OldCreateOrder = False
  Height = 254
  Width = 453
  object TETab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TE_TEMPLATE'
    UniDirectional = False
    Left = 32
    Top = 112
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 120
    Top = 32
  end
  object TemplateTab: TDataSetProvider
    DataSet = TETab
    Left = 32
    Top = 160
  end
  object TEQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TE_SYSTEM = :sys'
      'and TE_STATE = :state'
      'order by TE_NAME')
    Left = 120
    Top = 120
    ParamData = <
      item
        DataType = ftString
        Name = 'sys'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'state'
        ParamType = ptInput
      end>
  end
  object ListTempatesQry: TDataSetProvider
    DataSet = TEQry
    Left = 120
    Top = 168
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 208
    Top = 32
  end
  object SearchTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    UniDirectional = False
    Left = 176
    Top = 120
  end
  object DaTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction2
    BufferChunks = 1000
    CachedUpdates = False
    IndexName = 'DA_DATAFIELD_SEC'
    TableName = 'DA_DATAFIELD'
    UniDirectional = False
    Left = 296
    Top = 96
  end
  object IBTransaction2: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 368
    Top = 96
  end
  object DataFields: TDataSetProvider
    DataSet = DaTab
    Left = 296
    Top = 152
  end
  object TaskType: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    IndexName = 'TY_TASKTYPE_SEC'
    TableName = 'TY_TASKTYPE'
    UniDirectional = False
    Left = 312
    Top = 8
  end
  object TYTab: TDataSetProvider
    DataSet = TaskType
    Left = 384
    Top = 16
  end
end
