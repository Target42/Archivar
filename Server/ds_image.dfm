object dsImage: TdsImage
  OldCreateOrder = False
  Height = 150
  Width = 215
  object PicturesTab: TDataSetProvider
    DataSet = PicTab
    Left = 32
    Top = 80
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 111
    Top = 80
  end
  object PicTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'PI_PIC'
    TableName = 'PI_PIC'
    Left = 32
    Top = 24
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 112
    Top = 16
  end
end
