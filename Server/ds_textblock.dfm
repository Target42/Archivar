object dsTextBlock: TdsTextBlock
  OldCreateOrder = False
  Height = 482
  Width = 835
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 160
    Top = 48
  end
  object TB: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'TB_TEXT'
    UniDirectional = False
    Left = 80
    Top = 48
  end
  object TBTab: TDataSetProvider
    DataSet = TB
    Left = 80
    Top = 112
  end
  object DelQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from TB_TEXT'
      'where TB_ID = :tb_id')
    Left = 208
    Top = 128
    ParamData = <
      item
        DataType = ftInteger
        Name = 'tb_id'
        ParamType = ptInput
      end>
  end
  object DelTB: TDataSetProvider
    DataSet = DelQry
    Left = 208
    Top = 192
  end
end
