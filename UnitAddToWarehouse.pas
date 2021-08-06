unit UnitAddToWarehouse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, ComCtrls, ExtCtrls;

type
  TFormAddToWarehouse = class(TForm)
    ListView: TListView;
    MySQL: TSQLConnection;
    SQL: TSQLDataSet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    InputIndex: TEdit;
    Label2: TLabel;
    InputShortName: TEdit;
    Label3: TLabel;
    InputFullName: TEdit;
    Label4: TLabel;
    InputOrderNumber: TEdit;
    GroupBox2: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    OutputWarehouse: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    OutputQuantity: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Edit10: TEdit;
    InputStatus: TEdit;
    Label11: TLabel;
    DB_status: TStatusBar;
    TReadDB: TTimer;
    Label12: TLabel;
    OutputShortName: TEdit;
    Label13: TLabel;
    OutputFullName: TEdit;
    btnConnect: TButton;
    btnConfirmDelivery: TButton;
    Label14: TLabel;
    OutputIndex: TEdit;
    Label15: TLabel;
    OutputUnit: TEdit;
    procedure btnConnectClick(Sender: TObject);
    procedure MySQLAfterConnect(Sender: TObject);
    procedure MySQLAfterDisconnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TReadDBTimer(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure InputOrderNumberKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    Connected : Boolean;
    procedure ReadDB;
//    procedure LoadTables;
    procedure Show;
  public
    { Public declarations }
  end;

type
  TIndeks = Record
   Numer: Integer;
    Indeks: String[18];
     NazwaKrotka: String[191];
      NazwaPelna: String[191];
       Jednostka: String[5];
    end;

type
  TPozycjaZapotrzebowaniaMaterialowego = Record
   Nr: Integer;
    NrZapotrzebowaniaMaterialowego: Integer;
     NrIndeksu: Integer;
      Indeks: String[18];
       NazwaKrotka: String[191];
        NazwaPelna: String[191];
         Jednostka: String[5];
          Ilosc: Integer;
           IloscDostarczona: Integer;
            Status: String[20];
    end;

var

Indeksy: array of TIndeks;     //  MATRIX
 RozmiarIndeksy: Integer;
  Indeks: TIndeks;

PozycjeZapotrzebowaniaMaterialowego: array of TPozycjaZapotrzebowaniaMaterialowego;     //  MATRIX
 RozmiarPozycjeZapotrzebowaniaMaterialowego: Integer;
  PozycjaZapotrzebowaniaMaterialowego: TPozycjaZapotrzebowaniaMaterialowego;

var
  FormAddToWarehouse: TFormAddToWarehouse;

implementation

{$R *.dfm}

procedure TFormAddToWarehouse.btnConnectClick(Sender: TObject);
begin
  if Connected then Connected := False else Connected := True;
  MySQL.Connected := True;
end;

procedure TFormAddToWarehouse.MySQLAfterConnect(Sender: TObject);
begin
  btnConnect.Caption := 'Wyszukiwanie';
   btnConnect.Enabled := False;
    DB_status.Panels[0].Text:= 'DB conected';
     FormAddToWarehouse.ReadDB;
end;

procedure TFormAddToWarehouse.MySQLAfterDisconnect(Sender: TObject);
begin
  btnConnect.Caption := 'Wyszukaj';
   btnConnect.Enabled := True;
    DB_status.Panels[0].Text:= 'DB disconected';
end;

procedure TFormAddToWarehouse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MySQL.Connected := False; // podczas zamkni�cia programu - roz��czenie z serwerem
end;




procedure TFormAddToWarehouse.TReadDBTimer(Sender: TObject);
begin
  FormAddToWarehouse.TReadDB.Enabled:= false;
   FormAddToWarehouse.Show;
end;




procedure TFormAddToWarehouse.ReadDB;
var
  i, j: Integer;
  InIndeks: String;
  InShortName: String;
  InFullName: String;

  InNrZapotrzebowania: String;
  InStatus: String;

  SELECT, FROM, WHERE: String;
begin
  InIndeks:= '%' + FormAddToWarehouse.InputIndex.Text + '%';
  InShortName:= '%'+ FormAddToWarehouse.InputShortName.Text +'%';
  InFullName:= FormAddToWarehouse.InputFullName.Text;

  InNrZapotrzebowania:= FormAddToWarehouse.InputOrderNumber.Text;
  if InNrZapotrzebowania = '' then InNrZapotrzebowania:= '%';

   InStatus:= '%' + FormAddToWarehouse.InputStatus.Text + '%';




  SELECT:= 'SELECT ';
  SELECT:= SELECT + 'indeksy.nr, ';
  SELECT:= SELECT + 'indeksy.indeks, ';
  SELECT:= SELECT + 'indeksy.nazwa_krotka, ';
  SELECT:= SELECT + 'indeksy.nazwa_pelna, ';
  SELECT:= SELECT + 'indeksy.jednostka ';

  FROM:= 'FROM indeksy ';

  WHERE:= 'WHERE ';
  WHERE:= WHERE + 'indeks LIKE "%s" ';
  WHERE:= WHERE + 'AND nazwa_krotka LIKE "%s"';

  SQL.CommandText := Format(SELECT + FROM + WHERE, [InIndeks, InShortName]);

  SQL.Open; // odczytaj dane
  RozmiarIndeksy:= SQL.RecordCount;
  setLength(Indeksy, RozmiarIndeksy);
  DB_status.Panels[3].Text:= 'Pobrano '+IntToStr(RozmiarIndeksy)+' indeks�w.';

  for i := 1 to SQL.RecordCount-1 do
  begin
       Indeks.Numer:= SQL.FieldValues['nr'];
        Indeks.Indeks:= SQL.FieldValues['indeks'];
         if (Indeks.Indeks <> '') then Indeks.Indeks:= Indeks.Indeks);
         Indeks.NazwaKrotka:= SQL.FieldValues['nazwa_krotka'];
          if (Indeks.NazwaKrotka <> '') then Indeks.NazwaKrotka:= UTF8ToAnsi(Indeks.NazwaKrotka);
          Indeks.NazwaPelna:= SQL.FieldValues['nazwa_pelna'];
           if (Indeks.NazwaPelna <> '') then Indeks.NazwaPelna:= UTF8ToAnsi(Indeks.NazwaPelna);
            Indeks.Jednostka:= SQL.FieldValues['jednostka'];
            if (Indeks.Jednostka <> '') then Indeks.Jednostka:= UTF8ToAnsi(Indeks.Jednostka);
            { dodaj kolejne warto�ci }
            Indeksy[i]:= Indeks;
            SQL.Next;
  end;

  SQL.Close;

  SELECT:= 'SELECT ';
  SELECT:= SELECT + 'nr, ';
  SELECT:= SELECT + 'nr_indeksu, ';
  SELECT:= SELECT + 'ilosc, ';
  SELECT:= SELECT + 'ilosc_dostarczona, ';
  SELECT:= SELECT + 'status ';

  FROM:= 'FROM pozycje_zapotrzebowania_materialowego ';
  WHERE:= 'WHERE nr_zapotrzebowania_materialowego LIKE "%s" AND status LIKE "%s"';

  SQL.CommandText := Format(SELECT + FROM + WHERE, [InNrZapotrzebowania, InStatus]);

  SQL.Open; // odczytaj dane
  RozmiarPozycjeZapotrzebowaniaMaterialowego:= SQL.RecordCount;
  setLength(PozycjeZapotrzebowaniaMaterialowego, RozmiarPozycjeZapotrzebowaniaMaterialowego);
  DB_status.Panels[4].Text:= 'Pobrano ' + IntToStr(RozmiarPozycjeZapotrzebowaniaMaterialowego) + ' pozycji zapotrzebowa� zakupu.';

  for j := 1 to SQL.RecordCount-1 do
  begin
  { dodaj kolejne warto�ci }
   PozycjaZapotrzebowaniaMaterialowego.Nr:= SQL.FieldValues['nr'];
    PozycjaZapotrzebowaniaMaterialowego.NrIndeksu:= SQL.FieldValues['nr_indeksu'];
     PozycjaZapotrzebowaniaMaterialowego.Ilosc:= SQL.FieldValues['ilosc'];
      PozycjaZapotrzebowaniaMaterialowego.IloscDostarczona:= SQL.FieldValues['ilosc_dostarczona'];
       PozycjaZapotrzebowaniaMaterialowego.Status:= UTF8ToAnsi(SQL.FieldValues['status']);

    PozycjeZapotrzebowaniaMaterialowego[j]:= PozycjaZapotrzebowaniaMaterialowego;
     SQL.Next;
  end;

  SQL.Close;
  MySQL.Connected := False;

  FormAddToWarehouse.TReadDB.Enabled:= true;
