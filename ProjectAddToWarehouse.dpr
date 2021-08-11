program ProjectAddToWarehouse;

uses
  Forms,
  UnitLogin in 'UnitLogin.pas' {FormLogIn},
  UnitAddToWarehouse in 'UnitAddToWarehouse.pas' {FormAddToWarehouse},
  UnitSpendOnTheJob in 'UnitSpendOnTheJob.pas' {FormSpendOnTheJob};


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormAddToWarehouse, FormAddToWarehouse);
  Application.CreateForm(TFormLogIn, FormLogIn);
  Application.Run;
end.
