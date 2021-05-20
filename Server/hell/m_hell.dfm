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
end
