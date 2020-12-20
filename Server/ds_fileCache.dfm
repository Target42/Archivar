object dsFileCache: TdsFileCache
  OldCreateOrder = False
  Height = 244
  Width = 295
  object HC: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'HC_HTTP'
    UniDirectional = False
    Left = 64
    Top = 56
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 152
    Top = 64
  end
  object HCTab: TDataSetProvider
    DataSet = HC
    Left = 64
    Top = 112
  end
end
