object dsMisc: TdsMisc
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 262
  Width = 689
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
  object Meetings: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT * FROM EL_EINLADUNG a, el_pe b'
      'where a.el_id = b.el_id'
      'and pe_id = :pe_id'
      'and EL_STATUS = :status')
    Left = 464
    Top = 48
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end>
  end
  object MeetingQry: TDataSetProvider
    DataSet = Meetings
    Left = 464
    Top = 112
  end
  object PEQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PE_PERSON')
    Left = 560
    Top = 96
    object PEQryPE_ID: TIntegerField
      FieldName = 'PE_ID'
      Origin = '"PE_PERSON"."PE_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PEQryPE_NAME: TIBStringField
      FieldName = 'PE_NAME'
      Origin = '"PE_PERSON"."PE_NAME"'
      Size = 100
    end
    object PEQryPE_VORNAME: TIBStringField
      FieldName = 'PE_VORNAME'
      Origin = '"PE_PERSON"."PE_VORNAME"'
      Size = 100
    end
    object PEQryPE_DEPARTMENT: TIBStringField
      FieldName = 'PE_DEPARTMENT'
      Origin = '"PE_PERSON"."PE_DEPARTMENT"'
      Size = 25
    end
    object PEQryPE_NET: TIBStringField
      FieldName = 'PE_NET'
      Origin = '"PE_PERSON"."PE_NET"'
      Size = 25
    end
    object PEQryPE_MAIL: TIBStringField
      FieldName = 'PE_MAIL'
      Origin = '"PE_PERSON"."PE_MAIL"'
      Size = 200
    end
  end
end
