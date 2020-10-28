object dsChapter: TdsChapter
  OldCreateOrder = False
  Height = 353
  Width = 595
  object Chapter: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'CP_CHAPTER'
    UniDirectional = False
    Left = 48
    Top = 24
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 312
    Top = 32
  end
  object ChapterTab: TDataSetProvider
    DataSet = Chapter
    Left = 48
    Top = 80
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
      'a.ta_id = b.ta_id'
      'and'
      'b.ty_id = c.ty_id')
    Left = 224
    Top = 24
  end
  object ListTasks: TDataSetProvider
    DataSet = ListTasksQry
    Left = 224
    Top = 80
  end
  object ChapterText: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'CT_CHAPTER_TEXT'
    UniDirectional = False
    Left = 120
    Top = 24
  end
  object ChapterTextTab: TDataSetProvider
    DataSet = ChapterText
    Left = 120
    Top = 88
  end
end
