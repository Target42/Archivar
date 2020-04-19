object TaksEditorForm: TTaksEditorForm
  Left = 0
  Top = 0
  Caption = 'Aufgabeneditor'
  ClientHeight = 499
  ClientWidth = 802
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  WindowState = wsMaximized
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object StatusBar1: TStatusBar
    Left = 0
    Top = 480
    Width = 802
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 802
    Height = 480
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Allgemeines'
      ExplicitWidth = 296
      ExplicitHeight = 154
      object Splitter1: TSplitter
        Left = 0
        Top = 299
        Width = 794
        Height = 3
        Cursor = crVSplit
        Align = alBottom
        ExplicitTop = 169
        ExplicitWidth = 156
      end
      object GroupBox1: TGroupBox
        Left = 0
        Top = 0
        Width = 794
        Height = 299
        Align = alClient
        Caption = 'Datenfelder'
        TabOrder = 0
        object LV: TListView
          Left = 2
          Top = 15
          Width = 790
          Height = 241
          Align = alClient
          Columns = <
            item
              Caption = 'Name'
              Width = 100
            end
            item
              Caption = 'Typ'
              Width = 70
            end
            item
              Caption = 'Erforderlich'
              Width = 70
            end
            item
              Caption = 'Tabelle'
            end
            item
              Caption = 'Beschreibung'
              Width = 150
            end>
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
        end
        object Panel1: TPanel
          Left = 2
          Top = 256
          Width = 790
          Height = 41
          Align = alBottom
          BevelOuter = bvNone
          Caption = 'Panel1'
          ShowCaption = False
          TabOrder = 1
          object SpeedButton1: TSpeedButton
            Left = 584
            Top = 6
            Width = 23
            Height = 22
          end
          object BitBtn1: TBitBtn
            Left = 8
            Top = 6
            Width = 97
            Height = 25
            Caption = 'Neues Datenfeld'
            TabOrder = 0
            OnClick = BitBtn1Click
          end
          object BitBtn2: TBitBtn
            Left = 127
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Neue Tabelle'
            TabOrder = 1
            OnClick = BitBtn2Click
          end
          object BitBtn3: TBitBtn
            Left = 216
            Top = 6
            Width = 75
            Height = 25
            Caption = 'Bearbeiten'
            TabOrder = 2
            OnClick = BitBtn3Click
          end
          object BitBtn4: TBitBtn
            Left = 312
            Top = 6
            Width = 75
            Height = 25
            Caption = 'L'#246'schen'
            TabOrder = 3
            OnClick = BitBtn4Click
          end
          object BitBtn5: TBitBtn
            Left = 408
            Top = 6
            Width = 113
            Height = 25
            Caption = 'Globales Datenfeld'
            TabOrder = 4
          end
        end
      end
      object GroupBox2: TGroupBox
        Left = 0
        Top = 302
        Width = 794
        Height = 150
        Align = alBottom
        Caption = 'Beschreibung'
        TabOrder = 1
        ExplicitTop = 4
        ExplicitWidth = 296
        inline EditFrame1: TEditFrame
          Left = 2
          Top = 15
          Width = 790
          Height = 133
          Align = alClient
          TabOrder = 0
          ExplicitLeft = 2
          ExplicitTop = 15
          ExplicitWidth = 292
          ExplicitHeight = 133
          inherited RE: TRichEdit
            Width = 790
            Height = 133
            ExplicitWidth = 790
            ExplicitHeight = 133
          end
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
      inline EditorFrame1: TEditorFrame
        Left = 0
        Top = 0
        Width = 794
        Height = 452
        Align = alClient
        TabOrder = 0
        ExplicitWidth = 794
        ExplicitHeight = 452
        inherited Splitter2: TSplitter
          Height = 452
          ExplicitHeight = 452
        end
        inherited Splitter3: TSplitter
          Left = 606
          Height = 452
          ExplicitLeft = 606
          ExplicitHeight = 452
        end
        inherited GroupBox2: TGroupBox
          Height = 452
          ExplicitHeight = 452
          inherited TV: TTreeView
            Height = 435
            ExplicitHeight = 435
          end
        end
        inherited Panel1: TPanel
          Left = 609
          Height = 452
          ExplicitLeft = 609
          ExplicitHeight = 452
          inherited Splitter1: TSplitter
            Height = 205
            ExplicitHeight = 121
          end
          inherited PropertyFrame1: TPropertyFrame
            Height = 205
            ExplicitHeight = 205
            inherited VE: TValueListEditor
              Height = 124
              ExplicitHeight = 124
            end
          end
        end
        inherited EditPanel: TPanel
          Width = 418
          Height = 452
          ExplicitLeft = 188
          ExplicitTop = 0
          ExplicitWidth = 418
          ExplicitHeight = 452
        end
      end
    end
  end
end
