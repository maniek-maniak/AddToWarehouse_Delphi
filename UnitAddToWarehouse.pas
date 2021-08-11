unit UnitAddToWarehouse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, ComCtrls, ExtCtrls,
  Menus, UnitSpendOnTheJob;

type
  TFormAddToWarehouse = class(TForm)
    ListView: TListView;
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
    OutputShelfNumber: TEdit;
    OutputRackNumber: TEdit;
    OutputQuantity: TEdit;
    OutputValue: TEdit;
    OutputDeliveryNote: TEdit;
    OutputUnitValue: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    InputStatus: TEdit;
    Label11: TLabel;
    DB_status: TStatusBar;
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
    RadioGroup1: TRadioGroup;
    ButtonPrint: TButton;
    RadioButtonNoPrint: TRadioButton;
    RadioButtonOnePrint: TRadioButton;
    RadioButtonAllPrint: TRadioButton;
    MySQL: TSQLConnection;
    SQL: TSQLDataSet;
    TReadDB: TTimer;
    MainMenu1: TMainMenu;
    Dostawy1: TMenuItem;
    Rozchody1: TMenuItem;
    Wydajnazlecenie1: TMenuItem;
    procedure btnConnectClick(Sender: TObject);
    procedure MySQLAfterConnect(Sender: TObject);
    procedure MySQLAfterDisconnect(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure TReadDBTimer(Sender: TObject);
    procedure ListViewDblClick(Sender: TObject);
    procedure InputOrderNumberKeyPress(Sender: TObject; var Key: Char);
    procedure OutputValueKeyPress(Sender: TObject; var Key: Char);
    procedure OutputValueKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputDeliveryNoteKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputQuantityKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputShelfNumberKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputRackNumberKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure OutputWarehouseKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnConfirmDeliveryClick(Sender: TObject);
    procedure OutputQuantityKeyPress(Sender: TObject; var Key: Char);
    procedure Wydajnazlecenie1Click(Sender: TObject);
  private
    { Private declarations }
    Connected : Boolean;
    read_DB : Boolean;
    write_DB : Boolean;
    procedure ReadDB;
    procedure WriteDB;
//    procedure LoadTables;
    procedure Show;
    procedure ObliczCeneJedn;
    procedure CheckOutputData;
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

  InIndeks: String;
  InShortName: String;
  InFullName: String;

  InNrZapotrzebowania: String;
  InStatus: String;

  OutputNrLiniiZapotrzebowania: String;
  OutputNumberIndex: String;
  IloscDosatarczona: String;

  Quantity, UnitValue, Value: Currency;

var
  FormAddToWarehouse: TFormAddToWarehouse;

implementation

{$R *.dfm}

procedure TFormAddToWarehouse.btnConnectClick(Sender: TObject);
begin
//  if Connected then Connected := False else Connected := True;
  FormAddToWarehouse.btnConnect.Enabled:= False;
  read_DB:= True;
  MySQL.Connected := True;
end;

procedure TFormAddToWarehouse.MySQLAfterConnect(Sender: TObject);
begin
  btnConnect.Caption := 'Wyszukiwanie';
   btnConnect.Enabled := False;
    DB_status.Panels[0].Text:= 'DB conected';
  if (read_DB) then  ReadDB;
  if (write_DB) then  WriteDB;
end;

procedure TFormAddToWarehouse.MySQLAfterDisconnect(Sender: TObject);
begin
  btnConnect.Caption := 'Wyszukaj';
   btnConnect.Enabled := True;
    DB_status.Panels[0].Text:= 'DB disconected';
end;

procedure TFormAddToWarehouse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MySQL.Connected := False; // podczas zamkniêcia programu - roz³¹czenie z serwerem
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

  read_DB:= False;

  InIndeks:= '%' + FormAddToWarehouse.InputIndex.Text + '%';
  InShortName:= AnsiToUTF8('%' + FormAddToWarehouse.InputShortName.Text + '%');
  InFullName:= AnsiToUTF8('%' + FormAddToWarehouse.InputFullName.Text + '%');

  InNrZapotrzebowania:= FormAddToWarehouse.InputOrderNumber.Text;
  if InNrZapotrzebowania = '' then InNrZapotrzebowania:= '%';

  InStatus:= AnsiToUTF8('%' + FormAddToWarehouse.InputStatus.Text + '%');

  SELECT:= 'SELECT ';
  SELECT:= SELECT + 'indeksy.nr, ';
  SELECT:= SELECT + 'indeksy.indeks, ';
  SELECT:= SELECT + 'indeksy.nazwa_krotka, ';
  SELECT:= SELECT + 'indeksy.nazwa_pelna, ';
  SELECT:= SELECT + 'indeksy.jednostka ';

  FROM:= 'FROM indeksy ';

  WHERE:= 'WHERE ';
  WHERE:= WHERE + 'indeks LIKE "%s" ';
  WHERE:= WHERE + 'AND nazwa_krotka LIKE "%s";';

  SQL.CommandText := Format(SELECT + FROM + WHERE, [InIndeks, InShortName]);

  SQL.Open; // odczytaj dane
  RozmiarIndeksy:= SQL.RecordCount;
  setLength(Indeksy, RozmiarIndeksy);
  DB_status.Panels[3].Text:= 'Pobrano '+IntToStr(RozmiarIndeksy)+' indeksów.';

  for i := 0 to SQL.RecordCount-1 do
  begin
       Indeks.Numer:= SQL.FieldValues['nr'];
        Indeks.Indeks:= SQL.FieldValues['indeks'];
         if (Indeks.Indeks <> '') then Indeks.Indeks:= Indeks.Indeks;
         Indeks.NazwaKrotka:= SQL.FieldValues['nazwa_krotka'];
          if (Indeks.NazwaKrotka <> '') then Indeks.NazwaKrotka:= UTF8ToAnsi(Indeks.NazwaKrotka);
          Indeks.NazwaPelna:= SQL.FieldValues['nazwa_pelna'];
           if (Indeks.NazwaPelna <> '') then Indeks.NazwaPelna:= UTF8ToAnsi(Indeks.NazwaPelna);
            Indeks.Jednostka:= SQL.FieldValues['jednostka'];
            if (Indeks.Jednostka <> '') then Indeks.Jednostka:= UTF8ToAnsi(Indeks.Jednostka);
            { dodaj kolejne wartooci }
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
  WHERE:= 'WHERE nr_zapotrzebowania_materialowego LIKE "%s" ';
  WHERE:= WHERE + 'AND status LIKE "%s"';

  SQL.CommandText := Format(SELECT + FROM + WHERE, [InNrZapotrzebowania, InStatus]);

  SQL.Open; // odczytaj dane
  RozmiarPozycjeZapotrzebowaniaMaterialowego:= SQL.RecordCount;
  setLength(PozycjeZapotrzebowaniaMaterialowego, RozmiarPozycjeZapotrzebowaniaMaterialowego);
  DB_status.Panels[4].Text:= 'Pobrano ' + IntToStr(RozmiarPozycjeZapotrzebowaniaMaterialowego) + ' pozycji zapotrzebowan zakupu.';

  for j := 0 to SQL.RecordCount-1 do
  begin
  { dodaj kolejne wartooci }
   PozycjaZapotrzebowaniaMaterialowego.Nr:= SQL.FieldValues['nr'];
    PozycjaZapotrzebowaniaMaterialowego.NrIndeksu:= SQL.FieldValues['nr_indeksu'];
     PozycjaZapotrzebowaniaMaterialowego.Ilosc:= SQL.FieldValues['ilosc'];
      PozycjaZapotrzebowaniaMaterialowego.IloscDostarczona:= SQL.FieldValues['ilosc_dostarczona'];
       PozycjaZapotrzebowaniaMaterialowego.Status:= SQL.FieldValues['status'];

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
  for i:= 0 to RozmiarPozycjeZapotrzebowaniaMaterialowego-1 do
  begin
    for j:= 0 to RozmiarIndeksy-1 do
    begin
      if (PozycjeZapotrzebowaniaMaterialowego[i].NrIndeksu = Indeksy[j].Numer) then
        begin
          PozycjeZapotrzebowaniaMaterialowego[i].Indeks:= Indeksy[j].Indeks;
          PozycjeZapotrzebowaniaMaterialowego[i].NazwaKrotka:= Indeksy[j].NazwaKrotka;
          PozycjeZapotrzebowaniaMaterialowego[i].NazwaPelna:= Indeksy[j].NazwaPelna;
          PozycjeZapotrzebowaniaMaterialowego[i].Jednostka:= Indeksy[j].Jednostka;

          ListItem := ListView.Items.Add;
          ListItem.Caption:= (IntToStr(i));
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Indeks);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].NazwaKrotka);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].NazwaPelna);
          ListItem.SubItems.Add(IntToStr(PozycjeZapotrzebowaniaMaterialowego[i].Ilosc));
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Jednostka);
          ListItem.SubItems.Add(PozycjeZapotrzebowaniaMaterialowego[i].Status);
        end;

    end;

  end;

