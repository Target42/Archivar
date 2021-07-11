object dsGremium: TdsGremium
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 456
  Width = 983
  object GremiumTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BeforePost = GremiumTabBeforePost
    BufferChunks = 1000
    CachedUpdates = False
    FieldDefs = <
      item
        Name = 'GR_ID'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'GR_NAME'
        DataType = ftWideString
        Size = 100
      end
      item
        Name = 'GR_SHORT'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'GR_PARENT_SHORT'
        DataType = ftWideString
        Size = 20
      end
      item
        Name = 'GR_CHANGES'
        DataType = ftBlob
        Size = 8
      end
      item
        Name = 'GR_PIC_NAME'
        DataType = ftWideString
        Size = 100
      end>
    IndexDefs = <
      item
        Name = 'PK_GR_GREMIUM'
        Fields = 'GR_ID'
        Options = [ixUnique]
      end
      item
        Name = 'GR_GREMIUM_SHORT'
        Fields = 'GR_SHORT'
        Options = [ixUnique]
      end>
    IndexFieldNames = 'GR_SHORT'
    StoreDefs = True
    TableName = 'GR_GREMIUM'
    UniDirectional = False
    Left = 56
    Top = 32
  end
  object IBTransaction1: TIBTransaction
    DefaultDatabase = DBMod.IBDatabase1
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    Left = 144
    Top = 32
  end
  object GRTab: TDataSetProvider
    DataSet = GremiumTab
    Left = 56
    Top = 88
  end
  object AutoIncQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    Left = 248
    Top = 32
  end
  object GRPE: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'GR_PA'
    UniDirectional = False
    Left = 240
    Top = 112
  end
  object SelectAllUserQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from PE_PERSON'
      'where PE_ID > 9'
      'order by PE_NAME, PE_VORNAME')
    Left = 120
    Top = 240
  end
  object AllUserQry: TDataSetProvider
    DataSet = SelectAllUserQry
    Left = 120
    Top = 304
  end
  object SelectGrUserQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select  * from GR_PA a, PE_PERSON b'
      'where a.GR_ID = :gr_id'
      'and a.PE_ID = b.PE_ID'
      'order by b.PE_NAME, b.PE_VORNAME')
    Left = 240
    Top = 232
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
  end
  object GrUserQry: TDataSetProvider
    DataSet = SelectGrUserQry
    Left = 240
    Top = 304
  end
  object FindMAQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'select * from GR_PA'
      'where GR_ID = :gr_id'
      'and PE_ID = :pe_id')
    Left = 400
    Top = 56
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object AddMAQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'insert into GR_PA( GR_ID, PE_ID)'
      'values( :gr_id, :pe_id);')
    Left = 392
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object RemoveMAQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'delete from GR_PA'
      'where GR_ID = :gr_id'
      'and PE_ID = :pe_id')
    Left = 472
    Top = 112
    ParamData = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object changeRollQry: TIBQuery
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = True
    SQL.Strings = (
      'update GR_PA'
      'set GP_ROLLE = :rolle'
      'where GR_ID = :gr_id '
      'and PE_ID = :pe_id')
    Left = 560
    Top = 112
    ParamData = <
      item
        DataType = ftString
        Name = 'rolle'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pe_id'
        ParamType = ptInput
      end>
  end
  object PicTab: TIBTable
    Database = DBMod.IBDatabase1
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    TableName = 'PI_PIC'
    UniDirectional = False
    Left = 48
    Top = 160
  end
  object Images: TDataSetProvider
    DataSet = PicTab
    Left = 48
    Top = 224
  end
end
