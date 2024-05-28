unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.ImageList,
  Vcl.ImgList, Vcl.ExtCtrls, Vcl.Menus, IdCookieManager, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Vcl.Buttons,
  RequestThreadFile, CheckNewVerThreadFile, Vcl.ComCtrls, System.JSON, IniFiles,
  shellapi;

type
  TProc = procedure of object;

  TFormMain = class(TForm)
    TrayIcon: TTrayIcon;
    Images: TImageList;
    TrayMenu: TPopupMenu;
    MIExit: TMenuItem;
    N1: TMenuItem;
    IdHTTP: TIdHTTP;
    IdCM: TIdCookieManager;
    MIAdd: TMenuItem;
    MIAddLenta: TMenuItem;
    MIAddTask: TMenuItem;
    MIAbout: TMenuItem;
    MISettings: TMenuItem;
    MIAddCheckList: TMenuItem;
    TimerSHowAuth: TTimer;
    NIUpdate: TMenuItem;
    MILog: TMenuItem;
    TimerGetUpdate: TTimer;
    MIUpdate: TMenuItem;
    TimerCheckUpdates: TTimer;
    MIFastLinks: TMenuItem;
    MImpStats: TMenuItem;
    procedure MIExitClick(Sender: TObject);
    procedure MIAboutClick(Sender: TObject);
    procedure MIAddTaskClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure TimerSHowAuthTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TrayIconDblClick(Sender: TObject);
    procedure MISettingsClick(Sender: TObject);
    procedure NIUpdateClick(Sender: TObject);
    procedure MILogClick(Sender: TObject);
    procedure TimerGetUpdateTimer(Sender: TObject);
    procedure MIUpdateClick(Sender: TObject);
    procedure TimerCheckUpdatesTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure AppFinishRun();
    procedure AppFailAuthRequest();
    procedure InitApp();
    procedure CreateDefaultSettingsFile();
    procedure ShowNotify(Title, Description: String);
    function XORcrypt(Text: String): String;
    function GetMyVersion(Formated: Boolean): String;
    function GetLogin(): String;
    function GetPassword(): String;
    procedure SaveLogin(Login: String);
    procedure SavePassword(Password: String);
    procedure SendRequest(RequestData: TStringList; ProcedureName: TProc);
    function DeleteQuotes(Str: String): String;
    procedure GetAllData();
    procedure CallBackRequestGetAllData();
    function GetUpdateServices(): String;
    procedure GetUpdateData();
    procedure PaintProjectsForMenu();
    procedure OnCheckListMenuItemClick(Sender: TObject);
    procedure PaintProjectsForFastLinks();
    procedure OnFastLinksMenuItemClick(Sender: TObject);
    procedure Debug(MessageString: String);
    procedure CheckNewVer();
    procedure CallBackCheckNewVer(Version: String);
    procedure GetUpdateTimer();
    procedure CallBackRequestGetUpdate();
  end;

Const
  ENCRIPTION_WORD = 'DONOTSTEALMYPASS';
  USER_LOGIN_CAN_USE_TEST_FORM = 'a.grebnev';
  URL_DOWNLOAD_LAST_APP_VER = 'http://portalhelper.imyie.ru/download/';
  MAIN_NOTYFY_TITLE = 'PortalHelper';

var
  FormMain: TFormMain;
  NeedAuth: Boolean;
  AppCanClose: Boolean;
  AppFirstRunFinish: Boolean;
  // Settings - Main
  SettingsSiteUrlProtocol: String;
  SettingsSiteUrlDomain: String;
  SettingsSiteUrlPath: String;
  SettingsSiteUrl: String;
  SettingsShowFastLinks: Boolean;
  // Settings - Update
  SettingsTimeUpdate: Integer;
  SettingsUpdateLenta: Boolean;
  SettingsUpdateSupport: Boolean;
  SettingsUpdateSupportSlaHigh: Boolean;
  // /Settings
  PortalAnswerJson: String;
  AllDataProjectList: TStringList;
  AllDataTeamList: TStringList;
  FJSONObject: TJSONObject;
  AppDir: String;
  SettingsIniFilePath: String;
  IniFile: TIniFile;
  PortalUserId: Integer;
  PortalLogin: String;
  PortalPassword: String;
  NotifyTitle: String;
  NotifyDescription: String;
  tmpString: String;

