object dsMisc: TdsMisc
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 247
  Width = 441
  object openTasks: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TO_OPEN a,  TA_TASK b, TY_TASKTYPE c'
      'where a.gr_id = :gr_id'
      'and a.ta_id = b.ta_id '
      'and b.ty_id = c.ty_id')
    Left = 48
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 32
    Top = 16
  end
  object OpenTaskQry: TDataSetProvider
    DataSet = openTasks
    Left = 48
    Top = 144
  end
  object LockTrans: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 336
    Top = 32
  end
  object GetTaskinfo: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = LockTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 256
    Top = 32
    ParamData = <
      item
        DataType = ftInteger
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object GetProtoInfo: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = LockTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PR_PROTOKOL'
      'where PR_ID = :PR_ID')
    Left = 256
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 208
    Top = 160
  end
  object IncTrans: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 296
    Top = 160
  end
end
