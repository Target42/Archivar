object TaskList2Frame: TTaskList2Frame
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
    Height = 273
    Align = alClient
    Columns = <
      item
        Caption = 'Titel'
        Width = 100
      end
      item
        Caption = 'Type'
        Width = 100
      end
      item
        Caption = 'Termin'
        Width = 75
      end
      item
        Caption = 'Eingang'
        Width = 75
      end
      item
        Caption = 'Status'
        Width = 150
      end>
    DragMode = dmAutomatic
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 273
    Width = 451
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object CheckBox1: TCheckBox
      Tag = 1
      Left = 16
      Top = 6
      Width = 49
      Height = 17
      Caption = 'Neu'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Tag = 2
      Left = 71
      Top = 6
      Width = 58
      Height = 17
      Caption = 'Gelesen'
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox3: TCheckBox
      Tag = 4
      Left = 135
      Top = 6
      Width = 90
      Height = 17
      Caption = 'In Bearbeitung'
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object CheckBox4: TCheckBox
      Tag = 8
      Left = 231
      Top = 6
      Width = 154
      Height = 17
      Caption = 'Bearbeitung abgeschlossen'
      TabOrder = 3
      OnClick = CheckBox1Click
    end
    object CheckBox5: TCheckBox
      Tag = 16
      Left = 384
      Top = 6
      Width = 97
      Height = 17
      Caption = 'Kl'#228'rungsbedarf'
      TabOrder = 4
      OnClick = CheckBox1Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsChapter'
    Left = 56
    Top = 16
  end
  object ListTasksQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
    ProviderName = 'ListTasks'
    RemoteServer = DSProviderConnection1
    Left = 32
    Top = 72
  end
end
