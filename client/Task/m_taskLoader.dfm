object TaskLoaderMod: TTaskLoaderMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 325
  Width = 601
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTaskView'
    Connected = True
    SQLConnection = GM.SQLConnection1
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
  object BECTTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'BECTTab'
    RemoteServer = DSProviderConnection1
    Left = 288
    Top = 112
  end
  object BEListQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'ctid'
        ParamType = ptInput
      end>
    ProviderName = 'BEListQry'
    RemoteServer = DSProviderConnection1
    Left = 352
    Top = 112
  end
  object BETab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'BETab'
    RemoteServer = DSProviderConnection1
    Left = 440
    Top = 112
  end
end
