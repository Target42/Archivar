unit m_WindowHandler;

interface

uses
  System.SysUtils, System.Classes, System.Generics.Collections, Vcl.Forms, f_taskEdit,
  f_protokoll, f_protokoll_view, f_storage;

type
  TWindowHandler = class(TDataModule)
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    m_taskMap     : TDictionary<integer,TTaskEditForm>;
    m_protocolMap : TDictionary<integer,TProtokollForm>;
    m_protoView   : TDictionary<integer,TProtokollViewForm>;
    m_storages    : TDictionary<integer, TStorageForm >;
    m_forms       : TList<TForm>;

  public
    procedure openTaskWindow( id, typeID : integer; ro : boolean; modal : boolean = false );
    procedure closeTaskWindow( id : integer );
    function isTaskOpen( id : integer ) : Boolean;
    procedure closeTaksWindowMsg( id : integer; text : string );

    procedure openProtoCclWindow( id : integer ; ro : Boolean );
    procedure closeProtoclWindow( id : integer );
    function isProtocolOpen( id : integer ) : boolean;
    procedure closeProtocolWindowMsg( id : integer;  text : string );

    procedure openProtocolView( id : integer );
    procedure closeProtoclView( id : integer );

    procedure openStorage( id : integer; caption : string );
    procedure closeStorage(id : integer );

    procedure closeAll;
    procedure registerForm( frm : TForm );
    procedure unregisterForm( frm : TForm );

  end;

var
  WindowHandler: TWindowHandler;

implementation

uses
  Vcl.Dialogs, u_json;

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TWindowHandler.closeTaskWindow(id: integer);
begin
  m_taskMap.Remove(id);
end;

procedure TWindowHandler.closeAll;
var
  arr : TArray<TForm>;
  i   : integer;
begin
  arr := m_forms.ToArray;
  for i := low(arr) to High(arr) do begin
    arr[i].Close;
    arr[i].Free;
  end;

  setLength(arr, 0);
end;

procedure TWindowHandler.closeProtoclView(id: integer);
begin
  m_protoView.Remove(id);
end;

procedure TWindowHandler.closeProtoclWindow(id: integer);
begin
  m_protocolMap.Remove(id);
end;

procedure TWindowHandler.closeProtocolWindowMsg(id: integer; text: string);
var
  frm : TProtokollForm;
begin
  if m_protocolMap.ContainsKey(id) then
  begin
    frm := m_protocolMap[id];
    frm.Close;
    ShowMessage(text);
  end;
end;

procedure TWindowHandler.closeStorage(id: integer);
begin
  m_storages.Remove(id);
end;

procedure TWindowHandler.closeTaksWindowMsg(id: integer; text: string);
var
  frm : TTaskEditForm;
begin
  if m_taskMap.ContainsKey(id) then
  begin
    frm := m_taskMap[id];
    frm.Close;
    ShowMessage( text );
  end;
end;

procedure TWindowHandler.DataModuleCreate(Sender: TObject);
begin
  m_taskMap     := TDictionary<integer,TTaskEditForm>.create;
  m_protocolMap := TDictionary<integer,TProtokollForm>.Create;
  m_protoView   := TDictionary<integer,TProtokollViewForm>.create;
  m_storages    := TDictionary<integer, TStorageForm >.create;
  m_forms       := TList<TForm>.create;
end;

procedure TWindowHandler.DataModuleDestroy(Sender: TObject);
begin
  m_taskMap.Free;
  m_protocolMap.Free;
  m_protoView.free;
  m_storages.free;
  m_forms.Free;
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
    frm.Show;
    m_protoView.AddOrSetValue( id, frm);
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
  end else begin
    frm := m_storages[id];
    frm.BringToFront;
    frm.WindowState := wsMaximized;
  end;
end;

procedure TWindowHandler.openTaskWindow(id, typeID: integer; ro : boolean ; modal : boolean);
var
  TaskEditForm : TTaskEditForm;
begin
  if modal then
  begin
      Application.CreateForm(TTaskEditForm, TaskEditForm);
      TaskEditForm.FormStyle := fsNormal;
      TaskEditForm.Hide;

      TaskEditForm.setID( id, typeID );
      TaskEditForm.RO := ro;
      TaskEditForm.LockCheck;
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
      m_taskMap.Add(id, TaskEditForm);

      TaskEditForm.setID( id, typeID );
    end;
    TaskEditForm.RO := ro;
    TaskEditForm.Show;
    TaskEditForm.LockCheck;
  end;
end;

procedure TWindowHandler.registerForm(frm: TForm);
begin
  if not m_forms.Contains(frm) then
    m_forms.Add(frm);

end;

procedure TWindowHandler.unregisterForm(frm: TForm);
begin
  m_forms.Remove(frm);
end;

end.
