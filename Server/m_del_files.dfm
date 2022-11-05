object DeleteFilesMod: TDeleteFilesMod
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 333
  Width = 502
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 72
    Top = 32
  end
  object DeleteTomeToDie: TFDScript
    SQLScripts = <
      item
        Name = 'DeleteFileHistory'
        SQL.Strings = (
          'delete from FH_FILE_HIST'
          'where FI_ID in'
          '( select FI_ID from FI_FILE'
          '  where FI_TODELETE < current_date );'
          ''
          'delete from FI_EV'
          'where FI_ID in'
          '( select FI_ID from FI_FILE'
          '  where FI_TODELETE < current_date );'
          ''
          'delete from FI_LOCK'
          'where FI_ID in'
          '( select FI_ID from FI_FILE'
          '  where FI_TODELETE < current_date );'
          ''
          'delete from FI_FILE'
          'where FI_TODELETE < current_date;')
      end>
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    Params = <>
    Macros = <>
    Left = 80
    Top = 152
  end
  object GetFolderQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'SELECT * FROM DR_DIR '
      'where DR_GROUP = :grid')
    Left = 296
    Top = 48
    ParamData = <
      item
        Name = 'GRID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object DeleteFolder: TFDScript
    SQLScripts = <
      item
        Name = 'Delete'
        SQL.Strings = (
          'delete from FI_EV'
          'where FI_ID in '
          '('
          '  select FI_ID from FI_FILE'
          '  where DR_ID = :drid'
          ');'
          ''
          'delete from FI_LOCK'
          'where FI_ID in '
          '('
          '  select FI_ID from FI_FILE'
          '  where DR_ID = :drid'
          ');'
          ''
          'delete from DR_EV'
          'where DR_ID = :drid;'
          ''
          'delete FROM ST_STORAGE '
          'where DR_ID = :drid;'
          ''
          'delete from FI_FILE'
          'where DR_ID = :drid;'
          ''
          'delete FROM DR_DIR'
          'where DR_ID = :drid;')
      end>
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    ScriptOptions.TrimSpool = False
    Params = <
      item
        Name = 'drid'
        DataType = ftInteger
        ParamType = ptInput
      end>
    Macros = <>
    Left = 296
    Top = 120
  end
end
