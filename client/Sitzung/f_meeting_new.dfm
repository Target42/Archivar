object MeetingForm: TMeetingForm
  Left = 0
  Top = 0
  Caption = 'Sitzungsplanung'
  ClientHeight = 632
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 572
    Width = 677
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 572
    ExplicitWidth = 677
    inherited StatusBar1: TStatusBar
      Width = 677
      ExplicitWidth = 677
    end
    inherited Panel1: TPanel
      Width = 677
      ExplicitWidth = 677
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 578
        Top = 6
        Default = False
        Kind = bkCustom
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 578
        ExplicitTop = 6
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 677
    Height = 81
    Align = alTop
    Caption = 'Sitzungsdaten'
    TabOrder = 1
    object Label1: TLabel
      Left = 199
      Top = 24
      Width = 41
      Height = 13
      Caption = 'Protokoll'
    end
    object Label2: TLabel
      Left = 350
      Top = 24
      Width = 31
      Height = 13
      Caption = 'Datum'
    end
    object Label3: TLabel
      Left = 516
      Top = 24
      Width = 34
      Height = 13
      Caption = 'Uhrzeit'
    end
    object Label4: TLabel
      Left = 578
      Top = 24
      Width = 24
      Height = 13
      Caption = 'Ende'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 43
      Width = 177
      Height = 21
      EditLabel.Width = 41
      EditLabel.Height = 13
      EditLabel.Caption = 'Gremium'
      ReadOnly = True
      TabOrder = 0
    end
    object JvDBDateTimePicker1: TJvDBDateTimePicker
      Left = 350
      Top = 43
      Width = 160
      Height = 21
      Date = 44234.839669270830000000
      Time = 44234.839669270830000000
      TabOrder = 1
      DropDownDate = 44234.000000000000000000
      DataField = 'EL_DATUM'
      DataSource = ElSrc
    end
    object ComboBox1: TComboBox
      Left = 516
      Top = 43
      Width = 56
      Height = 21
      TabOrder = 2
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
    end
    object ComboBox2: TComboBox
      Left = 578
      Top = 43
      Width = 56
      Height = 21
      TabOrder = 3
      Text = 'ComboBox2'
    end
    object DBEdit1: TDBEdit
      Left = 199
      Top = 43
      Width = 145
      Height = 21
      DataField = 'PR_NAME'
      DataSource = ProcolSrc
      ReadOnly = True
      TabOrder = 4
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 81
    Width = 677
    Height = 431
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Inhalt'
      object Splitter1: TSplitter
        Left = 0
        Top = 279
        Width = 669
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 0
        ExplicitWidth = 267
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 0
        Width = 669
        Height = 279
        Align = alClient
        Caption = 'Tagesordnung'
        TabOrder = 0
        inline TOFrame1: TTOFrame
          Left = 2
          Top = 15
          Width = 665
          Height = 262
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 665
          ExplicitHeight = 262
          inherited VST: TVirtualStringTree
            Width = 665
            Height = 262
            ExplicitWidth = 665
            ExplicitHeight = 262
            Columns = <
              item
                Position = 0
                Text = #220'berschrift'
                Width = 200
              end
              item
                Position = 1
                Text = 'Datum'
                Width = 461
              end>
          end
        end
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 282
        Width = 669
        Height = 121
        Align = alBottom
        Caption = 'Anmerkungen'
        TabOrder = 1
        inline EditFrame1: TEditFrame
          Left = 2
          Top = 15
          Width = 665
          Height = 104
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 665
          ExplicitHeight = 104
          inherited RE: TRichEdit
            Width = 665
            Height = 104
            ExplicitWidth = 665
            ExplicitHeight = 104
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Teilnehmer'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 669
        Height = 403
        Align = alClient
        DataSource = TNSrc
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDrawColumnCell = DBGrid1DrawColumnCell
        Columns = <
          item
            Expanded = False
            FieldName = 'TN_NAME'
            Title.Caption = 'Name'
            Width = 80
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_VORNAME'
            Title.Caption = 'Vorname'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_ROLLE'
            Title.Caption = 'Rolle'
            Width = 90
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_STATUS_STR'
            Title.Caption = 'Status'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_DEPARTMENT'
            Title.Caption = 'Abteilung'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TN_GRUND'
            Title.Caption = 'Grund'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EP_READ'
            Title.Caption = 'Gelesen'
            Visible = True
          end>
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'G'#228'ste'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGrid2: TDBGrid
        Left = 0
        Top = 0
        Width = 669
        Height = 403
        Align = alClient
        DataSource = TGSrc
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'TG_NAME'
            Title.Caption = 'Name'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_VORNAME'
            Title.Caption = 'Vorname'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_DEPARTMENT'
            Title.Caption = 'Abteilung'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_VON'
            Title.Caption = 'Von'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_BIS'
            Title.Caption = 'bis'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'TG_GRUND'
            Title.Caption = 'Grund'
            Width = 150
            Visible = True
          end>
      end
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 512
    Width = 677
    Height = 60
    Align = alBottom
    Caption = 'Teilnahme'
    TabOrder = 3
    object Label5: TLabel
      Left = 148
      Top = 26
      Width = 29
      Height = 13
      Caption = 'Grund'
    end
    object BitBtn1: TBitBtn
      Left = 350
      Top = 16
      Width = 101
      Height = 25
      Caption = 'Status '#196'ndern'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object RadioButton1: TRadioButton
      Left = 16
      Top = 24
      Width = 70
      Height = 17
      Caption = 'Zusage'
      TabOrder = 1
      OnClick = RadioButton1Click
    end
    object RadioButton2: TRadioButton
      Left = 80
      Top = 24
      Width = 62
      Height = 17
      Caption = 'Absage'
      TabOrder = 2
      OnClick = RadioButton2Click
    end
    object ComboBox3: TComboBox
      Left = 183
      Top = 19
      Width = 145
      Height = 21
      TabOrder = 3
      Text = 'ComboBox3'
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsMeeing'
    Left = 48
    Top = 176
  end
  object ElTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'ElTab'
    RemoteServer = DSProviderConnection1
    BeforePost = ElTabBeforePost
    OnReconcileError = ElTabReconcileError
    Left = 24
    Top = 232
  end
  object ElSrc: TDataSource
    DataSet = ElTab
    Left = 24
    Top = 284
  end
  object ProtoQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'gr_id'
        ParamType = ptInput
      end>
    ProviderName = 'ListProtocolQry'
    RemoteServer = DSProviderConnection1
    AfterScroll = ProtoQryAfterScroll
    Left = 80
    Top = 232
  end
  object ProcolSrc: TDataSource
    DataSet = ProtoQry
    Left = 80
    Top = 284
  end
  object PRTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'PRTab'
    RemoteServer = DSProviderConnection1
    Left = 24
    Top = 348
  end
  object TNQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'el_id'
        ParamType = ptInput
      end
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
    ProviderName = 'TNQry'
    RemoteServer = DSProviderConnection1
    Left = 132
    Top = 233
    object TNQryEL_ID: TIntegerField
      FieldName = 'EL_ID'
      Origin = '"EL_PE"."EL_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TNQryPE_ID: TIntegerField
      FieldName = 'PE_ID'
      Origin = '"EL_PE"."PE_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TNQryEP_STATUS: TWideStringField
      FieldName = 'EP_STATUS'
      Origin = '"EL_PE"."EP_STATUS"'
      Size = 100
    end
    object TNQryEP_READ: TDateTimeField
      FieldName = 'EP_READ'
      Origin = '"EL_PE"."EP_READ"'
    end
    object TNQryPR_ID: TIntegerField
      FieldName = 'PR_ID'
      Origin = '"TN_TEILNEHMER"."PR_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TNQryTN_ID: TIntegerField
      FieldName = 'TN_ID'
      Origin = '"TN_TEILNEHMER"."TN_ID"'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object TNQryTN_NAME: TWideStringField
      FieldName = 'TN_NAME'
      Origin = '"TN_TEILNEHMER"."TN_NAME"'
      Size = 100
    end
    object TNQryTN_VORNAME: TWideStringField
      FieldName = 'TN_VORNAME'
      Origin = '"TN_TEILNEHMER"."TN_VORNAME"'
      Size = 100
    end
    object TNQryTN_DEPARTMENT: TWideStringField
      FieldName = 'TN_DEPARTMENT'
      Origin = '"TN_TEILNEHMER"."TN_DEPARTMENT"'
      Size = 25
    end
    object TNQryTN_ROLLE: TWideStringField
      FieldName = 'TN_ROLLE'
      Origin = '"TN_TEILNEHMER"."TN_ROLLE"'
      Size = 50
    end
    object TNQryTN_STATUS: TIntegerField
      FieldName = 'TN_STATUS'
      Origin = '"TN_TEILNEHMER"."TN_STATUS"'
    end
    object TNQryTN_GRUND: TWideStringField
      FieldName = 'TN_GRUND'
      Origin = '"TN_TEILNEHMER"."TN_GRUND"'
      Size = 100
    end
    object TNQryTN_STATUS_STR: TStringField
      FieldKind = fkCalculated
      FieldName = 'TN_STATUS_STR'
      OnGetText = TNQryTN_STATUS_STRGetText
      Size = 100
      Calculated = True
    end
  end
  object TNSrc: TDataSource
    DataSet = TNQry
    Left = 132
    Top = 289
  end
  object TGQry: TClientDataSet
    Aggregates = <>
    Params = <
      item
        DataType = ftInteger
        Name = 'pr_id'
        ParamType = ptInput
      end>
    ProviderName = 'TGQry'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 188
    Top = 233
  end
  object TGSrc: TDataSource
    DataSet = TGQry
    Left = 188
    Top = 289
  end
end
