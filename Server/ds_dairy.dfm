object dsDairy: TdsDairy
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 249
  Width = 413
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
    Left = 96
    Top = 40
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 16
    Top = 8
  end
  object DISrc: TDataSetProvider
    DataSet = DITab
    Left = 88
    Top = 96
  end
  object DataQry: TFDQuery
    BeforeOpen = DataQryBeforeOpen
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM DI_DAIRY r'
      'where '
      'cast(DI_STAMP as Date) >= :start and'
      'cast( DI_STAMP as Date ) <= :ende'
      'and pe_id = :pe_id')
    Left = 152
    Top = 48
    ParamData = <
      item
        Name = 'START'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'ENDE'
        DataType = ftDate
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DataSrc: TDataSetProvider
    DataSet = DataQry
    Left = 152
    Top = 96
  end
end
