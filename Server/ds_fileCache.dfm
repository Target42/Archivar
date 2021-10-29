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
    Left = 264
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
    Left = 560
    Top = 88
  end
  object UploadTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'FC_FILE_CACHE'
    TableName = 'FC_FILE_CACHE'
    Left = 392
    Top = 144
  end
  object UnlockQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'delete'
      'FROM FL_FILE_LOCK '
      'where fc_id = :fc_id')
    Left = 560
    Top = 160
    ParamData = <
      item
        Name = 'FC_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FL: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'FL_FILE_LOCK'
    TableName = 'FL_FILE_LOCK'
    Left = 128
    Top = 56
  end
  object FLTab: TDataSetProvider
    DataSet = FL
    Left = 128
    Top = 112
  end
  object LockQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'INSERT INTO FL_FILE_LOCK (FC_ID, PE_ID, FL_USER, FL_STAMP)'
      'VALUES ('
      '    :FC_ID,'
      '    :PE_ID,'
      '    :FL_USER,'
      '    :FL_STAMP'
      ');')
    Left = 560
    Top = 216
    ParamData = <
      item
        Name = 'FC_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'FL_USER'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'FL_STAMP'
        DataType = ftDateTime
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction3
    Left = 80
    Top = 208
  end
  object FDTransaction3: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 160
    Top = 208
  end
  object DnlQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      
        'SELECT r.FC_ID, r.FC_NAME, r.FC_CACHE, r.FC_MD5, r.FC_STAMP, r.F' +
        'C_DATA'
      'FROM FC_FILE_CACHE r'
      'where fc_id = :fc_id')
    Left = 392
    Top = 200
    ParamData = <
      item
        Name = 'FC_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object GetLockQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'SELECT *'
      'FROM FL_FILE_LOCK r'
      'where FC_ID = :fc_id')
    Left = 336
    Top = 40
    ParamData = <
      item
        Name = 'FC_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
