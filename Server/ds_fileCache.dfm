object dsFileCache: TdsFileCache
  OldCreateOrder = False
  Height = 244
  Width = 295
  object HCTab: TDataSetProvider
    DataSet = HC
    Left = 64
    Top = 112
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 144
    Top = 64
  end
  object HC: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'HC_HTTP'
    TableName = 'HC_HTTP'
    Left = 64
    Top = 56
  end
end
