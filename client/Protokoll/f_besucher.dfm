object BesucherForm: TBesucherForm
  Left = 0
  Top = 0
  ActiveControl = LabeledEdit1
  Caption = 'Besucher'
  ClientHeight = 270
  ClientWidth = 311
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 147
    Width = 18
    Height = 13
    Caption = 'Von'
    FocusControl = DateTimePicker1
  end
  object Label2: TLabel
    Left = 168
    Top = 147
    Width = 13
    Height = 13
    Caption = 'Bis'
    FocusControl = DateTimePicker2
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 210
    Width = 311
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 6
    ExplicitTop = 171
    ExplicitWidth = 311
    inherited StatusBar1: TStatusBar
      Width = 311
      ExplicitWidth = 311
    end
    inherited Panel1: TPanel
      Width = 311
      ExplicitWidth = 311
      inherited OKBtn: TBitBtn
        Left = 212
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 212
      end
    end
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 32
    Width = 121
    Height = 21
    EditLabel.Width = 27
    EditLabel.Height = 13
    EditLabel.Caption = 'Name'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 168
    Top = 32
    Width = 121
    Height = 21
    EditLabel.Width = 42
    EditLabel.Height = 13
    EditLabel.Caption = 'Vorname'
    TabOrder = 1
  end
  object LabeledEdit3: TLabeledEdit
    Left = 16
    Top = 120
    Width = 273
    Height = 21
    EditLabel.Width = 29
    EditLabel.Height = 13
    EditLabel.Caption = 'Grund'
    TabOrder = 3
  end
  object DateTimePicker1: TDateTimePicker
    Left = 16
    Top = 166
    Width = 81
    Height = 21
    Date = 44190.829866851850000000
    Time = 44190.829866851850000000
    Kind = dtkTime
    TabOrder = 4
  end
  object DateTimePicker2: TDateTimePicker
    Left = 168
    Top = 166
    Width = 81
    Height = 21
    Date = 44190.829866851850000000
    Time = 44190.829866851850000000
    Kind = dtkTime
    TabOrder = 5
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 80
    Width = 121
    Height = 21
    EditLabel.Width = 45
    EditLabel.Height = 13
    EditLabel.Caption = 'Abteilung'
    TabOrder = 2
  end
end
