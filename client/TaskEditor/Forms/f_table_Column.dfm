object TableCloumnForm: TTableCloumnForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Tabellenspalte'
  ClientHeight = 180
  ClientWidth = 345
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
  object Label1: TLabel
    Left = 176
    Top = 53
    Width = 47
    Height = 13
    Caption = 'Datenfeld'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 120
    Width = 345
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 112
    ExplicitWidth = 276
    inherited StatusBar1: TStatusBar
      Width = 345
      ExplicitWidth = 276
    end
    inherited Panel1: TPanel
      Width = 345
      ExplicitWidth = 276
      inherited OKBtn: TBitBtn
        Left = 257
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 188
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 145
    Height = 21
    EditLabel.Width = 53
    EditLabel.Height = 13
    EditLabel.Caption = #220'berschrift'
    TabOrder = 1
  end
  object LabeledEdit2: TLabeledEdit
    Left = 176
    Top = 24
    Width = 41
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Breite'
    NumbersOnly = True
    TabOrder = 2
  end
  object ComboBox1: TComboBox
    Left = 176
    Top = 72
    Width = 145
    Height = 21
    Sorted = True
    TabOrder = 3
    Text = 'ComboBox1'
  end
  object LabeledEdit3: TLabeledEdit
    Left = 16
    Top = 72
    Width = 145
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Prefix'
    Enabled = False
    TabOrder = 4
  end
end
