object dsSitzung: TdsSitzung
  OldCreateOrder = False
  Height = 268
  Width = 486
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 40
    Top = 24
  end
  object ELTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'EL_EINLADUNG'
    UniDirectional = False
    Left = 24
    Top = 80
  end
  object ELSrc: TDataSetProvider
    DataSet = ELTab
    Left = 24
    Top = 136
  end
  object TNQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from TN_TEILNEHMER'
      'where PR_ID = :pr_id')
    UniDirectional = True
    Left = 80
    Top = 80
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
  end
  object TNSrc: TDataSetProvider
    DataSet = TNQry
    Left = 80
    Top = 140
  end
end
