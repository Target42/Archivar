object dsPerson: TdsPerson
  OldCreateOrder = False
  Height = 362
  Width = 489
  object PETab: TDataSetProvider
    DataSet = PETable
    Left = 56
    Top = 104
  end
  object JvCsvDataSet1: TJvCsvDataSet
    CaseInsensitive = True
    Separator = ';'
    SavesChanges = False
    AutoBackupCount = 0
    Left = 368
    Top = 104
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 144
    Top = 48
  end
  object PETable: TFDTable
    Filtered = True
    Filter = 'PE_ID >9'
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'PE_PERSON'
    TableName = 'PE_PERSON'
    Left = 56
    Top = 48
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 248
    Top = 32
  end
end
