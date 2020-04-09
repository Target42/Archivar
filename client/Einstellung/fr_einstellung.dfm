object Einstellungsframe: TEinstellungsframe
  Left = 0
  Top = 0
  Width = 451
  Height = 337
  Align = alTop
  TabOrder = 0
  inline TaskHeaderFrame1: TTaskHeaderFrame
    Left = 0
    Top = 0
    Width = 451
    Height = 138
    Align = alTop
    TabOrder = 0
    ExplicitHeight = 138
    inherited GroupBox1: TGroupBox
      Width = 451
      Height = 138
      ExplicitHeight = 138
      inherited Label3: TLabel
        Left = 191
        Width = 48
        Caption = 'Gestarted'
        ExplicitLeft = 191
        ExplicitWidth = 48
      end
      inherited Label4: TLabel
        Left = 272
        ExplicitLeft = 272
      end
      inherited DBEdit1: TDBEdit
        Width = 172
        OnChange = TaskHeaderFrame1DBEdit1Change
        ExplicitWidth = 172
      end
      inherited DBEdit2: TDBEdit
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      inherited DBEdit3: TDBEdit
        Left = 191
        Width = 75
        DataSource = TaskSrc
        OnChange = TaskHeaderFrame1DBEdit1Change
        ExplicitLeft = 191
        ExplicitWidth = 75
      end
      inherited DBEdit4: TDBEdit
        Left = 272
        Width = 65
        OnChange = TaskHeaderFrame1DBEdit1Change
        ExplicitLeft = 272
        ExplicitWidth = 65
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 138
    Width = 451
    Height = 199
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Daten'
      object Label1: TLabel
        Left = 11
        Top = 24
        Width = 27
        Height = 13
        Caption = 'Name'
      end
      object Label10: TLabel
        Left = 204
        Top = 113
        Width = 32
        Height = 13
        Caption = 'Extern'
      end
      object Label11: TLabel
        Left = 308
        Top = 110
        Width = 70
        Height = 13
        Caption = 'Ausschreibung'
      end
      object Label2: TLabel
        Left = 156
        Top = 24
        Width = 42
        Height = 13
        Caption = 'Vorname'
      end
      object Label3: TLabel
        Left = 308
        Top = 24
        Width = 45
        Height = 13
        Caption = 'Abteilung'
      end
      object Label4: TLabel
        Left = 11
        Top = 64
        Width = 32
        Height = 13
        Caption = 'Termin'
      end
      object Label5: TLabel
        Left = 308
        Top = 64
        Width = 115
        Height = 13
        Caption = 'Lohngruppe, Einstellung'
      end
      object Label6: TLabel
        Left = 154
        Top = 64
        Width = 134
        Height = 13
        Caption = 'Lohngruppe, Ausschreibung'
      end
      object Label7: TLabel
        Left = 79
        Top = 113
        Width = 30
        Height = 13
        Caption = 'Intern'
      end
      object Label8: TLabel
        Left = 12
        Top = 113
        Width = 46
        Height = 13
        Caption = 'Bewerber'
      end
      object Label9: TLabel
        Left = 141
        Top = 113
        Width = 39
        Height = 13
        Caption = 'Konzern'
      end
      object DBEdit1: TDBEdit
        Left = 12
        Top = 43
        Width = 121
        Height = 21
        DataField = 'ES_NAME'
        DataSource = ESSrc
        TabOrder = 0
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit10: TDBEdit
        Left = 204
        Top = 132
        Width = 46
        Height = 21
        DataField = 'ES_EXTERN'
        DataSource = ESSrc
        TabOrder = 10
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit11: TDBEdit
        Left = 308
        Top = 129
        Width = 121
        Height = 21
        DataField = 'ES_TH'
        DataSource = ESSrc
        TabOrder = 9
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit2: TDBEdit
        Left = 156
        Top = 43
        Width = 121
        Height = 21
        DataField = 'ES_VORNAME'
        DataSource = ESSrc
        TabOrder = 1
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit3: TDBEdit
        Left = 308
        Top = 43
        Width = 121
        Height = 21
        DataField = 'ES_DEPARTMENT'
        DataSource = ESSrc
        TabOrder = 2
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit4: TDBEdit
        Left = 12
        Top = 83
        Width = 121
        Height = 21
        DataField = 'ES_TERMIN'
        DataSource = ESSrc
        TabOrder = 3
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit5: TDBEdit
        Left = 156
        Top = 83
        Width = 121
        Height = 21
        DataField = 'ES_AUSSCHREIBUNG'
        DataSource = ESSrc
        TabOrder = 4
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit6: TDBEdit
        Left = 308
        Top = 83
        Width = 121
        Height = 21
        DataField = 'ES_EINSTELLUNG'
        DataSource = ESSrc
        TabOrder = 5
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit7: TDBEdit
        Left = 12
        Top = 132
        Width = 46
        Height = 21
        DataField = 'ES_BEWERBER'
        DataSource = ESSrc
        TabOrder = 6
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit8: TDBEdit
        Left = 79
        Top = 132
        Width = 46
        Height = 21
        DataField = 'ES_INTERN'
        DataSource = ESSrc
        TabOrder = 7
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
      object DBEdit9: TDBEdit
        Left = 139
        Top = 132
        Width = 46
        Height = 21
        DataField = 'ES_KONZERN'
        DataSource = ESSrc
        TabOrder = 8
        OnChange = TaskHeaderFrame1DBEdit1Change
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Anmerkungen'
      ImageIndex = 1
      inline EditFrame1: TEditFrame
        Left = 0
        Top = 0
        Width = 443
        Height = 171
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 443
        ExplicitHeight = 171
        inherited RE: TRichEdit
          Width = 443
          Height = 171
          ExplicitWidth = 443
          ExplicitHeight = 171
        end
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsEinstellung'
    SQLConnection = GM.SQLConnection1
    Left = 360
    Top = 16
  end
  object TaskTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TaskTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 144
    Top = 24
  end
  object TaskSrc: TDataSource
    AutoEdit = False
    DataSet = TaskTab
    Left = 144
    Top = 80
  end
  object EinstellungTab: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'ES_ID'
    MasterFields = 'TA_SUB_ID'
    MasterSource = TaskSrc
    PacketRecords = 0
    Params = <>
    ProviderName = 'EinstellungTab'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 208
    Top = 80
  end
  object ESSrc: TDataSource
    AutoEdit = False
    DataSet = EinstellungTab
    Left = 280
    Top = 120
  end
end
