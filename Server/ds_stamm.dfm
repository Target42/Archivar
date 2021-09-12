object StammMod: TStammMod
  OldCreateOrder = False
  Height = 302
  Width = 215
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 48
    Top = 25
  end
  object TaskType: TFDTable
    IndexName = 'TY_TASKTYPE_SEC'
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'TY_TASKTYPE'
    TableName = 'TY_TASKTYPE'
    Left = 48
    Top = 88
  end
  object TYTab: TDataSetProvider
    DataSet = TaskType
    Left = 48
    Top = 144
  end
end
