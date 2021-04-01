object TaskFilterForm: TTaskFilterForm
  Left = 0
  Top = 0
  Caption = 'Filter'
  ClientHeight = 270
  ClientWidth = 323
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 210
    Width = 323
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 156
    ExplicitWidth = 323
    inherited StatusBar1: TStatusBar
      Width = 323
      ExplicitWidth = 323
    end
    inherited Panel1: TPanel
      Width = 323
      ExplicitWidth = 323
      inherited OKBtn: TBitBtn
        Left = 224
        ExplicitLeft = 224
      end
    end
  end
  object LB: TCheckListBox
    Left = 0
    Top = 0
    Width = 323
    Height = 160
    Align = alClient
    ItemHeight = 13
    Sorted = True
    TabOrder = 1
    ExplicitTop = 2
    ExplicitHeight = 111
  end
  object Panel1: TGroupBox
    Left = 0
    Top = 160
    Width = 323
    Height = 50
    Align = alBottom
    Caption = 'Auswahl'
    Color = clBtnFace
    ParentColor = False
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 16
      Top = 19
      Width = 49
      Height = 25
      Caption = 'Alle'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 71
      Top = 19
      Width = 49
      Height = 25
      Caption = 'Nichts'
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 126
      Top = 19
      Width = 49
      Height = 25
      Caption = 'Protokoll'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
end
