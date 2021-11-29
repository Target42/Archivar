object dsPKI: TdsPKI
  OldCreateOrder = False
  Height = 287
  Width = 562
  object GetKeyQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT r.PE_ID, r.PK_ID, r.PK_START, r.PK_END, r.PK_DATA'
      'FROM PK_PUBLIC_KEY r, pe_person b'
      'where '
      'upper(b.PE_NET) = upper(:name) and'
      'r.PE_ID = b.PE_ID and'
      ':da >= pk_start and '
      ':da <= pk_end')
    Left = 183
    Top = 118
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'DA'
        DataType = ftTimeStamp
        ParamType = ptInput
      end>
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 255
    Top = 126
  end
  object getUserQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'SELECT *    '
      'FROM PE_PERSON'
      'where upper(PE_NET) = upper(:net)')
    Left = 392
    Top = 32
    ParamData = <
      item
        Name = 'NET'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object PKTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'PK_PUBLIC_KEY'
    TableName = 'PK_PUBLIC_KEY'
    Left = 384
    Top = 176
  end
  object UpdateKeyQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    SQL.Strings = (
      'update PK_PUBLIC_KEY'
      'set PK_END = current_timestamp'
      'where pe_id = :id'
      'and PK_END > current_timestamp')
    Left = 392
    Top = 88
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FDTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 456
    Top = 176
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    Left = 464
    Top = 24
  end
  object PETab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction2
    UpdateOptions.UpdateTableName = 'PE_PERSON'
    TableName = 'PE_PERSON'
    Left = 456
    Top = 88
  end
end
