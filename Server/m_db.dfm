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
    Left = 38
    Top = 28
  end
  object FDTransaction1: TFDTransaction
    Connection = ArchivarConnection
    Left = 40
    Top = 80
  end
  object FDManager1: TFDManager
    ConnectionDefFileAutoLoad = False
    ConnectionDefFileName = 'D:\git\ber.git\Bin\Server\FDConnectionDefs.ini'
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 128
    Top = 24
  end
  object FDFBNBackup1: TFDFBNBackup
    DriverLink = FDPhysFBDriverLink1
    Left = 264
    Top = 88
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 264
    Top = 40
  end
end
