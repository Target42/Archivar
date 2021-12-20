object StorageForm: TStorageForm
  Left = 0
  Top = 0
  Caption = 'Datenablage'
  ClientHeight = 346
  ClientWidth = 783
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Visible = True
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  inline FileFrame1: TFileFrame
    Left = 0
    Top = 0
    Width = 783
    Height = 346
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 757
    ExplicitHeight = 299
    inherited Splitter1: TSplitter
      Height = 346
      ExplicitHeight = 299
    end
    inherited GroupBox2: TGroupBox
      Height = 346
      ExplicitHeight = 299
      inherited GroupBox4: TGroupBox
        Top = 287
        ExplicitTop = 240
      end
      inherited VST: TVirtualStringTree
        Height = 272
        ExplicitHeight = 225
      end
    end
    inherited GroupBox3: TGroupBox
      Width = 531
      Height = 346
      ExplicitWidth = 505
      ExplicitHeight = 299
      inherited GroupBox1: TGroupBox
        Top = 287
        Width = 527
        ExplicitTop = 240
        ExplicitWidth = 501
      end
      inherited DBGrid1: TDBGrid
        Width = 527
        Height = 272
      end
    end
    inherited JvDragDrop1: TJvDragDrop
      DropTarget = FileFrame1
    end
  end
end
