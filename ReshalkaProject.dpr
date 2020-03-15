program ReshalkaProject;

uses
  Forms,
  Reshalka in 'Reshalka.pas' {ReshalkaMainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TReshalkaMainForm, ReshalkaMainForm);
  Application.Run;
end.
