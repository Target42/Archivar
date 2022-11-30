object CorrectForm: TCorrectForm
  Left = 0
  Top = 0
  Caption = 'Rechtschreibung'
  ClientHeight = 292
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 316
    Height = 65
    Align = alTop
    Caption = 'Wort'
    TabOrder = 0
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 193
      Height = 21
      TabOrder = 0
      Text = 'Edit1'
    end
    object BitBtn1: TBitBtn
      Left = 232
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Ersetzen'
      TabOrder = 1
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 65
    Width = 316
    Height = 127
    Align = alClient
    Caption = 'Vorschl'#228'ge'
    TabOrder = 1
    object LB: TListBox
      Left = 2
      Top = 15
      Width = 312
      Height = 110
      Align = alClient
      ItemHeight = 13
      TabOrder = 0
      OnDblClick = LBDblClick
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 192
    Width = 316
    Height = 100
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object BitBtn2: TBitBtn
      Left = 16
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Start'
      TabOrder = 0
      OnClick = BitBtn2Click
    end
    object BitBtn4: TBitBtn
      Left = 16
      Top = 55
      Width = 75
      Height = 25
      Caption = 'Position'
      TabOrder = 1
      OnClick = BitBtn4Click
    end
    object BitBtn3: TBitBtn
      Left = 97
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Weiter'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn5: TBitBtn
      Left = 178
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Hinzuf'#252'gen'
      TabOrder = 3
      OnClick = BitBtn5Click
    end
  end
end
