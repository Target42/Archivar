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
    Left = 184
    Top = 16
  end
  object PRTab: TDataSetProvider
    DataSet = PRTable
    Left = 184
    Top = 64
  end
  object ElTable: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_EINLADUNG'
    UniDirectional = False
    Left = 240
    Top = 16
  end
  object ElTab: TDataSetProvider
    DataSet = ElTable
    UpdateMode = upWhereChanged
    Left = 240
    Top = 64
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
    Left = 136
    Top = 192
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
    Left = 136
    Top = 248
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
    Left = 136
    Top = 328
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
    Left = 72
    Top = 248
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
    Left = 24
    Top = 104
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
    Left = 80
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
    Left = 72
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end>
  end
  object Teilnehmer: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM el_pe a, TN_TEILNEHMER b'
      'where a.el_id = :el_id'
      'and b.pr_id = :pr_id'
      'and a.PE_ID = b.PE_ID'
      'order by tn_name, tn_vorname')
    Left = 304
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object TNQry: TDataSetProvider
    DataSet = Teilnehmer
    Left = 304
    Top = 64
  end
  object SetReadQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update el_pe'
      'set ep_read = current_timestamp'
      'where el_id = :el_id'
      'and pe_id = :pe_id'
      'and ep_read is NULL')
    Left = 200
    Top = 192
    ParamData = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object UpdateTnQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set TN_GRUND = :grund, TN_STATUS = :status'
      'where TN_ID = :tn_ID')
    Left = 200
    Top = 248
    ParamData = <
      item
        DataType = ftString
        Name = 'grund'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'tn_ID'
        ParamType = ptInput
      end>
  end
  object Gaeste: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TG_GAESTE'
      'where pr_id = :pr_id'
      'order by tg_grund, tg_name, tg_vorname')
    Left = 360
    Top = 16
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object TGQry: TDataSetProvider
    DataSet = Gaeste
    Left = 360
    Top = 64
  end
  object ChangeELStatusQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update EL_EINLADUNG'
      'set EL_STATUS = :status'
      'where EL_ID = :el_id')
    Left = 288
    Top = 192
    ParamData = <
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end>
  end
  object ResetReadQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update EL_PE'
      'set  EP_READ = NULL'
      'where EL_ID = :el_id')
    Left = 288
    Top = 248
    ParamData = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end>
  end
  object ChangeELPEStatusQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update EL_PE'
      'set EP_STATUS = :status'
      'where el_id = :EL_ID'
      'and pe_id = :pe_id')
    Left = 240
    Top = 304
    ParamData = <
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'EL_ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
end