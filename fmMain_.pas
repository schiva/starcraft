unit fmMain_;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Menus,
  SystemShortcut, Vcl.StdCtrls, CCR.VirtualKeying;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    lbStatus: TLabel;
    Label2: TLabel;
    edInterval: TEdit;
    Label3: TLabel;
    lbFound: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    FWorking: Boolean;
    FHotKey: TSystemShortcut;
    FSP: Cardinal;
    procedure OnHotKey(Sender: TObject; const AModifier: Cardinal;
      const AScancode: Cardinal);
    procedure SetWorking(const Value: Boolean);
    { Private declarations }
  public
    property Working: Boolean read FWorking Write SetWorking;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure SendKey_Normal(VirtualKey: Word);
var
  rgInput: array [0 .. 1] of TInput;
begin
  // Normal key down
  rgInput[0].iType := INPUT_KEYBOARD;
  rgInput[0].ki.time := 0;
  rgInput[0].ki.dwFlags := 0;
  rgInput[0].ki.dwExtraInfo := 66;
  rgInput[0].ki.wVk := VirtualKey;
  // rgInput[0].ki.wScan := ScanCode;

  // Normal key up
  rgInput[1].iType := INPUT_KEYBOARD;
  rgInput[1].ki.time := 0;
  rgInput[1].ki.dwFlags := KEYEVENTF_KEYUP;
  rgInput[1].ki.dwExtraInfo := 66;
  rgInput[1].ki.wVk := VirtualKey;
  // rgInput[1].ki.wScan := ScanCode;

  SendInput(2, rgInput[0], SizeOf(TInput));
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FHotKey := TSystemShortcut.Create(self);
  FHotKey.OnHotKey := OnHotKey;
  FHotKey.RegisterKey(VK_F12, MOD_CONTROL);

  self.Working := false;

  TThread.CreateAnonymousThread(
    procedure
    var
      LHandle: THandle;
    begin
      while not application.Terminated do
      begin
        TThread.Sleep(1);

        if Working then
        begin
          if (GetTickcount - FSP) > strToInt(edInterval.Text) then
          begin
            FSP := GetTickcount;

            TVirtualKeySequence.Execute(ShortCut(ord('8'), [ssCtrl]));
            sleep(100);
            SendKey_Normal( ord('0'));
            sleep(100);
            TVirtualKeySequence.Execute('p');
            sleep(100);
            SendKey_Normal( ord('8'));


          end;
        end;
      end;
    end).Start;
end;

procedure TForm1.OnHotKey(Sender: TObject;
const AModifier, AScancode: Cardinal);
begin
  if AScancode = VK_F12 then
    self.Working := not self.Working;

end;

procedure TForm1.SetWorking(const Value: Boolean);
begin
  FWorking := Value;

  if FWorking then
    lbStatus.Caption := 'Wokring'
  else
  begin
    lbStatus.Caption := 'N/A';
    FSP := 0;
  end;

end;

end.
