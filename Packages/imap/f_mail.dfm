object MailForm: TMailForm
  Left = 0
  Top = 0
  Caption = 'Mail (pop3/smtp)'
  ClientHeight = 418
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 417
    Top = 0
    Height = 399
    ExplicitLeft = 576
    ExplicitTop = 64
    ExplicitHeight = 100
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 417
    Height = 399
    Align = alLeft
    Caption = 'Mails'
    TabOrder = 0
    object VST: TVirtualStringTree
      Left = 2
      Top = 56
      Width = 413
      Height = 341
      Align = alClient
      Colors.BorderColor = 15987699
      Colors.DisabledColor = clGray
      Colors.DropMarkColor = 15385233
      Colors.DropTargetColor = 15385233
      Colors.DropTargetBorderColor = 15385233
      Colors.FocusedSelectionColor = 15385233
      Colors.FocusedSelectionBorderColor = 15385233
      Colors.GridLineColor = 15987699
      Colors.HeaderHotColor = clBlack
      Colors.HotColor = clBlack
      Colors.SelectionRectangleBlendColor = 15385233
      Colors.SelectionRectangleBorderColor = 15385233
      Colors.SelectionTextColor = clBlack
      Colors.TreeLineColor = 9471874
      Colors.UnfocusedColor = clGray
      Colors.UnfocusedSelectionColor = clWhite
      Colors.UnfocusedSelectionBorderColor = clWhite
      Header.AutoSizeIndex = -1
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      LineStyle = lsSolid
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight, toEditOnClick]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnDblClick = VSTDblClick
      OnDrawText = VSTDrawText
      OnGetText = VSTGetText
      OnPaintText = VSTPaintText
      OnInitNode = VSTInitNode
      Touch.InteractiveGestures = [igPan, igPressAndTap]
      Touch.InteractiveGestureOptions = [igoPanSingleFingerHorizontal, igoPanSingleFingerVertical, igoPanInertia, igoPanGutter, igoParentPassthrough]
      Columns = <>
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 413
      Height = 41
      Align = alTop
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        413
        41)
      object ComboBox1: TComboBox
        Left = 8
        Top = 11
        Width = 393
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 0
        Text = 'ComboBox1'
        OnChange = ComboBox1Change
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 399
    Width = 1020
    Height = 19
    Panels = <>
    ExplicitTop = 398
    ExplicitWidth = 1016
  end
  object GroupBox2: TGroupBox
    Left = 420
    Top = 0
    Width = 600
    Height = 399
    Align = alClient
    Caption = 'Mail'
    TabOrder = 2
    object Splitter2: TSplitter
      Left = 2
      Top = 297
      Width = 596
      Height = 3
      Cursor = crVSplit
      Align = alBottom
      ExplicitTop = 15
      ExplicitWidth = 285
    end
    object WebBrowser1: TWebBrowser
      Left = 2
      Top = 15
      Width = 596
      Height = 282
      Align = alClient
      TabOrder = 0
      ExplicitWidth = 592
      ExplicitHeight = 281
      ControlData = {
        4C000000993D0000251D00000000000000000000000000000000000000000000
        000000004C000000000000000000000001000000E0D057007335CF11AE690800
        2B2E126208000000000000004C0000000114020000000000C000000000000046
        8000000000000000000000000000000000000000000000000000000000000000
        00000000000000000100000000000000000000000000000000000000}
    end
    object LB: TListBox
      Left = 2
      Top = 300
      Width = 596
      Height = 97
      Align = alBottom
      Columns = 2
      ItemHeight = 13
      TabOrder = 1
      Visible = False
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 50
    OnTimer = Timer1Timer
    Left = 96
    Top = 152
  end
end
