object dsSitzung: TdsSitzung
  OldCreateOrder = False
  Height = 268
  Width = 486
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 40
    Top = 24
  end
  object ELTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_EINLADUNG'
    UniDirectional = False
    Left = 120
    Top = 24
  end
  object ELSrc: TDataSetProvider
    DataSet = ELTab
    Left = 120
    Top = 80
  end
end
