program TPM_by_MKowalczyk;

uses
  Forms,
  UnitLogin in 'UnitLogin.pas' {FormLogIn},
  UnitAddToWarehouse in 'UnitAddToWarehouse.pas' {FormAddToWarehouse},
  UnitSpendOnTheJob in 'UnitSpendOnTheJob.pas' {FormSpendOnTheJob};


{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFormLogIn, FormLogIn);
  Application.CreateForm(TFormAddToWarehouse, FormAddToWarehouse);
  Application.CreateForm(TFormSpendOnTheJob, FormSpendOnTheJob);
  Application.Run;
end.
