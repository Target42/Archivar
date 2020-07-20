object DatafieldEditform: TDatafieldEditform
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Datenfelddetails'
  ClientHeight = 331
  ClientWidth = 263
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 271
    Width = 263
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 271
    ExplicitWidth = 263
    inherited StatusBar1: TStatusBar
      Width = 263
      ExplicitWidth = 263
    end
    inherited Panel1: TPanel
      Width = 263
      ExplicitWidth = 263
      inherited OKBtn: TBitBtn
        Left = 175
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 175
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 263
    Height = 131
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    object Label1: TLabel
      Left = 152
      Top = 8
      Width = 18
      Height = 13
      Caption = 'Typ'
    end
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 24
      Width = 113
      Height = 21
      CharCase = ecUpperCase
      EditLabel.Width = 27
      EditLabel.Height = 13
      EditLabel.Caption = 'Name'
      TabOrder = 0
      OnKeyPress = LabeledEdit1KeyPress
    end
    object ComboBox1: TComboBox
      Left = 152
      Top = 27
      Width = 89
      Height = 21
      Sorted = True
      TabOrder = 1
      Text = 'ComboBox1'
      OnChange = ComboBox1Change
    end
    object LabeledEdit2: TLabeledEdit
      Left = 16
      Top = 69
      Width = 225
      Height = 21
      EditLabel.Width = 64
      EditLabel.Height = 13
      EditLabel.Caption = 'Beschreibung'
      TabOrder = 2
    end
    object Button1: TButton
      Left = 152
      Top = 100
      Width = 89
      Height = 25
      Caption = 'Tabellenfelder'
      TabOrder = 3
      OnClick = Button1Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 131
    Width = 263
    Height = 140
    Align = alClient
    Caption = 'Eigenschaften'
    TabOrder = 2
    object VE: TValueListEditor
      Left = 2
      Top = 15
      Width = 259
      Height = 123
      Align = alClient
      TabOrder = 0
      OnEditButtonClick = VEEditButtonClick
      OnExit = VEExit
      OnKeyPress = VEKeyPress
      ColWidths = (
        150
        103)
    end
  end
end
