object HellMod: THellMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 435
  Width = 670
  object IBTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 48
    Top = 32
  end
  object MeetingQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from EL_EINLADUNG'
      'where EL_ID = :el_id')
    Left = 232
    Top = 40
    ParamData = <
      item
        Name = 'EL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object UpdateStateQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set  TN_STATUS = :status'
      'where PR_ID = :pr_id'
      'and PE_ID = :pe_id')
    Left = 328
    Top = 40
    ParamData = <
      item
        Name = 'STATUS'
        DataType = ftInteger
        ParamType = ptInput
      end
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
  object UpdateMeetingStatQry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'update EL_EINLADUNG'
      'set EL_STATUS = :status'
      'where el_id = :EL_ID')
    Left = 224
    Top = 112
    ParamData = <
      item
        Name = 'STATUS'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'EL_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object PEqry: TFDQuery
    ObjectView = False
    Connection = DBMod.ArchivarConnection
    Transaction = IBTransaction1
    SQL.Strings = (
      'select * from PE_PERSON'
      'where pe_id = :pe_id')
    Left = 384
    Top = 144
    ParamData = <
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
