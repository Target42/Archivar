object DSImport: TDSImport
  OldCreateOrder = False
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
end
