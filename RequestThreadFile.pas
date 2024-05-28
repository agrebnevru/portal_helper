unit RequestThreadFile;

interface

uses
  SysUtils, System.Classes, IdCookieManager, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

type
  TProc = procedure of object;
  TRequestThread = class(TThread)
  private
    RequestData: TSTringList;
    procedure Debug(mes: String);
    procedure DebugSetProgress;
  private
    { Private declarations }
  protected
    procedure Execute; override;
  public
    threadResult: String;
    constructor Create(aRequestData: TSTringList; aProcedureName: TProc);
  end;

var
  DebugString: String;
  ProcedureName: TProc;

implementation

uses UnitMain, UnitTest;

constructor TRequestThread.Create(aRequestData: TSTringList; aProcedureName: TProc);
begin
  inherited Create(False);
  FreeOnTerminate := False;
  RequestData := aRequestData;
  ProcedureName := aProcedureName;
end;

procedure TRequestThread.Execute;
var
  Response: TStringStream;
begin
  { Place thread code here }
  Debug('TRequestThread - Start');

  Debug('RequestData.Text = ' + RequestData.Text);
  try
    FormMain.IdHTTP.CookieManager := FormMain.IdCM;
    Response := TStringStream.Create('');
    FormMain.IdHTTP.Post(SettingsSiteUrl, RequestData, Response);
    PortalAnswerJson := Response.DataString;
    Debug('Response.DataString = ' + Response.DataString);
  except
    on E: EIdHTTPProtocolException do
      begin
        Debug('[EIdHTTPProtocolException] Fail request. Code: ' + IntToStr(FormMain.IdHTTP.ResponseCode));
      end;
      on E: Exception do
      begin
        Debug('[Exception] Fail request. Code: ' + IntToStr(FormMain.IdHTTP.ResponseCode));
      end;
  end;

  if Assigned(ProcedureName) then
    ProcedureName;

  Debug('TRequestThread - Finish');
end;

procedure TRequestThread.Debug(mes: String);
begin
  DebugString := 'TRequestThread: ' + mes;
  Synchronize(DebugSetProgress);
end;

procedure TRequestThread.DebugSetProgress;
begin
  FormMain.Debug(DebugString);
end;

end.
