object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 207
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 31
    Height = 13
    Caption = 'Status'
  end
  object lbStatus: TLabel
    Left = 45
    Top = 24
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object Label2: TLabel
    Left = 8
    Top = 80
    Width = 36
    Height = 13
    Caption = 'interval'
  end
  object Label3: TLabel
    Left = 8
    Top = 48
    Width = 46
    Height = 13
    Caption = 'broodwar'
  end
  object lbFound: TLabel
    Left = 61
    Top = 48
    Width = 16
    Height = 13
    Caption = 'n/a'
  end
  object edInterval: TEdit
    Left = 64
    Top = 77
    Width = 73
    Height = 21
    TabOrder = 0
    Text = '13000'
  end
end