implementation

{$R *.dfm}

uses UnitAbout, UnitTest, UnitAddTaks, UnitNotify, UnitAuth,
  UnitAddTaskCheckList, UnitSettings;

procedure TFormMain.AppFinishRun();
begin
  TrayIcon.Hint := '';
  TrayIcon.PopupMenu := TrayMenu;
  TrayIcon.OnDblClick := nil;

  // TimerGetUpdate.Enabled := True;

  AppFirstRunFinish := True;
end;

procedure TFormMain.AppFailAuthRequest();
begin
  AppFinishRun();
  MIAdd.Enabled := False;
end;

procedure TFormMain.InitApp();
begin
  NeedAuth := False;
  AppDir := ExtractFileDir(Application.ExeName);
  SettingsIniFilePath := AppDir + '\settings.ini';
  IniFile := TIniFile.Create(SettingsIniFilePath);

  if not fileexists(SettingsIniFilePath) then
  begin
    CreateDefaultSettingsFile();
  end;

  // Main
  SettingsSiteUrlProtocol := IniFile.ReadString('SettingsMain', 'Protocol', 'http');
  SettingsSiteUrlDomain :=  IniFile.ReadString('SettingsMain', 'Domain', 'portal.redsign.ru');
  SettingsSiteUrlPath := IniFile.ReadString('SettingsMain', 'PathToScript', '/bitrix/imyie_portalhelper.php');
  SettingsSiteUrl := SettingsSiteUrlProtocol + '://' + SettingsSiteUrlDomain + SettingsSiteUrlPath;
  SettingsShowFastLinks := IniFile.ReadBool('SettingsMain', 'ShowFastLinks', False);

  // Update
  SettingsTimeUpdate := IniFile.ReadInteger('SettingsUpdate', 'TimeUpdate', 60);
  SettingsUpdateLenta := IniFile.ReadBool('SettingsUpdate', 'Lenta', False);
  SettingsUpdateSupport := IniFile.ReadBool('SettingsUpdate', 'Support', False);
  SettingsUpdateSupportSlaHigh := IniFile.ReadBool('SettingsUpdate', 'SupportSlaHigh', False);

  TimerGetUpdate.Interval := (SettingsTimeUpdate*1000);

  CheckNewVer();
end;

procedure TFormMain.CreateDefaultSettingsFile();
var
  ApplicationVersion: String;
begin
  ApplicationVersion := GetMyVersion(true);
  SaveLogin('');
  SavePassword('');

  // Main
  IniFile.WriteString('Main', 'Version', ApplicationVersion);
  IniFile.WriteString('SettingsMain', 'Protocol', 'http');
  IniFile.WriteString('SettingsMain', 'Domain', 'portal.redsign.ru');
  IniFile.WriteString('SettingsMain', 'PathToScript', '/bitrix/imyie_portalhelper.php');
  IniFile.WriteBool('SettingsMain', 'AppAutoRun', False);
  IniFile.WriteBool('SettingsMain', 'ShowTestForm', False);
  IniFile.WriteBool('SettingsMain', 'ShowFastLinks', False);

  // Update
  IniFile.WriteInteger('SettingsUpdate', 'TimeUpdate', 60);
  IniFile.WriteBool('SettingsUpdate', 'Lenta', False);
  IniFile.WriteBool('SettingsUpdate', 'Support', False);
  IniFile.WriteBool('SettingsUpdate', 'SupportSlaHigh', False);
end;

procedure TFormMain.ShowNotify(Title, Description: String);
begin
  {NotifyTitle := Title;
  NotifyDescription := Description;
  FormNotify.Show();}
  TrayIcon.Visible := True;
  TrayIcon.BalloonTitle := Title;
  TrayIcon.BalloonFlags := bfInfo;
  TrayIcon.BalloonHint := Description;
  TrayIcon.ShowBalloonHint;
end;

procedure TFormMain.TimerCheckUpdatesTimer(Sender: TObject);
begin
  Debug('TimerCheckUpdatesTimer');
  TimerCheckUpdates.Enabled := False;
  CheckNewVer();
end;

procedure TFormMain.TimerGetUpdateTimer(Sender: TObject);
begin
  GetUpdateTimer();
