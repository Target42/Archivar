object STatusForm: TSTatusForm
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Import'
  ClientHeight = 127
  ClientWidth = 630
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poMainFormCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 16
    Width = 24
    Height = 15
    Caption = 'Pfad'
  end
  object PathLab: TLabel
    Left = 56
    Top = 16
    Width = 537
    Height = 15
    AutoSize = False
    Caption = '.'
    EllipsisPosition = epPathEllipsis
  end
  object Label3: TLabel
    Left = 8
    Top = 37
    Width = 27
    Height = 15
    Caption = 'Datei'
  end
  object fileLab: TLabel
    Left = 56
    Top = 37
    Width = 537
    Height = 15
    AutoSize = False
    Caption = '.'
  end
  object ProgressBar1: TProgressBar
    Left = 56
    Top = 72
    Width = 537
    Height = 17
    TabOrder = 0
  end
end
