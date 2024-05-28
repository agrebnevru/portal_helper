unit UnitNotify;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TFormNotify = class(TForm)
    LabelDescription: TLabel;
    LabelTitle: TLabel;
    Image1: TImage;
    TimerHideForm: TTimer;
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerHideFormTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

Const
  WINDOWS_RIGHT_OFFSET = 15;
  WINDOWS_BOTTOM_OFFSET = 15;

var
  FormNotify: TFormNotify;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormNotify.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormNotify.FormCreate(Sender: TObject);
const
  CS_DROPSHADOW = $00020000;
begin
  Left:= Screen.WorkAreaWidth - FormNotify.Width - WINDOWS_RIGHT_OFFSET;
  Top:= Screen.WorkAreaHeight - FormNotify.Height - WINDOWS_BOTTOM_OFFSET;
  SetClassLong(Handle, GCL_STYLE, GetWindowLong(Handle, GCL_STYLE) or CS_DROPSHADOW);
end;

procedure TFormNotify.FormShow(Sender: TObject);
begin
  LabelTitle.Caption := NotifyTitle;
  LabelDescription.Caption := NotifyDescription;
  TimerHideForm.Enabled := True;
end;

procedure TFormNotify.Image1Click(Sender: TObject);
begin
  Close;
end;

procedure TFormNotify.TimerHideFormTimer(Sender: TObject);
begin
  TimerHideForm.Enabled := False;
  Hide();
end;

end.