end;

procedure TFormMain.GetUpdateTimer();
var
  PostData: TStringList;
  Services4Update: String;
begin
  PostData := TStringList.Create;
  PostData.Add('method=getupdate');

  Services4Update := GetUpdateServices();
  if Services4Update <> '' then
  begin
    PostData.Add(Services4Update);
    Debug(PostData.Text);
    FormMain.SendRequest(PostData, FormMain.CallBackRequestGetUpdate);
  end;
end;

procedure TFormMain.CallBackRequestGetUpdate();
begin
  Debug('CallBackRequestGetUpdate');
end;

procedure TFormMain.TimerSHowAuthTimer(Sender: TObject);
begin
  FormAuth.Show();
  TimerSHowAuth.Enabled := False;
end;

procedure TFormMain.TrayIconDblClick(Sender: TObject);
begin
  TrayIcon.Visible := True;
  TrayIcon.BalloonHint := 'Я загружаюсь';
  TrayIcon.ShowBalloonHint;
end;

function TFormMain.XORcrypt(Text: String): String;
var
  tmpString: string;
  i, p4: integer;
begin
  p4 := 0;
  tmpString := '';
  for i := 1 to Length(Text) do
  begin
    tmpString := tmpString + chr(ord(Text[i]) xor ord(ENCRIPTION_WORD[p4]));
    if p4 = (Length(ENCRIPTION_WORD) - 2) then
      p4 := 0
    else
      p4 := p4 + 1;
  end;
  Result := tmpString;
end;

function TFormMain.GetMyVersion(Formated: Boolean): String;
type
  TVerInfo = Packed Record
    Nevazhno: array [0 .. 47] of Byte;
    Minor, Major, Build, Release: Word;
  end;
var
  s: TResourceStream;
  v: TVerInfo;
begin
  Result := '';
  try
    s := TResourceStream.Create(HInstance, '#1', RT_VERSION);
    if s.Size > 0 then
    begin
      s.Read(v, SizeOf(v));
      if Formated = true then
      begin
        Result := Format('%d.%d.%d.%d', [v.Major, v.Minor, v.Release, v.Build]);
      end
      else
      begin
        Result := IntToStr(v.Major) + IntToStr(v.Minor) + IntToStr(v.Release) +
          IntToStr(v.Build);
      end;
    end;
    s.Free;
  except
    //
  end;
end;

function TFormMain.GetLogin(): String;
begin
  Result := IniFile.ReadString('Authorization', 'Login', '');
end;

procedure TFormMain.SaveLogin(Login: String);
begin
  IniFile.WriteString('Authorization', 'Login', Login);
  PortalLogin := GetLogin();
end;

function TFormMain.GetPassword(): String;
begin
  Result := XORcrypt(IniFile.ReadString('Authorization', 'Password', ''));
end;

procedure TFormMain.SavePassword(Password: String);
begin
  IniFile.WriteString('Authorization', 'Password', XORcrypt(Password));
  PortalPassword := GetPassword();
end;

procedure TFormMain.SendRequest(RequestData: TStringList; ProcedureName: TProc);
var
  RequestThread: TRequestThread;
begin
  RequestThread := TRequestThread.Create(RequestData, ProcedureName);
  RequestThread.Priority := tpLower;
end;

function TFormMain.DeleteQuotes(Str: String): String;
begin
  Delete(Str, 1, 1);
  Delete(Str, Length(Str), 1);
  Result := Str;
end;

procedure TFormMain.GetAllData();
var
  PostData: TStringList;
  Services4Update: String;
begin
  PostData := TStringList.Create;
  PostData.Add('method=getdata');

  Services4Update := GetUpdateServices();
  if Services4Update <> '' then
  begin
    PostData.Add('addUpdate=y');
    PostData.Add(Services4Update);
  end;

  FormMain.SendRequest(PostData, FormMain.CallBackRequestGetAllData);
end;

function TFormMain.GetUpdateServices(): String;
var
  PostData: TStringList;
  UpdateServices: String;
