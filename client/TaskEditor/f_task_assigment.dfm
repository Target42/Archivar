object TaskAssignmentForm: TTaskAssignmentForm
  Left = 0
  Top = 0
  Caption = 'Aufgabenzuweisungen'
  ClientHeight = 383
  ClientWidth = 976
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
    Top = 323
    Width = 976
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 323
    ExplicitWidth = 976
    inherited StatusBar1: TStatusBar
      Width = 976
      ExplicitWidth = 976
    end
    inherited Panel1: TPanel
      Width = 976
      ExplicitWidth = 976
      inherited OKBtn: TBitBtn
        Left = 881
        Visible = False
        ExplicitLeft = 881
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 656
    Top = 0
    Width = 320
    Height = 323
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 2
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 316
      Height = 306
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 316
      ExplicitHeight = 306
      inherited Panel1: TPanel
        Top = 250
        Width = 316
        ExplicitTop = 250
        ExplicitWidth = 316
        inherited LabeledEdit1: TLabeledEdit
          Width = 301
          ExplicitWidth = 301
        end
      end
      inherited LV: TListView
        Width = 316
        Height = 250
        ExplicitWidth = 316
        ExplicitHeight = 250
      end
    end
  end
  object GroupBox3: TGroupBox
    Left = 241
    Top = 0
    Width = 415
    Height = 323
    Align = alClient
    Caption = 'Grund'
    TabOrder = 3
    inline EditFrame1: TEditFrame
      Left = 2
      Top = 15
      Width = 411
      Height = 306
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 411
      ExplicitHeight = 306
      inherited RE: TRichEdit
        Width = 411
        Height = 272
        OnDragDrop = EditFrame1REDragDrop
        OnDragOver = EditFrame1REDragOver
        ExplicitWidth = 411
        ExplicitHeight = 272
      end
      inherited Panel1: TPanel
        Width = 411
        ExplicitWidth = 411
        inherited JvColorComboBox1: TJvColorComboBox
          Height = 20
          ExplicitHeight = 20
        end
      end
    end
  end
  object GroupBox1: TPanel
    Left = 0
    Top = 0
    Width = 241
    Height = 323
    Align = alLeft
    ParentColor = True
    TabOrder = 1
    object Splitter1: TSplitter
      Left = 1
      Top = 197
      Width = 239
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitLeft = -2
      ExplicitTop = 125
    end
    object GroupBox4: TGroupBox
      Left = 1
      Top = 1
      Width = 239
      Height = 196
      Align = alClient
      Caption = 'Zugewiesen'
      TabOrder = 0
      DesignSize = (
        239
        196)
      object LB: TListBox
        AlignWithMargins = True
        Left = 5
        Top = 18
        Width = 229
        Height = 140
        Margins.Bottom = 36
        Align = alClient
        ItemHeight = 13
        TabOrder = 0
      end
      object BitBtn2: TBitBtn
        Left = 15
        Top = 165
        Width = 130
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Zuweisung entfernen'
        TabOrder = 1
        OnClick = BitBtn2Click
      end
    end
    object GroupBox5: TGroupBox
      Left = 1
      Top = 200
      Width = 239
      Height = 122
      Align = alBottom
      Caption = 'Zuweisen'
      TabOrder = 1
      DesignSize = (
        239
        122)
      object Label1: TLabel
        Left = 15
        Top = 24
        Width = 41
        Height = 13
        Caption = 'Gremium'
      end
      object ComboBox1: TComboBox
        Left = 15
        Top = 43
        Width = 210
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        Sorted = True
        TabOrder = 0
        Text = 'ComboBox1'
      end
      object BitBtn1: TBitBtn
        Left = 15
        Top = 80
        Width = 75
        Height = 25
        Caption = 'Zuweisen'
        TabOrder = 1
        OnClick = BitBtn1Click
      end
    end
  end
end
