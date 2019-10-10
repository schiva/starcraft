program StarAssist;

uses
  Vcl.Forms,
  fmMain_ in 'fmMain_.pas' {Form1},
  SystemShortcut in 'SystemShortcut.pas',
  Observer.HandleComponent in 'Observer.HandleComponent.pas',
  CCR.VirtualKeying.Consts in 'VirtualKey\CCR.VirtualKeying.Consts.pas',
  CCR.VirtualKeying.Mac in 'VirtualKey\CCR.VirtualKeying.Mac.pas',
  CCR.VirtualKeying in 'VirtualKey\CCR.VirtualKeying.pas',
  CCR.VirtualKeying.Win in 'VirtualKey\CCR.VirtualKeying.Win.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
