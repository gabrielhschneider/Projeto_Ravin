object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'frmTesteBusca'
  ClientHeight = 281
  ClientWidth = 418
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object mmListaUsuarios: TMemo
    Left = 40
    Top = 8
    Width = 329
    Height = 153
    TabOrder = 0
  end
  object btnTestar: TButton
    Left = 168
    Top = 184
    Width = 75
    Height = 25
    Caption = 'Testar'
    TabOrder = 1
    OnClick = btnTestarClick
  end
end
