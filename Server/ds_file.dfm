object dsFile: TdsFile
  OldCreateOrder = False
  Height = 321
  Width = 485
  object ListFilesQry: TDataSetProvider
    DataSet = ListFiles
    Left = 56
    Top = 176
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 360
    Top = 48
  end
  object FITA: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'FI_TA'
    TableName = 'FI_TA'
    Left = 48
    Top = 40
  end
  object ListFiles: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from FI_TA a,  FI_FILE b'
      'where a.TA_ID = :ta_id'
      'and a.fi_id = b.fi_id')
    Left = 56
    Top = 240
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FindFileQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from FI_TA a, FI_FILE b'
      'where a.TA_ID = :ta_id'
      'and a.fi_id = b.fi_id')
    Left = 120
    Top = 120
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    Left = 240
    Top = 56
  end
  object FileData: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'FI_FILE'
    TableName = 'FI_FILE'
    Left = 104
    Top = 40
  end
end
