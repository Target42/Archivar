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
  object TACp: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from TA_CP'
      'where CP_ID = :CP_ID')
    Left = 120
    Top = 32
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
    Left = 168
    Top = 120
    ParamData = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object ListTasks: TDataSetProvider
    DataSet = ListTasksQry
    Left = 160
    Top = 176
  end
end
