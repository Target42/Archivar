object dsSitzung: TdsSitzung
  OldCreateOrder = False
  Height = 268
  Width = 486
  object ELSrc: TDataSetProvider
    DataSet = ELTab
    Left = 24
    Top = 136
  end
  object TNSrc: TDataSetProvider
    DataSet = TNQry
    Left = 80
    Top = 140
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 40
    Top = 24
  end
  object TNQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select  * from TN_TEILNEHMER'
      'where PR_ID = :pr_id')
    Left = 80
    Top = 80
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ELTab: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'EL_EINLADUNG'
    TableName = 'EL_EINLADUNG'
    Left = 24
    Top = 80
  end
end
