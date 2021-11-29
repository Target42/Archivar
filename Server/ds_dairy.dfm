object dsDairy: TdsDairy
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 249
  Width = 215
  object DITab: TFDTable
    BeforePost = DITabBeforePost
    IndexFieldNames = 'DI_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.AssignedValues = [uvGeneratorName]
    UpdateOptions.GeneratorName = 'GEN_DI_ID'
    UpdateOptions.UpdateTableName = 'DI_DAIRY'
    UpdateOptions.AutoIncFields = 'DI_ID'
    TableName = 'DI_DAIRY'
    Left = 56
    Top = 40
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 136
    Top = 24
  end
  object DISrc: TDataSetProvider
    DataSet = DITab
    Left = 56
    Top = 96
  end
end
