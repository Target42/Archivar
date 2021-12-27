object dsStorage: TdsStorage
  OldCreateOrder = False
  Height = 285
  Width = 624
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 64
    Top = 40
  end
  object AutoIncQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    Left = 64
    Top = 96
  end
  object Storages: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'ST_STORAGE'
    TableName = 'ST_STORAGE'
    Left = 64
    Top = 152
  end
  object StorageTab: TDataSetProvider
    DataSet = Storages
    Left = 64
    Top = 208
  end
  object DRTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'DR_DIR'
    TableName = 'DR_DIR'
    Left = 232
    Top = 56
  end
  object STTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'ST_STORAGE'
    TableName = 'ST_STORAGE'
    Left = 240
    Top = 112
  end
  object FDTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 232
    Top = 8
  end
  object CountFolder: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT count(*)'
      'FROM DR_DIR '
      'where dr_group = :grp')
    Left = 232
    Top = 176
    ParamData = <
      item
        Name = 'GRP'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CountFolderQry: TDataSetProvider
    DataSet = CountFolder
    Left = 232
    Top = 224
  end
  object CountFiles: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT count(FI_ID)    '
      'FROM FI_FILE a'
      'where a.dr_id in'
      '( '
      '  select dr_id from DR_DIR'
      '  where dr_group = :grp'
      ')')
    Left = 296
    Top = 176
    ParamData = <
      item
        Name = 'GRP'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CountFilesQry: TDataSetProvider
    DataSet = CountFiles
    Left = 304
    Top = 224
  end
  object Memory: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT sum(DR_SIZE)'
      'FROM DR_DIR '
      'where DR_GROUP = :grp')
    Left = 384
    Top = 184
    ParamData = <
      item
        Name = 'GRP'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object MemoryQry: TDataSetProvider
    DataSet = Memory
    Left = 384
    Top = 232
  end
end
