object dsMeeing: TdsMeeing
  OldCreateOrder = False
  Height = 447
  Width = 475
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 24
    Top = 32
  end
  object ListProtocol: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM PR_PROTOKOL'
      'where gr_id = :gr_id'
      'and PR_STATUS <> '#39'C'#39
      'order by pr_id desc')
    Left = 112
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
  end
  object ListProtocolQry: TDataSetProvider
    DataSet = ListProtocol
    Left = 112
    Top = 64
  end
  object PRTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PR_PROTOKOL'
    UniDirectional = False
    Left = 208
    Top = 16
  end
  object PRTab: TDataSetProvider
    DataSet = PRTable
    Left = 216
    Top = 72
  end
  object ElTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_EINLADUNG'
    UniDirectional = False
    Left = 280
    Top = 24
  end
  object ElTab: TDataSetProvider
    DataSet = ElTable
    Left = 280
    Top = 80
  end
  object ProtoQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PR_PROTOKOL'
      'where PR_ID = :pr_id')
    Left = 320
    Top = 208
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object CPTab: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from CP_CHAPTER'
      'where PR_ID = :pr_id'
      'order by CP_NR')
    Left = 320
    Top = 264
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object CTTab: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from CT_CHAPTER_TEXT'
      'where CP_ID = :cp_id'
      'order by CT_NUMBER')
    Left = 320
    Top = 320
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'cp_id'
        ParamType = ptUnknown
      end>
  end
  object ELPETab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_PE'
    UniDirectional = False
    Left = 16
    Top = 192
  end
  object GrPeQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM TN_TEILNEHMER'
      'where PR_ID = :pr_id')
    Left = 208
    Top = 256
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 408
    Top = 24
  end
  object LastDocQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM PR_PROTOKOL'
      'where gr_id = :gr_id'
      'and el_id is null'
      'order by pr_id desc')
    Left = 216
    Top = 328
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
  end
  object DelPEQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from EL_PE'
      'where EL_ID = :EL_ID')
    Left = 16
    Top = 384
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EL_ID'
        ParamType = ptInput
      end>
  end
  object DelELQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from EL_EINLADUNG'
      'where EL_ID = :EL_ID')
    Left = 16
    Top = 320
    ParamData = <
      item
        DataType = ftInteger
        Name = 'EL_ID'
        ParamType = ptInput
      end>
  end
  object FrindELQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PR_PROTOKOL'
      'where EL_ID = :el_id')
    Left = 120
    Top = 288
    ParamData = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end>
  end
end
