object dsTaskEdit: TdsTaskEdit
  OldCreateOrder = False
  Height = 227
  Width = 338
  object DATab: TDataSetProvider
    DataSet = DataField
    Left = 80
    Top = 104
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 16
    Top = 16
  end
  object DataField: TFDTable
    ObjectView = False
    IndexName = 'DA_DATAFIELD_SEC'
    Connection = DBMod.ArchivarConnection
    UpdateTransaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'DA_DATAFIELD'
    TableName = 'DA_DATAFIELD'
    Left = 80
    Top = 56
  end
end
