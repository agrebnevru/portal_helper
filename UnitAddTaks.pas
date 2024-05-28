unit UnitAddTaks;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  System.JSON;

type
  TFormAddTask = class(TForm)
    PanelAllAdd: TPanel;
    PanelButtons: TPanel;
    BtnOk: TBitBtn;
    BtnCancel: TBitBtn;
    PanelData: TPanel;
    MemoTaskDescription: TMemo;
    EditTaskTitle: TEdit;
    PanelWithComboBox: TPanel;
    CBProject: TComboBox;
    CMResponsible: TComboBox;
    BtnOkPlus: TBitBtn;
    procedure BtnCancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnOkClick(Sender: TObject);
    procedure EditTaskTitleKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure MemoTaskDescriptionKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnOkPlusClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(VAR Params: TCreateParams);
  public
    { Public declarations }
    procedure KeyPressForRequest(Key: Word;
  Shift: TShiftState);
    procedure PreAddTask();
    procedure AddTaskRequest();
    procedure OnSuccessAddTask();
    procedure OnFailAddTask();
    procedure OnFailAnswerAddTask();
    procedure CallBackRequestAddTask();
  end;

Const
  ADD_TASK_NOTYFY_TITLE = 'Новая задача';

var
  FormAddTask: TFormAddTask;
  NeedReOpen: Boolean;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormAddTask.CreateParams(VAR Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  WITH Params DO
  ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TFormAddTask.KeyPressForRequest(Key: Word;
  Shift: TShiftState);
begin
  if ([ssCtrl] = Shift) and (Key = VK_RETURN) then
  begin
    PreAddTask();
  end
  else if ([ssShift] = Shift) and (Key = VK_RETURN) then
  begin
    NeedReOpen := True;
    PreAddTask();
  end;
end;

procedure TFormAddTask.MemoTaskDescriptionKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  KeyPressForRequest(Key, Shift);
end;

procedure TFormAddTask.PreAddTask();
begin
  FormMain.Debug('PreAddTask');

  if not BtnOk.Enabled then
  begin
    FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE,
      'Запрос к серверу уже идет. Подождите немного.');
    Exit;
  end;

  if EditTaskTitle.Text = '' then
  begin
    FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE,
      'Вы должны обязательно указать название задачи перед добавлением.');
    Exit;
  end;

  if CBProject.ItemIndex < 1 then
  begin
    FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE,
      'Вы должны обязательно выбрать проект перед добавлением задачи.');
    Exit;
  end;

  if CMResponsible.ItemIndex < 1 then
  begin
    FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE,
      'Вы должны обязательно выбрать ответственного перед добавлением задачи.');
    Exit;
  end;

  BtnOk.Enabled := False;

  AddTaskRequest();
end;

procedure TFormAddTask.AddTaskRequest();
var
  PostData: TStringList;
  ProjectID, ResponsibleID: String;
begin
  FormMain.Debug('AddTaskRequest');
  ProjectID := AllDataProjectList.Names[(CBProject.ItemIndex - 1)];
  ResponsibleID := AllDataTeamList.Names[(CMResponsible.ItemIndex - 1)];
  PostData := TStringList.Create;
  PostData.Add('method=addtask');
  PostData.Add('title=' + EditTaskTitle.Text);
  PostData.Add('projectid=' + ProjectID);
  PostData.Add('responsibleid=' + ResponsibleID);
  PostData.Add('description=' + MemoTaskDescription.Lines.Text);

  FormMain.SendRequest(PostData, FormAddTask.CallBackRequestAddTask);
end;

procedure TFormAddTask.OnSuccessAddTask();
begin
  FormMain.Debug('OnSuccessAddTask');
  FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE, 'Задача добавлена.');

  BtnOk.Enabled := True;
  if not NeedReOpen then
  begin
    Hide();
  end
  else
  begin
    EditTaskTitle.Text := '';
    MemoTaskDescription.Clear;
  end;
end;

procedure TFormAddTask.OnFailAddTask();
begin
  FormMain.Debug('OnFailAddTask');
  FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE, FormMain.DeleteQuotes(FJSONObject.Get('MESSAGE').JsonValue.ToString));

  BtnOk.Enabled := False;
end;

procedure TFormAddTask.OnFailAnswerAddTask();
begin
  FormMain.Debug('OnFailAnswerAddTask');
  FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE, 'Получен некорректный ответ от сервера.');

  BtnOk.Enabled := False;
end;

procedure TFormAddTask.CallBackRequestAddTask();
begin
  FormMain.Debug('CallBackRequestAddTask');

  try
    FJSONObject := TJSONObject.ParseJSONValue(PortalAnswerJson) as TJSONObject;
  finally
    if Assigned(FJSONObject) then
    begin
      if FormMain.DeleteQuotes(FJSONObject.Get('TYPE').JsonValue.ToString) = 'ok' then
      begin
        OnSuccessAddTask();
      end
      else
      begin
        OnFailAddTask();
      end;
    end
    else
    begin
      BtnOk.Enabled := True;
      FormMain.ShowNotify(ADD_TASK_NOTYFY_TITLE, 'Ошибка чтения ответа сервера.');
    end;
  end;

  NeedReOpen := False;
end;

procedure TFormAddTask.EditTaskTitleKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  KeyPressForRequest(Key, Shift);
end;

procedure TFormAddTask.BtnOkPlusClick(Sender: TObject);
begin
  NeedReOpen := False;
  PreAddTask();
end;

procedure TFormAddTask.BtnCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAddTask.BtnOkClick(Sender: TObject);
begin
  PreAddTask();
end;

procedure TFormAddTask.FormCreate(Sender: TObject);
begin
  NeedReOpen := False;
end;

procedure TFormAddTask.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFormAddTask.FormShow(Sender: TObject);
var
  i, Offset: Integer;
begin
  Caption := ADD_TASK_NOTYFY_TITLE;

  Offset := 10;
  Top := Round(Screen.WorkAreaHeight - Height - Offset);
  Left := Round(Screen.WorkAreaWidth - Width - Offset);

  // projects
  CBProject.Items.BeginUpdate;
  for i := 0 to AllDataProjectList.Count - 1 do
  begin
    CBProject.Items.Add(AllDataProjectList.ValueFromIndex[i]);
  end;
  CBProject.Items.EndUpdate;

  // company team
  CMResponsible.Items.BeginUpdate;
  for i := 0 to AllDataTeamList.Count - 1 do
  begin
    CMResponsible.Items.Add(AllDataTeamList.ValueFromIndex[i]);
  end;
  CMResponsible.Items.EndUpdate;
end;

end.
