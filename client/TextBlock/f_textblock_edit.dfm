object TextBlockEditForm: TTextBlockEditForm
  Left = 0
  Top = 0
  Caption = 'Textbausteineditor'
  ClientHeight = 661
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
    Top = 601
    Width = 635
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 601
    ExplicitWidth = 635
    inherited StatusBar1: TStatusBar
      Width = 635
      ExplicitWidth = 635
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited AbortBtn: TBitBtn
        OnClick = BaseFrame1AbortBtnClick
      end
      inherited OKBtn: TBitBtn
        Left = 536
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 536
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 113
    Align = alTop
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    DesignSize = (
      635
      113)
    object Label1: TLabel
      Left = 16
      Top = 95
      Width = 22
      Height = 13
      Caption = 'Text'
    end
    object Label3: TLabel
      Left = 16
      Top = 4
      Width = 27
      Height = 13
      Caption = 'Name'
    end
    object Label4: TLabel
      Left = 16
      Top = 50
      Width = 23
      Height = 13
      Caption = 'Tags'
    end
    object SpeedButton1: TSpeedButton
      Left = 599
      Top = 68
      Width = 23
      Height = 22
      Anchors = [akLeft, akTop, akRight]
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object LabeledEdit1: TDBEdit
      Left = 16
      Top = 23
      Width = 241
      Height = 21
      DataField = 'TB_NAME'
      DataSource = TBSrc
      TabOrder = 0
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit2: TDBEdit
      Left = 16
      Top = 68
      Width = 569
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      DataField = 'TB_TAGS'
      DataSource = TBSrc
      TabOrder = 1
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 338
    Width = 635
    Height = 263
    Align = alBottom
    Caption = 'Variablen'
    TabOrder = 2
    object Panel2: TPanel
      Left = 2
      Top = 136
      Width = 631
      Height = 125
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 0
      object Label2: TLabel
        Left = 323
        Top = 0
        Width = 45
        Height = 13
        Caption = 'Datentyp'
      end
      object Label5: TLabel
        Left = 488
        Top = 0
        Width = 35
        Height = 13
        Caption = 'Default'
      end
      object LabeledEdit3: TLabeledEdit
        Left = 14
        Top = 16
        Width = 121
        Height = 21
        CharCase = ecUpperCase
        EditLabel.Width = 27
        EditLabel.Height = 13
        EditLabel.Caption = 'Name'
        MaxLength = 15
        TabOrder = 0
      end
      object LabeledEdit4: TLabeledEdit
        Left = 152
        Top = 16
        Width = 153
        Height = 21
        EditLabel.Width = 53
        EditLabel.Height = 13
        EditLabel.Caption = #220'berschrift'
        TabOrder = 1
      end
      object LabeledEdit5: TLabeledEdit
        Left = 14
        Top = 60
        Width = 606
        Height = 21
        EditLabel.Width = 64
        EditLabel.Height = 13
        EditLabel.Caption = 'Beschreibung'
        TabOrder = 4
      end
      object ComboBox1: TComboBox
        Left = 323
        Top = 16
        Width = 145
        Height = 21
        ItemIndex = 0
        TabOrder = 2
        Text = 'String'
        Items.Strings = (
          'String'
          'Zahl'
          'Datum')
      end
      object btnNeu: TBitBtn
        Left = 14
        Top = 96
        Width = 75
        Height = 25
        Caption = 'Neu'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004499440F47A0
          439B47A043ED47A043ED48A0439949A4490EFFFFFF00FFFFFF00FFFFFF00FFAA
          5503F5A442D6F5A542FFF5A542FFF5A542FFF5A542FFF5A542FF7FA242FF47A0
          43FF99CA97FF99CA97FF47A043FF56A142BDFFFFFF00FFFFFF00FFFFFF00F5A4
          4335F5A542FFF5A542FFF5A542FFF5A542FFF5A542FFD7A543FF47A043FF84C0
          82FFD6EAD6FFD6EAD6FF84C082FF47A043FF44A24429FFFFFF00FFFFFF00F6A4
          4038F6AE57CAF7B461D2F7B461D2F7B461D2F7B461D2BEAE58DF47A043FFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFF47A043FF469F4345FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFE9C689FF4BA145FF47A0
          43FFC2E0C1FFC2E0C1FF47A043FF47A043F946A24616FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFA7B76CFF47A0
          43FF6FB56CFF6FB56CFF47A043FE47A04373FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9241FFDF9241FFE39C4EFFC8BA
          74FF8FB162FF7EAD5BDD469F4345FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
          68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF0B875FFF0B875FFECAE68FFECAE68FFECAE68FFECAE
          68FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
          40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFE8A55BFFE8A55BFFDF9240FFDF9240FFDF9240FFDF92
          40FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
          90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
          90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00F9C991ABF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA90FFF9CA
          90FFF9CA90FFF9C991ABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        TabOrder = 5
        OnClick = btnNeuClick
      end
      object btnEdit: TBitBtn
        Left = 104
        Top = 96
        Width = 90
        Height = 25
        Caption = 'Bearbeiten'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003278889013ACE06C00AE
          FF13FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0011B0E56A06BBFFC60099
          FFCF0097FF16FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFE8DBC0FF24A3F5FF0098
          FFFF24A2F5FFE0D6C2FFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFDAD4C4FF1EA0
          F7FF0098FFFF2AA3F4FFDAD6C3B3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF2C797FFF2C797FFD57E24FFD57E24FFDA8A39FFE19A51FFDFD2
          BAFF25A2F5FF0098FFFF189EF9F31199F71EFFFFFF00FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF2C797FFF2C797FFE0994FFFE0994FFFE0994FFFE0994FFFE099
          4FFFDAC8ACFF1FA1F7FF51AAE1F1C3BCB1CF7B7BDC1DFFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
          85FFF6D3A9FFE4D8C1FFCAC3B3ED928FD3CB7373E683FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF6D3A9FFF6D3A9FFEDBB85FFEDBB85FFEDBB85FFEDBB85FFEDBB
          85FFF6D3A9FFFBDEBBFFE8CFBFB47373E4856666CC05FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
          4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00FBDE
          BAABFBDEBBFFF2C797FFF2C797FFE0984FFFE0984FFFE0984FFFE0984FFFE098
          4FFFF2C797FFFBDEBBFFFBDEBAABFFFFFF00FFFFFF00FFFFFF00FFFFFF00EFC6
          A6CEFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDEBBFFFBDE
          BBFFFBDEBBFFFBDEBBFFEFC6A6CEFFFFFF00FFFFFF00FFFFFF00FFFFFF00DB9E
          83D0E4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B092FFE4B0
          92FFE4B092FFE4B092FFDB9E83D0FFFFFF00FFFFFF00FFFFFF00FFFFFF00B651
          3FAAB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB5513FFFB551
          3FFFB5513FFFB5513FFFB6513FAAFFFFFF00FFFFFF00FFFFFF00FFFFFF00B351
          412FB4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B4513F55B451
          3F55B4513F55B4513F55B351412FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        TabOrder = 6
        OnClick = btnEditClick
      end
      object btnSave: TBitBtn
        Left = 216
        Top = 96
        Width = 89
        Height = 25
        Caption = 'Speichern'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFE4B268FFE5B36AFFE5B36AFFE5B36AFFE5B36AFFE5B36AFFE5B3
          6AFFE5B36AFFE5B36AFFE4B267FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFFFFFFFFFF7F6F4FFF3F2EFFFF3F2EFFFF3F2EFFFF3F2EFFFF3F2
          EFFFF3F2EFFFF7F6F4FFFFFFFFFFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFFFFFFFFFF7F6F4FFF3F2EFFFF3F2EFFFF3F2EFFFF3F2EFFFF3F2
          EFFFF3F2EFFFF7F6F4FFFFFFFFFFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFFFFFFFFFEFEEEAFFE8E5DFFFE8E5DFFFE8E5DFFFE8E5DFFFE8E5
          DFFFE8E5DFFFEFEEEAFFFFFFFFFFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFFFFFFFFFEFEEEAFFE8E5DFFFE8E5DFFFE8E5DFFFE8E5DFFFE8E5
          DFFFE8E5DFFFEFEEEAFFFFFFFFFFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFFEFBF8FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFEFBF8FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB98
          34FFDB9834FFDB9834FFDB9834FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB9834FFDB98
          34FFDB9834FFDB9834FFDB9834FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFBD822AFFB98029FFC4B7A1FFC5BEB0FFC5BEB0FFB5AEA1FF9690
          82FFC6BEAFFFD6A050FFDB9834FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFB98029FFB98029FFC5BEB0FFC5BEB0FFC5BEB0FF969082FF3832
          26FFC5BEB0FFD4A45EFFDB9834FFDB9834FFFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFB98029FFB98029FFC5BEB0FFC5BEB0FFC5BEB0FF969082FF3832
          26FFC5BEB0FFD4A45EFFDB9834FFDB9734C0FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00DB9834FFB98029FFB98029FFC5BEB0FFC5BEB0FFC5BEB0FFB5AEA1FF9690
          82FFC5BEB0FFD4A45EFFDB9734C0D1A22E0BFFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        TabOrder = 7
        OnClick = btnSaveClick
      end
      object btnDelete: TBitBtn
        Left = 545
        Top = 96
        Width = 75
        Height = 25
        Caption = 'L'#246'schen'
        Glyph.Data = {
          36040000424D3604000000000000360000002800000010000000100000000100
          20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00003DFF2E003CFF44003CFF44003CFF44003CFF44003C
          FF44003CFF44003DFF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003AFF30003DFFFE003DFFFF003DFFFF003DFFFF003DFFFF003D
          FFFF003DFFFF003DFFFE003DFF2EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
          FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF3D6BFEFF003DFFFF003DFFFF3D6B
          FEFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF3A69FEFFFAFAFAFF7696FDFF7797FDFFFAFA
          FAFF3968FEFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF86A2FCFFFAFAFAFFFAFAFAFF85A1
          FCFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF6E90FDFFFAFAFAFFF9F9FAFF6E90
          FDFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF3A69FEFFFAFAFAFF7696FDFF7797FDFFFAFA
          FAFF3968FEFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF3D6BFEFF003DFFFF003DFFFF3D6B
          FEFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
          FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00003CFF55003DFFFF003DFFFF003DFFFF003DFFFF003DFFFF003D
          FFFF003DFFFF003DFFFF003CFF55FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF003D6BFFB33666FFCA2C5EFFF92B5DFFFF2B5DFFFF2B5DFFFF2B5D
          FFFF2C5EFFF93666FFCA3D6BFFB3FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00416EFF92406EFFBB3B6AFFCC3061FFFC2F61FFFF2F61FFFF3062
          FFFB3B6AFFCA406EFFBB3F6FFF91FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF000040FF28003CFF55003CFF550040
          FF28FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
          FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
        TabOrder = 8
        OnClick = btnDeleteClick
      end
      object LabeledEdit6: TComboBox
        Left = 488
        Top = 16
        Width = 121
        Height = 21
        TabOrder = 3
        Items.Strings = (
          ''
          '$$date'
          '$$time'
          '$$user'
          'einstimmig'
          'einstimmig angenommen'
          'einstimmig abgelehnt'
          'zugestimmt'
          'abgelehnt')
      end
    end
    object LV: TListView
      AlignWithMargins = True
      Left = 5
      Top = 18
      Width = 625
      Height = 115
      Align = alClient
      Columns = <
        item
          Caption = 'Name'
          Width = 75
        end
        item
          Caption = #220'berschrift'
          Width = 150
        end
        item
          Caption = 'Datentyp'
          Width = 60
        end
        item
          Caption = 'Default'
        end
        item
          Caption = 'Reschreibung'
          Width = 250
        end>
      DragMode = dmAutomatic
      ReadOnly = True
      RowSelect = True
      SortType = stText
      TabOrder = 1
      ViewStyle = vsReport
      OnDblClick = LVDblClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 280
    Width = 635
    Height = 58
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 16
      Top = 27
      Width = 145
      Height = 25
      Caption = 'Testbaustein testen'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B67B4FB5B5795126FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFB97D52F4B77C51A0B17A4E17FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFEAB185FFC99063F7B87D50F1B57D
        4E68BF804004FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFF0B78BFFF0B78BFFE7AE82FFC68B
        5FF4B77D51E7B37B4F51FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFF0B78BFFF0B78BFFE7AE82FFC48A
        5EF4B97D51E4B67B4F4DFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFEEB488FFD2976BFAB87E52F3B67C
        4F7BAA805506FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B57A4EFFB97E52F6BA805394B680490EFFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00B67A4FAFB67C5023FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  inline EditFrame1: TEditFrame
    Left = 0
    Top = 113
    Width = 635
    Height = 167
    Align = alClient
    TabOrder = 4
    ExplicitTop = 113
    ExplicitWidth = 635
    ExplicitHeight = 167
    inherited RE: TRichEdit
      Width = 635
      Height = 133
      OnDragDrop = EditFrame1REDragDrop
      OnDragOver = EditFrame1REDragOver
      OnKeyPress = EditFrame1REKeyPress
      ExplicitWidth = 635
      ExplicitHeight = 133
    end
    inherited Panel1: TPanel
      Width = 635
      ExplicitWidth = 635
      inherited JvColorComboBox1: TJvColorComboBox
        Height = 20
        ExplicitHeight = 20
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TdsTextBlock'
    Left = 80
    Top = 112
  end
  object TBtab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'TBTab'
    RemoteServer = DSProviderConnection1
    BeforePost = TBtabBeforePost
    Left = 88
    Top = 168
  end
  object TBSrc: TDataSource
    DataSet = TBtab
    Left = 160
    Top = 168
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 304
    Top = 160
  end
end
