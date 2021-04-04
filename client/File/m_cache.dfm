object CacheMod: TCacheMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 243
  Width = 325
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsFileCache'
    Left = 56
    Top = 32
  end
  object HCTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'HCTab'
    RemoteServer = DSProviderConnection1
    Left = 64
    Top = 96
  end
end
