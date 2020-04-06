object dsImage: TdsImage
  OldCreateOrder = False
  Height = 150
  Width = 215
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 112
    Top = 16
  end
  object PicTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PI_PIC'
    UniDirectional = False
    Left = 32
    Top = 24
  end
  object PicturesTab: TDataSetProvider
    DataSet = PicTab
    Left = 32
    Top = 80
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 111
    Top = 80
  end
end
