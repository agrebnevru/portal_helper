unit UnitTest;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, System.JSON;

type
  TFormTest = class(TForm)
    MemoLog: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormTest: TFormTest;

implementation

uses UnitMain, UnitNotify;

{$R *.dfm}

procedure TFormTest.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FormMain.MILog.Checked := False;
end;

procedure TFormTest.FormCreate(Sender: TObject);
var
  ShowTestForm: Boolean;
begin
  if PortalLogin = '' then
    PortalLogin := FormMain.GetLogin();

  ShowTestForm := IniFile.ReadBool('SettingsMain', 'ShowTestForm', False);

  if ShowTestForm and (PortalLogin = USER_LOGIN_CAN_USE_TEST_FORM) then
  begin
    Visible := True;
    FormMain.MILog.Visible := Visible;
    FormMain.MILog.Checked := Visible;
  end;
end;

end.
