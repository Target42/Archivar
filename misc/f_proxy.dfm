object ProxyForm: TProxyForm
  Left = 0
  Top = 0
  Caption = 'Proxyeinstellungen'
  ClientHeight = 267
  ClientWidth = 286
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 192
    Top = 8
    Width = 48
    Height = 13
    Caption = 'Proxyport'
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 169
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Proxy'
    TabOrder = 0
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 64
    Width = 121
    Height = 21
    EditLabel.Width = 22
    EditLabel.Height = 13
    EditLabel.Caption = 'User'
    TabOrder = 2
  end
  object LabeledEdit3: TLabeledEdit
    Left = 143
    Top = 64
    Width = 122
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = 'Passwort'
    PasswordChar = '*'
    TabOrder = 3
  end
  object BitBtn1: TBitBtn
    Left = 16
    Top = 152
    Width = 75
    Height = 25
    Caption = 'Test'
    TabOrder = 5
    OnClick = BitBtn1Click
  end
  object LabeledEdit4: TLabeledEdit
    Left = 16
    Top = 104
    Width = 249
    Height = 21
    EditLabel.Width = 19
    EditLabel.Height = 13
    EditLabel.Caption = 'URL'
    TabOrder = 4
    Text = 'http://www.google.de'
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 207
    Width = 286
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 6
    ExplicitTop = 207
    ExplicitWidth = 286
    inherited StatusBar1: TStatusBar
      Width = 286
      ExplicitWidth = 286
    end
    inherited Panel1: TPanel
      Width = 286
      ExplicitWidth = 286
      inherited OKBtn: TBitBtn
        Left = 187
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 187
      end
    end
  end
  object SpinEdit1: TSpinEdit
    Left = 191
    Top = 24
    Width = 74
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 8080
  end
  object IdHTTP1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = True
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 112
    Top = 144
  end
end
