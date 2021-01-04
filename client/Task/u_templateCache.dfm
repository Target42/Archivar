object TemplateCacheMod: TTemplateCacheMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 349
  Width = 575
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTaskView'
    Left = 104
    Top = 32
  end
  object GetTEQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'TE_ID'
        ParamType = ptInput
      end>
    ProviderName = 'GetTEQry'
    RemoteServer = DSProviderConnection1
    Left = 96
    Top = 88
  end
  object GetSysTeQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftString
        Name = 'clid'
        ParamType = ptInput
      end>
    ProviderName = 'GetSysTeQry'
    RemoteServer = DSProviderConnection1
    Left = 176
    Top = 88
  end
end
