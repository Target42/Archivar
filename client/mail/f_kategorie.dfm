object KategorieForm: TKategorieForm
  Left = 0
  Top = 0
  Caption = 'Kategorien'
  ClientHeight = 272
  ClientWidth = 238
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 212
    Width = 238
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 216
    ExplicitWidth = 240
    inherited StatusBar1: TStatusBar
      Width = 240
      ExplicitWidth = 240
    end
    inherited Panel1: TPanel
      Width = 240
      ExplicitWidth = 240
      inherited OKBtn: TBitBtn
        Left = 141
        ExplicitLeft = 141
      end
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 238
    Height = 212
    Align = alClient
    Checkboxes = True
    Columns = <
      item
        Caption = 'Name'
        Width = 150
      end>
    ReadOnly = True
    SmallImages = ImageList1
    TabOrder = 1
    ViewStyle = vsReport
    ExplicitTop = 2
    ExplicitWidth = 240
    ExplicitHeight = 216
  end
  object ImageList1: TImageList
    Left = 72
    Top = 80
  end
end
