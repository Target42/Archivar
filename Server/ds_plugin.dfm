object TdsPlugin: TTdsPlugin
  OldCreateOrder = False
  Height = 367
  Width = 448
  object TabPlugin: TFDTable
    BeforePost = TabPluginBeforePost
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'PL_PLUGIN'
    TableName = 'PL_PLUGIN'
    Left = 40
    Top = 32
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 136
    Top = 56
  end
  object PluginTab: TDataSetProvider
    DataSet = TabPlugin
    Left = 40
    Top = 88
  end
  object AutoIncQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    Left = 36
    Top = 168
  end
end
