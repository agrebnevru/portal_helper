unit UnitAbout;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TFormAbout = class(TForm)
    ImageLogo: TImage;
    LabelLogo: TLabel;
    MemoAbout: TMemo;
    BtnClose: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelVersion: TLabel;
    procedure BtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    procedure CreateParams(VAR Params: TCreateParams);
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses UnitMain;

{$R *.dfm}

procedure TFormAbout.CreateParams(VAR Params: TCreateParams);
begin
  Inherited CreateParams(Params);
  WITH Params DO
  ExStyle := ExStyle OR WS_EX_APPWINDOW;
end;

procedure TFormAbout.BtnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TFormAbout.FormCreate(Sender: TObject);
begin
  LabelVersion.Caption := FormMain.GetMyVersion(true);
end;

procedure TFormAbout.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

end.
