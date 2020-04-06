object dsPerson: TdsPerson
  OldCreateOrder = False
  Height = 362
  Width = 489
  object PETable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Filter = 'PE_ID >9'
    Filtered = True
    TableName = 'PE_PERSON'
    UniDirectional = False
    Left = 56
    Top = 48
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 48
  end
  object PETab: TDataSetProvider
    DataSet = PETable
    Left = 56
    Top = 104
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
  object JvCsvDataSet1: TJvCsvDataSet
    CaseInsensitive = True
    Separator = ';'
    SavesChanges = False
    AutoBackupCount = 0
    Left = 368
    Top = 104
  end
end
