unit UnitMpStats;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Menus, Data.Win.ADODB;

type
  TFormMpStats = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    MIMpStatsActions: TMenuItem;
    MIMpStatsActionsGetAll: TMenuItem;
    MpStatsMainPageControl: TPageControl;
    MpStatsTabSheetAll: TTabSheet;
    MpStatsTabSheetParthnersList: TTabSheet;
    MpStatsTabSheetStats: TTabSheet;
    PanelAllMain: TPanel;
    DBGridAll: TDBGrid;
    PanelAllFilter: TPanel;
    PanelAllFilterLeft: TPanel;
    DateTimePickerAllFrom: TDateTimePicker;
    StaticTextALLDateFrom: TStaticText;
    StaticTextAllDateTo: TStaticText;
    DateTimePickerAllTo: TDateTimePicker;
    PanelAllFilterRight: TPanel;
    ButtonAllFilter: TButton;
    ButtonAllGetData: TButton;
    PanelPLFilter: TPanel;
    PanelPLFilterLeft: TPanel;
    StaticTextPLParCode: TStaticText;
    StaticTextPLPartName: TStaticText;
    EditPLParCode: TEdit;
    EditPLParName: TEdit;
    Panel1: TPanel;
    ButtonPLFilter: TButton;
    ButtonPLGetData: TButton;
    PanelPLMain: TPanel;
    DBGridPL: TDBGrid;
    PageControlStats: TPageControl;
    TSFullStats: TTabSheet;
    DBGridFS: TDBGrid;
    PanelFSFilter: TPanel;
    TSAutoGet: TTabSheet;
    PCAutoGet: TPageControl;
    TabSheetAutoGetPartnersInfo: TTabSheet;
    TabSheetAutoGetModulesInfo: TTabSheet;
    DBGridAG: TDBGrid;
    PanelAGFilter: TPanel;
    TSTopMP: TTabSheet;
    DBGridTopMP: TDBGrid;
    PanelTopMPFilter: TPanel;
    MpStatsADOConn: TADOConnection;
    MpStatsDataSourceAll: TDataSource;
    MpStatsDataSourcePL: TDataSource;
    MpStatsDataSourceAG: TDataSource;
    MpStatsDataSourceTopMP: TDataSource;
    MpStatsADOQueryAll: TADOQuery;
    MpStatsADOQueryPL: TADOQuery;
    MpStatsADOQueryAG: TADOQuery;
    MpStatsADOQueryTopMP: TADOQuery;
    MpStatsPopMenuAll: TPopupMenu;
    PMAll_Delete: TMenuItem;
    MpStatsPopMenuPL: TPopupMenu;
    PMPL_ShowModuleList: TMenuItem;
    PMPL_MLInfoGetData: TMenuItem;
    N4: TMenuItem;
    PMPL_ShowInfo: TMenuItem;
    PMPL_PLInfoGetData: TMenuItem;
    PMPL_GoToSite: TMenuItem;
    PMPL_GoToPartnerCard: TMenuItem;
    N5: TMenuItem;
    PMPL_Delete: TMenuItem;
    MpStatsPopMenuAG: TPopupMenu;
    PMAG_ModuleInfo: TMenuItem;
    N6: TMenuItem;
    PMAG_Refresh: TMenuItem;
    N3: TMenuItem;
    PMAG_Delete: TMenuItem;
    MpStatsPopupMenuTopMP: TPopupMenu;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMpStats: TFormMpStats;

implementation

{$R *.dfm}

end.