end;


procedure TFormAddToWarehouse.ListViewDblClick(Sender: TObject);
begin
 PozycjaZapotrzebowaniaMaterialowego:= PozycjeZapotrzebowaniaMaterialowego[StrToInt(ListView.Selected.Caption)];
  OutputNrLiniiZapotrzebowania:= IntToSTr(PozycjaZapotrzebowaniaMaterialowego.Nr);
   OutputNumberIndex:= IntToStr(PozycjaZapotrzebowaniaMaterialowego.NrIndeksu);
    OutputIndex.Text:= PozycjaZapotrzebowaniaMaterialowego.Indeks;
     OutputShortName.Text:= PozycjaZapotrzebowaniaMaterialowego.NazwaKrotka;
      OutputFullName.Text:= PozycjaZapotrzebowaniaMaterialowego.NazwaPelna;
       OutputQuantity.Text:= IntToStr(PozycjaZapotrzebowaniaMaterialowego.Ilosc);
        OutputUnit.Text:= PozycjaZapotrzebowaniaMaterialowego.Jednostka;
         OutputValue.Text:= '';
          CheckOutputData;
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


procedure TFormAddToWarehouse.CheckOutputData;
begin
  if ((FormAddToWarehouse.OutputIndex.Text <> '')
  and (FormAddToWarehouse.OutputShortName.Text <> '')
  and (FormAddToWarehouse.OutputFullName.Text <> '')
  and (FormAddToWarehouse.OutputDeliveryNote.Text <> '')
  and (FormAddToWarehouse.OutputWarehouse.Text <> '')
  and (FormAddToWarehouse.OutputRackNumber.Text <> '')
  and (FormAddToWarehouse.OutputShelfNumber.Text <> '')
  and (FormAddToWarehouse.OutputQuantity.Text <> '')
  and (FormAddToWarehouse.OutputValue.Text <> ''))
    then
     begin
       FormAddToWarehouse.btnConfirmDelivery.Enabled:= true;
     end else
     begin
       FormAddToWarehouse.btnConfirmDelivery.Enabled:= false;
    end;
