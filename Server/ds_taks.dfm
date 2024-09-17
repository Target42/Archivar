object dsTask: TdsTask
  Height = 679
  Width = 1283
  PixelsPerInch = 120
  object TaskTypes: TDataSetProvider
    DataSet = TaskTypesQry
    Left = 120
    Top = 170
  end
  object Task: TDataSetProvider
    DataSet = TaskTab
    Left = 160
    Top = 440
  end
  object GremiumList: TDataSetProvider
    DataSet = GremiumQry
    Left = 50
    Top = 180
  end
  object TemplatesQry: TDataSetProvider
    DataSet = Templates
    Left = 200
    Top = 160
  end
  object TemplateTab: TDataSetProvider
    DataSet = Template
    Left = 230
    Top = 440
  end
  object TaskTableSrc: TDataSetProvider
    DataSet = TaskTable
    UpdateMode = upWhereKeyOnly
    Left = 1050
    Top = 190
  end
  object IBTransaction2: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 1130
    Top = 30
  end
  object TaskTable: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction2
    UpdateOptions.UpdateTableName = 'TA_TASK'
    TableName = 'TA_TASK'
    Left = 1050
    Top = 120
  end
  object DeleteTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 640
    Top = 30
  end
  object ArchivQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = DeleteTrans
    SQL.Strings = (
      'insert into GR_ARCHIV( GR_ID, TA_ID)'
      'values( :gr_id, :ta_id);')
    Left = 730
    Top = 170
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
    Left = 730
    Top = 240
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
    Left = 645
    Top = 160
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
    Left = 630
    Top = 230
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
    Left = 640
    Top = 90
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
    Left = 640
    Top = 330
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
    Left = 640
    Top = 460
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
    Left = 640
    Top = 390
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
    Left = 640
    Top = 530
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
    Left = 730
    Top = 90
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
    Left = 730
    Top = 340
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 210
    Top = 40
  end
  object TaskTab: TFDTable
    ObjectView = False
    IndexFieldNames = 'TA_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TA_TASK'
    TableName = 'TA_TASK'
    Left = 176
    Top = 322
  end
  object OpenTasks: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 100
    Top = 370
  end
  object TATab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TO_OPEN'
    TableName = 'TO_OPEN'
    Left = 40
    Top = 370
  end
  object Template: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TE_TEMPLATE'
    TableName = 'TE_TEMPLATE'
    Left = 220
    Top = 370
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
    Left = 130
    Top = 110
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
    Left = 310
    Top = 40
  end
  object GremiumQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from GR_GREMIUM'
      'order by GR_NAME')
    Left = 50
    Top = 120
  end
  object SetStatusQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TA_TASK'
      'set TA_FLAGS = :TA_FLAGS, TA_STATUS = :TA_STATUS'
      'where TA_ID = :TA_ID')
    Left = 300
    Top = 120
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
    Left = 200
    Top = 100
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
    Left = 1150
    Top = 110
  end
  object TaskLogSrc: TDataSetProvider
    DataSet = TaskLogTab
    Left = 1150
    Top = 190
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
    Left = 960
    Top = 400
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UnusedQry: TDataSetProvider
    DataSet = Unused
    Left = 960
    Top = 460
  end
  object ListGrTaQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select b.GR_ID, b.GR_NAME from TO_OPEN a, GR_GREMIUM b'
      'where a.TA_ID = :ta_id'
      'and a.GR_ID = b.gr_id')
    Left = 390
    Top = 270
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
    Left = 390
    Top = 350
  end
  object LTTab: TFDTable
    BeforePost = TaskLogTabBeforePost
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'LT_TASK_LOG'
    TableName = 'LT_TASK_LOG'
    Left = 390
    Top = 430
  end
  object Assigenments: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT count(TA_ID)'
      'FROM TO_OPEN '
      'where ta_id = :ta_id')
    Left = 400
    Top = 50
    ParamData = <
      item
        Name = 'TA_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AssigenmentsQry: TDataSetProvider
    DataSet = Assigenments
    Left = 410
    Top = 130
  end
  object CheckFolderID: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = CheckTrans
    SQL.Strings = (
      'SELECT DR_ID    '
      'FROM TA_TASK a '
      'WHERE'
      '    a.TA_ID = :id')
    Left = 40
    Top = 590
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CheckTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 60
    Top = 530
  end
  object FolderID: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = CheckTrans
    Left = 130
    Top = 600
  end
  object NewFolderQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = CheckTrans
    SQL.Strings = (
      'INSERT INTO DR_DIR (DR_ID, DR_GROUP)'
      'VALUES ('
      '    :id, '
      '    :id'
      ');')
    Left = 210
    Top = 600
    ParamData = <
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UpdateTask: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = CheckTrans
    SQL.Strings = (
      'UPDATE TA_TASK a'
      'SET '
      '    a.DR_ID = :dr_id'
      'WHERE'
      '    a.TA_ID = :ta_id')
    Left = 290
    Top = 610
    ParamData = <
      item
        Name = 'DR_ID'
        ParamType = ptInput
      end
      item
        Name = 'TA_ID'
        ParamType = ptInput
      end>
  end
  object TaskType: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TY_TASKTYPE'
    TableName = 'TY_TASKTYPE'
    Left = 290
    Top = 360
  end
  object TYTab: TDataSetProvider
    DataSet = TaskType
    Left = 300
    Top = 440
  end
  object TS_TASK_STATUS: TFDTable
    Connection = DBMod.ArchivarConnection
    TableName = 'TS_TASK_STATUS'
    Left = 420
    Top = 510
  end
  object TSTab: TDataSetProvider
    DataSet = TS_TASK_STATUS
    Left = 420
    Top = 600
  end
end
