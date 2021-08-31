object dsGremium: TdsGremium
  OldCreateOrder = False
  Height = 456
  Width = 983
  object GRTab: TDataSetProvider
    DataSet = GremiumTab
    Left = 24
    Top = 128
  end
  object AllUserQry: TDataSetProvider
    DataSet = SelectAllUserQry
    Left = 408
    Top = 112
  end
  object GrUserQry: TDataSetProvider
    DataSet = SelectGrUserQry
    Left = 400
    Top = 177
  end
  object Images: TDataSetProvider
    DataSet = PicTab
    Left = 104
    Top = 128
  end
  object GremiumTab: TFDTable
    IndexFieldNames = 'GR_SHORT'
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'GR_GREMIUM'
    TableName = 'GR_GREMIUM'
    Left = 24
    Top = 72
  end
  object FDTransaction1: TFDTransaction
    Connection = DBMod.ArchivarConnection
    Left = 24
    Top = 24
  end
  object AutoIncQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Left = 104
    Top = 24
  end
  object PicTab: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'PI_PIC'
    TableName = 'PI_PIC'
    Left = 104
    Top = 72
  end
  object GRPE: TFDTable
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    UpdateOptions.UpdateTableName = 'GR_PA'
    TableName = 'GR_PA'
    Left = 176
    Top = 72
  end
  object FindMAQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from GR_PA'
      'where GR_ID = :gr_id'
      'and PE_ID = :pe_id')
    Left = 32
    Top = 232
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object AddMAQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'insert into GR_PA( GR_ID, PE_ID)'
      'values( :gr_id, :pe_id);')
    Left = 32
    Top = 288
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object RemoveMAQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'delete from GR_PA'
      'where GR_ID = :gr_id'
      'and PE_ID = :pe_id')
    Left = 104
    Top = 288
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object changeRollQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'update GR_PA'
      'set GP_ROLLE = :rolle'
      'where GR_ID = :gr_id '
      'and PE_ID = :pe_id')
    Left = 184
    Top = 288
    ParamData = <
      item
        Name = 'ROLLE'
        DataType = ftString
        ParamType = ptInput
      end
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end
      item
        Name = 'PE_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
  object SelectAllUserQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select * from PE_PERSON'
      'where PE_ID > 9'
      'order by PE_NAME, PE_VORNAME')
    Left = 312
    Top = 104
  end
  object SelectGrUserQry: TFDQuery
    Connection = DBMod.ArchivarConnection
    Transaction = FDTransaction1
    SQL.Strings = (
      'select  * from GR_PA a, PE_PERSON b'
      'where a.GR_ID = :gr_id'
      'and a.PE_ID = b.PE_ID'
      'order by b.PE_NAME, b.PE_VORNAME')
    Left = 312
    Top = 160
    ParamData = <
      item
        Name = 'GR_ID'
        DataType = ftInteger
        ParamType = ptInput
      end>
  end
end
