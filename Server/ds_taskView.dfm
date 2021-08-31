object dsTaskView: TdsTaskView
  OldCreateOrder = False
  Height = 334
  Width = 623
  object GetTAQry: TDataSetProvider
    DataSet = GetTA
    Left = 40
    Top = 184
  end
  object GetTEQry: TDataSetProvider
    DataSet = GetTE
    Left = 112
    Top = 192
  end
  object TaskTab: TDataSetProvider
    DataSet = Task
    Left = 264
    Top = 184
  end
  object BETab: TDataSetProvider
    DataSet = BE
    Left = 464
    Top = 176
  end
  object GetSysTeQry: TDataSetProvider
    DataSet = GetSysTe
    Left = 136
    Top = 136
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 272
    Top = 48
  end
  object Task: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 264
    Top = 112
  end
  object BE: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'BE_BESCHLUS'
    TableName = 'BE_BESCHLUS'
    Left = 464
    Top = 112
  end
  object GetTA: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 40
    Top = 48
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object GetTE: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TE_ID = :TE_ID')
    Left = 40
    Top = 120
    ParamData = <
      item
        Name = 'TE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object GetSysTe: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TE_CLID = :clid')
    Left = 144
    Top = 80
    ParamData = <
      item
        Name = 'CLID'
        DataType = ftString
        ParamType = ptInput
      end>
  end
end
