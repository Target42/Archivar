object dsTemplate: TdsTemplate
  OldCreateOrder = False
  Height = 266
  Width = 724
  object TemplateTab: TDataSetProvider
    DataSet = TETab
    Left = 32
    Top = 160
  end
  object ListTempatesQry: TDataSetProvider
    DataSet = TEQry
    Left = 192
    Top = 160
  end
  object DataFields: TDataSetProvider
    DataSet = DaTab
    Left = 488
    Top = 72
  end
  object TYTab: TDataSetProvider
    DataSet = TaskType
    Left = 120
    Top = 160
  end
  object IBTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 560
    Top = 16
  end
  object DaTab: TFDTable
    ObjectView = False
    IndexName = 'DA_DATAFIELD_SEC'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction2
    UpdateOptions.UpdateTableName = 'DA_DATAFIELD'
    TableName = 'DA_DATAFIELD'
    Left = 488
    Top = 16
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 120
    Top = 32
  end
  object TETab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TE_TEMPLATE'
    TableName = 'TE_TEMPLATE'
    Left = 32
    Top = 112
  end
  object SearchTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 72
    Top = 112
  end
  object TaskType: TFDTable
    ObjectView = False
    IndexName = 'TY_TASKTYPE_SEC'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TY_TASKTYPE'
    TableName = 'TY_TASKTYPE'
    Left = 120
    Top = 112
  end
  object TEQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TE_SYSTEM = :sys'
      'and TE_STATE = :state'
      'order by TE_NAME')
    Left = 192
    Top = 112
    ParamData = <
      item
        Name = 'SYS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'STATE'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Left = 208
    Top = 32
  end
  object FindCLIDQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT *'
      'FROM TE_TEMPLATE '
      'where te_clid = :clid')
    Left = 352
    Top = 144
    ParamData = <
      item
        Name = 'CLID'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end>
  end
end
