object AdminMod: TAdminMod
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 249
  Width = 466
  object GremiumQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from GR_GREMIUM')
    Left = 32
    Top = 72
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Left = 32
    Top = 16
  end
  object DeleteQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FD_DELETE'
      'order by FD_MONATE')
    Left = 32
    Top = 144
  end
end
