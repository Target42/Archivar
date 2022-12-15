object dsTask: TdsTask
  OldCreateOrder = False
  Height = 543
  Width = 1026
  object TaskTypes: TDataSetProvider
    DataSet = TaskTypesQry
    Left = 96
    Top = 136
  end
  object Task: TDataSetProvider
    DataSet = TaskTab
    Left = 128
    Top = 352
  end
  object GremiumList: TDataSetProvider
    DataSet = GremiumQry
    Left = 40
    Top = 144
  end
  object TemplatesQry: TDataSetProvider
    DataSet = Templates
    Left = 160
    Top = 128
  end
  object TemplateTab: TDataSetProvider
    DataSet = Template
    Left = 184
    Top = 352
  end
  object TaskTableSrc: TDataSetProvider
    DataSet = TaskTable
    UpdateMode = upWhereKeyOnly
    Left = 840
    Top = 152
  end
  object IBTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 904
    Top = 24
  end
  object TaskTable: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction2
    UpdateOptions.UpdateTableName = 'TA_TASK'
    TableName = 'TA_TASK'
    Left = 840
    Top = 96
  end
  object DeleteTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 512
    Top = 24
  end
  object ArchivQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'insert into GR_ARCHIV( GR_ID, TA_ID)'
      'values( :gr_id, :ta_id);')
    Left = 584
    Top = 136
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object RemoveOpenTask: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :ta_id')
    Left = 584
    Top = 192
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object RemoveTask: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :ta_id')
    Left = 516
    Top = 128
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AddTask: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'insert into TO_OPEN( GR_ID, TA_ID)'
      'values( :GR_ID, :TA_ID)')
    Left = 504
    Top = 184
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SetFlagQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'update TA_TASK'
      'set TA_FLAGS = :TA_FLAGS'
      'where TA_ID = :TA_ID')
    Left = 512
    Top = 72
    ParamData = <
      item
        Name = 'TA_FLAGS'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteOpenTA: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from TO_OPEN'
      'where TA_ID = :TA_ID')
    Left = 512
    Top = 264
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteTaskLog: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from LT_TASK_LOG'
      'where TA_ID = :TA_ID')
    Left = 512
    Top = 368
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteFiles: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from FI_FILE '
      'where FI_ID in'
      '(select FI_ID from FI_TA'
      'where TA_ID = :TA_ID)')
    Left = 512
    Top = 312
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteTaskQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'delete from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 512
    Top = 424
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FindTask: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 584
    Top = 72
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object TaskClidQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'select * from TA_TASK'
      'where TA_ID = :TA_ID')
    Left = 584
    Top = 272
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 168
    Top = 32
  end
  object TaskTab: TFDTable
    ObjectView = False
    IndexFieldNames = 'TA_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TA_TASK'
    TableName = 'TA_TASK'
    Left = 128
    Top = 296
  end
  object OpenTasks: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 80
    Top = 296
  end
  object TATab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 32
    Top = 296
  end
  object Template: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TE_TEMPLATE'
    TableName = 'TE_TEMPLATE'
    Left = 176
    Top = 296
  end
  object TaskTypesQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT b.*'
      'FROM GR_TY a, ty_tasktype b'
      'where GR_ID = :gr_id'
      'and a.TY_ID = b.ty_id')
    Left = 104
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
    Left = 248
    Top = 32
  end
  object GremiumQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from GR_GREMIUM'
      'order by GR_NAME')
    Left = 40
    Top = 96
  end
  object SetStatusQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TA_TASK'
      'set TA_FLAGS = :TA_FLAGS, TA_STATUS = :TA_STATUS'
      'where TA_ID = :TA_ID')
    Left = 240
    Top = 96
    ParamData = <
      item
        Name = 'TA_FLAGS'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TA_STATUS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object Templates: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TE_TEMPLATE'
      'where TY_ID = :id')
    Left = 160
    Top = 80
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object TaskLogTab: TFDTable
    BeforePost = TaskLogTabBeforePost
    IndexFieldNames = 'LT_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction2
    UpdateOptions.UpdateTableName = 'LT_TASK_LOG'
    TableName = 'LT_TASK_LOG'
    Left = 920
    Top = 88
  end
  object TaskLogSrc: TDataSetProvider
    DataSet = TaskLogTab
    Left = 920
    Top = 152
  end
  object Unused: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      
        'SELECT a.TA_ID, a.TA_NAME,a.TA_TERMIN, a.TA_CREATED, a.TA_STARTE' +
        'D, a.TA_FLAGS, a.TA_CREATED_BY, a.ta_status, a.ta_color, c.TY_NA' +
        'ME '
      'FROM TO_open b, TA_TASK a, TY_TASKTYPE c'
      'where  gr_id = :gr_id'
      'and a.ta_id = b.TA_ID'
      'and a.TY_ID = c.TY_ID'
      'and not b.TA_ID in '
      '('
      '  select TA_ID from CT_CHAPTER_TEXT'
      '  where not ta_id is NULL'
      ')'
      'order by ty_name')
    Left = 768
    Top = 320
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UnusedQry: TDataSetProvider
    DataSet = Unused
    Left = 768
    Top = 368
  end
  object ListGrTaQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select b.GR_ID, b.GR_NAME from TO_OPEN a, GR_GREMIUM b'
      'where a.TA_ID = :ta_id'
      'and a.GR_ID = b.gr_id')
    Left = 312
    Top = 216
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object TOTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 312
    Top = 280
  end
  object LTTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'LT_TASK_LOG'
    TableName = 'LT_TASK_LOG'
    Left = 312
    Top = 344
  end
end
