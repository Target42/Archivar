object AdminMod: TAdminMod
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 249
  Width = 466
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 40
    Top = 16
  end
  object GremiumQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from GR_GREMIUM')
    Left = 40
    Top = 80
  end
  object DeleteQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from FD_DELETE'
      'order by FD_MONATE')
    Left = 32
    Top = 144
  end
end
