object dsFileCache: TdsFileCache
  OldCreateOrder = False
  Height = 323
  Width = 639
  object HCTab: TDataSetProvider
    DataSet = HC
    Left = 64
    Top = 112
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 144
    Top = 64
  end
  object HC: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'HC_HTTP'
    TableName = 'HC_HTTP'
    Left = 64
    Top = 56
  end
  object FileCache: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'FC_FILE_CACHE'
    TableName = 'FC_FILE_CACHE'
    Left = 263
    Top = 144
  end
  object FCTab: TDataSetProvider
    DataSet = FileCache
    Left = 263
    Top = 200
  end
  object FileDelQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'delete FROM FC_FILE_CACHE'
      'where upper(FC_CACHE) = :cache'
      'and upper(FC_NAME) = :name')
    Left = 392
    Top = 88
    ParamData = <
      item
        Name = 'CACHE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object FDTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 480
    Top = 96
  end
  object UploadTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'FC_FILE_CACHE'
    TableName = 'FC_FILE_CACHE'
    Left = 392
    Top = 144
  end
end
