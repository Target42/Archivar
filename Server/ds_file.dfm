object dsFile: TdsFile
  OldCreateOrder = False
  Height = 321
  Width = 485
  object FITA: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'FI_TA'
    UniDirectional = False
    Left = 56
    Top = 48
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 264
    Top = 56
  end
  object FileData: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'FI_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'FI_NAME'
        DataType = ftString
        Size = 150
      end
      item
        Name = 'FI_TYPE'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'FI_DATA'
        DataType = ftBlob
      end
      item
        Name = 'FI_CREATED'
        DataType = ftDateTime
      end
      item
        Name = 'FI_TODELETE'
        DataType = ftDateTime
      end>
    IndexFieldNames = 'FI_ID'
    MasterFields = 'FI_ID'
    StoreDefs = True
    TableName = 'FI_FILE'
    UniDirectional = False
    Left = 120
    Top = 48
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 352
    Top = 32
  end
  object ListFiles: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FI_TA a,  FI_FILE b'
      'where a.TA_ID = :ta_id'
      'and a.fi_id = b.fi_id')
    Left = 56
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
  object ListFilesQry: TDataSetProvider
    DataSet = ListFiles
    Left = 56
    Top = 176
  end
  object FindFileQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from FI_TA a, FI_FILE b'
      'where a.TA_ID = :ta_id'
      'and a.fi_id = b.fi_id')
    Left = 224
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ta_id'
        ParamType = ptInput
      end>
  end
end
