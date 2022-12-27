object MailForm: TMailForm
  Left = 0
  Top = 0
  Caption = 'MailForm'
  ClientHeight = 418
  ClientWidth = 1020
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 497
    Top = 0
    Height = 399
    ExplicitLeft = 576
    ExplicitTop = 64
    ExplicitHeight = 100
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 497
    Height = 399
    Align = alLeft
    Caption = 'GroupBox1'
    TabOrder = 0
    object VST: TVirtualStringTree
      Left = 2
      Top = 56
      Width = 493
      Height = 341
      Align = alClient
      Header.AutoSizeIndex = -1
      Header.MainColumn = -1
      Header.Options = [hoColumnResize, hoDrag, hoShowSortGlyphs, hoVisible]
      LineStyle = lsSolid
      TabOrder = 0
      TreeOptions.MiscOptions = [toAcceptOLEDrop, toFullRepaintOnResize, toInitOnSave, toToggleOnDblClick, toWheelPanning, toVariableNodeHeight, toEditOnClick]
      TreeOptions.SelectionOptions = [toFullRowSelect]
      OnDrawText = VSTDrawText
      OnGetText = VSTGetText
      OnPaintText = VSTPaintText
      OnInitNode = VSTInitNode
      ExplicitLeft = -2
      ExplicitTop = 55
      Columns = <>
    end
    object Panel1: TPanel
      Left = 2
      Top = 15
      Width = 493
      Height = 41
      Align = alTop
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      DesignSize = (
        493
        41)
      object ComboBox1: TComboBox
        Left = 8
        Top = 11
        Width = 473
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
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 200
    OnTimer = Timer1Timer
    Left = 96
    Top = 152
  end
end
