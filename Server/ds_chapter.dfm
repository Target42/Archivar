object dsChapter: TdsChapter
  OldCreateOrder = False
  Height = 353
  Width = 595
  object ChapterTab: TDataSetProvider
    DataSet = Chapter
    Left = 48
    Top = 80
  end
  object ListTasks: TDataSetProvider
    DataSet = ListTasksQry
    Left = 216
    Top = 80
  end
  object ChapterTextTab: TDataSetProvider
    DataSet = ChapterText
    Left = 120
    Top = 88
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 432
    Top = 120
  end
  object Chapter: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'CP_CHAPTER'
    TableName = 'CP_CHAPTER'
    Left = 48
    Top = 32
  end
  object ChapterText: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'CT_CHAPTER_TEXT'
    TableName = 'CT_CHAPTER_TEXT'
    Left = 120
    Top = 32
  end
  object ListTasksQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from TO_OPEN a,  TA_TASK b,  TY_TASKTYPE c'
      'where '
      'a.ta_id = b.ta_id'
      'and'
      'b.ty_id = c.ty_id')
    Left = 216
    Top = 24
  end
end
