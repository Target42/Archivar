object dsTextBlock: TdsTextBlock
  OldCreateOrder = False
  Height = 482
  Width = 835
  object TBTab: TDataSetProvider
    DataSet = TB
    Left = 64
    Top = 144
  end
  object DelTB: TDataSetProvider
    DataSet = DelQry
    Left = 120
    Top = 144
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 24
    Top = 8
  end
  object TB: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'TB_TEXT'
    TableName = 'TB_TEXT'
    Left = 64
    Top = 80
  end
  object DelQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'delete from TB_TEXT'
      'where TB_ID = :tb_id')
    Left = 120
    Top = 80
    ParamData = <
      item
        Name = 'TB_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ListTagQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT distinct r.TB_TAGS'
      'FROM TB_TEXT r')
    Left = 248
    Top = 96
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 328
    Top = 96
  end
end
