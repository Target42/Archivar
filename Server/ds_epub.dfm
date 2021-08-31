object dsEpub: TdsEpub
  OldCreateOrder = False
  Height = 329
  Width = 381
  object ePubTab: TDataSetProvider
    DataSet = ePub
    Left = 40
    Top = 120
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 40
    Top = 8
  end
  object ePub: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'EP_EPUB'
    TableName = 'EP_EPUB'
    Left = 32
    Top = 72
  end
end
