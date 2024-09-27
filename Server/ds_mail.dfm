object DSMail: TDSMail
  Height = 277
  Width = 556
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 48
    Top = 32
  end
  object Mac: TFDTable
    IndexFieldNames = 'MAC_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'MAC_MAIL_ACCOUNT'
    TableName = 'MAC_MAIL_ACCOUNT'
    Left = 56
    Top = 88
  end
  object Maf: TFDTable
    IndexFieldNames = 'MAF_ID'
    DetailFields = 'MAC_ID'
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'MAF_FOLDER'
    TableName = 'MAF_FOLDER'
    Left = 120
    Top = 88
  end
  object MailAccount: TDataSetProvider
    DataSet = Mac
    Left = 32
    Top = 152
  end
  object Mailfolder: TDataSetProvider
    DataSet = Maf
    Left = 96
    Top = 152
  end
  object MamTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'MAM_MAIL'
    TableName = 'MAM_MAIL'
    Left = 176
    Top = 88
  end
  object Mails: TDataSetProvider
    DataSet = MamTab
    Left = 176
    Top = 152
  end
  object Gremien: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT GR_SHORT, r.GR_COLOR'
      'FROM GR_GREMIUM r'
      'where gr_color <> 0'
      'order by GR_SHORT')
    Left = 240
    Top = 88
  end
  object GremiumQry: TDataSetProvider
    DataSet = Gremien
    Left = 240
    Top = 152
  end
  object KategorieSet: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'UPDATE MAM_MAIL a'
      'SET '
      '    a.MAM_KATEGORIE = :name'
      'WHERE'
      '    a.MAM_ID = :id')
    Left = 352
    Top = 24
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object StatusSet: TFDQuery
    Connection = DBMod.ArchivarConnection
    SQL.Strings = (
      'UPDATE MAM_MAIL a'
      'SET '
      '    a.MAM_STATUs = :name'
      'WHERE'
      '    a.MAM_ID = :id')
    Left = 424
    Top = 112
    ParamData = <
      item
        Name = 'NAME'
        DataType = ftString
        ParamType = ptInput
        Value = Null
      end
      item
        Name = 'ID'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
end
