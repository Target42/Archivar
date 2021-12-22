object FileInfoForm: TFileInfoForm
  Left = 0
  Top = 0
  Caption = 'Dateiinformationen'
  ClientHeight = 299
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 239
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = 184
    ExplicitTop = 32
    inherited StatusBar1: TStatusBar
      Width = 635
    end
    inherited Panel1: TPanel
      Width = 635
      inherited OKBtn: TBitBtn
        Left = 536
      end
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 635
    Height = 239
    Align = alClient
    Columns = <
      item
        Caption = 'Name'
        Width = 150
      end
      item
        Caption = 'Version'
      end
      item
        Caption = 'Gr'#246#223'e'
        Width = 75
      end
      item
        Caption = 'Erzeugt'
        Width = 75
      end
      item
        Caption = 'L'#246'schdatum'
        Width = 75
      end
      item
        Caption = 'Benutzer'
        Width = 150
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitLeft = 136
    ExplicitTop = 40
    ExplicitWidth = 250
    ExplicitHeight = 150
  end
end
