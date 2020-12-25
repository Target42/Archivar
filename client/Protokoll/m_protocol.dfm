object ProtocolMod: TProtocolMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 374
  Width = 526
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsProtocol'
    Left = 72
    Top = 8
  end
  object PRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PRTable'
    RemoteServer = DSProviderConnection1
    Left = 32
    Top = 56
  end
  object CPTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ChapterTab'
    RemoteServer = DSProviderConnection1
    Left = 28
    Top = 120
  end
  object CPTextTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'CPTextTab'
    RemoteServer = DSProviderConnection1
    Left = 28
    Top = 177
  end
  object UpdateCPQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'CP_NR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CP_TITLE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CP_ID'
        ParamType = ptInput
      end>
    ProviderName = 'UpdateCPQry'
    RemoteServer = DSProviderConnection1
    Left = 100
    Top = 240
  end
  object TNTab: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PR_ID'
    Params = <>
    ProviderName = 'Teilnehmer'
    RemoteServer = DSProviderConnection1
    BeforePost = TNTabBeforePost
    Left = 116
    Top = 64
    object TNTabPR_ID: TIntegerField
      FieldName = 'PR_ID'
      Required = True
    end
    object TNTabTN_ID: TIntegerField
      FieldName = 'TN_ID'
      Required = True
    end
    object TNTabTN_NAME: TWideStringField
      FieldName = 'TN_NAME'
      Size = 100
    end
    object TNTabTN_VORNAME: TWideStringField
      FieldName = 'TN_VORNAME'
      Size = 100
    end
    object TNTabTN_DEPARTMENT: TWideStringField
      FieldName = 'TN_DEPARTMENT'
      Size = 25
    end
    object TNTabTN_ROLLE: TWideStringField
      FieldName = 'TN_ROLLE'
      Size = 50
    end
    object TNTabTN_STATUS: TIntegerField
      FieldName = 'TN_STATUS'
    end
    object TNTabPE_ID: TIntegerField
      FieldName = 'PE_ID'
    end
    object TNTabTN_GRUND: TWideStringField
      FieldName = 'TN_GRUND'
      Size = 100
    end
  end
  object TGTab: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'PR_ID'
    Params = <>
    ProviderName = 'TGTable'
    RemoteServer = DSProviderConnection1
    BeforePost = TGTabBeforePost
    Left = 168
    Top = 64
  end
end