begin
  if SettingsUpdateLenta or SettingsUpdateSupport then
  begin
    UpdateServices := 'services4update=';

    if SettingsUpdateLenta then
    begin
      UpdateServices := UpdateServices + 'lenta|';
    end;

    if SettingsUpdateSupport then
    begin
      if not SettingsUpdateSupportSlaHigh then
      begin
        UpdateServices := UpdateServices + 'support|';
      end
      else
      begin
        UpdateServices := UpdateServices + 'supportslahigh|';
      end;
    end;
  end;

  Result := UpdateServices;
end;

procedure TFormMain.GetUpdateData();
var
  PostData: TStringList;
begin
  if not SettingsUpdateLenta and not SettingsUpdateSupport then
  begin
    Exit;
  end;

  PostData := TStringList.Create;
  PostData.Add('method=getupdate');

  if not SettingsUpdateLenta and not SettingsUpdateSupport then
  begin
    PostData.Add('addUpdate=getdata');
  end;

  FormMain.SendRequest(PostData, FormMain.CallBackRequestGetAllData);
end;

procedure TFormMain.CallBackRequestGetAllData();
var
  i: integer;
  tmpString: String;
  JsonArray: TJSONArray;
  TmpJSONObject, ArrayProjectJSONObject: TJSONObject;
begin
  FJSONObject := TJSONObject.ParseJSONValue(PortalAnswerJson) as TJSONObject;
  if not Assigned(FJSONObject) then
  begin
    ShowNotify('Получение данных', 'Ошибка разбора json.');
    Exit;
  end;

  Debug('TYPE REQUEST = ' + DeleteQuotes(FJSONObject.Get('TYPE')
    .JsonValue.ToString));
  if DeleteQuotes(FJSONObject.Get('TYPE').JsonValue.ToString) <> 'ok' then
  begin
    ShowNotify('Получение данных', 'Ошибка ответа сервера.');
    Exit;
  end;

  // projects
  TmpJSONObject := FJSONObject.Get('PROJECTS').JsonValue as TJSONObject;
  AllDataProjectList := TStringList.Create;
  for i := 0 to TmpJSONObject.Size - 1 do
  begin
    ArrayProjectJSONObject := TmpJSONObject.Get(TmpJSONObject.Get(i)
      .JsonString.Value).JsonValue as TJSONObject;
    AllDataProjectList.AddPair(DeleteQuotes(ArrayProjectJSONObject.Get('ID')
      .JsonValue.ToString), DeleteQuotes(ArrayProjectJSONObject.Get('NAME')
      .JsonValue.ToString));
  end;

  // company team
  TmpJSONObject := FJSONObject.Get('TEAM').JsonValue as TJSONObject;
  AllDataTeamList := TStringList.Create;
  for i := 0 to TmpJSONObject.Size - 1 do
  begin
    ArrayProjectJSONObject := TmpJSONObject.Get(TmpJSONObject.Get(i)
      .JsonString.Value).JsonValue as TJSONObject;
    AllDataTeamList.AddPair(DeleteQuotes(ArrayProjectJSONObject.Get('ID').JsonValue.ToString),
      DeleteQuotes(ArrayProjectJSONObject.Get('NAME').JsonValue.ToString) +
      DeleteQuotes(ArrayProjectJSONObject.Get('LAST_NAME').JsonValue.ToString) +
      ' (' + DeleteQuotes(ArrayProjectJSONObject.Get('LOGIN')
      .JsonValue.ToString) + ')');
  end;

  PaintProjectsForMenu();
  PaintProjectsForFastLinks();
  AppFinishRun();
end;

procedure TFormMain.PaintProjectsForMenu();
var
  NewItem: TMenuItem;
  i: Integer;
begin
  for i := 0 to AllDataProjectList.Count - 1 do
  begin
    NewItem := TMenuItem.Create(MIAddCheckList);
    NewItem.Caption := AllDataProjectList.ValueFromIndex[i];
    NewItem.Name := 'MIAddCheckList_Project' + IntToStr(i);
    NewItem.OnClick:= OnCheckListMenuItemClick;
    NewItem.Tag := i;
    MIAddCheckList.Insert(i, NewItem);
  end;
end;

procedure TFormMain.OnCheckListMenuItemClick(Sender: TObject);
var
  ProjectID, Index: Integer;
begin
  Index := (TMenuItem(Sender).Tag);
  ProjectID := StrToInt(AllDataProjectList.Names[Index]);
  FormAddTaskCheckList.SetProjectId(ProjectID);
  FormAddTaskCheckList.Show();
