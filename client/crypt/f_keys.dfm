object Keysform: TKeysform
  Left = 0
  Top = 0
  Caption = 'Schl'#252'sselerzeugung'
  ClientHeight = 399
  ClientWidth = 529
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
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 529
    Height = 72
    Align = alTop
    Caption = 'Passwort privater Schl'#252'ssel'
    TabOrder = 0
    ExplicitWidth = 518
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
  object PageControl1: TPageControl
    Left = 0
    Top = 72
    Width = 529
    Height = 327
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 64
    ExplicitTop = 112
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabSheet1: TTabSheet
      Caption = #214'ffentlicher Schl'#252'ssel'
      ExplicitLeft = 12
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 521
        Height = 299
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
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Privater Schl'#252'ssel'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo2: TMemo
        Left = 0
        Top = 0
        Width = 521
        Height = 299
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
      end
    end
  end
end
