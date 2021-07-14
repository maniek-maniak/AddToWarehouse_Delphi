unit UnitAddToWarehouse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, ComCtrls;

type
  TFormAddToWarehouse = class(TForm)
    btnConnect: TButton;
    ListView: TListView;
    btnConfirmDelivery: TButton;
    MySQL: TSQLConnection;
    SQL: TSQLDataSet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    procedure btnConnectClick(Sender: TObject);
    procedure MySQLAfterConnect(Sender: TObject);
    procedure MySQLAfterDisconnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    Connected : Boolean;
    procedure LoadTable;
  public
    { Public declarations }
  end;

var
  FormAddToWarehouse: TFormAddToWarehouse;

implementation

{$R *.dfm}

procedure TFormAddToWarehouse.btnConnectClick(Sender: TObject);
begin
  if Connected then Connected := False else Connected := True;
  MySQL.Connected := Connected;
end;

procedure TFormAddToWarehouse.MySQLAfterConnect(Sender: TObject);
begin
  btnConnect.Caption := 'Roz��cz';
  btnConfirmDelivery.Enabled := True;
  LoadTable;
end;

procedure TFormAddToWarehouse.MySQLAfterDisconnect(Sender: TObject);
begin
  btnConnect.Caption := 'Po��cz';
  btnConfirmDelivery.Enabled := False;
end;

procedure TFormAddToWarehouse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
// podczas zamkni�cia programu - roz��czenie z serwerem
  MySQL.Connected := False;
end;

procedure TFormAddToWarehouse.LoadTable;
var
  i : Integer;
  ListItem : TListItem;
begin
  ListView.Items.Clear;
  //SQL.CommandText := 'SELECT * FROM stretch_foils'; // zapytanie

  SQL.CommandText := 'SELECT indeksy.indeks, indeksy.nazwa_krotka, indeksy.nazwa_pelna, indeksy.jednostka, ';
  SQL.CommandText := SQL.CommandText + 'pozycje_zapotrzebowania_materialowego.ilosc, ';
  SQL.CommandText := SQL.CommandText + 'pozycje_zapotrzebowania_materialowego.status_pozycji_zapotrzebowania_materialowego ';
  SQL.CommandText := SQL.CommandText + 'FROM pozycje_zapotrzebowania_materialowego, indeksy WHERE pozycje_zapotrzebowania_materialowego.nr_indeksu = indeksy.nr';

  SQL.Open; // odczytaj dane

  for I := 1 to SQL.RecordCount do
  begin
  { dodaj kolejne warto�ci }
    ListItem := ListView.Items.Add;
    //ListItem.Caption := IntToStr(SQL.FieldValues['id']);
    ListItem.SubItems.Add(SQL.FieldValues['indeks']);
    //ListItem.SubItems.Add(SQL.FieldValues['supplierNIP']);
    //ListItem.SubItems.Add(SQL.FieldValues['eanCode']);
    //ListItem.SubItems.Add(SQL.FieldValues['quantity']);
    //ListItem.SubItems.Add(SQL.FieldValues['unit']);
    //ListItem.SubItems.Add(SQL.FieldValues['product']);
    //ListItem.SubItems.Add(SQL.FieldValues['status']);
    SQL.Next;
  end;

  SQL.Close;
end;

end.