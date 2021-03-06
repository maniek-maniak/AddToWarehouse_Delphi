object FormAddToWarehouse: TFormAddToWarehouse
  Left = 63
  Top = 95
  BorderIcons = [biMinimize]
  BorderStyle = bsDialog
  Caption = 
    'Przyjmowanie materialu do magazynu                              ' +
    '                                                                ' +
    '                                                                ' +
    '                        autor programu Mariusz Kowalczyk'
  ClientHeight = 587
  ClientWidth = 1237
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object ListView: TListView
    Left = 368
    Top = 8
    Width = 873
    Height = 553
    Color = clBtnFace
    Columns = <
      item
        Caption = '#'
      end
      item
        Caption = 'Indeks'
        Width = 130
      end
      item
        Caption = 'Nazwa kr'#243'tka'
        Width = 200
      end
      item
        Caption = 'Nazwa pelna'
        Width = 400
      end
      item
        Caption = 'Ilosc'
      end
      item
        Caption = 'Jed.'
      end
      item
        Caption = 'Status'
        Width = 150
      end>
    GridLines = True
    ReadOnly = True
    RowSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = ListViewDblClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 345
    Height = 193
    Caption = 'Wyszukiwanie: '
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 16
      Width = 32
      Height = 13
      Caption = 'Indeks'
    end
    object Label2: TLabel
      Left = 8
      Top = 64
      Width = 66
      Height = 13
      Caption = 'Nazwa kr'#243'tka'
    end
    object Label3: TLabel
      Left = 8
      Top = 104
      Width = 62
      Height = 13
      Caption = 'Nazwa pelna'
    end
    object Label4: TLabel
      Left = 168
      Top = 16
      Width = 40
      Height = 13
      Caption = 'Nr zapo:'
    end
    object Label11: TLabel
      Left = 232
      Top = 16
      Width = 30
      Height = 13
      Caption = 'Status'
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
      Left = 8
      Top = 80
      Width = 329
      Height = 21
      Color = 12580802
      TabOrder = 1
    end
    object InputFullName: TEdit
      Left = 8
      Top = 120
      Width = 329
      Height = 21
      Color = 12580802
      TabOrder = 2
    end
    object InputOrderNumber: TEdit
      Left = 168
      Top = 32
      Width = 57
      Height = 21
      Color = 12580802
      TabOrder = 3
      OnKeyPress = InputOrderNumberKeyPress
    end
    object InputStatus: TEdit
      Left = 232
      Top = 32
      Width = 105
      Height = 21
      Color = 12580802
      TabOrder = 4
    end
    object btnConnect: TButton
      Left = 8
      Top = 152
      Width = 329
      Height = 33
      Caption = 'Wyszukaj'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = btnConnectClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 208
    Width = 345
    Height = 353
    Caption = 'Przymij do magazynu: '
    TabOrder = 2
    object Label5: TLabel
      Left = 8
      Top = 152
      Width = 43
      Height = 13
      Caption = 'Magazyn'
    end
    object Label6: TLabel
      Left = 216
      Top = 152
      Width = 43
      Height = 13
      Caption = 'Nr regalu'
    end
    object Label7: TLabel
      Left = 283
      Top = 152
      Width = 36
      Height = 13
      Caption = 'Nr p'#243'lki'
    end
    object Label8: TLabel
      Left = 11
      Top = 208
      Width = 22
      Height = 13
      Caption = 'Ilosc'
    end
    object Label9: TLabel
      Left = 123
      Top = 208
      Width = 103
      Height = 13
      Caption = 'Wartosc jednostkowa'
    end
    object Label10: TLabel
      Left = 235
      Top = 208
      Width = 40
      Height = 13
      Caption = 'Wartosc'
    end
    object Label12: TLabel
      Left = 8
      Top = 56
      Width = 66
      Height = 13
      Caption = 'Nazwa kr'#243'tka'
    end
    object Label13: TLabel
      Left = 8
      Top = 104
      Width = 62
      Height = 13
      Caption = 'Nazwa pelna'
    end
    object Label14: TLabel
      Left = 8
      Top = 16
      Width = 38
      Height = 13
      Caption = 'Indeks: '
    end
    object Label15: TLabel
      Left = 67
      Top = 208
      Width = 26
      Height = 13
      Caption = 'Jedn.'
    end
    object Label16: TLabel
      Left = 192
      Top = 16
      Width = 97
      Height = 13
      Caption = 'Dokument dostawy: '
      FocusControl = DB_status
    end
    object OutputWarehouse: TEdit
      Left = 8
      Top = 176
      Width = 201
      Height = 21
      Color = 12580802
      TabOrder = 0
      OnKeyUp = OutputWarehouseKeyUp
    end
    object OutputShelfNumber: TEdit
      Left = 280
      Top = 176
      Width = 57
      Height = 21
      Color = 12580802
      TabOrder = 1
      OnKeyUp = OutputShelfNumberKeyUp
    end
    object OutputRackNumber: TEdit
      Left = 216
      Top = 176
      Width = 57
      Height = 21
      Color = 12580802
      TabOrder = 2
      OnKeyUp = OutputRackNumberKeyUp
    end
    object OutputQuantity: TEdit
      Left = 8
      Top = 232
      Width = 49
      Height = 21
      Color = 12580802
      TabOrder = 3
      OnKeyPress = OutputQuantityKeyPress
      OnKeyUp = OutputQuantityKeyUp
    end
    object OutputUnitValue: TEdit
      Left = 120
      Top = 232
      Width = 105
      Height = 21
      Color = clScrollBar
      ReadOnly = True
      TabOrder = 4
    end
    object OutputValue: TEdit
      Left = 232
      Top = 232
      Width = 105
      Height = 21
      Color = 12580802
      TabOrder = 5
      OnKeyPress = OutputValueKeyPress
      OnKeyUp = OutputValueKeyUp
    end
    object OutputShortName: TEdit
      Left = 8
      Top = 72
      Width = 329
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 6
    end
    object OutputFullName: TEdit
      Left = 8
      Top = 120
      Width = 329
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 7
    end
    object btnConfirmDelivery: TButton
      Left = 8
      Top = 312
      Width = 329
      Height = 33
      Caption = 'Przyjmij'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 8
      OnClick = btnConfirmDeliveryClick
    end
    object OutputIndex: TEdit
      Left = 8
      Top = 32
      Width = 177
      Height = 21
      Color = cl3DLight
      TabOrder = 9
    end
    object OutputUnit: TEdit
      Left = 64
      Top = 232
      Width = 49
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 10
    end
    object RadioGroup1: TRadioGroup
      Left = 8
      Top = 264
      Width = 329
      Height = 41
      Caption = 'Opcje druku etykiety '
      TabOrder = 11
    end
    object RadioButtonOnePrint: TRadioButton
      Left = 104
      Top = 280
      Width = 73
      Height = 17
      Caption = 'Jedna szt.'
      TabOrder = 12
    end
    object RadioButtonAllPrint: TRadioButton
      Left = 192
      Top = 280
      Width = 73
      Height = 17
      Caption = 'Wszystkie'
      TabOrder = 13
    end
    object RadioButtonNoPrint: TRadioButton
      Left = 16
      Top = 280
      Width = 81
      Height = 17
      Caption = 'Bez etykiety'
      Checked = True
      TabOrder = 14
      TabStop = True
    end
    object ButtonPrint: TButton
      Left = 272
      Top = 280
      Width = 57
      Height = 17
      Caption = 'Wydruk'
      TabOrder = 15
    end
    object OutputDeliveryNote: TEdit
      Left = 192
      Top = 32
      Width = 145
      Height = 21
      Color = 12580802
      TabOrder = 16
      OnKeyUp = OutputDeliveryNoteKeyUp
    end
  end
  object DB_status: TStatusBar
    Left = 0
    Top = 568
    Width = 1237
    Height = 19
    Panels = <
      item
        Text = 'DB conection'
        Width = 100
      end
      item
        Width = 200
      end
      item
        Width = 200
      end
      item
        Text = 'Pobranych indeks'#243'w:'
        Width = 200
      end
      item
        Text = 'Pobranych pozycji zapotrzebowa'#324' zakupu:'
        Width = 50
      end>
  end
  object MySQL: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'dbexpmysql.dll'
    Params.Strings = (
      'DriverName=MySQL'
      'HostName=localhost'
      'Database=magazyny'
      'User_Name=root'
      'Password='
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000')
    VendorLib = 'libmysql.dll'
    AfterConnect = MySQLAfterConnect
    AfterDisconnect = MySQLAfterDisconnect
    Left = 408
    Top = 32
  end
  object SQL: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = MySQL
    Left = 440
    Top = 32
  end
  object TReadDB: TTimer
    Enabled = False
    Interval = 1
    OnTimer = TReadDBTimer
    Left = 376
    Top = 32
  end
  object MainMenu1: TMainMenu
    Left = 520
    Top = 168
    object Dostawy1: TMenuItem
      Caption = 'Dostawy'
    end
    object Rozchody1: TMenuItem
      Caption = 'Rozchody'
      object Wydajnazlecenie1: TMenuItem
        Caption = 'Wydaj na zlecenie'
        OnClick = Wydajnazlecenie1Click
      end
    end
  end
end
