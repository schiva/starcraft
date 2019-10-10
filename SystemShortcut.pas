unit SystemShortcut;

interface

uses
  Classes, Windows, Messages, System.Contnrs, System.Generics.Collections,
  Observer.HandleComponent;

Type

  TOnShortcut = reference to procedure(Sender:TObject; const AModifier:cardinal; const AScancode: cardinal);
  TSystemShortcut = Class(THandleComponent)
    private
      FSeq:integer;
      FKey: Integer;
      FList: TObjectList;
      FOnHotKey: TOnShortcut;
       procedure WMHotKey(var Msg: TWMHotKey); message WM_HOTKEY;
    public
      constructor Create(AOwner:TComponent); overload;
      constructor Create(AOwner:TComponent; AOnShortcut: TOnShortcut); overload;
      Destructor  Destroy; override;

      procedure RegisterKey(keycode:cardinal;Modifier:Cardinal=mod_win);
    published
      property OnHotKey: TOnShortcut read FOnHotKey Write FOnHotKey;
  End;

const
  MOD_ALT = 1;
  MOD_CONTROL = 2;
  MOD_SHIFT = 4;
  MOD_WIN = 8;

implementation

uses
  sysutils;

type
  TShortcutData = class
    atom: integer;
    name:String;
    modifier, keyscan:cardinal;
  end;

//  VK_A = $41;
//  VK_R = $52;
//  VK_F4 = $73;
{ TGlobalHotkey }

constructor TSystemShortcut.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FList := TObjectList.Create(true);
end;

constructor TSystemShortcut.Create(AOwner: TComponent;
  AOnShortcut: TOnShortcut);
begin
  self.Create(AOwner);
  self.OnHotKey := AOnShortCut;
end;

destructor TSystemShortcut.Destroy;
var
  I: Integer;
begin
  for I := 0 to FLIst.Count - 1 do
  begin
    UnRegisterHotKey(Handle, TShortcutData(Flist.Items[i]).atom );
    GlobalDeleteAtom(TShortcutData(Flist.Items[i]).atom);
  end;

  FList.Clear;
  FList.Free;
  inherited;
end;

// modifier sample
// MOD_CONTROL + MOD_ALT
procedure TSystemShortcut.RegisterKey(keycode:cardinal;Modifier:Cardinal=mod_win);
var
  data: TShortcutData;
begin
  inc(FSeq);

  data := TShortcutData.Create;
  data.name := format('g_CustomShortcut%.3d',[ FSeq ] );
  data.atom := GlobalAddAtom(pWideChar(data.name));
  data.modifier := Modifier;
  data.keyscan  := KeyCode;
  FList.Add(data);

  RegisterHotKey(self.Handle, data.atom, Modifier, keycode);
end;

procedure TSystemShortcut.WMHotKey(var Msg: TWMHotKey);
var
  I: Integer;
begin
  for I := 0 to FList.Count - 1 do
  begin
    if TShortcutData(FList.Items[i]).atom = msg.HotKey then
    begin
      if Assigned(FOnHotKey) then
        FOnHotKey(self, TShortcutData(FList.Items[i]).modifier, TShortcutData(FList.Items[i]).keyscan);
      break;
    end;
  end;
end;

end.
