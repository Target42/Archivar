object dsTaskEdit: TdsTaskEdit
  OldCreateOrder = False
  Height = 227
  Width = 338
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 16
    Top = 16
  end
  object DataField: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    IndexName = 'DA_DATAFIELD_SEC'
    TableName = 'DA_DATAFIELD'
    UniDirectional = False
    Left = 80
    Top = 56
  end
  object DATab: TDataSetProvider
    DataSet = DataField
    Left = 80
    Top = 104
  end
end
