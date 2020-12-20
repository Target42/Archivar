object dsProtocol: TdsProtocol
  OldCreateOrder = False
  Height = 342
  Width = 696
  object PRTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PR_PROTOKOL'
    UniDirectional = False
    Left = 24
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 16
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 80
    Top = 16
  end
  object PRTable: TDataSetProvider
    DataSet = PRTab
    Left = 24
    Top = 88
  end
  object TNTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'PR_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TN_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'TN_NAME'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'TN_VORNAME'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'TN_DEPARTMENT'
        DataType = ftWideString
        Size = 25
      end
      item
        Name = 'TN_ROLLE'
        DataType = ftWideString
        Size = 50
      end
      item
        Name = 'TN_STATUS'
        DataType = ftInteger
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
      end>
    IndexDefs = <
      item
        Name = 'PK_TN_TEILNEHMER'
        Fields = 'PR_ID;TN_ID'
        Options = [ixUnique]
      end
      item
        Name = 'FK_REF_1060'
        Fields = 'PR_ID'
      end
      item
        Name = 'TN_TELNEHMER_SEC'
        Fields = 'TN_NAME;TN_VORNAME;TN_DEPARTMENT'
      end>
    StoreDefs = True
    TableName = 'TN_TEILNEHMER'
    UniDirectional = False
    Left = 192
    Top = 128
    object TNTabPR_ID: TIntegerField
      FieldName = 'PR_ID'
      Required = True
    end
    object TNTabTN_ID: TIntegerField
      FieldName = 'TN_ID'
      Required = True
    end
    object TNTabTN_NAME: TIBStringField
      FieldName = 'TN_NAME'
      Size = 100
    end
    object TNTabTN_VORNAME: TIBStringField
      FieldName = 'TN_VORNAME'
      Size = 100
    end
    object TNTabTN_DEPARTMENT: TIBStringField
      FieldName = 'TN_DEPARTMENT'
      Size = 25
    end
    object TNTabTN_ROLLE: TIBStringField
      FieldName = 'TN_ROLLE'
      Size = 50
    end
    object TNTabTN_STATUS: TIntegerField
      FieldName = 'TN_STATUS'
    end
    object TNTabPE_ID: TIntegerField
      FieldName = 'PE_ID'
    end
  end
  object TGTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TG_GAESTE'
    UniDirectional = False
    Left = 248
    Top = 128
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
  object PEQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from GR_PA a,  PE_PERSON b'
      'where GR_ID = :GR_ID'
      'and a.PE_ID = b.PE_ID')
    Left = 88
    Top = 88
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object DeleteTrans: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 560
    Top = 16
  end
  object deleteTNQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TN_TEILNEHMER'
      'where  PR_ID = :PR_ID')
    Left = 560
    Top = 72
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object deleteTGQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TG_GAESTE'
      'where PR_ID = :PR_ID')
    Left = 560
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object deletePrTaQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from PR_TA'
      'where PR_ID = :PR_ID')
    Left = 560
    Top = 168
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object deletePR: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from PR_PROTOKOL'
      'where PR_ID = :PR_ID')
    Left = 560
    Top = 224
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object ListPr: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from PR_PROTOKOL'
      'where GR_ID = :GR_ID'
      'order by PR_DATUM')
    Left = 376
    Top = 24
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object ListPrQry: TDataSetProvider
    DataSet = ListPr
    Left = 400
    Top = 80
  end
  object incQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DBMod.IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'SELECT GEN_ID(gen_tg_id, 1 ) FROM RDB$DATABASE;')
    Left = 408
    Top = 152
  end
  object AutoIncValue: TDataSetProvider
    DataSet = incQry
    Left = 408
    Top = 216
  end
  object CPTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    IndexName = 'CP_CHAPTER_SEC'
    TableName = 'CP_CHAPTER'
    UniDirectional = False
    Left = 24
    Top = 152
  end
  object ChapterTab: TDataSetProvider
    DataSet = CPTab
    Left = 24
    Top = 208
  end
  object DeleteChapter: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from CP_CHAPTER'
      'where PR_ID = :PR_ID')
    Left = 552
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'PR_ID'
        ParamType = ptInput
      end>
  end
  object UpdateCP: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update CP_CHAPTER'
      'set CP_NR = :CP_NR, CP_TITLE = :CP_TITLE'
      'where CP_ID = :CP_ID')
    Left = 80
    Top = 152
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CP_NR'
        ParamType = ptInput
      end
      item
        DataType = ftString
        Name = 'CP_TITLE'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'CP_ID'
        ParamType = ptInput
      end>
  end
  object UpdateCPQry: TDataSetProvider
    DataSet = UpdateCP
    Left = 80
    Top = 216
  end
  object DeleteCPQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = DeleteTrans
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from CP_CHAPTER'
      'where CP_ID = :CP_ID')
    Left = 16
    Top = 272
    ParamData = <
      item
        DataType = ftInteger
        Name = 'CP_ID'
        ParamType = ptInput
      end>
  end
  object ListTasksQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
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
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object ListTasks: TDataSetProvider
    DataSet = ListTasksQry
    Left = 224
    Top = 72
  end
  object CPText: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'CT_CHAPTER_TEXT'
    UniDirectional = False
    Left = 200
    Top = 264
  end
  object CPTextTab: TDataSetProvider
    DataSet = CPText
    Left = 272
    Top = 264
  end
end
