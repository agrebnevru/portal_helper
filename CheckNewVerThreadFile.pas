unit CheckNewVerThreadFile;

interface

uses
  System.Classes, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TAppCheckNewVer = class(TThread)
  private
    { Private declarations }
    IdHTTP1: TIdHTTP;
    Finish: boolean;
    Version: String;
    procedure SetProgress;
    procedure Debug(mes: String);
    procedure DebugSetProgress;
  protected
    procedure Execute; override;
  end;

Const
  NEW_VER_URL = 'http://portalhelper.imyie.ru/version/';

var
  DebugString: String;

implementation

uses UnitMain, UnitTest;

{ AppCheckNewVer }

procedure TAppCheckNewVer.Execute;
begin
  { Place thread code here }
  Debug('TAppCheckNewVer.Execute');
  Finish := False;
  Version := '0000';

  IdHTTP1 := TIdHTTP.Create(nil);
  IdHTTP1.ReadTimeout := 10000;
  Debug('Execute - NEW_VER_URL = ' + NEW_VER_URL);
  Try
    Version := IdHTTP1.Get(NEW_VER_URL);
    Debug('Execute - Version = ' + Version);
    IdHTTP1.Free;
    Finish := True;
  Except
    Version := '0000';
  End;

  Synchronize(SetProgress);
end;

procedure TAppCheckNewVer.SetProgress;
begin
  Debug('SetProgress');
  { Place synchronize code here }
  Try
    FormMain.CallBackCheckNewVer(Version);
  Finally
    //
  End;
end;

procedure TAppCheckNewVer.Debug(mes: String);
begin
  DebugString := 'TRequestThread: ' + mes;
  Synchronize(DebugSetProgress);
end;

procedure TAppCheckNewVer.DebugSetProgress;
begin
  FormMain.Debug(DebugString);
end;

end.