end;

procedure TFormAddToWarehouse.OutputValueKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, '0'..'9', DecimalSeparator]) then
  begin
     Key := #0;
  end
  else
  if (Key = DecimalSeparator) and (Pos(Key, OutputValue.Text) > 0) then
  begin
    Key := #0;
  end;
end;

procedure TFormAddToWarehouse.ObliczCeneJedn;
begin
  if (OutputQuantity.Text <> '') then
   begin
    try
      Quantity:= StrToInt(OutputQuantity.Text);
    except
      Quantity:= 1;
     end;
   end;
  if (OutputValue.Text <>'') then
   begin
   Value:= StrToCurr(OutputValue.Text);
   if (Value > 0) then
    begin
     UnitValue:= Value / Quantity;
     OutputUnitValue.Text:= CurrToStr(UnitValue);
    end;
  end;
end;

procedure TFormAddToWarehouse.OutputValueKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ObliczCeneJedn;
  CheckOutputData;
end;

procedure TFormAddToWarehouse.OutputDeliveryNoteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckOutputData;
end;

procedure TFormAddToWarehouse.OutputQuantityKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  ObliczCeneJedn;
  CheckOutputData;
end;

procedure TFormAddToWarehouse.OutputShelfNumberKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckOutputData;
end;

procedure TFormAddToWarehouse.OutputRackNumberKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckOutputData;
end;

