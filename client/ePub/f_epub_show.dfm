object ePubShowForm: TePubShowForm
  Left = 0
  Top = 0
  Caption = 'Lokale ePubs'
  ClientHeight = 468
  ClientWidth = 1041
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  inline ePupFrame1: TePupFrame
    Left = 0
    Top = 0
    Width = 1041
    Height = 449
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 175
    ExplicitTop = 120
    inherited GroupBox1: TGroupBox
      Width = 1041
      Height = 384
      inherited DBGrid1: TDBGrid
        Width = 1037
        Height = 365
        Columns = <
          item
            Expanded = False
            FieldName = 'EP_TITEL'
            Title.Caption = 'Titel'
            Width = 800
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EP_GROUP'
            Title.Caption = 'Gruppe'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'EP_SUBGROUP'
            Title.Caption = 'Untergruppe'
            Width = 100
            Visible = True
          end>
      end
    end
    inherited GroupBox2: TGroupBox
      Top = 384
      Width = 1041
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 449
    Width = 1041
    Height = 19
    Panels = <>
    ExplicitLeft = 880
    ExplicitTop = 360
    ExplicitWidth = 0
  end
end
