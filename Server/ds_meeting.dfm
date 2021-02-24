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
      'select * from PR_PROTOKOL'
      'where PR_STATUS = :status'
      'and GR_ID = :gr_id'
      'order by pr_id desc'
      ' ')
    Left = 112
    Top = 48
    ParamData = <
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
  end
  object ListProtocolQry: TDataSetProvider
    DataSet = ListProtocol
    Left = 112
    Top = 112
  end
  object PRTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PR_PROTOKOL'
    UniDirectional = False
    Left = 224
    Top = 48
  end
  object PRTab: TDataSetProvider
    DataSet = PRTable
    Left = 224
    Top = 112
  end
  object ElTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_EINLADUNG'
    UniDirectional = False
    Left = 328
    Top = 40
  end
  object ElTab: TDataSetProvider
    DataSet = ElTable
    Left = 328
    Top = 112
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
end
