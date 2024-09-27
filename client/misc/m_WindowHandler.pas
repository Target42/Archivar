unit m_WindowHandler;

interface

uses
  System.SysUtils, System.Generics.Collections, Vcl.Forms, f_taskEdit,
  f_protokoll, f_protokoll_view, f_storage, u_ForceClose, System.Classes,
  u_IWindowHandler;

type
  TWindowHandler = class(TDataModule, IWindowHandler)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_taskMap     : TDictionary<integer,TTaskEditForm>;
    m_protocolMap : TDictionary<integer,TProtokollForm>;
    m_protoView   : TDictionary<integer,TProtokollViewForm>;
    m_storages    : TDictionary<integer, TStorageForm >;
    m_forms       : TList<TForm>;

    m_list        : TList<IForceClose>;

  public
    procedure openTaskWindow( id, typeID, grid : integer; ro : boolean; modal : boolean = false );
    procedure closeTaskWindow( id : integer );
    function  isTaskOpen( id : integer ) : Boolean;
    procedure closeTaksWindowMsg( id : integer; text : string );

    procedure openProtoCclWindow( id : integer ; ro : Boolean );
    procedure closeProtoclWindow( id : integer );
    function isProtocolOpen( id : integer ) : boolean;
    procedure closeProtocolWindowMsg( id : integer;  text : string );

    procedure openProtocolView( id : integer );
    procedure closeProtoclView( id : integer );

    procedure openStorage( id : integer; caption : string );
    procedure closeStorage(id : integer );

    procedure registerForm( frm : TForm );
    procedure unregisterForm( frm : TForm );

    procedure closeAll;
  end;

var
  WindowHandler: TWindowHandler;

implementation

uses
  Vcl.Dialogs, u_json, m_glob_client, u_berTypes, System.UITypes;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWindowHandler.closeTaskWindow(id: integer);
var
  frm : TTaskEditForm;
begin
  if m_taskMap.TryGetValue(id, frm) then
    m_list.Remove(frm);

  m_taskMap.Remove(id);
end;

procedure TWindowHandler.closeAll;
var
  i   : integer;
  arr : TArray<IForceClose>;
begin
  for i := pred(m_forms.Count) downto 0 do begin

    if Supports( m_forms[i], IForceClose) then
      m_list.Remove(m_forms[i] as IForceClose);

    try
      m_forms[i].Close;
      m_forms[i].Free;
    except

    end;
  end;
  m_forms.Clear;
  Application.ProcessMessages;

  arr := m_list.ToArray;
  m_list.Clear;

  for i := low(arr) to high(arr) do
    arr[i].ForceClose(true);
  SetLength(arr, 0);

  Application.ProcessMessages;
end;

procedure TWindowHandler.closeProtoclView(id: integer);
var
  frm : TProtokollViewForm;
begin
  if m_protoView.TryGetValue(id, frm) then
    m_list.Remove(frm);

  m_protoView.Remove(id);
end;

procedure TWindowHandler.closeProtoclWindow(id: integer);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.TryGetValue(id, frm) then
    m_list.Remove(frm);

  m_protocolMap.Remove(id);
end;

procedure TWindowHandler.closeProtocolWindowMsg(id: integer; text: string);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.TryGetValue(id, frm) then
  begin
    m_list.Remove(frm);
    frm.Close;
    ShowMessage(text);
  end;
end;

procedure TWindowHandler.closeStorage(id: integer);
var
  frm : TStorageForm;
begin
  if m_storages.TryGetValue(id, frm) then
    m_list.Remove(frm);

  m_storages.Remove(id);
end;

procedure TWindowHandler.closeTaksWindowMsg(id: integer; text: string);
var
  frm : TTaskEditForm;
begin
  if m_taskMap.TryGetValue(id, frm) then
  begin
    m_list.Remove(frm);
    frm.Close;
    ShowMessage( text );
  end;
end;

procedure TWindowHandler.DataModuleCreate(Sender: TObject);
begin
  m_taskMap     := TDictionary<integer,TTaskEditForm>.create;
  m_protocolMap := TDictionary<integer,TProtokollForm>.Create;
  m_protoView   := TDictionary<integer,TProtokollViewForm>.create;
  m_storages    := TDictionary<integer,TStorageForm >.create;
  m_forms       := TList<TForm>.create;
  m_list        := TList<IForceClose>.create;
