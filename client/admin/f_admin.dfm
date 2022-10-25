object AdminForm: TAdminForm
  Left = 0
  Top = 0
  Caption = 'Admin'
  ClientHeight = 254
  ClientWidth = 635
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 235
    Width = 635
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 635
    Height = 113
    Align = alClient
    Caption = 'Nachricht'
    TabOrder = 1
    DesignSize = (
      635
      113)
    object CheckBox1: TCheckBox
      Left = 16
      Top = 24
      Width = 57
      Height = 17
      Caption = 'Wichtig'
      TabOrder = 0
    end
    object Memo1: TMemo
      Left = 79
      Top = 22
      Width = 442
      Height = 75
      Anchors = [akLeft, akTop, akRight, akBottom]
      Lines.Strings = (
        'Memo1')
      ScrollBars = ssVertical
      TabOrder = 1
      WordWrap = False
    end
    object Senden: TBitBtn
      Left = 544
      Top = 20
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Senden'
      TabOrder = 2
      OnClick = SendenClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 171
    Width = 635
    Height = 64
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    ExplicitTop = 165
    object BitBtn1: TBitBtn
      Left = 24
      Top = 24
      Width = 121
      Height = 25
      Caption = 'Editoren schlie'#223'en'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 151
      Top = 24
      Width = 138
      Height = 25
      Caption = 'Alle Clients schlie'#223'en'
      TabOrder = 1
      OnClick = BitBtn3Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 113
    Width = 635
    Height = 58
    Align = alBottom
    Caption = 'Reboot'
    TabOrder = 3
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Sekunden'
    end
    object SpinEdit1: TSpinEdit
      Left = 69
      Top = 16
      Width = 52
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 0
      Value = 120
    end
    object LabeledEdit1: TLabeledEdit
      Left = 184
      Top = 16
      Width = 337
      Height = 21
      EditLabel.Width = 45
      EditLabel.Height = 13
      EditLabel.Caption = 'Nachricht'
      LabelPosition = lpLeft
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 544
      Top = 16
      Width = 75
      Height = 25
      Caption = 'Senden'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
  end
end
