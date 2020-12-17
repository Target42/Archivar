object TaskLoaderMod: TTaskLoaderMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 238
  Width = 371
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTaskView'
    Left = 104
    Top = 32
  end
  object GetTAQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
    ProviderName = 'GetTAQry'
    RemoteServer = DSProviderConnection1
    Left = 72
    Top = 104
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
    Left = 128
    Top = 104
  end
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTab'
    RemoteServer = DSProviderConnection1
    Left = 200
    Top = 104
  end
end
