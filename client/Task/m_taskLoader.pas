unit m_taskLoader;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Datasnap.DBClient,
  Datasnap.DSConnect, i_taskEdit, Vcl.Controls, xsd_TaskData;

type
  TTaskLoaderMod = class(TDataModule)
    DSProviderConnection1: TDSProviderConnection;
    GetTAQry: TClientDataSet;
    TaskTab: TClientDataSet;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);

  private
    m_taid  : integer;
    m_form  : ITaskForm;
    m_tc    : ITaskContainer;
    m_xList : IXMLList;
    m_style : ITaskStyle;

    function loadData( dataset    : TClientDataset )  : boolean; overload;
    function loadData( st         : TStream )         : boolean; overload;

    function saveDataToStream(st: TStream): boolean;
  public
    function load( taid : integer ) : boolean;
    function SysLoad( clid : string ) : boolean;

    property TaskContainer  : ITaskContainer  read m_tc     write m_tc;
    property Taskform       : ITaskForm       read m_form   write m_form;
    property TaskStyle      : ITaskStyle      read m_style  write m_style;

    property TaskData       : IXMLList        read m_xList  write m_xList;

    function BuildForm( owner : TControl) : ITaskForm;

    function saveFormData : boolean;

    procedure clearData;
  end;

var
  TaskLoaderMod: TTaskLoaderMod;

implementation

uses
  m_glob_client, u_taskForm2XML, System.Variants, u_templateCache;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TTaskLoaderMod.clearData;
begin
  m_taid  := -1;
  if Assigned(m_tc) then
    m_tc.release;
  m_tc    := NIL;
  m_form  := NIL;
  m_xList := NIL;
  m_style := NIL;

end;

procedure TTaskLoaderMod.DataModuleCreate(Sender: TObject);
begin
  DSProviderConnection1.SQLConnection := GM.SQLConnection1;
  m_form  := NIL;
  m_tc    := NIL;
  m_xList := NIL;
  m_style := NIL;
  m_taid  := -1;
end;

procedure TTaskLoaderMod.DataModuleDestroy(Sender: TObject);
begin
  m_form  := NIL;
  m_tc    := NIL;
  m_xList := NIL;
  m_style := NIL;
end;

function TTaskLoaderMod.BuildForm(owner: TControl): ITaskForm;
begin
  if Assigned(m_form) then begin
    m_form.Base.Control := owner;
    m_form.Base.build;
    m_form.Base.clearContent(true);
  end;
  Result := m_form;
end;

function TTaskLoaderMod.load(taid: integer ): boolean;
begin
  m_taid  := taid;
  m_tc    := NIL;
  m_xList := NIL;

  GetTAQry.ParamByName('TA_ID').AsInteger := taid;
  GetTAQry.Open;

  loadData(GetTAQry);

  m_tc    := TemplateCacheMod.load(GetTAQry.FieldByName('TE_ID').AsInteger);
  if Assigned(m_tc) then
  begin
    m_style := m_tc.Styles.getStyle(GetTAQry.FieldByName('TA_STYLE').AsString);
    m_form  := m_tc.Task.getMainForm;
  end;

  GetTAQry.Close;

  Result := Assigned(m_tc);
end;

function TTaskLoaderMod.loadData(dataset: TClientDataset): boolean;
var
  st : TStream;
begin
  st := dataset.CreateBlobStream(dataset.FieldByName('TA_DATA'), bmRead);
  self.loadData(st);
  st.Free;

  Result := true;
end;

function TTaskLoaderMod.loadData(st: TStream): boolean;
var
  loader : TTaskForm2XML;
begin
  Result := false;
  if Assigned(st) and (st.Size > 0) then
  begin
    loader  := TTaskForm2XML.create;
    m_xList := loader.getXML(st);
    loader.Free;
    Result := Assigned(m_xList);
  end;
end;

function TTaskLoaderMod.saveDataToStream(st: TStream): boolean;
var
  writer : TTaskForm2XML;
begin
  if Assigned(m_form) and Assigned(st) then
  begin
    writer := TTaskForm2XML.create;
    writer.save(st, m_form);
    writer.Free;
  end;
  Result := Assigned(st) and ( st.Size > 0 );
end;

function TTaskLoaderMod.saveFormData: boolean;
var
  st      : TStream;
  writer  : TTaskForm2XML;

begin
  Result := false;
  if m_taid = -1 then
    exit;

  if Assigned(m_form) then
  begin
    TaskTab.Open;
    if TaskTab.Locate('TA_ID', VarArrayOf([m_taid]), []) then
    begin
      st := TaskTab.CreateBlobStream(TaskTab.FieldByName('TA_DATA'), bmWrite);

      writer := TTaskForm2XML.create;
      writer.save(st, m_form);
      writer.Free;
      st.free;
    end;
    TaskTab.Close;
  end;
end;

function TTaskLoaderMod.SysLoad(clid: string): boolean;
begin
  m_tc    := NIL;
  m_xList := NIL;
  m_tc    := TemplateCacheMod.SysLoad(clid);

  if Assigned(m_tc) then
    m_style  := m_tc.Styles.DefaultStyle;

  Result := Assigned(m_tc);
end;

end.
