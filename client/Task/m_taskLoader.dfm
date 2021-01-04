object TaskLoaderMod: TTaskLoaderMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 325
  Width = 601
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
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTab'
    RemoteServer = DSProviderConnection1
    Left = 200
    Top = 104
  end
end