end;


{*****************        Wyswietlanie pobranych wynikow       ****************}
procedure TFormAddToWarehouse.Show;
var
  i, j : Integer;
  ListItem : TListItem;
begin
  ListView.Items.Clear;
  for i:= 1 to RozmiarPozycjeZapotrzebowaniaMaterialowego do
  begin
   //PozycjaZapotrzebowaniaMaterialowego:= PozycjeZapotrzebowaniaMaterialowego[i];
    for j:= 1 to RozmiarIndeksy do
    begin
      Indeks:= Indeksy[j];
      if (PozycjeZapotrzebowaniaMaterialowego[i].NrIndeksu = Indeks.Numer) then
        begin
          PozycjeZapotrzebowaniaMaterialowego[i].Indeks:= Indeks.Indeks;
          PozycjeZapotrzebowaniaMaterialowego[i].NazwaKrotka:= Indeks.NazwaKrotka;
          PozycjeZapotrzebowaniaMaterialowego[i].NazwaPelna:= Indeks.NazwaPelna;
          PozycjeZapotrzebowaniaMaterialowego[i].Jednostka:= Indeks.Jednostka;

          ListItem := ListView.Items.Add;
          ListItem.Caption:= (IntToStr(PozycjeZapotrzebowaniaMaterialowego[i].Nr));
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Indeks);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].NazwaKrotka);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].NazwaPelna);
          ListItem.SubItems.Add(IntToStr(PozycjeZapotrzebowaniaMaterialowego[i].Ilosc));
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Jednostka);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Status);

          //PozycjeZapotrzebowaniaMaterialowego[i] := PozycjaZapotrzebowaniaMaterialowego;
        end;

    end;

  end;

end;


procedure TFormAddToWarehouse.ListViewDblClick(Sender: TObject);
begin
 PozycjaZapotrzebowaniaMaterialowego:= PozycjeZapotrzebowaniaMaterialowego[StrToInt(ListView.Selected.Caption)];
  OutputIndex.Text:= PozycjaZapotrzebowaniaMaterialowego.Indeks;
   OutputShortName.Text:= PozycjaZapotrzebowaniaMaterialowego.NazwaKrotka;
    OutputFullName.Text:= PozycjaZapotrzebowaniaMaterialowego.NazwaPelna;
     OutputQuantity.Text:= IntToStr(PozycjaZapotrzebowaniaMaterialowego.Ilosc);
      OutputUnit.Text:= PozycjaZapotrzebowaniaMaterialowego.Jednostka;
end;

procedure TFormAddToWarehouse.InputOrderNumberKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, '0'..'9', DecimalSeparator]) then
  begin
     Key := #0;
  end
  else
  if (Key = DecimalSeparator) and (Pos(Key, InputOrderNumber.Text) > 0) then
  begin
    Key := #0;
  end;
end;

end.