end;

procedure TFormMain.PaintProjectsForFastLinks();
var
  NewItem: TMenuItem;
  i: Integer;
begin
  if SettingsShowFastLinks then
  begin
    for i := 0 to AllDataProjectList.Count - 1 do
    begin
      NewItem := TMenuItem.Create(MIFastLinks);
      NewItem.Caption := 'Задача по ' + AllDataProjectList.ValueFromIndex[i];
      NewItem.Name := 'MIFastLink_Project' + IntToStr(i);
      NewItem.OnClick:= OnFastLinksMenuItemClick;
      NewItem.Tag := i;
      MIFastLinks.Insert(i, NewItem);
    end;
  end
  else
  begin
    MIFastLinks.Visible := False;
  end;
end;

procedure TFormMain.OnFastLinksMenuItemClick(Sender: TObject);
var
  ProjectID, Index: Integer;
  url: String;
begin
  Index := (TMenuItem(Sender).Tag);
  ProjectID := StrToInt(AllDataProjectList.Names[Index]);
  url := SettingsSiteUrl + '?method=fastlinks&projectid=' + IntToStr(ProjectID);
  ShellExecute(Handle, 'open', PChar(url), nil, nil, SW_SHOW);
end;

procedure TFormMain.NIUpdateClick(Sender: TObject);
begin
  ShellExecute(Handle, 'open', PChar(URL_DOWNLOAD_LAST_APP_VER), nil, nil, SW_SHOW);
end;

procedure TFormMain.MIAboutClick(Sender: TObject);
begin
  FormAbout.Show;
end;

procedure TFormMain.MIAddTaskClick(Sender: TObject);
begin
  FormAddTask.Show();
end;

procedure TFormMain.MIExitClick(Sender: TObject);
begin
  AppCanClose := true;
  FormMain.Close();
end;

procedure TFormMain.MILogClick(Sender: TObject);
begin
  if MILog.Checked then
  begin
    FormTest.Close;
    MILog.Checked := FormTest.Visible;
  end
  else
  begin
    FormTest.Show;
    MILog.Checked := FormTest.Visible;
  end;
end;

procedure TFormMain.MISettingsClick(Sender: TObject);
begin
  FormSettings.Show();
end;

procedure TFormMain.MIUpdateClick(Sender: TObject);
begin
  GetUpdateTimer();
end;

procedure TFormMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := AppCanClose;
  if not CanClose and Visible then
    Hide();
end;

procedure TFormMain.FormCreate(Sender: TObject);
begin
  AppFirstRunFinish := False;
  InitApp();
end;

procedure TFormMain.Debug(MessageString: String);
var
  today: TDateTime;
begin
  today := Now;
  if Assigned(FormTest) then
  begin
    FormTest.MemoLog.Lines.Add(DateToStr(today) + ' ' + TimeToStr(today) + ' = ' + MessageString);
    FormTest.MemoLog.Lines.Add('====================');
  end;
end;

procedure TFormMain.CheckNewVer();
var
  AppCheckNewVer: TAppCheckNewVer;
begin
  AppCheckNewVer := TAppCheckNewVer.Create();
  AppCheckNewVer.Priority := tpLower;
end;

procedure TFormMain.CallBackCheckNewVer(Version: String);
var
  ApplicationVersion, ServerVersion: Integer;
begin
  ApplicationVersion := StrToInt(GetMyVersion(false));
  ServerVersion := StrToInt(Version);

  Debug('ServerVersion = ' + IntToStr(ServerVersion));
  Debug('ApplicationVersion = ' + IntToStr(ApplicationVersion));

  if (ServerVersion > 0) and (ServerVersion > ApplicationVersion) then
  begin
    MIAdd.Enabled := False;
    NIUpdate.Visible := True;
    FormMain.ShowNotify(MAIN_NOTYFY_TITLE, 'Чтобы продолжать пользоваться программой, необходимо скачать обновление.');
    if not AppFirstRunFinish then
    begin
      Debug('fufufu');
      TimerCheckUpdates.Enabled := True;
      AppFinishRun();
    end;
  end
  else
  begin
    FormAuth.AuthAfterAppRun();
  end;
end;

end.
