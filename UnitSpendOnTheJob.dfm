object FormSpendOnTheJob: TFormSpendOnTheJob
  Left = 251
  Top = 126
  Width = 817
  Height = 551
  Caption = 
    'Wydawanie towar'#243'w                                               ' +
    '                                                                ' +
    '                            autor programu Mariusz Kowalczyk'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 793
    Height = 105
    Caption = 'Wyszukiwanie: '
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Indeks'
    end
    object Label2: TLabel
      Left = 168
      Top = 16
      Width = 66
      Height = 13
      Caption = 'Nazwa kr'#243'tka'
    end
    object Label3: TLabel
      Left = 480
      Top = 16
      Width = 62
      Height = 13
      Caption = 'Nazwa pelna'
    end
    object InputIndex: TEdit
      Left = 8
      Top = 32
      Width = 153
      Height = 21
      Color = 12580802
      TabOrder = 0
    end
    object InputShortName: TEdit
      Left = 168
      Top = 32
      Width = 305
      Height = 21
      Color = 12580802
      TabOrder = 1
    end
    object InputFullName: TEdit
      Left = 480
      Top = 32
      Width = 305
      Height = 21
      Color = 12580802
      TabOrder = 2
    end
    object btnConnect: TButton
      Left = 696
      Top = 64
      Width = 89
      Height = 33
      Caption = 'Wyszukaj'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
  end
  object ListView: TListView
    Left = 4
    Top = 120
    Width = 797
    Height = 257
    Color = clBtnFace
    Columns = <
      item
        Caption = '#'
        Width = 40
      end
      item
        Caption = 'Indeks'
        Width = 130
      end
      item
        Caption = 'Nazwa kr'#243'tka'
        Width = 150
      end
      item
        Caption = 'Nazwa pelna'
        Width = 400
      end
      item
        Caption = 'Ilosc'
        Width = 70
      end
      item
        Caption = 'Jed.'
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 384
    Width = 793
    Height = 113
    Caption = 'Wydawanie: '
    TabOrder = 2
    object Label4: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Indeks'
    end
    object Label5: TLabel
      Left = 168
      Top = 16
      Width = 66
      Height = 13
      Caption = 'Nazwa kr'#243'tka'
    end
    object Label6: TLabel
      Left = 480
      Top = 16
      Width = 62
      Height = 13
      Caption = 'Nazwa pelna'
    end
    object Label7: TLabel
      Left = 632
      Top = 64
      Width = 22
      Height = 13
      Caption = 'Ilosc'
    end
    object Edit1: TEdit
      Left = 8
      Top = 32
      Width = 153
      Height = 21
      Color = cl3DLight
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 168
      Top = 32
      Width = 305
      Height = 21
      Color = cl3DLight
      TabOrder = 1
    end
    object Edit3: TEdit
      Left = 480
      Top = 32
      Width = 305
      Height = 21
      Color = cl3DLight
      TabOrder = 2
    end
    object Button1: TButton
      Left = 696
      Top = 72
      Width = 89
      Height = 33
      Caption = 'Wydaj'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object ComboBox2: TComboBox
      Left = 8
      Top = 80
      Width = 617
      Height = 21
      Color = 12580802
      ItemHeight = 13
      TabOrder = 4
      Text = 'zx'
    end
    object InputOrderNumber: TEdit
      Left = 632
      Top = 80
      Width = 49
      Height = 21
      Color = 12580802
      TabOrder = 5
    end
  end
  object MainMenu1: TMainMenu
    Left = 392
    Top = 152
    object Wydawanienazlecenia1: TMenuItem
      Caption = 'Przyjmowanie do magazynu'
      object Przyjmijzzamwienia1: TMenuItem
        Caption = 'Przyjmij z zam'#243'wienia'
      end
    end
    object Wydawanienazlecenia2: TMenuItem
      Caption = 'Wydawanie na zlecenia'
      object Wydajnazlecenie1: TMenuItem
        Caption = 'Wydaj na zlecenie'
      end
      object Wydajnaobszar1: TMenuItem
        Caption = 'Wydaj na obszar'
      end
    end
    object Wydawanienastan1: TMenuItem
      Caption = 'Wydawanie na stan'
      object UtwrzKPM1: TMenuItem
        Caption = 'Utw'#243'rz KPM'
      end
      object WydajnaKPM1: TMenuItem
        Caption = 'Wydaj na KPM'
      end
    end
  end
end
