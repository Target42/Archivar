object DSImport: TDSImport
  OnCreate = DSServerModuleCreate
  Height = 309
  Width = 648
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 40
    Top = 24
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 127
    Top = 16
  end
  object Task: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TA_TASK'
    TableName = 'TA_TASK'
    Left = 40
    Top = 80
  end
  object TaskTab: TDataSetProvider
    DataSet = Task
    Left = 40
    Top = 136
  end
  object Template: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate]
    UpdateOptions.EnableDelete = False
    UpdateOptions.EnableInsert = False
    UpdateOptions.EnableUpdate = False
    UpdateOptions.UpdateTableName = 'TE_TEMPLATE'
    TableName = 'TE_TEMPLATE'
    Left = 112
    Top = 80
  end
  object GRTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'GR_GREMIUM'
    TableName = 'GR_GREMIUM'
    Left = 176
    Top = 72
  end
  object TOTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 144
    Top = 160
  end
  object findTaskQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :ta_id')
    Left = 256
    Top = 56
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CreateDirQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'INSERT INTO DR_DIR (DR_ID, DR_GROUP)'
      'VALUES ('
      '    :DR_ID, '
      '    :DR_GROUP'
      ');')
    Left = 392
    Top = 40
    ParamData = <
      item
        Name = 'DR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'DR_GROUP'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FileData: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'FI_FILE'
    TableName = 'FI_FILE'
    Left = 392
    Top = 104
  end
  object UpdateDirSum: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update DR_DIR'
      'set dr_size = ('
      'SELECT sum(FI_SIZE)'
      'FROM FI_FILE r'
      'where dr_id = :id'
      ')'
      'where dr_id = :id;')
    Left = 392
    Top = 168
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UpdateTask: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'UPDATE TA_TASK a'
      'SET '
      '    a.DR_ID = :dr_id'
      'WHERE'
      '    a.TA_ID = :ta_id')
    Left = 504
    Top = 40
    ParamData = <
      item
        Name = 'DR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
