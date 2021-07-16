object FormAddToWarehouse: TFormAddToWarehouse
  Left = 202
  Top = 116
  Width = 1039
  Height = 532
  Caption = 'Przyjmowanie pozycji do magazynu'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object btnConnect: TButton
    Left = 8
    Top = 168
    Width = 233
    Height = 33
    Caption = 'Wyszukaj'
    TabOrder = 0
    OnClick = btnConnectClick
  end
  object ListView: TListView
    Left = 248
    Top = 16
    Width = 777
    Height = 481
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
    TabOrder = 1
    ViewStyle = vsReport
  end
  object btnConfirmDelivery: TButton
    Left = 8
    Top = 464
    Width = 233
    Height = 33
    Caption = 'Przyjmij'
    Enabled = False
    TabOrder = 2
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 16
    Width = 233
    Height = 145
    Caption = 'Wyszukiwanie: '
    TabOrder = 3
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 32
      Height = 13
      Caption = 'Indeks'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 66
      Height = 13
      Caption = 'Nazwa kr'#243'tka'
    end
    object Label3: TLabel
      Left = 8
      Top = 72
      Width = 62
      Height = 13
      Caption = 'Nazwa pelna'
    end
    object Label4: TLabel
      Left = 8
      Top = 96
      Width = 94
      Height = 13
      Caption = 'Nr zapotrzebowania'
    end
    object Label11: TLabel
      Left = 8
      Top = 120
      Width = 30
      Height = 13
      Caption = 'Status'
    end
    object InputIndex: TEdit
      Left = 120
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
    end
    object InputShortName: TEdit
      Left = 120
      Top = 40
      Width = 105
      Height = 21
      TabOrder = 1
    end
    object InputFullName: TEdit
      Left = 120
      Top = 64
      Width = 105
      Height = 21
      TabOrder = 2
    end
    object InputOrderNumber: TEdit
      Left = 120
      Top = 88
      Width = 105
      Height = 21
      TabOrder = 3
    end
    object InputStatus: TEdit
      Left = 120
      Top = 112
      Width = 105
      Height = 21
      TabOrder = 4
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 288
    Width = 233
    Height = 169
    Caption = 'Przymij do magazynu: '
    TabOrder = 4
    object Label5: TLabel
      Left = 8
      Top = 24
      Width = 43
      Height = 13
      Caption = 'Magazyn'
    end
    object Label6: TLabel
      Left = 8
      Top = 48
      Width = 43
      Height = 13
      Caption = 'Nr regalu'
    end
    object Label7: TLabel
      Left = 11
      Top = 72
      Width = 36
      Height = 13
      Caption = 'Nr p'#243'lki'
    end
    object Label8: TLabel
      Left = 11
      Top = 96
      Width = 22
      Height = 13
      Caption = 'Ilosc'
    end
    object Label9: TLabel
      Left = 11
      Top = 120
      Width = 103
      Height = 13
      Caption = 'Wartosc jednostkowa'
    end
    object Label10: TLabel
      Left = 11
      Top = 144
      Width = 40
      Height = 13
      Caption = 'Wartosc'
    end
    object Edit5: TEdit
      Left = 120
      Top = 16
      Width = 105
      Height = 21
      TabOrder = 0
    end
    object Edit6: TEdit
      Left = 120
      Top = 40
      Width = 105
      Height = 21
      TabOrder = 1
    end
    object Edit7: TEdit
      Left = 120
      Top = 64
      Width = 105
      Height = 21
      TabOrder = 2
    end
    object Edit8: TEdit
      Left = 120
      Top = 88
      Width = 105
      Height = 21
      TabOrder = 3
    end
    object Edit9: TEdit
      Left = 120
      Top = 112
      Width = 105
      Height = 21
      TabOrder = 4
    end
    object Edit10: TEdit
      Left = 120
      Top = 136
      Width = 105
      Height = 21
      TabOrder = 5
    end
  end
  object MySQL: TSQLConnection
    ConnectionName = 'MySQLConnection'
    DriverName = 'MySQL'
    GetDriverFunc = 'getSQLDriverMYSQL'
    LibraryName = 'libmySQL.dll'
    LoadParamsOnConnect = True
    Params.Strings = (
      'DriverName=MySQL'
      'HostName=127.0.0.1'
      'Database=magazyn'
      'BlobSize=-1'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'username=root'
      'password=')
    VendorLib = 'libmySQL.dll'
    AfterConnect = MySQLAfterConnect
    AfterDisconnect = MySQLAfterDisconnect
    Left = 256
    Top = 40
  end
  object SQL: TSQLDataSet
    MaxBlobSize = -1
    Params = <>
    SQLConnection = MySQL
    Left = 256
    Top = 72
  end
end
