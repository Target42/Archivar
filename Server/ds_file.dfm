object dsFile: TdsFile
  OldCreateOrder = False
  Height = 321
  Width = 639
  object ListFilesQry: TDataSetProvider
    DataSet = ListFiles
    Left = 96
    Top = 248
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 32
    Top = 8
  end
  object ListFiles: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * FROM FI_FILE'
      'where dr_id = :dr_id')
    Left = 88
    Top = 184
    ParamData = <
      item
        Name = 'DR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FindFileQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * FROM FI_FILE'
      'where dr_id = :dr_id')
    Left = 32
    Top = 184
    ParamData = <
      item
        Name = 'DR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    Left = 32
    Top = 56
  end
  object FileData: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'FI_FILE'
    TableName = 'FI_FILE'
    Left = 32
    Top = 136
  end
  object ListFolder: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM DR_DIR'
      'where DR_group = :grp')
    Left = 168
    Top = 200
    ParamData = <
      item
        Name = 'GRP'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ListFolderQry: TDataSetProvider
    DataSet = ListFolder
    Left = 168
    Top = 248
  end
  object DirTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'DR_DIR'
    TableName = 'DR_DIR'
    Left = 232
    Top = 152
  end
  object ListChilds: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM DR_DIR'
      'where dr_group = :grp'
      'and DR_PARENT = :pid')
    Left = 176
    Top = 56
    ParamData = <
      item
        Name = 'GRP'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AddHistQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      
        'INSERT INTO FH_FILE_HIST (FI_ID, FI_VERSION, FI_NAME, FI_TYPE, F' +
        'I_CREATED,'
      '    FI_TODELETE, FI_CREATED_BY, FI_DATA, FI_SIZE)'
      'select FI_ID, FI_VERSION, FI_NAME, FI_TYPE, FI_CREATED,'
      '    FI_TODELETE, FI_CREATED_BY, FI_DATA, FI_SIZE'
      'from FI_FILE'
      'where  '
      '    FI_ID = :id')
    Left = 320
    Top = 64
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DelFileHist: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'DELETE FROM FH_FILE_HIST a '
      'WHERE'
      '    a.FI_ID = :id')
    Left = 320
    Top = 120
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UpdateDirSum: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'update DR_DIR'
      'set dr_size = ('
      'SELECT sum(FI_SIZE)'
      'FROM FI_FILE r'
      'where dr_id = :id'
      ')'
      'where dr_id = :id')
    Left = 320
    Top = 184
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FileInfoQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM FI_FILE '
      'where FI_ID = :id')
    Left = 472
    Top = 48
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FileHistInfo: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM FH_FILE_HIST '
      'where FI_ID = :id'
      'order by fi_version desc')
    Left = 472
    Top = 96
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
