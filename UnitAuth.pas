unit UnitAuth;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.JSON;

type
  TFormAuth = class(TForm)
    LabelLogo: TLabel;
    EditLogin: TEdit;
    EditPassword: TEdit;
    ButtonAuth: TButton;
    procedure FormShow(Sender: TObject);
    procedure ButtonAuthClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditPasswordKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EditLoginKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(VAR Params: TCreateParams);
  public
    { Public declarations }
    procedure AuthAfterAppRun();
    procedure PreAuthorize();
    procedure Authorize(Login, Password: String);
    procedure OnSuccessAuthorize();
    procedure OnFailAuthorize();
    procedure CallBackRequestAuthorize();
  end;

Const
  AUTH_NOTYFY_TITLE = 'Авторизация';

var
  FormAuth: TFormAuth;

implementation

{$R *.dfm}

uses UnitMain, UnitTest, UnitSettings;

procedure TFormAuth.CreateParams(VAR Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  with Params do
    ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TFormAuth.AuthAfterAppRun();
begin
  PortalLogin := FormMain.GetLogin();
  PortalPassword := FormMain.GetPassword();

  if (PortalLogin = '') or (PortalPassword = '') then
  begin
    Show;
    Exit;
  end;

  FormAuth.Authorize(PortalLogin, PortalPassword);
end;

procedure TFormAuth.PreAuthorize();
begin
  if not ButtonAuth.Enabled then
  begin
    FormMain.ShowNotify(AUTH_NOTYFY_TITLE, 'Запрос к серверу уже идет. Подождите немного.');
    Exit;
  end;

  FormMain.SaveLogin(EditLogin.Text);
  FormMain.SavePassword(EditPassword.Text);
  Authorize(EditLogin.Text, EditPassword.Text);
  ButtonAuth.Enabled := False;
end;

procedure TFormAuth.Authorize(Login, Password: String);
var
  PostData: TStringList;
begin
  PostData := TStringList.Create;
  PostData.Add('method=auth');
  PostData.Add('USER_LOGIN=' + Login);
  PostData.Add('USER_PASSWORD=' + Password);
  FormMain.SendRequest(PostData, FormAuth.CallBackRequestAuthorize);
end;

procedure TFormAuth.OnSuccessAuthorize();
begin
  FormMain.Debug('OnSuccessAuthorize');
  PortalUserId := StrToInt(FormMain.DeleteQuotes(FJSONObject.Get('USER_ID').JsonValue.ToString));

  FormMain.GetAllData();

  if Assigned(FormAuth) and (FormAuth.Visible) then
    Hide();
end;

procedure TFormAuth.OnFailAuthorize();
begin
  FormMain.Debug('OnFailAuthorize');

  FormMain.ShowNotify(AUTH_NOTYFY_TITLE, FormMain.DeleteQuotes(FJSONObject.Get('MESSAGE').JsonValue.ToString));
  ButtonAuth.Enabled := True;
  if not Visible then
    FormMain.TimerSHowAuth.Enabled := True;
  FormMain.AppFinishRun();
end;

procedure TFormAuth.CallBackRequestAuthorize();
var
  S: TStringList;
  JsonArray: TJSONArray;
  TmpJSONObject, JsonObject: TJSONObject;
begin
  FormMain.Debug('CallBackRequestAuthorize');
  FormMain.Debug(PortalAnswerJson);

  S := TStringList.Create;
  S.Add(PortalAnswerJson);
  try
    FJSONObject := TJSONObject.ParseJSONValue(S.Text) as TJSONObject;
  finally
    if Assigned(FJSONObject) then
    begin
      if FormMain.DeleteQuotes(FJSONObject.Get('TYPE').JsonValue.ToString) = 'ok' then
      begin
        OnSuccessAuthorize();
      end
      else
      begin
        OnFailAuthorize();
      end;
    end
    else
    begin
      FormMain.ShowNotify(AUTH_NOTYFY_TITLE, 'Ошибка чтения ответа сервера. Возможно указаны неверные параметры подключения.');
      FormMain.AppFailAuthRequest();
    end;
  end;
end;


procedure TFormAuth.EditLoginKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) = #13 then
  begin
    PreAuthorize();
  end;
end;

procedure TFormAuth.EditPasswordKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if chr(key) = #13 then
  begin
    PreAuthorize();
  end;
end;

procedure TFormAuth.ButtonAuthClick(Sender: TObject);
begin
  PreAuthorize();
end;

procedure TFormAuth.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  AppCanClose := True;
  FormMain.Close();
end;

procedure TFormAuth.FormCreate(Sender: TObject);
begin
  if NeedAuth then
  begin
    Visible := True;
  end;
end;

procedure TFormAuth.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFormAuth.FormShow(Sender: TObject);
begin
  Caption := AUTH_NOTYFY_TITLE;

  Width := 192;
  Height := 176;

  EditLogin.Text := PortalLogin;
end;

end.
