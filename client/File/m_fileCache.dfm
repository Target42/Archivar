object FileCacheMod: TFileCacheMod
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 263
  Width = 331
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsFileCache'
    Left = 56
    Top = 32
  end
  object FCTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'FCTab'
    RemoteServer = DSProviderConnection1
    Left = 64
    Top = 88
  end
  object FLTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'FLTab'
    RemoteServer = DSProviderConnection1
    Left = 136
    Top = 88
  end
end
