program portal.helper;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  RequestThreadFile in 'RequestThreadFile.pas',
  UnitAbout in 'UnitAbout.pas' {FormAbout},
  UnitTest in 'UnitTest.pas' {FormTest},
  UnitAddTaks in 'UnitAddTaks.pas' {FormAddTask},
  UnitNotify in 'UnitNotify.pas' {FormNotify},
  UnitAuth in 'UnitAuth.pas' {FormAuth},
  UnitAddTaskCheckList in 'UnitAddTaskCheckList.pas' {FormAddTaskCheckList},
  UnitSettings in 'UnitSettings.pas' {FormSettings},
  CheckNewVerThreadFile in 'CheckNewVerThreadFile.pas',
  UnitMpStats in 'UnitMpStats.pas' {FormMpStats};

{$R *.res}

begin
  Application.Initialize;
  Application.ShowMainForm := False;
  Application.Title := 'PortalHelper';
  Application.CreateForm(TFormMain, FormMain);
  Application.CreateForm(TFormAuth, FormAuth);
  Application.CreateForm(TFormAbout, FormAbout);
  Application.CreateForm(TFormTest, FormTest);
  Application.CreateForm(TFormAddTask, FormAddTask);
  Application.CreateForm(TFormNotify, FormNotify);
  Application.CreateForm(TFormAddTaskCheckList, FormAddTaskCheckList);
  Application.CreateForm(TFormSettings, FormSettings);
  Application.CreateForm(TFormMpStats, FormMpStats);
  Application.Run;
end.
