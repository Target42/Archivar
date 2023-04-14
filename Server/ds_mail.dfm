object DSMail: TDSMail
  OldCreateOrder = False
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
    Left = 136
    Top = 144
  end
  object MailAccount: TDataSetProvider
    DataSet = Mac
    Left = 64
    Top = 200
  end
  object Mailfolder: TDataSetProvider
    DataSet = Maf
    Left = 144
    Top = 200
  end
end
