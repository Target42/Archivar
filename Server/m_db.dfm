object DBMod: TDBMod
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 256
  Width = 364
  object ArchivarConnection: TFDConnection
    Params.Strings = (
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=c:\db\ARCHIVAR.FDB'
      'MonitorBy=Remote'
      'DriverID=FB'
      'Pooled=True')
    ResourceOptions.AssignedValues = [rvCmdExecMode, rvAutoReconnect]
    ResourceOptions.CmdExecMode = amNonBlocking
    ResourceOptions.AutoReconnect = True
    LoginPrompt = False
    Transaction = FDTransaction1
    Left = 62
    Top = 28
  end
  object FDTransaction1: TFDTransaction
    Connection = ArchivarConnection
    Left = 40
    Top = 80
  end
  object FDManager1: TFDManager
    ConnectionDefFileName = '.\FDConnectionDefs.ini'
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <>
    Left = 160
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
  object FDMoniRemoteClientLink1: TFDMoniRemoteClientLink
    EventKinds = [ekLiveCycle, ekError, ekConnConnect, ekConnTransact, ekAdaptUpdate]
    Left = 56
    Top = 144
  end
end
