object TitelEditform: TTitelEditform
  Left = 0
  Top = 0
  ActiveControl = Edit1
  BorderStyle = bsDialog
  Caption = 'Titel'
  ClientHeight = 80
  ClientWidth = 248
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Edit1: TEdit
    Left = 8
    Top = 8
    Width = 232
    Height = 21
    TabOrder = 0
    Text = 'Edit1'
  end
  object Button1: TButton
    Left = 84
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Abbruch'
    ModalResult = 2
    TabOrder = 1
  end
  object Button2: TButton
    Left = 165
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Ok'
    Default = True
    ModalResult = 1
    TabOrder = 2
  end
end
