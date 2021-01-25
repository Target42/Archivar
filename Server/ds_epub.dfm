object dsEpub: TdsEpub
  OldCreateOrder = False
  Height = 329
  Width = 381
  object ePub: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EP_EPUB'
    UniDirectional = False
    Left = 88
    Top = 88
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Left = 224
    Top = 104
  end
  object ePubTab: TDataSetProvider
    DataSet = ePub
    Left = 88
    Top = 136
  end
end
