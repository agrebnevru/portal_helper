unit UnitSettings;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Registry;

type
  TFormSettings = class(TForm)
    PageControl: TPageControl;
    TabMain: TTabSheet;
    EditDomain: TEdit;
    LabelDomain: TLabel;
    RGProtocol: TRadioGroup;
    CheckBoxAppAutoRun: TCheckBox;
    CheckBoxShowLogForm: TCheckBox;
    TabUpdate: TTabSheet;
    LabelTimeUpdate: TLabel;
    CBTimeUpdate: TComboBox;
    GBWhatUpdate: TGroupBox;
    CBLenta: TCheckBox;
    CBSupport: TCheckBox;
    CBSupportSlaHigh: TCheckBox;
    CBShowFastLinks: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBoxAppAutoRunClick(Sender: TObject);
    procedure EditDomainChange(Sender: TObject);
    procedure RGProtocolClick(Sender: TObject);
    procedure CheckBoxShowLogFormClick(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBLentaClick(Sender: TObject);
    procedure CBSupportClick(Sender: TObject);
    procedure CBSupportSlaHighClick(Sender: TObject);
    procedure CBTimeUpdateChange(Sender: TObject);
    procedure CBShowFastLinksClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;
  ProtocolList: TStringList;

implementation

{$R *.dfm}

uses UnitMain;

procedure TFormSettings.CBLentaClick(Sender: TObject);
begin
  IniFile.WriteBool('SettingsUpdate', 'Lenta', CBLenta.Checked);
end;

procedure TFormSettings.CBShowFastLinksClick(Sender: TObject);
begin
  IniFile.WriteBool('SettingsMain', 'ShowFastLinks', CBShowFastLinks.Checked);
end;

procedure TFormSettings.CBSupportClick(Sender: TObject);
begin
  IniFile.WriteBool('SettingsUpdate', 'Support', CBSupport.Checked);
  CBSupportSlaHigh.Enabled := CBSupport.Checked;
end;

procedure TFormSettings.CBSupportSlaHighClick(Sender: TObject);
begin
  IniFile.WriteBool('SettingsUpdate', 'SupportSlaHigh', CBSupportSlaHigh.Checked);
end;

procedure TFormSettings.CBTimeUpdateChange(Sender: TObject);
begin
  IniFile.WriteInteger('SettingsUpdate', 'TimeUpdate', StrToInt(CBTimeUpdate.Items[CBTimeUpdate.ItemIndex]));
end;

procedure TFormSettings.CheckBoxAppAutoRunClick(Sender: TObject);
var
  Reg: TRegistry;
begin
  if CheckBoxAppAutoRun.Checked then
  begin
     Reg := TRegistry.Create;
     Reg.RootKey := HKEY_CURRENT_USER;
     Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false);
     Reg.WriteString('PortalHelper', Application.ExeName);
     Reg.Free;
  end
  else
  begin
     Reg := TRegistry.Create;
     Reg.RootKey := HKEY_CURRENT_USER;
     Reg.OpenKey('\SOFTWARE\Microsoft\Windows\CurrentVersion\Run', false);
     Reg.DeleteValue('PortalHelper');
     Reg.Free;
  end;
  IniFile.WriteBool('SettingsMain', 'AppAutoRun', CheckBoxAppAutoRun.Checked);
end;

procedure TFormSettings.CheckBoxShowLogFormClick(Sender: TObject);
begin
  IniFile.WriteBool('SettingsMain', 'ShowTestForm', CheckBoxShowLogForm.Checked);
end;

procedure TFormSettings.EditDomainChange(Sender: TObject);
begin
  IniFile.WriteString('SettingsMain', 'Domain', EditDomain.Text);
end;

procedure TFormSettings.FormCreate(Sender: TObject);
var
  i: Integer;
  Protocol: String;
begin
  ProtocolList := TStringList.Create;
  ProtocolList.Add('http');
  ProtocolList.Add('https');

  // protocol
  Protocol := IniFile.ReadString('SettingsMain', 'Protocol', '');
  for i := 0 to ProtocolList.Count-1 do
  begin
    RGProtocol.Items.Add(ProtocolList[i]);
    if Protocol = ProtocolList[i] then
      RGProtocol.ItemIndex := i;
  end;
end;

procedure TFormSettings.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = VK_ESCAPE then
    Close;
end;

procedure TFormSettings.FormShow(Sender: TObject);
var
  i: Integer;
  TmpProtocol: String;
  TmpTimeUpdate: Integer;
begin
  // Settings - Main
  // Application auto run
  CheckBoxAppAutoRun.Checked := IniFile.ReadBool('SettingsMain', 'AppAutoRun', False);
  // protocol
  TmpProtocol := IniFile.ReadString('SettingsMain', 'Protocol', '');
  for i := 0 to ProtocolList.Count - 1 do
  begin
    if ProtocolList[i] = TmpProtocol then
    begin
      RGProtocol.ItemIndex := i;
      Break;
    end;
  end;
  // domain
  EditDomain.Text := IniFile.ReadString('SettingsMain', 'Domain', '');
  // show fast links menu item
  CBShowFastLinks.Checked := IniFile.ReadBool('SettingsMain', 'ShowFastLinks', False);
  // Show log form
  CheckBoxShowLogForm.Checked := IniFile.ReadBool('SettingsMain', 'ShowTestForm', False);
  if PortalLogin <> USER_LOGIN_CAN_USE_TEST_FORM then
    CheckBoxShowLogForm.Enabled := False;

  // Settings - Update
  // time update
  TmpTimeUpdate := IniFile.ReadInteger('SettingsUpdate', 'TimeUpdate', 60);
  for i := 0 to CBTimeUpdate.Items.Count - 1 do
  begin
    if StrToInt(CBTimeUpdate.Items[i]) = TmpTimeUpdate then
    begin
      CBTimeUpdate.ItemIndex := i;
      Break;
    end;
  end;
  // lenta
  CBLenta.Checked := IniFile.ReadBool('SettingsUpdate', 'Lenta', False);
  // support
  CBSupport.Checked := IniFile.ReadBool('SettingsUpdate', 'Support', False);
  // suport sla high
  CBSupportSlaHigh.Checked := IniFile.ReadBool('SettingsUpdate', 'SupportSlaHigh', False);
end;

procedure TFormSettings.RGProtocolClick(Sender: TObject);
begin
  IniFile.WriteString('SettingsMain', 'Protocol', ProtocolList[RGProtocol.ItemIndex]);
end;

end.
