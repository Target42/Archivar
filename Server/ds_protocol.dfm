object dsProtocol: TdsProtocol
  OldCreateOrder = False
  Height = 553
  Width = 978
  object PRTable: TDataSetProvider
    DataSet = PRTab
    Left = 24
    Top = 88
  end
  object Teilnehmer: TDataSetProvider
    DataSet = TNTab
    Left = 192
    Top = 184
  end
  object TGTable: TDataSetProvider
    DataSet = TGTab
    Left = 248
    Top = 184
  end
  object ListPrQry: TDataSetProvider
    DataSet = ListPr
    Left = 400
    Top = 80
  end
  object AutoIncValue: TDataSetProvider
    DataSet = incQry
    Left = 408
    Top = 216
  end
  object ChapterTab: TDataSetProvider
    DataSet = CPTab
    Left = 24
    Top = 208
  end
  object UpdateCPQry: TDataSetProvider
    DataSet = UpdateCP
    Left = 88
    Top = 216
  end
  object ListTasks: TDataSetProvider
    DataSet = ListTasksQry
    Left = 224
    Top = 72
  end
  object CPTextTab: TDataSetProvider
    DataSet = CPText
    Left = 272
    Top = 264
  end
  object BETab: TDataSetProvider
    DataSet = BE
    Left = 360
    Top = 424
  end
  object DeleteTrans: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 752
    Top = 16
  end
  object deleteTNQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from TN_TEILNEHMER'
      'where  PR_ID = :PR_ID')
    Left = 760
    Top = 72
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object deleteTGQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from TG_GAESTE'
      'where PR_ID = :PR_ID')
    Left = 752
    Top = 120
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object deletePR: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from PR_PROTOKOL'
      'where PR_ID = :PR_ID')
    Left = 752
    Top = 168
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteChapter: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from CP_CHAPTER'
      'where PR_ID = :PR_ID')
    Left = 768
    Top = 256
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SelectChapterQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'select * from CP_CHAPTER'
      'where PR_ID = :PR_ID')
    Left = 860
    Top = 256
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SelectChapterTextQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'select * from CT_CHAPTER_TEXT'
      'where CP_ID = :CP_ID')
    Left = 864
    Top = 312
    ParamData = <
      item
        Name = 'CP_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object deleteBEQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from BE_BESCHLUS'
      'where ct_id = :ct_id')
    Left = 872
    Top = 376
    ParamData = <
      item
        Name = 'CT_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object deleteCT: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'delete from CT_CHAPTER_TEXT'
      'where CP_ID = :CP_ID')
    Left = 768
    Top = 392
    ParamData = <
      item
        Name = 'CP_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object BE: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'BE_BESCHLUS'
    TableName = 'BE_BESCHLUS'
    Left = 360
    Top = 360
  end
  object PRTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'PR_PROTOKOL'
    TableName = 'PR_PROTOKOL'
    Left = 24
    Top = 16
  end
  object TGTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TG_GAESTE'
    TableName = 'TG_GAESTE'
    Left = 248
    Top = 128
  end
  object CPTab: TFDTable
    ObjectView = False
    IndexName = 'CP_CHAPTER_SEC'
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateOptions.UpdateTableName = 'CP_CHAPTER'
    TableName = 'CP_CHAPTER'
    Left = 24
    Top = 152
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 56
    Top = 368
  end
  object CPText: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.AssignedValues = [uvUpdateMode]
    UpdateOptions.UpdateMode = upWhereChanged
    UpdateOptions.UpdateTableName = 'CT_CHAPTER_TEXT'
    TableName = 'CT_CHAPTER_TEXT'
    Left = 208
    Top = 264
  end
  object ListPr: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select  * from PR_PROTOKOL'
      'where GR_ID = :GR_ID'
      'order by PR_DATUM desc')
    Left = 376
    Top = 24
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object incQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT GEN_ID(gen_tg_id, 1 ) FROM RDB$DATABASE;')
    Left = 408
    Top = 152
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 80
    Top = 16
  end
  object UpdateCP: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update CP_CHAPTER'
      'set CP_NR = :CP_NR, CP_TITLE = :CP_TITLE'
      'where CP_ID = :CP_ID')
    Left = 80
    Top = 152
    ParamData = <
      item
        Name = 'CP_NR'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'CP_TITLE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'CP_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteCPQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'delete from CP_CHAPTER'
      'where CP_ID = :CP_ID')
    Left = 24
    Top = 272
    ParamData = <
      item
        Name = 'CP_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ListTasksQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TO_OPEN a,  TA_TASK b,  TY_TASKTYPE c'
      'where '
      'a.gr_ID = :GR_ID'
      'and'
      'a.ta_id = b.ta_id'
      'and'
      'b.ty_id = c.ty_id')
    Left = 232
    Top = 16
    ParamData = <
      item
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object TNTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TN_TEILNEHMER'
    TableName = 'TN_TEILNEHMER'
    Left = 200
    Top = 128
  end
  object NextNrQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select max( pr_nr )'
      'from ('
      'SELECT first 10 pr_nr    '
      'FROM PR_PROTOKOL r'
      'where gr_id = :gr_id'
      'order by pr_id desc'
      ')')
    Left = 504
    Top = 48
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object InsertTNQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 112
    Top = 328
  end
end
