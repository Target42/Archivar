object dsTaskView: TdsTaskView
  OldCreateOrder = False
  Height = 334
  Width = 623
  object GetTA: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 40
    Top = 48
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object GetTE: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TE_ID = :TE_ID')
    Left = 104
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TE_ID'
        ParamType = ptInput
      end>
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 272
    Top = 48
  end
  object GetTAQry: TDataSetProvider
    DataSet = GetTA
    Left = 40
    Top = 184
  end
  object GetTEQry: TDataSetProvider
    DataSet = GetTE
    Left = 112
    Top = 192
  end
  object Task: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    UniDirectional = False
    Left = 264
    Top = 112
  end
  object TaskTab: TDataSetProvider
    DataSet = Task
    Left = 264
    Top = 184
  end
end
