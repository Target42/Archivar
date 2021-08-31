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
    Connected = True
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 262
    Top = 20
  end
  object FDTransaction1: TFDTransaction
    Connection = ArchivarConnection
    Left = 264
    Top = 72
  end
end
