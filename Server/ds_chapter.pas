unit ds_chapter;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, 
  Datasnap.DSAuth, Datasnap.DSProviderDataModuleAdapter, Datasnap.Provider,
  Data.DB, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.Client, FireDAC.Comp.DataSet;

type
  [TRoleAuth('user,admin', 'download')]
  TdsChapter = class(TDSServerModule)
    ChapterTab: TDataSetProvider;
    ListTasks: TDataSetProvider;
    ChapterTextTab: TDataSetProvider;
    FDTransaction1: TFDTransaction;
    Chapter: TFDTable;
    ChapterText: TFDTable;
    ListTasksQry: TFDQuery;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

implementation

uses
  m_db;

{%CLASSGROUP 'System.Classes.TPersistent'}

{$R *.dfm}

end.