procedure TFormAddToWarehouse.OutputWarehouseKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckOutputData;
end;

procedure TFormAddToWarehouse.WriteDB;
var

  IloscDostarczona, DeliveryNote, Warehouse, UnitValue : String;

  _UPDATE, _SET, _WHERE: String;
  _INSERT_INTO, _VALUES, _STATUS: String;
begin
  write_DB:= False;
  IloscDostarczona:= FormAddToWarehouse.OutputQuantity.Text;
  _UPDATE:= 'UPDATE `pozycje_zapotrzebowania_materialowego` ';
  _SET:= 'SET `ilosc_dostarczona` =  %s, ';
  _SET:= _SET + '`status_pozycji_zapotrzebowania_materialowego` = %s ';
  _WHERE:= 'WHERE `pozycje_zapotrzebowania_materialowego`.`nr` = %s;';
  _STATUS:= AnsiToUTF8('"Przyjête"');

  SQL.CommandText := Format(_UPDATE + _SET + _WHERE, [IloscDostarczona, _STATUS, OutputNrLiniiZapotrzebowania]);

  SQL.ExecSQL;

  DeliveryNote:= AnsiToUTF8(FormAddToWarehouse.OutputDeliveryNote.Text);
  Warehouse:= AnsiToUTF8(FormAddToWarehouse.OutputWarehouse.Text);
  UnitValue:= FormAddToWarehouse.OutputUnitValue.Text;
  UnitValue:= StringReplace(UnitValue, ',', '.', []);

  _INSERT_INTO:= 'INSERT INTO `magazyn_pz_rw` (`nr_pozycji_zapotrzebowania_materialowego`, `pz_wz`, `nr_roportu_o_usterce`, ';
  _INSERT_INTO:= _INSERT_INTO + '`nr_pracownika_wydajacego`, `nr_pracownika_pobierajacego`, `nr_indeksu_materialowego`, `nr_magazynu`, `nr_regalu`, `nr_polki`, `ilosc`, `wartosc_jednostkowa`) ';
  _VALUES:= 'VALUES ("%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s", "%s");';

  SQL.CommandText := Format(_INSERT_INTO + _VALUES, [OutputNrLiniiZapotrzebowania, DeliveryNote, '0','52','0', OutputNumberIndex, Warehouse, '0','0', IloscDostarczona, UnitValue]);

  SQL.ExecSQL;

  SQL.Close;
  MySQL.Connected := False;

end;

procedure TFormAddToWarehouse.btnConfirmDeliveryClick(Sender: TObject);
begin
//  if Connected then Connected := False else Connected := True;
  FormAddToWarehouse.btnConfirmDelivery.Enabled:= False;
  write_DB:= True;
  MySQL.Connected := True;
end;

procedure TFormAddToWarehouse.OutputQuantityKeyPress(Sender: TObject;
  var Key: Char);
begin
  if not (Key in [#8, '0'..'9', DecimalSeparator]) then
  begin
     Key := #0;
  end
  else
  if (Key = DecimalSeparator) and (Pos(Key, OutputQuantity.Text) > 0) then
  begin
    Key := #0;
  end;
end;

procedure TFormAddToWarehouse.Wydajnazlecenie1Click(Sender: TObject);
begin
  FormAddToWarehouse.Visible:= false;
  FormSpendOnTheJob.Visible:= true;
end;

end.