end;

procedure TWindowHandler.DataModuleDestroy(Sender: TObject);
begin
  m_taskMap.Free;
  m_protocolMap.Free;
  m_protoView.free;
  m_storages.free;
  m_forms.Free;
  m_list.free;
end;

function TWindowHandler.isProtocolOpen(id: integer): boolean;
begin
  Result := m_protocolMap.ContainsKey(id);
end;

function TWindowHandler.isTaskOpen(id: integer): Boolean;
begin
  Result := m_taskMap.ContainsKey(id);
end;

procedure TWindowHandler.openProtoCclWindow(id: integer; ro: Boolean);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.ContainsKey(id) then
  begin
    frm := m_protocolMap[id];
    frm.BringToFront;
    frm.WindowState := wsMaximized;
  end
  else
  begin
    Application.CreateForm(TProtokollForm, frm);
    frm.ID := id;
    frm.Show;

    m_protocolMap.AddOrSetValue(id, frm);
    m_list.Add(frm);
  end;
  frm.RO := ro;
  frm.Show;
end;

procedure TWindowHandler.openProtocolView(id: integer);
var
  frm : TProtokollViewForm;
begin
  if m_protoView.ContainsKey(id) then
  begin
    frm := m_protoView[id];
    frm.BringToFront;
    frm.WindowState := wsMaximized;
  end
  else
  begin
    Application.CreateForm(TProtokollViewForm, frm);
    frm.ID := id;
    m_protoView.AddOrSetValue( id, frm);
    m_list.Add(frm);
  end;
  frm.Show;
end;

procedure TWindowHandler.openStorage(id: integer; caption: string);
var
  frm : TStorageForm;
begin
  if id = -1 then begin
    ShowMessage(Format('Ungültige Ablage ID : %d', [id]));
    exit;
  end;

  if not m_storages.ContainsKey(id) then begin
    Application.CreateForm(TStorageForm, frm);
    frm.Header := caption;
    frm.DirID  := id;
    frm.Show;
    m_storages.AddOrSetValue(id, frm);
    m_list.Add(frm);
  end else begin
    frm := m_storages[id];
    frm.BringToFront;
    frm.WindowState := wsMaximized;
  end;
end;

procedure TWindowHandler.openTaskWindow(id, typeID, grid: integer; ro : boolean ; modal : boolean);
var
  TaskEditForm : TTaskEditForm;
begin
  Screen.Cursor := crHourGlass;
  if modal then
  begin
      Application.CreateForm(TTaskEditForm, TaskEditForm);
      TaskEditForm.FormStyle := fsNormal;
      TaskEditForm.Hide;

      TaskEditForm.setID( id, typeID );
      TaskEditForm.RO := ro;
      TaskEditForm.LockCheck;
      TaskEditForm.GremiumID := grid;
      TaskEditForm.resizeForm;
      TaskEditForm.ShowModal;
      TaskEditForm.Free;
  end
  else begin
    if m_taskMap.ContainsKey(id) then
    begin
      TaskEditForm := m_taskMap[id];
      TaskEditForm.BringToFront;
      TaskEditForm.WindowState := wsMaximized;
    end
    else
    begin
      Application.CreateForm(TTaskEditForm, TaskEditForm);
      TaskEditForm.setID( id, typeID );
      TaskEditForm.GremiumID := grid;

      if TaskEditForm.WindowState <> TWindowState.wsMaximized then
        TaskEditForm.resizeForm;

      m_taskMap.Add(id, TaskEditForm);
      m_list.Add(TaskEditForm);
    end;

    TaskEditForm.RO := ro;
    TaskEditForm.Show;

    if not ro then begin
      GM.LockDocument( id, integer(ltTask));
      if Gm.LockedFlag (id,integer(ltTask))  then
        TaskEditForm.edit;
    end;
  end;
  Screen.Cursor := crDefault;
end;

procedure TWindowHandler.registerForm(frm: TForm);
begin
  if not m_forms.Contains(frm) then
    m_forms.Add(frm);

  if Supports( frm, IForceClose) then
    m_list.Add(frm as IForceClose);

end;

procedure TWindowHandler.unregisterForm(frm: TForm);
begin
  m_forms.Remove(frm);

  if Supports( frm, IForceClose) then
    m_list.Remove(frm as IForceClose);
end;

end.
