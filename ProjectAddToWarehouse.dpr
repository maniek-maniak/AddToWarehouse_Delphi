program ProjectAddToWarehouse;

uses
  Forms,
  UnitAddToWarehouse in 'UnitAddToWarehouse.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormAddToWarehouse, FormAddToWarehouse);
  Application.Run;
end.
