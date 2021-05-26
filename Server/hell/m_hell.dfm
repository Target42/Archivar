object HellMod: THellMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 435
  Width = 670
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 40
    Top = 32
  end
  object MeetingQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from EL_EINLADUNG'
      'where EL_ID = :el_id')
    Left = 232
    Top = 40
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'el_id'
        ParamType = ptUnknown
      end>
  end
  object UpdateStateQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update TN_TEILNEHMER'
      'set  TN_STATUS = :status'
      'where PR_ID = :pr_id'
      'and PE_ID = :pe_id')
    Left = 328
    Top = 40
    ParamData = <
      item
        DataType = ftInteger
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object UpdateMeetingStatQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update EL_EINLADUNG'
      'set EL_STATUS = :status'
      'where el_id = :EL_ID')
    Left = 224
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'status'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'EL_ID'
        ParamType = ptInput
      end>
  end
  object PEqry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PE_PERSON'
      'where pe_id = :pe_id')
    Left = 384
    Top = 144
    ParamData = <
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
end
