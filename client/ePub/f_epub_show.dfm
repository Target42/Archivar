object ePubShowForm: TePubShowForm
  Left = 0
  Top = 0
  Caption = 'Lokale ePubs'
  ClientHeight = 464
  ClientWidth = 1039
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
    Width = 1039
    Height = 445
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 1039
    ExplicitHeight = 445
    inherited GroupBox1: TGroupBox
      Width = 1039
      Height = 380
      ExplicitWidth = 1037
      ExplicitHeight = 376
      inherited DBGrid1: TDBGrid
        Width = 1035
        Height = 361
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
      Top = 380
      Width = 1039
      ExplicitTop = 376
      ExplicitWidth = 1037
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 445
    Width = 1039
    Height = 19
    Panels = <>
    ExplicitTop = 441
    ExplicitWidth = 1037
  end
end
