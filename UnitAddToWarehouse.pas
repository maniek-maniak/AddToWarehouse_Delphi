unit UnitAddToWarehouse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBXpress, FMTBcd, DB, SqlExpr, StdCtrls, ComCtrls, ExtCtrls, DataBase;

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
    Edit6: TEdit;
    Edit7: TEdit;
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
  private
    { Private declarations }
    Connected : Boolean;
    procedure ReadDB;
//    procedure LoadTables;
    procedure Show;
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

Quantity, UnitValue, Value: Currency;

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

  InIndeks:= '%' + FormAddToWarehouse.InputIndex.Text + '%';
  InShortName:= '%'+ FormAddToWarehouse.InputShortName.Text +'%';
  InFullName:= FormAddToWarehouse.InputFullName.Text;

  InNrZapotrzebowania:= FormAddToWarehouse.InputOrderNumber.Text;
  if InNrZapotrzebowania = '' then InNrZapotrzebowania:= '%';

  InStatus:= '%' + FormAddToWarehouse.InputStatus.Text + '%';

  ReadDB;
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
          ListItem.Caption:= (IntToStr(i));
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
  and (FormAddToWarehouse.OutputDeliveryNote.Text <> ''))
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

procedure TFormAddToWarehouse.OutputValueKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
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
     CheckOutputData;
    end;
  end;
end;

procedure TFormAddToWarehouse.OutputDeliveryNoteKeyUp(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  CheckOutputData;
end;

end.
