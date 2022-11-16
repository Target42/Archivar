object Taskform: TTaskform
  Left = 0
  Top = 0
  ActiveControl = LVType
  Caption = 'Aufgabe'
  ClientHeight = 285
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 362
    Height = 285
    ActivePage = AufgabenTypen
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.ModalResult = 1
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Abbrechen'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Hilfe'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = False
    DesignSize = (
      362
      285)
    object Gremium: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Aufgabentypen'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Welches Gremium soll es bearbeiten?'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'Gremium'
      OnNextButtonClick = GremiumNextButtonClick
      object LV: TListView
        Left = 0
        Top = 70
        Width = 362
        Height = 173
        Align = alClient
        Columns = <
          item
            Caption = 'Kurz'
            Width = 75
          end
          item
            Caption = 'Name'
            Width = 200
          end>
        HideSelection = False
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = LVClick
        ExplicitTop = 78
        ExplicitHeight = 67
      end
    end
    object AufgabenTypen: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Gremium'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Welches Gremium soll die Aufgabe bearbeiten?'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'AufgabenTypen'
      OnEnterPage = AufgabenTypenEnterPage
      OnNextButtonClick = AufgabenTypenNextButtonClick
      object LVType: TListView
        Left = 0
        Top = 70
        Width = 362
        Height = 173
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 150
          end
          item
            Caption = 'Frist'
          end>
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = LVTypeClick
        ExplicitTop = 118
        ExplicitHeight = 75
      end
    end
    object Template: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Aufgabenvorlage'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Mit welcher Vorlage soll die Aufgabe bearbeitet werden?'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'Template'
      OnEnterPage = TemplateEnterPage
      object TEView: TListView
        Left = 0
        Top = 70
        Width = 362
        Height = 173
        Align = alClient
        Columns = <
          item
            Caption = 'Name'
            Width = 200
          end>
        ReadOnly = True
        RowSelect = True
        SortType = stText
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = TEViewClick
      end
    end
    object Details1: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Details'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Tahoma'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Detailinformationen'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -11
      Header.Subtitle.Font.Name = 'Tahoma'
      Header.Subtitle.Font.Style = []
      Caption = 'Details1'
      OnEnterPage = Details1EnterPage
      OnFinishButtonClick = Details1FinishButtonClick
      object Label2: TLabel
        Left = 19
        Top = 85
        Width = 50
        Height = 13
        Caption = 'Bearbeiter'
      end
      object Label3: TLabel
        Left = 19
        Top = 117
        Width = 38
        Height = 13
        Caption = 'Eingang'
      end
      object Label4: TLabel
        Left = 19
        Top = 193
        Width = 20
        Height = 13
        Caption = 'Titel'
      end
      object Label6: TLabel
        Left = 19
        Top = 144
        Width = 45
        Height = 13
        Caption = 'Fristende'
      end
      object Label7: TLabel
        Left = 19
        Top = 171
        Width = 21
        Height = 13
        Caption = 'Frist'
      end
      object DBEdit1: TDBEdit
        Left = 88
        Top = 82
        Width = 184
        Height = 21
        DataField = 'TA_CREATED_BY'
        DataSource = TaskSrc
        Enabled = False
        TabOrder = 0
      end
      object DBEdit2: TDBEdit
        Left = 88
        Top = 193
        Width = 184
        Height = 21
        DataField = 'TA_NAME'
        DataSource = TaskSrc
        TabOrder = 1
      end
      object JvDBDateTimePicker1: TJvDBDateTimePicker
        Left = 88
        Top = 109
        Width = 184
        Height = 21
        Date = 43893.633508275460000000
        Time = 43893.633508275460000000
        TabOrder = 2
        OnChange = JvDBDateTimePicker1Change
        DropDownDate = 43893.000000000000000000
        DataField = 'TA_STARTED'
        DataSource = TaskSrc
      end
      object JvDBDateTimePicker2: TJvDBDateTimePicker
        Left = 88
        Top = 136
        Width = 186
        Height = 21
        Date = 43895.375511296300000000
        Time = 43895.375511296300000000
        TabOrder = 3
        DropDownDate = 43895.000000000000000000
        DataField = 'TA_TERMIN'
        DataSource = TaskSrc
      end
      object Edit1: TEdit
        Left = 88
        Top = 166
        Width = 41
        Height = 21
        TabOrder = 4
        Text = 'Edit1'
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTask'
    SQLConnection = GM.SQLConnection1
    Left = 48
    Top = 8
  end
  object TaskTypes: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'GR_ID'
        ParamType = ptInput
      end>
    ProviderName = 'TaskTypes'
    RemoteServer = DSProviderConnection1
    Left = 120
    Top = 136
  end
  object Task: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'Task'
    RemoteServer = DSProviderConnection1
    Left = 216
    Top = 8
  end
  object TaskSrc: TDataSource
    DataSet = Task
    Left = 216
    Top = 64
  end
  object TEQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'id'
        ParamType = ptInput
      end>
    ProviderName = 'TemplatesQry'
    RemoteServer = DSProviderConnection1
    Left = 56
    Top = 112
  end
end
