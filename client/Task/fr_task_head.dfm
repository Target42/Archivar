object TaskHeaderFrame: TTaskHeaderFrame
  Left = 0
  Top = 0
  Width = 601
  Height = 127
  Align = alTop
  TabOrder = 0
  ExplicitWidth = 451
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 601
    Height = 127
    Align = alClient
    Caption = 'Aufgabe'
    TabOrder = 0
    ExplicitWidth = 451
    DesignSize = (
      601
      127)
    object Label1: TLabel
      Left = 11
      Top = 24
      Width = 20
      Height = 13
      Caption = 'Titel'
    end
    object Label2: TLabel
      Left = 11
      Top = 70
      Width = 58
      Height = 13
      Caption = 'Erzeugt von'
    end
    object Label3: TLabel
      Left = 200
      Top = 70
      Width = 44
      Height = 13
      Caption = 'Gestated'
    end
    object Label4: TLabel
      Left = 304
      Top = 70
      Width = 32
      Height = 13
      Caption = 'Termin'
    end
    object Label5: TLabel
      Left = 408
      Top = 70
      Width = 31
      Height = 13
      Caption = 'Status'
    end
    object DBEdit1: TDBEdit
      Left = 11
      Top = 43
      Width = 578
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'TA_NAME'
      TabOrder = 0
      ExplicitWidth = 428
    end
    object DBEdit2: TDBEdit
      Left = 11
      Top = 89
      Width = 174
      Height = 21
      BiDiMode = bdLeftToRight
      DataField = 'TA_CREATED_BY'
      Enabled = False
      ParentBiDiMode = False
      ReadOnly = True
      TabOrder = 1
    end
    object DBEdit3: TDBEdit
      Left = 200
      Top = 89
      Width = 89
      Height = 21
      DataField = 'TA_STARTED'
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object DBEdit4: TDBEdit
      Left = 304
      Top = 89
      Width = 89
      Height = 21
      DataField = 'TA_TERMIN'
      TabOrder = 3
    end
    object ComboBox1: TComboBox
      Left = 408
      Top = 89
      Width = 145
      Height = 21
      TabOrder = 4
      OnChange = ComboBox1Change
      Items.Strings = (
        'Gelesen'
        'In Bearbeitung'
        'Bearbeitung abgeschlossen'
        'Kl'#228'rumgsbedarf')
    end
  end
end
