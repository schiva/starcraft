unit Observer.HandleComponent;

interface

uses
  Windows, Classes, SysUtils, Messages;

type
  THandleComponent = class (TComponent)
  private
    FHandle : THandle;
  protected
    procedure WndProc(var Message:TMessage); virtual;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Handle : THandle read FHandle;
  end;

implementation

{ THandleComponent }

constructor THandleComponent.Create(AOwner: TComponent);
begin
  inherited;

  FHandle := AllocateHWND(WndProc);
end;

destructor THandleComponent.Destroy;
begin
  DeAllocateHWND(FHandle);

  inherited;
end;

procedure THandleComponent.WndProc(var Message: TMessage);
begin
  Dispatch(Message);
end;

end.

