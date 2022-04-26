object Form1: TForm1
  Left = 296
  Top = 210
  Width = 816
  Height = 638
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 600
    Height = 600
    OnMouseDown = Image1MouseDown
  end
  object Label1: TLabel
    Left = 624
    Top = 256
    Width = 32
    Height = 13
    Caption = 'Label1'
  end
  object Label2: TLabel
    Left = 624
    Top = 280
    Width = 81
    Height = 17
    Caption = 'Label2'
  end
  object EditX: TEdit
    Left = 632
    Top = 8
    Width = 57
    Height = 21
    TabOrder = 0
    Text = '300'
  end
  object EditY: TEdit
    Left = 704
    Top = 8
    Width = 57
    Height = 21
    TabOrder = 1
    Text = '300'
  end
  object EditR: TEdit
    Left = 632
    Top = 40
    Width = 129
    Height = 21
    TabOrder = 2
    Text = '200'
  end
  object Button1: TButton
    Left = 632
    Top = 72
    Width = 129
    Height = 25
    Caption = 'Brezenhem'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 632
    Top = 112
    Width = 129
    Height = 25
    Caption = 'MyAlhorithm'
    TabOrder = 4
    OnClick = Button2Click
  end
  object ColorCombo: TComboBox
    Left = 622
    Top = 224
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = 'Red'
    Items.Strings = (
      'Black'
      'Maroon'
      'Green'
      'Olive'
      'Navy'
      'Purple'
      'Teal'
      'Gray'
      'Silver'
      'Red'
      'Lime'
      'Yellow'
      'Blue'
      'Fuchsia'
      'Aqua')
  end
  object Button3: TButton
    Left = 632
    Top = 144
    Width = 129
    Height = 25
    Caption = 'MyAlhorithmInt'
    TabOrder = 6
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 632
    Top = 176
    Width = 129
    Height = 25
    Caption = 'MyAlhorithmBrezenhem'
    TabOrder = 7
    OnClick = Button4Click
  end
  object cbb1: TComboBox
    Left = 624
    Top = 312
    Width = 145
    Height = 21
    ItemHeight = 13
    ItemIndex = 2
    TabOrder = 8
    Text = 'TriangleBuild'
    Items.Strings = (
      'RecurseFilling'
      'MyLineFilling'
      'TriangleBuild'
      'PointInTriangle')
  end
  object ButtonNet: TButton
    Left = 624
    Top = 392
    Width = 145
    Height = 33
    Caption = 'Net'
    TabOrder = 9
    OnClick = ButtonNetClick
  end
  object ButtonClear: TButton
    Left = 624
    Top = 344
    Width = 145
    Height = 33
    Caption = 'ButtonClear'
    TabOrder = 10
    OnClick = ButtonClearClick
  end
end
