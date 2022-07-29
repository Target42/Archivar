object dsMeeing: TdsMeeing
  OldCreateOrder = False
  Height = 502
  Width = 809
  object ListProtocolQry: TDataSetProvider
    DataSet = ListProtocol
    Left = 112
    Top = 64
  end
  object PRTab: TDataSetProvider
    DataSet = PRTable
    Left = 184
    Top = 64
  end
  object ElTab: TDataSetProvider
    DataSet = ElTable
    UpdateMode = upWhereChanged
    Left = 240
    Top = 64
  end
  object TNQry: TDataSetProvider
    DataSet = Teilnehmer
    Left = 304
    Top = 64
  end
  object TGQry: TDataSetProvider
    DataSet = Gaeste
    Left = 464
    Top = 64
  end
  object OptTnQry: TDataSetProvider
    DataSet = OptTn
    Left = 352
    Top = 64
  end
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 24
    Top = 32
  end
  object DeleteTN: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'delete from TN_TEILNEHMER'
      'where tn_id = :tn_id')
    Left = 416
    Top = 176
    ParamData = <
      item
        Name = 'TN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AddTN: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 512
    Top = 176
  end
  object ProtoQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from PR_PROTOKOL'
      'where PR_ID = :pr_id')
    Left = 136
    Top = 192
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CPTab: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from CP_CHAPTER'
      'where PR_ID = :pr_id'
      'order by CP_NR')
    Left = 136
    Top = 248
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object CTTab: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from CT_CHAPTER_TEXT'
      'where CP_ID = :cp_id'
      'order by CT_NUMBER')
    Left = 136
    Top = 328
    ParamData = <
      item
        Name = 'CP_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object LastDocQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM PR_PROTOKOL'
      'where gr_id = :gr_id'
      'and el_id is null'
      'order by pr_id desc')
    Left = 80
    Top = 328
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object FrindELQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from EL_EINLADUNG'
      'where EL_ID = :el_id')
    Left = 72
    Top = 192
    ParamData = <
      item
        Name = 'EL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SetReadQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set TN_READ = current_timestamp'
      'where pr_id = :pr_id'
      'and pe_id = :pe_id'
      'and TN_READ is NULL')
    Left = 200
    Top = 192
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UpdateTnQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set TN_GRUND = :grund, TN_STATUS = :status'
      'where TN_ID = :tn_ID')
    Left = 200
    Top = 248
    ParamData = <
      item
        Name = 'GRUND'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'STATUS'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'TN_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ResetReadQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set  TN_READ= NULL'
      'where PR_ID = :pr_id')
    Left = 288
    Top = 248
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object ChangeELPEStatusQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set tn_status = :stat'
      'where pe_id = :pe_id'
      'and pr_id = :pr_id')
    Left = 352
    Top = 336
    ParamData = <
      item
        Name = 'STAT'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object PRTable: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'PR_PROTOKOL'
    TableName = 'PR_PROTOKOL'
    Left = 184
    Top = 16
  end
  object ElTable: TFDTable
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    UpdateOptions.UpdateTableName = 'EL_EINLADUNG'
    TableName = 'EL_EINLADUNG'
    Left = 240
    Top = 16
  end
  object AutoIncQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    Left = 24
    Top = 104
  end
  object ListProtocol: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM PR_PROTOKOL'
      'where gr_id= :gr_id')
    Left = 112
    Top = 16
    ParamData = <
      item
        Name = 'GR_ID'
        ParamType = ptInput
      end>
  end
  object Teilnehmer: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'SELECT * FROM TN_TEILNEHMER b'
      'where b.pr_id = :pr_id'
      'order by tn_name, tn_vorname')
    Left = 304
    Top = 16
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object Gaeste: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from TG_GAESTE'
      'where pr_id = :pr_id'
      'order by tg_grund, tg_name, tg_vorname')
    Left = 464
    Top = 16
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object OptTn: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from PE_PERSON a'
      'where not a.PE_ID  in'
      '('
      '  select PE_ID from'
      '    TN_TEILNEHMER'
      '  where pr_id = :pr_id'
      ')'
      'and a.PE_ID > 9'
      'order by pe_name, pe_vorname'
      '')
    Left = 352
    Top = 16
    ParamData = <
      item
        Name = 'PR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DelELQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'delete from EL_EINLADUNG'
      'where EL_ID = :EL_ID')
    Left = 16
    Top = 320
    ParamData = <
      item
        Name = 'EL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
