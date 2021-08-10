unit UnitSpendOnTheJob;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ComCtrls;

type
  TFormSpendOnTheJob = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    InputIndex: TEdit;
    InputShortName: TEdit;
    InputFullName: TEdit;
    btnConnect: TButton;
    ListView: TListView;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    ComboBox2: TComboBox;
    MainMenu1: TMainMenu;
    Wydawanienazlecenia1: TMenuItem;
    Przyjmijzzamwienia1: TMenuItem;
    Wydawanienazlecenia2: TMenuItem;
    Wydajnazlecenie1: TMenuItem;
    Wydajnaobszar1: TMenuItem;
    Wydawanienastan1: TMenuItem;
    UtwrzKPM1: TMenuItem;
    WydajnaKPM1: TMenuItem;
    InputOrderNumber: TEdit;
    Label7: TLabel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSpendOnTheJob: TFormSpendOnTheJob;

implementation

{$R *.dfm}

end.
