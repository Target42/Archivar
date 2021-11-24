object Keysform: TKeysform
  Left = 0
  Top = 0
  Caption = 'Schl'#252'sselerzeugung'
  ClientHeight = 707
  ClientWidth = 518
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 72
    Width = 518
    Height = 185
    Align = alTop
    Caption = #214'ffentlicher Schl'#252'ssel'
    TabOrder = 0
    object Memo1: TMemo
      Left = 2
      Top = 15
      Width = 514
      Height = 168
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitLeft = 3
      ExplicitTop = 11
      ExplicitWidth = 631
      ExplicitHeight = 104
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 518
    Height = 72
    Align = alTop
    Caption = 'Passwort privater Schl'#252'ssel'
    TabOrder = 1
    ExplicitWidth = 635
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 32
      Width = 161
      Height = 21
      EditLabel.Width = 44
      EditLabel.Height = 13
      EditLabel.Caption = 'Passwort'
      PasswordChar = '*'
      TabOrder = 0
    end
    object LabeledEdit2: TLabeledEdit
      Left = 192
      Top = 32
      Width = 161
      Height = 21
      EditLabel.Width = 66
      EditLabel.Height = 13
      EditLabel.Caption = 'Wiederholung'
      PasswordChar = '*'
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 368
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Erzeugen'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 257
    Width = 518
    Height = 450
    Align = alClient
    Caption = 'Privater Schl'#252'ssel'
    TabOrder = 2
    ExplicitTop = 193
    ExplicitWidth = 635
    ExplicitHeight = 121
    object Memo2: TMemo
      Left = 2
      Top = 15
      Width = 514
      Height = 433
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'Memo1')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
      ExplicitWidth = 631
      ExplicitHeight = 104
    end
  end
end
