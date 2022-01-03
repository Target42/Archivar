object DBMod: TDBMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 256
  Width = 364
  object ArchivarConnection: TFDConnection
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
    ConnectionDefFileName = 'D:\git\ber.git\Bin\Server\FDConnectionDefs.ini'
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Active = True
    Left = 128
    Top = 24
  end
end
