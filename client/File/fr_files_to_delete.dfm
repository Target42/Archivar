object FilesToDeleteFrame: TFilesToDeleteFrame
  Left = 0
  Top = 0
  Width = 451
  Height = 305
  Align = alClient
  TabOrder = 0
  object LV: TListView
    Left = 0
    Top = 0
    Width = 451
    Height = 305
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 250
      end
      item
        Caption = 'L'#246'schung'
        Width = 100
      end
      item
        Caption = 'Resttage'
        Width = 75
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMisc'
    SQLConnection = GM.SQLConnection1
    Left = 72
    Top = 16
  end
  object FilesToDeleteQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'PE_ID'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'TAGE'
        ParamType = ptInput
        Value = 34
      end>
    ProviderName = 'FilesToDeleteQry'
    RemoteServer = DSProviderConnection1
    Left = 192
    Top = 24
    object FilesToDeleteQryFI_ID: TIntegerField
      FieldName = 'FI_ID'
      Required = True
    end
    object FilesToDeleteQryFI_NAME: TStringField
      FieldName = 'FI_NAME'
      Size = 150
    end
    object FilesToDeleteQryFI_CREATED: TDateField
      FieldName = 'FI_CREATED'
    end
    object FilesToDeleteQryFI_TODELETE: TDateField
      FieldName = 'FI_TODELETE'
    end
    object FilesToDeleteQryFI_VERSION: TIntegerField
      FieldName = 'FI_VERSION'
    end
    object FilesToDeleteQryFI_CREATED_BY: TStringField
      FieldName = 'FI_CREATED_BY'
      Size = 200
    end
    object FilesToDeleteQryDR_ID: TIntegerField
      FieldName = 'DR_ID'
    end
    object FilesToDeleteQryFI_SIZE: TLargeintField
      FieldName = 'FI_SIZE'
    end
    object FilesToDeleteQryFI_LOCKED: TStringField
      FieldName = 'FI_LOCKED'
      FixedChar = True
      Size = 1
    end
  end
end
