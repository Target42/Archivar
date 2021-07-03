object BeschlussFrame: TBeschlussFrame
  Left = 0
  Top = 0
  Width = 960
  Height = 468
  Align = alClient
  TabOrder = 0
  ExplicitWidth = 451
  ExplicitHeight = 305
  object Splitter1: TSplitter
    Left = 703
    Top = 0
    Height = 385
    Align = alRight
    ExplicitLeft = 344
    ExplicitTop = 64
    ExplicitHeight = 100
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 385
    Width = 960
    Height = 83
    Align = alBottom
    Caption = 'Abstimmung'
    TabOrder = 0
    ExplicitTop = 222
    ExplicitWidth = 451
    object Button1: TBitBtn
      Left = 9
      Top = 24
      Width = 91
      Height = 41
      Caption = 'Zustimmung Einstimmig'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF008080800247A0437E4A9F4018FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF0000FF000146A0439147A043FF47A044CC4BA53C11FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0055AA5503489F43A047A043F8489F426047A043D647A043D64A9F4018FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0000FF
        0001469F439547A043FA48A14251FFFFFF00489F402047A043DF47A044CC4BA5
        3C11FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF0047A1
        423647A043F3489F414AFFFFFF00FFFFFF00FFFFFF004A9F401847A043D647A0
        43D64A9F4018FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF0046A24616FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF004A9F401847A0
        43D647A043D64A9F4018FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00489F
        402047A043DF47A044CC4BA53C11FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00489F402047A043DF47A044CC4BA53C11FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00489F402047A043DF47A044CC4BA53C11FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF004A9F401847A043B7489F4020FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentDoubleBuffered = True
      TabOrder = 0
      WordWrap = True
      OnClick = Button1Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 120
      Top = 40
      Width = 50
      Height = 21
      EditLabel.Width = 57
      EditLabel.Height = 13
      EditLabel.Caption = 'Zustimmung'
      NumbersOnly = True
      TabOrder = 1
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit2: TLabeledEdit
      Left = 191
      Top = 40
      Width = 50
      Height = 21
      EditLabel.Width = 51
      EditLabel.Height = 13
      EditLabel.Caption = 'Ablehnung'
      NumbersOnly = True
      TabOrder = 2
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit3: TLabeledEdit
      Left = 255
      Top = 40
      Width = 50
      Height = 21
      EditLabel.Width = 60
      EditLabel.Height = 13
      EditLabel.Caption = 'Enhaltungen'
      NumbersOnly = True
      TabOrder = 3
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object Button2: TBitBtn
      Left = 327
      Top = 24
      Width = 90
      Height = 41
      Caption = 'Ablehnung Einstimmig'
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        20000000000000040000C40E0000C40E00000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF001746D62C1443D7731543D99F1543D99F1443
        D7731841D52BFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF001540D50C1543D9A01543D8FE1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FE1544D89E1540D50CFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00143BD80D1543D8CF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8CD1540D50CFFFFFF00FFFFFF00FFFFFF00FFFF
        FF001543D7A11543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D89DFFFFFF00FFFFFF00FFFFFF001346
        D9281543D8FD1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D8FD1443D726FFFFFF00FFFFFF001542
        D87B1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D8FF1544D978FFFFFF00FFFFFF001543
        D99F1543D8FF1543D8FF6382E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF6382E5FF1543D8FF1543D8FF1544D89EFFFFFF00FFFFFF001543
        D99F1543D8FF1543D8FF6382E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF6382E5FF1543D8FF1543D8FF1544D89EFFFFFF00FFFFFF001542
        D87B1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D8FF1544D978FFFFFF00FFFFFF001346
        D9281543D8FD1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D8FD1443D726FFFFFF00FFFFFF00FFFF
        FF001543D7A11543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D8FF1543D89DFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00143BD80D1543D8D01543D8FF1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FF1543D8FF1543D7CE1540D50CFFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF001040DF101542D9AD1543D8FF1543D8FF1543D8FF1543D8FF1543
        D8FF1543D8FE1544D8AA1144DD0FFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF001641D92F1643D8821643D8A41643D8A41643
        D7811643D82EFFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentDoubleBuffered = True
      TabOrder = 4
      WordWrap = True
      OnClick = Button2Click
    end
    object LabeledEdit4: TLabeledEdit
      Left = 477
      Top = 40
      Width = 33
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Anwesend'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 5
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit5: TLabeledEdit
      Left = 536
      Top = 40
      Width = 34
      Height = 21
      EditLabel.Width = 50
      EditLabel.Height = 13
      EditLabel.Caption = 'Abwesend'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 6
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit6: TLabeledEdit
      Left = 600
      Top = 40
      Width = 34
      Height = 21
      EditLabel.Width = 75
      EditLabel.Height = 13
      EditLabel.Caption = 'Nicht Abgestimt'
      NumbersOnly = True
      ReadOnly = True
      TabOrder = 7
      OnExit = LabeledEdit1Exit
      OnKeyPress = LabeledEdit1KeyPress
    end
    object BitBtn1: TBitBtn
      Left = 704
      Top = 24
      Width = 75
      Height = 41
      Caption = 'Teilnehmer'
      TabOrder = 8
      OnClick = BitBtn1Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 703
    Height = 385
    Align = alClient
    Caption = 'Text'
    TabOrder = 1
    ExplicitWidth = 194
    ExplicitHeight = 222
    object Splitter2: TSplitter
      Left = 2
      Top = 301
      Width = 699
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 15
      ExplicitWidth = 153
    end
    inline EditFrame1: TEditFrame
      Left = 2
      Top = 15
      Width = 699
      Height = 286
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 190
      ExplicitHeight = 123
      inherited RE: TRichEdit
        Width = 699
        Height = 286
        PopupMenu = PopupMenu1
        OnDragDrop = EditFrame1REDragDrop
        OnDragOver = EditFrame1REDragOver
        ExplicitWidth = 190
        ExplicitHeight = 123
      end
    end
    object Groupbox4: TGroupBox
      Left = 2
      Top = 304
      Width = 699
      Height = 79
      Align = alBottom
      Caption = 'Nicht mit Abgestimmt'
      TabOrder = 1
      TabStop = True
      Visible = False
      object Memo1: TMemo
        Left = 2
        Top = 15
        Width = 695
        Height = 62
        Align = alClient
        Lines.Strings = (
          'Memo1')
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 706
    Top = 0
    Width = 254
    Height = 385
    Align = alRight
    Caption = 'Textbausteine'
    TabOrder = 2
    Visible = False
    ExplicitLeft = 197
    ExplicitHeight = 222
    inline TextBlockFrame1: TTextBlockFrame
      Left = 2
      Top = 15
      Width = 250
      Height = 368
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 15
      ExplicitWidth = 250
      ExplicitHeight = 205
      inherited Panel1: TPanel
        Top = 312
        Width = 250
        ExplicitTop = 149
        ExplicitWidth = 250
        inherited LabeledEdit1: TLabeledEdit
          Width = 232
          EditLabel.ExplicitLeft = 8
          EditLabel.ExplicitTop = 8
          EditLabel.ExplicitWidth = 46
          ExplicitWidth = 232
        end
      end
      inherited LV: TListView
        Width = 250
        Height = 312
        ExplicitWidth = 250
        ExplicitHeight = 149
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 208
    Top = 16
    object extbausteine1: TMenuItem
      Caption = 'Textbausteine'
      OnClick = extbausteine1Click
    end
  end
end
