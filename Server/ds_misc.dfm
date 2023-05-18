object dsMisc: TdsMisc
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 357
  Width = 689
  object OpenTaskQry: TDataSetProvider
    DataSet = openTasks
    Left = 56
    Top = 144
  end
  object MeetingQry: TDataSetProvider
    DataSet = Meetings
    Left = 112
    Top = 144
  end
  object GetTaskinfo: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = LockTrans
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 416
    Top = 24
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object GetProtoInfo: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = LockTrans
    SQL.Strings = (
      'select * from PR_PROTOKOL'
      'where PR_ID = :PR_ID')
    Left = 416
    Top = 80
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object LockTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 496
    Top = 24
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 32
    Top = 16
  end
  object openTasks: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TO_OPEN a,  TA_TASK b, TY_TASKTYPE c'
      'where a.gr_id = :gr_id'
      'and a.ta_id = b.ta_id '
      'and b.ty_id = c.ty_id')
    Left = 48
    Top = 88
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 112
    Top = 16
  end
  object Meetings: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM EL_EINLADUNG a, TN_TEILNEHMER b'
      'where a.pr_id = b.pr_id'
      'and b.pe_id = :pe_id'
      'and EL_STATUS = :status')
    Left = 104
    Top = 88
    ParamData = <
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'STATUS'
        DataType = ftString
        ParamType = ptInput
      end>
  end
  object IncTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 256
    Top = 56
  end
  object PEQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from PE_PERSON')
    Left = 352
    Top = 192
    object PEQryPE_ID: TIntegerField
      FieldName = 'PE_ID'
      Origin = 'PE_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object PEQryPE_NAME: TStringField
      FieldName = 'PE_NAME'
      Origin = 'PE_NAME'
      Size = 100
    end
    object PEQryPE_VORNAME: TStringField
      FieldName = 'PE_VORNAME'
      Origin = 'PE_VORNAME'
      Size = 100
    end
    object PEQryPE_DEPARTMENT: TStringField
      FieldName = 'PE_DEPARTMENT'
      Origin = 'PE_DEPARTMENT'
      Size = 25
    end
    object PEQryDR_ID: TIntegerField
      FieldName = 'DR_ID'
      Origin = 'DR_ID'
    end
  end
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
    Left = 424
    Top = 176
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
    Left = 488
    Top = 176
  end
  object ListStoragesQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM ST_STORAGE')
    Left = 224
    Top = 152
  end
  object GRTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'GR_GREMIUM'
    TableName = 'GR_GREMIUM'
    Left = 616
    Top = 24
  end
  object PETab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'PE_PERSON'
    TableName = 'PE_PERSON'
    Left = 616
    Top = 80
  end
  object DRTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'DR_DIR'
    TableName = 'DR_DIR'
    Left = 616
    Top = 136
  end
  object FilesToDelete: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * '
      'FROM FI_FILE r'
      'where PE_ID = :pe_id'
      'and datediff( day from current_date to FI_TODELETE) < :tage'
      'order by FI_TODELETE')
    Left = 224
    Top = 232
    ParamData = <
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TAGE'
        DataType = ftInteger
        ParamType = ptInput
        Value = 34
      end>
  end
  object FilesToDeleteQry: TDataSetProvider
    DataSet = FilesToDelete
    Left = 216
    Top = 288
  end
end
