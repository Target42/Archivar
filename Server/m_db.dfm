object DBMod: TDBMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 256
  Width = 364
  object ArchivarConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=D:\db\ARCHIVAR.FDB'
      'DriverID=FB')
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 38
    Top = 28
  end
  object FDTransaction1: TFDTransaction
    Connection = ArchivarConnection
    Left = 40
    Top = 80
  end
end
