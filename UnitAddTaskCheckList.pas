unit UnitAddTaskCheckList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons, System.JSON,
  Vcl.ComCtrls;

type
  TFormAddTaskCheckList = class(TForm)
    PanelAllAdd: TPanel;
    PanelData: TPanel;
    EditTaskCheckListTitle: TEdit;
    PanelButtons: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    LabelProject: TLabel;
    LabelProjectName: TLabel;
    BtnOkPlus: TBitBtn;
    procedure BtnCancelClick(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure EditTaskCheckListTitleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(VAR Params: TCreateParams);
  public
    { Public declarations }
    procedure PreAddTaskCheckList();
    procedure AddTaskCheckListRequest();
    procedure OnSuccessAddTaskCheckList();
    procedure OnFailAddTaskCheckList();
    procedure OnFailAnswerAddTaskCheckList();
    procedure CallBackRequestAddTaskCheckList();
    procedure SetProjectId(ProjID: Integer);
  end;

Const
  ADD_TASK_CHECK_LIST_NOTYFY_TITLE = 'Новый чек-лист';

var
  FormAddTaskCheckList: TFormAddTaskCheckList;
  ProjectID: String;
  NeedReOpen: Boolean;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormAddTaskCheckList.CreateParams(VAR Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  WITH Params DO
  ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TFormAddTaskCheckList.PreAddTaskCheckList();
begin
  FormMain.Debug('PreAddTaskCheckList');

  if not BtnOk.Enabled then
  begin
    FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE,
      'Запрос к серверу уже идет. Подождите немного.');
    Exit;
  end;

  if EditTaskCheckListTitle.Text = '' then
  begin
    FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE,
      'Вы должны обязательно указать текст чек-листа перед добавлением.');
    Exit;
  end;

  BtnOk.Enabled := False;

  AddTaskCheckListRequest();
end;

procedure TFormAddTaskCheckList.AddTaskCheckListRequest();
var
  PostData: TStringList;
begin
  FormMain.Debug('AddTaskCheckListRequest');
  PostData := TStringList.Create;
  PostData.Add('method=addtaskchecklist');
  PostData.Add('title=' + EditTaskCheckListTitle.Text);
  PostData.Add('projectid=' + ProjectID);

  FormMain.SendRequest(PostData, FormAddTaskCheckList.CallBackRequestAddTaskCheckList);
end;

procedure TFormAddTaskCheckList.OnSuccessAddTaskCheckList();
begin
  FormMain.Debug('OnSuccessAddTaskCheckList');
  FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE, 'Чек-лист добавлен.');

  BtnOk.Enabled := True;
  if not NeedReOpen then
  begin
    Hide();
  end;
  EditTaskCheckListTitle.Text := '';
end;

procedure TFormAddTaskCheckList.OnFailAddTaskCheckList();
begin
  FormMain.Debug('OnFailAddTaskCheckList');
  FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE, FormMain.DeleteQuotes(FJSONObject.Get('MESSAGE').JsonValue.ToString));

  BtnOk.Enabled := True;
end;

procedure TFormAddTaskCheckList.OnFailAnswerAddTaskCheckList();
begin
  FormMain.Debug('OnFailAnswerAddTask');
  FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE, 'Получен некорректный ответ от сервера.');

  BtnOk.Enabled := True;
end;

procedure TFormAddTaskCheckList.CallBackRequestAddTaskCheckList();
begin
  FormMain.Debug('CallBackRequestAddTask');

  try
    FJSONObject := TJSONObject.ParseJSONValue(PortalAnswerJson) as TJSONObject;
  finally
    if Assigned(FJSONObject) then
    begin
      if FormMain.DeleteQuotes(FJSONObject.Get('TYPE').JsonValue.ToString) = 'ok' then
      begin
        OnSuccessAddTaskCheckList();
      end
      else
      begin
        OnFailAddTaskCheckList();
      end;
    end
    else
    begin
      BtnOk.Enabled := True;
      FormMain.ShowNotify(ADD_TASK_CHECK_LIST_NOTYFY_TITLE, 'Ошибка чтения ответа сервера.');
    end;
  end;

  NeedReOpen := False;
end;

procedure TFormAddTaskCheckList.SetProjectId(ProjID: Integer);
begin
  ProjectID := IntToStr(ProjID);
end;

procedure TFormAddTaskCheckList.EditTaskCheckListTitleKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if ([ssCtrl] = Shift) and (Key = VK_RETURN) then
  begin
    PreAddTaskCheckList();
  end
  else if ([ssShift] = Shift) and (Key = VK_RETURN) then
  begin
    NeedReOpen := True;
    PreAddTaskCheckList();
  end;
end;

procedure TFormAddTaskCheckList.FormCreate(Sender: TObject);
begin
  NeedReOpen := False;
end;

procedure TFormAddTaskCheckList.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFormAddTaskCheckList.FormShow(Sender: TObject);
var
  i, Offset: Integer;
begin
  Caption := ADD_TASK_CHECK_LIST_NOTYFY_TITLE;

  Offset := 10;
  Top := Round(Screen.WorkAreaHeight - Height - Offset);
  Left := Round(Screen.WorkAreaWidth - Width - Offset);

  for i := 0 to AllDataProjectList.Count-1 do
  begin
    if (StrToInt(ProjectID) = StrToInt(AllDataProjectList.Names[i])) then
    begin
      LabelProjectName.Caption := AllDataProjectList.ValueFromIndex[i];
      break;
    end;
  end;

  FormMain.Debug(ProjectID);
end;

procedure TFormAddTaskCheckList.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAddTaskCheckList.BtnOkClick(Sender: TObject);
begin
  PreAddTaskCheckList();
end;

end.
